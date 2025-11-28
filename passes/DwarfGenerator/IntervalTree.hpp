// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#ifndef WARPO_PASSES_DWARF_GENERATOR_INTERVAL_TREE_HPP
#define WARPO_PASSES_DWARF_GENERATOR_INTERVAL_TREE_HPP

#include <algorithm>
#include <deque>
#include <stack>
#include <utility>

#include "binaryen/src/wasm-binary.h"

namespace warpo::passes {

template <typename T> class IntervalTree {
public:
  struct Node {
    wasm::BinaryLocations::Span span;
    T data;
    std::deque<Node> children;
    Node *parent;

    template <typename U>
    Node(wasm::BinaryLocations::Span const &s, U &&d) : span(s), data(std::forward<U>(d)), parent(nullptr) {}
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
    std::sort(
        intervals.begin(), intervals.end(),
        [](std::pair<wasm::BinaryLocations::Span, U> const &a, std::pair<wasm::BinaryLocations::Span, U> const &b) {
          if (a.first.start < b.first.start) {
            return true;
          }
          if (a.first.start > b.first.start) {
            return false;
          }
          return a.first.end > b.first.end;
        });

    // Build tree using stack-based approach
    // Stack maintains potential parent intervals
    std::stack<Node *> stack;

    for (std::pair<wasm::BinaryLocations::Span, U> &interval : intervals) {
      Node *nodePtr = nullptr;

      // Pop intervals that don't contain current interval
      while (!stack.empty() && stack.top()->span.end < interval.first.end) {
        stack.pop();
      }

      if (stack.empty()) {
        // Root level node
        roots_.emplace_back(interval.first, std::forward<U>(interval.second));
        nodePtr = &roots_.back();
      } else {
        // Child node - add to parent's children deque
        Node *parent = stack.top();
        parent->children.emplace_back(interval.first, std::forward<U>(interval.second));
        nodePtr = &parent->children.back();
        nodePtr->parent = parent;
      }

      stack.push(nodePtr);
    }
  }

  // Get all root-level intervals (intervals not contained by any other)
  std::deque<Node> &getRoots() { return roots_; }
  std::deque<Node> const &getRoots() const { return roots_; }

  // Clear the tree
  void clear() { roots_.clear(); }

  // Check if a span contains another span
  static bool contains(wasm::BinaryLocations::Span const &outer, wasm::BinaryLocations::Span const &inner) {
    return outer.start <= inner.start && inner.end <= outer.end;
  }

private:
  std::deque<Node> roots_;
};

} // namespace warpo::passes

#endif // WARPO_PASSES_DWARF_GENERATOR_INTERVAL_TREE_HPP
