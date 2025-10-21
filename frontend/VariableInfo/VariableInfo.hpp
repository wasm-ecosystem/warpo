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
#include <cstdint>
#include <memory>
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>

#include "llvm/ADT/StringMap.h"
#include "llvm/Support/MemoryBuffer.h"

#include "src/WasmModule/WasmModule.hpp"
#include "src/core/common/NativeSymbol.hpp"

namespace warpo::frontend {

class ClassInfo;

class VariableInfo final {
public:
  using ClassRegistry = std::unordered_map<std::string_view, ClassInfo>;

  static std::vector<vb::NativeSymbol> createVariableInfoAPI();

  static llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> generateDwarf();

  static std::string dumpDwarf(llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> const &debugSections);

private:
  static void createClass(uint32_t const classNamePtr, uint32_t const parentNamePtr, uint32_t const size,
                          uint32_t const rtid, vb::WasmModule const *const ctx);

  static void addField(uint32_t const classNamePtr, uint32_t const fieldNamePtr, uint32_t const typeNamePtr,
                       uint32_t const offset, uint32_t const nullable, vb::WasmModule const *const ctx);

  static ClassRegistry classRegistry_;
};
} // namespace warpo::frontend