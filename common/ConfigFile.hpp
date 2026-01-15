// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <optional>
#include <string>
#include <vector>

#include "warpo/common/FileConfigOptions.hpp"

namespace warpo::common {

struct MergedFileConfig {
  std::vector<std::string> entries;
  FileConfigOptions options;

  static std::optional<MergedFileConfig> const &getConfigFromFile();
};

} // namespace warpo::common
