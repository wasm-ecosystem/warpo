// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <memory>
#include <sstream>
#include <stdexcept>
#include <string>
#include <support/index.h>
#include <utility>
#include <vector>

#include "AdvancedInlining.hpp"
#include "BinaryWriter.hpp"
#include "Closure.hpp"
#include "CombineSwitchTargets.hpp"
#include "ConditionalReturn.hpp"
#include "ExtractMostFrequentlyUsedGlobals.hpp"
#include "GC/FastLower.hpp"
#include "GC/OptLower.hpp"
#include "ImmutableLoadEliminating.hpp"
#include "InlinedDecoratorLower.hpp"
#include "InsertTracePoint.hpp"
#include "InstrSimplifier.hpp"
#include "MergeDataSection.hpp"
#include "Runner.hpp"
#include "binaryen-c.h"
#include "instrumentation/CoverageInstrumentation.hpp"
#include "parser/wat-parser.h"
#include "pass.h"
#include "warpo/common/AsModule.hpp"
#include "warpo/common/DebugLevel.hpp"
#include "warpo/common/Features.hpp"
#include "warpo/common/OptLevel.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Statistics.hpp"
#include "wasm-binary.h"
#include "wasm-features.h"
#include "wasm-stack.h"
#include "wasm.h"

namespace warpo::passes {

static void ensureValidate(wasm::Module &m) {
  support::PerfRAII const r{support::PerfItemKind::Validation};
  if (!wasm::WasmValidator{}.validate(m))
    throw std::logic_error("validate error");
}

std::unique_ptr<wasm::Module> loadWasm(const std::vector<char> &input) {
  std::unique_ptr<wasm::Module> m{new wasm::Module()};
  wasm::WasmBinaryReader parser(*m, common::Features::fromCLI().toBinaryenFeatureSet(), input);
  parser.read();
  ensureValidate(*m);
  return m;
}

std::unique_ptr<wasm::Module> loadWat(std::string_view wat) {
  std::unique_ptr<wasm::Module> m{new wasm::Module()};
  m->features = common::Features::fromCLI().toBinaryenFeatureSet();
  auto parsed = wasm::WATParser::parseModule(*m, wat);
  if (auto *err = parsed.getErr())
    throw std::logic_error(err->msg);
  ensureValidate(*m);
  return m;
}

static std::unique_ptr<wasm::PassRunner> createPassRunner(wasm::Module *const m, Config const &config) {
  auto passRunner = std::make_unique<wasm::PassRunner>(m);
  passRunner->options.shrinkLevel = static_cast<int32_t>(config.shrinkLevel);
  passRunner->options.optimizeLevel = static_cast<int32_t>(config.optimizeLevel);
  return passRunner;
}

static void lowering(AsModule const &m, Config const &config) {
  {
    support::PerfRAII const r{support::PerfItemKind::Lowering};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get(), config);
    passRunner->add(std::unique_ptr<wasm::Pass>{createInlinedDecoratorLower(m.forceInlineHints_)});
    if (passRunner->options.shrinkLevel > 0 || passRunner->options.optimizeLevel > 0) {
      passRunner->add(std::make_unique<closure::OptLower>(&m.variableInfo_));
      passRunner->add(std::unique_ptr<wasm::Pass>{new gc::OptLower(&m.variableInfo_)});
    } else {
      passRunner->add(std::make_unique<closure::FastLower>(&m.variableInfo_));
      passRunner->add(std::unique_ptr<wasm::Pass>{new gc::FastLower()});
    }
    passRunner->run();
  }
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m.get());
#endif
}

static void preOptimize(AsModule const &m, Config const &config) {
  {
    support::PerfRAII const r{support::PerfItemKind::Instrument};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get(), config);
    passRunner->add(std::unique_ptr<wasm::Pass>{createInsertTracePointPass()});
    passRunner->run();
  }
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m.get());
#endif
}

