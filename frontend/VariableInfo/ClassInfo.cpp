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

#include "ClassInfo.hpp"

namespace warpo::frontend {

ClassInfo::ClassInfo(wasm::IString name, wasm::IString parentName, uint32_t const size, uint32_t const rtid)
    : name_(std::move(name)), parentName_(std::move(parentName)), size_(size), rtid_(rtid), debugInfoOffset_(SIZE_MAX) {
}

void ClassInfo::addMember(wasm::IString name, wasm::IString type, uint32_t offsetInClass, bool nullable) {
  fields_.emplace_back(FieldInfo{std::move(name), std::move(type), offsetInClass, nullable});
}

bool ClassInfo::isBasicType() const noexcept {
  static const std::regex basicTypePattern(R"(~lib/number/(F32|F64|U8|I8|U16|I16|U32|I32|U64|I64|Usize))");
  return std::regex_match(name_.str.begin(), name_.str.end(), basicTypePattern);
}

} // namespace warpo::frontend
