// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

//
// Purpose:
// - Before GC epilogue insertion, this pass lets guard returns
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

  static bool isReturnGuard(wasm::If *expr) {
    return expr->ifFalse == nullptr && expr->ifTrue != nullptr && expr->ifTrue->is<wasm::Return>();
  }

  static bool isSimpleNonVoidGuard(wasm::If *expr) {
    if (!isReturnGuard(expr))
      return false;
    auto *const returnValue = expr->ifTrue->cast<wasm::Return>()->value;
    if (returnValue == nullptr || !returnValue->is<wasm::Const>())
      return false;
    if (expr->condition->is<wasm::LocalGet>())
      return true;
    auto *const unary = expr->condition->dynCast<wasm::Unary>();
    return unary != nullptr && unary->value->is<wasm::LocalGet>();
  }

  void visitIf(wasm::If *expr) {
    if (isReturnGuard(expr))
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
  wasm::Type const resultType = func->getResults();
  Scanner scanner{};
  if (resultType == wasm::Type::none) {
    scanner.walk(func->body);
  } else if (auto *const block = func->body->dynCast<wasm::Block>()) {
    for (wasm::Expression *&expr : block->list) {
      if (auto *const ifExpr = expr->dynCast<wasm::If>(); ifExpr != nullptr && Scanner::isSimpleNonVoidGuard(ifExpr))
        scanner.targetIfs_.push_back(&expr);
    }
  }

  if (scanner.targetIfs_.empty() || (resultType != wasm::Type::none && scanner.targetIfs_.size() < 2))
    return;

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
      if (!func->imported() && func->getResults() == wasm::Type::none)
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

#include "GC/GCInfo.hpp"
#include "GC/PrologEpilogInserter.hpp"
#include "Runner.hpp"
#include "pass.h"
#include "wasm-validator.h"

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

struct RestoreCounter : wasm::PostWalker<RestoreCounter> {
  std::size_t calls_ = 0;

  void visitCall(wasm::Call *expr) {
    if (expr->target == gc::FnIncreaseSP)
      ++calls_;
  }
};

ResultCounter countResults(wasm::Function *func) {
  ResultCounter result{getBlockName(func->name.view())};
  result.walk(func->body);
  return result;
}

} // namespace

TEST(ConditionalReturnTest, SingleNonVoidGuardIsSkipped) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32) (result i32)
        local.get 0
        if
          i32.const 42
          return
        end
        i32.const 0
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");
  wasm::Expression *const body = func->body;

  optimizeConditionalReturns(m.get(), func);

  EXPECT_EQ(func->body, body);
}

TEST(ConditionalReturnTest, SingleVoidGuardIsExtracted) {
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

  optimizeConditionalReturns(m.get(), func);

  EXPECT_EQ(countResults(func).branches_, 1U);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
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

  wasm::Expression *const body = func->body;
  std::unique_ptr<wasm::Pass> const latePass{createConditionalReturnPass()};
  latePass->run(m.get());
  EXPECT_EQ(func->body, body);

  optimizeConditionalReturns(m.get(), func);

  ResultCounter const result = countResults(func);
  EXPECT_EQ(func->body->type, wasm::Type::i32);
  EXPECT_EQ(result.branches_, 2U);
  EXPECT_EQ(result.valuedBranches_, 2U);
}

TEST(ConditionalReturnTest, NestedNonVoidGuardsAreSkipped) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32 i32 i32) (result i32)
        local.get 0
        if
          local.get 1
          if
            i32.const 42
            return
          end
          local.get 2
          if
            i32.const 24
            return
          end
        end
        i32.const 0
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");

  optimizeConditionalReturns(m.get(), func);

  EXPECT_EQ(countResults(func).branches_, 0U);
}

TEST(ConditionalReturnTest, NonVoidGuardsWithLoadsAreSkipped) {
  auto m = loadWat(R"(
    (module
      (memory 1)
      (func $main (param i32 i32) (result i32)
        local.get 0
        i32.load
        if
          i32.const 42
          return
        end
        local.get 1
        i32.load
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

  EXPECT_EQ(countResults(func).branches_, 0U);
}

TEST(ConditionalReturnTest, SharesNonVoidEpilogueOnlyWithShadowStack) {
  auto m = loadWat(R"(
    (module
      (func $~lib/rt/__decrease_sp (param i32))
      (func $~lib/rt/__increase_sp (param i32))
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
  auto const offsets = std::make_shared<gc::MaxShadowStackOffsets>();
  gc::PrologEpilogInserter inserter{nullptr, offsets};

  (*offsets)[func] = 0;
  wasm::Expression *const originalBody = func->body;
  inserter.runOnFunction(m.get(), func);
  EXPECT_EQ(func->body, originalBody);

  (*offsets)[func] = gc::ShadowStackElementSize;
  inserter.runOnFunction(m.get(), func);

  ResultCounter const result = countResults(func);
  RestoreCounter restores;
  restores.walk(func->body);
  EXPECT_EQ(result.branches_, 2U);
  EXPECT_EQ(result.valuedBranches_, 2U);
  EXPECT_EQ(restores.calls_, 1U);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

} // namespace warpo::passes::ut

#endif