///
/// @file ClassInfo.cpp
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
#include <regex>
#include <utility>

#include "warpo/common/ClassInfo.hpp"

namespace warpo {

void ClassInfo::addMember(std::string name, std::string_view const type, uint32_t const offsetInClass,
                          bool const nullable) {
  fields_.emplace_back(FieldInfo{std::move(name), type, offsetInClass, nullable});
}

bool ClassInfo::isBasicType() const noexcept {
  static const std::regex basicTypePattern(R"(~lib/number/(F32|F64|U8|I8|U16|I16|U32|I32|U64|I64|Usize|Isize|Bool))");
  return std::regex_match(name_.begin(), name_.end(), basicTypePattern);
}

} // namespace warpo
