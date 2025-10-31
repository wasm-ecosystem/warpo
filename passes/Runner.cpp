// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fstream>
#include <ios>
#include <memory>
#include <sstream>
#include <stdexcept>
#include <string>
#include <support/index.h>
#include <utility>
#include <vector>

#include "AdvancedInlining.hpp"
#include "ConditionalReturn.hpp"
#include "ExtractMostFrequentlyUsedGlobals.hpp"
#include "GC/FastLower.hpp"
#include "GC/OptLower.hpp"
#include "ImmutableLoadEliminating.hpp"
#include "InsertTracePoint.hpp"
#include "Runner.hpp"
#include "binaryen-c.h"
#include "parser/wat-parser.h"
#include "pass.h"
#include "warpo/common/AsModule.hpp"
#include "warpo/common/DebugLevel.hpp"
#include "warpo/common/Features.hpp"
#include "warpo/common/OptLevel.hpp"
#include "warpo/passes/DwarfGenerator/DwarfGenerator.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Statistics.hpp"
#include "wasm-binary.h"
#include "wasm-features.h"
#include "wasm-stack.h"
#include "wasm.h"

namespace warpo {

static void ensureValidate(wasm::Module &m) {
  support::PerfRAII const r{support::PerfItemKind::Validation};
  if (!wasm::WasmValidator{}.validate(m))
    throw std::logic_error("validate error");
}

std::unique_ptr<wasm::Module> passes::loadWasm(const std::vector<char> &input) {
  std::unique_ptr<wasm::Module> m{new wasm::Module()};
  wasm::WasmBinaryReader parser(*m, common::Features::fromCLI().toBinaryenFeatureSet(), input);
  parser.read();
  ensureValidate(*m);
  return m;
}

std::unique_ptr<wasm::Module> passes::loadWat(std::string_view wat) {
  std::unique_ptr<wasm::Module> m{new wasm::Module()};
  m->features = common::Features::fromCLI().toBinaryenFeatureSet();
  auto parsed = wasm::WATParser::parseModule(*m, wat);
  if (auto *err = parsed.getErr())
    throw std::logic_error(err->msg);
  ensureValidate(*m);
  return m;
}

void passes::init() { Colors::setEnabled(false); }

static std::unique_ptr<wasm::PassRunner> createPassRunner(wasm::Module *const m) {
  auto passRunner = std::make_unique<wasm::PassRunner>(m);
  passRunner->options.shrinkLevel = static_cast<int32_t>(common::getShrinkLevel());
  passRunner->options.optimizeLevel = static_cast<int32_t>(common::getOptimizationLevel());
  return passRunner;
}

static void preOptimize(AsModule const &m) {
  {
    support::PerfRAII const r{support::PerfItemKind::Instrument};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get());
    passRunner->add(std::unique_ptr<wasm::Pass>{passes::createInsertTracePointPass()});
    passRunner->run();
  }
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m.get());
#endif
}

static void optimize(AsModule const &m) {
  {
    support::PerfRAII const r{support::PerfItemKind::Optimization};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get());
    passRunner->addDefaultOptimizationPasses();
    passRunner->add(std::unique_ptr<wasm::Pass>{passes::createAdvancedInliningPass()});
    passRunner->run();
  }
  {
    support::PerfRAII const r{support::PerfItemKind::Optimization};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get());
    passRunner->add(std::unique_ptr<wasm::Pass>{passes::createImmutableLoadEliminatingPass(m.immutableRanges_)});
    passRunner->add(std::unique_ptr<wasm::Pass>{passes::createExtractMostFrequentlyUsedGlobalsPass()});
    passRunner->add(std::unique_ptr<wasm::Pass>{passes::createConditionalReturnPass()});
    passRunner->run();
  }
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m.get());
#endif
  {
    support::PerfRAII const r{support::PerfItemKind::Optimization};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get());
    passRunner->setDebug(false);
    passRunner->addDefaultOptimizationPasses();
    passRunner->run();
  }
  ensureValidate(*m.get());
}

static void addDebugInfoAsCustomSection(AsModule const &m) {
  llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> const debugSections =
      passes::DwarfGenerator::generateDebugSections(m.variableInfo_);

  if (!debugSections.empty()) {
    for (auto I = debugSections.begin(); !(I == debugSections.end()); I++) {
      llvm::StringRef const sectionName = I->getKey();
      llvm::MemoryBuffer const *const buffer = I->getValue().get();
      BinaryenAddCustomSection(m.get(), sectionName.data(), reinterpret_cast<const char *>(buffer->getBufferStart()),
                               static_cast<wasm::Index>(buffer->getBufferSize()));
    }
  }
}

