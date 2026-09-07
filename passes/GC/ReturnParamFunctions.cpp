// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <optional>
#include <unordered_set>

#include "../helper/CFG.hpp"
#include "GCInfo.hpp"
#include "ReturnParamFunctions.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes::gc {

namespace {

wasm::Expression *getValueExpr(wasm::Expression *expr) {
  if (expr == nullptr) {
    return nullptr;
  }
  if (wasm::Break *const br = expr->dynCast<wasm::Break>()) {
    if (br->value != nullptr) {
      return getValueExpr(br->value);
    }
  } else if (wasm::Switch *const sw = expr->dynCast<wasm::Switch>()) {
    if (sw->value != nullptr) {
      return getValueExpr(sw->value);
    }
  } else if (wasm::Return *const ret = expr->dynCast<wasm::Return>()) {
    if (ret->value != nullptr) {
      return getValueExpr(ret->value);
    }
  }
  return expr;
}

class ReturnParamAnalysis : public wasm::PostWalker<ReturnParamAnalysis> {
public:
  explicit ReturnParamAnalysis(wasm::Function *f) : function_(f) {}

  void visitLocalSet(wasm::LocalSet *curr) {
    if (curr->index < function_->getNumParams()) {
      modifiedParamIndices_.insert(curr->index);
    }
  }

  void visitReturn(wasm::Return *curr) { checkReturnExpr(curr->value); }

  void checkReturnExpr(wasm::Expression *expr) {
    if (!allReturnsAreLocalGetsOfSameParam_)
      return;
    if (expr == nullptr) {
      allReturnsAreLocalGetsOfSameParam_ = false;
      return;
    }
    wasm::LocalGet *const get = expr->dynCast<wasm::LocalGet>();
    if (get == nullptr || get->index >= function_->getNumParams()) {
      allReturnsAreLocalGetsOfSameParam_ = false;
      return;
    }

    if (!unchangedParamIndex_.has_value()) {
      unchangedParamIndex_ = get->index;
    } else if (unchangedParamIndex_.value() != get->index) {
      allReturnsAreLocalGetsOfSameParam_ = false;
    }
  }

  void checkImplicitReturns(wasm::Module *m) {
    if (!allReturnsAreLocalGetsOfSameParam_)
      return;

    CFG const cfg = CFG::fromFunction(m, function_);
    BasicBlock const *const exit = cfg.getExit();
    if (exit == nullptr)
      return;

    std::unordered_set<BasicBlock const *> visited;
    auto visitBB = [&](auto const &self, BasicBlock const *bb) -> void {
      if (!allReturnsAreLocalGetsOfSameParam_ || bb == nullptr)
        return;
      if (!visited.insert(bb).second)
        return;

      // Find the last valuable instruction in this basic block.
      // Skipping AST container nodes (Block, Loop, Nop) is necessary because CFGBuilder
      // appends them to basic block instruction lists at block closure during post-order walk:
      //
      // 1. Pure join/merge point:
      //      (block $merge (result i32)
      //        (if (local.get $c)
      //          (then (br $merge (local.get $a)))
      //          (else (br $merge (local.get $a)))))
      //    The exit block after $merge only contains [ (block $merge ...) ]. Skipping it yields
      //    lastInst == nullptr, so the analysis checks incoming predecessor paths.
      //
      // 2. Linear statements followed by closed block(s) in the same basic block:
      //      (block $outer (result i32)
      //        (block $inner (result i32)
      //          (local.get $this)))
      //    CFGBuilder appends [ (local.get $this), (block $inner ...), (block $outer ...) ].
      //    Reverse iteration skips the closing containers to inspect the actual value (local.get $this).
      //
      // 3. Statements after an inner block closes:
      //      (block (nop))
      //      (local.get $this)
      //    CFGBuilder appends [ (nop), (block ...), (local.get $this) ].
      //    Reverse iteration immediately encounters (local.get $this) first.
      wasm::Expression *lastInst = nullptr;
      // NOLINTNEXTLINE(modernize-loop-convert)
      for (BasicBlock::reverse_iterator it = bb->rbegin(); it != bb->rend(); ++it) {
        wasm::Expression *const expr = *it;
        if (expr == nullptr || expr->is<wasm::Block>() || expr->is<wasm::Loop>() || expr->is<wasm::Nop>())
          continue;
        lastInst = expr;
        break;
      }

      // If the basic block contains no valuable instruction (e.g. empty join block)
      // or ends with a branching condition (If), the return value flows from predecessors.
      if (lastInst == nullptr || lastInst->is<wasm::If>()) {
        for (BasicBlock const *const pred : bb->preds()) {
          self(self, pred);
        }
      } else if (wasm::Break *const br = lastInst->dynCast<wasm::Break>()) {
        if (br->value != nullptr) {
          checkReturnExpr(br->value);
        }
      } else if (wasm::Switch *const sw = lastInst->dynCast<wasm::Switch>()) {
        if (sw->value != nullptr) {
          checkReturnExpr(sw->value);
        }
      } else if (lastInst->type != wasm::Type::unreachable && !lastInst->is<wasm::Return>()) {
        // Concrete instruction producing the return value in this basic block (visitReturn handles Return)
        checkReturnExpr(lastInst);
      } else {
        assert(lastInst->type == wasm::Type::unreachable || lastInst->is<wasm::Return>());
      }
    };

    visitBB(visitBB, exit);
  }

