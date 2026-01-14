// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <fmt/format.h>
#include <optional>
#include <string>
#include <vector>

#include "CompilerImpl.hpp"
#include "warpo/common/ConfigFile.hpp"
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

static cli::Opt<std::vector<std::string>> entryPathsOption{
    cli::Category::Frontend,
    "entries",
    [](argparse::Argument &arg) -> void { arg.help("entry files").nargs(argparse::nargs_pattern::any); },
};

static cli::Opt<std::vector<std::string>> useOptions{
    cli::Category::Frontend,
    "-u",
    "--use",
    [](argparse::Argument &arg) -> void {
      arg.help("use option, format <name>=<value>").nargs(argparse::nargs_pattern::at_least_one).append();
    },
};

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
    [](argparse::Argument &arg) -> void { arg.help("Sets the initial memory size in pages.").nargs(1); },
};

static cli::Opt<uint32_t> stackSizeOption{
    cli::Category::Frontend,
    "--stackSize",
    [](argparse::Argument &arg) -> void { arg.help("Sets the stack size in bytes.").nargs(1); },
};

static cli::Opt<std::string> runtimeOption{
    cli::Category::Frontend,
    "--runtime",
    [](argparse::Argument &arg) -> void {
      arg.help("Specifies the runtime to use. Options are 'radical' and 'incremental'.")
          .nargs(1)
          .default_value(RuntimeUtils::toString(RuntimeKind::Incremental))
          .choices(RuntimeUtils::toString(RuntimeKind::Radical), RuntimeUtils::toString(RuntimeKind::Incremental));
    },
};

static RuntimeKind getRuntimeFromCLI() { return RuntimeUtils::fromString(runtimeOption.get()); }

static void applyJsonConfig(Config &config, const common::FileConfigOptions &jsonConfig) {
  if (jsonConfig.exportStart)
    config.exportStart = *jsonConfig.exportStart;
  if (jsonConfig.exportRuntime)
    config.exportRuntime = *jsonConfig.exportRuntime;
  if (jsonConfig.exportTable)
    config.exportTable = *jsonConfig.exportTable;
  if (jsonConfig.initialMemory)
    config.initialMemory = *jsonConfig.initialMemory;
  if (jsonConfig.runtime)
    config.runtime = frontend::RuntimeUtils::fromString(*jsonConfig.runtime);
  if (jsonConfig.use)
    config.uses = *jsonConfig.use;
  if (jsonConfig.stackSize)
    config.stackSize = *jsonConfig.stackSize;
}

static void applyCLIConfig(Config &config) {
  std::vector<std::string> const &uses = useOptions.get();
  for (std::string const &use : uses) {
    config.uses.merge(use);
  }
  if (ascWasmOption.isSet()) {
    config.ascWasmPath = convertEmptyStringToNullOpt(ascWasmOption.get());
  }
  if (exportStartOption.isSet()) {
    config.exportStart = convertEmptyStringToNullOpt(exportStartOption.get());
  }
  if (runtimeOption.isSet()) {
    config.runtime = getRuntimeFromCLI();
  }
  if (exportRuntimeOption.isSet()) {
    config.exportRuntime = exportRuntimeOption.get();
  }
  if (exportTableOption.isSet())
    config.exportTable = exportTableOption.get();
  if (initialMemoryOption.isSet())
    config.initialMemory = initialMemoryOption.get();
  if (stackSizeOption.isSet())
    config.stackSize = stackSizeOption.get();
}

class EntryPaths {
  std::set<std::string> entries_;

public:
  void merge(std::vector<std::string> const &other) { entries_.insert(other.begin(), other.end()); }
  std::vector<std::string> toVector() const { return std::vector<std::string>{entries_.begin(), entries_.end()}; }
};

Config Config::getDefault() {
  return Config{
      .uses = common::UsesOption{},
      .ascWasmPath = std::nullopt,
      .exportStart = std::nullopt,
      .runtime = RuntimeKind::Incremental,
      .exportRuntime = false,
      .exportTable = false,
      .initialMemory = std::nullopt,
      .stackSize = 32768U,

      .useColorfulDiagMessage = support::isTTY(),

      .features = common::Features::all(),
      .optimizationLevel = 0U,
      .shrinkLevel = 0U,
      .emitDebugLine = false,
      .emitDebugInfo = false,
  };
}

} // namespace warpo::frontend

namespace warpo {

void frontend::init() { FrontendCompiler::init(); }

frontend::CompilationResult frontend::compile(Pluggable *plugin, std::vector<std::string> const &entryFilePaths,
                                              Config const &config) {
  if (entryFilePaths.empty())
    throw std::runtime_error("No entry files specified for compilation.");
  support::PerfRAII const r(support::PerfItemKind::CompilationHIR);
  FrontendCompiler compiler{config, plugin};
  return compiler.compile(entryFilePaths, config);
}

frontend::CompilationResult frontend::compile(Pluggable *plugin) {
  // handle config
  Config config = Config::getDefault();
  std::optional<common::MergedFileConfig> const &fileConfig = common::getFileConfig();
  if (fileConfig.has_value())
    applyJsonConfig(config, fileConfig->options);
  applyCLIConfig(config);

  config.features = common::Features::fromCLI();
  config.optimizationLevel = common::getOptimizationLevel();
  config.shrinkLevel = common::getShrinkLevel();
  config.emitDebugLine = common::isEmitDebugLine();
  config.emitDebugInfo = common::isEmitDebugInfo();

  // handle entries
  EntryPaths entries;
  if (fileConfig.has_value())
    entries.merge(fileConfig->entries);
  entries.merge(entryPathsOption.get());

  return compile(plugin, entries.toVector(), config);
}

} // namespace warpo
