// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <array>
#include <atomic>
#include <cassert>
#include <memory>
#include <mutex>
#include <optional>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "Closure.hpp"
#include "helper/CFG.hpp"
#include "helper/DomTree.hpp"
#include "helper/ExprInserter.hpp"
#include "helper/FindExpr.hpp"
#include "ir/effects.h"
#include "warpo/support/Opt.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

namespace warpo::passes::closure {

static constexpr const char *const kSetClosureEnv = "~lib/rt/closure/setClosureEnv";
static constexpr const char *const kGetClosureEnvByLevel = "~lib/rt/closure/getClosureEnvByLevel";

static constexpr const char *const kSetFFIClosureEnv = "~lib/warpo/ffi/ffi.set_ffi_closure_env";

static constexpr const char *const kClosureEnvGlobal = "~lib/rt/closure/env";

static std::array<const char *const, 2> kClosureImportBases = {
    kSetClosureEnv,
    kGetClosureEnvByLevel,
};

namespace {

struct CacheLevelInLocalAction final {
  LevelDef levelAlreadyInLocal;
  LevelDef levelNeedStorageInLocal;
};

struct ActionPlan final {
  std::optional<std::vector<CacheLevelInLocalAction>> saveTempLevelAction;
  std::optional<LevelDef> lowerCallAction;
};

struct ClosureCallSummary final {
  bool hasGet;
  bool hasSet;
  bool hasFFISet;

  bool needsLowering() const noexcept { return (hasGet && hasSet) || hasFFISet; }
  bool needsSetOnlyRemoval() const noexcept { return !hasGet && hasSet; }
};

class ClosureCallScanner : public wasm::WalkerPass<wasm::PostWalker<ClosureCallScanner>> {
public:
  ClosureCallScanner(std::atomic<bool> &hasSet, std::atomic<bool> &hasFFISet) : hasSet(hasSet), hasFFISet(hasFFISet) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<ClosureCallScanner>(hasSet, hasFFISet); }

  void visitCall(wasm::Call *curr) {
    if (curr->target == kSetClosureEnv)
      hasSet.store(true, std::memory_order_relaxed);
    else if (curr->target == kSetFFIClosureEnv)
      hasFFISet.store(true, std::memory_order_relaxed);
  }

private:
  std::atomic<bool> &hasSet;
  std::atomic<bool> &hasFFISet;
};

ClosureCallSummary scanClosureCalls(wasm::Module *const m, wasm::PassRunner *const parentRunner) {
  std::atomic<bool> hasSet{false};
  std::atomic<bool> hasFFISet{false};
  {
    wasm::PassRunner runner{parentRunner};
    runner.add(std::make_unique<ClosureCallScanner>(hasSet, hasFFISet));
    runner.run();
  }
  return {
      m->getGlobalOrNull(kClosureEnvGlobal) != nullptr,
      hasSet.load(std::memory_order_relaxed),
      hasFFISet.load(std::memory_order_relaxed),
  };
}

void removeClosureImports(wasm::Module *const m) {
  for (const char *const name : kClosureImportBases)
    m->removeFunction(name);
  if (m->getFunctionOrNull(kSetFFIClosureEnv) != nullptr)
    m->removeFunction(kSetFFIClosureEnv);
}

class SetClosureEnvRemover : public wasm::WalkerPass<wasm::PostWalker<SetClosureEnvRemover>> {
public:
  explicit SetClosureEnvRemover(wasm::Name setClosureEnvName) : setClosureEnvName(std::move(setClosureEnvName)) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<SetClosureEnvRemover>(setClosureEnvName); }

  void visitCall(wasm::Call *const curr) {
    if (curr->target == setClosureEnvName) {
      auto *const load = curr->operands[0]->dynCast<wasm::Load>();
      assert(load && "first operand of setClosureEnv must be i32.load");
      constexpr uint32_t kForbiddenEffects =
          wasm::EffectAnalyzer::SideEffects::WritesLocal | wasm::EffectAnalyzer::SideEffects::Calls |
          wasm::EffectAnalyzer::SideEffects::Branches | wasm::EffectAnalyzer::SideEffects::WritesMemory |
          wasm::EffectAnalyzer::SideEffects::WritesGlobal;
      static_cast<void>(load);
      static_cast<void>(kForbiddenEffects);
      assert(!(wasm::EffectAnalyzer(getPassOptions(), *getModule(), load->ptr).getSideEffects() & kForbiddenEffects) &&
             "address of i32.load must not write locals/globals/memory, call, or branch");
      wasm::Builder b{*getModule()};
      replaceCurrent(b.makeNop());
    }
  }

private:
  wasm::Name setClosureEnvName;
};

void runSetClosureEnvRemoval(wasm::PassRunner *const parentRunner) {
  wasm::PassRunner runner{parentRunner};
  runner.add(std::make_unique<SetClosureEnvRemover>(kSetClosureEnv));
  runner.run();
}

wasm::Index getHeapLocalIndex(VariableInfo const *variableInfo, wasm::Function *func) {
  VariableInfo::SubProgramLookupMap const &lookupMap = variableInfo->getSubProgramLookupMap();
  VariableInfo::SubProgramLookupMap::const_iterator const it = lookupMap.find(func->name.view());
  assert(it != lookupMap.end() && "function not found in SubProgramLookupMap");
  std::optional<uint32_t> heapIdx = it->second.getHeapVariableStorageLocalIndex();
  assert(heapIdx.has_value() && "function has no heapVariableStorageLocalIndex");
  return *heapIdx;
}

wasm::Expression *lowerSetFFIClosureEnv(wasm::Call *const curr, wasm::Module *m, wasm::Function *func,
                                        VariableInfo const *variableInfo) {
  wasm::Builder b{*m};
  wasm::Index const heapIdx = getHeapLocalIndex(variableInfo, func);
  wasm::Name const memoryName = m->memories.front()->name;
  return b.makeStore(4, 0, 4, b.makeLocalGet(heapIdx, wasm::Type::i32), curr->operands[0], wasm::Type::i32, memoryName);
}

class ClosureEnvCommonLower : public wasm::WalkerPass<wasm::PostWalker<ClosureEnvCommonLower>> {
public:
  explicit ClosureEnvCommonLower(VariableInfo const *variableInfo) : variableInfo_(variableInfo) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<ClosureEnvCommonLower>(variableInfo_); }

  void visitCall(wasm::Call *const curr) {
    wasm::Builder b{*getModule()};
    if (curr->target == kSetClosureEnv) {
      replaceCurrent(b.makeGlobalSet(kClosureEnvGlobal, curr->operands[0]));
    } else if (curr->target == kSetFFIClosureEnv) {
      replaceCurrent(lowerSetFFIClosureEnv(curr, getModule(), getFunction(), variableInfo_));
    }
  }

private:
  VariableInfo const *variableInfo_;
};

wasm::Expression *fastLowerGetClosureEnvByLevel(wasm::Call *const curr, wasm::Module *m, wasm::Function *func,
                                                VariableInfo const *variableInfo) {
  wasm::Builder b{*m};
  wasm::Const const *const levelConst = curr->operands[0]->dynCast<wasm::Const>();
  assert(levelConst && "getClosureEnvByLevel parameter must be i32.const");
  int32_t const level = levelConst->value.geti32();

  wasm::Index const heapIdx = getHeapLocalIndex(variableInfo, func);
  wasm::Name const memoryName = m->memories.front()->name;
  wasm::Expression *addr = b.makeLocalGet(heapIdx, wasm::Type::i32);
  for (int32_t i = 0; i < level; ++i)
    addr = b.makeLoad(4, false, 0, 4, addr, wasm::Type::i32, memoryName);
  return addr;
}

