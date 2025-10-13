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
#include <vector>

#include "src/WasmModule/WasmModule.hpp"
#include "src/core/common/NativeSymbol.hpp"
namespace warpo::frontend {
class VariableInfo final {
public:
  static std::vector<vb::NativeSymbol> createVariableInfoAPI();

private:
  static void createClass(uint32_t const classNamePtr, uint32_t const parentNamePtr, uint32_t const rtid,
                          vb::WasmModule const *const ctx);
};
} // namespace warpo::frontend