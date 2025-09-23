// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <string>

#include "wasm.h"

namespace warpo::passes {

std::string toString(wasm::Expression *expr);
std::string toString(wasm::Function *f);

} // namespace warpo::passes