class FastGetClosureEnvByLevelLower : public wasm::WalkerPass<wasm::PostWalker<FastGetClosureEnvByLevelLower>> {
public:
  explicit FastGetClosureEnvByLevelLower(VariableInfo const *variableInfo) : variableInfo_(variableInfo) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override {
    return std::make_unique<FastGetClosureEnvByLevelLower>(variableInfo_);
  }

  void visitCall(wasm::Call *const curr) {
    if (curr->target == kGetClosureEnvByLevel)
      replaceCurrent(fastLowerGetClosureEnvByLevel(curr, getModule(), getFunction(), variableInfo_));
  }

private:
  VariableInfo const *variableInfo_;
};

class SortedLevelDefs final {
public:
  bool insert(int32_t const level, wasm::Index const localIndex) {
    std::vector<LevelDef>::iterator const it = std::lower_bound(
        defs_.begin(), defs_.end(), level, [](LevelDef const &def, int32_t val) { return def.level < val; });
    if (it != defs_.end() && it->level == level)
      return false;
    defs_.insert(it, {level, localIndex});
    return true;
  }

  std::optional<LevelDef> getClosest(int32_t const level) const noexcept {
    std::vector<LevelDef>::const_iterator const it = std::upper_bound(
        defs_.begin(), defs_.end(), level, [](int32_t val, LevelDef const &def) { return val < def.level; });
    if (it == defs_.begin())
      return std::nullopt;
    return *std::prev(it);
  }

  bool empty() const noexcept { return defs_.empty(); }
  LevelDef const &front() const noexcept { return defs_.front(); }
  std::vector<LevelDef>::const_iterator begin() const noexcept { return defs_.begin(); }
  std::vector<LevelDef>::const_iterator end() const noexcept { return defs_.end(); }

private:
  std::vector<LevelDef> defs_;
};

class ClosureEnvDefMap final {

  struct BlockClosureInfo final {
    SortedLevelDefs definedLevels;
    std::vector<uint32_t> levelCounts;
  };

  bool isReusableNode(BasicBlock const *const block, int32_t const level) const noexcept {
    std::unordered_map<BasicBlock const *, BlockClosureInfo>::const_iterator const infoIt = blockInfos_.find(block);
    if (infoIt == blockInfos_.end())
      return false;
    BlockClosureInfo const &info = infoIt->second;
    for (size_t i = 1; i < info.levelCounts.size(); ++i) {
      if (info.levelCounts[i] > 0)
        return level <= static_cast<int32_t>(i);
    }
    return !info.definedLevels.empty() && level <= info.definedLevels.front().level;
  }

public:
  explicit ClosureEnvDefMap(wasm::Function *func)
      : cfg_(std::make_shared<CFG>(CFG::fromFunction(func))), domTree_(DomTree::create(cfg_)), func_(func) {}

  CFG const &cfg() const noexcept { return *cfg_; }

  void insertUsedLevel(BasicBlock const *const block, int32_t const level) {
    std::vector<uint32_t> &counts = blockInfos_[block].levelCounts;
    size_t const levelIndex = static_cast<size_t>(level);
    if (levelIndex >= counts.size())
      counts.resize(levelIndex + 1, 0);
    ++counts[levelIndex];
  }

  std::vector<uint32_t> const *getLevelCounts(BasicBlock const *const block) const noexcept {
    std::unordered_map<BasicBlock const *, BlockClosureInfo>::const_iterator const it = blockInfos_.find(block);
    if (it == blockInfos_.end())
      return nullptr;
    return &it->second.levelCounts;
  }

  // Allocates a new i32 local and records (level -> localIndex) in the sorted list for the given block.
  // Returns the allocated local index, or nullopt if the level is already defined.
  std::optional<wasm::Index> addDef(BasicBlock const *const block, int32_t const level,
                                    DynBitset const *const insideLoop = nullptr) {
    BasicBlock const *insertBlock = block;
    for (BasicBlock const *domBlock = block; domBlock != nullptr; domBlock = domTree_.getIDom(domBlock)) {
      if (isReusableNode(domBlock, level))
        insertBlock = domBlock;
    }
    if (insideLoop != nullptr) {
      for (BasicBlock const *domBlock = insertBlock; domBlock != nullptr; domBlock = domTree_.getIDom(domBlock)) {
        if (!insideLoop->get(domBlock->getIndex())) {
          insertBlock = domBlock;
          break;
        }
      }
    }

    wasm::Index const localIdx = wasm::Builder::addVar(func_, wasm::Type::i32);
    if (!blockInfos_[insertBlock].definedLevels.insert(level, localIdx))
      return std::nullopt;
    return localIdx;
  }

  // Returns the closest def with level <= the given level in the given block, or nullopt if none.
  std::optional<LevelDef> getClosestDef(BasicBlock const *const block, int32_t const level) const noexcept {
    for (BasicBlock const *domBlock = block; domBlock != nullptr; domBlock = domTree_.getIDom(domBlock)) {
      std::unordered_map<BasicBlock const *, BlockClosureInfo>::const_iterator const infoIt =
          blockInfos_.find(domBlock);
      if (infoIt == blockInfos_.end())
        continue;
      std::optional<LevelDef> const def = infoIt->second.definedLevels.getClosest(level);
      if (def.has_value())
        return def;
    }
    return std::nullopt;
  }

  void getInsertions(VariableInfo const *variableInfo,
                     std::unordered_map<wasm::Expression *, ActionPlan> &actionPlans) const {
    wasm::Index const heapIdx = getHeapLocalIndex(variableInfo, func_);
    LevelDef const level0{0, heapIdx};
    for (auto const &[block, info] : blockInfos_) {
      if (info.definedLevels.empty())
        continue;
      wasm::Expression *anchor = nullptr;
      for (wasm::Expression *const expr : *block) {
        wasm::Call const *const call = expr->dynCast<wasm::Call>();
        if (call != nullptr && call->target == kGetClosureEnvByLevel) {
          anchor = expr;
          break;
        }
      }
      if (anchor == nullptr) {
        assert(block->size() > 0 && "no expressions in BasicBlock for block-end insertion");
        anchor = *block->rbegin();
      }
      for (LevelDef const &def : info.definedLevels) {
        assert(def.level > 0 && "cached closure levels must be greater than zero");
        std::optional<LevelDef> const levelAlreadyInLocal = getClosestDef(block, def.level - 1);
        ActionPlan &actionPlan = actionPlans[anchor];
        if (!actionPlan.saveTempLevelAction.has_value())
          actionPlan.saveTempLevelAction.emplace();
        actionPlan.saveTempLevelAction->push_back({levelAlreadyInLocal.value_or(level0), def});
      }
    }
  }

private:
  std::shared_ptr<CFG> cfg_;
  DomTree domTree_;
  std::unordered_map<BasicBlock const *, BlockClosureInfo> blockInfos_;
  wasm::Function *func_;
};

