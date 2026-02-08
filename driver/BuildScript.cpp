// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <filesystem>
#include <fmt/base.h>
#include <memory>
#include <optional>

#include "BuildScript.hpp"
#include "LinkedAPI.hpp"
#include "warpo/common/ConfigProvider.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/warp_runner/WarpRunner.hpp"

#include "src/core/common/NativeSymbol.hpp"
#include "src/core/common/Span.hpp"

namespace warpo::driver {

static std::optional<std::filesystem::path> getProjectConfigPath() {
  std::optional<std::filesystem::path> const projectPath = common::ConfigProvider::instance().projectPath();
  if (!projectPath.has_value())
    return std::nullopt;
  if (isDirectory(projectPath.value()))
    return projectPath.value() / "create.ts";
  return projectPath.value();
}

BuildScriptRunner::BuildScriptRunner(std::filesystem::path const &buildScriptPath)
    : r_{this}, createFileDirName_{buildScriptPath.parent_path().string()} {
  constexpr const char *startFunctionName = "__create_start";
  frontend::Config createConfig = frontend::Config::getDefault();
  createConfig.emitDebugLine = true;
  createConfig.exportRuntime = true;
  createConfig.exportTable = true;
  createConfig.runtime = frontend::RuntimeKind::Radical;
  createConfig.exportStart = startFunctionName;
  frontend::CompilationResult const result = frontend::compile(nullptr, {buildScriptPath.string()}, createConfig);
  if (result.m.invalid()) {
    fmt::println("compilation failed");
    fmt::println("{}", result.errorMessage);
    throw std::runtime_error{"compilation 'create.ts' failed"};
  }
  passes::Config const passesConfig{
      .optimizeLevel = 0,
      .shrinkLevel = 0,
      .sourceMapURL = "",
  };
  passes::Output output = passes::runOnModule(result.m, passesConfig);

  std::vector<vb::NativeSymbol> const &linkedAPI = getLinkedAPI();
  r_.initFromBytecode(vb::Span<uint8_t const>{output.wasm.data(), output.wasm.size()},
                      vb::Span<vb::NativeSymbol const>(linkedAPI.data(), linkedAPI.size()), false);
  r_.start();
  r_.callExportedFunctionWithName<0>(startFunctionName);
}

std::unique_ptr<BuildScriptRunner> BuildScriptRunner::create() {
  std::optional<std::filesystem::path> const buildScriptPath = getProjectConfigPath();
  if (!buildScriptPath.has_value() || !isRegularFile(*buildScriptPath))
    return nullptr;
  return std::unique_ptr<BuildScriptRunner>{new BuildScriptRunner(*buildScriptPath)};
}

std::optional<std::filesystem::path> BuildScriptRunner::getPackageRoot(std::string const &packageName) {
  if (onModuleResolveCallback_.has_value())
    return onModuleResolveCallback_.value()(packageName);
  return std::nullopt;
}
void BuildScriptRunner::registerOnModuleResolve(OnResolveModuleFn callback) {
  onModuleResolveCallback_ = std::move(callback);
}

} // namespace warpo::driver
