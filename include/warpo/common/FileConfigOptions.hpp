// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <filesystem>
#include <optional>
#include <string>

#include "warpo/common/Features.hpp"
#include "warpo/common/UsesOption.hpp"

namespace warpo::common {

struct FileConfigOptions {
  std::optional<std::filesystem::path> project = std::nullopt;
  std::optional<std::filesystem::path> outFile = std::nullopt;
  std::optional<std::string> exportStart = std::nullopt;
  std::optional<bool> exportRuntime = std::nullopt;
  std::optional<bool> exportTable = std::nullopt;
  std::optional<uint32_t> initialMemory = std::nullopt;
  std::optional<uint32_t> stackSize = std::nullopt;
  std::optional<std::string> runtime = std::nullopt;
  std::optional<uint32_t> optimizeLevel = std::nullopt;
  std::optional<uint32_t> shrinkLevel = std::nullopt;
  std::optional<bool> debug = std::nullopt;
  std::optional<bool> sourceMap = std::nullopt;
  std::optional<UsesOption> use = std::nullopt;
  std::optional<Features> features = std::nullopt;
};
} // namespace warpo::common