// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

/// @details create dominator tree for the given CFG

#pragma once

#include <cassert>
#include <cstddef>
#include <iostream>
#include <ostream>
#include <vector>

#include "CFG.hpp"
#include "warpo/support/DynBitSet.hpp"

namespace warpo::passes::dom_tree_impl {

struct DomTree : public std::vector<DynBitset> {
  friend std::ostream &operator<<(std::ostream &os, DomTree const &domTree) {
    for (size_t i = 0; i < domTree.size(); ++i) {
      os << "BB[" << i << "]:" << domTree[i] << " ";
    }
    return os;
  }
};

struct ImmediateDomTree : public std::vector<size_t> {
  DomTree toDomTree() const;
};

ImmediateDomTree createDomTree(CFG const &cfg);

ImmediateDomTree createPostDomTree(CFG const &cfg);

} // namespace warpo::passes::dom_tree_impl