  std::optional<wasm::Index> getUnchangedParamIndex() const {
    if (!allReturnsAreLocalGetsOfSameParam_ || !unchangedParamIndex_.has_value())
      return std::nullopt;
    if (modifiedParamIndices_.contains(unchangedParamIndex_.value()))
      return std::nullopt;
    return unchangedParamIndex_;
  }

private:
  wasm::Function *function_;
  std::optional<wasm::Index> unchangedParamIndex_;
  bool allReturnsAreLocalGetsOfSameParam_ = true;
  std::unordered_set<wasm::Index> modifiedParamIndices_;
};

std::optional<wasm::Index> checkFunction(wasm::Module *m, wasm::Function *func) {
  if (func->imported() || func->body == nullptr || func->getResults() == wasm::Type::none) {
    return std::nullopt;
  }

  ReturnParamAnalysis analysis{func};
  analysis.walk(func->body);
  analysis.checkImplicitReturns(m);

  return analysis.getUnchangedParamIndex();
}

} // namespace

ReturnParamMap collectReturnParamFunctions(wasm::Module *m) {
  ReturnParamMap result;
  result[wasm::Name(FnLocalToStack)] = 0;
  result[wasm::Name(FnTmpToStack)] = 0;

  for (std::unique_ptr<wasm::Function> const &func : m->functions) {
    std::optional<wasm::Index> const paramIndex = checkFunction(m, func.get());
    if (paramIndex.has_value())
      result[func->name] = paramIndex.value();
  }

  return result;
}

} // namespace warpo::passes::gc

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "../Runner.hpp"

namespace warpo::passes::gc::ut {

TEST(ReturnParamFunctionsTest, SingleReturnParam) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (result i32)
        local.get $this
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 0);
}

TEST(ReturnParamFunctionsTest, ExplicitReturnParam) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $a i32) (param $b i32) (result i32)
        local.get $b
        return
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 1);
}

TEST(ReturnParamFunctionsTest, MixedLocalGetAndNonLocalGetReturns) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $condition i32) (param $this i32) (result i32)
        (if (local.get $condition)
          (then (return (local.get $this)))
        )
        i32.const 42
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, RuntimeToStackFunctionsReturnFirstParameter) {
  auto m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__localtostack"
        (func $~lib/rt/__localtostack (param i32) (result i32)))
      (import "as-builtin-fn" "~lib/rt/__tmptostack"
        (func $~lib/rt/__tmptostack (param i32) (result i32)))
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_EQ(res.at(wasm::Name(FnLocalToStack)), 0);
  EXPECT_EQ(res.at(wasm::Name(FnTmpToStack)), 0);
}

