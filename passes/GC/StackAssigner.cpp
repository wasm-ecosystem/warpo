// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <fmt/base.h>
#include <optional>
#include <unordered_map>
#include <utility>

#include "../helper/Matcher.hpp"
#include "../helper/ToString.hpp"
#include "GCInfo.hpp"
#include "Liveness.hpp"
#include "StackAssigner.hpp"
#include "warpo/support/Debug.hpp"
#include "warpo/support/Err.hpp"
#include "warpo/support/Range.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

#define PASS_NAME "GCStackAssigner"

namespace warpo::passes::gc {

uint32_t StackPosition::getFrameSize() const {
  auto const maxElement = std::max_element(begin(), end(), [](auto const &a, auto const &b) {
    return a.second < b.second;
  });
  return maxElement != end() ? maxElement->second + ShadowStackElementSize : 0U;
}

namespace {

struct IAssigner {
  virtual ~IAssigner() = default;
  virtual size_t getStackPosition(size_t ssaIndex) = 0;
};

struct GreedyAssigner final : public IAssigner {
  ColorVec const &color_;
  explicit GreedyAssigner(ColorVec const &color) : color_(color) {}
  size_t getStackPosition(size_t ssaIndex) override { return color_.getColor(ssaIndex) * ShadowStackElementSize; }
};

struct VanillaAssigner final : public IAssigner {
  std::unordered_map<size_t, size_t> map_;
  size_t getStackPosition(size_t ssaIndex) override {
    if (map_.contains(ssaIndex))
      return map_.at(ssaIndex) * ShadowStackElementSize;
    size_t const cnt = map_.size();
    map_.insert_or_assign(ssaIndex, cnt);
    return cnt * ShadowStackElementSize;
  }
};

struct Process : public wasm::PostWalker<Process, wasm::UnifiedExpressionVisitor<Process>> {
  wasm::Function const &func_;
  IAssigner &assigner_;
  LivenessMap const &livenessMap_;
  StackPosition &stackPosition_;
  Process(wasm::Function const &func, IAssigner &assigner, LivenessMap const &livenessMap, StackPosition &stackPosition)
      : func_(func), assigner_(assigner), livenessMap_(livenessMap), stackPosition_(stackPosition) {}

  Result<wasm::Call *> extractCall(wasm::Expression *expr, Liveness const &l) {
    if (auto set = expr->dynCast<wasm::LocalSet>()) {
      // localtostack
      if (!matcher::isCall(matcher::call::callee(FnLocalToStack))(*set->value)) {
        // some parameter will be treat as GC object by mistake.
        return failed();
      }
      return succeed(set->value->cast<wasm::Call>());
    }
    if (auto call = expr->dynCast<wasm::Call>()) {
      // tmptostack
      if (call->target != FnTmpToStack && call->target != FnLocalToStack) {
        fmt::println("in '{}', unknown {}: {} -> {}", func_.name.view(), toString(expr), l.before().toString(),
                     l.after().toString());
        std::abort();
      }
      return succeed(call);
    }
    fmt::println("in '{}', unknown {}: {} -> {}", func_.name.view(), toString(expr), l.before().toString(),
                 l.after().toString());
    std::abort();
  };

  void visitExpression(wasm::Expression *expr) {
    std::optional<Liveness> const currentLiveness = livenessMap_.getLiveness(expr);
    if (!currentLiveness.has_value())
      return;
    for (size_t const ssaIndex : Range{livenessMap_.getDimension()}) {
      if (!currentLiveness->before().get(ssaIndex) && currentLiveness->after().get(ssaIndex)) {
        Result<wasm::Call *> const callExpr = extractCall(expr, currentLiveness.value());
        if (callExpr.ok()) {
          assert(!stackPosition_.contains(callExpr.value()) && "call -> store is 1 - 1 mapping");
          stackPosition_.insert_or_assign(callExpr.value(), assigner_.getStackPosition(ssaIndex));
        }
      }
    }
  }
};

} // namespace

static void calStackPositionWithVanillaAlgorithm(wasm::Function *func, StackPosition &stackPosition,
                                                 LivenessMap const &livenessMap) {
  VanillaAssigner assigner{};
  Process process{*func, assigner, livenessMap, stackPosition};
  process.walkFunction(func);
}

static void calStackPositionWithGreedyConflictGraphAlgorithm(wasm::Function *func, StackPosition &stackPosition,
                                                             LivenessMap const &livenessMap, bool tryMCS) {
  ConflictGraph const conflictGraph = ConflictGraph::create(livenessMap);
  ColorVec color = conflictGraph.color();
  GreedyAssigner assigner{color};
  Process process{*func, assigner, livenessMap, stackPosition};
  process.walkFunction(func);
  uint32_t const legacyBytes = stackPosition.getFrameSize();
  uint32_t mcsBytes = legacyBytes;
  if (tryMCS && legacyBytes > ShadowStackElementSize) {
    ColorVec mcsColor = conflictGraph.colorMCS();
    StackPosition candidate;
    GreedyAssigner mcsAssigner{mcsColor};
    Process mcsProcess{*func, mcsAssigner, livenessMap, candidate};
    mcsProcess.walkFunction(func);
    mcsBytes = candidate.getFrameSize();
    // Only emitted marker slots determine frame size; caller-managed nodes may also be colored.
    if (mcsBytes < legacyBytes) {
      stackPosition = std::move(candidate);
      color = std::move(mcsColor);
    }
  }
  if (support::isDebug("GCColoring", func->name.view())) {
    fmt::println("GCColoring {} legacy={} mcs={} selected={} nodes={}", func->name.view(), legacyBytes, mcsBytes,
                 stackPosition.getFrameSize(), livenessMap.getDimension());
  }
  if (support::isDebug(PASS_NAME, func->name.view())) {
    fmt::println("=========ConflictGraph=========");
    fmt::println("{}", func->name.view());
    conflictGraph.dump();
    color.dump();
    fmt::println("===============================");
  }
}

void StackAssigner::runOnFunction(wasm::Module *const m, wasm::Function *const func) {
  static_cast<void>(m);
  StackPosition &stackPosition = stackPositions_->at(func);
  LivenessMap const &livenessMap = livenessInfo_->at(func);

  switch (mode_) {
  case Mode::Vanilla:
    calStackPositionWithVanillaAlgorithm(func, stackPosition, livenessMap);
    break;
  case Mode::GreedyConflictGraph:
    calStackPositionWithGreedyConflictGraphAlgorithm(func, stackPosition, livenessMap, false);
    break;
  case Mode::BestOfGreedyAndMCS:
    calStackPositionWithGreedyConflictGraphAlgorithm(func, stackPosition, livenessMap, true);
    break;
  }
}

} // namespace warpo::passes::gc

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "../Runner.hpp"
#include "wasm-builder.h"

