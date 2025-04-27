#pragma once

#include <cstddef>

#include "ObjLivenessAnalyzer.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

struct StackPosition : private std::map<wasm::Call *, uint32_t> {
  using Super = std::map<wasm::Call *, uint32_t>;
  using Super::begin;
  using Super::contains;
  using Super::end;
  using Super::find;
  using Super::insert_or_assign;
};
using StackPositions = std::map<wasm::Function *, StackPosition>;

struct StackAssigner : public wasm::Pass {
  enum class Mode { Vanilla, GreedyConflictGraph };
  static StackPositions createResults(wasm::Module *m) {
    StackPositions ret{};
    for (std::unique_ptr<wasm::Function> const &f : m->functions) {
      ret.insert_or_assign(f.get(), StackPosition{});
    }
    return ret;
  }
  Mode mode_;
  StackPositions &stackPositions_;
  ObjLivenessInfo const &livenessInfo_;
  explicit StackAssigner(Mode mode, StackPositions &stackPositions, ObjLivenessInfo const &livenessInfo)
      : mode_(mode), stackPositions_(stackPositions), livenessInfo_(livenessInfo) {
    name = "StackAssigner";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override {
    return std::make_unique<StackAssigner>(mode_, stackPositions_, livenessInfo_);
  }
  bool modifiesBinaryenIR() override { return false; }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override;
};

} // namespace warpo::passes::gc
