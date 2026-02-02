// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <regex>
#include <string>
#include <string_view>
#include <vector>

namespace warpo::passes::instrumentation {

/// @brief Class for performing if file should be included.
///
class BasicBlockAnalysis final {
public:
  ///
  /// @brief Add exclude file to debug info analysis
  ///
  /// @param exclude
  inline void addExclude(std::string const &exclude) noexcept { excludes.emplace_back(exclude); }

  ///
  /// @brief If the debug file should be included into debug info analysis
  ///
  /// @param fileName
  /// @return Return true if the file should be included
  bool shouldIncludeFile(std::string_view fileName) const noexcept;

private:
  std::vector<std::regex> includes; ///< functions should be processed
  std::vector<std::regex> excludes; ///< functions should not be processed
};
} // namespace warpo::passes::instrumentation
