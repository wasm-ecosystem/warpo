// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <cassert>
#include <fmt/format.h>
#include <ir/manipulation.h>
#include <ir/names.h>
#include <ir/utils.h>
#include <memory>
#include <mutex>
#include <pass.h>
#include <string>
#include <string_view>
#include <support/index.h>
#include <unordered_map>
#include <utility>
#include <vector>
#include <wasm-builder.h>
#include <wasm-traversal.h>
#include <wasm-type.h>
#include <wasm.h>

#include "ConstructorNewOutlining.hpp"
#include "helper/CFG.hpp"
#include "warpo/support/Debug.hpp"

#define PASS_NAME "ConstructorNewOutlining"

namespace warpo::passes {
namespace {

inline bool endsWith(std::string_view value, std::string_view suffix) noexcept {
  return value.size() >= suffix.size() && value.substr(value.size() - suffix.size()) == suffix;
}

inline bool isConstructorName(wasm::Name const &name) noexcept { return endsWith(name.view(), "#constructor"); }

inline bool isRuntimeNewName(wasm::Name const &name) noexcept {
  std::string_view const view = name.view();
  return view == "~lib/rt/itcms/__new" || view == "~lib/rt/tcms/__new";
}

inline bool isTmpToStackName(wasm::Name const &name) noexcept { return name.view() == "~lib/rt/__tmptostack"; }

inline wasm::Call *asRuntimeNew(wasm::Expression *expr) noexcept {
  wasm::Call *const call = expr->dynCast<wasm::Call>();
  if ((call == nullptr) || !isRuntimeNewName(call->target) || call->operands.size() != 2)
    return nullptr;
  return call;
}

inline wasm::Call *getAllocationCall(wasm::Expression *expr) noexcept {
  wasm::Call *const wrapper = expr->dynCast<wasm::Call>();
  if ((wrapper == nullptr) || !isTmpToStackName(wrapper->target))
    return nullptr;
  assert(wrapper->operands.size() == 1);
  return asRuntimeNew(wrapper->operands[0]);
}

struct Match {
  wasm::Call *call = nullptr;
  wasm::Expression *allocationOperand = nullptr;
};

using CandidateMap = std::unordered_map<wasm::Name, std::vector<Match>>;
using ReplacementMap = std::unordered_map<wasm::Call *, wasm::Name>;

std::vector<wasm::Type> getHelperParameterTypes(wasm::Function *function) {
  std::vector<wasm::Type> parameterTypes;
  wasm::Signature const sig = function->type.getHeapType().getSignature();
  if (sig.params.size() <= 1)
    return parameterTypes;

  parameterTypes.reserve(sig.params.size() - 1);
  for (wasm::Index i = 1; i < sig.params.size(); i++) {
    parameterTypes.push_back(sig.params[i]);
  }
  return parameterTypes;
}

class Scanner : public wasm::WalkerPass<wasm::PostWalker<Scanner>> {
public:
  Scanner(CandidateMap &candidates, std::mutex &candidateMutex)
      : candidates(candidates), candidateMutex(candidateMutex) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<Scanner>(candidates, candidateMutex); }

  void doWalkFunction(wasm::Function *function) {
    if (function->body == nullptr)
      return;

    CFG const cfg = CFG::fromFunction(function);
    DynBitset const insideLoop = cfg.getBlockInsideLoop();
    for (BasicBlock const &bb : cfg) {
      if (insideLoop.get(bb.getIndex()))
        continue;
      for (wasm::Expression *const expr : bb) {
        wasm::Call *const call = expr->dynCast<wasm::Call>();
        if (call != nullptr)
          collectCandidate(call);
      }
    }
  }

private:
  void collectCandidate(wasm::Call *call) {
    if (!isConstructorName(call->target) || call->operands.empty())
      return;

    wasm::Expression *const allocationOperand = call->operands[0];
    if (getAllocationCall(allocationOperand) == nullptr)
      return;

    Match const match{.call = call, .allocationOperand = allocationOperand};
    std::lock_guard<std::mutex> const lock{candidateMutex};
    auto [candidate, inserted] = candidates.try_emplace(call->target);
    candidate->second.push_back(match);
  }

