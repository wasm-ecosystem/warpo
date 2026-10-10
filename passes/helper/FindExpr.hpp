// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {

struct FindExpr : public wasm::PostWalker<FindExpr, wasm::UnifiedExpressionVisitor<FindExpr>> {
  wasm::Expression **ptr_ = nullptr;
  explicit FindExpr(wasm::Expression *expr) : expr_(expr) {}

  void visitExpression(wasm::Expression *curr) {
    if (curr == expr_) {
      ptr_ = getCurrentPointer();
    }
  }

private:
  wasm::Expression *expr_;
};

// Find expr by pointer identity and return its AST pointer slot, or nullptr if absent.
// Assigning through the returned pointer replaces that expression in the tree.
inline wasm::Expression **findExprPointer(wasm::Expression *expr, wasm::Expression *&root) {
  FindExpr finder{expr};
  finder.walk(root);
  return finder.ptr_;
}

inline wasm::Expression **findExprPointer(wasm::Expression *expr, wasm::Function *func) {
  return findExprPointer(expr, func->body);
}

} // namespace warpo::passes