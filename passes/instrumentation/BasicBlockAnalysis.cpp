// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "BasicBlockAnalysis.hpp"

namespace warpo::passes::instrumentation {

bool BasicBlockAnalysis::shouldIncludeFile(std::string_view fileName) const noexcept {
  bool shouldInclude = false;
  bool shouldExclude = false;
  if (includes.size() == 0) {
    shouldInclude = true;
  } else {
    for (const auto &include : includes) {
      if (std::regex_match(fileName.begin(), fileName.end(), include)) {
        shouldInclude = true;
        break;
      }
    }
  }

  for (const auto &exclude : this->excludes) {
    if (std::regex_match(fileName.begin(), fileName.end(), exclude)) {
      shouldExclude = true;
    }
  }
  return (shouldInclude && (!shouldExclude));
}

} // namespace warpo::passes::instrumentation
