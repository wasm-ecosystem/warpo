/// @details create dominator tree for the given CFG

#pragma once

#include <cassert>
#include <cstddef>
#include <iostream>
#include <ostream>
#include <vector>

#include "CFG.hpp"
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

DomTree createDomTree(CFG const &cfg);

DomTree createPostDomTree(CFG const &bbs);

} // namespace warpo::passes::dom_tree_impl