template <typename F> void forEachGetClosureEnvByLevel(CFG const &cfg, F &&fn) {
  for (BasicBlock const &bb : cfg) {
    for (wasm::Expression *const expr : bb) {
      wasm::Call *const call = expr->dynCast<wasm::Call>();
      if (call == nullptr || call->target != kGetClosureEnvByLevel)
        continue;
      wasm::Const const *const levelConst = call->operands[0]->dynCast<wasm::Const>();
      assert(levelConst != nullptr);
      int32_t const level = levelConst->value.geti32();
      fn(bb, call, level);
    }
  }
}

struct PerFunctionAnalysisResult final {
  std::unordered_map<wasm::Expression *, ActionPlan> actionPlans;
};

class OptClosureEnvAnalyzer final : public wasm::WalkerPass<wasm::PostWalker<OptClosureEnvAnalyzer>> {
public:
  OptClosureEnvAnalyzer(VariableInfo const *variableInfo, std::vector<PerFunctionAnalysisResult> &results,
                        std::mutex &mu) noexcept
      : variableInfo_(variableInfo), results_(results), mu_(mu) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override {
    return std::make_unique<OptClosureEnvAnalyzer>(variableInfo_, results_, mu_);
  }

  void doWalkFunction(wasm::Function *func) {
    VariableInfo::SubProgramLookupMap const &lookupMap = variableInfo_->getSubProgramLookupMap();
    VariableInfo::SubProgramLookupMap::const_iterator const spIt = lookupMap.find(func->name.view());
    if (spIt == lookupMap.end() || !spIt->second.getHeapVariableStorageLocalIndex().has_value())
      return;
    wasm::Index const heapIdx = *spIt->second.getHeapVariableStorageLocalIndex();
    ClosureEnvDefMap defMap(func);
    forEachGetClosureEnvByLevel(defMap.cfg(), [&](BasicBlock const &bb, wasm::Call *, int32_t const level) {
      if (level > 0)
        defMap.insertUsedLevel(&bb, level);
    });
    DynBitset const insideLoop = defMap.cfg().getBlockInsideLoop();
    std::unordered_set<BasicBlock const *> loopHandled;
    for (BasicBlock const &bb : defMap.cfg()) {
      if (!insideLoop.get(bb.getIndex()))
        continue;
      bool const anySuccInLoop = std::any_of(bb.succs().begin(), bb.succs().end(),
                                             [&](BasicBlock const *succ) { return insideLoop.get(succ->getIndex()); });
      if (!anySuccInLoop)
        continue;
      std::vector<uint32_t> const *const levelCounts = defMap.getLevelCounts(&bb);
      if (levelCounts == nullptr || levelCounts->empty())
        continue;
      for (size_t levelIndex = 1; levelIndex < levelCounts->size(); ++levelIndex) {
        if ((*levelCounts)[levelIndex] > 0)
          defMap.addDef(&bb, static_cast<int32_t>(levelIndex), &insideLoop);
      }
      loopHandled.insert(&bb);
    }
    for (BasicBlock const &bb : defMap.cfg()) {
      if (loopHandled.contains(&bb))
        continue;
      std::vector<uint32_t> const *const levelCounts = defMap.getLevelCounts(&bb);
      if (levelCounts == nullptr || levelCounts->empty())
        continue;
      int32_t const maxLevel = static_cast<int32_t>(levelCounts->size() - 1);
      for (size_t levelIndex = 1; levelIndex < levelCounts->size(); ++levelIndex) {
        uint32_t const count = (*levelCounts)[levelIndex];
        if (count == 0)
          continue;
        int32_t const level = static_cast<int32_t>(levelIndex);
        if (level < maxLevel || count > 1)
          defMap.addDef(&bb, level);
      }
    }

    std::unordered_map<wasm::Expression *, ActionPlan> localActionPlans;
    defMap.getInsertions(variableInfo_, localActionPlans);
    forEachGetClosureEnvByLevel(defMap.cfg(), [&](BasicBlock const &bb, wasm::Call *call, int32_t const level) {
      std::optional<LevelDef> const def = defMap.getClosestDef(&bb, level);
      localActionPlans[call].lowerCallAction = def.value_or(LevelDef{0, heapIdx});
    });

    std::lock_guard<std::mutex> const lock(mu_);
    results_.push_back({std::move(localActionPlans)});
  }

private:
  VariableInfo const *variableInfo_;
  std::vector<PerFunctionAnalysisResult> &results_;
  std::mutex &mu_;
};

class OptGetClosureEnvByLevelLower
    : public wasm::WalkerPass<wasm::PostWalker<OptGetClosureEnvByLevelLower,
                                               wasm::UnifiedExpressionVisitor<OptGetClosureEnvByLevelLower>>> {
public:
  explicit OptGetClosureEnvByLevelLower(std::unordered_map<wasm::Expression *, ActionPlan> const &actionPlans)
      : actionPlans_(actionPlans) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<OptGetClosureEnvByLevelLower>(actionPlans_); }

  void visitExpression(wasm::Expression *const curr) {
    std::unordered_map<wasm::Expression *, ActionPlan>::const_iterator const actionIt = actionPlans_.find(curr);
    if (actionIt == actionPlans_.end())
      return;
    ActionPlan const &actionPlan = actionIt->second;
    if (actionPlan.saveTempLevelAction.has_value() && actionPlan.lowerCallAction.has_value()) {
      wasm::Call *const call = curr->dynCast<wasm::Call>();
      assert(call != nullptr && call->target == kGetClosureEnvByLevel);
      wasm::Const const *const levelConst = call->operands[0]->dynCast<wasm::Const>();
      assert(levelConst && "getClosureEnvByLevel parameter must be i32.const");
      wasm::Expression *const lowered =
          lowerGetClosureEnvByLevel(*actionPlan.lowerCallAction, levelConst->value.geti32());
      replaceCurrent(makeSaveTempLevelBlock(*actionPlan.saveTempLevelAction, lowered));
      return;
    }

    if (actionPlan.saveTempLevelAction.has_value()) {
      insertSaveTempLevelActions(curr, *actionPlan.saveTempLevelAction);
      return;
    }

    if (!actionPlan.lowerCallAction.has_value())
      return;

    wasm::Call *const call = curr->dynCast<wasm::Call>();
    assert(call != nullptr && call->target == kGetClosureEnvByLevel);
    wasm::Const const *const levelConst = call->operands[0]->dynCast<wasm::Const>();
    assert(levelConst && "getClosureEnvByLevel parameter must be i32.const");
    replaceCurrent(lowerGetClosureEnvByLevel(*actionPlan.lowerCallAction, levelConst->value.geti32()));
  }

  wasm::Expression *lowerGetClosureEnvByLevel(LevelDef const &action, int32_t const neededLevel) {
    wasm::Module *const m = this->getModule();

    wasm::Builder b{*m};

    wasm::Expression *addr = b.makeLocalGet(action.localIndex, wasm::Type::i32);

    wasm::Name const memoryName = m->memories.front()->name;
    for (int32_t i = action.level; i < neededLevel; ++i)
      addr = b.makeLoad(4, false, 0, 4, addr, wasm::Type::i32, memoryName);

    return addr;
  }

