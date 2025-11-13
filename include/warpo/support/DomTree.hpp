// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <concepts>
#include <vector>

#include "warpo/support/DynBitSet.hpp"

namespace warpo {

namespace details {

template <class Node>
concept IsNode = requires(Node n) {
  { n.getIndex() } -> std::convertible_to<size_t>;
};

template <class Handler, class Node>
concept IsHandler = IsNode<Node> && requires(Handler h, Node const *bb) {
  { h.preds(bb) } -> std::same_as<std::vector<Node const *> const &>;
};

} // namespace details

struct DomTree : public std::vector<DynBitset> {
  friend std::ostream &operator<<(std::ostream &os, DomTree const &domTree) {
    for (size_t i = 0; i < domTree.size(); ++i) {
      os << "[" << i << "]:" << domTree[i] << " ";
    }
    return os;
  }
};

// Node::getIndex is the index into ImmediateDomTree
struct ImmediateDomTree : public std::vector<size_t> {
  DomTree toDomTree() const;
};

static constexpr size_t undef = SIZE_MAX;

// nodes in reverse post order due to
// 1. reverse post order is more efficient
// 2. this optimized algorithm (2-fingers) must use reverse post order
// let the sequence index in reverse post order as SI(node)
// if SI(a) < SI(b), a must not lower than b in dominator tree (neighbor or ancestor)
// So we can always jump to the less one when finding common dominator
// see http://www.hipersoft.rice.edu/grads/publications/dom14.pdf for details
template <details::IsNode Node, details::IsHandler<Node> Handler>
ImmediateDomTree createDomTreeImpl(Handler h, size_t const n, std::vector<Node const *> const &nodes) {
  // consider we should handle both dominator and post-dominator, Node::getIndex() != index in nodes
  auto const isStartNode = [&h](Node const *bb) { return h.preds(bb).empty(); };
  ImmediateDomTree idoms{};
  std::vector<size_t> indexToSequenceIndex{}; // for quick query index in nodes by Node::getIndex()
  indexToSequenceIndex.resize(n, 0);
  for (size_t i = 0; i < nodes.size(); i++)
    indexToSequenceIndex[nodes[i]->getIndex()] = i;

#ifdef WARPO_ENABLE_UNIT_TESTS
  std::cerr << "indexToSequenceIndex: ";
  for (size_t i = 0; i < n; i++)
    std::cerr << indexToSequenceIndex[i] << " ";
  std::cerr << std::endl;
#endif

  auto const lessThan = [&indexToSequenceIndex](size_t a, size_t b) -> bool {
    return indexToSequenceIndex[a] < indexToSequenceIndex[b];
  };

  auto const dump =
#ifdef WARPO_ENABLE_UNIT_TESTS
      [&idoms]() {
        for (size_t i = 0; i < idoms.size(); ++i) {
          std::cerr << "idoms[" << i << "]";
          if (idoms[i] == undef)
            std::cerr << "undef";
          else
            std::cerr << idoms[i];
          std::cerr << " ";
        }
        std::cerr << "\n";
      };
#else
      []() {};
#endif

  idoms.resize(n, undef);
  for (Node const *const bb : nodes) {
    if (isStartNode(bb))
      idoms[bb->getIndex()] = bb->getIndex();
  }

  bool isChanged = true;
  while (isChanged) {
    dump();
    isChanged = false;
    for (Node const *const bb : nodes) {
      if (isStartNode(bb)) {
        // skip start node
        continue;
      }
      size_t newIdom = undef;
      for (Node const *const pred : h.preds(bb)) {
        size_t const predIndex = pred->getIndex();
        if (idoms[predIndex] == undef)
          continue;

        // pred is calculated
        if (newIdom == undef) {
          newIdom = predIndex;
        } else {
          size_t finger1 = predIndex;
          size_t finger2 = newIdom;
          while (finger1 != finger2) {
            while (lessThan(finger2, finger1)) {
              finger1 = idoms[finger1];
            }
            while (lessThan(finger1, finger2)) {
              finger2 = idoms[finger2];
            }
          }
          newIdom = finger1;
        }
      }
      size_t const index = bb->getIndex();
      if (idoms[index] != newIdom) {
        idoms[index] = newIdom;
        isChanged = true;
      }
    }
  }
  return idoms;
}

inline DomTree ImmediateDomTree::toDomTree() const {
  size_t const n = this->size();
  DomTree doms{};
  doms.resize(n, DynBitset{n});
  for (size_t index = 0; index < n; ++index) {
    size_t idomIndex = index;
    while (true) {
      // no idom, skip
      if (idomIndex == undef)
        break;
      doms[index].set(idomIndex, true);
      // stop loop when idom is itself (start node)
      if (idomIndex == (*this)[idomIndex])
        break;
      idomIndex = (*this)[idomIndex];
    }
  }
  return doms;
}

} // namespace warpo
