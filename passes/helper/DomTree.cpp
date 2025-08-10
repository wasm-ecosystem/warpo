#include <cassert>
#include <iostream>
#include <memory>

#include "CFG.hpp"
#include "DomTree.hpp"
#include "DomTreeImpl.hpp"

namespace warpo::passes {

struct DomTree::Storage {
  std::shared_ptr<CFG> cfg_;
  dom_tree_impl::ImmediateDomTree idomTree;
  dom_tree_impl::ImmediateDomTree postIdomTree;
  dom_tree_impl::DomTree domTree;
  dom_tree_impl::DomTree postDomTree;

  explicit Storage(std::shared_ptr<CFG> const &cfg)
      : cfg_(cfg), idomTree(dom_tree_impl::createDomTree(*cfg)), postIdomTree(dom_tree_impl::createPostDomTree(*cfg)),
        domTree(idomTree.toDomTree()), postDomTree(postIdomTree.toDomTree()) {}
};

DomTree::~DomTree() { delete storage_; }

DomTree DomTree::create(std::shared_ptr<CFG> const &cfg) {
  std::unique_ptr<Storage> storage{new Storage(cfg)};
  return DomTree{storage.release()};
}

/// @brief return true if node dominates dominator
bool DomTree::isDom(BasicBlock const *node, BasicBlock const *dominator) const {
  return storage_->domTree[dominator->getIndex()].get(node->getIndex());
}

/// @brief return true if node post dominates dominator
bool DomTree::isPostDom(BasicBlock const *node, BasicBlock const *dominator) const {
  return storage_->postDomTree[dominator->getIndex()].get(node->getIndex());
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "../Runner.hpp"

namespace warpo::passes::ut {

struct DomTreeTest : public ::testing::Test {};

TEST_F(DomTreeTest, Base) {
  auto m = loadWat(R"(
      (module
        (func $f (param i32 i32 i32) (result i32)
          ;; BB0
          local.get 0
          if (result i32)
          ;; BB1
            local.get 1
          else
          ;; BB2
            local.get 2
          end
          ;; BB3
        )
      )
    )");

  std::shared_ptr<CFG> const cfg{new CFG{CFG::fromFunction(m->getFunction("f"))}};
  cfg->print(std::cout, m.get(), EmptyInfoPrinter{});
  DomTree const domTree = DomTree::create(cfg);

  EXPECT_TRUE(domTree.isDom(&(*cfg)[0], &(*cfg)[1]));
  EXPECT_TRUE(domTree.isDom(&(*cfg)[0], &(*cfg)[2]));
  EXPECT_TRUE(domTree.isDom(&(*cfg)[0], &(*cfg)[3]));
  EXPECT_FALSE(domTree.isDom(&(*cfg)[1], &(*cfg)[3]));
  EXPECT_FALSE(domTree.isDom(&(*cfg)[2], &(*cfg)[3]));

  EXPECT_TRUE(domTree.isPostDom(&(*cfg)[3], &(*cfg)[0]));
  EXPECT_TRUE(domTree.isPostDom(&(*cfg)[3], &(*cfg)[1]));
  EXPECT_TRUE(domTree.isPostDom(&(*cfg)[3], &(*cfg)[2]));
  EXPECT_FALSE(domTree.isPostDom(&(*cfg)[1], &(*cfg)[0]));
  EXPECT_FALSE(domTree.isPostDom(&(*cfg)[2], &(*cfg)[0]));
}

} // namespace warpo::passes::ut

#endif