TEST(ReturnParamFunctionsTest, DifferentReturnParams) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $cond i32) (param $a i32) (param $b i32) (result i32)
        (if (result i32) (local.get $cond)
          (then (return (local.get $a)))
          (else (return (local.get $b)))
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, SameReturnParamBranches) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $cond i32) (param $this i32) (result i32)
        (if (result i32) (local.get $cond)
          (then (return (local.get $this)))
          (else (return (local.get $this)))
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 1);
}

TEST(ReturnParamFunctionsTest, ParamModifiedByLocalSet) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (result i32)
        (local.set $this (i32.const 0))
        (local.get $this)
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, ParamModifiedByLocalTee) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (result i32)
        (local.tee $this (i32.const 0))
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, ReturnsNonParamLocal) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (result i32)
        (local $temp i32)
        (local.set $temp (local.get $this))
        (local.get $temp)
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, ImplicitReturnNestedBlock) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (result i32)
        (block (result i32)
          (nop)
          (block (result i32)
            (nop)
            (local.get $this)
          )
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 0);
}

TEST(ReturnParamFunctionsTest, MixedExplicitAndImplicitReturnSameParam) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $cond i32) (param $this i32) (result i32)
        (if (local.get $cond)
          (then (return (local.get $this)))
        )
        (local.get $this)
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 1);
}

TEST(ReturnParamFunctionsTest, BranchToBlockExitImplicitReturn) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $cond i32) (param $this i32) (result i32)
        (block $exit (result i32)
          (drop
            (br_if $exit (local.get $this) (local.get $cond))
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 1);
}

TEST(ReturnParamFunctionsTest, BranchToBlockExitDifferentValue) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $cond i32) (param $this i32) (result i32)
        (block $exit (result i32)
          (drop
            (br_if $exit (i32.const 0) (local.get $cond))
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, IfElseImplicitReturnPositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $cond i32) (param $this i32) (result i32)
        (if (result i32) (local.get $cond)
          (then (local.get $this))
          (else (local.get $this))
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 1);
}

TEST(ReturnParamFunctionsTest, IfElseImplicitReturnNegative) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $cond i32) (param $this i32) (result i32)
        (if (result i32) (local.get $cond)
          (then (local.get $this))
          (else (i32.const 100))
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, BrTableImplicitReturnPositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $idx i32) (param $this i32) (result i32)
        (block $out (result i32)
          (block $c2
            (block $c1
              (block $c0
                (br_table $c0 $c1 $c2 (local.get $idx))
              )
              (br $out (local.get $this))
            )
            (br $out (local.get $this))
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 1);
}

TEST(ReturnParamFunctionsTest, BrTableImplicitReturnNegative) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $idx i32) (param $this i32) (result i32)
        (block $out (result i32)
          (block $c2
            (block $c1
              (block $c0
                (br_table $c0 $c1 $c2 (local.get $idx))
              )
              (br $out (local.get $this))
            )
            (br $out (i32.const 42))
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, BrTableValueBranchPositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $idx i32) (param $this i32) (result i32)
        (block $out (result i32)
          (br_table $out $out (local.get $this) (local.get $idx))
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 1);
}

TEST(ReturnParamFunctionsTest, LoopImplicitReturnPositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (param $count i32) (result i32)
        (loop $l (result i32)
          (local.set $count (i32.sub (local.get $count) (i32.const 1)))
          (br_if $l (local.get $count))
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 0);
}

