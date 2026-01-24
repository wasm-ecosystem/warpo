// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"

namespace warpo::passes {

// Combine Switch (br_table) targets when their case bodies are identical.
wasm::Pass *createCombineSwitchTargetsPass();

} // namespace warpo::passes
