// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <binaryen/src/binaryen-c.h>
#include <regex>
#include <string>

namespace warpo::passes {

std::string runOnWatForTest(std::string const &input, std::regex const &targetFunctionRegex);

} // namespace warpo::passes
