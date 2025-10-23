///
/// @file AsString.cpp
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
#include <sstream>
#include <string>

#include "AsString.hpp"

#include "src/WasmModule/WasmModule.hpp"
namespace warpo {

std::string AsString::get(uint32_t const ptr, vb::WasmModule const *const ctx) {
  if (ptr == 0U)
    return "<<NULL>>";
  uint8_t const *const header = ctx->getLinearMemoryRegion(ptr - 20U, 20);
  uint32_t size = 0;
  std::memcpy(&size, header + 16, sizeof(size));
  uint8_t const *const content = ctx->getLinearMemoryRegion(ptr, size);
  size /= 2U;

  std::stringstream ss{};
  for (uint32_t i = 0; i < size; ++i) {
    ss << content[i * 2U];
  }
  return std::move(ss).str();
}

} // namespace warpo