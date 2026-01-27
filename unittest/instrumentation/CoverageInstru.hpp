#ifndef __ASC_COV_COVERAGE_INSTRU_HPP__
#define __ASC_COV_COVERAGE_INSTRU_HPP__
#include "json/json.h"
#include "json/value.h"
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <cstdio>
#include <filesystem>
#include <fstream>
#include <ios>
#include <iostream>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>
#include "BasicBlockAnalysis.hpp"
#include "BasicBlockWalker.hpp"
#include "CovInstrumentationWalker.hpp"
#include "InstrumentResponse.hpp"
#include "MockInstrumentationWalker.hpp"
#include "binaryen-c.h"
#include "support/index.h"
#include "wasm-io.h"
#include "wasm.h"

namespace wasmInstrumentation {
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
  friend std::ostream &operator<<(std::ostream &out,
                                  const InstrumentationConfig &instance) noexcept {
    out << "filename: " << instance.fileName << ", targetName: " << instance.targetName
        << ", sourceMap: " << instance.sourceMap << ", reportFunction:" << instance.reportFunction
        << ", excludes: " << instance.excludes
        << ", expectInfoOutputFilePath: " << instance.expectInfoOutputFilePath
        << ", skipLib: " << std::boolalpha << instance.skipLib
        << ", collectCoverage: " << std::boolalpha << instance.collectCoverage << std::endl;
    return out;
  }
};

///
/// @brief Main instrumentation class
///
class CoverageInstru final {

public:
  ///
  ///@brief Constructor for coverage instrumentation
  ///
  ///@param cfg configuration from customer
  explicit CoverageInstru(InstrumentationConfig const *const cfg) noexcept : config(cfg) {
  }
  CoverageInstru(const CoverageInstru &src) = delete; // disable copy construct
  CoverageInstru(CoverageInstru &&src) = delete;      // disable move construct
  CoverageInstru &operator=(const CoverageInstru &) = delete;
  CoverageInstru &operator=(CoverageInstru &&) = delete;
  ///
  ///@brief Destructor for CoverageInstru
  ///
  ~CoverageInstru() noexcept = default;

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
} // namespace wasmInstrumentation

// export wasm API
#if defined(__EMSCRIPTEN__)
#include <emscripten/emscripten.h>
///
///@brief Common public API for instrument process
///
///@param fileName
///@param targetName
///@param reportFunction
///@param sourceMap
///@param expectInfoOutputFilePath
///@param debugInfoOutputFilePath
///@param includes
///@param excludes
///@param skipLib
///@return InstrumentationResponse
extern "C" EMSCRIPTEN_KEEPALIVE wasmInstrumentation::InstrumentationResponse
wasm_instrument(char const *const fileName, char const *const targetName,
                char const *const reportFunction, char const *const sourceMap,
                char const *const expectInfoOutputFilePath,
                char const *const debugInfoOutputFilePath, char const *const excludes, bool skipLib,
                bool collectCoverage) noexcept;
#endif
#endif
