///
/// @file FieldInfo.hpp
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
#pragma once

#include <cstdint>
#include <string_view>
#include <unordered_map>

#include "binaryen/src/support/istring.h"

namespace warpo::frontend {

class FieldInfo final {
public:
  FieldInfo(wasm::IString name, wasm::IString type, uint32_t offsetInClass, bool nullable);

  std::string_view getName() const noexcept { return name_.str; }
  std::string_view getType() const noexcept { return type_.str; }
  uint32_t getOffsetInClass() const noexcept { return offsetInClass_; }
  bool isNullable() const noexcept { return nullable_; }

private:
  static wasm::IString normalizeTypeName(const wasm::IString &type) noexcept;

  wasm::IString name_;
  wasm::IString type_;
  uint32_t offsetInClass_;
  bool nullable_;
};

} // namespace warpo::frontend
