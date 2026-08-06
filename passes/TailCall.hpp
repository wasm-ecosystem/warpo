// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <pass.h>

namespace warpo::passes {

wasm::Pass *createTailCallOptimizerPass();

} // namespace warpo::passes
