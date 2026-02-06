// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "BasicBlockWalker.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"
namespace warpo::passes::instrumentation {
///
/// @brief Post walker for instrumentation purpose
///
class CovInstrumentationWalker final
    : public wasm::PostWalker<CovInstrumentationWalker,
                              wasm::UnifiedExpressionVisitor<CovInstrumentationWalker, void>> {
public:
  CovInstrumentationWalker(wasm::Module *const m, BasicBlockWalker &_basicBlockWalker) noexcept
      : m(m), b(wasm::Builder(*m)), basicBlockWalker(_basicBlockWalker) {}

  void visitFunction(wasm::Function *const curr) noexcept;

  void visitExpression(wasm::Expression *const curr) noexcept;

  void covWalk() noexcept;

private:
  wasm::Module *const m;                    ///< working wasm module
  wasm::Builder b;                          ///< module build for create wasm reference
  const BasicBlockWalker &basicBlockWalker; ///< basic block walker for instrument
  ///
  /// @brief introduce the trace report function, if customer does not config report function, use a
  /// default one
  ///
  void introduceReportFun() noexcept;
};
} // namespace warpo::passes::instrumentation
