// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

//
// Purpose:
// - GC shadow-stack lowering inserts the same stack-pointer restoration before
//   each early return.
// - After the regular function optimizations, this pass lets two or more guard
//   returns branch to a single restoration at the function exit.
//
// Source (TS) intent:
//   if (cond) return;
//   useValue();
//
// WAT (before):
//   if
//     call $__increase_sp
//     return
//   end
//   call $__increase_sp
//
// WAT (after):
//   block $return
//     br_if $return
//   end
//   call $__increase_sp
//

#include <cstddef>
#include <fmt/format.h>
#include <memory>
#include <optional>
#include <vector>

#include "ConditionalReturn.hpp"
#include "GC/GCInfo.hpp"
#include "fmt/base.h"
#include "ir/branch-utils.h"
#include "ir/effects.h"
#include "ir/names.h"
#include "ir/utils.h"
#include "support/name.h"
#include "warpo/support/Debug.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "ConditionalReturn"

namespace warpo::passes {
namespace {

wasm::Expression *unwrapSingletonBlocks(wasm::Expression *expr) {
  while (auto *const block = expr->dynCast<wasm::Block>()) {
    if (block->list.size() != 1)
      break;
    expr = block->list.front();
  }
  return expr;
}

bool isStackPointerIncreaseFunction(wasm::Module *m, wasm::Call const *call) {
  if (call->operands.size() != 1)
    return false;
  wasm::Function *const callee = m->getFunctionOrNull(call->target);
  if (callee == nullptr || callee->imported() || callee->body == nullptr)
    return false;

  auto *const globalSet = unwrapSingletonBlocks(callee->body)->dynCast<wasm::GlobalSet>();
  if (globalSet == nullptr || globalSet->name != gc::VarStackPointer)
    return false;
  auto *const add = globalSet->value->dynCast<wasm::Binary>();
  if (add == nullptr || add->op != wasm::BinaryOp::AddInt32)
    return false;
  auto *const stackPointer = add->left->dynCast<wasm::GlobalGet>();
  auto *const amount = add->right->dynCast<wasm::LocalGet>();
  return stackPointer != nullptr && stackPointer->name == gc::VarStackPointer && amount != nullptr &&
         amount->index == 0;
}

struct TailEpilogue {
  wasm::Block *body;
  wasm::Call *call;
  wasm::Expression *result;
};

std::optional<TailEpilogue> findTailEpilogue(wasm::Module *m, wasm::Function *func, wasm::PassOptions const &options) {
  auto *const body = func->body->dynCast<wasm::Block>();
  if (body == nullptr)
    return std::nullopt;

  wasm::Type const resultType = func->getResults();
  std::size_t const resultCount = resultType == wasm::Type::none ? 0U : 1U;
  if (body->list.size() <= resultCount)
    return std::nullopt;
  std::size_t const callIndex = body->list.size() - resultCount - 1U;
  auto *const call = body->list[callIndex]->dynCast<wasm::Call>();
  if (call == nullptr || !isStackPointerIncreaseFunction(m, call))
    return std::nullopt;

  wasm::Expression *const result = resultCount == 0 ? nullptr : body->list.back();
  if (result != nullptr && !wasm::EffectAnalyzer::canReorder(options, *m, call, result))
    return std::nullopt;
  return TailEpilogue{body, call, result};
}

wasm::Block *getMatchingEpilogueReturnBlock(wasm::Expression *expr, wasm::Expression *epilogue, wasm::Module *m,
                                            wasm::PassOptions const &options) {
  auto *const block = expr->dynCast<wasm::Block>();
  if (block == nullptr || block->list.size() < 2)
    return nullptr;
  auto *const returnExpr = block->list.back()->dynCast<wasm::Return>();
  wasm::Expression *const candidateEpilogue = block->list[block->list.size() - 2U];
  if (returnExpr == nullptr || !wasm::ExpressionAnalyzer::equal(candidateEpilogue, epilogue))
    return nullptr;
  if (returnExpr->value != nullptr &&
      !wasm::EffectAnalyzer::canReorder(options, *m, candidateEpilogue, returnExpr->value))
    return nullptr;
  return block;
}

struct GuardScanner : public wasm::PostWalker<GuardScanner> {
  wasm::Expression *const epilogue_;
  wasm::Module *const module_;
  wasm::PassOptions const &options_;
  std::vector<wasm::Block *> guards_;

  GuardScanner(wasm::Expression *epilogue, wasm::Module *module, wasm::PassOptions const &options)
      : epilogue_(epilogue), module_(module), options_(options) {}

  void visitIf(wasm::If *expr) {
    if (expr->ifFalse == nullptr) {
      if (auto *const block = getMatchingEpilogueReturnBlock(expr->ifTrue, epilogue_, module_, options_))
        guards_.push_back(block);
    }
  }
};

struct EpilogueReturnReplacer : public wasm::PostWalker<EpilogueReturnReplacer> {
  wasm::Expression *const epilogue_;
  wasm::Name const targetName_;
  wasm::Module *const module_;
  wasm::PassOptions const &options_;