TEST(ReturnParamFunctionsTest, LoopImplicitReturnNegative) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (param $count i32) (result i32)
        (loop $l (result i32)
          (local.set $count (i32.sub (local.get $count) (i32.const 1)))
          (br_if $l (local.get $count))
          (local.get $count)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, LoopWithEarlyBreakToOuterBlockPositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (param $cond i32) (result i32)
        (block $exit (result i32)
          (loop $l
            (br_if $exit (local.get $this) (local.get $cond))
            (br $l)
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 0);
}

TEST(ReturnParamFunctionsTest, LoopWithEarlyBreakToOuterBlockNegative) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (param $cond i32) (result i32)
        (block $exit (result i32)
          (loop $l
            (br_if $exit (i32.const 99) (local.get $cond))
            (br $l)
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, NestedBlocksWithMultipleExitsPositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (param $this i32) (result i32)
        (block $b1 (result i32)
          (block $b2
            (br_if $b1 (local.get $this) (local.get $c1))
            (br_if $b2 (local.get $c2))
            (return (local.get $this))
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 2);
}

TEST(ReturnParamFunctionsTest, NestedBlocksWithMultipleExitsNegative) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (param $this i32) (result i32)
        (block $b1 (result i32)
          (block $b2
            (br_if $b1 (local.get $this) (local.get $c1))
            (br_if $b2 (local.get $c2))
            (return (i32.const 0))
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, BuilderPatternWithMemoryStoreAndCalls) {
  auto m = loadWat(R"(
    (module
      (memory 1)
      (func $helper (param i32))
      (func $setProp (param $this i32) (param $val i32) (result i32)
        (i32.store (local.get $this) (local.get $val))
        (call $helper (local.get $this))
        (local.get $this)
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("setProp")));
  EXPECT_EQ(res.at(wasm::Name("setProp")), 0);
}

TEST(ReturnParamFunctionsTest, ModifiesOtherParameterOnly) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (param $other i32) (result i32)
        (local.set $other (i32.add (local.get $other) (i32.const 1)))
        (local.get $this)
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 0);
}

TEST(ReturnParamFunctionsTest, AssertTrapBranchAndReturn) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (param $valid i32) (result i32)
        (if (i32.eqz (local.get $valid))
          (then (unreachable))
        )
        (local.get $this)
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 0);
}

TEST(ReturnParamFunctionsTest, NestedIfElseMultiLevelConvergencePositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (param $this i32) (result i32)
        (if (result i32) (local.get $c1)
          (then
            (if (result i32) (local.get $c2)
              (then (local.get $this))
              (else (local.get $this))
            )
          )
          (else (local.get $this))
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 2);
}

TEST(ReturnParamFunctionsTest, NestedIfElseMultiLevelConvergenceNegative) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (param $this i32) (result i32)
        (if (result i32) (local.get $c1)
          (then
            (if (result i32) (local.get $c2)
              (then (local.get $this))
              (else (i32.const 999))
            )
          )
          (else (local.get $this))
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, NestedBlocksTreeConvergencePositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (param $this i32) (result i32)
        (block $outer (result i32)
          (block $inner (result i32)
            (drop (br_if $outer (local.get $this) (local.get $c1)))
            (drop (br_if $inner (local.get $this) (local.get $c2)))
            (local.get $this)
          )
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 2);
}

TEST(ReturnParamFunctionsTest, NestedBlocksTreeConvergenceNegative) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (param $this i32) (result i32)
        (block $outer (result i32)
          (block $inner (result i32)
            (drop (br_if $outer (local.get $this) (local.get $c1)))
            (drop (br_if $inner (i32.const 123) (local.get $c2)))
            (local.get $this)
          )
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, NestedLoopWithInnerLoopAndBreaksPositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (param $i i32) (param $j i32) (result i32)
        (block $exit (result i32)
          (loop $outer
            (local.set $i (i32.sub (local.get $i) (i32.const 1)))
            (drop (br_if $exit (local.get $this) (i32.eqz (local.get $i))))
            (loop $inner
              (local.set $j (i32.sub (local.get $j) (i32.const 1)))
              (drop (br_if $exit (local.get $this) (i32.eqz (local.get $j))))
              (br_if $inner (local.get $j))
            )
            (br $outer)
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 0);
}

TEST(ReturnParamFunctionsTest, NestedLoopWithInnerLoopAndBreaksNegative) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $this i32) (param $i i32) (param $j i32) (result i32)
        (block $exit (result i32)
          (loop $outer
            (local.set $i (i32.sub (local.get $i) (i32.const 1)))
            (drop (br_if $exit (local.get $this) (i32.eqz (local.get $i))))
            (loop $inner
              (local.set $j (i32.sub (local.get $j) (i32.const 1)))
              (drop (br_if $exit (i32.const 42) (i32.eqz (local.get $j))))
              (br_if $inner (local.get $j))
            )
            (br $outer)
          )
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, SwitchComplexBranchesPositive) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $tag i32) (param $this i32) (result i32)
        (block $sw_exit (result i32)
          (block $b3
            (block $b2
              (block $b1
                (block $b0
                  (br_table $b0 $b1 $b2 $b3 (local.get $tag))
                )
                ;; case 0
                (drop (br $sw_exit (local.get $this)))
              )
              ;; case 1
              (drop (br $sw_exit (local.get $this)))
            )
            ;; case 2
            (return (local.get $this))
          )
          ;; default
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 1);
}

