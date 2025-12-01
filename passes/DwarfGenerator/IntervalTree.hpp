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

// Abstract visitor for processing intervals in containment order
template <typename T> class IntervalVisitor {
public:
  virtual ~IntervalVisitor() = default;

  // Called when entering a scope (before processing its children)
  virtual void onEnterScope(std::pair<wasm::BinaryLocations::Span, T> const &interval) = 0;

  // Called when exiting a scope (after processing all its children)
  virtual void onExitScope(std::pair<wasm::BinaryLocations::Span, T> const &interval) = 0;
};

// Builder that processes intervals and invokes visitor callbacks
template <typename T> class IntervalTreeBuilder final {
public:
  // Process intervals with visitor pattern (no physical tree built)
  // Visitor callbacks are invoked in depth-first order
  template <typename U>
  static void process(std::vector<std::pair<wasm::BinaryLocations::Span, U>> &&intervals, IntervalVisitor<T> &visitor) {
    // Sort intervals: ascending start, then descending end
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

    std::stack<std::pair<wasm::BinaryLocations::Span, U> const *> stack;

    for (std::pair<wasm::BinaryLocations::Span, U> const &interval : intervals) {
      // Pop intervals that don't contain current interval and exit their scopes
      while (!stack.empty() && (stack.top()->first.end < interval.first.end)) {
        std::pair<wasm::BinaryLocations::Span, U> const *popped = stack.top();
        visitor.onExitScope(*popped);
        stack.pop();
      }

      // Enter current scope
      visitor.onEnterScope(interval);
      stack.push(&interval);
    }

    // Exit remaining scopes in stack
    while (!stack.empty()) {
      std::pair<wasm::BinaryLocations::Span, U> const *popped = stack.top();
      visitor.onExitScope(*popped);
      stack.pop();
    }
  }
};

// Concrete tree structure that stores intervals in a containment hierarchy
template <typename T> class IntervalTree final : public IntervalVisitor<T> {
public:
  struct Node final {
    wasm::BinaryLocations::Span span;
    T data;
    std::vector<std::unique_ptr<Node>> children;
    Node *parent;

    template <typename U>
    inline Node(wasm::BinaryLocations::Span const &s, U &&d) : span(s), data(std::forward<U>(d)), parent(nullptr) {}
  };

  IntervalTree() : currentParent_(nullptr) {}

  // Build tree from intervals
  template <typename U> void build(std::vector<std::pair<wasm::BinaryLocations::Span, U>> &&intervals) {
    clear();
    currentParent_ = nullptr;
    IntervalTreeBuilder<T>::process(std::move(intervals), *this);
  }

  // IntervalVisitor implementation
  void onEnterScope(std::pair<wasm::BinaryLocations::Span, T> const &interval) override {
    if (currentParent_ == nullptr) {
      // Root level node
      roots_.emplace_back(interval.first, interval.second);
      currentParent_ = &roots_.back();
      parentStack_.push(nullptr);
    } else {
      // Child node - add to parent's children
      currentParent_->children.emplace_back(std::make_unique<Node>(interval.first, interval.second));
      Node *newNode = currentParent_->children.back().get();
      newNode->parent = currentParent_;
      parentStack_.push(currentParent_);
      currentParent_ = newNode;
    }
  }

  void onExitScope(std::pair<wasm::BinaryLocations::Span, T> const &) override {
    if (!parentStack_.empty()) {
      currentParent_ = parentStack_.top();
      parentStack_.pop();
    }
  }

  std::deque<Node> const &getRoots() const noexcept { return roots_; }

  void clear() {
    roots_.clear();
    while (!parentStack_.empty()) {
      parentStack_.pop();
    }
  }

private:
  std::deque<Node> roots_;
  Node *currentParent_ = nullptr;
  std::stack<Node *> parentStack_;
};

} // namespace warpo::passes