  CandidateMap &candidates;
  std::mutex &candidateMutex;
};

class Replacer : public wasm::WalkerPass<wasm::PostWalker<Replacer>> {
public:
  explicit Replacer(ReplacementMap const &replacements) : replacements(replacements) {}

  void visitCall(wasm::Call *call) {
    auto const replacement = replacements.find(call);
    if (replacement == replacements.end())
      return;

    wasm::Builder builder{*getModule()};
    std::vector<wasm::Expression *> operands;
    operands.reserve(call->operands.size() - 1);
    for (wasm::Index i = 1; i < call->operands.size(); i++) {
      operands.push_back(call->operands[i]);
    }
    replaceCurrent(builder.makeCall(replacement->second, operands, call->type));
  }

private:
  ReplacementMap const &replacements;
};

wasm::Type makeTupleType(std::vector<wasm::Type> const &types) {
  if (types.empty())
    return wasm::Type::none;
  return wasm::Type(types);
}

wasm::Type makeFunctionType(std::vector<wasm::Type> const &parameterTypes, wasm::Type resultType) {
  return wasm::Type(wasm::Signature(makeTupleType(parameterTypes), resultType), wasm::NonNullable, wasm::Exact);
}

wasm::Expression *makeHelperBody(wasm::Module &m, wasm::Name const constructorName, Match const &representative) {
  wasm::Builder builder{m};
  wasm::Function &constructor = *m.getFunction(constructorName);
  std::vector<wasm::Type> const parameterTypes = getHelperParameterTypes(&constructor);
  wasm::Signature const sig = constructor.type.getHeapType().getSignature();
  std::vector<wasm::Expression *> operands;
  operands.reserve(parameterTypes.size() + 1);
  operands.push_back(wasm::ExpressionManipulator::copy(representative.allocationOperand, m));
  for (wasm::Index i = 0; i < parameterTypes.size(); i++) {
    operands.push_back(builder.makeLocalGet(i, parameterTypes[i]));
  }
  return builder.makeCall(constructorName, operands, sig.results);
}

wasm::Name addHelperFunction(wasm::Module &m, wasm::Name const constructorName, std::vector<Match> const &matches) {
  Match const &representative = matches.front();
  wasm::Function &constructor = *m.getFunction(constructorName);
  std::vector<wasm::Type> const parameterTypes = getHelperParameterTypes(&constructor);
  wasm::Signature const sig = constructor.type.getHeapType().getSignature();
  wasm::Name const helperName = wasm::Names::getValidFunctionName(m, fmt::format("{}@new", constructorName.view()));
  auto function = wasm::Builder::makeFunction(helperName, makeFunctionType(parameterTypes, sig.results), {},
                                              makeHelperBody(m, constructorName, representative));
  m.addFunction(std::move(function));

  if (support::isDebug(PASS_NAME)) {
    fmt::println("[" PASS_NAME "] outline '{}' as '{}' ({} uses)", constructorName.view(), helperName.view(),
                 matches.size());
  }
  return helperName;
}

void addReplacements(ReplacementMap &replacements, wasm::Name const helperName, std::vector<Match> const &matches) {
  for (Match const &match : matches) {
    replacements.try_emplace(match.call, helperName);
  }
}

// Reduce code size by outlining the same constructor allocation pattern when
// it appears multiple times in a module. The pass replaces repeated object
// allocations for the same constructor with one shared helper. Candidates in
// loops are skipped to avoid adding helper-call overhead on hot paths.
//
// Example:
//   input, repeated several times for the same object type:
//     (call $A#constructor
//       (call $~lib/rt/__tmptostack
//         (call $~lib/rt/itcms/__new ...))
//       (i32.const 7))
//   output:
//     (func $A#constructor@new (param ...constructor args...)
//       (call $A#constructor
//         (call $~lib/rt/__tmptostack
//           (call $~lib/rt/itcms/__new ...))
//         (local.get ...constructor args...)))
//     (call $A#constructor@new ...)
struct ConstructorNewOutlining : public wasm::Pass {
  bool modifiesBinaryenIR() override { return true; }

