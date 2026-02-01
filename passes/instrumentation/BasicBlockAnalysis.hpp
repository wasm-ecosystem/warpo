#ifndef __ASC_COV_BASICBLOCK_ANALYSIS_HPP__
#define __ASC_COV_BASICBLOCK_ANALYSIS_HPP__

#include <algorithm>
#include <cstdint>
#include <memory>
#include <regex>
#include <string_view>
#include <utility>
#include <vector>

namespace wasmInstrumentation {

/// @brief Class for performing if file should be included.
///
class BasicBlockAnalysis final {
public:
  ///
  /// @brief Add exclude file to debug info analysis
  ///
  /// @param exclude
  inline void addExclude(const std::string &&exclude) noexcept {
    excludes.emplace_back(exclude);
  }

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
} // namespace wasmInstrumentation

#endif
