// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <optional>
#include <unordered_set>

#include "GCInfo.hpp"
#include "ReturnParamFunctions.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes::gc {

namespace {

class ReturnParamAnalysis : public wasm::PostWalker<ReturnParamAnalysis> {
public:
  explicit ReturnParamAnalysis(wasm::Function *f) : function_(f) {}

  void visitLocalSet(wasm::LocalSet *curr) {
    if (curr->index < function_->getNumParams()) {
      modifiedParamIndices_.insert(curr->index);
    }
  }

  void visitReturn(wasm::Return *curr) {
    hasExplicitReturn_ = true;
    checkReturnExpr(curr->value);
  }

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

  void checkFlowValue(wasm::Expression *expr) {
    if (!allReturnsAreLocalGetsOfSameParam_)
      return;
    if (expr == nullptr || expr->type == wasm::Type::unreachable || expr->type == wasm::Type::none)
      return;

    if (auto *block = expr->dynCast<wasm::Block>()) {
      if (!block->list.empty()) {
        checkFlowValue(block->list.back());
      }
      return;
    }

    if (expr->is<wasm::Return>()) {
      // Explicit returns are handled by visitReturn.
      return;
    }

    checkReturnExpr(expr);
  }

  bool hasExplicitReturn() const { return hasExplicitReturn_; }

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
  bool hasExplicitReturn_ = false;
  std::unordered_set<wasm::Index> modifiedParamIndices_;
};

std::optional<wasm::Index> checkFunction(wasm::Function *func) {
  if (func->imported() || func->body == nullptr || func->getResults() == wasm::Type::none) {
    return std::nullopt;
  }

  ReturnParamAnalysis analysis{func};
  analysis.walk(func->body);

  // If the body flows a value out to return (i.e. body type is not unreachable/none),
  // check the falling-through / implicit return expressions.
  analysis.checkFlowValue(func->body);

  return analysis.getUnchangedParamIndex();
}

} // namespace

ReturnParamMap collectReturnParamFunctions(wasm::Module *m) {
  ReturnParamMap result;
  result[wasm::Name(FnLocalToStack)] = 0;
  result[wasm::Name(FnTmpToStack)] = 0;

  for (auto const &func : m->functions) {
    if (func->name == wasm::Name(FnLocalToStack) || func->name == wasm::Name(FnTmpToStack)) {
      result[func->name] = 0;
      continue;
    }
    if (auto paramIndex = checkFunction(func.get())) {
      result[func->name] = paramIndex.value();
    }
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
      (func $~lib/rt/__localtostack (param $a i32) (param $b i32) (result i32)
        local.get $b
      )
      (func $~lib/rt/__tmptostack (param $a i32) (param $b i32) (result i32)
        local.get $b
      )
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

} // namespace warpo::passes::gc::ut

#endif
