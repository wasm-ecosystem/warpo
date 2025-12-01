// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

// AS specific optimizations for instructions simplification.
// Base on following assumptions:
//  - linear memory addresses are always valid.
//    - load opcode itself is no side effect.

#include <ir/effects.h>
#include <memory>
#include <pass.h>
#include <wasm-builder.h>
#include <wasm-traversal.h>
#include <wasm.h>

#include "InstrSimplifier.hpp"

struct InstrSimplifier : public wasm::WalkerPass<wasm::PostWalker<InstrSimplifier>> {
  void visitDrop(wasm::Drop *curr) {
    // (drop (load ...))
    if (wasm::Load *const load = curr->value->dynCast<wasm::Load>(); load != nullptr) {
      wasm::EffectAnalyzer::SideEffects const sideEffects = getSideEffects(load->ptr);
      wasm::Builder builder{*getModule()};
      if (sideEffects == wasm::EffectAnalyzer::SideEffects::None) {
        // load ptr has no side effects, we can remove the drop entirely
        replaceCurrent(builder.makeNop());
      } else {
        // load ptr has side effects, we can drop ptr directly
        curr->value = load->ptr;
      }
    }
  }

private:
  wasm::EffectAnalyzer::SideEffects getSideEffects(wasm::Expression *expr) {
    return static_cast<wasm::EffectAnalyzer::SideEffects>(
        wasm::EffectAnalyzer{getPassOptions(), *getModule(), expr}.getSideEffects());
  }
};

wasm::Pass *warpo::passes::createInstrSimplifier() { return new InstrSimplifier(); }

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "helper/Matcher.hpp"
#include "pass.h"

namespace warpo::passes::ut {

TEST(InstrSimplifierTest, DropLoadWithoutSideEffects) {
  auto m = loadWat(R"(
    (module
      (memory 1)
      (func $simplifier
        (drop (i32.load offset=0 (i32.const 4)))
      )
    )
  )");
  wasm::Function *const f = m->getFunction("simplifier");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{warpo::passes::createInstrSimplifier()});
  runner.run();

  using namespace matcher;
  auto const match = isNop();
  isMatched(match, f->body);
}

TEST(InstrSimplifierTest, DropLoadWithSideEffects) {
  auto m = loadWat(R"(
    (module
      (memory 1)
      (func $simplifier
        (local i32)
        (drop (i32.load offset=0 (local.tee 0 (i32.const 4))))
      )
    )
  )");
  wasm::Function *const f = m->getFunction("simplifier");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{warpo::passes::createInstrSimplifier()});
  runner.run();

  using namespace matcher;
  auto const match = isDrop(drop::v(isLocalSet(local_set::tee())));
  isMatched(match, f->body);
}

} // namespace warpo::passes::ut

#endif
