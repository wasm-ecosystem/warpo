// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>
#include <filesystem>
#include <optional>
#include <string>
#include <vector>

#include "warpo/common/Features.hpp"
#include "warpo/common/FileConfigOptions.hpp"

namespace warpo::common {

class ConfigProvider final {
public:
  static ConfigProvider &instance();

  /// Returns config-file options with CLI overrides applied.
  FileConfigOptions mergedFrontendOptions();

  /// Returns entry paths merged from config-file and CLI positional args.
  std::vector<std::string> mergedEntryPaths();

  /// Returns output path merged from CLI (-o/--output) and config file (outFile).
  std::optional<std::filesystem::path> outputPath();

  Features features();
  uint32_t optimizationLevel();
  uint32_t shrinkLevel();
  bool isDebugEnabled();

private:
  ConfigProvider() = default;
};

} // namespace warpo::common
