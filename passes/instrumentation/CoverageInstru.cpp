// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <binaryen-c.h>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <ostream>
#include <string>
#include <string_view>
#include <unordered_map>

#include "BasicBlockAnalysis.hpp"
#include "BasicBlockWalker.hpp"
#include "CovInstrumentationWalker.hpp"
#include "CoverageInstru.hpp"
#include "MockInstrumentationWalker.hpp"
#include "nlohmann/json.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm-io.h"
#include "wasm.h"

namespace warpo::passes::instrumentation {

void CoverageInstrumentation::innerAnalysis(BasicBlockAnalysis &basicBlockAnalysis) const noexcept {
  if (config->skipLib) {
    basicBlockAnalysis.addExclude("~lib/.+");
  }
  if (config->excludes.empty()) {
    return;
  }
  for (std::string const &excludeItem : config->excludes) {
    if (!excludeItem.empty())
      basicBlockAnalysis.addExclude(excludeItem);
  }
}

InstrumentationResponse CoverageInstrumentation::instrument() const noexcept {
  if (config->fileName.empty() || config->reportFunction.empty() || config->sourceMap.empty() ||
      config->targetName.empty() || config->expectInfoOutputFilePath.empty()) {
    std::cout << *config << std::endl;
    return InstrumentationResponse::CONFIG_ERROR; // config error
  }
  std::filesystem::path const filePath(config->fileName);
  std::filesystem::path const targetFilePath(config->targetName);
  std::filesystem::path const sourceMapPath(config->sourceMap);
  if ((!std::filesystem::exists(filePath)) || (!std::filesystem::exists(sourceMapPath)) ||
      (!std::filesystem::exists(targetFilePath.parent_path()))) {
    std::cout << *config << std::endl;
    return InstrumentationResponse::CONFIG_FILEPATH_ERROR; // config file path error
  }

  wasm::Module module;
  wasm::ModuleReader reader;
  reader.read(std::string(config->fileName), module, std::string(config->sourceMap));
  BasicBlockAnalysis basicBlockAnalysis = BasicBlockAnalysis();
  innerAnalysis(basicBlockAnalysis);

  if (config->collectCoverage) {
    if (config->debugInfoOutputFilePath.empty()) {
      std::cout << *config << std::endl;
      return InstrumentationResponse::CONFIG_ERROR; // config error
    }
    std::filesystem::path const debugInfoPath(config->debugInfoOutputFilePath);
    if ((!std::filesystem::exists(debugInfoPath.parent_path()))) {
      std::cout << *config << std::endl;
      return InstrumentationResponse::CONFIG_FILEPATH_ERROR; // config file path error
    }

    BasicBlockWalker basicBlockWalker = BasicBlockWalker(&module, basicBlockAnalysis);
    basicBlockWalker.basicBlockWalk();
    const std::unordered_map<std::string_view, FunctionAnalysisResult> &results = basicBlockWalker.getResults();
    nlohmann::json json = nlohmann::json::object();
    nlohmann::json debugInfoJson = nlohmann::json::object();
    nlohmann::json debugFileJson = nlohmann::json::array();
    for (auto &[function, result] : results) {
      nlohmann::json innerJson = nlohmann::json::object();
      innerJson["index"] = result.functionIndex;

      nlohmann::json branchInfoArray = nlohmann::json::array();
      for (const auto &branchInfo : result.branchInfo) {
        branchInfoArray.push_back(nlohmann::json::array({branchInfo.first, branchInfo.second}));
      }
      innerJson["branchInfo"] = std::move(branchInfoArray);

      nlohmann::json debugLineJson = nlohmann::json::array();
      for (const auto &basicBlock : result.basicBlocks) {
        if (basicBlock.basicBlockIndex == static_cast<wasm::Index>(-1)) {
          continue;
        }

        nlohmann::json debugLineItemJsonArray = nlohmann::json::array();
        for (const auto &debugLine : basicBlock.debugLocations) {
          debugLineItemJsonArray.push_back(
              nlohmann::json::array({debugLine.fileIndex, debugLine.lineNumber, debugLine.columnNumber}));
        }

        const size_t basicBlockIndex = static_cast<size_t>(basicBlock.basicBlockIndex);
        while (debugLineJson.size() <= basicBlockIndex) {
          debugLineJson.push_back(nullptr);
        }
        debugLineJson[basicBlockIndex] = std::move(debugLineItemJsonArray);
      }
      innerJson["lineInfo"] = std::move(debugLineJson);
      debugInfoJson[std::string(function)] = std::move(innerJson);
    }
    for (const std::string &debugInfoFileName : module.debugInfoFileNames) {
      debugFileJson.push_back(debugInfoFileName);
    }
    json["debugInfos"] = std::move(debugInfoJson);
    json["debugFiles"] = std::move(debugFileJson);
    std::ofstream jsonWriteStream(config->debugInfoOutputFilePath.data(), std::ios::trunc);

    try {
      jsonWriteStream << json.dump();
    } catch (...) {
      // Hard to control IO error
      // LCOV_EXCL_START
      return InstrumentationResponse::DEBUG_INFO_GENERATION_ERROR; // debug info json write failed
      // LCOV_EXCL_STOP
    }
    jsonWriteStream.close();
    if (jsonWriteStream.fail() || jsonWriteStream.bad()) {
      // Hard to control IO error
      // LCOV_EXCL_START
      return InstrumentationResponse::DEBUG_INFO_GENERATION_ERROR; // debug info json write failed
      // LCOV_EXCL_STOP
    }
    CovInstrumentationWalker covWalker(&module, config->reportFunction.data(), basicBlockWalker);
    covWalker.covWalk();
  }

  MockInstrumentationWalker mockWalker(&module);
  mockWalker.mockWalk();

  const std::string targetSourceMapPath = std::string{this->config->targetName} + ".map";
  BinaryenSetDebugInfo(true);
  const BinaryenModuleAllocateAndWriteResult result =
      BinaryenModuleAllocateAndWrite(&module, targetSourceMapPath.c_str());
  std::ofstream wasmFileStream(this->config->targetName.data(), std::ios::trunc | std::ios::binary);
  wasmFileStream.write(static_cast<char *>(result.binary), static_cast<std::streamsize>(result.binaryBytes));
  std::ofstream sourceMapFileStream(targetSourceMapPath, std::ios::trunc | std::ios::binary);
  sourceMapFileStream << result.sourceMap << std::flush;
  free(result.binary);
  free(result.sourceMap);
  if (wasmFileStream.fail() || wasmFileStream.bad()) {
    // Hard to control IO error
    // LCOV_EXCL_START
    return InstrumentationResponse::FILE_GENERATION_ERROR; // debug info json write failed
    // LCOV_EXCL_STOP
  }

  nlohmann::json expectInfosJson = nlohmann::json::object();
  for (const auto &[key, value] : mockWalker.getExpectInfos()) {
    // Mock test will verified with wasm-testing-framework project, escape this
    // LCOV_EXCL_START
    expectInfosJson[std::to_string(key)] = value;
    // LCOV_EXCL_STOP
  }
  std::ofstream expectInfosJsonWriteStream(config->expectInfoOutputFilePath.data(), std::ios::trunc);
  try {
    expectInfosJsonWriteStream << expectInfosJson.dump();
  } catch (...) {
    // Hard to control IO error
    // LCOV_EXCL_START
    return InstrumentationResponse::EXPECT_INFO_GENERATION_ERROR; // expectation info generation
                                                                  // failed
    // LCOV_EXCL_STOP
  }
  expectInfosJsonWriteStream.close();
  if (expectInfosJsonWriteStream.fail() || expectInfosJsonWriteStream.bad()) {
    // Hard to control IO error
    // LCOV_EXCL_START
    return InstrumentationResponse::EXPECT_INFO_GENERATION_ERROR; // expectation info generation
                                                                  // failed
    // LCOV_EXCL_STOP
  }
  return InstrumentationResponse::NORMAL;
}

} // namespace warpo::passes::instrumentation