namespace warpo::passes::gc::ut {

struct StackColoringTest : testing::Test {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
      (func $test (local i32 i32 i32 i32 i32 i32)
        (local.set 0 (call $~lib/rt/__localtostack (i32.const 16)))
        (local.set 1 (call $~lib/rt/__localtostack (i32.const 32)))
        (local.set 2 (call $~lib/rt/__localtostack (i32.const 48)))
        (local.set 3 (call $~lib/rt/__localtostack (i32.const 64)))
        (local.set 4 (call $~lib/rt/__localtostack (i32.const 80)))
        (local.set 5 (call $~lib/rt/__localtostack (i32.const 96)))
      )
    )
  )");

  LivenessMap pathLiveness(bool onlyNodeFour) {
    wasm::Function *const func = m->getFunction("test");
    LivenessMap live{SSAMap::create(func)};
    auto *const body = func->body->cast<wasm::Block>();
    for (size_t const node : Range{6U}) {
      live.ensureExpression(body->list[node]);
      if (!onlyNodeFour || node == 4U)
        live.set(body->list[node], LivenessMap::Pos::After, node, true);
    }
    wasm::Builder b{*m};
    for (auto const &[a, c] : {std::pair{1U, 5U}, {5U, 3U}, {3U, 2U}, {2U, 4U}, {4U, 0U}}) {
      wasm::Expression *const point = b.makeNop();
      body->list.push_back(point);
      live.ensureExpression(point);
      for (auto const pos : {LivenessMap::Pos::Before, LivenessMap::Pos::After}) {
        live.set(point, pos, a, true);
        live.set(point, pos, c, true);
      }
    }
    return live;
  }
};

TEST_F(StackColoringTest, ChoosesSmallerEmittedFrame) {
  LivenessMap const live = pathLiveness(false);
  StackPosition legacy;
  StackPosition best;
  calStackPositionWithGreedyConflictGraphAlgorithm(m->getFunction("test"), legacy, live, false);
  calStackPositionWithGreedyConflictGraphAlgorithm(m->getFunction("test"), best, live, true);
  EXPECT_EQ(legacy.getFrameSize(), 12U);
  EXPECT_EQ(best.getFrameSize(), 8U);
}

TEST_F(StackColoringTest, RejectsFewerColorsWithLargerEmittedFrame) {
  LivenessMap const live = pathLiveness(true);
  EXPECT_EQ(ConflictGraph::create(live).colorMCS().getColor(4U), 1U);
  StackPosition best;
  calStackPositionWithGreedyConflictGraphAlgorithm(m->getFunction("test"), best, live, true);
  EXPECT_EQ(best.getFrameSize(), 4U);
}

TEST_F(StackColoringTest, KeepsLegacyOffsetsOnEqualEmittedFrames) {
  LivenessMap live = pathLiveness(true);
  auto *const body = m->getFunction("test")->body->cast<wasm::Block>();
  live.set(body->list[0], LivenessMap::Pos::After, 0U, true);
  StackPosition best;
  calStackPositionWithGreedyConflictGraphAlgorithm(m->getFunction("test"), best, live, true);
  auto *const marker = body->list[4]->cast<wasm::LocalSet>()->value->cast<wasm::Call>();
  EXPECT_EQ(best.getFrameSize(), 8U);
  ASSERT_NE(best.find(marker), best.end());
  EXPECT_EQ(best.find(marker)->second, 0U);
}

} // namespace warpo::passes::gc::ut

#endif
