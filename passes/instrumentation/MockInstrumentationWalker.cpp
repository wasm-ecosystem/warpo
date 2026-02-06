// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <array>
#include <binaryen-c.h>
#include <sstream>
#include <string_view>
#include <wasm-type.h>
#include <wasm.h>

#include "MockInstrumentationWalker.hpp"
#include "Name.hpp"

namespace warpo::passes::instrumentation {

void MockInstrumentationWalker::visitCall(wasm::Call *const curr) noexcept {
  /* generate expect infos */
  if (std::any_of(this->expectTestFuncNames.begin(), this->expectTestFuncNames.end(),
                  [&curr](std::string_view str) noexcept {
                    auto lastIndex = curr->target.str.find_last_of(">");
                    if (lastIndex != std::string_view::npos) {
                      return curr->target.str.substr(lastIndex + 1) == str;
                    }
                    return false;
                  })) {
    const auto &currDebugLocations = getFunction()->debugLocations;
    const auto currentDebugLocationIterator = currDebugLocations.find(curr);
    if (currentDebugLocationIterator != currDebugLocations.cend() && currentDebugLocationIterator->second) {
      const wasm::Function::DebugLocation &currDebugLocation = *(currentDebugLocationIterator->second);
      const std::string &fileName = m->debugInfoFileNames[currDebugLocation.fileIndex];
      std::stringstream expectInfo;
      expectInfo << fileName << ":" << currDebugLocation.lineNumber << ":" << currDebugLocation.columnNumber;
      expectInfos[expectIndex] = expectInfo.str();
    }
    curr->operands.back() = b.makeConst(wasm::Literal(expectIndex));
    expectIndex++;
  }

  /* Function Call Mock */
  const auto functionRefsIterator = funcRefs.find(curr->target.str);
  if (functionRefsIterator != funcRefs.end()) {
    const wasm::Index localIdx = wasm::Builder::addVar(getFunction(), wasm::Type::i32);
    const auto &[tableName, originFuncIdx] = functionRefsIterator->second;
    const std::array<wasm::Expression *, 2U> callArgs = {b.makeConst(originFuncIdx), b.makeConst(true)};
    wasm::If *const mockReplacement = b.makeIf(
        b.makeBinary(wasm::BinaryOp::NeInt32,
                     b.makeLocalTee(localIdx, b.makeCall(checkMockInternalFunctionName, callArgs, wasm::Type::i32),
                                    wasm::Type::i32),
                     b.makeConst(-1)),
        b.makeCallIndirect(tableName, b.makeLocalGet(localIdx, wasm::Type::i32), curr->operands,
                           getModule()->getFunction(curr->target)->type.getHeapType()),
        curr);
    replaceCurrent(mockReplacement);
  }
}

void MockInstrumentationWalker::visitCallIndirect(wasm::CallIndirect *const curr) noexcept {
  if (funcRefs.size() == 0U) {
    return;
  }
  const std::array<wasm::Expression *, 2U> args = {curr->target, b.makeConst(false)};
  curr->target = b.makeCall(checkMockInternalFunctionName, args, wasm::Type::i32);
}

void MockInstrumentationWalker::mockWalk() noexcept {
  std::array<BinaryenType, 2U> ii_ = std::array<BinaryenType, 2U>{BinaryenTypeInt32(), BinaryenTypeInt32()};
  const BinaryenType ii = BinaryenTypeCreate(ii_.data(), ii_.size());
  BinaryenAddFunctionImport(m, checkMockInternalFunctionName, unittestFrameworkEnvModuleName, checkMockFunctionName, ii,
                            BinaryenTypeInt32());
  wasm::ModuleUtils::iterDefinedFunctions(
      *m, [this](wasm::Function *const func) noexcept { walkFunctionInModule(func, this->m); });
}

} // namespace warpo::passes::instrumentation
