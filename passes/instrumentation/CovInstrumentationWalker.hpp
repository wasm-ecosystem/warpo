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
  ///
  /// @brief Constructor for CovInstrumentationWalker
  ///
  /// @param _module
  /// @param _reportFunName
  /// @param _basicBlockWalker
  CovInstrumentationWalker(wasm::Module *const _module, char const *const _reportFunName,
                           BasicBlockWalker &_basicBlockWalker) noexcept
      : module(_module), reportFunName(_reportFunName), moduleBuilder(wasm::Builder(*_module)),
        basicBlockWalker(_basicBlockWalker) {}
  CovInstrumentationWalker(const CovInstrumentationWalker &src) = delete;
  CovInstrumentationWalker(CovInstrumentationWalker &&src) = delete;
  CovInstrumentationWalker &operator=(const CovInstrumentationWalker &) = delete;
  CovInstrumentationWalker &operator=(CovInstrumentationWalker &&) = delete;

  ///
  /// @brief Destructor for CovInstrumentationWalker
  ///
  ~CovInstrumentationWalker() noexcept = default;
  ///
  /// @brief walk function
  ///
  /// @param curr current function reference
  void visitFunction(wasm::Function *const curr) noexcept;

  ///
  /// @brief walk expression
  ///
  /// @param curr current expression reference
  void visitExpression(wasm::Expression *const curr) noexcept;

  ///
  /// @brief walk module
  ///
  void covWalk() noexcept;

private:
  wasm::Module *const module;               ///< working wasm module
  char const *const reportFunName;          ///< trace report function name
  wasm::Builder moduleBuilder;              ///< module build for create wasm reference
  const BasicBlockWalker &basicBlockWalker; ///< basic block walker for instrument
  ///
  /// @brief introduce the trace report function, if customer does not config report function, use a
  /// default one
  ///
  void introduceReportFun() noexcept;
};
} // namespace warpo::passes::instrumentation
