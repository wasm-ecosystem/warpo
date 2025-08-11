
#pragma once

#include "CFG.hpp"

namespace warpo::passes {

class DomTree {
  struct Storage;
  Storage *storage_;

public:
  explicit DomTree(Storage *storage) noexcept : storage_(storage) {}
  ~DomTree();

  static DomTree create(std::shared_ptr<CFG> const &cfg);
  bool isDom(BasicBlock const *node, BasicBlock const *dominator) const;
  bool isPostDom(BasicBlock const *node, BasicBlock const *dominator) const;
};

} // namespace warpo::passes
