// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstddef>
#include <exception>
#include <fmt/format.h>
#include <map>
#include <nlohmann/json.hpp>
#include <optional>
#include <stdexcept>
#include <string>
#include <vector>

#include "ConfigFile.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo::common {

namespace {

struct FileConfigJson {
  std::vector<std::string> entries;
  FileConfigOptions options;
  std::map<std::string, FileConfigOptions> targets;
};

cli::Opt<std::string> configOption{
    cli::Category::Frontend,
    "--config",
    [](argparse::Argument &arg) -> void { arg.help("Specifies the path to the asconfig.json file.").nargs(1); },
};

cli::Opt<std::string> targetOption{
    cli::Category::Frontend,
    "--target",
    [](argparse::Argument &arg) -> void {
      arg.help("Specifies the target configuration to use from asconfig.json.").nargs(1);
    },
};

} // namespace

void UsesOption::merge(std::string const &useStr) {
  size_t const eqPos = useStr.find('=');
  if (eqPos != std::string::npos && eqPos != 0) {
    this->insert_or_assign(useStr.substr(0, eqPos), useStr.substr(eqPos + 1));
  } else {
    throw std::runtime_error{fmt::format("Invalid use option: {}", useStr)};
  }
}

static FileConfigOptions parseFileConfigOptions(nlohmann::json const &jsonOptions) {
  FileConfigOptions config;
  try {
    if (jsonOptions.contains("outFile"))
      config.outFile = jsonOptions["outFile"].get<std::string>();
    if (jsonOptions.contains("exportStart"))
      config.exportStart = jsonOptions["exportStart"].get<std::string>();
    if (jsonOptions.contains("exportRuntime"))
      config.exportRuntime = jsonOptions["exportRuntime"].get<bool>();
    if (jsonOptions.contains("exportTable"))
      config.exportTable = jsonOptions["exportTable"].get<bool>();
    if (jsonOptions.contains("initialMemory"))
      config.initialMemory = jsonOptions["initialMemory"].get<uint32_t>();
    if (jsonOptions.contains("stackSize"))
      config.stackSize = jsonOptions["stackSize"].get<uint32_t>();
    if (jsonOptions.contains("runtime"))
      config.runtime = jsonOptions["runtime"].get<std::string>();
    if (jsonOptions.contains("optimizeLevel"))
      config.optimizeLevel = jsonOptions["optimizeLevel"].get<uint32_t>();
    if (jsonOptions.contains("shrinkLevel"))
      config.shrinkLevel = jsonOptions["shrinkLevel"].get<uint32_t>();
    if (jsonOptions.contains("debug"))
      config.debug = jsonOptions["debug"].get<bool>();
    if (jsonOptions.contains("sourceMap"))
      config.sourceMap = jsonOptions["sourceMap"].get<bool>();
    if (jsonOptions.contains("use")) {
      config.use = UsesOption{};
      for (const auto &[useKey, useEntry] : jsonOptions["use"].items()) {
        config.use->insert_or_assign(useKey, useEntry.get<std::string>());
      }
    }
    if (jsonOptions.contains("disable"))
      config.features = Features::all() & ~Features::fromString(jsonOptions["disable"].get<std::vector<std::string>>());
  } catch (std::exception const &e) {
    throw std::runtime_error{fmt::format("Failed to parse json options: {}", e.what())};
  }
  return config;
}

