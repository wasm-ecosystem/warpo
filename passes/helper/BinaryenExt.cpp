// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>

#include "BinaryenExt.hpp"
#include "ir/iteration.h"
#include "ir/properties.h"
#include "warpo/common/ScopeInfo.hpp"

namespace warpo::passes {

static bool shouldSkipExpression(wasm::Expression *expr) noexcept { return expr->is<wasm::Block>(); }

wasm::Expression *findFirstInstruction(wasm::Expression *expr) noexcept {
  assert(expr);

  wasm::ChildIterator iter(expr);
  wasm::Index const numChildren = iter.getNumChildren();

  if (numChildren == 0U) {
    return expr;
  }

  for (wasm::Index i = 0U; i < numChildren; i++) {
    wasm::Expression *const child = iter.getChild(i);
    wasm::Expression *const result = findFirstInstruction(child);
    if (!shouldSkipExpression(result)) {
      return result;
    }
  }

  return expr;
}

wasm::Expression *findLastInstruction(wasm::Expression *expr) noexcept {
  assert(expr);

  // For control flow structures (Block, If, Loop), the last instruction is in the last child.
  // For other expressions (Binary, Unary, Call, etc.), the expression itself is the last instruction.
  if (!wasm::Properties::isControlFlowStructure(expr)) {
    return expr;
  }

  wasm::ChildIterator iter(expr);
  wasm::Index const numChildren = iter.getNumChildren();
  if (numChildren == 0U) {
    return expr;
  }

  for (wasm::Index i = numChildren; i > 0; i--) {
    wasm::Expression *const child = iter.getChild(i - 1U);
    wasm::Expression *const result = findLastInstruction(child);
    if (!shouldSkipExpression(result)) {
      return result;
    }
  }

  return expr;
}

wasm::BinaryLocations::Span
getRangeOfScope(warpo::ScopeInfo const &scopeInfo,
                std::unordered_map<wasm::Expression *, uint32_t> const &exprLocationMap) noexcept {
  wasm::BinaryLocations::Span span{0, 0};

  wasm::Expression *const startExpr = scopeInfo.getScopeStartSubTreeRoot();
  assert(startExpr != nullptr);
  wasm::Expression *const firstExpr = findFirstInstruction(startExpr);
  if (firstExpr != nullptr && exprLocationMap.contains(firstExpr)) {
    span.start = exprLocationMap.at(firstExpr);
  }

  wasm::Expression *const endExpr = scopeInfo.getScopeEndSubTreeRoot();
  assert(endExpr != nullptr);
  wasm::Expression *const lastExpr = findLastInstruction(endExpr);
  if (lastExpr != nullptr && exprLocationMap.contains(lastExpr)) {
    span.end = exprLocationMap.at(lastExpr);
  }

  return span;
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "wasm-builder.h"
#include "wasm.h"

namespace warpo::passes::ut {

TEST(TestBinaryenExt, TestFindInstructionsWithBlocks) {
  // Build a real Binaryen expression tree:
  // block { i32.const 1 + i32.const 2 }  and  block { i32.const 3 - i32.const 4 }
  wasm::Module module;
  wasm::Builder builder(module);

  wasm::Expression *const const1 = builder.makeConst(wasm::Literal(1));
  wasm::Expression *const const2 = builder.makeConst(wasm::Literal(2));
  wasm::Expression *const add = builder.makeBinary(wasm::BinaryOp::AddInt32, const1, const2);
  wasm::Expression *const blockAdd = builder.makeBlock({add});

  wasm::Expression *const const3 = builder.makeConst(wasm::Literal(3));
  wasm::Expression *const const4 = builder.makeConst(wasm::Literal(4));
  wasm::Expression *const sub = builder.makeBinary(wasm::BinaryOp::SubInt32, const3, const4);
  wasm::Expression *const blockSub = builder.makeBlock({sub});

  EXPECT_EQ(findFirstInstruction(blockAdd), const1);
  EXPECT_EQ(findLastInstruction(blockSub), sub);
}

TEST(TestBinaryenExt, TestFindInstructionsWithEmptyBlocks) {
  // Build a real Binaryen expression tree with empty blocks:
  // block { block { block {} } (i32.const 1 + i32.const 2) }  and  block { (i32.const 3 - i32.const 4) block { block {}
  // } }
  wasm::Module module;
  wasm::Builder builder(module);

  wasm::Expression *const const1 = builder.makeConst(wasm::Literal(1));
  wasm::Expression *const const2 = builder.makeConst(wasm::Literal(2));
  wasm::Expression *const add = builder.makeBinary(wasm::BinaryOp::AddInt32, const1, const2);

  wasm::Expression *const emptyBlock1Inner = builder.makeBlock({});
  wasm::Expression *const emptyBlock1 = builder.makeBlock({emptyBlock1Inner});
  wasm::Expression *const blockAdd = builder.makeBlock({emptyBlock1, add});

  wasm::Expression *const const3 = builder.makeConst(wasm::Literal(3));
  wasm::Expression *const const4 = builder.makeConst(wasm::Literal(4));
  wasm::Expression *const sub = builder.makeBinary(wasm::BinaryOp::SubInt32, const3, const4);

  wasm::Expression *const emptyBlock2Inner = builder.makeBlock({});
  wasm::Expression *const emptyBlock2 = builder.makeBlock({emptyBlock2Inner});
  wasm::Expression *const blockSub = builder.makeBlock({sub, emptyBlock2});

  // Assert that findFirstInstruction and findLastInstruction skip nested empty blocks
  EXPECT_EQ(findFirstInstruction(blockAdd), const1);
  EXPECT_EQ(findLastInstruction(blockSub), sub);
}

} // namespace warpo::passes::ut

#endif
