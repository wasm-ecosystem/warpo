#include <cassert>
#include <cstddef>
#include <map>

#include "MergeSSA.hpp"
#include "SSAObj.hpp"
#include "support/DynBitSet.hpp"
#include "support/Range.hpp"
#include "support/index.h"
#include "wasm.h"

namespace warpo::passes::gc {

class LocalIndexToSSA : private std::map<wasm::Index, DynBitset> {
  size_t size_;

  void push(wasm::Index localIndex, size_t ssaIndex) {
    auto it = this->try_emplace(localIndex, DynBitset{size_}).first;
    it->second.set(ssaIndex, true);
  }
  explicit LocalIndexToSSA(size_t size) : size_(size) {}

public:
  static LocalIndexToSSA create(SSAMap const &ssaMap) {
    LocalIndexToSSA ret{ssaMap.size()};
    for (auto const &[ssa, ssaIndex] : ssaMap) {
      std::optional<wasm::Index> localIndex = ssa.tryGetLocalIndex();
      if (localIndex.has_value()) {
        ret.push(localIndex.value(), ssaIndex);
      }
    }
    return ret;
  }
  DynBitset const &get(wasm::Index localIndex) const {
    auto it = this->find(localIndex);
    assert(it != this->end());
    return it->second;
  }
};

void MergeSSA::runOnFunction(wasm::Module *m, wasm::Function *func) {
  SSAMap const &ssaMap = moduleLevelSSAMap_.at(func);
  LivenessMap &livenessMap = info_->at(func);
  size_t const ssaCount = ssaMap.size();
  LocalIndexToSSA const localIndexToSSA = LocalIndexToSSA::create(ssaMap);
  DynBitset invalidSSA{ssaCount};

  for (auto const &[ssa, tmpSSAIndex] : ssaMap) {
    if (ssa.kind_ != SSAValue::Kind::Tmp)
      continue;
    wasm::Call *const callExpr = ssa.value_.tmp;

    if (auto *const getExpr = callExpr->operands[0]->dynCast<wasm::LocalGet>()) {
      // this tmp ssa is reference of local
      wasm::Index const localIndex = getExpr->index;
      Liveness const localgetLiveness = livenessMap.getLiveness(getExpr).value();

      DynBitset const localMappedSSA = localIndexToSSA.get(localIndex);
      DynBitset const livenessBeforeLocalGet = localgetLiveness.before() & localMappedSSA;
      DynBitset const livenessAfterLocalGet = localgetLiveness.after() & localMappedSSA;

      assert(livenessBeforeLocalGet >= livenessAfterLocalGet && "local.get should kill liveness");

      // ;; 1_0 => 1_0 livenessBeforeLocalGet
      // local.get
      // ;; 0_0 => 1_0 livenessAfterLocalGet
      // call $tostack
      // ;; 0_1 => 1_1(invalid)
      bool hasTarget = false;
      // we extend the tmp ssa to the local ssa
      for (size_t const target : Range{ssaCount}) {
        if (livenessBeforeLocalGet.get(target)) {
          hasTarget = true;
          // because liveness for tmp will be active in call opcode. we should manually set the liveness
          livenessMap.set(getExpr, LivenessMap::Pos::After, target, true);
          livenessMap.set(callExpr, LivenessMap::Pos::Before, target, true);
          livenessMap.mergeByColumns(target, tmpSSAIndex, LivenessMap::MergeOperator::OR);
        }
      }
      // local call be invalidate before local.get when enabling other optimization
      if (hasTarget) {
        invalidSSA.set(tmpSSAIndex, true);
      }
    }
    livenessMap.setInvalid(invalidSSA);
  }
}
} // namespace warpo::passes::gc
