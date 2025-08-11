
#pragma once

#include "CFG.hpp"
#include "support/DynBitSet.hpp"

namespace warpo::passes {

class DomTree {
  struct Storage;
  Storage *storage_;

public:
  explicit DomTree(Storage *storage) noexcept : storage_(storage) {}
  ~DomTree();

  static DomTree create(std::shared_ptr<CFG> const &cfg);

  /// @brief return true if node dominates dominator
  bool isDom(BasicBlock const *dominatorNode, BasicBlock const *dominatedNode) const;
  bool isPostDom(BasicBlock const *dominatorNode, BasicBlock const *dominatedNode) const;

  /// @brief get all dominators of @param node
  DynBitset getDominators(BasicBlock const *node) const;
  DynBitset getPostDominators(BasicBlock const *node) const;
};

} // namespace warpo::passes