TEST(ReturnParamFunctionsTest, SwitchComplexBranchesNegative) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $tag i32) (param $this i32) (result i32)
        (block $sw_exit (result i32)
          (block $b3
            (block $b2
              (block $b1
                (block $b0
                  (br_table $b0 $b1 $b2 $b3 (local.get $tag))
                )
                ;; case 0
                (drop (br $sw_exit (local.get $this)))
              )
              ;; case 1
              (drop (br $sw_exit (i32.const 999)))
            )
            ;; case 2
            (return (local.get $this))
          )
          ;; default
          (local.get $this)
        )
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

TEST(ReturnParamFunctionsTest, ConvergingIfElseFollowedByUnrelatedCalculationsAndLocalGet) {
  auto m = loadWat(R"(
    (module
      (global $g (mut i32) (i32.const 0))
      (func $foo (param $cond i32) (param $this i32) (result i32)
        (if (local.get $cond)
          (then
            (global.set $g (i32.const 1))
          )
          (else
            (global.set $g (i32.const 2))
          )
        )
        (global.set $g (i32.add (global.get $g) (i32.const 10)))
        (local.get $this)
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 1);
}

TEST(ReturnParamFunctionsTest, ComplexDataFlowInPredecessorsFollowedByUnrelatedCalculationsPositive) {
  auto m = loadWat(R"(
    (module
      (global $g (mut i32) (i32.const 0))
      (memory 1)
      (func $helper (param i32) (result i32)
        (i32.add (local.get 0) (i32.const 1))
      )
      (func $foo (param $cond i32) (param $val i32) (param $this i32) (result i32)
        (local $temp i32)
        (if (local.get $cond)
          (then
            (local.set $temp (call $helper (local.get $val)))
            (i32.store (i32.const 0) (local.get $temp))
          )
          (else
            (local.set $temp (i32.mul (local.get $val) (i32.const 2)))
            (global.set $g (local.get $temp))
          )
        )
        ;; Unrelated calculations in the merge basic block
        (global.set $g (i32.add (global.get $g) (local.get $temp)))
        (i32.store (i32.const 4) (global.get $g))
        (local.get $this)
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_TRUE(res.contains(wasm::Name("foo")));
  EXPECT_EQ(res.at(wasm::Name("foo")), 2);
}

TEST(ReturnParamFunctionsTest, ConvergingBranchesFollowedByCalculationReturningComputedValueNegative) {
  auto m = loadWat(R"(
    (module
      (global $g (mut i32) (i32.const 0))
      (func $foo (param $cond i32) (param $this i32) (result i32)
        (if (local.get $cond)
          (then
            (global.set $g (i32.const 1))
          )
          (else
            (global.set $g (i32.const 2))
          )
        )
        ;; Calculates and returns a computed value instead of the parameter
        (global.set $g (i32.add (global.get $g) (i32.const 10)))
        (global.get $g)
      )
    )
  )");
  auto res = collectReturnParamFunctions(m.get());
  EXPECT_FALSE(res.contains(wasm::Name("foo")));
}

} // namespace warpo::passes::gc::ut

#endif
