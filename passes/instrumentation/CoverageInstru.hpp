// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <filesystem>
#include <ios>
#include <ostream>
#include <string>
#include <vector>

#include "InstrumentResponse.hpp"

namespace warpo::passes::instrumentation {

class BasicBlockAnalysis;
///
/// @brief Customer input configuration for instrumentation
///
class InstrumentationConfig final {
public:
  ///
  /// @brief Default constructor for InstrumentationConfig
  ///
  InstrumentationConfig() noexcept = default;
  std::string fileName;                 ///< input file name
  std::string targetName;               ///< target file name
  std::string reportFunction;           ///< trace report function name
  std::string sourceMap;                ///< input source map file name
  std::string debugInfoOutputFilePath;  ///< debug info output file name
  std::vector<std::string> excludes;    ///< function exclude filter
  std::string expectInfoOutputFilePath; ///< exception info output file name
  bool skipLib = true;                  ///< if skip lib functions
  bool collectCoverage = true;          ///< whether collect coverage information

  ///
  ///@brief Print information of InstrumentationConfig to output stream
  ///
  ///@param out target output stream
  ///@param instance
  ///@return processed output stream
  friend std::ostream &operator<<(std::ostream &out, const InstrumentationConfig &instance) noexcept {
    out << "filename: " << instance.fileName << ", targetName: " << instance.targetName
        << ", sourceMap: " << instance.sourceMap << ", reportFunction:" << instance.reportFunction << ", excludes: [";
    for (size_t i = 0; i < instance.excludes.size(); ++i) {
      if (i > 0)
        out << ", ";
      out << instance.excludes[i];
    }
    out << "], expectInfoOutputFilePath: " << instance.expectInfoOutputFilePath << ", skipLib: " << std::boolalpha
        << instance.skipLib << ", collectCoverage: " << std::boolalpha << instance.collectCoverage << std::endl;
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
  explicit CoverageInstrumentation(InstrumentationConfig const *const cfg) noexcept : config(cfg) {}
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
  ///@return InstrumentationResponse
  InstrumentationResponse instrument() const noexcept;

private:
  InstrumentationConfig const *const config; ///< customer configuration for instrumentation
  ///
  ///@brief Do preparation and analysis module
  ///
  void innerAnalysis(BasicBlockAnalysis &basicBlockAnalysis) const noexcept;
};

bool isCoverageInstrumentationEnabled();

InstrumentationResponse runCoverageInstrumentation(std::filesystem::path const &inputWasm,
                                                   std::filesystem::path const &outputWasm,
                                                   std::filesystem::path const &sourceMapPath);
} // namespace warpo::passes::instrumentation
