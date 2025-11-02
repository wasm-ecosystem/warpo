// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>
#include <utility>

#include "src/WasmModule/WasmModule.hpp"
#include "src/utils/STDCompilerLogger.hpp"

namespace warpo {

uint8_t const *stackTop();

class WarpRunner {
  vb::STDCompilerLogger logger_;
  vb::WasmModule instance_;

public:
  explicit WarpRunner(void *const ctx);

  vb::WasmModule *getInstance() { return &instance_; }
  vb::WasmModule const *getInstance() const { return &instance_; }
  vb::STDCompilerLogger &getLogger() { return logger_; }
  void printStacktrace() { instance_.printStacktrace(logger_); }

  static uint32_t allocObject(vb::WasmModule *instance, int32_t rtId, int32_t size);
  static uint32_t allocString(vb::WasmModule *instance, std::string_view str);
  static std::string getString(vb::WasmModule const *instance, uint32_t ptr);

  uint32_t allocString(std::string_view str) { return allocString(getInstance(), str); }
  std::string getString(uint32_t ptr) const { return getString(getInstance(), ptr); }

  void start() { instance_.start(stackTop()); }

  template <size_t NumReturnValue, typename... FunctionArguments>
  std::array<vb::WasmValue, NumReturnValue> callExportedFunctionWithName(const char *const functionName,
                                                                         FunctionArguments... args) {
    return instance_.callExportedFunctionWithName<NumReturnValue, FunctionArguments...>(
        stackTop(), functionName, std::forward<FunctionArguments>(args)...);
  }

  void initFromBytecode(vb::Span<uint8_t const> const &bytecode,
                        vb::Span<vb::NativeSymbol const> const &linkedFunctions, bool const allowUnknownImports) {
    instance_.initFromBytecode(bytecode, linkedFunctions, allowUnknownImports);
  }

  vb::WasmModule::CompileResult compile(vb::Span<uint8_t const> const &bytecode,
                                        vb::Span<vb::NativeSymbol const> const &linkedFunctions) {
    return instance_.compile(bytecode, linkedFunctions);
  }
  void initFromCompiledBinary(vb::Span<const uint8_t> const &compiledBinary,
                              vb::Span<vb::NativeSymbol const> const &linkedFunctions,
                              vb::Span<uint8_t const> const &rawDebugSymbol) {
    instance_.initFromCompiledBinary(compiledBinary, linkedFunctions, rawDebugSymbol);
  }
};

} // namespace warpo
