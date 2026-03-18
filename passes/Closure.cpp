// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <array>
#include <atomic>
#include <cassert>
#include <map>
#include <memory>
#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

#include "Closure.hpp"
#include "helper/CFG.hpp"
#include "helper/ExprInserter.hpp"
#include "ir/effects.h"
#include "warpo/support/Opt.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"
namespace warpo::passes::closure {

static constexpr const char *const kGetClosureEnv = "~lib/rt/closure/getClosureEnv";
static constexpr const char *const kSetClosureEnv = "~lib/rt/closure/setClosureEnv";
static constexpr const char *const kGetClosureEnvByLevel = "~lib/rt/closure/getClosureEnvByLevel";

static constexpr const char *const kSetFFIClosureEnv = "~lib/builtins/ffi.set_ffi_closure_env";

static constexpr const char *const kClosureEnvGlobal = "~lib/rt/closure/env";

static std::array<const char *const, 3> kClosureImportBases = {
    kGetClosureEnv,
    kSetClosureEnv,
    kGetClosureEnvByLevel,
};

namespace {

class ClosureCallScanner : public wasm::WalkerPass<wasm::PostWalker<ClosureCallScanner>> {
public:
  ClosureCallScanner(std::atomic<bool> &hasGet, std::atomic<bool> &hasSet, std::atomic<bool> &hasFFISet)
      : hasGet(hasGet), hasSet(hasSet), hasFFISet(hasFFISet) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override {
    return std::make_unique<ClosureCallScanner>(hasGet, hasSet, hasFFISet);
  }

  void visitCall(wasm::Call *curr) {
    if ((curr->target == kGetClosureEnv) || (curr->target == kGetClosureEnvByLevel))
      hasGet.store(true, std::memory_order_relaxed);
    else if (curr->target == kSetClosureEnv)
      hasSet.store(true, std::memory_order_relaxed);
    else if (curr->target == kSetFFIClosureEnv)
      hasFFISet.store(true, std::memory_order_relaxed);
  }

private:
  std::atomic<bool> &hasGet;
  std::atomic<bool> &hasSet;
  std::atomic<bool> &hasFFISet;
};

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

wasm::Index getHeapLocalIndex(VariableInfo const *variableInfo, wasm::Function *func) {
  VariableInfo::SubProgramLookupMap const &lookupMap = variableInfo->getSubProgramLookupMap();
  VariableInfo::SubProgramLookupMap::const_iterator const it = lookupMap.find(func->name.str);
  assert(it != lookupMap.end() && "function not found in SubProgramLookupMap");
  std::optional<uint32_t> heapIdx = it->second.getHeapVariableStorageLocalIndex();
  assert(heapIdx.has_value() && "function has no heapVariableStorageLocalIndex");
  return *heapIdx;
}

template <typename Derived, typename VisitorType = wasm::Visitor<Derived>>
class ClosureEnvLowerBase : public wasm::WalkerPass<wasm::PostWalker<Derived, VisitorType>> {
  using Super = wasm::WalkerPass<wasm::PostWalker<Derived, VisitorType>>;

public:
  explicit ClosureEnvLowerBase(VariableInfo const *variableInfo) : variableInfo(variableInfo) {}

  void run(wasm::Module *module) override {
    wasm::Builder b{*module};
    module->addGlobal(
        wasm::Builder::makeGlobal(kClosureEnvGlobal, wasm::Type::i32, b.makeConst(0), wasm::Builder::Mutable));
    Super::run(module);
  }

  void visitCall(wasm::Call *const curr) {
    wasm::Builder b{*this->getModule()};
    if (curr->target == kGetClosureEnv) {
      this->replaceCurrent(b.makeGlobalGet(kClosureEnvGlobal, wasm::Type::i32));
    } else if (curr->target == kSetClosureEnv) {
      this->replaceCurrent(b.makeGlobalSet(kClosureEnvGlobal, curr->operands[0]));
    } else if (curr->target == kGetClosureEnvByLevel) {
      this->replaceCurrent(static_cast<Derived *>(this)->lowerGetClosureEnvByLevel(curr));
    } else if (curr->target == kSetFFIClosureEnv) {
      this->lowerSetFFIClosureEnv(curr);
    }
  }

