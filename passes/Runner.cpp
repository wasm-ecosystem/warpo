#include <fmt/base.h>
#include <fmt/format.h>
#include <memory>
#include <optional>
#include <regex>
#include <sstream>
#include <string>
#include <vector>

#include "ExtractMostFrequentlyUsedGlobals.hpp"
#include "GC/Lowering.hpp"
#include "InlineSetterFunction.hpp"
#include "Runner.hpp"
#include "ToString.hpp"
#include "binaryen-c.h"
#include "parser/wat-parser.h"
#include "pass.h"
#include "passes/Runner.hpp"
#include "support/Debug.hpp"
#include "wasm-binary.h"
#include "wasm-features.h"
#include "wasm-stack.h"
#include "wasm.h"

namespace warpo {

static void ensureValidate(wasm::Module &m) {
  if (!wasm::WasmValidator{}.validate(m))
    throw std::logic_error("validate error");
}

std::unique_ptr<wasm::Module> passes::loadWasm(const std::vector<char> &input) {
  std::unique_ptr<wasm::Module> m{new wasm::Module()};
  wasm::WasmBinaryReader parser(*m, features, input);
  parser.read();
  ensureValidate(*m);
  return m;
}

std::unique_ptr<wasm::Module> passes::loadWat(std::string_view wat) {
  std::unique_ptr<wasm::Module> m{new wasm::Module()};
  m->features = features;
  auto parsed = wasm::WATParser::parseModule(*m, wat);
  if (auto *err = parsed.getErr())
    throw std::logic_error(err->msg);
  ensureValidate(*m);
  return m;
}

void passes::init() { Colors::setEnabled(false); }

static std::vector<uint8_t> outputWasm(wasm::Module *m) {
  wasm::BufferWithRandomAccess buffer;
  wasm::WasmBinaryWriter writer(m, buffer, wasm::PassOptions::getWithoutOptimization());
  writer.setNamesSection(false);
  writer.setEmitModuleName(false);
  writer.write();
  return static_cast<std::vector<uint8_t>>(buffer);
}
static std::string outputWat(wasm::Module *m) {
  std::stringstream ss{};
  wasm::printStackIR(ss, m, wasm::PassOptions::getWithoutOptimization());
  return std::move(ss).str();
}

passes::Output passes::runOnWat(std::string const &input) {
  std::unique_ptr<wasm::Module> m = passes::loadWat(input);
  {
    wasm::PassRunner passRunner(m.get());
    passRunner.setDebug(support::isDebug());

    passRunner.add(std::unique_ptr<wasm::Pass>{new passes::GCLowering()});

    passRunner.run();
    ensureValidate(*m);
  }
  {
    wasm::PassRunner defaultOptRunner{m.get()};
    defaultOptRunner.options.shrinkLevel = 2;
    defaultOptRunner.options.optimizeLevel = 0;
    defaultOptRunner.setDebug(false);
    defaultOptRunner.addDefaultOptimizationPasses();
    defaultOptRunner.run();
    ensureValidate(*m);
  }
  {
    wasm::PassRunner passRunner(m.get());
    passRunner.setDebug(support::isDebug());

    passRunner.add(std::unique_ptr<wasm::Pass>{passes::createExtractMostFrequentlyUsedGlobalsPass()});
    passRunner.add(std::unique_ptr<wasm::Pass>{passes::createInlineSetterFunctionPass()});

    passRunner.run();
    ensureValidate(*m);
  }
  {
    wasm::PassRunner defaultOptRunner{m.get()};
    defaultOptRunner.options.shrinkLevel = 2;
    defaultOptRunner.options.optimizeLevel = 0;
    defaultOptRunner.setDebug(false);
    defaultOptRunner.addDefaultOptimizationPasses();
    defaultOptRunner.run();
    ensureValidate(*m);
  }
  return {.wat = outputWat(m.get()), .wasm = outputWasm(m.get())};
}

std::string passes::runOnWat(std::string const &input, PresetOpt presetOpt,
                             std::optional<std::regex> const &targetFunctionRegex) {
  std::unique_ptr<wasm::Module> m = passes::loadWat(input);
  wasm::PassRunner passRunner(m.get());
  passRunner.setDebug(support::isDebug());

  passes::GCLowering::Opt baseGCLoweringOpt{
      .LeafFunctionFilter = false,
      .MergeSSA = false,
      .OptimizedStackPositionAssigner = false,
  };
  switch (presetOpt) {
  case PresetOpt::AS_GC_LOWER_TEST_BASE:
    passes::GCLowering::preprocess(passRunner);
    break;
  case PresetOpt::AS_GC_LOWER:
    passRunner.add(std::unique_ptr<wasm::Pass>{new passes::GCLowering(baseGCLoweringOpt)});
    break;
  case PresetOpt::AS_GC_LOWER_WITH_LEAF_FUNCTION_FILTER:
    baseGCLoweringOpt.LeafFunctionFilter = true;
    passRunner.add(std::unique_ptr<wasm::Pass>{new passes::GCLowering(baseGCLoweringOpt)});
    break;
  case PresetOpt::AS_GC_LOWER_WITH_SSA_MERGE:
    baseGCLoweringOpt.MergeSSA = true;
    passRunner.add(std::unique_ptr<wasm::Pass>{new passes::GCLowering(baseGCLoweringOpt)});
    break;
  case PresetOpt::AS_GC_LOWER_WITH_OPTIMIZED_STACK_POSITION_ASSIGNER:
    baseGCLoweringOpt.OptimizedStackPositionAssigner = true;
    passRunner.add(std::unique_ptr<wasm::Pass>{new passes::GCLowering(baseGCLoweringOpt)});
    break;
  }
  passRunner.run();
  ensureValidate(*m);

  if (targetFunctionRegex.has_value()) {
    std::stringstream ss{};
    for (std::unique_ptr<wasm::Function> &f : m->functions) {
      if (std::regex_match(f->name.toString(), targetFunctionRegex.value()))
        ss << toString(f.get());
    }
    return std::move(ss).str();
  }
  return outputWat(m.get());
}

} // namespace warpo
