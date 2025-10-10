// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <set>

#include "BuildCallGraph.hpp"
#include "support/name.h"
#include "wasm.h"

#define DEBUG_PREFIX "[CallGraph] "

namespace warpo::passes {

CallGraph CallGraphBuilder::createResults(wasm::Module &m) {
  CallGraph ret{};
  for (std::unique_ptr<wasm::Function> const &f : m.functions) {
    // we treat imported function as leaf function because in wasm-compiler, nest wasm call is not allowed.
    ret.insert_or_assign(f->name, std::set<wasm::Name>{});
  }
  return ret;
}

void CallGraphBuilder::visitCall(wasm::Call *expr) { cg_.at(getFunction()->name).insert(expr->target); }

void CallGraphBuilder::visitCallIndirect(wasm::CallIndirect *expr) {
  wasm::Module *m = getModule();
  std::set<wasm::Name> &call = cg_.at(getFunction()->name);
  std::vector<wasm::Expression *> const &potentialTargets = m->getElementSegment(expr->table)->data;
  for (wasm::Expression *target : potentialTargets) {
    wasm::Name const refFunc = target->cast<wasm::RefFunc>()->func;
    if (expr->heapType.getSignature() == m->getFunction(refFunc)->getSig())
      call.insert(refFunc);
  }
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "../Runner.hpp"

namespace warpo::passes::ut {

using ::testing::Contains;

TEST(BuildCallGraph, Base) {
  auto m = loadWat(R"(
      (module
        (type $v_v (func))
        (type $i_v (func (param i32)))
        (table $0 2 2 funcref)
        (elem $0 (i32.const 1) $leaf $leaf_i32)
        (func $leaf)
        (func $leaf_i32 (param i32))
        (func $call_leaf (param i32)
          (call $leaf)
        )
        (func $call_leaf_twice (param i32)
          (call $leaf)
          (call $leaf)
        )
        (func $call_indirect_v (param i32)
          (call_indirect (type $v_v) (i32.const 0))
        )
        (func $call_indirect_i (param i32)
          (call_indirect (type $i_v) (i32.const 0) (i32.const 1))
        )
      )
    )");

  auto CG = CallGraphBuilder::createResults(*m);
  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new CallGraphBuilder(CG)});
  runner.run();

  EXPECT_TRUE(CG.at("leaf").empty());

  EXPECT_EQ(CG.at("call_leaf").size(), 1);
  EXPECT_THAT(CG.at("call_leaf"), Contains("leaf"));

  EXPECT_EQ(CG.at("call_leaf_twice").size(), 1);
  EXPECT_THAT(CG.at("call_leaf_twice"), Contains("leaf"));

  EXPECT_EQ(CG.at("call_indirect_v").size(), 1);
  EXPECT_THAT(CG.at("call_indirect_v"), Contains("leaf"));

  EXPECT_EQ(CG.at("call_indirect_i").size(), 1);
  EXPECT_THAT(CG.at("call_indirect_i"), Contains("leaf_i32"));
}

} // namespace warpo::passes::ut

#endif