static FileConfigOptions mergeFileConfigOptions(FileConfigOptions const &baseConfig,
                                                FileConfigOptions const &overrideConfig) {
  FileConfigOptions result = baseConfig;
  if (overrideConfig.outFile.has_value())
    result.outFile = overrideConfig.outFile;
  if (overrideConfig.exportStart.has_value())
    result.exportStart = overrideConfig.exportStart;
  if (overrideConfig.exportRuntime.has_value())
    result.exportRuntime = overrideConfig.exportRuntime;
  if (overrideConfig.exportTable.has_value())
    result.exportTable = overrideConfig.exportTable;
  if (overrideConfig.initialMemory.has_value())
    result.initialMemory = overrideConfig.initialMemory;
  if (overrideConfig.stackSize.has_value())
    result.stackSize = overrideConfig.stackSize;
  if (overrideConfig.runtime.has_value())
    result.runtime = overrideConfig.runtime;
  if (overrideConfig.optimizeLevel.has_value())
    result.optimizeLevel = overrideConfig.optimizeLevel;
  if (overrideConfig.shrinkLevel.has_value())
    result.shrinkLevel = overrideConfig.shrinkLevel;
  if (overrideConfig.debug.has_value())
    result.debug = overrideConfig.debug;
  if (overrideConfig.sourceMap.has_value())
    result.sourceMap = overrideConfig.sourceMap;
  if (overrideConfig.use.has_value())
    result.use = overrideConfig.use;
  if (overrideConfig.features.has_value())
    result.features = overrideConfig.features;
  return result;
}

static FileConfigJson parseFileConfigJson(std::string const &configContent) {
  try {
    nlohmann::json configJson = nlohmann::json::parse(configContent);
    FileConfigJson configFile;

    // Parse entries
    if (configJson.contains("entries")) {
      configFile.entries = configJson["entries"].get<std::vector<std::string>>();
    }

    // Parse global options
    if (configJson.contains("options")) {
      configFile.options = parseFileConfigOptions(configJson["options"]);
    }

    // Parse targets
    if (configJson.contains("targets")) {
      auto const &targetsJson = configJson["targets"];
      for (auto const &[targetName, targetJson] : targetsJson.items()) {
        configFile.targets[targetName] = parseFileConfigOptions(targetJson);
      }
    }
    return configFile;
  } catch (std::exception const &e) {
    throw std::runtime_error{fmt::format("Failed to parse config file: {}", e.what())};
  }
}

static std::optional<MergedFileConfig> createFileConfigImpl(std::string const configContent,
                                                            std::optional<std::string> const &target) {
  FileConfigJson const fileConfigJson = parseFileConfigJson(configContent);
  return MergedFileConfig{
      .entries = fileConfigJson.entries,
      .options = target.has_value()
                     ? mergeFileConfigOptions(fileConfigJson.options, fileConfigJson.targets.at(target.value()))
                     : fileConfigJson.options,
  };
}

std::optional<MergedFileConfig> createFileConfig() {
  if (configOption.notSet())
    return std::nullopt;
  std::string const configContent = readTextFile(configOption.get());
  return createFileConfigImpl(configContent, targetOption.tryGet());
}

std::optional<MergedFileConfig> const &MergedFileConfig::getConfigFromFile() {
  static std::optional<MergedFileConfig> const fileConfig = createFileConfig();
  return fileConfig;
}

} // namespace warpo::common

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

namespace warpo::common::ut {

TEST(TestConfigFile, TestParseFileConfigOptions) {
  // Test parsing complete JSON options
  std::string const jsonStr = R"({
    "exportStart": "start",
    "exportRuntime": true,
    "exportTable": false,
    "initialMemory": 65536,
    "runtime": "instantiate",
    "optimizeLevel": 3,
    "shrinkLevel": 2,
    "debug": true,
    "sourceMap": false,
    "use": { "U1": "10" }
  })";
  nlohmann::json const jsonOptions = nlohmann::json::parse(jsonStr);

  FileConfigOptions const config = parseFileConfigOptions(jsonOptions);

  EXPECT_EQ(config.exportStart, "start");
  EXPECT_EQ(config.exportRuntime, true);
  EXPECT_EQ(config.exportTable, false);
  EXPECT_EQ(config.initialMemory, 65536);
  EXPECT_EQ(config.runtime, "instantiate");
  EXPECT_EQ(config.optimizeLevel, 3);
  EXPECT_EQ(config.shrinkLevel, 2);
  EXPECT_EQ(config.debug, true);
  EXPECT_EQ(config.sourceMap, false);
  EXPECT_EQ(config.use->at("U1"), "10");

  // Test parsing partial JSON options
  std::string const partialJsonStr = R"({
    "exportStart": "main",
    "debug": false
  })";
  nlohmann::json const partialJson = nlohmann::json::parse(partialJsonStr);

  FileConfigOptions const partialConfig = parseFileConfigOptions(partialJson);

  EXPECT_EQ(partialConfig.exportStart, "main");
  EXPECT_EQ(partialConfig.debug, false);
  EXPECT_FALSE(partialConfig.exportRuntime.has_value());
  EXPECT_FALSE(partialConfig.initialMemory.has_value());

  // Test empty JSON options
  nlohmann::json const emptyJson = {};
  FileConfigOptions const emptyConfig = parseFileConfigOptions(emptyJson);

  EXPECT_FALSE(emptyConfig.exportStart.has_value());
  EXPECT_FALSE(emptyConfig.exportRuntime.has_value());
  EXPECT_FALSE(emptyConfig.exportTable.has_value());
  EXPECT_FALSE(emptyConfig.initialMemory.has_value());
  EXPECT_FALSE(emptyConfig.runtime.has_value());
  EXPECT_FALSE(emptyConfig.optimizeLevel.has_value());
  EXPECT_FALSE(emptyConfig.shrinkLevel.has_value());
  EXPECT_FALSE(emptyConfig.debug.has_value());
  EXPECT_FALSE(emptyConfig.sourceMap.has_value());
  EXPECT_FALSE(emptyConfig.use.has_value());
}

