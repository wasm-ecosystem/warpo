// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <filesystem>
#include <ios>
#include <ostream>
#include <string>
#include <vector>

namespace warpo::passes::instrumentation {

class BasicBlockAnalysis;

struct InstrumentationIOConfig final {
  std::string fileName;   ///< input file name
  std::string targetName; ///< target file name
  std::string sourceMap;  ///< input source map file name

  friend std::ostream &operator<<(std::ostream &out, InstrumentationIOConfig const &instance) noexcept {
    out << "filename: " << instance.fileName << ", targetName: " << instance.targetName
        << ", sourceMap: " << instance.sourceMap;
    return out;
  }
};

struct CoverageInstrumentationConfig final {
  std::string reportFunction;          ///< coverage report function name
  std::string debugInfoOutputFilePath; ///< debug info output file name
  std::vector<std::string> excludes;   ///< function exclude filter
  bool skipLib = true;                 ///< if skip lib functions

  friend std::ostream &operator<<(std::ostream &out, CoverageInstrumentationConfig const &instance) noexcept {
    out << "reportFunction: " << instance.reportFunction
        << ", debugInfoOutputFilePath: " << instance.debugInfoOutputFilePath << ", excludes: [";
    for (size_t i = 0; i < instance.excludes.size(); ++i) {
      if (i > 0)
        out << ", ";
      out << instance.excludes[i];
    }
    out << "], skipLib: " << std::boolalpha << instance.skipLib;
    return out;
  }
};

struct TestInstrumentationConfig final {
  std::string expectInfoOutputFilePath; ///< expectation info output file name

  friend std::ostream &operator<<(std::ostream &out, TestInstrumentationConfig const &instance) noexcept {
    out << "expectInfoOutputFilePath: " << instance.expectInfoOutputFilePath;
    return out;
  }
};

///
/// @brief Main instrumentation class
///
class CoverageInstrumentation final {

public:
  ///
  ///@brief Constructor for coverage instrumentation
  ///
  ///@param cfg configuration from customer
  explicit CoverageInstrumentation(InstrumentationIOConfig const *const ioCfg,
                                   CoverageInstrumentationConfig const *const coverageCfg,
                                   TestInstrumentationConfig const *const testCfg) noexcept
      : ioConfig(ioCfg), coverageConfig(coverageCfg), testConfig(testCfg) {}
  CoverageInstrumentation(const CoverageInstrumentation &src) = delete; // disable copy construct
  CoverageInstrumentation(CoverageInstrumentation &&src) = delete;      // disable move construct
  CoverageInstrumentation &operator=(const CoverageInstrumentation &) = delete;
  CoverageInstrumentation &operator=(CoverageInstrumentation &&) = delete;
  ///
  ///@brief Destructor for CoverageInstrumentation
  ///
  ~CoverageInstrumentation() noexcept = default;

  ///
  ///@brief Common public API for instrument process
  ///
  void instrument() const;

private:
  InstrumentationIOConfig const *const ioConfig;
  CoverageInstrumentationConfig const *const coverageConfig;
  TestInstrumentationConfig const *const testConfig;
  ///
  ///@brief Do preparation and analysis module
  ///
  void innerAnalysis(BasicBlockAnalysis &basicBlockAnalysis) const noexcept;
};

bool isCoverageInstrumentationEnabled();

void runCoverageOnlyInstrumentation(std::filesystem::path const &inputWasm, std::filesystem::path const &outputWasm,
                                    std::filesystem::path const &sourceMapPath);

void runTestInstrumentation(std::filesystem::path const &inputWasm, std::filesystem::path const &outputWasm,
                            std::filesystem::path const &sourceMapPath);

void runCoverageInstrumentation(std::filesystem::path const &inputWasm, std::filesystem::path const &outputWasm,
                                std::filesystem::path const &sourceMapPath);
} // namespace warpo::passes::instrumentation
