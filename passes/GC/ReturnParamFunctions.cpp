// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

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
  if (auto *block = expr->dynCast<wasm::Block>()) {
    if (!block->list.empty()) {
      return getValueExpr(block->list.back());
    }
  } else if (auto *loop = expr->dynCast<wasm::Loop>()) {
    return getValueExpr(loop->body);
  } else if (auto *br = expr->dynCast<wasm::Break>()) {
    if (br->value != nullptr) {
      return getValueExpr(br->value);
    }
  } else if (auto *sw = expr->dynCast<wasm::Switch>()) {
    if (sw->value != nullptr) {
      return getValueExpr(sw->value);
    }
  } else if (auto *ret = expr->dynCast<wasm::Return>()) {
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
    auto *get = expr->dynCast<wasm::LocalGet>();
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
    BasicBlock const *exit = cfg.getExit();
    if (exit != nullptr) {
      std::vector<BasicBlock const *> exitBlocks;
      if (exit->size() > 0) {
        exitBlocks.push_back(exit);
      } else {
        for (BasicBlock const *pred : exit->preds()) {
          // CFG creates synthetic exit block and links any block that terminates
          // or becomes unreachable (such as unreachable/trap instructions) to exit.
          // Ignore paths that do not normally return a value (e.g. empty or unreachable blocks).
          if (pred != nullptr && pred->size() > 0) {
            wasm::Expression *lastExpr = getValueExpr(*pred->rbegin());
            if (lastExpr != nullptr && lastExpr->type != wasm::Type::unreachable &&
                lastExpr->type != wasm::Type::none) {
              exitBlocks.push_back(pred);
            }
          }
        }
      }

      for (BasicBlock const *block : exitBlocks) {
        if (block != nullptr && block->size() > 0) {
          wasm::Expression *lastExpr = getValueExpr(*block->rbegin());
          if (lastExpr != nullptr && !lastExpr->is<wasm::Return>() && lastExpr->type != wasm::Type::unreachable &&
              lastExpr->type != wasm::Type::none) {
            checkReturnExpr(lastExpr);
          }
        }
      }
    }
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

  for (auto const &func : m->functions) {
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

} // namespace warpo::passes::gc::ut

#endif
