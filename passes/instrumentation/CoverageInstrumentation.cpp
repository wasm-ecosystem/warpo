// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <binaryen-c.h>
#include <cassert>
#include <cstdlib>
#include <string>
#include <string_view>
#include <unordered_map>

#include "BasicBlockAnalysis.hpp"
#include "BasicBlockWalker.hpp"
#include "CovInstrumentationWalker.hpp"
#include "CoverageInstrumentation.hpp"
#include "MockInstrumentationWalker.hpp"
#include "nlohmann/json.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm.h"

namespace warpo::passes::instrumentation {

static constexpr std::string_view defaultCoverageDebugInfoSectionName = "warpo.coverage.debug-info";
static constexpr std::string_view defaultTestExpectInfoSectionName = "warpo.test.expect-info";

static void addCustomSection(wasm::Module &module, std::string const &sectionName, std::string const &payload) {
  if (sectionName.empty() || payload.empty())
    return;
  BinaryenAddCustomSection(&module, sectionName.c_str(), payload.data(), static_cast<wasm::Index>(payload.size()));
}

static void setupBasicBlockAnalysis(BasicBlockAnalysis &basicBlockAnalysis,
                                    CoverageInstrumentationConfig const &coverageConfig) noexcept {
  if (coverageConfig.skipLib)
    basicBlockAnalysis.addExclude("~lib/.+");
}

static void runCoverageOnlyPart(wasm::Module &module, CoverageInstrumentationConfig const &coverageConfig) {
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

  addCustomSection(module, std::string(defaultCoverageDebugInfoSectionName), json.dump());

  CovInstrumentationWalker covWalker(&module, coverageConfig.reportFunction.data(), basicBlockWalker);
  covWalker.covWalk();
}

static void runTestOnlyPart(wasm::Module &module, std::unordered_map<uint32_t, std::string> &outExpectInfos) {
  MockInstrumentationWalker mockWalker(&module);
  mockWalker.mockWalk();
  outExpectInfos = mockWalker.getExpectInfos();
}

static void instrumentModule(wasm::Module &module, CoverageInstrumentationConfig const *const coverageConfig) {
  if (coverageConfig != nullptr) {
    assert(!coverageConfig->reportFunction.empty());
    runCoverageOnlyPart(module, *coverageConfig);
  }

  std::unordered_map<uint32_t, std::string> expectInfos{};
  runTestOnlyPart(module, expectInfos);

  nlohmann::json expectInfosJson = nlohmann::json::object();
  for (const auto &[key, value] : expectInfos) {
    expectInfosJson[std::to_string(key)] = value;
  }

  addCustomSection(module, std::string(defaultTestExpectInfoSectionName), expectInfosJson.dump());
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

void passes::instrumentation::runCoverageInstrumentation(wasm::Module &m) {
  if (!enableCoverageInstrumentationOption.get())
    return;
  CoverageInstrumentationConfig coverageConfig{};
  coverageConfig.reportFunction = instrumentationReportFunctionOption.get();
  coverageConfig.skipLib = !instrumentationIncludeLibOption.get();

  CoverageInstrumentationConfig const *const coverageCfgPtr =
      instrumentationDisableCoverageOption.get() ? nullptr : &coverageConfig;

  instrumentModule(m, coverageCfgPtr);
}

} // namespace warpo
