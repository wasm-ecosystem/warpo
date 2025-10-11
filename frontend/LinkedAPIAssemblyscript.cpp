// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <iostream>
#include <sstream>
#include <utility>
#include <vector>

#include "LinkedAPI.hpp"

#include "src/WasmModule/WasmModule.hpp"
#include "src/core/common/NativeSymbol.hpp"
#include "src/core/common/function_traits.hpp"

namespace warpo::frontend {

namespace {

std::string getAsString(uint32_t ptr, vb::WasmModule *ctx) {
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

void abortForLink(uint32_t messagePtr, uint32_t fileNamePtr, uint32_t lineNumber, uint32_t columnNumber,
                  vb::WasmModule *ctx) {
  std::stringstream ss{};
  ss << "abort: " << getAsString(messagePtr, ctx) << " in " << getAsString(fileNamePtr, ctx) << ":" << lineNumber << ":"
     << columnNumber;
  std::cerr << std::move(ss).str() << std::endl;
  ctx->requestInterruption(vb::TrapCode::BUILTIN_TRAP);
}

void traceForLink(uint32_t ptr, uint32_t n, double d1, double d2, double d3, double d4, double d5,
                  vb::WasmModule *ctx) {
  std::stringstream ss{};
  ss << getAsString(ptr, ctx);
  for (size_t i = 1U; i <= n; i++) {
    switch (i) {
    case 1:
      ss << " " << d1;
      break;
    case 2:
      ss << " " << d2;
      break;
    case 3:
      ss << " " << d3;
      break;
    case 4:
      ss << " " << d4;
      break;
    case 5:
      ss << " " << d5;
      break;
    default:
      break;
    }
  }
  std::cout << std::move(ss).str() << std::endl;
}

} // namespace

std::vector<vb::NativeSymbol> createAssemblyscriptAPI() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("env", "abort", abortForLink),
      STATIC_LINK("env", "trace", traceForLink),
  };
}

} // namespace warpo::frontend
