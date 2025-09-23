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

inline wasm::Expression **findExprPointer(wasm::Expression *expr, wasm::Function *func) {
  FindExpr finder{expr};
  finder.walk(func->body);
  return finder.ptr_;
}

} // namespace warpo::passes