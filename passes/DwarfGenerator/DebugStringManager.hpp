///
/// @file DebugStringManager.hpp
/// @copyright Copyright (C) 2025 wasm-ecosystem
/// SPDX-License-Identifier: Apache-2.0
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
#ifndef DEBUG_STRING_MANAGER_HPP
#define DEBUG_STRING_MANAGER_HPP

#include <cstddef>
#include <string_view>
#include <unordered_map>
#include <vector>

#include "binaryen/src/support/istring.h"
#include "llvm/ADT/StringRef.h"

namespace warpo {

/// @brief Manager for DWARF debug string section with deduplication
class DebugStringManager final {
public:
  /// @brief Add a string to the debug string section and return its offset
  /// @param str The string to add (string_view)
  /// @return The offset of the string in the debug_str section
  size_t addString(std::string_view str);

  /// @brief Get the vector of debug strings
  /// @return Reference to the vector of StringRefs for the debug_str section
  const std::vector<llvm::StringRef> &getDebugStrings() const noexcept { return debugStrings_; }

private:
  std::unordered_map<wasm::IString, size_t> stringOffsets_;
  std::vector<llvm::StringRef> debugStrings_;
  size_t currentOffset_ = 0U;
};

} // namespace warpo

#endif // WARPO_FRONTEND_DEBUG_STRING_MANAGER_HPP
