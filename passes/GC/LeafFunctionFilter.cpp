#include <cassert>

#include "CollectLeafFunction.hpp"
#include "LeafFunctionFilter.hpp"
#include "support/Debug.hpp"
#include "support/DynBitSet.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes::gc {

void LeafFunctionFilter::runOnFunction(wasm::Module *m, wasm::Function *func) {
  struct Collector : public wasm::PostWalker<Collector> {
    DynBitset validSSAValue_;
    LivenessMap const &livenessMap_;
    LeafFunc const &leaf_;
    explicit Collector(LivenessMap const &livenessMap, LeafFunc const &leaf)
        : validSSAValue_(livenessMap.getDimension()), livenessMap_(livenessMap), leaf_(leaf) {}

    void visitCall(wasm::Call *expr) {
      // we don't handle leaf function call
      if (leaf_.contains(expr->target))
        return;
      markCurrentLivedSSAValid(expr);
    }
    void visitCallIndirect(wasm::CallIndirect *expr) {
      // TODO: check if the target is a leaf function
      markCurrentLivedSSAValid(expr);
    }

  private:
    void markCurrentLivedSSAValid(wasm::Expression *expr) {
      std::optional<Liveness> const l = livenessMap_.getLiveness(expr);
      assert(l.has_value());
      validSSAValue_ |= l->before();
      validSSAValue_ |= l->after();
    }
  };

  LivenessMap &livenessMap = info_.at(func);
  Collector collector{livenessMap, leaf_};
  collector.walkFunctionInModule(func, m);
  // TODO: mark parameters SSA valid
  livenessMap.setInvalid(~collector.validSSAValue_);

  if (support::isDebug()) {
    std::cout << "=================================\n";
    std::cout << func->name << " liveness leaf filter\n";
    livenessMap.dump(func);
    std::cout << "=================================\n";
  }
}

} // namespace warpo::passes::gc
