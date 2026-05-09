// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <unordered_map>
#include <unordered_set>

#include "CollectLeafFunction.hpp"
#include "GCInfo.hpp"
#include "fmt/base.h"
#include "support/name.h"
#include "warpo/support/Debug.hpp"
#include "wasm.h"

#define PASS_NAME "GCCollectLeafFunction"

namespace warpo::passes::gc {

static LeafFunc collectLeafFunctions(const CallGraph &cg) {
  LeafFunc leaf{};
  std::unordered_map<wasm::Name, std::unordered_set<wasm::Name>> reservedCallGraph{};

  for (auto const &[caller, callees] : cg) {
    leaf.insert(caller);
    for (wasm::Name const &callee : callees) {
      reservedCallGraph.try_emplace(callee, std::unordered_set<wasm::Name>{}).first->second.insert(caller);
    }
  }
  std::unordered_set<wasm::Name> workList{FnITCMSNew, FnITCMSCollect, FnTCMSNew, FnTCMSCollect};
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
  static_cast<void>(m);
  *result_ = collectLeafFunctions(*cg_);
  if (support::isDebug(PASS_NAME)) {
    for (wasm::Name const &name : *result_) {
      if (support::isDebug(PASS_NAME, name.view()))
        fmt::println("[" PASS_NAME "] leaf function: '{}'", name.view());
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
  CG[FnITCMSNew] = {};
  CG["leaf"] = {};
  CG["parent_1"] = {"leaf"};
  CG["parent_poison"] = {"leaf", FnITCMSNew};

  LeafFunc const leaf = collectLeafFunctions(CG);

  EXPECT_THAT(leaf, Contains("leaf"));
  EXPECT_THAT(leaf, Contains("parent_1"));

  EXPECT_THAT(leaf, Not(Contains("poison")));
  EXPECT_THAT(leaf, Not(Contains("parent_poison")));
}

} // namespace warpo::passes::ut

#endif
