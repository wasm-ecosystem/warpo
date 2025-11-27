// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#include <cassert>

#include "ir/iteration.h"
#include "ir/properties.h"
#include "warpo/common/ScopeInfo.hpp"

namespace warpo {

bool ScopeInfo::shouldSkipExpression(BinaryenExpressionRef expr) noexcept { return expr->is<wasm::Block>(); }

BinaryenExpressionRef ScopeInfo::findFirstInstruction(BinaryenExpressionRef const expr) noexcept {
  assert(expr);

  wasm::ChildIterator iter(expr);
  wasm::Index const numChildren = iter.getNumChildren();

  if (numChildren == 0) {
    return expr;
  }

  for (wasm::Index i = 0; i < numChildren; i++) {
    wasm::Expression *child = iter.getChild(i);
    BinaryenExpressionRef result = findFirstInstruction(child);
    if (!shouldSkipExpression(result)) {
      return result;
    }
  }

  return expr;
}

BinaryenExpressionRef ScopeInfo::findLastInstruction(BinaryenExpressionRef const expr) noexcept {
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
    wasm::Expression *child = iter.getChild(i - 1U);
    BinaryenExpressionRef result = findLastInstruction(child);
    if (!shouldSkipExpression(result)) {
      return result;
    }
  }

  return expr;
}

BinaryenExpressionRef ScopeInfo::getFirstExpr() const noexcept {
  if (!firstExpr_) {
    firstExpr_ = findFirstInstruction(scopeStartSubTreeRoot_);
  }
  return *firstExpr_;
}

BinaryenExpressionRef ScopeInfo::getLastExpr() const noexcept {
  if (!lastExpr_) {
    lastExpr_ = findLastInstruction(scopeEndSubTreeRoot_);
  }
  return *lastExpr_;
}

} // namespace warpo
