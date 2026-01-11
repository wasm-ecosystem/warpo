// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <filesystem>
#include <map>
#include <optional>
#include <string>
#include <vector>

namespace warpo::common {

struct UsesOption : std::map<std::string, std::string> {
  UsesOption() = default;
  void merge(std::string const &useStr);
  using std::map<std::string, std::string>::insert_or_assign;
};

struct FileConfigOptions {
  std::optional<std::filesystem::path> outFile = std::nullopt;
  std::optional<std::string> exportStart = std::nullopt;
  std::optional<bool> exportRuntime = std::nullopt;
  std::optional<bool> exportTable = std::nullopt;
  std::optional<uint32_t> initialMemory = std::nullopt;
  std::optional<std::string> runtime = std::nullopt;
  std::optional<uint32_t> optimizeLevel = std::nullopt;
  std::optional<uint32_t> shrinkLevel = std::nullopt;
  std::optional<bool> debug = std::nullopt;
  std::optional<bool> sourceMap = std::nullopt;
  std::optional<UsesOption> use = std::nullopt;

  void dump() const;
};

struct MergedFileConfig {
  std::vector<std::string> entries;
  FileConfigOptions options;
};

std::optional<MergedFileConfig> const &getFileConfig();

} // namespace warpo::common
