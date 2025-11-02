// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <filesystem>
#include <fmt/base.h>
#include <memory>

#include "BuildScript.hpp"
#include "LinkedAPI.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"
#include "warpo/warp_runner/WarpRunner.hpp"

#include "src/core/common/NativeSymbol.hpp"
#include "src/core/common/Span.hpp"

namespace warpo::driver {

static cli::Opt<std::filesystem::path> projectOption{
    cli::Category::All,
    "-p",
    "--project",
    [](argparse::Argument &arg) -> void {
      arg.help("Compile the project given the path to its configuration file, or to a folder with a 'create.ts'")
          .nargs(1U)
          .default_value("");
    },
};

static std::filesystem::path getProjectConfigPath() {
  std::filesystem::path projectPath = projectOption.get();
  if (projectPath.empty())
    return std::filesystem::current_path() / "create.ts";
  if (isDirectory(projectPath))
    return projectPath / "create.ts";
  return projectPath;
}

BuildScriptRunner::BuildScriptRunner(std::filesystem::path const &buildScriptPath)
    : r_{this}, createFileDirName_{buildScriptPath.parent_path().string()} {
  constexpr const char *startFunctionName = "__create_start";
  frontend::Config createConfig = frontend::getDefaultConfig();
  createConfig.emitDebugLine = true;
  createConfig.exportRuntime = true;
  createConfig.exportTable = true;
  createConfig.exportStart = startFunctionName;
  frontend::CompilationResult const result = frontend::compile(nullptr, {buildScriptPath}, createConfig);
  if (result.m.invalid()) {
    fmt::println("compilation failed");
    fmt::println("{}", result.errorMessage);
    throw std::runtime_error{"compilation 'create.ts' failed"};
  }
  passes::Config const passesConfig{.sourceMapURL = ""};
  passes::Output output = passes::runOnModule(result.m, passesConfig);

  std::vector<vb::NativeSymbol> const &linkedAPI = getLinkedAPI();
  r_.initFromBytecode(vb::Span<uint8_t const>{output.wasm.data(), output.wasm.size()},
                      vb::Span<vb::NativeSymbol const>(linkedAPI.data(), linkedAPI.size()), false);
  r_.start();
  r_.callExportedFunctionWithName<0>(startFunctionName);
}

std::unique_ptr<BuildScriptRunner> BuildScriptRunner::create() {
  std::filesystem::path const buildScriptPath = getProjectConfigPath();
  if (!isRegularFile(buildScriptPath))
    return nullptr;
  return std::unique_ptr<BuildScriptRunner>{new BuildScriptRunner(buildScriptPath)};
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
