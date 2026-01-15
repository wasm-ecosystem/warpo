// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <cstdint>
#include <filesystem>
#include <optional>
#include <set>
#include <string>
#include <vector>

#include "ConfigFile.hpp"
#include "warpo/common/ConfigProvider.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo::common {

namespace {

std::optional<std::string> convertEmptyStringToNullOpt(std::string const &str) {
  if (!str.empty())
    return str;
  return std::nullopt;
}

cli::Opt<std::vector<std::string>> entryPathsOption{
    cli::Category::Frontend,
    "entries",
    [](argparse::Argument &arg) -> void { arg.help("entry files").nargs(argparse::nargs_pattern::any); },
};

cli::Opt<std::vector<std::string>> useOptions{
    cli::Category::Frontend,
    "-u",
    "--use",
    [](argparse::Argument &arg) -> void {
      arg.help("use option, format <name>=<value>").nargs(argparse::nargs_pattern::at_least_one).append();
    },
};

cli::Opt<std::string> exportStartOption{
    cli::Category::Frontend,
    "--exportStart",
    [](argparse::Argument &arg) -> void {
      arg.help("Exports the start function using the specified name instead of calling it implicitly."
               " Useful to obtain the exported memory before executing any code accessing it.")
          .nargs(1);
    },
};

cli::Opt<bool> exportTableOption{
    cli::Category::Frontend,
    "--exportTable",
    [](argparse::Argument &arg) -> void { arg.help("Exports the function table as 'table'.").flag(); },
};

cli::Opt<bool> exportRuntimeOption{
    cli::Category::Frontend,
    "--exportRuntime",
    [](argparse::Argument &arg) -> void {
      arg.help("Always exports the runtime helpers (__new, __collect, __pin etc.).").flag();
    },
};

cli::Opt<uint32_t> initialMemoryOption{
    cli::Category::Frontend,
    "--initialMemory",
    [](argparse::Argument &arg) -> void { arg.help("Sets the initial memory size in pages.").nargs(1); },
};

cli::Opt<uint32_t> stackSizeOption{
    cli::Category::Frontend,
    "--stackSize",
    [](argparse::Argument &arg) -> void { arg.help("Sets the stack size in bytes.").nargs(1); },
};

cli::Opt<std::string> runtimeOption{
    cli::Category::Frontend,
    "--runtime",
    [](argparse::Argument &arg) -> void {
      arg.help("Specifies the runtime to use. Options are 'radical' and 'incremental'.")
          .nargs(1)
          .default_value(std::string{"incremental"})
          .choices("radical", "incremental");
    },
};

cli::Opt<uint32_t> optimizeLevelOption{
    cli::Category::Frontend | cli::Category::Optimization,
    "--optimizeLevel",
    [](argparse::Argument &arg) -> void {
      arg.help("How much to focus on optimizing code. [0-3]").nargs(1U).default_value(0U);
    },
};

cli::Opt<uint32_t> shrinkLevelOption{
    cli::Category::Frontend | cli::Category::Optimization,
    "--shrinkLevel",
    [](argparse::Argument &arg) -> void {
      arg.help("How much to focus on shrinking code. [0-2]").nargs(1U).default_value(0U);
    },
};

cli::Opt<bool> debugOption{
    cli::Category::Frontend | cli::Category::Optimization,
    "--debug",
    [](argparse::Argument &arg) -> void { arg.help("Enables debug information in emitted binaries.").flag(); },
};

cli::Opt<std::vector<std::string>> disableFeatureOptions{
    cli::Category::Frontend | cli::Category::Optimization,
    "--disable-feature",
    [](argparse::Argument &arg) -> void {
      arg.help("disable WebAssembly features, mutable-globals, sign-extension, nontrapping-f2i, bulk-memory")
          .nargs(argparse::nargs_pattern::at_least_one)
          .choices("mutable-globals", "sign-extension", "nontrapping-f2i", "bulk-memory")
          .append();
    },
};

cli::Opt<std::filesystem::path> outputPathOption{
    cli::Category::All,
    "-o",
    "--output",
    [](argparse::Argument &arg) -> void { arg.help("output file"); },
};

} // namespace

ConfigProvider &ConfigProvider::instance() {
  static ConfigProvider ins;
  return ins;
}