private:
  std::vector<wasm::Expression *> makeSaveTempLevelLocalSets(std::vector<CacheLevelInLocalAction> const &actions) {
    wasm::Builder b{*getModule()};
    wasm::Name const memoryName = getModule()->memories.front()->name;
    std::vector<wasm::Expression *> localSets;
    for (CacheLevelInLocalAction const &action : actions) {
      wasm::Expression *addr = b.makeLocalGet(action.levelAlreadyInLocal.localIndex, wasm::Type::i32);
      for (int32_t i = action.levelAlreadyInLocal.level; i < action.levelNeedStorageInLocal.level; ++i)
        addr = b.makeLoad(4, false, 0, 4, addr, wasm::Type::i32, memoryName);
      localSets.push_back(b.makeLocalSet(action.levelNeedStorageInLocal.localIndex, addr));
    }
    return localSets;
  }

  wasm::Expression *makeSaveTempLevelBlock(std::vector<CacheLevelInLocalAction> const &actions,
                                           wasm::Expression *resultExpr) {
    wasm::Builder b{*getModule()};
    std::vector<wasm::Expression *> exprs = makeSaveTempLevelLocalSets(actions);
    exprs.push_back(resultExpr);
    return b.makeBlock(exprs, resultExpr->type);
  }

  void insertSaveTempLevelActions(wasm::Expression *const curr, std::vector<CacheLevelInLocalAction> const &actions) {
    wasm::Builder b{*getModule()};
    ExprInserter inserter{getFunction()};
    wasm::Expression *const inserted = b.makeBlock(makeSaveTempLevelLocalSets(actions), wasm::Type::none);

    inserter.insertAtEndOfBB(b, inserted, findExprPointer(curr, getFunction()));
  }

  std::unordered_map<wasm::Expression *, ActionPlan> const &actionPlans_;
};

} // namespace

void FastLower::run(wasm::Module *m) {
  wasm::PassRunner *const parentRunner = getPassRunner();
  ClosureCallSummary const summary = scanClosureCalls(m, parentRunner);

  if (summary.needsLowering()) {
    wasm::PassRunner passRunner{parentRunner};
    passRunner.add(std::make_unique<ClosureEnvCommonLower>(variableInfo_));
    passRunner.add(std::make_unique<FastGetClosureEnvByLevelLower>(variableInfo_));
    passRunner.run();
  } else if (summary.needsSetOnlyRemoval()) {
    runSetClosureEnvRemoval(parentRunner);
  }

  removeClosureImports(m);
}

void OptLower::run(wasm::Module *m) {
  wasm::PassRunner *const parentRunner = getPassRunner();
  ClosureCallSummary const summary = scanClosureCalls(m, parentRunner);

  if (summary.needsLowering()) {
    {
      wasm::PassRunner passRunner{parentRunner};
      passRunner.add(std::make_unique<ClosureEnvCommonLower>(variableInfo_));
      passRunner.run();
    }
    std::vector<PerFunctionAnalysisResult> analysisResults;
    std::unordered_map<wasm::Expression *, ActionPlan> actionPlans;
    std::mutex mu;
    {
      wasm::PassRunner passRunner{parentRunner};
      passRunner.add(std::make_unique<OptClosureEnvAnalyzer>(variableInfo_, analysisResults, mu));
      passRunner.run();

      for (PerFunctionAnalysisResult &result : analysisResults) {
        actionPlans.merge(result.actionPlans);
      }
    }
    wasm::PassRunner passRunner{parentRunner};
    passRunner.add(std::make_unique<OptGetClosureEnvByLevelLower>(actionPlans));
    passRunner.run();
  } else if (summary.needsSetOnlyRemoval()) {
    runSetClosureEnvRemoval(parentRunner);
  }

  removeClosureImports(m);
}

} // namespace warpo::passes::closure

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "helper/Matcher.hpp"
#include "pass.h"

namespace warpo::passes::ut {
namespace {
TEST(ClosureLower, SetOnlyRemovesCallsAndFunctions) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (memory 1)
      (func $caller
        (call $~lib/rt/closure/setClosureEnv (i32.load (i32.const 0)))
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::FastLower(nullptr)});
  runner.run();

  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/setClosureEnv"), nullptr);
  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/getClosureEnvByLevel"), nullptr);

  wasm::Function *const caller = m->getFunctionOrNull("caller");
  ASSERT_NE(caller, nullptr);
  EXPECT_TRUE(caller->body->is<wasm::Nop>());
}

TEST(ClosureLower, NoClosureCallsKeepsFunctions) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (func $caller
        nop
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::FastLower(nullptr)});
  runner.run();

  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/setClosureEnv"), nullptr);
  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/getClosureEnvByLevel"), nullptr);
}

TEST(ClosureLower, BothGetAndSetLowersToGlobalAndLocal) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $setter
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
      )
      (func $getter (result i32)
        (global.get $~lib/rt/closure/env)
      )
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 0))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 0);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::FastLower(&variableInfo)});
  runner.run();

  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/setClosureEnv"), nullptr);
  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/getClosureEnvByLevel"), nullptr);

  EXPECT_NE(m->getGlobalOrNull("~lib/rt/closure/env"), nullptr);

  wasm::Function *const setter = m->getFunctionOrNull("setter");
  ASSERT_NE(setter, nullptr);
  EXPECT_TRUE(setter->body->is<wasm::GlobalSet>());

  wasm::Function *const getter = m->getFunctionOrNull("getter");
  ASSERT_NE(getter, nullptr);
  EXPECT_TRUE(getter->body->is<wasm::GlobalGet>());

  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);
  EXPECT_TRUE(levelGetter->body->is<wasm::LocalGet>());
}

TEST(ClosureLower, GetClosureEnvByLevelWithChainedLoads) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $setter
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
      )
      (func $level1 (result i32) (local i32)
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1))
      )
      (func $level2 (result i32) (local i32)
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("level1", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("level1", 0);
  variableInfo.addSubProgram("level2", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("level2", 0);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::FastLower(&variableInfo)});
  runner.run();

  // level=1: i32.load(local.get)
  wasm::Function *const level1 = m->getFunctionOrNull("level1");
  ASSERT_NE(level1, nullptr);
  ASSERT_TRUE(level1->body->is<wasm::Load>());
  EXPECT_TRUE(level1->body->cast<wasm::Load>()->ptr->is<wasm::LocalGet>());

  // level=2: i32.load(i32.load(local.get))
  wasm::Function *const level2 = m->getFunctionOrNull("level2");
  ASSERT_NE(level2, nullptr);
  ASSERT_TRUE(level2->body->is<wasm::Load>());
  wasm::Load *const outerLoad = level2->body->cast<wasm::Load>();
  ASSERT_TRUE(outerLoad->ptr->is<wasm::Load>());
  EXPECT_TRUE(outerLoad->ptr->cast<wasm::Load>()->ptr->is<wasm::LocalGet>());
}

TEST(ClosureLower, FFISetClosureEnvLowersToStore) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (import "as-builtin-fn" "set_ffi_closure_env" (func $~lib/warpo/ffi/ffi.set_ffi_closure_env (param i32)))
      (memory 1)
      (func $callback (param i32) (local i32)
        (call $~lib/warpo/ffi/ffi.set_ffi_closure_env (local.get 0))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("callback", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("callback", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::FastLower(&variableInfo)});
  runner.run();

  EXPECT_EQ(m->getFunctionOrNull("~lib/warpo/ffi/ffi.set_ffi_closure_env"), nullptr);

  wasm::Function *const callback = m->getFunctionOrNull("callback");
  ASSERT_NE(callback, nullptr);
  ASSERT_TRUE(callback->body->is<wasm::Store>());
  wasm::Store *const store = callback->body->cast<wasm::Store>();
  EXPECT_EQ(store->offset, 0U);
  EXPECT_TRUE(store->ptr->is<wasm::LocalGet>());
  EXPECT_EQ(store->ptr->cast<wasm::LocalGet>()->index, 1U);
  EXPECT_TRUE(store->value->is<wasm::LocalGet>());
  EXPECT_EQ(store->value->cast<wasm::LocalGet>()->index, 0U);
}

