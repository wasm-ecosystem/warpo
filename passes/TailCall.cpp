// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "TailCall.hpp"
#include "pass.h"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {
namespace {

// A minimal tail-call optimization pass.
//
// It does NOT perform any control-flow analysis.  It only rewrites the following
// local patterns into Binaryen's return_call / return_call_indirect form:
//
//   1. An adjacent void "call; return" pair inside a block.
//   2. A call that is the last expression of a function body (implicit return).
//   3. A "return (call ...)" where the return's value is produced directly by
//      the call.
//
// Patterns that require CFG/try-catch/loop analysis are intentionally left for
// future, more advanced passes.
struct TailCallOptimizer : public wasm::WalkerPass<wasm::PostWalker<TailCallOptimizer>> {
  bool modifiesBinaryenIR() override { return true; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<TailCallOptimizer>(); }

  bool tryConvertExpressionToReturnCall(wasm::Expression *expr, wasm::Module *m, wasm::Function *func) {
    if (auto *call = expr->dynCast<wasm::Call>()) {
      if (call->isReturn || m->getFunction(call->target)->getResults() != func->getResults())
        return false;
      call->isReturn = true;
      call->finalize();
      return true;
    }

    if (auto *call = expr->dynCast<wasm::CallIndirect>()) {
      if (call->isReturn || call->type != func->getResults())
        return false;
      call->isReturn = true;
      call->finalize();
      return true;
    }

    return false;
  }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override {
    // Step 1: Walk all blocks in this function. Any explicit `call; return`
    // pair is safe to fold because the return proves the call is in tail
    // position, even when the pair is inside a nested block.
    wasm::WalkerPass<wasm::PostWalker<TailCallOptimizer>>::runOnFunction(m, func);

    // Step 2: Check the function-level implicit-return case.
    wasm::Expression *tail = func->body;
    wasm::Block *const block = func->body->dynCast<wasm::Block>();
    if (block != nullptr && !block->list.empty())
      tail = block->list.back();

    bool const converted = tryConvertExpressionToReturnCall(tail, m, func);
    if (converted && block != nullptr)
      block->finalize();
  }

  void visitBlock(wasm::Block *curr) {
    if (curr->list.size() < 2U)
      return;

    wasm::Return *const returnExpr = curr->list.back()->dynCast<wasm::Return>();
    wasm::Expression *const call = curr->list[curr->list.size() - 2U];
    if (returnExpr == nullptr || returnExpr->value != nullptr)
      return;

    bool const converted = tryConvertExpressionToReturnCall(call, getModule(), getFunction());
    if (!converted)
      return;

    curr->list.pop_back();
    curr->finalize();
  }

  void visitReturn(wasm::Return *curr) {
    if (curr->value != nullptr && tryConvertExpressionToReturnCall(curr->value, getModule(), getFunction()))
      replaceCurrent(curr->value);
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

} // namespace warpo::passes::ut

#endif
