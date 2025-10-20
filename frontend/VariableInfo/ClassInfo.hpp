///
/// @file ClassInfo.hpp
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
#include <vector>

#include "FieldInfo.hpp"
#include "binaryen/src/support/istring.h"

namespace warpo::frontend {

class InterfaceInfo final {};

class ClassInfo final {
public:
  ClassInfo(wasm::IString name, wasm::IString parentName, uint32_t size, uint32_t rtid);

  uint32_t getSize() const noexcept { return size_; }
  std::string_view getName() const noexcept { return name_.str; }
  std::vector<FieldInfo> const &getFields() const noexcept { return fields_; }

  void addMember(wasm::IString name, wasm::IString type, uint32_t offsetInClass, bool nullable);

  void setDebugInfoOffset(uint64_t offset) noexcept { debugInfoOffset_ = offset; }
  uint64_t getDebugInfoOffset() const noexcept { return debugInfoOffset_; }

  bool isBasicType() const noexcept;

private:
  wasm::IString name_;
  wasm::IString parentName_;
  uint32_t size_;
  uint32_t rtid_;
  size_t debugInfoOffset_;
  std::vector<FieldInfo> fields_;
  std::vector<InterfaceInfo> interfaces_;
};

} // namespace warpo::frontend
