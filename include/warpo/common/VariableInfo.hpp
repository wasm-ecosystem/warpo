///
/// @file VariableInfo.hpp
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
#ifndef VARIABLE_INFO_HPP
#define VARIABLE_INFO_HPP
#include <cstdint>
#include <memory>
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>

#include "ClassInfo.hpp"
#include "llvm/ADT/StringMap.h"
#include "llvm/Support/MemoryBuffer.h"
#include "warpo/support/StringPool.hpp"

namespace warpo {

class VariableInfo final {
public:
  using ClassRegistry = std::unordered_map<std::string_view, ClassInfo>;

  void createClass(std::string className, std::string parentName, uint32_t const size, uint32_t const rtid);

  void addField(std::string_view const className, std::string fieldName, std::string typeName, uint32_t const offset,
                uint32_t const nullable);

  ClassRegistry const &getClassRegistry() const noexcept { return classRegistry_; }

private:
  ClassRegistry classRegistry_;
  StringPool stringPool_;
};
} // namespace warpo
#endif