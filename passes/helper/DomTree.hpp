// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include "CFG.hpp"
#include "warpo/support/DynBitSet.hpp"

namespace warpo::passes {

// In a program, pathological CFGs containing unreachable may occur. Such pathological CFGs have no impact on the
// Dominator Tree, but can affect the Post-dominator Tree. As a program has multiple exit points, a large number of
// nodes cannot be post-dominated by their successor nodes. To prevent unreachable from interfering with optimizations,
// Basic Blocks (BBs) terminated by unreachable are ignored in this Dominator Tree implementation.
// This is analogous to the handling of Undefined Behavior (UB) in C++.
//
// Example:
// `TEST_F(DomTreeImplTest, Unreachable)`
class DomTree {
  struct Storage;
  Storage *storage_;

public:
  explicit DomTree(Storage *storage) noexcept : storage_(storage) {}
  DomTree(DomTree const &) = delete;
  DomTree &operator=(DomTree const &) = delete;
  DomTree(DomTree &&other) noexcept = delete;
  DomTree &operator=(DomTree &&other) noexcept = delete;
  ~DomTree();

  static DomTree create(std::shared_ptr<CFG> const &cfg);

  /// @brief return true if node dominates dominator
  bool isDom(BasicBlock const *dominatorNode, BasicBlock const *dominatedNode) const;
  bool isPostDom(BasicBlock const *dominatorNode, BasicBlock const *dominatedNode) const;
  BasicBlock const *getIDom(BasicBlock const *node) const;

  /// @brief get all dominators of @param node
  DynBitset getDominators(BasicBlock const *node) const;
  DynBitset getPostDominators(BasicBlock const *node) const;
};

} // namespace warpo::passes
