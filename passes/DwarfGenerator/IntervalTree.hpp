// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <algorithm>
#include <deque>
#include <memory>
#include <stack>
#include <utility>
#include <vector>

#include "binaryen/src/wasm-binary.h"

namespace warpo::passes {

template <typename T> class IntervalTree final {
public:
  struct Node final {
    wasm::BinaryLocations::Span span;
    T data;
    std::vector<std::unique_ptr<Node>> children;
    Node *parent;

    template <typename U>
    inline Node(wasm::BinaryLocations::Span const &s, U &&d) : span(s), data(std::forward<U>(d)), parent(nullptr) {}
  };

  IntervalTree() = default;

  // Build the tree from a vector of intervals
  // This will sort the intervals and construct the containment tree
  // Sort order: intervals with same start position are ordered by end position (descending)
  // This ensures larger containing intervals are processed before smaller contained ones
  template <typename U> void build(std::vector<std::pair<wasm::BinaryLocations::Span, U>> &&intervals) {
    clear();

    // Sort intervals: ascending start, then descending end
    // Example: [1,10] comes before [1,5], so [1,10] becomes parent of [1,5]
    std::sort(intervals.begin(), intervals.end(),
              [](std::pair<wasm::BinaryLocations::Span, U> const &a,
                 std::pair<wasm::BinaryLocations::Span, U> const &b) noexcept -> bool {
                if (a.first.start < b.first.start) {
                  return true;
                }
                if (a.first.start > b.first.start) {
                  return false;
                }
                return a.first.end > b.first.end;
              });

    std::stack<Node *> stack;

    for (std::pair<wasm::BinaryLocations::Span, U> &interval : intervals) {
      // Pop intervals that don't contain current interval
      while (!stack.empty() && (stack.top()->span.end < interval.first.end)) {
        stack.pop();
      }

      Node *nodePtr;
      if (stack.empty()) {
        // Root level node
        roots_.emplace_back(interval.first, std::forward<U>(interval.second));
        nodePtr = &roots_.back();
      } else {
        // Child node - add to parent's children deque
        Node *const parent = stack.top();
        parent->children.emplace_back(std::make_unique<Node>(interval.first, std::forward<U>(interval.second)));
        nodePtr = parent->children.back().get();
        nodePtr->parent = parent;
      }

      stack.push(nodePtr);
    }
  }

  std::deque<Node> const &getRoots() const noexcept { return roots_; }

  void clear() { roots_.clear(); }

private:
  std::deque<Node> roots_;
};

} // namespace warpo::passes