static void optimize(AsModule const &m, Config const &config) {
  {
    support::PerfRAII const r{support::PerfItemKind::Optimization};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get(), config);
    passRunner->addDefaultOptimizationPasses();
    passRunner->add(std::unique_ptr<wasm::Pass>{createAdvancedInliningPass()});
    passRunner->add(std::unique_ptr<wasm::Pass>{createInstrSimplifier()});
    passRunner->run();
  }
  {
    support::PerfRAII const r{support::PerfItemKind::Optimization};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get(), config);
    passRunner->add(std::unique_ptr<wasm::Pass>{createImmutableLoadEliminatingPass(m.immutableRanges_)});
    passRunner->add(std::unique_ptr<wasm::Pass>{createExtractMostFrequentlyUsedGlobalsPass()});
    passRunner->add(std::unique_ptr<wasm::Pass>{createConditionalReturnPass()});
    passRunner->add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
    passRunner->run();
  }
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m.get());
#endif
  {
    support::PerfRAII const r{support::PerfItemKind::Optimization};
    std::unique_ptr<wasm::PassRunner> const passRunner = createPassRunner(m.get(), config);
    passRunner->setDebug(false);
    passRunner->addDefaultOptimizationPasses();
    {
      // Run CombineSwitchTargets again after the final default optimization batch.
      // It checks __visit_members for duplicate visit continuations and merges
      // the corresponding br_table cases. Before late inlining, two cases may
      // still be separate calls such as A.visit and B.visit, so
      // CombineSwitchTargets cannot treat them as identical. After inlining,
      // both cases become the same bytecode, and rerunning the pass here lets
      // it merge them.
      //
      // Schematic WAT progression:
      // 1) After CombineSwitchTargets, only the branch targets change:
      //      br_table ... $func1 $func2 $invalid
      //   => br_table ... $func2 $func2 $invalid
      //
      //    but the old nested structure is still there:
      //      (block $func2
      //        (block $func1
      //          (block $tuple ...)
      //        )
      //        ;; old $func1 continuation, now unreachable
      //        local.get $0
      //        i32.load offset=4
      //        call $~lib/rt/itcms/__visit
      //        return
      //      )
      //      ;; canonical $func2 continuation
      //      local.get $0
      //      i32.load offset=4
      //      call $~lib/rt/itcms/__visit
      //      return
      //
      // 2) vacuum turns the old $func1 continuation into an explicit
      //    unreachable, but the wrapper block still exists:
      //      (block $func2
      //        (block $func1
      //          (block $tuple ...)
      //        )
      //        unreachable
      //      )
      //      local.get $0
      //      i32.load offset=4
      //      call $~lib/rt/itcms/__visit
      //      return
      //
      // 3) merge-blocks can then remove that useless wrapper block shape:
      //      (block $func2
      //        (block $tuple ...)
      //      )
      //      local.get $0
      //      i32.load offset=4
      //      call $~lib/rt/itcms/__visit
      //      return
      //
      // 4) remove-unused-names strips any labels left without incoming branches.
      passRunner->add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
      passRunner->add("vacuum");
      passRunner->add("merge-blocks");
      passRunner->add("remove-unused-names");
    }
    passRunner->add(std::unique_ptr<wasm::Pass>{createMergeDataSectionPass()});
    passRunner->run();
  }
  ensureValidate(*m.get());
}

namespace {
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

} // namespace

} // namespace warpo::passes

namespace warpo {

void passes::init() { Colors::setEnabled(false); }

passes::Output passes::runOnModule(AsModule const &m, Config const &config) {
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m.get());
#endif
  lowering(m, config);
  preOptimize(m, config);
  if (config.optimizeLevel > 0U || config.shrinkLevel > 0U)
    optimize(m, config);
  instrumentation::runCoverageInstrumentation(*m.get());

  if (common::isEmitDebugInfo()) {
    wasm::PassRunner runner(m.get());
    runner.add("propagate-debug-locs");
    runner.run();
  }

  // wasm and source map
  BinaryWriter writer{m};
  writer.setSourceMapEnabled(common::isEmitDebugLine() && !config.sourceMapURL.empty(), config.sourceMapURL);
  writer.setNameSectionEnabled(common::isEmitDebugName());
  writer.setDwarfEnabled(common::isEmitDebugInfo());
  writer.write();

  // wat
  std::stringstream ss{};
  wasm::printStackIR(ss, m.get(), wasm::PassOptions::getWithoutOptimization());

  return {
      .wat = std::move(ss).str(),
      .wasm = writer.getBinary(),
      .sourceMap = writer.getSourceMap(),
  };
}

void passes::runAndEmit(AsModule const &m, std::filesystem::path const &outputPath) {
  OutputFiles const outputFiles = OutputFiles::create(outputPath);
  ensureFileDirectory(outputFiles.wasm_);

  Config const config{
      .optimizeLevel = common::getOptimizationLevel(),
      .shrinkLevel = common::getShrinkLevel(),
      .sourceMapURL = getBaseName(outputFiles.sourceMap_),
  };
  Output const output = runOnModule(m, config);
  writeBinaryFile(outputFiles.wat_, output.wat);
  writeBinaryFile(outputFiles.wasm_, output.wasm);
  if (!outputFiles.sourceMap_.empty() && common::isEmitDebugLine()) {
    writeBinaryFile(outputFiles.sourceMap_, output.sourceMap);
  }
}

} // namespace warpo
