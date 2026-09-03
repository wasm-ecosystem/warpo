// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <optional>
#include <unordered_map>

#include "GCInfo.hpp"
#include "MergeSSA.hpp"
#include "ReturnParamFunctions.hpp"
#include "SSAObj.hpp"
#include "support/index.h"
#include "warpo/support/DynBitSet.hpp"
#include "warpo/support/Range.hpp"
#include "wasm.h"

namespace warpo::passes::gc {

namespace {

struct AliasPath {
  wasm::Expression *root = nullptr;
  std::vector<wasm::Call *> intermediateToStackCalls;
};

AliasPath resolveAliasPath(wasm::Expression *expr, ReturnParamMap const &returnParamMap) {
  AliasPath path;
  while (expr != nullptr) {
    if (auto *const getExpr = expr->dynCast<wasm::LocalGet>()) {
      path.root = getExpr;
      return path;
    }
    auto *const callExpr = expr->dynCast<wasm::Call>();
    if (callExpr == nullptr) {
      path.root = expr;
      return path;
    }
    auto const it = returnParamMap.find(callExpr->target);
    if (it == returnParamMap.end()) {
      path.root = expr;
      return path;
    }
    if (callExpr->target == FnTmpToStack || callExpr->target == FnLocalToStack) {
      path.intermediateToStackCalls.push_back(callExpr);
    }
    wasm::Index const paramIndex = it->second;
    assert(paramIndex < callExpr->operands.size());
    expr = callExpr->operands[paramIndex];
  }
  return path;
}

void mergeLivenessAlongPath(LivenessMap &livenessMap, AliasPath const &aliasPath, wasm::Call *const callExpr,
                            size_t const targetSSAIndex, size_t const tmpSSAIndex) {
  for (wasm::Call *const intermediateCall : aliasPath.intermediateToStackCalls) {
    livenessMap.set(intermediateCall, LivenessMap::Pos::Before, targetSSAIndex, true);
    livenessMap.set(intermediateCall, LivenessMap::Pos::After, targetSSAIndex, true);
  }
  livenessMap.set(callExpr, LivenessMap::Pos::Before, targetSSAIndex, true);
  livenessMap.mergeByColumns(targetSSAIndex, tmpSSAIndex, LivenessMap::MergeOperator::OR);
}

} // namespace

class LocalIndexToSSA : private std::unordered_map<wasm::Index, DynBitset> {
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

  using std::unordered_map<wasm::Index, DynBitset>::contains;
};

void MergeSSA::runOnFunction(wasm::Module *const m, wasm::Function *const func) {
  static_cast<void>(m);
  SSAMap const &ssaMap = moduleLevelSSAMap_.at(func);
  LivenessMap &livenessMap = info_->at(func);
  size_t const ssaCount = ssaMap.size();
  LocalIndexToSSA const localIndexToSSA = LocalIndexToSSA::create(ssaMap);
  DynBitset invalidSSA{ssaCount};

  for (auto const &[ssa, tmpSSAIndex] : ssaMap) {
    if (ssa.kind_ != SSAValue::Kind::Tmp)
      continue;
    wasm::Call *const callExpr = ssa.value_.tmp;

    AliasPath const aliasPath = resolveAliasPath(callExpr->operands[0], returnParamMap_);
    if (aliasPath.root == nullptr)
      continue;

    if (auto *const getExpr = aliasPath.root->dynCast<wasm::LocalGet>()) {
      // this tmp ssa is reference of local
      wasm::Index const localIndex = getExpr->index;
      std::optional<Liveness> const liveness = livenessMap.getLiveness(getExpr);
      if (liveness == std::nullopt)
        // this expr are unreachable, so CFG will not contain it.
        // we just skip this node and let other optimization handle it.
        // FIXME: maybe we should do pre-opt to remove the dead code?
        continue;
      // sometimes local.get is come from tmp local to stack. ignore this cases.
      if (!localIndexToSSA.contains(localIndex))
        continue;
      Liveness const localgetLiveness = liveness.value();

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
          mergeLivenessAlongPath(livenessMap, aliasPath, callExpr, target, tmpSSAIndex);
        }
      }
      // local call be invalidate before local.get when enabling other optimization
      if (hasTarget) {
        invalidSSA.set(tmpSSAIndex, true);
      }
    } else if (auto *const rootCall = aliasPath.root->dynCast<wasm::Call>()) {
      if (rootCall->target == FnTmpToStack && ssaMap.contains(SSAValue{rootCall})) {
        size_t const rootTmpSSAIndex = ssaMap.getIndex(SSAValue{rootCall});
        if (rootTmpSSAIndex != tmpSSAIndex) {
          livenessMap.set(rootCall, LivenessMap::Pos::After, rootTmpSSAIndex, true);
          mergeLivenessAlongPath(livenessMap, aliasPath, callExpr, rootTmpSSAIndex, tmpSSAIndex);
          invalidSSA.set(tmpSSAIndex, true);
        }
      }
    }
  }
  livenessMap.setInvalid(invalidSSA);
}
} // namespace warpo::passes::gc
