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
#include "warpo/common/ConfigProvider.hpp"
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

static cli::Opt<std::string> ascWasmOption{
    cli::Category::Frontend,
    "--asc-wasm",
    [](argparse::Argument &arg) -> void { arg.help("WASM files for the frontend compiler").hidden(); },
};

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
  if (jsonConfig.host)
    config.host = frontend::HostUtils::fromString(*jsonConfig.host);
  if (jsonConfig.use)
    config.uses = *jsonConfig.use;
  if (jsonConfig.stackSize)
    config.stackSize = *jsonConfig.stackSize;
}

static void applyCLIConfig(Config &config) {
  if (ascWasmOption.isSet()) {
    config.ascWasmPath = convertEmptyStringToNullOpt(ascWasmOption.get());
  }
}

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
      .host = HostKind::None,

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

  common::ConfigProvider &configProvider = common::ConfigProvider::instance();
  common::FileConfigOptions const mergedOptions = configProvider.mergedFrontendOptions();
  applyJsonConfig(config, mergedOptions);
  applyCLIConfig(config);

  config.features = configProvider.features();
  config.optimizationLevel = configProvider.optimizationLevel();
  config.shrinkLevel = configProvider.shrinkLevel();
  config.emitDebugLine = configProvider.isDebugEnabled();
  config.emitDebugInfo = configProvider.isDebugEnabled();

  return compile(plugin, configProvider.mergedEntryPaths(), config);
}

} // namespace warpo