  void run(wasm::Module *m) override {
    CandidateMap candidates;
    std::mutex candidateMutex;
    {
      wasm::PassRunner runner{getPassRunner()};
      runner.add(std::make_unique<Scanner>(candidates, candidateMutex));
      runner.run();
    }

    ReplacementMap replacements;
    std::vector<CandidateMap::const_iterator> orderedCandidates;
    orderedCandidates.reserve(candidates.size());
    for (auto const &function : m->functions) {
      auto const candidate = candidates.find(function->name);
      if (candidate == candidates.end())
        continue;
      orderedCandidates.push_back(candidate);
    }

    for (auto const candidate : orderedCandidates) {
      auto const &[constructorName, matches] = *candidate;
      if (matches.size() < 2)
        continue;
      wasm::Name const helperName = addHelperFunction(*m, constructorName, matches);
      addReplacements(replacements, helperName, matches);
    }

    if (!replacements.empty()) {
      wasm::PassRunner runner{getPassRunner()};
      runner.add(std::make_unique<Replacer>(replacements));
      runner.run();
      m->updateMaps();
    }
  }
};

} // namespace
} // namespace warpo::passes

wasm::Pass *warpo::passes::createConstructorNewOutliningPass() { return new ConstructorNewOutlining(); }

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "pass.h"

namespace warpo::passes::ut {
namespace {

struct CallTargetCounter : public wasm::PostWalker<CallTargetCounter> {
  explicit CallTargetCounter(wasm::Name target) : target(std::move(target)) {}

  void visitCall(wasm::Call *call) {
    if (call->target == target)
      count++;
  }

  wasm::Name target;
  size_t count = 0U;
};

size_t countCallsTo(wasm::Function *function, wasm::Name target) {
  CallTargetCounter counter{std::move(target)};
  counter.walk(function->body);
  return counter.count;
}

} // namespace

TEST(ConstructorNewOutliningTest, OutlinesRepeatedConstructorAllocation) {
  auto m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (func $~lib/rt/itcms/__new (param i32 i32) (result i32)
        (i32.const 1)
      )
      (func $A#constructor (param i32) (result i32)
        (local.get 0)
      )
      (func $one (result i32)
        (call $A#constructor
          (call $~lib/rt/__tmptostack
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 4)
            )
          )
        )
      )
      (func $two (result i32)
        (call $A#constructor
          (call $~lib/rt/__tmptostack
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 4)
            )
          )
        )
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{warpo::passes::createConstructorNewOutliningPass()});
  runner.run();

  ASSERT_NE(m->getFunctionOrNull("A#constructor@new"), nullptr);
  auto *const one = m->getFunction("one");
  auto *const two = m->getFunction("two");
  auto *const oneCall = one->body->dynCast<wasm::Call>();
  auto *const twoCall = two->body->dynCast<wasm::Call>();
  ASSERT_NE(oneCall, nullptr);
  ASSERT_NE(twoCall, nullptr);
  EXPECT_EQ(oneCall->target, wasm::Name("A#constructor@new"));
  EXPECT_EQ(twoCall->target, wasm::Name("A#constructor@new"));
}

TEST(ConstructorNewOutliningTest, DoesNotOutlineSingleUse) {
  auto m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (func $~lib/rt/itcms/__new (param i32 i32) (result i32)
        (i32.const 1)
      )
      (func $A#constructor (param i32) (result i32)
        (local.get 0)
      )
      (func $one (result i32)
        (call $A#constructor
          (call $~lib/rt/__tmptostack
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 4)
            )
          )
        )
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{warpo::passes::createConstructorNewOutliningPass()});
  runner.run();

  EXPECT_EQ(m->getFunctionOrNull("A#constructor@new"), nullptr);
}

