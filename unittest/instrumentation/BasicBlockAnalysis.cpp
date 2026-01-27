#include "BasicBlockAnalysis.hpp"
#include <algorithm>
#include <memory>
#include <regex>
#include <string>
#include <utility>

namespace wasmInstrumentation {

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

} // namespace wasmInstrumentation
