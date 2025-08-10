#include <cassert>
#include <memory>

#include "CFG.hpp"
#include "DomTree.hpp"
#include "DomTreeImpl.hpp"

namespace warpo::passes {

struct DomTree::Storage {
  std::shared_ptr<CFG> cfg_; // cfg which own real bb
  dom_tree_impl::DomTree const domTree;
  dom_tree_impl::DomTree const postDomTree;
};

namespace {

struct BB {
  using reference_type = BB const *;
  BasicBlock const *bb_;
  std::vector<reference_type> in_;
  std::vector<reference_type> out_;
  std::vector<reference_type> const &preds() const { return in_; }
  std::vector<reference_type> const &succs() const { return out_; }
  bool isEntry() const { return bb_->isEntry(); }
  bool isExit() const { return bb_->isExit(); }
  size_t getId() const { return bb_->getIndex(); }
};

static_assert(dom_tree_impl::IsDomTreeBB<BB>, "");
static_assert(dom_tree_impl::IsPostDomTreeBB<BB>, "");

} // namespace

DomTree::~DomTree() { delete storage_; }

DomTree DomTree::create(std::shared_ptr<CFG> cfg) {
  std::vector<BB> bbs{};
  for (BasicBlock const &bb : *cfg) {
    bbs.push_back(BB{.bb_ = &bb, .in_ = {}, .out_ = {}});
  }
  for (BasicBlock const &bb : *cfg) {
    for (BasicBlock const *pred : bb.preds()) {
      bbs[pred->getIndex()].out_.push_back(&bbs[bb.getIndex()]);
      bbs[bb.getIndex()].in_.push_back(&bbs[pred->getIndex()]);
    }
  }
  std::unique_ptr<Storage> storage{new Storage{
      .cfg_ = std::move(cfg),
      .domTree = dom_tree_impl::createDomTree(bbs),
      .postDomTree = dom_tree_impl::createPostDomTree(bbs),
  }};
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
