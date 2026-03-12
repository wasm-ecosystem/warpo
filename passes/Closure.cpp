// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <array>
#include <atomic>
#include <cassert>
#include <optional>
#include <string>

#include "Closure.hpp"
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
      assert(!(wasm::EffectAnalyzer(getPassOptions(), *getModule(), load->ptr).getSideEffects() & kForbiddenEffects) &&
             "address of i32.load must not write locals/globals/memory, call, or branch");
      wasm::Builder b{*getModule()};
      replaceCurrent(b.makeNop());
    }
  }

private:
  wasm::Name setClosureEnvName;
};

template <typename Derived> class ClosureEnvLowerBase : public wasm::WalkerPass<wasm::PostWalker<Derived>> {
  using Super = wasm::WalkerPass<wasm::PostWalker<Derived>>;

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
    VariableInfo::SubProgramLookupMap const &lookupMap = this->variableInfo->getSubProgramLookupMap();
    auto const it = lookupMap.find(this->getFunction()->name.str);
    assert(it != lookupMap.end() && "function not found in SubProgramLookupMap");
    std::optional<uint32_t> heapIdx = it->second.getHeapVariableStorageLocalIndex();
    assert(heapIdx.has_value() && "function has no heapVariableStorageLocalIndex");

    wasm::Name const memoryName = this->getModule()->memories.front()->name;
    wasm::Store *const storeExpr =
        b.makeStore(4, 0, 4, b.makeLocalGet(*heapIdx, wasm::Type::i32), curr->operands[0], wasm::Type::i32, memoryName);
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

  VariableInfo::SubProgramLookupMap const &lookupMap = variableInfo->getSubProgramLookupMap();
  VariableInfo::SubProgramLookupMap::const_iterator const it = lookupMap.find(func->name.str);
  assert(it != lookupMap.end() && "function not found in SubProgramLookupMap");
  std::optional<uint32_t> heapIdx = it->second.getHeapVariableStorageLocalIndex();
  assert(heapIdx.has_value() && "function has no heapVariableStorageLocalIndex");

  wasm::Name const memoryName = module->memories.front()->name;
  wasm::Expression *addr = b.makeLocalGet(*heapIdx, wasm::Type::i32);
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

class OptClosureEnvLower : public ClosureEnvLowerBase<OptClosureEnvLower> {
public:
  using ClosureEnvLowerBase::ClosureEnvLowerBase;

  wasm::Expression *lowerGetClosureEnvByLevel(wasm::Call *const curr) {
    // TODO: implement optimized lowering
    return fastLowerGetClosureEnvByLevel(curr, this->getModule(), this->getFunction(), this->variableInfo);
  }
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

void OptLower::run(wasm::Module *m) { runClosureLower<OptClosureEnvLower>(getPassRunner(), m, variableInfo_); }

} // namespace warpo::passes::closure

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
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
  EXPECT_EQ(store->offset, 0u);
  EXPECT_TRUE(store->ptr->is<wasm::LocalGet>());
  EXPECT_EQ(store->ptr->cast<wasm::LocalGet>()->index, 1u);
  EXPECT_TRUE(store->value->is<wasm::LocalGet>());
  EXPECT_EQ(store->value->cast<wasm::LocalGet>()->index, 0u);
}

} // namespace
} // namespace warpo::passes::ut

#endif