namespace warpo {

static cli::Opt<bool> enableCoverageInstrumentationOption{
    cli::Category::Transformation,
    "--instrument",
    [](argparse::Argument &arg) -> void { arg.help("Enable coverage instrumentation.").flag(); },
};

static cli::Opt<std::string> instrumentationReportFunctionOption{
    cli::Category::Transformation,
    "--instrument-report-function",
    [](argparse::Argument &arg) -> void { arg.help("Coverage report function name.").nargs(1U); },
};

static cli::Opt<std::string> instrumentationDebugInfoOutputOption{
    cli::Category::Transformation,
    "--instrument-debug-info-output",
    [](argparse::Argument &arg) -> void { arg.help("Output path for coverage debug info json.").nargs(1U); },
};

static cli::Opt<std::string> instrumentationExpectInfoOutputOption{
    cli::Category::Transformation,
    "--instrument-expect-info-output",
    [](argparse::Argument &arg) -> void { arg.help("Output path for expectation info json.").nargs(1U); },
};

static cli::Opt<std::vector<std::string>> instrumentationExcludeOption{
    cli::Category::Transformation,
    "--instrument-exclude",
    [](argparse::Argument &arg) -> void {
      arg.help("Exclude function regex (repeatable).").nargs(argparse::nargs_pattern::at_least_one).append();
    },
};

static cli::Opt<bool> instrumentationIncludeLibOption{
    cli::Category::Transformation,
    "--instrument-include-lib",
    [](argparse::Argument &arg) -> void { arg.help("Include library functions in coverage.").flag(); },
};

static cli::Opt<bool> instrumentationDisableCoverageOption{
    cli::Category::Transformation,
    "--instrument-no-coverage",
    [](argparse::Argument &arg) -> void { arg.help("Disable coverage collection.").flag(); },
};

} // namespace warpo

namespace warpo::passes::instrumentation {

bool isCoverageInstrumentationEnabled() { return enableCoverageInstrumentationOption.get(); }

InstrumentationResponse runCoverageInstrumentation(std::filesystem::path const &inputWasm,
                                                   std::filesystem::path const &outputWasm,
                                                   std::filesystem::path const &sourceMapPath) {
  if (!isCoverageInstrumentationEnabled())
    return InstrumentationResponse::NORMAL;

  InstrumentationConfig config{};
  config.fileName = inputWasm.string();
  config.targetName = outputWasm.string();
  config.sourceMap = sourceMapPath.string();
  config.reportFunction = instrumentationReportFunctionOption.get();
  config.debugInfoOutputFilePath = instrumentationDebugInfoOutputOption.get();
  config.expectInfoOutputFilePath = instrumentationExpectInfoOutputOption.get();
  config.excludes = instrumentationExcludeOption.get();
  config.skipLib = !instrumentationIncludeLibOption.get();
  config.collectCoverage = !instrumentationDisableCoverageOption.get();

  CoverageInstrumentation const instrumentation(&config);
  return instrumentation.instrument();
}

} // namespace warpo::passes::instrumentation
