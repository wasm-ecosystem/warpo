// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "pass.h"
#include "warpo/common/VariableInfo.hpp"

namespace warpo::passes {

wasm::Pass *createUnusedFieldStoreEliminatingPass(VariableInfo const *variableInfo = nullptr);

} // namespace warpo::passes