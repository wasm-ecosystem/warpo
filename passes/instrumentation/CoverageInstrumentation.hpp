// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <binaryen-c.h>
#include <wasm.h>

namespace warpo::passes::instrumentation {

struct CoverageInstrumentationConfig final {
  bool skipLib = true; ///< if skip lib functions
};

void runCoverageInstrumentation(wasm::Module &module);

} // namespace warpo::passes::instrumentation
