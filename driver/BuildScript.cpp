// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <filesystem>
#include <fmt/base.h>
#include <memory>

#include "BuildScript.hpp"
#include "warp_runner/WarpRunner.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/frontend/LinkedAPIAssemblyscript.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/Container.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"

#include "src/core/common/NativeSymbol.hpp"
#include "src/core/common/Span.hpp"

namespace warpo::driver {

static cli::Opt<std::filesystem::path> projectOption{
    cli::Category::All,
    "-p",
    "--project",
    [](argparse::Argument &arg) -> void {
      arg.help("Compile the project given the path to its configuration file, or to a folder with a 'build.ts'")
          .nargs(1U)
          .default_value("");
    },
};

static std::filesystem::path getProjectConfigPath() {
  std::filesystem::path projectPath = projectOption.get();
  if (projectPath.empty()) {
    return std::filesystem::current_path() / "build.ts";
  }
  if (isDirectory(projectPath)) {
    return projectPath / "build.ts";
  }
  return projectPath;
}

} // namespace warpo::driver

std::unique_ptr<WarpRunner> warpo::driver::initProjectConfig() {
  frontend::Config frontendConfig = frontend::getDefaultConfig();
  frontendConfig.emitDebugLine = true;

  std::filesystem::path const buildScriptPath = getProjectConfigPath();
  if (!isRegularFile(buildScriptPath))
    return nullptr;
  frontend::CompilationResult const result = frontend::compile({buildScriptPath}, frontendConfig);
  if (result.m.invalid()) {
    fmt::println("compilation failed");
    fmt::println("{}", result.errorMessage);
    throw std::runtime_error("compilation 'build.ts' failed");
  }
  passes::Config const passesConfig{.sourceMapURL = ""};
  passes::Output output = passes::runOnModule(result.m, passesConfig);

  std::unique_ptr<WarpRunner> r{new WarpRunner(nullptr)};
  std::vector<vb::NativeSymbol> linkedAPI;
  append(linkedAPI, frontend::createAssemblyscriptAPI());
  (*r)->initFromBytecode(vb::Span<uint8_t const>{output.wasm.data(), output.wasm.size()},
                         vb::Span<vb::NativeSymbol const>(linkedAPI.data(), linkedAPI.size()), false);
  uint8_t const *const stackTop = (*r).getStackTop();
  (*r)->start(stackTop);
  return r;
}
