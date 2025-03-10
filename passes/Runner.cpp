#include <memory>
#include <vector>

#include "ExtractMostFrequentlyUsedGlobals.hpp"
#include "InlineSetterFunction.hpp"
#include "binaryen-c.h"
#include "pass.h"
#include "passes/Runner.hpp"
#include "wasm-binary.h"
#include "wasm.h"

namespace warpo {

void passes::init() {
  wasm::PassRegistry::get()->registerPass("extract-most-frequently-used-global", "",
                                          createExtractMostFrequentlyUsedGlobalsPass);
  wasm::PassRegistry::get()->registerPass("inline-setter-function", "", createInlineSetterFunctionPass);
}

static std::unique_ptr<wasm::Module> load(const std::vector<char> &input) {
  auto m = std::make_unique<wasm::Module>();
  wasm::WasmBinaryReader parser(*m, wasm::FeatureSet::All, input);
  parser.read();
  return m;
}

std::vector<uint8_t> passes::run(const std::vector<char> &input, std::vector<const char *> const &passNames) {
  std::unique_ptr<wasm::Module> m = load(input);
  wasm::PassRunner passRunner(m.get());
  for (const char *passName : passNames) {
    passRunner.add(passName);
  }
  passRunner.run();

  wasm::BufferWithRandomAccess buffer;
  wasm::WasmBinaryWriter writer(m.get(), buffer, wasm::PassOptions::getWithoutOptimization());
  writer.setNamesSection(false);
  writer.setEmitModuleName(false);
  writer.write();
  return static_cast<std::vector<uint8_t>>(buffer);
}

} // namespace warpo
