// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <fmt/format.h>
#include <map>
#include <optional>
#include <string>
#include <vector>

#include "CompilerImpl.hpp"
#include "warpo/common/DebugLevel.hpp"
#include "warpo/common/OptLevel.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/Color.hpp"
#include "warpo/support/Opt.hpp"
#include "warpo/support/Statistics.hpp"

namespace warpo::frontend {

static std::optional<std::string> convertEmptyStringToNullOpt(std::string const &str) {
  if (!str.empty())
    return str;
  return std::nullopt;
}

static cli::Opt<std::vector<std::string>> entryPaths{
    cli::Category::Frontend,
    "entries",
    [](argparse::Argument &arg) -> void { arg.help("entry files").nargs(argparse::nargs_pattern::at_least_one); },
};

static cli::Opt<std::vector<std::string>> useOptions{
    cli::Category::Frontend,
    "-u",
    "--use",
    [](argparse::Argument &arg) -> void {
      arg.help("use option, format <name>=<value>").nargs(argparse::nargs_pattern::at_least_one).append();
    },
};
static std::map<std::string, std::string> getUses() {
  std::map<std::string, std::string> res{};
  std::vector<std::string> const &uses = useOptions.get();
  for (std::string const &use : uses) {
    size_t const eqPos = use.find('=');
    if (eqPos == std::string::npos || eqPos == 0) {
      fmt::println("ERROR: invalid use option: {}", use);
      std::exit(1);
    }
    res.insert_or_assign(use.substr(0, eqPos), use.substr(eqPos + 1));
  }
  return res;
}

static cli::Opt<std::string> ascWasmOption{
    cli::Category::Frontend,
    "--asc-wasm",
    [](argparse::Argument &arg) -> void { arg.help("WASM files for the frontend compiler").hidden(); },
};

static cli::Opt<std::string> exportStartOption{
    cli::Category::Frontend,
    "--exportStart",
    [](argparse::Argument &arg) -> void {
      arg.help("Exports the start function using the specified name instead of calling it implicitly."
               " Useful to obtain the exported memory before executing any code accessing it.")
          .nargs(1);
    },
};

static cli::Opt<bool> exportTableOption{
    cli::Category::Frontend,
    "--exportTable",
    [](argparse::Argument &arg) -> void { arg.help("Exports the function table as 'table'.").flag(); },
};
static cli::Opt<bool> exportRuntimeOption{
    cli::Category::Frontend,
    "--exportRuntime",
    [](argparse::Argument &arg) -> void {
      arg.help("Always exports the runtime helpers (__new, __collect, __pin etc.).").flag();
    },
};

static cli::Opt<uint32_t> initialMemoryOption{
    cli::Category::Frontend,
    "--initialMemory",
    [](argparse::Argument &arg) -> void {
      arg.help("Sets the initial memory size in pages.").nargs(1).default_value(static_cast<uint32_t>(-1));
    },
};

static cli::Opt<bool> experimentalOption{
    cli::Category::Frontend,
    "--experimental",
    [](argparse::Argument &arg) -> void { arg.help("Enables experimental AssemblyScript extensions.").flag(); },
};

} // namespace warpo::frontend

namespace warpo {

void frontend::init() { FrontendCompiler::init(); }

frontend::CompilationResult frontend::compile(std::vector<std::string> const &entryFilePaths, Config const &config) {
  support::PerfRAII const r(support::PerfItemKind::CompilationHIR);
  FrontendCompiler compiler{config};
  return compiler.compile(entryFilePaths, config);
}

warpo::frontend::Config warpo::frontend::getDefaultConfig() {
  return Config{
      .uses = {},
      .ascWasmPath = std::nullopt,
      .features = common::Features::all(),
      .exportStart = std::nullopt,
      .exportRuntime = false,
      .exportTable = false,
      .initialMemory = std::nullopt,
      .optimizationLevel = 0U,
      .shrinkLevel = 0U,
      .emitDebugLine = false,
      .useColorfulDiagMessage = support::isTTY(),
      .experimental = false,
  };
}

frontend::CompilationResult frontend::compile() {
  Config const config{
      .uses = getUses(),
      .ascWasmPath = convertEmptyStringToNullOpt(ascWasmOption.get()),
      .features = common::Features::fromCLI(),
      .exportStart = convertEmptyStringToNullOpt(exportStartOption.get()),
      .exportRuntime = exportRuntimeOption.get(),
      .exportTable = exportTableOption.get(),
      .initialMemory = initialMemoryOption.get() == static_cast<uint32_t>(-1)
                           ? std::nullopt
                           : std::optional<uint32_t>{initialMemoryOption.get()},
      .optimizationLevel = common::getOptimizationLevel(),
      .shrinkLevel = common::getShrinkLevel(),
      // currently, AS only support debug line via source map
      .emitDebugLine = common::isEmitDebugLineInfo(),
      .useColorfulDiagMessage = support::isTTY(),
      .experimental = experimentalOption.get(),
  };

  return compile(entryPaths.get(), config);
}

} // namespace warpo
