// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <array>

#include "CovInstrumentationWalker.hpp"
#include "binaryen-c.h"
#include "ir/module-utils.h"

namespace warpo::passes::instrumentation {
void CovInstrumentationWalker::introduceReportFun() noexcept {
  bool needImport = true;
  wasm::ModuleUtils::iterDefinedFunctions(*module, [this, &needImport](const BinaryenFunctionRef &func) noexcept {
    if (func->name == wasm::IString(this->reportFunName)) {
      // escape already declared function
      // LCOV_EXCL_START
      needImport = false;
      // LCOV_EXCL_STOP
    }
  });
  wasm::ModuleUtils::iterImportedFunctions(*module, [this, &needImport](const BinaryenFunctionRef &func) noexcept {
    if (func->name == wasm::IString(this->reportFunName)) {
      // escape already imported function
      // LCOV_EXCL_START
      needImport = false;
      // LCOV_EXCL_STOP
    }
  });
  if (needImport) {
    wasm::Builder const builder(*module);
    std::array<BinaryenType, 3U> iii_{BinaryenTypeInt32(), BinaryenTypeInt32(), BinaryenTypeInt32()};
    const BinaryenType iii = BinaryenTypeCreate(iii_.data(), iii_.size());
    BinaryenAddFunctionImport(module, reportFunName, "__unittest_framework_env", "traceExpression", iii,
                              wasm::Type::none);
  }
}

void CovInstrumentationWalker::visitFunction(wasm::Function *const curr) noexcept {
  using Parent =
      wasm::PostWalker<CovInstrumentationWalker, wasm::UnifiedExpressionVisitor<CovInstrumentationWalker, void>>;
  Parent::visitFunction(curr);

  const wasm::Index functionIndex = basicBlockWalker.getFunctionIndexByName(curr->name.str);
  // function in instruction
  if (functionIndex != static_cast<wasm::Index>(-1)) {
    const std::array<BinaryenExpressionRef, 3U> callInReportArgs = {
        moduleBuilder.makeConst(functionIndex), moduleBuilder.makeConst(static_cast<wasm::Index>(-1)),
        moduleBuilder.makeConst(1U)};
    wasm::Call *const callIn = moduleBuilder.makeCall(this->reportFunName, callInReportArgs, wasm::Type::none);

    wasm::Block *const newBody = moduleBuilder.makeBlock();
    newBody->list.push_back(callIn);
    newBody->list.push_back(curr->body);
    newBody->finalize(curr->body->type);
    curr->body = newBody;
  }
}

void CovInstrumentationWalker::visitExpression(wasm::Expression *curr) noexcept {
  BinaryenFunctionRef const func = getFunction();
  std::vector<InstrumentPosition> const *const positionIterator = basicBlockWalker.getCovInstrumentPosition(curr);
  if (positionIterator != nullptr) {
    for (const InstrumentPosition &position : *positionIterator) {
      wasm::Block *replacement = moduleBuilder.makeBlock();
      const wasm::Index functionIndex = basicBlockWalker.getFunctionIndexByName(func->name.str);
      const std::array<BinaryenExpressionRef, 3U> reportArgs = {moduleBuilder.makeConst(functionIndex),
                                                                moduleBuilder.makeConst(position.basicBlockIndex),
                                                                moduleBuilder.makeConst(0U)};
      wasm::Expression *const report = moduleBuilder.makeCall(reportFunName, reportArgs, wasm::Type::none);
      wasm::Expression **const replacePtr = getCurrentPointer();
      if (position.pre) {
        replacement->list.push_back(report);
        replacement->list.push_back(*replacePtr);
      } else {
        replacement->list.push_back(*replacePtr);
        replacement->list.push_back(report);
      }
      replacement->finalize(curr->type);
      *replacePtr = replacement;
    }
  }

  if (curr->is<wasm::Call>()) {
    // function out instrumentation
    wasm::Call *const call = curr->cast<wasm::Call>();
    const wasm::Index targetFunctionIndex = basicBlockWalker.getFunctionIndexByName(call->target.str);
    if (targetFunctionIndex != static_cast<wasm::Index>(-1)) {
      wasm::Block *const replacement = moduleBuilder.makeBlock();
      std::array<BinaryenExpressionRef, 3U> const callOutReportArgs = {
          moduleBuilder.makeConst(targetFunctionIndex), moduleBuilder.makeConst(static_cast<wasm::Index>(-1)),
          moduleBuilder.makeConst(2U)};
      wasm::Expression *const callOut = moduleBuilder.makeCall(reportFunName, callOutReportArgs, wasm::Type::none);
      wasm::Expression **const replacePtr = getCurrentPointer();
      replacement->list.push_back(*replacePtr);
      replacement->list.push_back(callOut);
      replacement->finalize(curr->type);
      *replacePtr = replacement;
    }
  }
}

void CovInstrumentationWalker::covWalk() noexcept {
  introduceReportFun();
  wasm::ModuleUtils::iterDefinedFunctions(*module, [this](const BinaryenFunctionRef &func) noexcept {
    if (basicBlockWalker.getBasicBlockAnalysis().shouldIncludeFile(func->name.str)) {
      walkFunctionInModule(func, this->module);
    }
  });
}

} // namespace warpo::passes::instrumentation