  void lowerSetFFIClosureEnv(wasm::Call *const curr) {
    wasm::Builder b{*this->getModule()};
    wasm::Index const heapIdx = getHeapLocalIndex(variableInfo, this->getFunction());
    wasm::Name const memoryName = this->getModule()->memories.front()->name;
    wasm::Store *const storeExpr =
        b.makeStore(4, 0, 4, b.makeLocalGet(heapIdx, wasm::Type::i32), curr->operands[0], wasm::Type::i32, memoryName);
    this->replaceCurrent(storeExpr);
  }

protected:
  VariableInfo const *variableInfo;
};

wasm::Expression *fastLowerGetClosureEnvByLevel(wasm::Call *const curr, wasm::Module *module, wasm::Function *func,
                                                VariableInfo const *variableInfo) {
  wasm::Builder b{*module};
  wasm::Const const *const levelConst = curr->operands[0]->dynCast<wasm::Const>();
  assert(levelConst && "getClosureEnvByLevel parameter must be i32.const");
  int32_t const level = levelConst->value.geti32();

  wasm::Index const heapIdx = getHeapLocalIndex(variableInfo, func);
  wasm::Name const memoryName = module->memories.front()->name;
  wasm::Expression *addr = b.makeLocalGet(heapIdx, wasm::Type::i32);
  for (int32_t i = 0; i < level; ++i)
    addr = b.makeLoad(4, false, 0, 4, addr, wasm::Type::i32, memoryName);
  return addr;
}

class FastClosureEnvLower : public ClosureEnvLowerBase<FastClosureEnvLower> {
public:
  using ClosureEnvLowerBase::ClosureEnvLowerBase;

  wasm::Expression *lowerGetClosureEnvByLevel(wasm::Call *const curr) {
    return fastLowerGetClosureEnvByLevel(curr, this->getModule(), this->getFunction(), this->variableInfo);
  }
};

class ClosureEnvDefMap final {

public:
  explicit ClosureEnvDefMap(wasm::Function *func) noexcept : func_(func) {}

  // Allocates a new i32 local and records (level -> localIndex) in the sorted list for the given block.
  // Returns the allocated local index, or nullopt if the level is already defined.
  std::optional<wasm::Index> addDef(BasicBlock const *const block, int32_t const level) {
    std::vector<LevelDef> &list = map_[block];
    std::vector<LevelDef>::iterator const it = std::lower_bound(
        list.begin(), list.end(), level, [](LevelDef const &def, int32_t val) { return def.level < val; });
    if (it != list.end() && it->level == level)
      return std::nullopt;
    wasm::Index const localIdx = wasm::Builder::addVar(func_, wasm::Type::i32);
    list.insert(it, {level, localIdx});
    return localIdx;
  }

  // Returns the closest def with level <= the given level in the given block, or nullopt if none.
  std::optional<LevelDef> getClosestDef(BasicBlock const *const block, int32_t const level) const noexcept {
    std::unordered_map<BasicBlock const *, std::vector<LevelDef>>::const_iterator const mapIt = map_.find(block);
    if (mapIt == map_.end())
      return std::nullopt;
    std::vector<LevelDef> const &list = mapIt->second;
    std::vector<LevelDef>::const_iterator const it = std::upper_bound(
        list.begin(), list.end(), level, [](int32_t val, LevelDef const &def) { return val < def.level; });
    if (it == list.begin())
      return std::nullopt;
    return *std::prev(it);
  }

