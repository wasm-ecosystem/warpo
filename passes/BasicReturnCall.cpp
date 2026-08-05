// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <iterator>

#include "BasicReturnCall.hpp"
#include "pass.h"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {
namespace {

struct BasicReturnCall : public wasm::WalkerPass<wasm::PostWalker<BasicReturnCall>> {
  bool modifiesBinaryenIR() override { return true; }

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

  void run(wasm::Module *m) override {
    m->features.setTailCall();
    for (std::unique_ptr<wasm::Function> const &func : m->functions) {
      if (func->imported() || func->body == nullptr)
        continue;
      runOnFunction(m, func.get());
    }
  }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override {
    // Step 1: Walk all blocks in this function. Any explicit `call; return`
    // pair is safe to fold because the return proves the call is in tail
    // position, even when the pair is inside a nested block.
    wasm::WalkerPass<wasm::PostWalker<BasicReturnCall>>::runOnFunction(m, func);

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
    // This handles only adjacent explicit returns. A block's last expression may
    // be inside a nested block, so implicit function-tail calls are handled in
    // runOnFunction instead.
    for (auto it = curr->list.begin(); it != curr->list.end();) {
      auto next = std::next(it);
      if (next == curr->list.end())
        break;

      wasm::Return *const returnExpr = (*next)->dynCast<wasm::Return>();
      if (returnExpr == nullptr || returnExpr->value != nullptr) {
        it = next;
        continue;
      }

      bool const converted = tryConvertExpressionToReturnCall(*it, getModule(), getFunction());
      if (!converted) {
        it = next;
        continue;
      }

      curr->list.erase(next);
      ++it;
    }
    curr->finalize();
  }
};

} // namespace
} // namespace warpo::passes

wasm::Pass *warpo::passes::createBasicReturnCallPass() { return new BasicReturnCall(); }

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>
#include <memory>

#include "Runner.hpp"
#include "helper/Matcher.hpp"

namespace warpo::passes::ut {

TEST(BasicReturnCallTest, ConvertsDirectCallFollowedByReturn) {
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
  runner.add(std::unique_ptr<wasm::Pass>{createBasicReturnCallPass()});
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

TEST(BasicReturnCallTest, ConvertsFinalDirectCallInVoidFunctionBody) {
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
  runner.add(std::unique_ptr<wasm::Pass>{createBasicReturnCallPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Call>());
  wasm::Call *const call = func->body->cast<wasm::Call>();
  EXPECT_EQ(call->target, "callee");
  EXPECT_TRUE(call->isReturn);
  EXPECT_TRUE(call->type == wasm::Type::unreachable);
}

TEST(BasicReturnCallTest, ConvertsIndirectCallFollowedByReturn) {
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
  runner.add(std::unique_ptr<wasm::Pass>{createBasicReturnCallPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::Block>());
  wasm::Block *const block = func->body->cast<wasm::Block>();
  ASSERT_EQ(block->list.size(), 1U);
  ASSERT_TRUE(block->list.back()->is<wasm::CallIndirect>());
  wasm::CallIndirect *const call = block->list.back()->cast<wasm::CallIndirect>();
  EXPECT_TRUE(call->isReturn);
  EXPECT_TRUE(call->type == wasm::Type::unreachable);
}

TEST(BasicReturnCallTest, ConvertsFinalIndirectCallInFunctionBody) {
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
  runner.add(std::unique_ptr<wasm::Pass>{createBasicReturnCallPass()});
  runner.run();

  ASSERT_TRUE(func->body->is<wasm::CallIndirect>());
  wasm::CallIndirect *const call = func->body->cast<wasm::CallIndirect>();
  EXPECT_TRUE(call->isReturn);
  EXPECT_TRUE(call->type == wasm::Type::unreachable);
}

TEST(BasicReturnCallTest, KeepsNonTailCall) {
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
  runner.add(std::unique_ptr<wasm::Pass>{createBasicReturnCallPass()});
  runner.run();

  using namespace matcher;
  auto const match = isBlock(block::has(3U), block::at(0U, isCall(call::callee("callee"))), block::at(1U, isNop()),
                             block::at(2U, isReturn()));
  isMatched(match, func->body);
  EXPECT_FALSE(func->body->cast<wasm::Block>()->list[0]->cast<wasm::Call>()->isReturn);
}

} // namespace warpo::passes::ut

#endif