TEST(ClosureLower, OptLowerCachesFromClosestDef) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 0);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  matcher::M<wasm::Expression> const match = isBlock({
      block::at(1, isDrop(drop::v(isBlock({
                       block::has(3),
                       block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(0))))))
                                        .bind("level1Cache")),
                       block::at(1, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet().bind("level2Source")))))),
                   })))),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  wasm::LocalGet const *const level2Source = ctx.getBinding<wasm::LocalGet>("level2Source");
  ASSERT_NE(level1Cache, nullptr);
  ASSERT_NE(level2Source, nullptr);
  EXPECT_EQ(level2Source->index, level1Cache->index);
}

TEST(ClosureLower, OptLowerNoCachingWhenSingleUse) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 0);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // level=1, count=1, maxLevel=1 → no caching, lowered as i32.load(local.get $0)
  isMatched(isBlock({
                block::has(2),
                block::at(0, isGlobalSet()),
                block::at(1, isLoad(load::ptr(isLocalGet(local_get::index(0))))),
            }),
            levelGetter->body);
}

TEST(ClosureLower, OptLowerSingleLevelRepeated) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 0);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // level=1, count=2 → cached. Cache block wraps first use.
  // Both uses read from the same cache local.
  matcher::M<wasm::Expression> const match = isBlock({
      block::at(1, isDrop(drop::v(isBlock({
                       block::has(2),
                       block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(0))))))
                                        .bind("level1Cache")),
                       block::at(1, isLocalGet().bind("firstUse")),
                   })))),
      block::at(2, isLocalGet().bind("secondUse")),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  wasm::LocalGet const *const firstUse = ctx.getBinding<wasm::LocalGet>("firstUse");
  wasm::LocalGet const *const secondUse = ctx.getBinding<wasm::LocalGet>("secondUse");
  ASSERT_NE(level1Cache, nullptr);
  ASSERT_NE(firstUse, nullptr);
  ASSERT_NE(secondUse, nullptr);
  EXPECT_EQ(firstUse->index, level1Cache->index);
  EXPECT_EQ(secondUse->index, level1Cache->index);
}

TEST(ClosureLower, OptLowerReusesDominatingDefAcrossBasicBlocks) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (if (local.get 0)
          (then
            nop
          )
        )
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  matcher::M<wasm::Expression> const match = isBlock({
      block::at(1, isDrop(drop::v(isBlock({
                       block::has(2),
                       block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(1))))))
                                        .bind("level1Cache")),
                       block::at(1, isLocalGet().bind("firstUse")),
                   })))),
      block::at(2, isDrop(drop::v(isLocalGet().bind("secondUse")))),
      block::at(3, isIf()),
      block::at(4, isLoad(load::ptr(isLocalGet().bind("mergeUse")))),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  wasm::LocalGet const *const firstUse = ctx.getBinding<wasm::LocalGet>("firstUse");
  wasm::LocalGet const *const secondUse = ctx.getBinding<wasm::LocalGet>("secondUse");
  wasm::LocalGet const *const mergeUse = ctx.getBinding<wasm::LocalGet>("mergeUse");
  ASSERT_NE(level1Cache, nullptr);
  ASSERT_NE(firstUse, nullptr);
  ASSERT_NE(secondUse, nullptr);
  ASSERT_NE(mergeUse, nullptr);
  EXPECT_EQ(firstUse->index, level1Cache->index);
  EXPECT_EQ(secondUse->index, level1Cache->index);
  EXPECT_EQ(mergeUse->index, level1Cache->index);
}

TEST(ClosureLower, OptLowerReusesExactDominatingDefAcrossBasicBlocks) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (if (local.get 0)
          (then
            nop
          )
        )
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  matcher::M<wasm::Expression> const match = isBlock({
      block::at(1, isDrop(drop::v(isBlock({
                       block::has(2),
                       block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(1))))))
                                        .bind("level1Cache")),
                       block::at(1, isLocalGet().bind("firstUse")),
                   })))),
      block::at(2, isDrop(drop::v(isLocalGet().bind("secondUse")))),
      block::at(3, isIf()),
      block::at(4, isLocalGet().bind("mergeUse")),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  wasm::LocalGet const *const firstUse = ctx.getBinding<wasm::LocalGet>("firstUse");
  wasm::LocalGet const *const secondUse = ctx.getBinding<wasm::LocalGet>("secondUse");
  wasm::LocalGet const *const mergeUse = ctx.getBinding<wasm::LocalGet>("mergeUse");
  ASSERT_NE(level1Cache, nullptr);
  ASSERT_NE(firstUse, nullptr);
  ASSERT_NE(secondUse, nullptr);
  ASSERT_NE(mergeUse, nullptr);
  EXPECT_EQ(firstUse->index, level1Cache->index);
  EXPECT_EQ(secondUse->index, level1Cache->index);
  EXPECT_EQ(mergeUse->index, level1Cache->index);
}

TEST(ClosureLower, OptLowerCreatesChildDefFromDominatingParentCache) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (if (local.get 0)
          (then
            nop
          )
        )
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  matcher::M<wasm::Expression> const match = isBlock({
      block::at(1, isDrop(drop::v(isBlock({
                       block::has(2),
                       block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(1))))))
                                        .bind("level1Cache")),
                       block::at(1, isLocalGet().bind("firstLevel1Use")),
                   })))),
      block::at(2, isDrop(drop::v(isLocalGet().bind("secondLevel1Use")))),
      block::at(3, isIf()),
      block::at(4, isDrop(drop::v(isBlock({
                       block::has(2),
                       block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet().bind("level2From")))))
                                        .bind("level2Cache")),
                       block::at(1, isLocalGet().bind("firstLevel2Use")),
                   })))),
      block::at(5, isLocalGet().bind("secondLevel2Use")),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  wasm::LocalGet const *const firstLevel1Use = ctx.getBinding<wasm::LocalGet>("firstLevel1Use");
  wasm::LocalGet const *const secondLevel1Use = ctx.getBinding<wasm::LocalGet>("secondLevel1Use");
  wasm::LocalGet const *const level2From = ctx.getBinding<wasm::LocalGet>("level2From");
  wasm::LocalSet const *const level2Cache = ctx.getBinding<wasm::LocalSet>("level2Cache");
  wasm::LocalGet const *const firstLevel2Use = ctx.getBinding<wasm::LocalGet>("firstLevel2Use");
  wasm::LocalGet const *const secondLevel2Use = ctx.getBinding<wasm::LocalGet>("secondLevel2Use");
  ASSERT_NE(level1Cache, nullptr);
  ASSERT_NE(firstLevel1Use, nullptr);
  ASSERT_NE(secondLevel1Use, nullptr);
  ASSERT_NE(level2From, nullptr);
  ASSERT_NE(level2Cache, nullptr);
  ASSERT_NE(firstLevel2Use, nullptr);
  ASSERT_NE(secondLevel2Use, nullptr);
  EXPECT_EQ(firstLevel1Use->index, level1Cache->index);
  EXPECT_EQ(secondLevel1Use->index, level1Cache->index);
  EXPECT_EQ(level2From->index, level1Cache->index);
  EXPECT_EQ(firstLevel2Use->index, level2Cache->index);
  EXPECT_EQ(secondLevel2Use->index, level2Cache->index);
}