  EpilogueReturnReplacer(wasm::Expression *epilogue, wasm::Name const targetName, wasm::Module *module,
                         wasm::PassOptions const &options)
      : epilogue_(epilogue), targetName_(targetName), module_(module), options_(options) {}

  void visitBlock(wasm::Block *expr) {
    if (getMatchingEpilogueReturnBlock(expr, epilogue_, module_, options_) == nullptr)
      return;
    auto *const returnExpr = expr->list.back()->cast<wasm::Return>();
    wasm::Builder b{*getModule()};
    expr->list.erase(expr->list.end() - 2U);
    expr->list.back() = b.makeBreak(targetName_, returnExpr->value);
    expr->finalize();
  }
};

wasm::Name getBlockName(std::string_view funcName) { return fmt::format("~CONDITION_RETURN/{}", funcName); }

wasm::Name getValidBlockName(wasm::Function *func) {
  wasm::BranchUtils::NameSet const names = wasm::BranchUtils::getBranchTargets(func->body);
  return wasm::Names::getValidName(getBlockName(func->name.view()),
                                   [&](wasm::Name const name) { return !names.contains(name); });
}

void optimizeConditionalReturns(wasm::Module *m, wasm::Function *func, wasm::PassOptions const &options) {
  std::optional<TailEpilogue> const tailEpilogue = findTailEpilogue(m, func, options);
  if (!tailEpilogue)
    return;

  GuardScanner scanner{tailEpilogue->call, m, options};
  scanner.walk(func->body);

  if (scanner.guards_.size() < 2)
    return;

  wasm::Type const resultType = func->getResults();
  if (support::isDebug(PASS_NAME, func->name.view())) {
    fmt::println("[" PASS_NAME "] fn '{}' has {} (if (cond) (return)) patterns which can be converted to branches",
                 func->name.view(), scanner.guards_.size());
  }
  wasm::Builder b{*m};
  wasm::Name const targetName = getValidBlockName(func);

  EpilogueReturnReplacer returnReplacer{tailEpilogue->call, targetName, m, options};
  returnReplacer.walkFunctionInModule(func, m);

  if (tailEpilogue->result != nullptr)
    tailEpilogue->body->list.pop_back();
  tailEpilogue->body->list.pop_back();
  if (tailEpilogue->result != nullptr)
    tailEpilogue->body->list.push_back(tailEpilogue->result);
  tailEpilogue->body->finalize(resultType);
  wasm::Block *const sharedBody = b.makeBlock(targetName, {func->body}, resultType);
  if (resultType == wasm::Type::none) {
    func->body = b.makeBlock({sharedBody, tailEpilogue->call}, resultType);
  } else {
    wasm::Index const resultLocal = wasm::Builder::addVar(func, resultType);
    func->body = b.makeBlock(
        {b.makeLocalSet(resultLocal, sharedBody), tailEpilogue->call, b.makeLocalGet(resultLocal, resultType)},
        resultType);
  }
}

struct ConditionalReturn final : wasm::Pass {
  ConditionalReturn() { name = PASS_NAME; }

  void run(wasm::Module *m) override {
    for (auto &func : m->functions) {
      if (!func->imported())
        optimizeConditionalReturns(m, func.get(), getPassOptions());
    }
  }
};

} // namespace

wasm::Pass *createConditionalReturnPass() { return new ConditionalReturn(); }

void optimizeConditionalReturns(wasm::Module *m, wasm::Function *func) {
  optimizeConditionalReturns(m, func, wasm::PassOptions{});
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "pass.h"

namespace warpo::passes::ut {

namespace {

std::unique_ptr<wasm::Module> loadWithStackPointer(std::string_view function) {
  return loadWat(fmt::format(R"(
    (module
      (global ${0} (mut i32) (i32.const 1024))
      (func $increase_sp (param i32)
        global.get ${0}
        local.get 0
        i32.add
        global.set ${0}
      )
      {1}
    )
  )",
                             gc::VarStackPointer, function));
}

struct ResultCounter : wasm::PostWalker<ResultCounter> {
  wasm::Name const target_;
  std::size_t calls_ = 0;
  std::size_t branches_ = 0;
  std::size_t valuedBranches_ = 0;

  explicit ResultCounter(wasm::Name const target) : target_(target) {}

  void visitCall(wasm::Call *expr) {
    if (expr->target == "increase_sp")
      ++calls_;
  }

  void visitBreak(wasm::Break *expr) {
    if (expr->name != target_)
      return;
    ++branches_;
    if (expr->value != nullptr)
      ++valuedBranches_;
  }
};

ResultCounter countResults(wasm::Function *func) {
  ResultCounter result{getBlockName(func->name.view())};
  result.walk(func->body);
  return result;
}

} // namespace

TEST(ConditionalReturnTest, ReturnsWithoutStackRestoreAreSkipped) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32 i32)
        local.get 0
        if
          return
        end
        local.get 1
        if
          return
        end
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");
  wasm::Expression *const body = func->body;

