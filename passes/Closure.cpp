// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <array>
#include <atomic>
#include <cassert>
#include <string>

#include "Closure.hpp"
#include "ir/effects.h"
#include "warpo/support/Opt.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"
namespace warpo::passes {

static constexpr const char *const kGetClosureEnv = "~lib/rt/closure/getClosureEnv";
static constexpr const char *const kSetClosureEnv = "~lib/rt/closure/setClosureEnv";
static constexpr const char *const kGetClosureEnvByLevel = "~lib/rt/closure/getClosureEnvByLevel";

static std::array<const char *const, 3> kClosureImportBases = {
    kGetClosureEnv,
    kSetClosureEnv,
    kGetClosureEnvByLevel,
};

namespace {

class ClosureCallScanner : public wasm::WalkerPass<wasm::PostWalker<ClosureCallScanner>> {
public:
  ClosureCallScanner(std::atomic<bool> &hasGet, std::atomic<bool> &hasSet) : hasGet(hasGet), hasSet(hasSet) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<ClosureCallScanner>(hasGet, hasSet); }

  void visitCall(wasm::Call *curr) {
    if ((curr->target == kGetClosureEnv) || (curr->target == kGetClosureEnvByLevel))
      hasGet.store(true, std::memory_order_relaxed);
    else if (curr->target == kSetClosureEnv)
      hasSet.store(true, std::memory_order_relaxed);
  }

private:
  std::atomic<bool> &hasGet;
  std::atomic<bool> &hasSet;
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

} // namespace

void ClosureLower::run(wasm::Module *m) {
  // Phase 1: Scan which closure functions are actually called
  std::atomic<bool> hasGet{false};
  std::atomic<bool> hasSet{false};
  {
    wasm::PassRunner runner{getPassRunner()};
    runner.add(std::make_unique<ClosureCallScanner>(hasGet, hasSet));
    runner.run();
  }

  // Phase 2: If setClosureEnv is used but no get functions are, remove setClosureEnv call sites
  if (!hasGet && hasSet) {
    wasm::PassRunner runner{getPassRunner()};
    runner.add(std::make_unique<SetClosureEnvRemover>(kSetClosureEnv));
    runner.run();
    // Always remove the 3 import functions
    for (auto const &name : kClosureImportBases)
      m->removeFunction(name);
  }
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "pass.h"

namespace warpo::passes::ut {
namespace {

TEST(ClosureLower, SetOnlyRemovesCallsAndFunctions) {
  auto m = loadWat(R"(
    (module
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (param i32) (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32 i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32 i32) (result i32)))
      (func $caller
        (call $~lib/rt/closure/setClosureEnv (i32.const 1) (i32.const 2))
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new ClosureLower(nullptr)});
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
      (import "env" "~lib/rt/closure/getClosureEnv" (func $~lib/rt/closure/getClosureEnv (param i32) (result i32)))
      (import "env" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32 i32)))
      (import "env" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32 i32) (result i32)))
      (func $caller
        nop
      )
    )
  )");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new ClosureLower(nullptr)});
  runner.run();

  EXPECT_NE(m->getFunctionOrNull("~lib/rt/closure/getClosureEnv"), nullptr);
  EXPECT_NE(m->getFunctionOrNull("~lib/rt/closure/setClosureEnv"), nullptr);
  EXPECT_NE(m->getFunctionOrNull("~lib/rt/closure/getClosureEnvByLevel"), nullptr);
}

} // namespace
} // namespace warpo::passes::ut

#endif