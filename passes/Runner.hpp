// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "wasm.h"

namespace warpo::passes {

std::unique_ptr<wasm::Module> loadWasm(const std::vector<char> &input);

std::unique_ptr<wasm::Module> loadWat(std::string_view wat);

} // namespace warpo::passes
