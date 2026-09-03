// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <fmt/base.h>
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

// Not all nodes in the return-parameter call chain are SSA nodes (e.g. leaf methods
// that do not push to the shadow stack). Cache the latest encountered SSA node and
// backtrack the path to that SSA boundary when the chain terminates.
AliasPath resolveAliasPath(wasm::Expression *expr, SSAMap const &ssaMap, ReturnParamMap const &returnParamMap) {
  AliasPath path;
  wasm::Expression *lastSSAExpr = nullptr;
  size_t callsCountAtLastSSA = 0;

  while (expr != nullptr) {
    if (auto *const getExpr = expr->dynCast<wasm::LocalGet>()) {
      path.root = getExpr;
      return path;
    }
    if (ssaMap.tryGetIndexFromExpr(expr).has_value()) {
      lastSSAExpr = expr;
      callsCountAtLastSSA = path.intermediateToStackCalls.size();
    }
    auto *const callExpr = expr->dynCast<wasm::Call>();
    if (callExpr == nullptr) {
      break;
    }
    auto const it = returnParamMap.find(callExpr->target);
    if (it == returnParamMap.end()) {
      break;
    }
    path.intermediateToStackCalls.push_back(callExpr);
    wasm::Index const paramIndex = it->second;
    assert(paramIndex < callExpr->operands.size());
    expr = callExpr->operands[paramIndex];
  }

  if (lastSSAExpr != nullptr) {
    path.root = lastSSAExpr;
    path.intermediateToStackCalls.resize(callsCountAtLastSSA);
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

    AliasPath const aliasPath = resolveAliasPath(callExpr->operands[0], ssaMap, returnParamMap_);
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
      if (ssaMap.contains(SSAValue{rootCall})) {
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

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "../Runner.hpp"
#include "ObjLivenessAnalyzer.hpp"

namespace warpo::passes::gc::ut {

TEST(MergeSSATest, TwoSubChainsWithIntermediateAndRootOptimization) {
  // Emulates: a.foo().goo().createAnotherObject().yoo().yoo().zoo()
  // Non-leaf methods (they call another non-leaf function $dummyNonLeaf)
  // Sub-chain 1: a.foo().goo() -> starts at local $a, intermediate __tmptostack merges into $a
  // Sub-chain 2: .createAnotherObject().yoo().yoo().zoo() -> returns a new object, intermediate __tmptostack calls
  // merge into the new object's __tmptostack
  auto m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
      (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (func $dummyNonLeaf
        (nop)
      )
      (func $create (result i32)
        (call $dummyNonLeaf)
        (i32.const 100)
      )
      (func $foo (param $this i32) (result i32)
        (call $dummyNonLeaf)
        (local.get $this)
      )
      (func $goo (param $this i32) (result i32)
        (call $dummyNonLeaf)
        (local.get $this)
      )
      (func $createAnotherObject (param $this i32) (result i32)
        (call $dummyNonLeaf)
        (call $create)
      )
      (func $yoo (param $this i32) (result i32)
        (call $dummyNonLeaf)
        (local.get $this)
      )
      (func $zoo (param $this i32) (result i32)
        (call $dummyNonLeaf)
        (local.get $this)
      )
      (func $main (result i32)
        (local $a i32)
        (local.set $a
          (call $~lib/rt/__localtostack
            (call $create)
          )
        )
        ;; a.foo().goo().createAnotherObject().yoo().yoo().zoo()
        (drop
          (call $zoo
            (call $~lib/rt/__tmptostack
              (call $yoo
                (call $~lib/rt/__tmptostack
                  (call $yoo
                    (call $~lib/rt/__tmptostack
                      (call $createAnotherObject
                        (call $~lib/rt/__tmptostack
                          (call $goo
                            (call $~lib/rt/__tmptostack
                              (call $foo
                                (local.get $a)
                              )
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
        (i32.const 0)
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  ModuleLevelSSAMap const moduleLevelSSAMap = ModuleLevelSSAMap::create(m.get());
  std::shared_ptr<ObjLivenessInfo> const livenessInfo = ObjLivenessAnalyzer::addToPass(runner, moduleLevelSSAMap);
  ReturnParamMap const returnParamMap = collectReturnParamFunctions(m.get());
  MergeSSA::addToPass(runner, moduleLevelSSAMap, livenessInfo, returnParamMap);
  runner.run();

  wasm::Function *const mainFunc = m->getFunction("main");
  LivenessMap const &livenessMap = livenessInfo->at(mainFunc);
  // Total SSAs in main:
  // 1 Local SSA for $a (from __localtostack)
  // 5 Tmp SSAs for:
  //   - $foo (sub-chain 1 -> merged into $a)
  //   - $goo (sub-chain 1 -> merged into $a)
  //   - (createAnotherObject (...)) (sub-chain 2 root SSA)
  //   - $yoo (sub-chain 2 -> merged into (createAnotherObject) SSA)
  //   - $yoo (sub-chain 2 -> merged into (createAnotherObject) SSA)
  // Total dimension = 6. Invalidated = 4. Remaining valid = 2 ($a and createAnotherObject).
  EXPECT_EQ(livenessMap.getDimension(), 6U);
  EXPECT_EQ(livenessMap.getValidDimension(), 2U);
}

} // namespace warpo::passes::gc::ut

#endif
