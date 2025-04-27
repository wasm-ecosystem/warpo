#include <cassert>
#include <cstddef>
#include <map>

#include "MergeSSA.hpp"
#include "ObjLivenessAnalyzer.hpp"
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
  LivenessMap &livenessMap = info_.at(func);
  size_t const ssaCount = ssaMap.size();

  LocalIndexToSSA const localIndexToSSA = LocalIndexToSSA::create(ssaMap);
  DynBitset invalidSSA{ssaCount};

  for (auto const &[ssa, tmpSSAIndex] : ssaMap) {
    if (ssa.kind_ != SSAValue::Kind::Tmp)
      continue;
    wasm::Call *const call = ssa.value_.tmp;

    if (auto *const actuallySSAValueExpr = call->operands[0]->dynCast<wasm::LocalGet>()) {
      // this tmp ssa is reference of local
      wasm::Index const localIndex = actuallySSAValueExpr->index;
      std::optional<Liveness> const currentLiveness = livenessMap.getLiveness(actuallySSAValueExpr);
      assert(currentLiveness.has_value() && "local.get must have liveness");
      DynBitset const localMappedLivedSSAIndexes = localIndexToSSA.get(localIndex) & currentLiveness.value().after();
      // we extend the tmp ssa to the local ssa
      for (size_t i : Range{ssaCount}) {
        if (localMappedLivedSSAIndexes.get(i))
          livenessMap.mergeByColumns(i, tmpSSAIndex, LivenessMap::MergeOperator::OR);
      }
      invalidSSA.set(tmpSSAIndex, true);
    }
  }
  livenessMap.setInvalid(invalidSSA);
}

} // namespace warpo::passes::gc
