#pragma once

#include "pass.h"
#include "wasm.h"

namespace warpo::passes {

/// @brief lowering tostack function
struct GCLowering : public wasm::Pass {
  explicit GCLowering() { name = "GCLowering"; }
  void run(wasm::Module *m) override;

  // preprocess pass for testing
  static void preprocess(wasm::PassRunner &runner);
};

} // namespace warpo::passes
