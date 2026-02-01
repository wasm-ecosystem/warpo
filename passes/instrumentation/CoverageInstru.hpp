// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <ios>
#include <ostream>
#include <string_view>

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
  std::string_view fileName;                 ///< input file name
  std::string_view targetName;               ///< target file name
  std::string_view reportFunction;           ///< trace report function name
  std::string_view sourceMap;                ///< input source map file name
  std::string_view debugInfoOutputFilePath;  ///< debug info output file name
  std::string_view excludes;                 ///< function exclude filter
  std::string_view expectInfoOutputFilePath; ///< exception info output file name
  bool skipLib = true;                       ///< if skip lib functions
  bool collectCoverage = true;               ///< whether collect coverage information

  ///
  ///@brief Print information of InstrumentationConfig to output stream
  ///
  ///@param out target output stream
  ///@param instance
  ///@return processed output stream
  friend std::ostream &operator<<(std::ostream &out, const InstrumentationConfig &instance) noexcept {
    out << "filename: " << instance.fileName << ", targetName: " << instance.targetName
        << ", sourceMap: " << instance.sourceMap << ", reportFunction:" << instance.reportFunction
        << ", excludes: " << instance.excludes << ", expectInfoOutputFilePath: " << instance.expectInfoOutputFilePath
        << ", skipLib: " << std::boolalpha << instance.skipLib << ", collectCoverage: " << std::boolalpha
        << instance.collectCoverage << std::endl;
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
} // namespace warpo::passes::instrumentation
