/// @brief There are some function

#include "CollectGCLeafFunction.hpp"
#include "fmt/base.h"
#include "support/Container.hpp"
#include "support/Debug.hpp"
#include "wasm.h"

#define DEBUG_PREFIX "[GCLeafFunction] "

namespace warpo::passes::as_gc {

void CallCollector::visitCall(wasm::Call *expr) { cg_.at(getFunction()->name).insert(expr->target); }

void CallCollector::visitCallIndirect(wasm::CallIndirect *expr) {
  wasm::Module *m = getModule();
  std::set<wasm::Name> &call = cg_.at(getFunction()->name);
  std::vector<wasm::Expression *> const &potentialTargets = m->getElementSegment(expr->table)->data;
  for (wasm::Expression *target : potentialTargets) {
    wasm::Name refFunc = target->cast<wasm::RefFunc>()->func;
    if (expr->heapType.getSignature() == m->getFunction(refFunc)->getSig())
      call.insert(refFunc);
  }
}

static std::set<wasm::Name> collectLeafFunctions(const CallGraph &cg, std::set<wasm::Name> const &taint) {
  std::set<wasm::Name> leaf{};
  bool changed = true;
  while (changed) {
    changed = false;
    for (auto const &[caller, callees] : cg) {
      if (taint.contains(caller))
        continue;
      // to handle recursive call
      // we put the current function into leaf and calculate subset.
      // if the current function is not a leaf, roll back.
      std::set<wasm::Name>::iterator it{};
      bool isChange;
      std::tie(it, isChange) = leaf.insert(caller);
      if (!isChange)
        continue;
      if (subset(leaf, callees)) {
        changed = true;
      } else {
        leaf.erase(it);
      }
    }
  }

  return leaf;
}

void LeafFunctionCollector::run(wasm::Module *m) {
  results_ = collectLeafFunctions(cg_, taint_);
  if (support::isDebug()) {
    for (wasm::Name const &name : results_)
      fmt::println(DEBUG_PREFIX "leaf function: '{}'", name.str);
  }
}

} // namespace warpo::passes::as_gc

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "Runner.hpp"

namespace warpo::passes::ut {

using namespace as_gc;
using ::testing::Contains;
using ::testing::Not;

TEST(GCLeafFunctionTest, BuildCallGraph) {
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

  auto CG = CallCollector::createCallGraph(*m);
  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new CallCollector(CG)});
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

TEST(GCLeafFunctionTest, LeafFunction) {
  CallGraph CG{};
  CG["leaf"] = {};
  CG["parent_1"] = {"leaf"};
  CG["recursive"] = {"recursive"};
  CG["bad_1"] = {"imported"};
  CG["bad_recursive"] = {"bad_recursive", "bad_1"};

  std::set<wasm::Name> leaf = collectLeafFunctions(CG, {});

  EXPECT_THAT(leaf, Contains("leaf"));
  EXPECT_THAT(leaf, Contains("parent_1"));
  EXPECT_THAT(leaf, Contains("recursive"));

  EXPECT_THAT(leaf, Not(Contains("bad_1")));
  EXPECT_THAT(leaf, Not(Contains("bad_recursive")));
}

TEST(GCLeafFunctionTest, LeafFunctionTaint) {
  CallGraph CG{};
  CG["poison"] = {};
  CG["leaf"] = {};
  CG["parent_1"] = {"leaf"};
  CG["parent_poison"] = {"leaf", "poison"};

  std::set<wasm::Name> leaf = collectLeafFunctions(CG, {"poison"});

  EXPECT_THAT(leaf, Contains("leaf"));
  EXPECT_THAT(leaf, Contains("parent_1"));

  EXPECT_THAT(leaf, Not(Contains("poison")));
  EXPECT_THAT(leaf, Not(Contains("parent_poison")));
}

} // namespace warpo::passes::ut

#endif