TEST(TestConfigFile, TestMergeFileConfigOptions) {
  // Create base config
  FileConfigOptions baseConfig;
  baseConfig.exportStart = "base_start";
  baseConfig.exportRuntime = false;
  baseConfig.debug = true;
  baseConfig.optimizeLevel = 1;

  // Create override config
  FileConfigOptions overrideConfig;
  overrideConfig.exportStart = "override_start";
  overrideConfig.exportTable = true;
  overrideConfig.optimizeLevel = 3;
  overrideConfig.shrinkLevel = 2;

  // Merge configs
  FileConfigOptions const mergedConfig = mergeFileConfigOptions(baseConfig, overrideConfig);

  // Verify merged values
  EXPECT_EQ(mergedConfig.exportStart, "override_start"); // Override takes precedence
  EXPECT_EQ(mergedConfig.exportRuntime, false);          // From base
  EXPECT_EQ(mergedConfig.exportTable, true);             // From override
  EXPECT_EQ(mergedConfig.debug, true);                   // From base
  EXPECT_EQ(mergedConfig.optimizeLevel, 3);              // Override takes precedence
  EXPECT_EQ(mergedConfig.shrinkLevel, 2);                // From override

  // Test merging with empty base
  FileConfigOptions const emptyBase;
  FileConfigOptions const mergedFromEmpty = mergeFileConfigOptions(emptyBase, overrideConfig);

  EXPECT_EQ(mergedFromEmpty.exportStart, "override_start");
  EXPECT_EQ(mergedFromEmpty.exportTable, true);
  EXPECT_FALSE(mergedFromEmpty.exportRuntime.has_value()); // Not set in either

  // Test merging with empty override
  FileConfigOptions const mergedWithEmptyOverride = mergeFileConfigOptions(baseConfig, FileConfigOptions{});

  EXPECT_EQ(mergedWithEmptyOverride.exportStart, "base_start"); // Should retain base values
  EXPECT_EQ(mergedWithEmptyOverride.exportRuntime, false);
  EXPECT_EQ(mergedWithEmptyOverride.debug, true);
  EXPECT_EQ(mergedWithEmptyOverride.optimizeLevel, 1);
}