  void getInsertions(VariableInfo const *variableInfo,
                     std::unordered_map<wasm::Expression *, std::vector<CacheLevelInLocalAction>> &insertions) const {
    wasm::Index const heapIdx = getHeapLocalIndex(variableInfo, func_);
    LevelDef const level0{0, heapIdx};
    for (std::pair<BasicBlock const *const, std::vector<LevelDef>> const &pair : map_) {
      BasicBlock const *const block = pair.first;
      std::vector<LevelDef> const &defs = pair.second;
      if (defs.empty())
        continue;
      wasm::Expression *anchor = nullptr;
      for (wasm::Expression *const expr : *block) {
        wasm::Call const *const call = expr->dynCast<wasm::Call>();
        if (call != nullptr && call->target == kGetClosureEnvByLevel) {
          anchor = expr;
          break;
        }
      }
      assert(anchor != nullptr && "no getClosureEnvByLevel found in BasicBlock");
      for (LevelDef const &def : defs) {
        assert(def.level > 0 && "cached closure levels must be greater than zero");
        std::optional<LevelDef> const fromLevel = getClosestDef(block, def.level - 1);
        insertions[anchor].push_back({fromLevel.value_or(level0), def});
      }
    }
  }

private:
  std::unordered_map<BasicBlock const *, std::vector<LevelDef>> map_;
  wasm::Function *func_;
};

class OptClosureEnvAnalyzer final : public wasm::WalkerPass<wasm::PostWalker<OptClosureEnvAnalyzer>> {
public:
  using AnalysisResult = std::pair<CFG, ClosureEnvDefMap>;

