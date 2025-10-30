// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>

#include "src/WasmModule/WasmModule.hpp"
#include "src/utils/STDCompilerLogger.hpp"

class WarpRunner {
  vb::STDCompilerLogger logger;
  uint8_t const *stackTop;
  vb::WasmModule m;

public:
  explicit WarpRunner(void *const ctx);

  vb::WasmModule *operator->() { return &m; }
  uint8_t const *getStackTop() const { return stackTop; }
  vb::STDCompilerLogger &getLogger() { return logger; }
  void printStacktrace() { m.printStacktrace(logger); }
};
