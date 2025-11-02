// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstring>
#include <fmt/base.h>
#include <string>
#include <vector>

#include "BuildScript.hpp"
#include "LinkedAPI.hpp"
#include "warpo/support/Container.hpp"
#include "warpo/warp_runner/LinkedAPIAssemblyscript.hpp"
#include "warpo/warp_runner/WarpRunner.hpp"

#include "src/WasmModule/WasmModule.hpp"
#include "src/core/common/function_traits.hpp"

namespace warpo::driver {

static BuildScriptRunner *getRunner(vb::WasmModule *ctx) { return static_cast<BuildScriptRunner *>(ctx->getContext()); }

static uint32_t getCreateFileDirNameForLink(vb::WasmModule *ctx) {
  uint32_t const pathOffset = WarpRunner::allocString(ctx, getRunner(ctx)->getCreateFileDirName());
  return pathOffset;
}

namespace {

class ResolveModule {
  // detail layout see create/resolveModule.ts
  using PackageNameType = uint32_t;
  constexpr static uint32_t packageNameOffset = 0U;
  constexpr static uint32_t packageNameSize = sizeof(PackageNameType);
  using PackagePathType = uint32_t;
  constexpr static uint32_t packageOffset = packageNameOffset + packageNameSize;
  constexpr static uint32_t packagePathSize = sizeof(PackagePathType);

  uint32_t offset_;

public:
  constexpr static uint32_t size = packageOffset + packagePathSize;
  explicit ResolveModule(uint32_t offset) : offset_(offset) {}

  void setPackageName(std::string const &packageName, vb::WasmModule *ctx) {
    uint32_t const stringOffset = WarpRunner::allocString(ctx, packageName);
    uint8_t *const ptr = ctx->getLinearMemoryRegion(offset_ + packageNameOffset, packageNameSize);
    std::memcpy(ptr, &stringOffset, packageNameSize);
  }
  std::optional<std::filesystem::path> getPackagePath(vb::WasmModule *ctx) {
    uint32_t pathOffset;
    uint8_t *const ptr = ctx->getLinearMemoryRegion(offset_ + packageOffset, packagePathSize);
    std::memcpy(&pathOffset, ptr, packagePathSize);
    if (pathOffset == 0U)
      return std::nullopt;
    return {WarpRunner::getString(ctx, pathOffset)};
  }
};

} // namespace

static void onModuleResolveForLink(uint32_t callbackFnIndex, int32_t rtId, vb::WasmModule *ctx) {
  getRunner(ctx)->registerOnModuleResolve(
      [ctx, callbackFnIndex, rtId](std::string const &packageName) -> std::optional<std::filesystem::path> {
        uint32_t const resolveModuleOffset = WarpRunner::allocObject(ctx, rtId, ResolveModule::size);
        ResolveModule resolveModule{resolveModuleOffset};
        resolveModule.setPackageName(packageName, ctx);
        ctx->callWasmFunctionByExportedTableIndex<0>(stackTop(), callbackFnIndex, resolveModuleOffset);
        return resolveModule.getPackagePath(ctx);
      });
}

static std::vector<vb::NativeSymbol> createLinkedAPICreate() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("__warpo_create", "getCreateFileDirName", getCreateFileDirNameForLink),

      STATIC_LINK("__warpo_create", "onModuleResolve", onModuleResolveForLink),
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
