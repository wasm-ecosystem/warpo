///
/// @file TypeNameHelper.cpp
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
#include "warpo/common/TypeNameHelper.hpp"

namespace warpo {

const std::unordered_map<std::string_view, std::string_view> TypeNameHelper::basicTypeMap = {
    {"~lib/number/I32", "i32"},  {"~lib/number/U32", "u32"},     {"~lib/number/I64", "i64"},
    {"~lib/number/U64", "u64"},  {"~lib/number/F32", "f32"},     {"~lib/number/F64", "f64"},
    {"~lib/number/I8", "i8"},    {"~lib/number/U8", "u8"},       {"~lib/number/I16", "i16"},
    {"~lib/number/U16", "u16"},  {"~lib/number/Isize", "isize"}, {"~lib/number/Usize", "usize"},
    {"~lib/number/Bool", "bool"}};

std::string_view TypeNameHelper::normalizeTypeName(std::string_view const type) noexcept {
  auto const it = basicTypeMap.find(type);
  if (it != basicTypeMap.end()) {
    return it->second;
  }
  return type;
}

} // namespace warpo