TEST(ConstructorNewOutliningTest, UsesConstructorSignatureForHelperParameters) {
  auto m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (func $~lib/rt/itcms/__new (param i32 i32) (result i32)
        (i32.const 1)
      )
      (func $A#constructor (param i32 i32) (result i32)
        (local.get 0)
      )
      (func $both (result i32)
        (block (result i32)
          (drop
            (call $A#constructor
              (call $~lib/rt/__tmptostack
                (call $~lib/rt/itcms/__new
                  (i32.const 16)
                  (i32.const 4)
                )
              )
              (i32.const 8)
            )
          )
          (call $A#constructor
            (call $~lib/rt/__tmptostack
              (call $~lib/rt/itcms/__new
                (i32.const 16)
                (i32.const 4)
              )
            )
            (i32.const 7)
          )
        )
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{warpo::passes::createConstructorNewOutliningPass()});
  runner.run();

  auto *const helper = m->getFunction("A#constructor@new");
  ASSERT_NE(helper, nullptr);
  EXPECT_EQ(helper->getParams().size(), 1U);
  EXPECT_EQ(helper->getParams()[0], wasm::Type::i32);
  EXPECT_EQ(helper->getResults(), wasm::Type::i32);
}

TEST(ConstructorNewOutliningTest, OutlinesNonLoopCallsButKeepsLoopCalls) {
  auto m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (func $~lib/rt/itcms/__new (param i32 i32) (result i32)
        (i32.const 1)
      )
      (func $A#constructor (param i32) (result i32)
        (local.get 0)
      )
      (func $one (result i32)
        (call $A#constructor
          (call $~lib/rt/__tmptostack
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 4)
            )
          )
        )
      )
      (func $two (result i32)
        (call $A#constructor
          (call $~lib/rt/__tmptostack
            (call $~lib/rt/itcms/__new
              (i32.const 16)
              (i32.const 4)
            )
          )
        )
      )
      (func $looped (result i32)
        (loop $again
          (drop
            (call $A#constructor
              (call $~lib/rt/__tmptostack
                (call $~lib/rt/itcms/__new
                  (i32.const 16)
                  (i32.const 4)
                )
              )
            )
          )
          (br_if $again
            (i32.const 0)
          )
        )
        (i32.const 0)
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{warpo::passes::createConstructorNewOutliningPass()});
  runner.run();

  ASSERT_NE(m->getFunctionOrNull("A#constructor@new"), nullptr);

  auto *const one = m->getFunction("one");
  auto *const two = m->getFunction("two");
  auto *const oneCall = one->body->dynCast<wasm::Call>();
  auto *const twoCall = two->body->dynCast<wasm::Call>();
  ASSERT_NE(oneCall, nullptr);
  ASSERT_NE(twoCall, nullptr);
  EXPECT_EQ(oneCall->target, wasm::Name("A#constructor@new"));
  EXPECT_EQ(twoCall->target, wasm::Name("A#constructor@new"));

  auto *const looped = m->getFunction("looped");
  EXPECT_EQ(countCallsTo(looped, "A#constructor@new"), 0U);
  EXPECT_EQ(countCallsTo(looped, "A#constructor"), 1U);
}

TEST(ConstructorNewOutliningTest, DoesNotMatchUserFunctionsBySuffix) {
  auto m = loadWat(R"(
    (module
      (func $user/abc__new (param i32 i32) (result i32)
        (i32.const 1)
      )
      (func $user/abc__tmptostack (param i32) (result i32)
        (local.get 0)
      )
      (func $A#constructor (param i32) (result i32)
        (local.get 0)
      )
      (func $one (result i32)
        (call $A#constructor
          (call $user/abc__tmptostack
            (call $user/abc__new
              (i32.const 16)
              (i32.const 4)
            )
          )
        )
      )
      (func $two (result i32)
        (call $A#constructor
          (call $user/abc__tmptostack
            (call $user/abc__new
              (i32.const 16)
              (i32.const 4)
            )
          )
        )
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{warpo::passes::createConstructorNewOutliningPass()});
  runner.run();

  EXPECT_EQ(m->getFunctionOrNull("A#constructor@new"), nullptr);
}

} // namespace warpo::passes::ut

#endif
