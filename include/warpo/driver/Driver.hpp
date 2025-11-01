// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <filesystem>
namespace warpo::driver {

void build();
void build(std::filesystem::path const &outputPath);

} // namespace warpo::driver
