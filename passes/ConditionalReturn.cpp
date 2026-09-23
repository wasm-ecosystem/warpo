// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

//
// Purpose:
// - Before GC epilogue insertion, this pass lets two or more guard returns
//   branch to a single function-level exit block.
//
// Source (TS) intent:
//   if (cond) return;
//   useValue();
//
// WAT (before):
//   if
//     return
//   end
//   if
//     return
//   end
//
// WAT (after):
//   block $return
//     br_if $return ;; first condition
//     br_if $return ;; second condition
//   end
//

#include <fmt/format.h>
#include <memory>
#include <vector>

#include "ConditionalReturn.hpp"
#include "fmt/base.h"
#include "ir/branch-utils.h"
#include "ir/names.h"
#include "support/name.h"
#include "warpo/support/Debug.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "ConditionalReturn"

namespace warpo::passes {
namespace {

struct Scanner : public wasm::PostWalker<Scanner> {
  std::vector<wasm::Expression **> targetIfs_;

  void visitIf(wasm::If *expr) {
    if (expr->ifFalse == nullptr && expr->ifTrue != nullptr && expr->ifTrue->is<wasm::Return>())
      targetIfs_.push_back(getCurrentPointer());
  }
};

wasm::Name getBlockName(std::string_view funcName) { return fmt::format("~CONDITION_RETURN/{}", funcName); }

wasm::Name getValidBlockName(wasm::Function *func) {
  if (auto *const block = func->body->dynCast<wasm::Block>(); block != nullptr && !block->name.isNull())
    return block->name;
  wasm::BranchUtils::NameSet const names = wasm::BranchUtils::getBranchTargets(func->body);
  return wasm::Names::getValidName(getBlockName(func->name.view()),
                                   [&](wasm::Name const name) { return !names.contains(name); });
}

void optimizeConditionalReturnsImpl(wasm::Module *m, wasm::Function *func) {
  Scanner scanner{};
  scanner.walk(func->body);

  if (scanner.targetIfs_.size() < 3)
    return;

  wasm::Type const resultType = func->getResults();
  if (support::isDebug(PASS_NAME, func->name.view())) {
    fmt::println("[" PASS_NAME "] fn '{}' has {} (if (cond) (return)) patterns which can be converted to branches",
                 func->name.view(), scanner.targetIfs_.size());
  }
  wasm::Builder b{*m};
  wasm::Name const targetName = getValidBlockName(func);

  for (wasm::Expression **const expr : scanner.targetIfs_) {
    auto *const ifExpr = (*expr)->cast<wasm::If>();
    auto *const returnExpr = ifExpr->ifTrue->cast<wasm::Return>();
    if (resultType == wasm::Type::none) {
      *expr = b.makeBreak(targetName, nullptr, ifExpr->condition);
    } else {
      *expr = b.makeIf(ifExpr->condition, b.makeBreak(targetName, returnExpr->value));
    }
  }

  if (auto *const block = func->body->dynCast<wasm::Block>()) {
    block->name = targetName;
    block->finalize(resultType);
  } else {
    func->body = b.makeBlock(targetName, {func->body}, resultType);
  }
}

struct ConditionalReturn final : wasm::Pass {
  ConditionalReturn() { name = PASS_NAME; }

  void run(wasm::Module *m) override {
    for (auto &func : m->functions) {
      if (!func->imported())
        optimizeConditionalReturnsImpl(m, func.get());
    }
  }
};

} // namespace

void optimizeConditionalReturns(wasm::Module *m, wasm::Function *func) { optimizeConditionalReturnsImpl(m, func); }

wasm::Pass *createConditionalReturnPass() { return new ConditionalReturn(); }

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "pass.h"

namespace warpo::passes::ut {

namespace {

struct ResultCounter : wasm::PostWalker<ResultCounter> {
  wasm::Name const target_;
  std::size_t branches_ = 0;
  std::size_t valuedBranches_ = 0;

  explicit ResultCounter(wasm::Name const target) : target_(target) {}

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

TEST(ConditionalReturnTest, SingleEarlyReturnIsSkipped) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32)
        local.get 0
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

TEST(ConditionalReturnTest, MultipleVoidGuardsAreExtracted) {
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

  optimizeConditionalReturns(m.get(), func);

  ResultCounter const result = countResults(func);
  EXPECT_EQ(result.branches_, 2U);
  EXPECT_EQ(result.valuedBranches_, 0U);
}

TEST(ConditionalReturnTest, NestedGuardsAreExtracted) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32 i32 i32)
        local.get 0
        if
          local.get 1
          if
            return
          end
        else
          local.get 2
          if
            return
          end
        end
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");

  optimizeConditionalReturns(m.get(), func);

  ResultCounter const result = countResults(func);
  EXPECT_EQ(result.branches_, 2U);
  EXPECT_EQ(result.valuedBranches_, 0U);
}

TEST(ConditionalReturnTest, NonVoidGuardsAreExtracted) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32 i32) (result i32)
        local.get 0
        if
          i32.const 42
          return
        end
        local.get 1
        if
          i32.const 24
          return
        end
        i32.const 10
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");

  optimizeConditionalReturns(m.get(), func);

  ResultCounter const result = countResults(func);
  EXPECT_EQ(func->body->type, wasm::Type::i32);
  EXPECT_EQ(result.branches_, 2U);
  EXPECT_EQ(result.valuedBranches_, 2U);
}

} // namespace warpo::passes::ut

#endif