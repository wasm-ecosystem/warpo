// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <array>

#include "CovInstrumentationWalker.hpp"
#include "Name.hpp"
#include "binaryen-c.h"
#include "ir/module-utils.h"

namespace warpo::passes::instrumentation {

void CovInstrumentationWalker::visitFunction(wasm::Function *const curr) noexcept {
  using Parent =
      wasm::PostWalker<CovInstrumentationWalker, wasm::UnifiedExpressionVisitor<CovInstrumentationWalker, void>>;
  Parent::visitFunction(curr);

  const wasm::Index functionIndex = basicBlockWalker.getFunctionIndexByName(curr->name.str);
  // function in instruction
  if (functionIndex != static_cast<wasm::Index>(-1)) {
    const std::array<BinaryenExpressionRef, 3U> callInReportArgs = {
        b.makeConst(functionIndex), b.makeConst(static_cast<wasm::Index>(-1)), b.makeConst(1U)};
    wasm::Call *const callIn = b.makeCall(traceInternalFunctionName, callInReportArgs, wasm::Type::none);

    wasm::Block *const newBody = b.makeBlock();
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
      wasm::Block *replacement = b.makeBlock();
      const wasm::Index functionIndex = basicBlockWalker.getFunctionIndexByName(func->name.str);
      const std::array<BinaryenExpressionRef, 3U> reportArgs = {b.makeConst(functionIndex),
                                                                b.makeConst(position.basicBlockIndex), b.makeConst(0U)};
      wasm::Expression *const report = b.makeCall(traceInternalFunctionName, reportArgs, wasm::Type::none);
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
      wasm::Block *const replacement = b.makeBlock();
      std::array<BinaryenExpressionRef, 3U> const callOutReportArgs = {
          b.makeConst(targetFunctionIndex), b.makeConst(static_cast<wasm::Index>(-1)), b.makeConst(2U)};
      wasm::Expression *const callOut = b.makeCall(traceInternalFunctionName, callOutReportArgs, wasm::Type::none);
      wasm::Expression **const replacePtr = getCurrentPointer();
      replacement->list.push_back(*replacePtr);
      replacement->list.push_back(callOut);
      replacement->finalize(curr->type);
      *replacePtr = replacement;
    }
  }
}

void CovInstrumentationWalker::covWalk() noexcept {
  if (m->getFunctionOrNull(traceInternalFunctionName) == nullptr) {
    wasm::Builder const builder(*m);
    std::array<BinaryenType, 3U> iii_{BinaryenTypeInt32(), BinaryenTypeInt32(), BinaryenTypeInt32()};
    const BinaryenType iii = BinaryenTypeCreate(iii_.data(), iii_.size());
    BinaryenAddFunctionImport(m, traceInternalFunctionName, unittestFrameworkEnvModuleName, traceFunctionName, iii,
                              wasm::Type::none);
  }
  wasm::ModuleUtils::iterDefinedFunctions(*m, [this](const BinaryenFunctionRef &func) noexcept {
    if (basicBlockWalker.getBasicBlockAnalysis().shouldIncludeFile(func->name.str)) {
      walkFunctionInModule(func, this->m);
    }
  });
}

} // namespace warpo::passes::instrumentation

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "../Runner.hpp"
#include "../helper/Matcher.hpp"

namespace warpo::passes::instrumentation::ut {

TEST(CovInstrumentationWalkerTest, InstrumentsFunctionAndCall) {
  auto m = loadWat(R"(
    (module
      (func $callee
        nop
      )
      (func $caller
        call $callee
      )
    )
  )");

  wasm::Function *const callee = m->getFunction("callee");
  wasm::Function *const caller = m->getFunction("caller");

  wasm::Function::DebugLocation loc{};
  loc.fileIndex = 0;
  loc.lineNumber = 1;
  loc.columnNumber = 1;
  callee->debugLocations.emplace(callee->body, loc);
  caller->debugLocations.emplace(caller->body, loc);

  BasicBlockAnalysis basicBlockAnalysis{};
  BasicBlockWalker basicBlockWalker(m.get(), basicBlockAnalysis);
  basicBlockWalker.basicBlockWalk();

  CovInstrumentationWalker covWalker(m.get(), basicBlockWalker);
  covWalker.covWalk();

  EXPECT_NE(m->getFunctionOrNull(traceInternalFunctionName), nullptr);

  using namespace matcher;
  auto traceCall = []() {
    return isCall(call::callee(traceInternalFunctionName),
                  call::operands(allOf({has(3), at(0, isConst()), at(1, isConst()), at(2, isConst())})));
  };
  auto callWithBasicBlock = [&]() {
    return isBlock(block::list(allOf({
        has(2),
        at(0, isCall(call::callee("callee"))),
        at(1, traceCall()),
    })));
  };
  auto innerBlock = [&]() {
    return isBlock(block::list(allOf({
        has(2),
        at(0, callWithBasicBlock()),
        at(1, traceCall()),
    })));
  };
  auto match = isBlock(block::list(allOf({
      has(2),
      at(0, traceCall()),
      at(1, innerBlock()),
  })));
  isMatched(match, caller->body);
}

} // namespace warpo::passes::instrumentation::ut

#endif
