// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <vector>

#include "wasm.h"

namespace warpo::passes {

/// Represents an exit / return point of a function.
/// `expr` is the expression evaluated at this return point (e.g. Call, LocalGet, Const, etc.).
struct ReturnPoint {
  wasm::Expression *expr = nullptr;
};

/// Computes the return points of a function using CFG backward reachability.
/// Collects both explicit `return` and implicit/fallthrough return points.
std::vector<ReturnPoint> computeReturnPoints(wasm::Module *m, wasm::Function *func);

} // namespace warpo::passes
