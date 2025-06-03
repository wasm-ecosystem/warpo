#include <set>

#include "CollectLeafFunction.hpp"
#include "GCInfo.hpp"
#include "fmt/base.h"
#include "support/Debug.hpp"
#include "support/name.h"
#include "wasm.h"

#define PASS_NAME "GCLeafFunction"
#define DEBUG_PREFIX "[GCLeafFunction] "

namespace warpo::passes::gc {

static LeafFunc collectLeafFunctions(const CallGraph &cg) {
  LeafFunc leaf{};
  std::map<wasm::Name, std::set<wasm::Name>> reservedCallGraph{};

  for (auto const &[caller, callees] : cg) {
    leaf.insert(caller);
    for (wasm::Name const &callee : callees) {
      reservedCallGraph.try_emplace(callee, std::set<wasm::Name>{}).first->second.insert(caller);
    }
  }
  std::set<wasm::Name> workList{FnNew, FnCollect};
  while (!workList.empty()) {
    auto it = workList.begin();
    if (leaf.erase(*it) == 1) {
      auto const reservedCallGraphIt = reservedCallGraph.find(*it);
      if (reservedCallGraphIt != reservedCallGraph.end()) {
        workList.insert(reservedCallGraphIt->second.begin(), reservedCallGraphIt->second.end());
      }
    }
    workList.erase(it);
  }
  return leaf;
}

void LeafFunctionCollector::run(wasm::Module *m) {
  result_ = collectLeafFunctions(cg_);
  if (support::isDebug(PASS_NAME)) {
    for (wasm::Name const &name : result_) {
      if (support::isDebug(PASS_NAME, name.str))
        fmt::println(DEBUG_PREFIX "leaf function: '{}'", name.str);
    }
  }
}

} // namespace warpo::passes::gc

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

namespace warpo::passes::ut {

using namespace gc;
using ::testing::Contains;
using ::testing::Not;

TEST(GCLeafFunctionTest, LeafFunction) {
  CallGraph CG{};
  CG[FnNew] = {};
  CG["leaf"] = {};
  CG["parent_1"] = {"leaf"};
  CG["parent_poison"] = {"leaf", FnNew};

  std::set<wasm::Name> leaf = collectLeafFunctions(CG);

  EXPECT_THAT(leaf, Contains("leaf"));
  EXPECT_THAT(leaf, Contains("parent_1"));

  EXPECT_THAT(leaf, Not(Contains("poison")));
  EXPECT_THAT(leaf, Not(Contains("parent_poison")));
}

} // namespace warpo::passes::ut

#endif
