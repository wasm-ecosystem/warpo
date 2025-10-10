// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <vector>

#include "CompilerImpl.hpp"
#include "LinkedAPI.hpp"

#include "src/WasmModule/WasmModule.hpp"
#include "src/core/common/NativeSymbol.hpp"
#include "src/core/common/function_traits.hpp"

namespace warpo::frontend {

namespace {

uint32_t loadU8ForLink(uint64_t ptr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint8_t *>(ptr)[0];
}
uint32_t loadI32ForLink(uint64_t ptr, [[maybe_unused]] vb::WasmModule *ctx) {
  return reinterpret_cast<uint32_t *>(ptr)[0];
}
void store8ForLink(uint64_t ptr, uint32_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  reinterpret_cast<uint8_t *>(ptr)[0] = value;
}
void store32ForLink(uint64_t ptr, uint32_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  reinterpret_cast<uint32_t *>(ptr)[0] = value;
}
void store64ForLink(uint64_t ptr, uint64_t value, [[maybe_unused]] vb::WasmModule *ctx) {
  reinterpret_cast<uint64_t *>(ptr)[0] = value;
}

uint64_t mallocForLink(uint32_t size, [[maybe_unused]] vb::WasmModule *ctx) {
  void *const p = std::malloc(size);
  static_cast<FrontendCompiler *>(ctx->getContext())->allocedPtrs_.insert(p);
  return reinterpret_cast<uint64_t>(p);
}
void freeForLink(uint64_t ptr, [[maybe_unused]] vb::WasmModule *ctx) {
  void *const p = reinterpret_cast<void *>(ptr);
  static_cast<FrontendCompiler *>(ctx->getContext())->allocedPtrs_.erase(p);
  std::free(p);
}
} // namespace

std::vector<vb::NativeSymbol> createCppWrapperAPI() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("binaryen", "__i32_load8_u", loadU8ForLink), STATIC_LINK("binaryen", "__i32_load", loadI32ForLink),
      STATIC_LINK("binaryen", "__i32_store8", store8ForLink),  STATIC_LINK("binaryen", "__i32_store", store32ForLink),
      STATIC_LINK("binaryen", "__i64_store", store64ForLink),  STATIC_LINK("binaryen", "_malloc", mallocForLink),
      STATIC_LINK("binaryen", "_free", freeForLink),
  };
}

} // namespace warpo::frontend
