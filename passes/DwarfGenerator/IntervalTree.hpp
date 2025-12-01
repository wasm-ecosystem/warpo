// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <algorithm>
#include <deque>
#include <fmt/format.h>
#include <memory>
#include <utility>
#include <vector>

#include "binaryen/src/wasm-binary.h"

namespace warpo::passes {

/// @brief Abstract visitor for processing intervals in containment order
template <typename T> class IntervalVisitor {
public:
  virtual ~IntervalVisitor() = default;

  /// @brief Called when entering a scope (before processing its children)
  virtual void onEnterScope(std::pair<wasm::BinaryLocations::Span, T> const &interval) = 0;

  /// @brief Called when exiting a scope (after processing all its children)
  virtual void onExitScope(std::pair<wasm::BinaryLocations::Span, T> const &interval) = 0;
};

/// @brief Builder that processes intervals and invokes visitor callbacks
template <typename T> class IntervalTreeBuilder final {
public:
  /// @brief Process intervals with visitor pattern (no physical tree built)
  /// Visitor callbacks are invoked in depth-first order
  static void process(std::vector<std::pair<wasm::BinaryLocations::Span, T>> &&intervals, IntervalVisitor<T> &visitor) {
    std::sort(intervals.begin(), intervals.end(),
              [](std::pair<wasm::BinaryLocations::Span, T> const &a,
                 std::pair<wasm::BinaryLocations::Span, T> const &b) noexcept -> bool {
                if (a.first.start < b.first.start) {
                  return true;
                }
                if (a.first.start > b.first.start) {
                  return false;
                }
                return a.first.end > b.first.end;
              });

    std::vector<std::pair<wasm::BinaryLocations::Span, T> const *> parentStack;

    for (std::pair<wasm::BinaryLocations::Span, T> const &interval : intervals) {
      while (!parentStack.empty() && (parentStack.back()->first.end < interval.first.end)) {
        std::pair<wasm::BinaryLocations::Span, T> const *popped = parentStack.back();

        bool isValidPop = true;

        bool isContainedByCurrent =
            (interval.first.start <= popped->first.start && interval.first.end >= popped->first.end);
        bool noOverlapWithCurrent =
            (popped->first.end <= interval.first.start || popped->first.start >= interval.first.end);

        if (!isContainedByCurrent && !noOverlapWithCurrent) {
          isValidPop = false;
        }

        if (!isValidPop) {
          fmt::print(stderr, "Warning: Interval [{}, {}] overlaps with existing root but is not contained.\n",
                     popped->first.start, popped->first.end);
        }

        visitor.onExitScope(*popped);
        parentStack.pop_back();
      }

      visitor.onEnterScope(interval);
      parentStack.push_back(&interval);
    }

    while (!parentStack.empty()) {
      std::pair<wasm::BinaryLocations::Span, T> const *popped = parentStack.back();
      visitor.onExitScope(*popped);
      parentStack.pop_back();
    }
  }
};

/// @brief Concrete tree structure that stores intervals in a containment hierarchy
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

  void build(std::vector<std::pair<wasm::BinaryLocations::Span, T>> &&intervals) {
    clear();
    currentParent_ = nullptr;
    IntervalTreeBuilder<T>::process(std::move(intervals), *this);
  }

  void onEnterScope(std::pair<wasm::BinaryLocations::Span, T> const &interval) override {
    if (currentParent_ == nullptr) {
      roots_.emplace_back(interval.first, interval.second);
      currentParent_ = &roots_.back();
      parentStack_.push_back(nullptr);
    } else {
      currentParent_->children.emplace_back(std::make_unique<Node>(interval.first, interval.second));
      Node *newNode = currentParent_->children.back().get();
      newNode->parent = currentParent_;
      parentStack_.push_back(currentParent_);
      currentParent_ = newNode;
    }
  }

  void onExitScope([[maybe_unused]] std::pair<wasm::BinaryLocations::Span, T> const &interval) override {
    if (!parentStack_.empty()) {
      currentParent_ = parentStack_.back();
      parentStack_.pop_back();
    }
  }

  std::deque<Node> const &getRoots() const noexcept { return roots_; }

  void clear() {
    roots_.clear();
    parentStack_.clear();
  }

private:
  std::deque<Node> roots_;
  Node *currentParent_ = nullptr;
  std::vector<Node *> parentStack_;
};

} // namespace warpo::passes
