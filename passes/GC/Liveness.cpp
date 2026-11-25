// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <fmt/base.h>
#include <fmt/ranges.h>
#include <iostream>
#include <optional>
#include <queue>
#include <sstream>
#include <unordered_set>
#include <utility>
#include <vector>

#include "../helper/CFG.hpp"
#include "Liveness.hpp"
#include "warpo/support/DynBitSet.hpp"
#include "warpo/support/Range.hpp"
#include "wasm.h"

namespace warpo::passes::gc {

namespace {
struct LivenessPrinter : public IInfoPrinter {
  LivenessMap const &livenessMap_;
  explicit LivenessPrinter(LivenessMap const &livenessMap) : livenessMap_(livenessMap) {}
  std::optional<std::string> onExpr(wasm::Expression *expr) const override;
};

std::optional<std::string> LivenessPrinter::onExpr(wasm::Expression *expr) const {
  std::stringstream ss;
  std::optional<Liveness> const l = livenessMap_.getLiveness(expr);
  if (!l.has_value())
    return std::nullopt;
  ss << "[liveness: ";
  if (l->before() == l->after()) {
    ss << l->before();
  } else {
    ss << l->before() << " -> " << l->after();
  }
  ss << "] ";
  return ss.str();
}
} // namespace

void LivenessMap::dump(wasm::Module *m, wasm::Function *func) const {
  CFG const cfg = CFG::fromFunction(m, func);
  LivenessPrinter const infoPrinter{*this};
  cfg.print(std::cout, m, infoPrinter);
}

std::optional<Liveness> LivenessMap::getLiveness(wasm::Expression *expr) const {
  std::optional<size_t> const base = getIndexBase(expr);
  if (!base.has_value())
    return std::nullopt;
  size_t const baseIndex = base.value();
  return getLiveness(baseIndex);
}

Liveness LivenessMap::getLiveness(size_t const exprIndex) const {
  Liveness ret{dimension_};
  for (size_t const index : Range{dimension_}) {
    ret.setBefore(index, get(exprIndex, Pos::Before, index));
    ret.setAfter(index, get(exprIndex, Pos::After, index));
  }
  ret.applyInvalid(invalid_);
  return ret;
}

void LivenessMap::mergeByColumns(size_t targetColumn, size_t sourceColumn, MergeOperator op) {
  for (size_t const index : Range{2 * map_.size()}) {
    size_t const targetIndex = index * dimension_ + targetColumn;
    size_t const sourceIndex = index * dimension_ + sourceColumn;
    switch (op) {
    case MergeOperator::OR:
      storage_.set(targetIndex, storage_.get(targetIndex) || storage_.get(sourceIndex));
      break;
    default:
      assert(false);
    }
  }
}

ConflictGraph ConflictGraph::create(LivenessMap const &livenessMap) {
  size_t const dim = livenessMap.getDimension();
  ConflictGraph graph{dim};
  for (auto &[expr, line] : livenessMap.getExprMap()) {
    static_cast<void>(expr);
    Liveness const liveness = livenessMap.getLiveness(line);
    std::unordered_set<size_t> visitedLivenessSSAsForBefore{};
    std::unordered_set<size_t> visitedLivenessSSAsForAfter{};
    for (size_t const ssaIndex : Range{dim}) {
      if (liveness.before().get(ssaIndex)) {
        for (size_t const oldSSAIndex : visitedLivenessSSAsForBefore) {
          graph.addEdge(oldSSAIndex, ssaIndex);
        }
        visitedLivenessSSAsForBefore.insert(ssaIndex);
      }
      if (liveness.after().get(ssaIndex)) {
        for (size_t const oldSSAIndex : visitedLivenessSSAsForAfter) {
          graph.addEdge(oldSSAIndex, ssaIndex);
        }
        visitedLivenessSSAsForAfter.insert(ssaIndex);
      }
    }
  }
  return graph;
}

void ConflictGraph::dump() const {
  for (size_t const line : Range{dim_}) {
    fmt::print("{}: ", line);
    for (size_t const column : Range{dim_})
      fmt::print("{} ", isAdjacent(line, column) ? '+' : ' ');
    fmt::println("");
  }
}

void ColorVec::dump() const {
  for (size_t const color : (*this)) {
    fmt::print("{} ", color);
  }
  fmt::println("");
}

// welch powell algorithm
ColorVec ConflictGraph::color() const {
  // pre-sort the nodes by degree
  struct SortedNodes : private std::priority_queue<std::pair<size_t, size_t>> {
    using P = std::priority_queue<std::pair<size_t, size_t>>;
    void insert(size_t cnt, size_t line) { push(std::pair<size_t, size_t>{cnt, line}); }

    size_t pop() {
      size_t const line = P::top().second;
      P::pop();
      return line;
    }
    using P::empty;
  };
  SortedNodes sortedNodes{};
  for (size_t const line : Range{dim_}) {
    size_t cnt = 0;
    for (size_t const column : Range{dim_}) {
      if (isAdjacent(line, column))
        cnt++;
    }
    sortedNodes.insert(cnt, line);
  }

  // visit from the largest degree
  ColorVec nodeColor{dim_};
  size_t currentNewColor = 0;

  while (!sortedNodes.empty()) {
    size_t const line = sortedNodes.pop();
    DynBitset usedColors{currentNewColor}; // color index -> is used
    for (size_t const column : Range{dim_}) {
      if (isAdjacent(line, column) && nodeColor.hasColor(column)) {
        // remove the color of the adjacent node
        usedColors.set(nodeColor.getColor(column), true);
      }
    }
    auto findSmallestUnusedColor = [&]() -> size_t {
      for (size_t const color : Range{currentNewColor}) {
        if (!usedColors.get(color))
          return color;
      }
      size_t const selectedColor = currentNewColor;
      currentNewColor++;
      return selectedColor;
    };
    nodeColor.setColor(line, findSmallestUnusedColor());
  }
  return nodeColor;
}

ColorVec ConflictGraph::colorMCS() const {
  ColorVec colors{dim_};
  std::vector<size_t> weights(dim_, 0U);
  for (size_t const step : Range{dim_}) {
    static_cast<void>(step);
    size_t selected = dim_;
    for (size_t const node : Range{dim_}) {
      if (!colors.hasColor(node) && (selected == dim_ || weights[node] >= weights[selected]))
        selected = node;
    }
    assert(selected < dim_);
    DynBitset usedColors{dim_};
    for (size_t const neighbor : Range{dim_}) {
      if (isAdjacent(selected, neighbor) && colors.hasColor(neighbor))
        usedColors.set(colors.getColor(neighbor), true);
    }
    size_t color = 0;
    while (usedColors.get(color))
      ++color;
    colors.setColor(selected, color);
    for (size_t const neighbor : Range{dim_}) {
      if (isAdjacent(selected, neighbor) && !colors.hasColor(neighbor))
        ++weights[neighbor];
    }
  }
  return colors;
}

} // namespace warpo::passes::gc

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

