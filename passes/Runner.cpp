#include <memory>
#include <sstream>
#include <vector>

#include "ExtractMostFrequentlyUsedGlobals.hpp"
#include "InlineSetterFunction.hpp"
#include "RemoveDuplicateStoreLocalInGC.hpp"
#include "Runner.hpp"
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

void passes::init() {
  wasm::PassRegistry::get()->registerPass("extract-most-frequently-used-global", "",
                                          createExtractMostFrequentlyUsedGlobalsPass);
  wasm::PassRegistry::get()->registerPass("inline-setter-function", "", createInlineSetterFunctionPass);
  wasm::PassRegistry::get()->registerPass("remove-duplicate-store-local-in-shadow-stack", "",
                                          as_gc::createRemoveDuplicateStoreLocalInGCPass);
}

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

static passes::Output runImpl(std::unique_ptr<wasm::Module> &m, std::vector<const char *> const &passNames) {
  {
    wasm::PassRunner passRunner(m.get());
    passRunner.setDebug(support::isDebug());
    for (const char *passName : passNames) {
      passRunner.add(passName);
    }
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

  wasm::BufferWithRandomAccess buffer;
  wasm::WasmBinaryWriter writer(m.get(), buffer, wasm::PassOptions::getWithoutOptimization());
  writer.setNamesSection(false);
  writer.setEmitModuleName(false);
  writer.write();

  Colors::setEnabled(false);
  std::stringstream ss{};
  wasm::printStackIR(ss, m.get(), wasm::PassOptions::getWithoutOptimization());
  return {.wat = std::move(ss).str(), .wasm = static_cast<std::vector<uint8_t>>(buffer)};
}

passes::Output passes::runOnWasm(const std::vector<char> &input, std::vector<const char *> const &passNames) {
  std::unique_ptr<wasm::Module> m = loadWasm(input);
  return runImpl(m, passNames);
}

passes::Output passes::runOnWat(std::string const &input, std::vector<const char *> const &passNames) {
  std::unique_ptr<wasm::Module> m = loadWat(input);
  return runImpl(m, passNames);
}

} // namespace warpo
