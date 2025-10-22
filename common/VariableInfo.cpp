///
/// @file VariableInfo.cpp
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
#include <cassert>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <memory>
#include <unordered_map>
#include <utility>
#include <vector>

#include "warpo/common/ClassInfo.hpp"
#include "warpo/common/FieldInfo.hpp"
#include "warpo/common/VariableInfo.hpp"
#include "warpo/support/AsString.hpp"

namespace warpo {

void VariableInfo::addField(std::string_view const className, std::string fieldName, std::string const typeName,
                            uint32_t const offset, uint32_t const nullable) {
  ClassRegistry::iterator const classIt = classRegistry_.find(className);
  assert(classIt != classRegistry_.end());
  std::string_view const internedTypeName = stringPool_.internString(typeName);
  classIt->second.addMember(std::move(fieldName), internedTypeName, offset, nullable != 0);
}

void VariableInfo::createClass(std::string const className, std::string const parentName, uint32_t const size,
                               uint32_t const rtid) {
  std::string_view const internedClassName = stringPool_.internString(className);
  std::string_view const internedParentName = stringPool_.internString(parentName);
  classRegistry_.emplace(internedClassName, ClassInfo{internedClassName, internedParentName, size, rtid});
}

} // namespace warpo