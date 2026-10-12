// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <string_view>

#include "warpo/passes/KnownImportSemantics.hpp"

namespace warpo::passes {
namespace {

bool isLinkedMemoryGetter(wasm::Function const *const function) noexcept {
  if (function == nullptr || !function->imported() || function->module != "builtin")
    return false;

  std::string_view const base = function->base.view();
  if (base == "getLengthOfLinkedMemory")
    return true;
  if (base == "getU8FromLinkedMemory")
    return true;
  if (base == "getI8FromLinkedMemory")
    return true;
  if (base == "getU16FromLinkedMemory")
    return true;
  if (base == "getI16FromLinkedMemory")
    return true;
  if (base == "getU32FromLinkedMemory")
    return true;
  if (base == "getI32FromLinkedMemory")
    return true;
  if (base == "getU64FromLinkedMemory")
    return true;
  if (base == "getI64FromLinkedMemory")
    return true;
  if (base == "getF32FromLinkedMemory")
    return true;
  if (base == "getF64FromLinkedMemory")
    return true;
  return false;
}

class KnownImportSemantics : public wasm::Pass {
public:
  std::unique_ptr<Pass> create() override { return std::make_unique<KnownImportSemantics>(); }

  void run(wasm::Module *module) override {
    for (std::unique_ptr<wasm::Function> const &function : module->functions) {
      if (isLinkedMemoryGetter(function.get()))
        function->funcAnnotations.removableIfUnused = true;
    }
  }
};

} // namespace

wasm::Pass *createKnownImportSemanticsPass() { return new KnownImportSemantics(); }

} // namespace warpo::passes
