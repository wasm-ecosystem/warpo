///
/// @file DebugStringManager.cpp
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
#include "DebugStringManager.hpp"

namespace warpo {

size_t DebugStringManager::addString(std::string_view str) {
  wasm::IString const internedStr(str);

  std::unordered_map<wasm::IString, size_t>::const_iterator const it = stringOffsets_.find(internedStr);
  if (it != stringOffsets_.end()) {
    return it->second;
  }

  size_t const offset = currentOffset_;

  stringOffsets_[internedStr] = offset;
  debugStrings_.emplace_back(internedStr.str.data(), internedStr.str.size());

  currentOffset_ += str.size() + 1U;

  return offset;
}

} // namespace warpo
