/// @details create dominator tree for the given CFG

#pragma once

#include <cassert>
#include <concepts>
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
concept IsBB = requires(T const block) {
  { block.getId() } -> std::same_as<size_t>;
};
template <class T>
concept IsDomTreeBB = requires(T const block) {
  requires IsBB<T>;
  typename T::reference_type;
  { block.preds() } -> std::same_as<std::vector<typename T::reference_type> const &>;
  { *std::declval<typename T::reference_type>() } -> IsBB;
  { block.isEntry() } -> std::same_as<bool>;
};

template <class T>
concept IsPostDomTreeBB = requires(T const block) {
  requires IsBB<T>;
  { block.succs() } -> std::same_as<std::vector<T const *> const &>;
  { block.isExit() } -> std::same_as<bool>;
};

template <IsPostDomTreeBB BB> struct PostDomTreeBB {
  using reference_type = BB const *;
  BB const &bb_;
  PostDomTreeBB(BB const &bb) : bb_(bb) {}
  std::vector<BB const *> const &preds() const { return bb_.succs(); }
  bool isEntry() const { return bb_.isExit(); }
  size_t getId() const { return bb_.getId(); }
};

template <IsDomTreeBB BB> DomTree createDomTreeImpl(std::vector<BB> const &bbs) {
  // TODO: optimize with IDOM
  const size_t n = bbs.size();
  DomTree doms{};
  doms.reserve(n);
  for (BB const &bb : bbs) {
    if (bb.isEntry()) {
      DynBitset dom{n};
      dom.set(bb.getId(), true);
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
    for (BB const &bb : bbs) {
      DynBitset newDom{n};
      if (!bb.preds().empty()) {
        newDom = ~newDom;
      }
      for (typename BB::reference_type pred : bb.preds()) {
        newDom &= doms[pred->getId()];
      }
      size_t const index = bb.getId();
      newDom.set(index, true);
      if (newDom != doms[index]) {
        doms[index] = std::move(newDom);
        isChanged = true;
      }
    }
  }
  return doms;
}

template <IsDomTreeBB BB> DomTree createDomTree(std::vector<BB> const &bbs) { return createDomTreeImpl(bbs); }
template <IsDomTreeBB BB> DomTree createPostDomTree(std::vector<BB> const &bbs) {
  return createDomTreeImpl(transform<PostDomTreeBB<BB>>(bbs, [](BB const &bb) { return PostDomTreeBB<BB>{bb}; }));
}

} // namespace warpo::passes::dom_tree_impl