  OptClosureEnvAnalyzer(VariableInfo const *variableInfo, std::vector<AnalysisResult> &funcResults,
                        std::unordered_map<wasm::Call *, LevelDef> &lowerAction) noexcept
      : variableInfo_(variableInfo), funcResults_(funcResults), lowerAction_(lowerAction) {}
  void doWalkFunction(wasm::Function *func) {
    CFG cfg = CFG::fromFunction(func);
    ClosureEnvDefMap defMap(func);
    wasm::Index const heapIdx = getHeapLocalIndex(variableInfo_, func);
    for (BasicBlock const &bb : cfg) {
      std::map<int32_t, int32_t> levelCounts;
      for (wasm::Expression *const expr : bb) {
        wasm::Call const *const call = expr->dynCast<wasm::Call>();
        if (call == nullptr || call->target != kGetClosureEnvByLevel)
          continue;
        wasm::Const const *const levelConst = call->operands[0]->dynCast<wasm::Const>();
        assert(levelConst != nullptr);
        int32_t const level = levelConst->value.geti32();
        if (level > 0) {
          ++levelCounts[level];
        }
      }
      if (levelCounts.empty())
        continue;
      int32_t const maxLevel = levelCounts.rbegin()->first;
      for (std::map<int32_t, int32_t>::const_iterator it = levelCounts.begin(); it != levelCounts.end(); ++it) {
        if (it->first < maxLevel || it->second > 1)
          defMap.addDef(&bb, it->first);
      }
    }

    for (BasicBlock const &bb : cfg) {
      for (wasm::Expression *const expr : bb) {
        wasm::Call *const call = expr->dynCast<wasm::Call>();
        if (call == nullptr || call->target != kGetClosureEnvByLevel)
          continue;
        wasm::Const const *const levelConst = call->operands[0]->dynCast<wasm::Const>();
        assert(levelConst != nullptr);
        int32_t const level = levelConst->value.geti32();
        std::optional<LevelDef> const def = defMap.getClosestDef(&bb, level);
        if (def.has_value()) {
          lowerAction_[call] = *def;
        } else {
          lowerAction_[call] = {0, heapIdx};
        }
      }
    }
    funcResults_.push_back({std::move(cfg), std::move(defMap)});
  }

private:
  VariableInfo const *variableInfo_;
  std::vector<AnalysisResult> &funcResults_;
  std::unordered_map<wasm::Call *, LevelDef> &lowerAction_;
};

class OptClosureEnvLower
    : public ClosureEnvLowerBase<OptClosureEnvLower, wasm::UnifiedExpressionVisitor<OptClosureEnvLower>> {
  using Base = ClosureEnvLowerBase<OptClosureEnvLower, wasm::UnifiedExpressionVisitor<OptClosureEnvLower>>;

public:
  using Base::ClosureEnvLowerBase;

  OptClosureEnvLower(VariableInfo const *variableInfo,
                     std::unordered_map<wasm::Expression *, std::vector<CacheLevelInLocalAction>> addDefMap,
                     std::unordered_map<wasm::Call *, LevelDef> &lowerAction)
      : Base(variableInfo), addDefMap_(addDefMap), lowerAction_(lowerAction) {}

  void visitCall(wasm::Call *const curr) {
    Base::visitCall(curr);
    auto const it = addDefMap_.find(curr);
    if (it != addDefMap_.end())
      wrapWithCache(it->second);
  }

  void visitExpression(wasm::Expression *const curr) {
    if (curr->is<wasm::Call>())
      return;
    auto const cacheIt = addDefMap_.find(curr);
    if (cacheIt != addDefMap_.end())
      wrapWithCache(cacheIt->second);
  }

  wasm::Expression *lowerGetClosureEnvByLevel(wasm::Call *const curr) {
    auto const actionIt = lowerAction_.find(curr);
    assert(actionIt != lowerAction_.end() && "call not found in lowerAction_");
    LevelDef const &action = actionIt->second;
    wasm::Const const *const levelConst = curr->operands[0]->dynCast<wasm::Const>();
    assert(levelConst && "getClosureEnvByLevel parameter must be i32.const");
    int32_t const neededLevel = levelConst->value.geti32();

    wasm::Module *module = this->getModule();

    wasm::Builder b{*module};

    wasm::Expression *addr = b.makeLocalGet(action.localIndex, wasm::Type::i32);

    wasm::Name const memoryName = module->memories.front()->name;
    for (int32_t i = action.level; i < neededLevel; ++i)
      addr = b.makeLoad(4, false, 0, 4, addr, wasm::Type::i32, memoryName);

    return addr;
  }

private:
  void wrapWithCache(std::vector<CacheLevelInLocalAction> const &actions) {
    wasm::Builder b{*this->getModule()};
    wasm::Name const memoryName = this->getModule()->memories.front()->name;
    wasm::Expression *const current = this->getCurrent();
    std::vector<wasm::Expression *> items;
    for (CacheLevelInLocalAction const &action : actions) {
      wasm::Expression *addr = b.makeLocalGet(action.fromLevel.localIndex, wasm::Type::i32);
      for (int32_t i = action.fromLevel.level; i < action.toLevel.level; ++i)
        addr = b.makeLoad(4, false, 0, 4, addr, wasm::Type::i32, memoryName);
      items.push_back(b.makeLocalSet(action.toLevel.localIndex, addr));
    }
    items.push_back(current);
    this->replaceCurrent(b.makeBlock(items, current->type));
  }

  std::unordered_map<wasm::Expression *, std::vector<CacheLevelInLocalAction>> addDefMap_;
  std::unordered_map<wasm::Call *, LevelDef> &lowerAction_;
};

template <typename ClosureEnvLowerT>
void runClosureLower(wasm::PassRunner *parentRunner, wasm::Module *m, VariableInfo const *variableInfo) {
  std::atomic<bool> hasGet{false};
  std::atomic<bool> hasSet{false};
  std::atomic<bool> hasFFISet{false};
  {
    wasm::PassRunner runner{parentRunner};
    runner.add(std::make_unique<ClosureCallScanner>(hasGet, hasSet, hasFFISet));
    runner.run();
  }

  wasm::PassRunner runner{parentRunner};
  if ((hasGet && hasSet) || hasFFISet) {
    runner.add(std::make_unique<ClosureEnvLowerT>(variableInfo));
  } else if (!hasGet && hasSet) {
    runner.add(std::make_unique<SetClosureEnvRemover>(kSetClosureEnv));
  }
  runner.run();
  for (const char *const name : kClosureImportBases)
    m->removeFunction(name);
  if (m->getFunctionOrNull(kSetFFIClosureEnv))
    m->removeFunction(kSetFFIClosureEnv);
}

} // namespace

void FastLower::run(wasm::Module *m) { runClosureLower<FastClosureEnvLower>(getPassRunner(), m, variableInfo_); }

void OptLower::run(wasm::Module *m) {
  std::vector<OptClosureEnvAnalyzer::AnalysisResult> funcResults;
  std::unordered_map<wasm::Expression *, std::vector<CacheLevelInLocalAction>> addDefMap;

  std::unordered_map<wasm::Call *, LevelDef> lowerAction;
  {
    wasm::PassRunner runner{getPassRunner()};
    runner.add(std::make_unique<OptClosureEnvAnalyzer>(variableInfo_, funcResults, lowerAction));
    runner.run();

    for (OptClosureEnvAnalyzer::AnalysisResult const &result : funcResults) {
      result.second.getInsertions(variableInfo_, addDefMap);
    }
  }

  wasm::PassRunner *parentRunner = getPassRunner();

  std::atomic<bool> hasGet{false};
  std::atomic<bool> hasSet{false};
  std::atomic<bool> hasFFISet{false};
  {
    wasm::PassRunner runner{parentRunner};
    runner.add(std::make_unique<ClosureCallScanner>(hasGet, hasSet, hasFFISet));
    runner.run();
  }

  wasm::PassRunner runner{parentRunner};
  if ((hasGet && hasSet) || hasFFISet) {
    runner.add(std::make_unique<OptClosureEnvLower>(variableInfo_, addDefMap, lowerAction));
  } else if (!hasGet && hasSet) {
    runner.add(std::make_unique<SetClosureEnvRemover>(kSetClosureEnv));
  }
  runner.run();
  for (const char *const name : kClosureImportBases)
    m->removeFunction(name);
  if (m->getFunctionOrNull(kSetFFIClosureEnv))
    m->removeFunction(kSetFFIClosureEnv);
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
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
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

  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/getClosureEnv"), nullptr);
  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/setClosureEnv"), nullptr);
  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/getClosureEnvByLevel"), nullptr);

  wasm::Function *const caller = m->getFunctionOrNull("caller");
  ASSERT_NE(caller, nullptr);
  EXPECT_TRUE(caller->body->is<wasm::Nop>());
}

TEST(ClosureLower, NoClosureCallsKeepsFunctions) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
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

  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/getClosureEnv"), nullptr);
  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/setClosureEnv"), nullptr);
  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/getClosureEnvByLevel"), nullptr);
}