TEST(ClosureLower, OptLowerHoistsDefToTopMostReusableDominator) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
        (if (local.get 0)
          (then
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
          )
        )
        (i32.const 0)
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  matcher::M<wasm::Expression> const match = isBlock({
      block::at(
          1,
          isDrop(drop::v(isBlock({
              block::has(3),
              block::at(
                  0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(1)))))).bind("level1Cache")),
              block::at(
                  1, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet().bind("level2From"))))).bind("level2Cache")),
              block::at(2, isLocalGet().bind("firstLevel2Use")),
          })))),
      block::at(2, isDrop(drop::v(isLocalGet().bind("secondLevel2Use")))),
      block::at(3, isIf().bind("branch")),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  wasm::LocalGet const *const level2From = ctx.getBinding<wasm::LocalGet>("level2From");
  wasm::LocalSet const *const level2Cache = ctx.getBinding<wasm::LocalSet>("level2Cache");
  wasm::LocalGet const *const firstLevel2Use = ctx.getBinding<wasm::LocalGet>("firstLevel2Use");
  wasm::LocalGet const *const secondLevel2Use = ctx.getBinding<wasm::LocalGet>("secondLevel2Use");
  wasm::If const *const branch = ctx.getBinding<wasm::If>("branch");
  ASSERT_NE(level1Cache, nullptr);
  ASSERT_NE(level2From, nullptr);
  ASSERT_NE(level2Cache, nullptr);
  ASSERT_NE(firstLevel2Use, nullptr);
  ASSERT_NE(secondLevel2Use, nullptr);
  ASSERT_NE(branch, nullptr);
  EXPECT_EQ(level2From->index, level1Cache->index);
  EXPECT_EQ(firstLevel2Use->index, level2Cache->index);
  EXPECT_EQ(secondLevel2Use->index, level2Cache->index);

  matcher::M<wasm::Expression> const thenMatch = isBlock({
      block::at(0, isDrop(drop::v(isLocalGet().bind("thenFirstUse")))),
      block::at(1, isDrop(drop::v(isLocalGet().bind("thenSecondUse")))),
  });
  isMatched(thenMatch, branch->ifTrue);

  matcher::Context thenCtx{};
  ASSERT_TRUE(thenMatch(*branch->ifTrue, thenCtx));

  wasm::LocalGet const *const thenFirstUse = thenCtx.getBinding<wasm::LocalGet>("thenFirstUse");
  wasm::LocalGet const *const thenSecondUse = thenCtx.getBinding<wasm::LocalGet>("thenSecondUse");
  ASSERT_NE(thenFirstUse, nullptr);
  ASSERT_NE(thenSecondUse, nullptr);
  EXPECT_EQ(thenFirstUse->index, level1Cache->index);
  EXPECT_EQ(thenSecondUse->index, level1Cache->index);
}

TEST(ClosureLower, OptLowerStopsHoistingAtNonReusableAncestor) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32 i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (if (local.get 0)
          (then
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 3)))
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 3)))
            (if (local.get 1)
              (then
                (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
                (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
              )
            )
          )
        )
        (i32.const 0)
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 2);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  matcher::M<wasm::Expression> const match = isBlock({
      block::at(1, isDrop(drop::v(isLoad(load::ptr(isLocalGet(local_get::index(2))))))),
      block::at(2, isIf().bind("outerIf")),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::If const *const outerIf = ctx.getBinding<wasm::If>("outerIf");
  ASSERT_NE(outerIf, nullptr);

  matcher::M<wasm::Expression> const outerThenMatch = isBlock({
      block::at(0, isDrop(drop::v(isBlock({
                       block::has(3),
                       block::at(0, isLocalSet(local_set::v(isLoad(
                                                   load::ptr(isLoad(load::ptr(isLocalGet(local_get::index(2))))))))
                                        .bind("level2Cache")),
                       block::at(1, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet().bind("level3From")))))
                                        .bind("level3Cache")),
                       block::at(2, isLocalGet().bind("firstLevel3Use")),
                   })))),
      block::at(1, isDrop(drop::v(isLocalGet().bind("secondLevel3Use")))),
      block::at(2, isIf().bind("innerIf")),
  });
  isMatched(outerThenMatch, outerIf->ifTrue);

  matcher::Context outerThenCtx{};
  ASSERT_TRUE(outerThenMatch(*outerIf->ifTrue, outerThenCtx));

  wasm::LocalSet const *const level2Cache = outerThenCtx.getBinding<wasm::LocalSet>("level2Cache");
  wasm::LocalGet const *const level3From = outerThenCtx.getBinding<wasm::LocalGet>("level3From");
  wasm::LocalSet const *const level3Cache = outerThenCtx.getBinding<wasm::LocalSet>("level3Cache");
  wasm::LocalGet const *const firstLevel3Use = outerThenCtx.getBinding<wasm::LocalGet>("firstLevel3Use");
  wasm::LocalGet const *const secondLevel3Use = outerThenCtx.getBinding<wasm::LocalGet>("secondLevel3Use");
  wasm::If const *const innerIf = outerThenCtx.getBinding<wasm::If>("innerIf");
  ASSERT_NE(level2Cache, nullptr);
  ASSERT_NE(level3From, nullptr);
  ASSERT_NE(level3Cache, nullptr);
  ASSERT_NE(firstLevel3Use, nullptr);
  ASSERT_NE(secondLevel3Use, nullptr);
  ASSERT_NE(innerIf, nullptr);
  EXPECT_EQ(level3From->index, level2Cache->index);
  EXPECT_EQ(firstLevel3Use->index, level3Cache->index);
  EXPECT_EQ(secondLevel3Use->index, level3Cache->index);

  matcher::M<wasm::Expression> const innerThenMatch = isBlock({
      block::at(0, isDrop(drop::v(isLocalGet().bind("firstLevel2Use")))),
      block::at(1, isDrop(drop::v(isLocalGet().bind("secondLevel2Use")))),
  });
  isMatched(innerThenMatch, innerIf->ifTrue);

  matcher::Context innerThenCtx{};
  ASSERT_TRUE(innerThenMatch(*innerIf->ifTrue, innerThenCtx));

  wasm::LocalGet const *const firstLevel2Use = innerThenCtx.getBinding<wasm::LocalGet>("firstLevel2Use");
  wasm::LocalGet const *const secondLevel2Use = innerThenCtx.getBinding<wasm::LocalGet>("secondLevel2Use");
  ASSERT_NE(firstLevel2Use, nullptr);
  ASSERT_NE(secondLevel2Use, nullptr);
  EXPECT_EQ(firstLevel2Use->index, level2Cache->index);
  EXPECT_EQ(secondLevel2Use->index, level2Cache->index);
}

