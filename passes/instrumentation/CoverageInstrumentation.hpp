// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <binaryen-c.h>
#include <string>
#include <wasm.h>

namespace warpo::passes::instrumentation {

struct CoverageInstrumentationConfig final {
  std::string reportFunction; ///< coverage report function name
  bool skipLib = true;        ///< if skip lib functions
};

void runCoverageInstrumentation(wasm::Module &module);

} // namespace warpo::passes::instrumentation
