// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <fmt/base.h>
#include <vector>

#include "LinkedAPI.hpp"
#include "warpo/frontend/AsString.hpp"
#include "warpo/frontend/LinkedAPIAssemblyscript.hpp"
#include "warpo/support/Container.hpp"

#include "src/WasmModule/WasmModule.hpp"
#include "src/core/common/function_traits.hpp"

namespace warpo::driver {

static uint32_t getCreateFileDirPathForLink(vb::WasmModule *ctx) { return 0; }

static void onModuleResolveForLink(uint32_t fnIndex, uint32_t rtId, vb::WasmModule *ctx) {
  fmt::println("onModuleResolve called with fnIndex: {}, rtId: {}", fnIndex, rtId);
}

static void setPackagePathForLink(uint32_t packageNamePtr, uint32_t packagePathPtr, vb::WasmModule *ctx) {
  std::string const packageName = frontend::AsString::get(packageNamePtr, ctx);
  std::string const packagePath = frontend::AsString::get(packagePathPtr, ctx);
}

static std::vector<vb::NativeSymbol> createLinkedAPICreate() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("__warpo_create", "getCreateFileDirPath", getCreateFileDirPathForLink),

      STATIC_LINK("__warpo_create", "onModuleResolve", onModuleResolveForLink),
      STATIC_LINK("__warpo_create", "setPackagePath", setPackagePathForLink),
  };
}

static std::vector<vb::NativeSymbol> createLinkedAPI() {
  std::vector<vb::NativeSymbol> linkedAPI;
  append(linkedAPI, frontend::createAssemblyscriptAPI());
  append(linkedAPI, createLinkedAPICreate());
  return linkedAPI;
}

} // namespace warpo::driver

std::vector<vb::NativeSymbol> const &warpo::driver::getLinkedAPI() {
  static std::vector<vb::NativeSymbol> const linkedAPI = createLinkedAPI();
  return linkedAPI;
}