TEST(ClosureLower, OptLowerThreeLevelsChaining) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 3))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 0);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // levels 1,2,3 each once. maxLevel=3.
  // level1: 1<3 → cached from level0
  // level2: 2<3 → cached from level1
  // level3: count=1, is max → NOT cached, uses level2 cache + one load
  matcher::M<wasm::Expression> const match = isBlock({
      block::at(
          1,
          isDrop(drop::v(isBlock({
              block::has(3),
              block::at(
                  0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(0)))))).bind("level1Cache")),
              block::at(
                  1, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet().bind("level2From"))))).bind("level2Cache")),
              block::at(2, isLocalGet().bind("use1")),
          })))),
      block::at(2, isDrop(drop::v(isLocalGet().bind("use2")))),
      block::at(3, isLoad(load::ptr(isLocalGet().bind("use3")))),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  wasm::LocalSet const *const level2Cache = ctx.getBinding<wasm::LocalSet>("level2Cache");
  wasm::LocalGet const *const level2From = ctx.getBinding<wasm::LocalGet>("level2From");
  wasm::LocalGet const *const use1 = ctx.getBinding<wasm::LocalGet>("use1");
  wasm::LocalGet const *const use2 = ctx.getBinding<wasm::LocalGet>("use2");
  wasm::LocalGet const *const use3 = ctx.getBinding<wasm::LocalGet>("use3");
  ASSERT_NE(level1Cache, nullptr);
  ASSERT_NE(level2Cache, nullptr);
  ASSERT_NE(level2From, nullptr);
  ASSERT_NE(use1, nullptr);
  ASSERT_NE(use2, nullptr);
  ASSERT_NE(use3, nullptr);
  // level2 cache built from level1 cache
  EXPECT_EQ(level2From->index, level1Cache->index);
  // getByLevel(1) uses level1 cache
  EXPECT_EQ(use1->index, level1Cache->index);
  // getByLevel(2) uses level2 cache
  EXPECT_EQ(use2->index, level2Cache->index);
  // getByLevel(3) uses level2 cache + one more load
  EXPECT_EQ(use3->index, level2Cache->index);
}

TEST(ClosureLower, OptLowerLevelZeroNoCaching) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 0)))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 0))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 0);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // level=0 is never counted (skipped by `if (level > 0)`), so no caching.
  // Both lowered to local.get $0 (heapIdx).
  isMatched(isBlock({
                block::has(3),
                block::at(0, isGlobalSet()),
                block::at(1, isDrop(drop::v(isLocalGet(local_get::index(0))))),
                block::at(2, isLocalGet(local_get::index(0))),
            }),
            levelGetter->body);
}

TEST(ClosureLower, OptLowerCachesIndependentlyInIfElseBranches) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (if (local.get 0)
          (then
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
          )
          (else
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
          )
        )
        (i32.const 0)
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  matcher::M<wasm::Expression> const match = isBlock({
      block::at(0, isGlobalSet()),
      block::at(1, isIf().bind("branch")),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::If const *const branch = ctx.getBinding<wasm::If>("branch");
  ASSERT_NE(branch, nullptr);

  // then branch: independent cache
  matcher::M<wasm::Expression> const thenMatch = isBlock({
      block::at(
          0, isDrop(drop::v(isBlock({
                 block::has(2),
                 block::at(
                     0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(1)))))).bind("thenCache")),
                 block::at(1, isLocalGet().bind("thenFirstUse")),
             })))),
      block::at(1, isDrop(drop::v(isLocalGet().bind("thenSecondUse")))),
  });
  isMatched(thenMatch, branch->ifTrue);

  matcher::Context thenCtx{};
  ASSERT_TRUE(thenMatch(*branch->ifTrue, thenCtx));

  wasm::LocalSet const *const thenCache = thenCtx.getBinding<wasm::LocalSet>("thenCache");
  wasm::LocalGet const *const thenFirstUse = thenCtx.getBinding<wasm::LocalGet>("thenFirstUse");
  wasm::LocalGet const *const thenSecondUse = thenCtx.getBinding<wasm::LocalGet>("thenSecondUse");
  ASSERT_NE(thenCache, nullptr);
  ASSERT_NE(thenFirstUse, nullptr);
  ASSERT_NE(thenSecondUse, nullptr);
  EXPECT_EQ(thenFirstUse->index, thenCache->index);
  EXPECT_EQ(thenSecondUse->index, thenCache->index);

  // else branch: independent cache
  matcher::M<wasm::Expression> const elseMatch = isBlock({
      block::at(
          0, isDrop(drop::v(isBlock({
                 block::has(2),
                 block::at(
                     0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(1)))))).bind("elseCache")),
                 block::at(1, isLocalGet().bind("elseFirstUse")),
             })))),
      block::at(1, isDrop(drop::v(isLocalGet().bind("elseSecondUse")))),
  });
  isMatched(elseMatch, branch->ifFalse);

  matcher::Context elseCtx{};
  ASSERT_TRUE(elseMatch(*branch->ifFalse, elseCtx));

  wasm::LocalSet const *const elseCache = elseCtx.getBinding<wasm::LocalSet>("elseCache");
  wasm::LocalGet const *const elseFirstUse = elseCtx.getBinding<wasm::LocalGet>("elseFirstUse");
  wasm::LocalGet const *const elseSecondUse = elseCtx.getBinding<wasm::LocalGet>("elseSecondUse");
  ASSERT_NE(elseCache, nullptr);
  ASSERT_NE(elseFirstUse, nullptr);
  ASSERT_NE(elseSecondUse, nullptr);
  EXPECT_EQ(elseFirstUse->index, elseCache->index);
  EXPECT_EQ(elseSecondUse->index, elseCache->index);

  // Each branch has its own independent cache local
  EXPECT_NE(thenCache->index, elseCache->index);
}

