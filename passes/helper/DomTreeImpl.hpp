/// @details create dominator tree for the given CFG

#pragma once

#include <cassert>
#include <cstddef>
#include <iostream>
#include <ostream>
#include <utility>
#include <vector>

#include "support/Container.hpp"
#include "support/DynBitSet.hpp"

namespace warpo::passes::dom_tree_impl {

struct DomTree : public std::vector<DynBitset> {
  friend std::ostream &operator<<(std::ostream &os, DomTree const &domTree) {
    for (size_t i = 0; i < domTree.size(); ++i) {
      os << "BB[" << i << "]:" << domTree[i] << " ";
    }
    return os;
  }
};

template <class T>
concept IsDomTreeBB = requires(T const block) {
  { block.preds() } -> std::same_as<std::vector<size_t> const &>;
  { block.isEntry() } -> std::same_as<bool>;
};

template <class T>
concept IsPostDomTreeBB = requires(T const block) {
  { block.succs() } -> std::same_as<std::vector<size_t> const &>;
  { block.isExit() } -> std::same_as<bool>;
};

template <IsPostDomTreeBB BB> struct PostDomTreeBB {
  BB const &bb_;
  PostDomTreeBB(BB const &bb) : bb_(bb) {}
  std::vector<size_t> const &preds() const { return bb_.succs(); }
  bool isEntry() const { return bb_.isExit(); }
};

template <IsDomTreeBB BB> DomTree createDomTreeImpl(bool isReverse, std::vector<BB> const &bbs) {
  // TODO: optimize with IDOM
  const size_t n = bbs.size();
  DomTree doms{};
  doms.reserve(n);
  for (size_t i = 0; i < n; i++) {
    BB const &bb = bbs[i];
    if (bb.isEntry()) {
      DynBitset dom{n};
      dom.set(i, true);
      doms.emplace_back(std::move(dom));
    } else {
      doms.emplace_back(~DynBitset{n});
    }
  }

  bool isChanged = true;
  while (isChanged) {
#ifdef WARPO_ENABLE_UNIT_TESTS
    std::cerr << doms << "\n";
#endif
    isChanged = false;
    for (size_t i = 0; i < n; i++) {
      size_t const index = isReverse ? n - 1 - i : i;
      BB const &bb = bbs[index];
      DynBitset newDom{n};
      if (!bb.preds().empty()) {
        newDom = ~newDom;
      }
      for (size_t predIndex : bb.preds()) {
        newDom &= doms[predIndex];
      }
      newDom.set(index, true);
      if (newDom != doms[index]) {
        doms[index] = std::move(newDom);
        isChanged = true;
      }
    }
  }
  return doms;
}

template <IsDomTreeBB BB> DomTree createDomTree(std::vector<BB> const &bbs) { return createDomTreeImpl(false, bbs); }
template <IsDomTreeBB BB> DomTree createPostDomTree(std::vector<BB> const &bbs) {
  return createDomTreeImpl(true, transform<PostDomTreeBB<BB>>(bbs, [](BB const &bb) { return PostDomTreeBB<BB>{bb}; }));
}

} // namespace warpo::passes::dom_tree_impl
