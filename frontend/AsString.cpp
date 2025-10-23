// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstdint>
#include <string>

#include "AsString.hpp"
#include "UTF16.hpp"

#include "src/WasmModule/WasmModule.hpp"
namespace warpo::frontend {

std::string AsString::get(uint32_t const ptr, vb::WasmModule const *const ctx) {
  if (ptr == 0U)
    return "<<NULL>>";
  uint8_t const *const header = ctx->getLinearMemoryRegion(ptr - 20U, 20);
  uint32_t size = 0;
  std::memcpy(&size, header + 16, sizeof(size));
  uint8_t const *const content = ctx->getLinearMemoryRegion(ptr, size);

  return utf16::toUTF8(std::u16string_view{reinterpret_cast<char16_t const *>(content), size / 2U});
}

} // namespace warpo::frontend