// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"

namespace warpo::passes {

void optimizeConditionalReturns(wasm::Module *m, wasm::Function *func);
wasm::Pass *createConditionalReturnPass();

} // namespace warpo::passes
