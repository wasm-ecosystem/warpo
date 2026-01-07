// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once
#include <binaryen-c.h>

namespace warpo {

class ScopeInfo final {

public:
  inline ScopeInfo(BinaryenExpressionRef const startExpr, BinaryenExpressionRef const endExpr) noexcept
      : scopeStartSubTreeRoot_(startExpr), scopeEndSubTreeRoot_(endExpr) {}

  inline BinaryenExpressionRef getScopeStartSubTreeRoot() const noexcept { return scopeStartSubTreeRoot_; }
  inline BinaryenExpressionRef getScopeEndSubTreeRoot() const noexcept { return scopeEndSubTreeRoot_; }

private:
  BinaryenExpressionRef scopeStartSubTreeRoot_;
  BinaryenExpressionRef scopeEndSubTreeRoot_;
};
} // namespace warpo