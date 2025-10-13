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
#include <iostream>

#include "AsString.hpp"
#include "VariableInfo.hpp"

#include "src/core/common/function_traits.hpp"

namespace warpo::frontend {
void VariableInfo::createClass(uint32_t const classNamePtr, uint32_t const parentNamePtr, uint32_t const rtid,
                               vb::WasmModule const *const ctx) {
  std::string const className{AsString::get(classNamePtr, ctx)};
  std::string const parentName{AsString::get(parentNamePtr, ctx)};
  std::cout << className << " extends " << parentName << " rtid=" << rtid << std::endl;
}

std::vector<vb::NativeSymbol> VariableInfo::createVariableInfoAPI() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("warpo", "_WarpoCreateClass", createClass),
  };
}
} // namespace warpo::frontend