#pragma once

#include "pass.h"
#include "wasm.h"

namespace warpo::passes {

struct GCLowering : public wasm::Pass {
  struct Opt {
    bool LeafFunctionFilter : 1 = true;
    bool MergeSSA : 1 = true;
    bool OptimizedStackPositionAssigner : 1 = true;
  };
  Opt opt_;
  explicit GCLowering() : GCLowering(passes::GCLowering::Opt{}) {}
  explicit GCLowering(Opt opt) : opt_(opt) { name = "GCLowering"; }
  void run(wasm::Module *m) override;

  // preprocess pass for testing
  static void preprocess(wasm::PassRunner &runner);
};

} // namespace warpo::passes
