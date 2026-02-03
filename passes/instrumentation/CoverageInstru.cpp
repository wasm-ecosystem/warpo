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

static void setupBasicBlockAnalysis(BasicBlockAnalysis &basicBlockAnalysis,
                                    CoverageInstrumentationConfig const &coverageConfig) noexcept {
  if (coverageConfig.skipLib)
    basicBlockAnalysis.addExclude("~lib/.+");

  if (coverageConfig.excludes.empty())
    return;

  for (std::string const &excludeItem : coverageConfig.excludes) {
    if (!excludeItem.empty())
      basicBlockAnalysis.addExclude(excludeItem);
  }
}

static InstrumentationResponse runCoverageOnlyPart(wasm::Module &module,
                                                   CoverageInstrumentationConfig const &coverageConfig) noexcept {
  BasicBlockAnalysis basicBlockAnalysis = BasicBlockAnalysis();
  setupBasicBlockAnalysis(basicBlockAnalysis, coverageConfig);

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
  std::ofstream jsonWriteStream(coverageConfig.debugInfoOutputFilePath.data(), std::ios::trunc);

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
  CovInstrumentationWalker covWalker(&module, coverageConfig.reportFunction.data(), basicBlockWalker);
  covWalker.covWalk();
  return InstrumentationResponse::NORMAL;
}

static InstrumentationResponse runTestOnlyPart(wasm::Module &module,
                                               std::unordered_map<uint32_t, std::string> &outExpectInfos) noexcept {
  MockInstrumentationWalker mockWalker(&module);
  mockWalker.mockWalk();
  outExpectInfos = mockWalker.getExpectInfos();
  return InstrumentationResponse::NORMAL;
}

void CoverageInstrumentation::innerAnalysis(BasicBlockAnalysis &basicBlockAnalysis) const noexcept {
  (void)basicBlockAnalysis;
}

