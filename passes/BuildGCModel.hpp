#pragma once

#include <cassert>
#include <memory>
#include <set>
#include <vector>

#include "pass.h"
#include "wasm.h"

namespace warpo::passes::as_gc {

constexpr const char *stackPointerName = "~lib/memory/__stack_pointer";

struct UpdateOperator {
  int64_t size_;
};

struct ShadowStackInfo {
  std::vector<UpdateOperator> stackPointerUpdate_{};
  std::set<wasm::Store *> storeToShadownStack_{};
};

using ShadowStackInfoMap = std::map<wasm::Name, ShadowStackInfo>;

class BuildGCModel : public wasm::Pass {
  ShadowStackInfoMap &infoMap_;

public:
  explicit BuildGCModel(ShadowStackInfoMap &infoMap) : infoMap_(infoMap) {}

  void runOnFunction(wasm::Module *m, wasm::Function *f) override;
  bool modifiesBinaryenIR() override { return false; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<BuildGCModel>(infoMap_); }

  static ShadowStackInfoMap createShadowStackInfoMap(wasm::Module const &m);
};

} // namespace warpo::passes::as_gc
