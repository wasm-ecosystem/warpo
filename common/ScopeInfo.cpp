// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#include <cassert>

#include "ir/iteration.h"
#include "ir/properties.h"
#include "warpo/common/ScopeInfo.hpp"

namespace warpo {

// Find the first instruction (leaf) in the expression subtree
BinaryenExpressionRef ScopeInfo::findFirstInstruction(BinaryenExpressionRef const expr) noexcept {
  assert(expr);

  wasm::ChildIterator iter(expr);
  wasm::Index const numChildren = iter.getNumChildren();
  if (numChildren == 0) {
    return expr;
  }

  wasm::Expression *const firstChild = iter.getChild(0);

  // Otherwise, recurse into the first child
  return findFirstInstruction(firstChild);
}

// Find the last instruction (leaf) in the expression subtree
BinaryenExpressionRef ScopeInfo::findLastInstruction(BinaryenExpressionRef const expr) noexcept {
  assert(expr);

  // For control flow structures (Block, If, Loop), the last instruction
  // is in the last child. For other expressions (Binary, Unary, Call, etc.),
  // the expression itself is the last instruction since it executes after its operands.
  if (!wasm::Properties::isControlFlowStructure(expr)) {
    // For non-container expressions, the expression itself is the last instruction
    return expr;
  }

  // For container expressions, recurse into the last child
  wasm::ChildIterator iter(expr);
  wasm::Index const numChildren = iter.getNumChildren();
  if (numChildren == 0) {
    return expr;
  }

  wasm::Expression *const lastChild = iter.getChild(numChildren - 1);
  return findLastInstruction(lastChild);
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