TEST(TestConfigFile, TestParseFileConfigJson) {
  // Test parsing complete config JSON
  std::string const configContent = R"(
  {
    "entries": ["src/main.ts", "src/module.ts"],
    "options": {
      "exportStart": "main",
      "debug": true,
      "optimizeLevel": 0
    },
    "targets": {
      "release": {
        "debug": false,
        "optimizeLevel": 3,
        "shrinkLevel": 2
      },
      "debug": {
        "debug": true,
        "sourceMap": true
      }
    }
  }
  )";

  FileConfigJson configFile = parseFileConfigJson(configContent);

  // Verify entries
  EXPECT_THAT(configFile.entries, ::testing::ElementsAre("src/main.ts", "src/module.ts"));

  // Verify global options
  EXPECT_EQ(configFile.options.exportStart, "main");
  EXPECT_EQ(configFile.options.debug, true);
  EXPECT_EQ(configFile.options.optimizeLevel, 0);

  // Verify targets
  EXPECT_EQ(configFile.targets.size(), 2);

  // Verify release target
  EXPECT_EQ(configFile.targets["release"].debug, false);
  EXPECT_EQ(configFile.targets["release"].optimizeLevel, 3);
  EXPECT_EQ(configFile.targets["release"].shrinkLevel, 2);

  // Verify debug target
  EXPECT_EQ(configFile.targets["debug"].debug, true);
  EXPECT_EQ(configFile.targets["debug"].sourceMap, true);

  // Test parsing config with only entries
  std::string const minimalConfig = R"(
  {
    "entries": ["src/index.ts"]
  }
  )";

  FileConfigJson const minimalConfigFile = parseFileConfigJson(minimalConfig);
  EXPECT_THAT(minimalConfigFile.entries, ::testing::ElementsAre("src/index.ts"));
  EXPECT_FALSE(minimalConfigFile.options.exportStart.has_value());
  EXPECT_EQ(minimalConfigFile.targets.size(), 0);

  // Test parsing empty config
  std::string const emptyConfig = R"({})";
  FileConfigJson const emptyConfigFile = parseFileConfigJson(emptyConfig);
  EXPECT_TRUE(emptyConfigFile.entries.empty());
  EXPECT_FALSE(emptyConfigFile.options.exportStart.has_value());
  EXPECT_EQ(emptyConfigFile.targets.size(), 0);
}

TEST(TestConfigFile, TestGetFileConfigImpl) {
  std::string const configContent = R"(
  {
    "entries": ["src/main.ts", "src/utils.ts"],
    "options": {
      "exportStart": "main",
      "debug": true,
      "optimizeLevel": 1
    },
    "targets": {
      "debug": {
        "optimizeLevel": 0
      },
      "release": {
        "debug": false,
        "optimizeLevel": 3,
        "shrinkLevel": 2
      }
    }
  }
  )";

  // Test with config file but no target
  {
    std::optional<MergedFileConfig> const result = createFileConfigImpl(configContent, std::nullopt);
    ASSERT_TRUE(result.has_value());
    EXPECT_THAT(result->entries, ::testing::ElementsAre("src/main.ts", "src/utils.ts"));
    EXPECT_EQ(result->options.exportStart, "main");
    EXPECT_EQ(result->options.debug, true);
    EXPECT_EQ(result->options.optimizeLevel, 1);
    EXPECT_FALSE(result->options.shrinkLevel.has_value());
  }

  // Test with config file and existing target
  {
    std::optional<MergedFileConfig> const result = createFileConfigImpl(configContent, "debug");
    ASSERT_TRUE(result.has_value());
    EXPECT_THAT(result->entries, ::testing::ElementsAre("src/main.ts", "src/utils.ts"));
    EXPECT_EQ(result->options.exportStart, "main");
    EXPECT_EQ(result->options.debug, true);
    EXPECT_EQ(result->options.optimizeLevel, 0);
    EXPECT_FALSE(result->options.shrinkLevel.has_value());
  }

  // Test with config file and existing target
  {
    std::optional<MergedFileConfig> const result = createFileConfigImpl(configContent, "release");
    ASSERT_TRUE(result.has_value());
    EXPECT_THAT(result->entries, ::testing::ElementsAre("src/main.ts", "src/utils.ts"));
    EXPECT_EQ(result->options.exportStart, "main"); // From global options
    EXPECT_EQ(result->options.debug, false);        // Overridden by release target
    EXPECT_EQ(result->options.optimizeLevel, 3);    // Overridden by release target
    EXPECT_EQ(result->options.shrinkLevel, 2);      // From release target}
  }
}
} // namespace warpo::common::ut

#endif