namespace warpo::passes::ut {

using namespace gc;

TEST(ConflictGraphTest, Color1) {
  ConflictGraph graph{4};
  //     0 1 2 3
  // --------------
  // 0 | - 1 0 1 -> (2)
  // 1 | 1 - 0 1 -> (1)
  // 2 | 0 0 - 1 -> (1)
  // 3 | 1 1 1 - -> (0)
  graph.addEdge(0, 1);
  graph.addEdge(0, 1);
  graph.addEdge(3, 0);
  graph.addEdge(3, 1);
  graph.addEdge(3, 2);

  ColorVec const color = graph.color();
  EXPECT_EQ(color.getColor(0), 2);
  EXPECT_EQ(color.getColor(1), 1);
  EXPECT_EQ(color.getColor(2), 1);
  EXPECT_EQ(color.getColor(3), 0);
}

TEST(ConflictGraphTest, Color2) {
  ConflictGraph graph{2};
  // 0: + +
  // 1: + +
  graph.addEdge(0, 0);
  graph.addEdge(0, 1);
  graph.addEdge(1, 1);

  ColorVec const color = graph.color();
  EXPECT_EQ(color.getColor(0), 1);
  EXPECT_EQ(color.getColor(1), 0);
}

TEST(ConflictGraphTest, MCSImprovesDegreeOrdering) {
  ConflictGraph graph{6};
  graph.addEdge(1, 5);
  graph.addEdge(5, 3);
  graph.addEdge(3, 2);
  graph.addEdge(2, 4);
  graph.addEdge(4, 0);
  ColorVec const legacy = graph.color();
  ColorVec const mcs = graph.colorMCS();
  size_t legacyMax = 0;
  size_t mcsMax = 0;
  for (size_t const node : Range{6U}) {
    legacyMax = std::max(legacyMax, legacy.getColor(node));
    mcsMax = std::max(mcsMax, mcs.getColor(node));
  }
  EXPECT_EQ(legacyMax + 1U, 3U);
  EXPECT_EQ(mcsMax + 1U, 2U);
}

TEST(ConflictGraphTest, MCSColorsSmallGraphsIncludingSelfEdges) {
  for (size_t nodes = 0; nodes <= 5; ++nodes) {
    size_t const edgeCount = nodes == 0 ? 0 : nodes * (nodes - 1U) / 2U;
    for (size_t mask = 0; mask < (size_t{1} << edgeCount); ++mask) {
      ConflictGraph graph{nodes};
      size_t edge = 0;
      for (size_t a = 0; a < nodes; ++a) {
        graph.addEdge(a, a);
        for (size_t b = a + 1; b < nodes; ++b, ++edge) {
          if ((mask & (size_t{1} << edge)) != 0)
            graph.addEdge(a, b);
        }
      }
      ColorVec const colors = graph.colorMCS();
      ColorVec const repeated = graph.colorMCS();
      for (size_t a = 0; a < nodes; ++a) {
        ASSERT_TRUE(colors.hasColor(a));
        EXPECT_EQ(colors.getColor(a), repeated.getColor(a));
        for (size_t b = a + 1; b < nodes; ++b) {
          if (graph.isAdjacent(a, b))
            EXPECT_NE(colors.getColor(a), colors.getColor(b));
        }
      }
    }
  }
}

} // namespace warpo::passes::ut

#endif
