// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <binaryen/src/binaryen-c.h>
#include <cstdint>
#include <filesystem>
#include <string>
#include <vector>

#include "warpo/common/AsModule.hpp"

namespace warpo::passes {

struct Output {
  std::string wat;
  std::vector<uint8_t> wasm;
  std::string sourceMap;
};

struct Config {
  uint32_t optimizeLevel;
  uint32_t shrinkLevel;
  std::string sourceMapURL;
};

void init();

Output runOnWat(std::string const &input, Config const &config);

Output runOnModule(AsModule const &m);
Output runOnModule(AsModule const &m, Config const &config);

void runAndEmit(AsModule const &m, std::filesystem::path const &outputPath);
void runAndEmit(std::string const &inputPath, std::filesystem::path const &outputPath);

} // namespace warpo::passes
