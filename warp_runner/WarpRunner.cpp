// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include "UTF16.hpp"
#include "warpo/warp_runner/WarpRunner.hpp"

#include "src/utils/StackTop.hpp"

namespace warpo {

uint8_t const *stackTop() {
  thread_local static uint8_t const *const stackTop = static_cast<uint8_t const *>(vb::getStackTop());
  return stackTop;
}

WarpRunner::WarpRunner(void *const ctx) : logger_(), instance_{logger_} {
  instance_.setStacktraceRecordCount(32U);
  instance_.setContext(ctx);
}

uint32_t WarpRunner::allocObject(vb::WasmModule *instance, int32_t rtId, int32_t size) {
  uint32_t const offset = instance->callExportedFunctionWithName<1>(stackTop(), "__new", size, rtId)[0].u32;
  instance->callExportedFunctionWithName<1>(stackTop(), "__pin", offset);
  return offset;
}

uint32_t WarpRunner::allocString(vb::WasmModule *instance, std::string_view str) {
  std::u16string utf16Str = utf16::fromUTF8(std::string(str));
  uint32_t const offset = allocObject(instance, 2 /* rtId for string */, static_cast<int32_t>(utf16Str.size() * 2U));
  uint8_t *const ptr =
      instance->getLinearMemoryRegion(static_cast<uint32_t>(offset), static_cast<uint32_t>(utf16Str.size()));
  std::memcpy(ptr, utf16Str.data(), utf16Str.size() * sizeof(char16_t));
  return offset;
}

std::string WarpRunner::getString(vb::WasmModule const *instance, uint32_t ptr) {
  if (ptr == 0U)
    return "<<NULL>>";
  uint8_t const *const header = instance->getLinearMemoryRegion(ptr - 20U, 20);
  uint32_t size = 0;
  std::memcpy(&size, header + 16, sizeof(size));
  uint8_t const *const content = instance->getLinearMemoryRegion(ptr, size);

  return utf16::toUTF8(std::u16string_view{reinterpret_cast<char16_t const *>(content), size / 2U});
}

} // namespace warpo
