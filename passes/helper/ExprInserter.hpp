// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "wasm-builder.h"
#include "wasm.h"

namespace warpo::passes {

/// @brief insert expr before / after another expr.
/// The expr here means WASM opcode instead of binaryen IR level expr.
class ExprInserter {
  wasm::Function *func_;

public:
  explicit ExprInserter(wasm::Function *func) : func_(func) {}

  bool canInsertBefore(wasm::Expression *insertPosition);
  /// @note when insertPosition is a terminator, it will insert before terminator
  bool canInsertAfter(wasm::Expression *insertPosition);
  void insertBefore(wasm::Builder &b, wasm::Expression *insertedExpr, wasm::Expression **insertPositionPtr);
  void insertAfter(wasm::Builder &b, wasm::Expression *insertedExpr, wasm::Expression **insertPositionPtr);
};

} // namespace warpo::passes
