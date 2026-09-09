// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <unordered_set>

#include "TailCall.hpp"
#include "helper/ReturnPoints.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes {
namespace {

// Unwraps Return/Break when it directly wraps a converted tail call in a single pass.
void unwrapReturnPoints(wasm::Function *func, std::unordered_set<wasm::Expression *> const &converted) {
  if (converted.empty())
    return;

  struct Unwrapper : public wasm::PostWalker<Unwrapper> {
    std::unordered_set<wasm::Expression *> const &targets;
    explicit Unwrapper(std::unordered_set<wasm::Expression *> const &targets) : targets(targets) {}

    void visitReturn(wasm::Return *curr) {
      if (curr->value != nullptr && targets.count(curr->value) > 0)
        replaceCurrent(curr->value);
    }

    void visitBreak(wasm::Break *curr) {
      if (curr->value != nullptr && targets.count(curr->value) > 0)
        replaceCurrent(curr->value);
    }
  };

  Unwrapper unwrapper{converted};
  unwrapper.walk(func->body);
}

struct TailCallOptimizer : public wasm::Pass {
  bool modifiesBinaryenIR() override { return true; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<TailCallOptimizer>(); }

  bool tryConvertCall(wasm::Expression *expr, wasm::Module *m, wasm::Function *func) {
    if (expr == nullptr)
      return false;

    if (auto *const call = expr->dynCast<wasm::Call>()) {
      if (call->isReturn)
        return false;
      auto *const targetFunc = m->getFunctionOrNull(call->target);
      if (targetFunc == nullptr || targetFunc->getResults() != func->getResults())
        return false;
      call->isReturn = true;
      call->finalize();
      return true;
    }

    if (auto *const call = expr->dynCast<wasm::CallIndirect>()) {
      if (call->isReturn || call->heapType.getSignature().results != func->getResults())
        return false;
      call->isReturn = true;
      call->finalize();
      return true;
    }

    if (auto *const call = expr->dynCast<wasm::CallRef>()) {
      if (call->isReturn || !call->target->type.isRef() || !call->target->type.getHeapType().isSignature() ||
          call->target->type.getHeapType().getSignature().results != func->getResults())
        return false;
      call->isReturn = true;
      call->finalize();
      return true;
    }

    return false;
  }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override {
    if (!m->features.hasTailCall() || func->imported() || func->body == nullptr)
      return;

    std::unordered_set<wasm::Expression *> convertedCalls;
    std::vector<ReturnPoint> const returnPoints = computeReturnPoints(m, func);
    for (ReturnPoint const &rp : returnPoints) {
      if (tryConvertCall(rp.expr, m, func))
        convertedCalls.insert(rp.expr);
    }

    if (!convertedCalls.empty()) {
      unwrapReturnPoints(func, convertedCalls);
      // Reuse Binaryen DCE pass to clean
      wasm::PassRunner runner{m};
      runner.setIsNested(true);
      runner.add("dce");
      runner.runOnFunction(func);
    }
  }
};

} // namespace
} // namespace warpo::passes

wasm::Pass *warpo::passes::createTailCallOptimizerPass() { return new TailCallOptimizer(); }

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>
#include <memory>

#include "Runner.hpp"
#include "helper/Matcher.hpp"