TEST(ClosureLower, OptLowerCachesSingleMaxLevelWhenCountExceedsOne) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 0);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // level=2, count=3, maxLevel=2 → count>1 triggers caching.
  // Cache is built from heapIdx(level0) with two loads: i32.load(i32.load(local.get $0))
  matcher::M<wasm::Expression> const match = isBlock({
      block::at(0, isGlobalSet()),
      block::at(1, isDrop(drop::v(isBlock({
                       block::has(2),
                       block::at(0, isLocalSet(local_set::v(isLoad(
                                                   load::ptr(isLoad(load::ptr(isLocalGet(local_get::index(0))))))))
                                        .bind("level2Cache")),
                       block::at(1, isLocalGet().bind("firstUse")),
                   })))),
      block::at(2, isDrop(drop::v(isLocalGet().bind("secondUse")))),
      block::at(3, isLocalGet().bind("thirdUse")),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level2Cache = ctx.getBinding<wasm::LocalSet>("level2Cache");
  wasm::LocalGet const *const firstUse = ctx.getBinding<wasm::LocalGet>("firstUse");
  wasm::LocalGet const *const secondUse = ctx.getBinding<wasm::LocalGet>("secondUse");
  wasm::LocalGet const *const thirdUse = ctx.getBinding<wasm::LocalGet>("thirdUse");
  ASSERT_NE(level2Cache, nullptr);
  ASSERT_NE(firstUse, nullptr);
  ASSERT_NE(secondUse, nullptr);
  ASSERT_NE(thirdUse, nullptr);
  EXPECT_EQ(firstUse->index, level2Cache->index);
  EXPECT_EQ(secondUse->index, level2Cache->index);
  EXPECT_EQ(thirdUse->index, level2Cache->index);
}

TEST(ClosureLower, OptLowerHoistsPastIntermediateDomWithoutClosureCalls) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32 i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 3)))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 3)))
        (if (local.get 0)
          (then
            (if (local.get 1)
              (then
                (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
                (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
              )
            )
          )
        )
        (i32.const 0)
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 2);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // Level 1 should be hoisted past the intermediate dom node (outer then-block
  // with no closure calls) all the way to the entry block where level 3 lives.
  // Level 3 cache chains from level 1 cache.
  matcher::M<wasm::Expression> const match = isBlock({
      block::at(0, isGlobalSet()),
      block::at(1, isDrop(drop::v(isBlock({
                       block::has(3),
                       block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(2))))))
                                        .bind("level1Cache")),
                       block::at(1, isLocalSet(local_set::v(isLoad(
                                                   load::ptr(isLoad(load::ptr(isLocalGet().bind("level3From")))))))
                                        .bind("level3Cache")),
                       block::at(2, isLocalGet().bind("firstL3Use")),
                   })))),
      block::at(2, isDrop(drop::v(isLocalGet().bind("secondL3Use")))),
      block::at(3, isIf().bind("outerIf")),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  wasm::LocalGet const *const level3From = ctx.getBinding<wasm::LocalGet>("level3From");
  wasm::LocalSet const *const level3Cache = ctx.getBinding<wasm::LocalSet>("level3Cache");
  wasm::LocalGet const *const firstL3Use = ctx.getBinding<wasm::LocalGet>("firstL3Use");
  wasm::LocalGet const *const secondL3Use = ctx.getBinding<wasm::LocalGet>("secondL3Use");
  wasm::If const *const outerIf = ctx.getBinding<wasm::If>("outerIf");
  ASSERT_NE(level1Cache, nullptr);
  ASSERT_NE(level3From, nullptr);
  ASSERT_NE(level3Cache, nullptr);
  ASSERT_NE(firstL3Use, nullptr);
  ASSERT_NE(secondL3Use, nullptr);
  ASSERT_NE(outerIf, nullptr);
  EXPECT_EQ(level3From->index, level1Cache->index);
  EXPECT_EQ(firstL3Use->index, level3Cache->index);
  EXPECT_EQ(secondL3Use->index, level3Cache->index);

  // Outer if then-block has no closure calls — it's just the inner if.
  ASSERT_TRUE(outerIf->ifTrue->is<wasm::If>());
  wasm::If const *const innerIf = outerIf->ifTrue->cast<wasm::If>();

  // Inner then uses level 1 cache from the entry block (hoisted past the intermediate dom).
  matcher::M<wasm::Expression> const innerThenMatch = isBlock({
      block::at(0, isDrop(drop::v(isLocalGet().bind("firstL1Use")))),
      block::at(1, isDrop(drop::v(isLocalGet().bind("secondL1Use")))),
  });
  isMatched(innerThenMatch, innerIf->ifTrue);

  matcher::Context innerCtx{};
  ASSERT_TRUE(innerThenMatch(*innerIf->ifTrue, innerCtx));

  wasm::LocalGet const *const firstL1Use = innerCtx.getBinding<wasm::LocalGet>("firstL1Use");
  wasm::LocalGet const *const secondL1Use = innerCtx.getBinding<wasm::LocalGet>("secondL1Use");
  ASSERT_NE(firstL1Use, nullptr);
  ASSERT_NE(secondL1Use, nullptr);
  EXPECT_EQ(firstL1Use->index, level1Cache->index);
  EXPECT_EQ(secondL1Use->index, level1Cache->index);
}

TEST(ClosureLower, OptLowerHoistsOutOfLoop) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (block $break
          (loop $loop
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
            (br_if $break (local.get 0))
            (br $loop)
          )
        )
        (i32.const 0)
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // The local.set for level 1 should be hoisted to the entry block (before the loop),
  // and inside the loop the getClosureEnvByLevel should use local.get of the cached local.
  matcher::M<wasm::Expression> const match = isBlock({
      block::at(
          0,
          isBlock({
              block::at(0, isGlobalSet()),
              block::at(1, isBlock({
                               block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(1))))))
                                                .bind("level1Cache")),
                               block::has(1),
                           })),
              block::has(2),
          })),
      block::has(3),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  ASSERT_NE(level1Cache, nullptr);
}

TEST(ClosureLower, OptLowerHoistsOutOfNestedLoop) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32 i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (block $outerBreak
          (loop $outerLoop
            (block $innerBreak
              (loop $innerLoop
                (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
                (br_if $innerBreak (local.get 1))
                (br $innerLoop)
              )
            )
            (br_if $outerBreak (local.get 0))
            (br $outerLoop)
          )
        )
        (i32.const 0)
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 2);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // The local.set for level 1 should be hoisted past both loops to the entry block.
  matcher::M<wasm::Expression> const match = isBlock({
      block::at(
          0,
          isBlock({
              block::at(0, isGlobalSet()),
              block::at(1, isBlock({
                               block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(2))))))
                                                .bind("level1Cache")),
                               block::has(1),
                           })),
              block::has(2),
          })),
      block::has(3),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  ASSERT_NE(level1Cache, nullptr);
}

TEST(ClosureLower, OptLowerSkipsHoistWhenLoopBlockExits) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (block $break
          (loop $loop
            (if (local.get 0)
              (then
                (return (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
              )
            )
            (br $loop)
          )
        )
        (i32.const 0)
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // The getClosureEnvByLevel is in a block that exits the loop (return),
  // so it should NOT be hoisted. It should be lowered in place with i32.load.
  // No local.set should appear before the loop.
  matcher::M<wasm::Expression> const match = isBlock({
      block::at(0, isGlobalSet()),
      block::has(3),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));
}

TEST(ClosureLower, OptLowerHoistsLoopDefToBlockWithClosureCall) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (global $~lib/rt/closure/env (mut i32) (i32.const 0))
      (memory 1)
      (func $levelGetter (param i32) (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 2)))
        (block $break
          (loop $loop
            (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
            (br_if $break (local.get 0))
            (br $loop)
          )
        )
        (i32.const 0)
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::OptLower(&variableInfo)});
  runner.run();

  using namespace matcher;
  wasm::Function *const levelGetter = m->getFunctionOrNull("levelGetter");
  ASSERT_NE(levelGetter, nullptr);

  // Entry block has getClosureEnvByLevel(2) — single use of max level, so level 2 is NOT cached.
  // Level 1 is cached (intermediate level used by both entry and loop).
  // The drop block: { local.set $cached1 (load heapIdx), i32.load($cached1) }
  matcher::M<wasm::Expression> const match = isBlock({
      block::at(0, isGlobalSet()),
      block::at(1, isDrop(drop::v(isBlock({
                       block::has(2),
                       block::at(0, isLocalSet(local_set::v(isLoad(load::ptr(isLocalGet(local_get::index(1))))))
                                        .bind("level1Cache")),
                       block::at(1, isLoad(load::ptr(isLocalGet().bind("level2From")))),
                   })))),
  });
  isMatched(match, levelGetter->body);

  matcher::Context ctx{};
  ASSERT_TRUE(match(*levelGetter->body, ctx));

  wasm::LocalSet const *const level1Cache = ctx.getBinding<wasm::LocalSet>("level1Cache");
  wasm::LocalGet const *const level2From = ctx.getBinding<wasm::LocalGet>("level2From");
  ASSERT_NE(level1Cache, nullptr);
  ASSERT_NE(level2From, nullptr);
  EXPECT_EQ(level2From->index, level1Cache->index);
}

} // namespace
} // namespace warpo::passes::ut

#endif