TEST(ClosureLower, BothGetAndSetLowersToGlobalAndLocal) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (memory 1)
      (func $setter
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
      )
      (func $getter (result i32)
        (call $~lib/rt/closure/getClosureEnv)
      )
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 0))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "");
  variableInfo.addHeapVariableStorageLocalIndex("levelGetter", 0);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::FastLower(&variableInfo)});
  runner.run();

  EXPECT_EQ(m->getFunctionOrNull("~lib/rt/closure/getClosureEnv"), nullptr);
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
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
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
  variableInfo.addSubProgram("level1", "");
  variableInfo.addHeapVariableStorageLocalIndex("level1", 0);
  variableInfo.addSubProgram("level2", "");
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
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (import "as-builtin-fn" "set_ffi_closure_env" (func $~lib/builtins/ffi.set_ffi_closure_env (param i32)))
      (memory 1)
      (func $callback (param i32) (local i32)
        (call $~lib/builtins/ffi.set_ffi_closure_env (local.get 0))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("callback", "");
  variableInfo.addHeapVariableStorageLocalIndex("callback", 1);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new closure::FastLower(&variableInfo)});
  runner.run();

  EXPECT_EQ(m->getFunctionOrNull("~lib/builtins/ffi.set_ffi_closure_env"), nullptr);

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
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
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
  variableInfo.addSubProgram("levelGetter", "");
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
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (memory 1)
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "");
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
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (memory 1)
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1)))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 1))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "");
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

TEST(ClosureLower, OptLowerThreeLevelsChaining) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
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
  variableInfo.addSubProgram("levelGetter", "");
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
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
      (memory 1)
      (func $levelGetter (result i32) (local i32)
        (call $~lib/rt/closure/setClosureEnv (i32.const 42))
        (drop (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 0)))
        (call $~lib/rt/closure/getClosureEnvByLevel (i32.const 0))
      )
    )
  )");

  VariableInfo variableInfo;
  variableInfo.addSubProgram("levelGetter", "");
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

} // namespace
} // namespace warpo::passes::ut

#endif