namespace warpo::passes::ut {

TEST(TailCallOptimizerTest, ConvertsDirectCallFollowedByReturn) {
  auto m = loadWat(R"(
    (module
      (func $callee)
      (func $caller
        call $callee
        return
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Block>());
  wasm::Block *const block = func->body->cast<wasm::Block>();
  ASSERT_EQ(block->list.size(), 1U);
  ASSERT_TRUE(block->list[0]->is<wasm::Call>());
  wasm::Call *const call = block->list[0]->cast<wasm::Call>();
  EXPECT_EQ(call->target, "callee");
  EXPECT_TRUE(call->isReturn);
  EXPECT_TRUE(call->type == wasm::Type::unreachable);
}

TEST(TailCallOptimizerTest, ConvertsReturnedDirectCallWithResult) {
  auto m = loadWat(R"(
    (module
      (func $callee (result i32)
        i32.const 1
      )
      (func $caller (result i32)
        call $callee
        return
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Call>());
  wasm::Call *const call = func->body->cast<wasm::Call>();
  EXPECT_EQ(call->target, "callee");
  EXPECT_TRUE(call->isReturn);
  EXPECT_EQ(call->type, wasm::Type::unreachable);
}

TEST(TailCallOptimizerTest, ConvertsFinalDirectCallInVoidFunctionBody) {
  auto m = loadWat(R"(
    (module
      (func $callee)
      (func $caller
        call $callee
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Call>());
  wasm::Call *const call = func->body->cast<wasm::Call>();
  EXPECT_EQ(call->target, "callee");
  EXPECT_TRUE(call->isReturn);
  EXPECT_TRUE(call->type == wasm::Type::unreachable);
}

TEST(TailCallOptimizerTest, ConvertsIndirectCallFollowedByReturn) {
  auto m = loadWat(R"(
    (module
      (type $callee_type (func))
      (func $callee)
      (table 1 funcref)
      (elem (i32.const 0) $callee)
      (func $caller
        i32.const 0
        call_indirect (type $callee_type)
        return
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Block>());
  wasm::Block *const block = func->body->cast<wasm::Block>();
  ASSERT_EQ(block->list.size(), 1U);
  ASSERT_TRUE(block->list.back()->is<wasm::CallIndirect>());
  wasm::CallIndirect *const call = block->list.back()->cast<wasm::CallIndirect>();
  EXPECT_TRUE(call->isReturn);
  EXPECT_TRUE(call->type == wasm::Type::unreachable);
}

TEST(TailCallOptimizerTest, ConvertsFinalIndirectCallInFunctionBody) {
  auto m = loadWat(R"(
    (module
      (type $callee_type (func))
      (func $callee)
      (table 1 funcref)
      (elem (i32.const 0) $callee)
      (func $caller
        i32.const 0
        call_indirect (type $callee_type)
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::CallIndirect>());
  wasm::CallIndirect *const call = func->body->cast<wasm::CallIndirect>();
  EXPECT_TRUE(call->isReturn);
  EXPECT_TRUE(call->type == wasm::Type::unreachable);
}

TEST(TailCallOptimizerTest, KeepsNonTailCall) {
  auto m = loadWat(R"(
    (module
      (func $callee)
      (func $caller
        call $callee
        nop
        return
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  using namespace matcher;
  auto const match = isBlock(block::has(3U), block::at(0U, isCall(call::callee("callee"))), block::at(1U, isNop()),
                             block::at(2U, isReturn()));
  isMatched(match, func->body);
  EXPECT_FALSE(func->body->cast<wasm::Block>()->list[0]->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsIfElseDirectCalls) {
  auto m = loadWat(R"(
    (module
      (func $foo (result i32) (i32.const 1))
      (func $goo (result i32) (i32.const 2))
      (func $baz (param $0 i32) (result i32)
        local.get $0
        i32.const 0
        i32.gt_s
        if (result i32)
          call $foo
        else
          call $goo
        end
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::If>());
  wasm::If *const ifExpr = func->body->cast<wasm::If>();
  ASSERT_TRUE(ifExpr->ifTrue->is<wasm::Call>());
  ASSERT_TRUE(ifExpr->ifFalse->is<wasm::Call>());
  EXPECT_TRUE(ifExpr->ifTrue->cast<wasm::Call>()->isReturn);
  EXPECT_TRUE(ifExpr->ifFalse->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsIfElseIndirectCalls) {
  auto m = loadWat(R"(
    (module
      (type $sig (func (result i32)))
      (table 2 funcref)
      (func $baz (param $0 i32) (result i32)
        local.get $0
        if (result i32)
          i32.const 0
          call_indirect (type $sig)
        else
          i32.const 1
          call_indirect (type $sig)
        end
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::If>());
  wasm::If *const ifExpr = func->body->cast<wasm::If>();
  ASSERT_TRUE(ifExpr->ifTrue->is<wasm::CallIndirect>());
  ASSERT_TRUE(ifExpr->ifFalse->is<wasm::CallIndirect>());
  EXPECT_TRUE(ifExpr->ifTrue->cast<wasm::CallIndirect>()->isReturn);
  EXPECT_TRUE(ifExpr->ifFalse->cast<wasm::CallIndirect>()->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsNestedIfElseInBlock) {
  auto m = loadWat(R"(
    (module
      (func $foo (result i32) (i32.const 1))
      (func $goo (result i32) (i32.const 2))
      (func $log (param i32))
      (func $baz (param $0 i32) (result i32)
        (block (result i32)
          local.get $0
          call $log
          local.get $0
          if (result i32)
            call $foo
          else
            call $goo
          end
        )
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Block>());
  wasm::Block *const block = func->body->cast<wasm::Block>();
  ASSERT_EQ(block->list.size(), 2U);
  EXPECT_FALSE(block->list[0]->cast<wasm::Call>()->isReturn);
  ASSERT_TRUE(block->list[1]->is<wasm::If>());
  wasm::If *const ifExpr = block->list[1]->cast<wasm::If>();
  ASSERT_TRUE(ifExpr->ifTrue->is<wasm::Call>());
  ASSERT_TRUE(ifExpr->ifFalse->is<wasm::Call>());
  EXPECT_TRUE(ifExpr->ifTrue->cast<wasm::Call>()->isReturn);
  EXPECT_TRUE(ifExpr->ifFalse->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsSingleArmedIfInVoidFunction) {
  auto m = loadWat(R"(
    (module
      (func $foo)
      (func $bar (param $0 i32)
        local.get $0
        if
          call $foo
        end
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("bar");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::If>());
  wasm::If *const ifExpr = func->body->cast<wasm::If>();
  ASSERT_TRUE(ifExpr->ifTrue->is<wasm::Call>());
  EXPECT_TRUE(ifExpr->ifTrue->cast<wasm::Call>()->isReturn);
  EXPECT_EQ(ifExpr->ifFalse, nullptr);
}

TEST(TailCallOptimizerTest, ConvertsReturnWrappingIf) {
  auto m = loadWat(R"(
    (module
      (func $foo (result i32) (i32.const 1))
      (func $goo (result i32) (i32.const 2))
      (func $baz (param $0 i32) (result i32)
        local.get $0
        if (result i32)
          call $foo
        else
          call $goo
        end
        return
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::If>());
  wasm::If *const ifExpr = func->body->cast<wasm::If>();
  ASSERT_TRUE(ifExpr->ifTrue->is<wasm::Call>());
  ASSERT_TRUE(ifExpr->ifFalse->is<wasm::Call>());
  EXPECT_TRUE(ifExpr->ifTrue->cast<wasm::Call>()->isReturn);
  EXPECT_TRUE(ifExpr->ifFalse->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsBreakTargetingTailBlock) {
  auto m = loadWat(R"(
    (module
      (func $foo (result i32) (i32.const 1))
      (func $goo (result i32) (i32.const 2))
      (func $baz (param $0 i32) (result i32)
        (block $exit (result i32)
          local.get $0
          if
            call $foo
            br $exit
          end
          call $goo
        )
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Block>());
  wasm::Block *const block = func->body->cast<wasm::Block>();
  ASSERT_EQ(block->list.size(), 2U);
  ASSERT_TRUE(block->list[0]->is<wasm::If>());
  wasm::If *const ifExpr = block->list[0]->cast<wasm::If>();
  ASSERT_TRUE(ifExpr->ifTrue->is<wasm::Call>());
  EXPECT_TRUE(ifExpr->ifTrue->cast<wasm::Call>()->isReturn);
  ASSERT_TRUE(block->list[1]->is<wasm::Call>());
  EXPECT_TRUE(block->list[1]->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, KeepsMismatchedReturnTypeCall) {
  auto m = loadWat(R"(
    (module
      (func $callee (result i32) (i32.const 1))
      (func $caller
        call $callee
        drop
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Drop>());
  wasm::Drop *const drop = func->body->cast<wasm::Drop>();
  ASSERT_TRUE(drop->value->is<wasm::Call>());
  EXPECT_FALSE(drop->value->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, KeepsNonTailCallInIfCondition) {
  auto m = loadWat(R"(
    (module
      (func $check (result i32) (i32.const 1))
      (func $foo (result i32) (i32.const 2))
      (func $goo (result i32) (i32.const 3))
      (func $baz (result i32)
        call $check
        if (result i32)
          call $foo
        else
          call $goo
        end
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::If>());
  wasm::If *const ifExpr = func->body->cast<wasm::If>();
  ASSERT_TRUE(ifExpr->condition->is<wasm::Call>());
  EXPECT_FALSE(ifExpr->condition->cast<wasm::Call>()->isReturn);
  ASSERT_TRUE(ifExpr->ifTrue->is<wasm::Call>());
  EXPECT_TRUE(ifExpr->ifTrue->cast<wasm::Call>()->isReturn);
  ASSERT_TRUE(ifExpr->ifFalse->is<wasm::Call>());
  EXPECT_TRUE(ifExpr->ifFalse->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsVoidIfElseFollowedByReturn) {
  auto m = loadWat(R"(
    (module
      (func $foo)
      (func $goo)
      (func $baz (param $0 i32)
        (block
          local.get $0
          if
            call $foo
          else
            call $goo
          end
          return
        )
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Block>());
  wasm::Block *const block = func->body->cast<wasm::Block>();
  ASSERT_EQ(block->list.size(), 1U);
  ASSERT_TRUE(block->list[0]->is<wasm::If>());
  wasm::If *const ifExpr = block->list[0]->cast<wasm::If>();
  EXPECT_TRUE(ifExpr->ifTrue->cast<wasm::Call>()->isReturn);
  EXPECT_TRUE(ifExpr->ifFalse->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsIfElseIfElseChain) {
  auto m = loadWat(R"(
    (module
      (func $f1 (result i32) (i32.const 1))
      (func $f2 (result i32) (i32.const 2))
      (func $f3 (result i32) (i32.const 3))
      (func $baz (param $0 i32) (param $1 i32) (result i32)
        local.get $0
        if (result i32)
          call $f1
        else
          local.get $1
          if (result i32)
            call $f2
          else
            call $f3
          end
        end
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::If>());
  wasm::If *const outerIf = func->body->cast<wasm::If>();
  EXPECT_TRUE(outerIf->ifTrue->cast<wasm::Call>()->isReturn);
  ASSERT_TRUE(outerIf->ifFalse->is<wasm::If>());
  wasm::If *const innerIf = outerIf->ifFalse->cast<wasm::If>();
  EXPECT_TRUE(innerIf->ifTrue->cast<wasm::Call>()->isReturn);
  EXPECT_TRUE(innerIf->ifFalse->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsTailCallInLoopBody) {
  auto m = loadWat(R"(
    (module
      (func $foo (result i32) (i32.const 1))
      (func $baz (param $0 i32) (result i32)
        (loop $loop (result i32)
          local.get $0
          if (result i32)
            call $foo
          else
            br $loop
          end
        )
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Loop>());
  wasm::Loop *const loop = func->body->cast<wasm::Loop>();
  ASSERT_TRUE(loop->body->is<wasm::If>());
  wasm::If *const ifExpr = loop->body->cast<wasm::If>();
  EXPECT_TRUE(ifExpr->ifTrue->cast<wasm::Call>()->isReturn);
  EXPECT_TRUE(ifExpr->ifFalse->is<wasm::Break>());
}

TEST(TailCallOptimizerTest, KeepsNonTailBreakCall) {
  auto m = loadWat(R"(
    (module
      (func $foo (result i32) (i32.const 1))
      (func $baz (param $0 i32) (result i32)
        (i32.add
          (block $b (result i32)
            (if
              (local.get $0)
              (then
                (br $b (call $foo))
              )
            )
            (i32.const 0)
          )
          (i32.const 1)
        )
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("baz");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Binary>());
  wasm::Binary *const binary = func->body->cast<wasm::Binary>();
  ASSERT_TRUE(binary->left->is<wasm::Block>());
  wasm::Block *const block = binary->left->cast<wasm::Block>();
  ASSERT_TRUE(block->list[0]->is<wasm::If>());
  wasm::If *const ifExpr = block->list[0]->cast<wasm::If>();
  ASSERT_TRUE(ifExpr->ifTrue->is<wasm::Break>());
  wasm::Break *const br = ifExpr->ifTrue->cast<wasm::Break>();
  ASSERT_TRUE(br->value->is<wasm::Call>());
  EXPECT_FALSE(br->value->cast<wasm::Call>()->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsCallAndBreakTargetingOutermostBlock) {
  auto m = loadWat(R"(
    (module
      (func $target_inner (result i32) (i32.const 1))
      (func $target_outer (result i32) (i32.const 2))
      (func $fallback (result i32) (i32.const 3))
      (func $caller (param $cond1 i32) (param $cond2 i32) (result i32)
        (block $outer (result i32)
          (block $inner (result i32)
            (if
              (local.get $cond1)
              (then
                ;; Breaking to inner block is not tail position -> keeps normal call
                (br $inner (call $target_inner))
              )
            )
            (if
              (local.get $cond2)
              (then
                ;; Call followed by break directly to outermost block -> converted to return_call
                (br $outer (call $target_outer))
              )
            )
            (call $fallback)
          )
          (i32.const 10)
          (i32.add)
        )
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  // Find call expressions in caller
  struct CallFinder : public wasm::PostWalker<CallFinder> {
    wasm::Call *innerCall = nullptr;
    wasm::Call *outerCall = nullptr;
    wasm::Call *fallbackCall = nullptr;
    void visitCall(wasm::Call *curr) {
      if (curr->target == "target_inner")
        innerCall = curr;
      else if (curr->target == "target_outer")
        outerCall = curr;
      else if (curr->target == "fallback")
        fallbackCall = curr;
    }
  } finder;
  finder.walk(func->body);

  ASSERT_NE(finder.innerCall, nullptr);
  EXPECT_FALSE(finder.innerCall->isReturn);

  ASSERT_NE(finder.outerCall, nullptr);
  EXPECT_TRUE(finder.outerCall->isReturn);

  ASSERT_NE(finder.fallbackCall, nullptr);
  EXPECT_FALSE(finder.fallbackCall->isReturn);
}

TEST(TailCallOptimizerTest, ConvertsVoidCallFollowedByBreakToOutermostBlock) {
  auto m = loadWat(R"(
    (module
      (func $callee)
      (func $fallback)
      (func $caller (param $cond i32)
        (block $outer
          (if
            (local.get $cond)
            (then
              call $callee
              br $outer
            )
          )
          call $fallback
        )
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  struct CallFinder : public wasm::PostWalker<CallFinder> {
    wasm::Call *calleeCall = nullptr;
    wasm::Call *fallbackCall = nullptr;
    void visitCall(wasm::Call *curr) {
      if (curr->target == "callee")
        calleeCall = curr;
      else if (curr->target == "fallback")
        fallbackCall = curr;
    }
  } finder;
  finder.walk(func->body);

  ASSERT_NE(finder.calleeCall, nullptr);
  EXPECT_TRUE(finder.calleeCall->isReturn);

  ASSERT_NE(finder.fallbackCall, nullptr);
  EXPECT_TRUE(finder.fallbackCall->isReturn);
}

TEST(TailCallOptimizerTest, PreservesReturnWrappingIfWithNonCallBranch) {
  auto m = loadWat(R"(
    (module
      (func $foo (result i32) (i32.const 2))
      (func $caller (param $cond i32) (result i32)
        (return
          (if (result i32)
            (local.get $cond)
            (then
              (i32.const 1)
            )
            (else
              (call $foo)
            )
          )
        )
      )
    )
  )");
  m->features.setTailCall();
  wasm::Function *const func = m->getFunction("caller");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createTailCallOptimizerPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Return>());
  wasm::Return *const ret = func->body->cast<wasm::Return>();
  ASSERT_TRUE(ret->value->is<wasm::If>());
  wasm::If *const ifExpr = ret->value->cast<wasm::If>();
  ASSERT_TRUE(ifExpr->ifFalse->is<wasm::Call>());
  EXPECT_TRUE(ifExpr->ifFalse->cast<wasm::Call>()->isReturn);
}

} // namespace warpo::passes::ut

#endif