passes::Output passes::runOnModule(AsModule const &m, Config const &config) {
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m.get());
#endif
  lowering(m);
  preOptimize(m);
  if (common::getOptimizationLevel() > 0U || common::getShrinkLevel() > 0U)
    optimize(m);

  // wasm and source map
  wasm::BufferWithRandomAccess buffer;
  wasm::PassOptions const options = wasm::PassOptions::getWithoutOptimization();
  if (common::isEmitDebugInfo()) {
    addDebugInfoAsCustomSection(m);
  }
  wasm::WasmBinaryWriter writer(m.get(), buffer, options);
  std::stringstream sourceMapStream;
  if (common::isEmitDebugLine()) {
    assert(!config.sourceMapURL.empty());
    writer.setSourceMap(&sourceMapStream, config.sourceMapURL);
  }
  writer.setNamesSection(common::isEmitDebugName());
  writer.setEmitModuleName(common::isEmitDebugName());
  writer.write();

  // wat
  std::stringstream ss{};
  wasm::printStackIR(ss, m.get(), wasm::PassOptions::getWithoutOptimization());

  return {
      .wat = std::move(ss).str(),
      .wasm = static_cast<std::vector<uint8_t>>(buffer),
      .sourceMap = std::move(sourceMapStream).str(),
  };
}

passes::Output passes::runOnWat(std::string const &input, Config const &config) {
  std::unique_ptr<wasm::Module> m = passes::loadWat(input);
  return runOnModule(AsModule{m.release()}, config);
}

struct OutputFiles {
  std::filesystem::path wat_;
  std::filesystem::path wasm_;
  std::filesystem::path sourceMap_;

  static OutputFiles create(std::filesystem::path const &path) {
    std::filesystem::path const extension = path.extension();
    if (extension == ".wasm")
      return OutputFiles{
          .wat_ = replaceExtension(path, ".wat"),
          .wasm_ = path,
          .sourceMap_ = replaceExtension(path, ".wasm.map"),
      };
    if (extension == ".wat" || extension == ".wast")
      return OutputFiles{
          .wat_ = path,
          .wasm_ = replaceExtension(path, ".wasm"),
          .sourceMap_ = replaceExtension(path, ".wasm.map"),
      };
    return OutputFiles{
        .wat_ = path,
        .wasm_ = "",
        .sourceMap_ = "",
    };
  }
};

void passes::runAndEmit(AsModule const &m, std::filesystem::path const &outputPath) {
  OutputFiles const outputFiles = OutputFiles::create(outputPath);
  ensureFileDirectory(outputFiles.wasm_);

  passes::Output const output = runOnModule(m, passes::Config{.sourceMapURL = getBaseName(outputFiles.sourceMap_)});

  if (std::ofstream of{outputFiles.wat_, std::ios::out}; of.good()) {
    of.write(output.wat.data(), static_cast<std::streamsize>(output.wat.size()));
  } else {
    throw std::runtime_error{fmt::format("failed to open file: {}", outputFiles.wat_.c_str())};
  }
  if (!outputFiles.wasm_.empty()) {
    if (std::ofstream of{outputFiles.wasm_, std::ios::binary | std::ios::out}; of.good()) {
      of.write(reinterpret_cast<char const *>(output.wasm.data()), static_cast<std::streamsize>(output.wasm.size()));
    } else {
      throw std::runtime_error{fmt::format("ERROR: failed to open file: {}", outputFiles.wasm_.c_str())};
    }
  }
  if (!outputFiles.sourceMap_.empty() && common::isEmitDebugLine()) {
    if (std::ofstream of{outputFiles.sourceMap_, std::ios::out}; of.good()) {
      of.write(output.sourceMap.data(), static_cast<std::streamsize>(output.sourceMap.size()));
    } else {
      throw std::runtime_error{fmt::format("failed to open file: {}", outputFiles.sourceMap_.c_str())};
    }
  }
}

void passes::runAndEmit(std::string const &inputPath, std::filesystem::path const &outputPath) {
  if (!inputPath.ends_with("wat") && !inputPath.ends_with("wast"))
    throw std::runtime_error{fmt::format("invalid file extension: {}, expected 'wat' or 'wast'", inputPath)};
  std::ifstream ifstream{inputPath, std::ios::in};
  if (!ifstream.good())
    throw std::runtime_error{fmt::format("failed to open file: {}", inputPath)};
  std::string const wat{std::istreambuf_iterator<char>{ifstream}, {}};
  std::unique_ptr<wasm::Module> m = loadWat(wat);
  runAndEmit(AsModule{m.release()}, outputPath);
}

} // namespace warpo

void warpo::passes::lowering(AsModule const &m) {
  {
    support::PerfRAII const r{support::PerfItemKind::Lowering};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get());
    if (passRunner->options.shrinkLevel > 0 || passRunner->options.optimizeLevel > 0)
      passRunner->add(std::unique_ptr<wasm::Pass>{new passes::gc::OptLower()});
    else
      passRunner->add(std::unique_ptr<wasm::Pass>{new passes::gc::FastLower()});
    passRunner->run();
  }
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m.get());
#endif
}
