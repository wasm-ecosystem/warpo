#include <fmt/base.h>
#include <fmt/format.h>
#include <memory>
#include <regex>
#include <sstream>
#include <string>
#include <vector>

#include "AdvancedInlining.hpp"
#include "ConditionalReturn.hpp"
#include "ExtractMostFrequentlyUsedGlobals.hpp"
#include "GC/Lowering.hpp"
#include "Runner.hpp"
#include "binaryen-c.h"
#include "helper/ToString.hpp"
#include "parser/wat-parser.h"
#include "pass.h"
#include "support/Opt.hpp"
#include "warpo/passes/Runner.hpp"
#include "wasm-binary.h"
#include "wasm-features.h"
#include "wasm-stack.h"
#include "wasm.h"

namespace warpo {

static const cli::Opt<bool> EnableGCLoweringPassForTesting{
    "--enable-gc-lowering-pass-for-testing",
    [](argparse::Argument &arg) { arg.help("Enable advanced inlining pass").flag().hidden(); },
};
static const cli::Opt<bool> EnableAdvancedInliningPassForTesting{
    "--enable-advanced-inlining-pass-for-testing",
    [](argparse::Argument &arg) { arg.help("Enable advanced inlining pass").flag().hidden(); },
};

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
  wasm::PassOptions options = wasm::PassOptions::getWithoutOptimization();
  wasm::WasmBinaryWriter writer(m, buffer, options);
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

passes::Output passes::runOnModule(BinaryenModuleRef const m) {
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m);
#endif
  {
    wasm::PassRunner passRunner{m};
    passRunner.add(std::unique_ptr<wasm::Pass>{new passes::GCLowering()});
    passRunner.run();
  }
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m);
#endif
  {
    wasm::PassRunner defaultOptRunner{m};
    defaultOptRunner.options.shrinkLevel = 2;
    defaultOptRunner.options.optimizeLevel = 0;
    defaultOptRunner.setDebug(false);
    defaultOptRunner.addDefaultOptimizationPasses();
    defaultOptRunner.add(std::unique_ptr<wasm::Pass>{passes::createAdvancedInliningPass()});
    defaultOptRunner.run();
  }
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m);
#endif
  {
    wasm::PassRunner passRunner{m};
    passRunner.add(std::unique_ptr<wasm::Pass>{passes::createExtractMostFrequentlyUsedGlobalsPass()});
    passRunner.add(std::unique_ptr<wasm::Pass>{passes::createConditionalReturnPass()});
    passRunner.run();
  }
#ifndef WARPO_RELEASE_BUILD
  ensureValidate(*m);
#endif
  {
    wasm::PassRunner defaultOptRunner{m};
    defaultOptRunner.options.shrinkLevel = 2;
    defaultOptRunner.options.optimizeLevel = 0;
    defaultOptRunner.setDebug(false);
    defaultOptRunner.addDefaultOptimizationPasses();
    defaultOptRunner.run();
  }
  ensureValidate(*m);
  return {.wat = outputWat(m), .wasm = outputWasm(m)};
}

passes::Output passes::runOnWat(std::string const &input) {
  std::unique_ptr<wasm::Module> m = passes::loadWat(input);
  return runOnModule(m.get());
}

std::string passes::runOnWatForTesting(std::string const &input, std::regex const &targetFunctionRegex) {
  std::unique_ptr<wasm::Module> m = passes::loadWat(input);
  wasm::PassRunner passRunner(m.get());
  if (EnableGCLoweringPassForTesting.get())
    passRunner.add(std::unique_ptr<wasm::Pass>{new passes::GCLowering()});
  if (EnableAdvancedInliningPassForTesting.get())
    passRunner.add(std::unique_ptr<wasm::Pass>{passes::createAdvancedInliningPass()});
  passRunner.run();
  ensureValidate(*m);

  std::stringstream ss{};
  for (std::unique_ptr<wasm::Function> &f : m->functions) {
    if (std::regex_match(f->name.toString(), targetFunctionRegex))
      ss << toString(f.get());
  }
  return std::move(ss).str();
}

} // namespace warpo