  optimizeConditionalReturns(m.get(), func);

  EXPECT_EQ(func->body, body);
}

TEST(ConditionalReturnTest, SingleGuardWithStackRestoreIsSkipped) {
  auto m = loadWithStackPointer(R"(
    (func $main (param i32)
      local.get 0
      if
        i32.const 4
        call $increase_sp
        return
      end
      i32.const 4
      call $increase_sp
    )
  )");
  wasm::Function *const func = m->getFunction("main");
  wasm::Expression *const body = func->body;

  optimizeConditionalReturns(m.get(), func);

  EXPECT_EQ(func->body, body);
  EXPECT_EQ(countResults(func).calls_, 2U);
}

TEST(ConditionalReturnTest, MultipleVoidGuardsShareStackRestore) {
  auto m = loadWithStackPointer(R"(
      (func $main (param i32 i32)
        local.get 0
        if
          i32.const 4
          call $increase_sp
          return
        end
        local.get 1
        if
          i32.const 4
          call $increase_sp
          return
        end
        i32.const 4
        call $increase_sp
      )
  )");
  wasm::Function *const func = m->getFunction("main");

  optimizeConditionalReturns(m.get(), func);

  ResultCounter const result = countResults(func);
  EXPECT_EQ(result.calls_, 1U);
  EXPECT_EQ(result.branches_, 2U);
  EXPECT_EQ(result.valuedBranches_, 0U);
}

TEST(ConditionalReturnTest, NestedGuardsShareStackRestore) {
  auto m = loadWithStackPointer(R"(
      (func $main (param i32 i32 i32)
        local.get 0
        if
          local.get 1
          if
            i32.const 4
            call $increase_sp
            return
          end
        else
          local.get 2
          if
            i32.const 4
            call $increase_sp
            return
          end
        end
        i32.const 4
        call $increase_sp
      )
  )");
  wasm::Function *const func = m->getFunction("main");

  optimizeConditionalReturns(m.get(), func);

  ResultCounter const result = countResults(func);
  EXPECT_EQ(result.calls_, 1U);
  EXPECT_EQ(result.branches_, 2U);
}

TEST(ConditionalReturnTest, AllMatchingReturnsShareStackRestore) {
  auto m = loadWithStackPointer(R"(
      (func $main (param i32 i32 i32)
        local.get 0
        if
          i32.const 4
          call $increase_sp
          return
        end
        local.get 1
        if
          i32.const 4
          call $increase_sp
          return
        end
        block
          i32.const 4
          call $increase_sp
          return
        end
        i32.const 4
        call $increase_sp
      )
  )");
  wasm::Function *const func = m->getFunction("main");

  optimizeConditionalReturns(m.get(), func);

  ResultCounter const result = countResults(func);
  EXPECT_EQ(result.calls_, 1U);
  EXPECT_EQ(result.branches_, 3U);
}

TEST(ConditionalReturnTest, MismatchedStackRestoreIsSkipped) {
  auto m = loadWithStackPointer(R"(
      (func $main (param i32 i32)
        local.get 0
        if
          i32.const 4
          call $increase_sp
          return
        end
        local.get 1
        if
          i32.const 8
          call $increase_sp
          return
        end
        i32.const 4
        call $increase_sp
      )
  )");
  wasm::Function *const func = m->getFunction("main");
  wasm::Expression *const body = func->body;

  optimizeConditionalReturns(m.get(), func);

  EXPECT_EQ(func->body, body);
  EXPECT_EQ(countResults(func).calls_, 3U);
}

TEST(ConditionalReturnTest, MultipleNonVoidGuardsShareStackRestore) {
  auto m = loadWithStackPointer(R"(
      (func $main (param i32 i32) (result i32)
        local.get 0
        if
          i32.const 4
          call $increase_sp
          i32.const 42
          return
        end
        local.get 1
        if
          i32.const 4
          call $increase_sp
          i32.const 24
          return
        end
        i32.const 4
        call $increase_sp
        i32.const 10
      )
  )");
  wasm::Function *const func = m->getFunction("main");

  optimizeConditionalReturns(m.get(), func);

  ResultCounter const result = countResults(func);
  EXPECT_EQ(func->body->type, wasm::Type::i32);
  EXPECT_EQ(result.calls_, 1U);
  EXPECT_EQ(result.branches_, 2U);
  EXPECT_EQ(result.valuedBranches_, 2U);
}

} // namespace warpo::passes::ut

#endif