InstrumentationResponse CoverageInstrumentation::instrument() const noexcept {
  if (ioConfig == nullptr)
    return InstrumentationResponse::CONFIG_ERROR;

  if (ioConfig->fileName.empty() || ioConfig->sourceMap.empty() || ioConfig->targetName.empty()) {
    std::cout << *ioConfig << std::endl;
    return InstrumentationResponse::CONFIG_ERROR; // config error
  }
  if (coverageConfig == nullptr && testConfig == nullptr)
    return InstrumentationResponse::NORMAL;

  if (coverageConfig != nullptr) {
    if (coverageConfig->reportFunction.empty() || coverageConfig->debugInfoOutputFilePath.empty()) {
      std::cout << *ioConfig << ", " << *coverageConfig << std::endl;
      return InstrumentationResponse::CONFIG_ERROR; // config error
    }
  }
  if (testConfig != nullptr) {
    if (testConfig->expectInfoOutputFilePath.empty()) {
      std::cout << *ioConfig << ", " << *testConfig << std::endl;
      return InstrumentationResponse::CONFIG_ERROR; // config error
    }
  }

  std::filesystem::path const filePath(ioConfig->fileName);
  std::filesystem::path const targetFilePath(ioConfig->targetName);
  std::filesystem::path const sourceMapPath(ioConfig->sourceMap);
  if ((!std::filesystem::exists(filePath)) || (!std::filesystem::exists(sourceMapPath)) ||
      (!std::filesystem::exists(targetFilePath.parent_path()))) {
    std::cout << *ioConfig << std::endl;
    return InstrumentationResponse::CONFIG_FILEPATH_ERROR; // config file path error
  }

  if (coverageConfig != nullptr) {
    std::filesystem::path const debugInfoPath(coverageConfig->debugInfoOutputFilePath);
    if ((!std::filesystem::exists(debugInfoPath.parent_path()))) {
      std::cout << *ioConfig << ", " << *coverageConfig << std::endl;
      return InstrumentationResponse::CONFIG_FILEPATH_ERROR; // config file path error
    }
  }

  if (testConfig != nullptr) {
    std::filesystem::path const expectInfoPath(testConfig->expectInfoOutputFilePath);
    if ((!std::filesystem::exists(expectInfoPath.parent_path()))) {
      std::cout << *ioConfig << ", " << *testConfig << std::endl;
      return InstrumentationResponse::CONFIG_FILEPATH_ERROR; // config file path error
    }
  }

  wasm::Module module;
  wasm::ModuleReader reader;
  reader.read(std::string(ioConfig->fileName), module, std::string(ioConfig->sourceMap));
  if (coverageConfig != nullptr) {
    InstrumentationResponse const coverageResult = runCoverageOnlyPart(module, *coverageConfig);
    if (coverageResult != InstrumentationResponse::NORMAL)
      return coverageResult;
  }

  std::unordered_map<uint32_t, std::string> expectInfos{};
  if (testConfig != nullptr) {
    InstrumentationResponse const testResult = runTestOnlyPart(module, expectInfos);
    if (testResult != InstrumentationResponse::NORMAL)
      return testResult;
  }

  const std::string targetSourceMapPath = std::string{this->ioConfig->targetName} + ".map";
  BinaryenSetDebugInfo(true);
  const BinaryenModuleAllocateAndWriteResult result =
      BinaryenModuleAllocateAndWrite(&module, targetSourceMapPath.c_str());
  std::ofstream wasmFileStream(this->ioConfig->targetName.data(), std::ios::trunc | std::ios::binary);
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

  if (testConfig != nullptr) {
    nlohmann::json expectInfosJson = nlohmann::json::object();
    for (const auto &[key, value] : expectInfos) {
      // Mock test will verified with wasm-testing-framework project, escape this
      // LCOV_EXCL_START
      expectInfosJson[std::to_string(key)] = value;
      // LCOV_EXCL_STOP
    }
    std::ofstream expectInfosJsonWriteStream(testConfig->expectInfoOutputFilePath.data(), std::ios::trunc);
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

InstrumentationResponse runCoverageOnlyInstrumentation(std::filesystem::path const &inputWasm,
                                                       std::filesystem::path const &outputWasm,
                                                       std::filesystem::path const &sourceMapPath) {
  if (!isCoverageInstrumentationEnabled())
    return InstrumentationResponse::NORMAL;
  if (instrumentationDisableCoverageOption.get())
    return InstrumentationResponse::NORMAL;

  InstrumentationIOConfig ioConfig{};
  ioConfig.fileName = inputWasm.string();
  ioConfig.targetName = outputWasm.string();
  ioConfig.sourceMap = sourceMapPath.string();

  CoverageInstrumentationConfig coverageConfig{};
  coverageConfig.reportFunction = instrumentationReportFunctionOption.get();
  coverageConfig.debugInfoOutputFilePath = instrumentationDebugInfoOutputOption.get();
  coverageConfig.excludes = instrumentationExcludeOption.get();
  coverageConfig.skipLib = !instrumentationIncludeLibOption.get();

  CoverageInstrumentation const instrumentation(&ioConfig, &coverageConfig, nullptr);
  return instrumentation.instrument();
}

InstrumentationResponse runTestInstrumentation(std::filesystem::path const &inputWasm,
                                               std::filesystem::path const &outputWasm,
                                               std::filesystem::path const &sourceMapPath) {
  if (!isCoverageInstrumentationEnabled())
    return InstrumentationResponse::NORMAL;

  InstrumentationIOConfig ioConfig{};
  ioConfig.fileName = inputWasm.string();
  ioConfig.targetName = outputWasm.string();
  ioConfig.sourceMap = sourceMapPath.string();

  TestInstrumentationConfig testConfig{};
  testConfig.expectInfoOutputFilePath = instrumentationExpectInfoOutputOption.get();

  CoverageInstrumentation const instrumentation(&ioConfig, nullptr, &testConfig);
  return instrumentation.instrument();
}

InstrumentationResponse runCoverageInstrumentation(std::filesystem::path const &inputWasm,
                                                   std::filesystem::path const &outputWasm,
                                                   std::filesystem::path const &sourceMapPath) {
  if (!isCoverageInstrumentationEnabled())
    return InstrumentationResponse::NORMAL;

  InstrumentationIOConfig ioConfig{};
  ioConfig.fileName = inputWasm.string();
  ioConfig.targetName = outputWasm.string();
  ioConfig.sourceMap = sourceMapPath.string();

  CoverageInstrumentationConfig coverageConfig{};
  coverageConfig.reportFunction = instrumentationReportFunctionOption.get();
  coverageConfig.debugInfoOutputFilePath = instrumentationDebugInfoOutputOption.get();
  coverageConfig.excludes = instrumentationExcludeOption.get();
  coverageConfig.skipLib = !instrumentationIncludeLibOption.get();

  TestInstrumentationConfig testConfig{};
  testConfig.expectInfoOutputFilePath = instrumentationExpectInfoOutputOption.get();

  CoverageInstrumentationConfig const *const coverageCfgPtr =
      instrumentationDisableCoverageOption.get() ? nullptr : &coverageConfig;
  TestInstrumentationConfig const *const testCfgPtr =
      testConfig.expectInfoOutputFilePath.empty() ? nullptr : &testConfig;

  CoverageInstrumentation const instrumentation(&ioConfig, coverageCfgPtr, testCfgPtr);
  return instrumentation.instrument();
}

} // namespace warpo::passes::instrumentation
