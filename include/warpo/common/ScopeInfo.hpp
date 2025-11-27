// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once
#include <binaryen-c.h>
#include <optional>

namespace warpo {

class ScopeInfo final {

public:
  inline ScopeInfo(BinaryenExpressionRef const startExpr, BinaryenExpressionRef const endExpr) noexcept
      : scopeStartSubTreeRoot_(startExpr), scopeEndSubTreeRoot_(endExpr) {}

  BinaryenExpressionRef getFirstExpr() const noexcept;
  BinaryenExpressionRef getLastExpr() const noexcept;

private:
  static BinaryenExpressionRef findFirstInstruction(BinaryenExpressionRef const expr) noexcept;
  static BinaryenExpressionRef findLastInstruction(BinaryenExpressionRef const expr) noexcept;

  BinaryenExpressionRef scopeStartSubTreeRoot_;
  BinaryenExpressionRef scopeEndSubTreeRoot_;
  mutable std::optional<BinaryenExpressionRef> firstExpr_;
  mutable std::optional<BinaryenExpressionRef> lastExpr_;
};
} // namespace warpo