FileConfigOptions ConfigProvider::mergedFrontendOptions() {
  FileConfigOptions merged;

  std::optional<MergedFileConfig> const &fileCfg = MergedFileConfig::getConfigFromFile();
  if (fileCfg.has_value())
    merged = fileCfg->options;

  // Merge CLI uses into config-file uses.
  UsesOption uses = merged.use.value_or(UsesOption{});
  for (std::string const &useStr : useOptions.get())
    uses.merge(useStr);
  if (!uses.empty() || merged.use.has_value())
    merged.use = uses;

  if (exportStartOption.isSet())
    merged.exportStart = convertEmptyStringToNullOpt(exportStartOption.get());
  if (exportRuntimeOption.isSet())
    merged.exportRuntime = exportRuntimeOption.get();
  if (exportTableOption.isSet())
    merged.exportTable = exportTableOption.get();
  if (initialMemoryOption.isSet())
    merged.initialMemory = initialMemoryOption.get();
  if (stackSizeOption.isSet())
    merged.stackSize = stackSizeOption.get();
  if (runtimeOption.isSet())
    merged.runtime = convertEmptyStringToNullOpt(runtimeOption.get());

  if (optimizeLevelOption.isSet())
    merged.optimizeLevel = std::min(3U, optimizeLevelOption.get());
  if (shrinkLevelOption.isSet())
    merged.shrinkLevel = std::min(2U, shrinkLevelOption.get());
  if (debugOption.isSet())
    merged.debug = debugOption.get();

  if (disableFeatureOptions.isSet())
    merged.features = Features::all() & ~Features::fromString(disableFeatureOptions.get());

  return merged;
}

std::vector<std::string> ConfigProvider::mergedEntryPaths() {
  std::set<std::string> mergedEntries;

  std::optional<MergedFileConfig> const &fileCfg = MergedFileConfig::getConfigFromFile();
  if (fileCfg.has_value())
    mergedEntries.insert(fileCfg->entries.begin(), fileCfg->entries.end());

  std::vector<std::string> const &cliEntries = entryPathsOption.get();
  mergedEntries.insert(cliEntries.begin(), cliEntries.end());

  return std::vector<std::string>{mergedEntries.begin(), mergedEntries.end()};
}

std::optional<std::filesystem::path> ConfigProvider::outputPath() {
  if (outputPathOption.isSet())
    return outputPathOption.get();

  std::optional<MergedFileConfig> const &fileCfg = MergedFileConfig::getConfigFromFile();
  if (fileCfg.has_value() && fileCfg->options.outFile.has_value())
    return fileCfg->options.outFile.value();

  return std::nullopt;
}

Features ConfigProvider::features() {
  if (disableFeatureOptions.isSet())
    return Features::all() & ~Features::fromString(disableFeatureOptions.get());

  std::optional<MergedFileConfig> const &fileCfg = MergedFileConfig::getConfigFromFile();
  if (fileCfg.has_value() && fileCfg->options.features.has_value())
    return fileCfg->options.features.value();

  return Features::all();
}

uint32_t ConfigProvider::optimizationLevel() {
  if (optimizeLevelOption.isSet())
    return std::min(3U, optimizeLevelOption.get());

  std::optional<MergedFileConfig> const &fileCfg = MergedFileConfig::getConfigFromFile();
  if (fileCfg.has_value() && fileCfg->options.optimizeLevel.has_value())
    return std::min(3U, fileCfg->options.optimizeLevel.value());

  return 0U;
}

uint32_t ConfigProvider::shrinkLevel() {
  if (shrinkLevelOption.isSet())
    return std::min(2U, shrinkLevelOption.get());

  std::optional<MergedFileConfig> const &fileCfg = MergedFileConfig::getConfigFromFile();
  if (fileCfg.has_value() && fileCfg->options.shrinkLevel.has_value())
    return std::min(2U, fileCfg->options.shrinkLevel.value());

  return 0U;
}

bool ConfigProvider::isDebugEnabled() {
  if (debugOption.isSet())
    return debugOption.get();

  std::optional<MergedFileConfig> const &fileCfg = MergedFileConfig::getConfigFromFile();
  if (fileCfg.has_value() && fileCfg->options.debug.has_value())
    return fileCfg->options.debug.value();

  return false;
}

} // namespace warpo::common
