// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <optional>
#include <string>
#include <vector>

namespace warpo::common {

struct FileConfigOptions {
  std::optional<std::string> exportStart = std::nullopt;
  std::optional<bool> exportRuntime = std::nullopt;
  std::optional<bool> exportTable = std::nullopt;
  std::optional<uint32_t> initialMemory = std::nullopt;
  std::optional<std::string> runtime = std::nullopt;
  std::optional<uint32_t> optimizeLevel = std::nullopt;
  std::optional<uint32_t> shrinkLevel = std::nullopt;
  std::optional<bool> debug = std::nullopt;
  std::optional<bool> sourceMap = std::nullopt;
  std::optional<std::string> use = std::nullopt;

  void dump() const;
};

struct MergedFileConfig {
  std::vector<std::string> entries;
  FileConfigOptions options;
};

std::optional<MergedFileConfig> getFileConfig();

} // namespace warpo::common
