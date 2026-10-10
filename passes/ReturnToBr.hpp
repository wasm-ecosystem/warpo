// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"

namespace warpo::passes {

void convertReturnsToBranches(wasm::Module *m, wasm::Function *func);

} // namespace warpo::passes