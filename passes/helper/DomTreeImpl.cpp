// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <iostream>
#include <vector>

#include "CFG.hpp"
#include "DomTreeImpl.hpp"
#include "warpo/support/DynBitSet.hpp"

namespace warpo::passes {

namespace {

struct NormalHandler {
  std::vector<const BasicBlock *> const &preds(BasicBlock const *bb) const { return bb->preds(); }
};
struct ReverseHandler {
  // In reverse graph, successors are predecessors in the original graph.
  std::vector<const BasicBlock *> const &preds(BasicBlock const *bb) const { return bb->succs(); }
};

} // namespace

ImmediateDomTree dom_tree_impl::createDomTree(CFG const &cfg) {
#ifdef WARPO_ENABLE_UNIT_TESTS
  std::cerr << __FUNCTION__ << "\n";
#endif
  std::vector<BasicBlock const *> const bbs = cfg.getReversePostOrder();
  return createDomTreeImpl<BasicBlock, NormalHandler>(NormalHandler{}, cfg.size(), bbs);
}
ImmediateDomTree dom_tree_impl::createPostDomTree(CFG const &cfg) {
#ifdef WARPO_ENABLE_UNIT_TESTS
  std::cerr << __FUNCTION__ << "\n";
#endif
  std::vector<BasicBlock const *> const bbs = cfg.getReversePostOrderOnReverseGraph();
  return createDomTreeImpl<BasicBlock, ReverseHandler>(ReverseHandler{}, cfg.size(), bbs);
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

namespace warpo::passes::dom_tree_impl::ut {

struct DomTreeImplTest : public ::testing::Test {
  CFGTestWrapper cfg_;
  DynBitset createExpectDom(std::initializer_list<size_t> domIndexes) {
    DynBitset expectDom{CFGForTest::blocks(cfg_.raw_).size()};
    for (size_t const domIndex : domIndexes) {
      expectDom.set(domIndex, true);
    }
    return expectDom;
  }
};

TEST_F(DomTreeImplTest, Base) {
  size_t const entry = cfg_.addBB();
  size_t const exit = cfg_.addExitBB();
  cfg_.linkBBs(entry, exit);

  DomTree const domTree = createDomTree(cfg_.raw_).toDomTree();
  ASSERT_EQ(domTree.size(), cfg_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, exit}));

  DomTree const postDomTree = createPostDomTree(cfg_.raw_).toDomTree();
  ASSERT_EQ(postDomTree.size(), cfg_.size());

  EXPECT_EQ(postDomTree[entry], createExpectDom({entry, exit}));
  EXPECT_EQ(postDomTree[exit], createExpectDom({exit}));
}

TEST_F(DomTreeImplTest, Complex) {
  /*
        Entry
        /   \
        A    B
      /  \    \
      C   D    E
      |   \  /
      F    G
       \   /
         Exit
  */
  size_t const entry = cfg_.addBB();
  size_t const a = cfg_.addBB();
  size_t const b = cfg_.addBB();
  size_t const c = cfg_.addBB();
  size_t const d = cfg_.addBB();
  size_t const e = cfg_.addBB();
  size_t const f = cfg_.addBB();
  size_t const g = cfg_.addBB();
  size_t const exit = cfg_.addExitBB();
  cfg_.linkBBs(entry, a);
  cfg_.linkBBs(entry, b);
  cfg_.linkBBs(a, c);
  cfg_.linkBBs(a, d);
  cfg_.linkBBs(b, e);
  cfg_.linkBBs(c, f);
  cfg_.linkBBs(d, g);
  cfg_.linkBBs(e, g);
  cfg_.linkBBs(f, exit);
  cfg_.linkBBs(g, exit);

  DomTree const domTree = createDomTree(cfg_.raw_).toDomTree();
  ASSERT_EQ(domTree.size(), cfg_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[a], createExpectDom({entry, a}));
  EXPECT_EQ(domTree[b], createExpectDom({entry, b}));
  EXPECT_EQ(domTree[c], createExpectDom({entry, a, c}));
  EXPECT_EQ(domTree[d], createExpectDom({entry, a, d}));
  EXPECT_EQ(domTree[e], createExpectDom({entry, b, e}));
  EXPECT_EQ(domTree[f], createExpectDom({entry, a, c, f}));
  EXPECT_EQ(domTree[g], createExpectDom({entry, g}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, exit}));

  DomTree const postDomTree = createPostDomTree(cfg_.raw_).toDomTree();
  ASSERT_EQ(postDomTree.size(), cfg_.size());

  EXPECT_EQ(postDomTree[entry], createExpectDom({exit, entry}));
  EXPECT_EQ(postDomTree[a], createExpectDom({exit, a}));
  EXPECT_EQ(postDomTree[b], createExpectDom({exit, g, e, b}));
  EXPECT_EQ(postDomTree[c], createExpectDom({exit, f, c}));
  EXPECT_EQ(postDomTree[d], createExpectDom({exit, g, d}));
  EXPECT_EQ(postDomTree[e], createExpectDom({exit, g, e}));
  EXPECT_EQ(postDomTree[f], createExpectDom({exit, f}));
  EXPECT_EQ(postDomTree[g], createExpectDom({exit, g}));
  EXPECT_EQ(postDomTree[exit], createExpectDom({exit}));
}

TEST_F(DomTreeImplTest, Loop) {
  /*
        Entry
        |
        A
      /  \
      B   C <-|
      |   |   F
      D   E --|
      \   /
        G
        |
       exit
  */
  size_t const entry = cfg_.addBB();
  size_t const a = cfg_.addBB();
  size_t const b = cfg_.addBB();
  size_t const c = cfg_.addBB();
  size_t const d = cfg_.addBB();
  size_t const e = cfg_.addBB();
  size_t const f = cfg_.addBB();
  size_t const g = cfg_.addBB();
  size_t const exit = cfg_.addExitBB();
  cfg_.linkBBs(entry, a);
  cfg_.linkBBs(a, b);
  cfg_.linkBBs(a, c);
  cfg_.linkBBs(b, d);
  cfg_.linkBBs(c, e);
  cfg_.linkBBs(d, g);
  cfg_.linkBBs(e, f);
  cfg_.linkBBs(e, g);
  cfg_.linkBBs(f, c);
  cfg_.linkBBs(g, exit);

  DomTree const domTree = createDomTree(cfg_.raw_).toDomTree();
  ASSERT_EQ(domTree.size(), cfg_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[a], createExpectDom({entry, a}));
  EXPECT_EQ(domTree[b], createExpectDom({entry, a, b}));
  EXPECT_EQ(domTree[c], createExpectDom({entry, a, c}));
  EXPECT_EQ(domTree[d], createExpectDom({entry, a, b, d}));
  EXPECT_EQ(domTree[e], createExpectDom({entry, a, c, e}));
  EXPECT_EQ(domTree[f], createExpectDom({entry, a, c, e, f}));
  EXPECT_EQ(domTree[g], createExpectDom({entry, a, g}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, a, g, exit}));

  DomTree const postDomTree = createPostDomTree(cfg_.raw_).toDomTree();
  ASSERT_EQ(postDomTree.size(), cfg_.size());

  EXPECT_EQ(postDomTree[entry], createExpectDom({exit, g, a, entry}));
  EXPECT_EQ(postDomTree[a], createExpectDom({exit, g, a}));
  EXPECT_EQ(postDomTree[b], createExpectDom({exit, g, d, b}));
  EXPECT_EQ(postDomTree[c], createExpectDom({exit, e, g, c}));
  EXPECT_EQ(postDomTree[d], createExpectDom({exit, g, d}));
  EXPECT_EQ(postDomTree[e], createExpectDom({exit, g, e}));
  EXPECT_EQ(postDomTree[f], createExpectDom({exit, c, e, g, f}));
  EXPECT_EQ(postDomTree[g], createExpectDom({exit, g}));
  EXPECT_EQ(postDomTree[exit], createExpectDom({exit}));
}

TEST_F(DomTreeImplTest, Unreachable) {
  /*
        Entry
        /   \
        A    B <- unreachable
        \
         Exit
   */
  size_t const entry = cfg_.addBB();
  size_t const exit = cfg_.addExitBB();
  size_t const a = cfg_.addBB();
  size_t const b = cfg_.addBB();
  cfg_.linkBBs(entry, a);
  cfg_.linkBBs(entry, b);
  cfg_.linkBBs(a, exit);

  DomTree const domTree = createDomTree(cfg_.raw_).toDomTree();
  ASSERT_EQ(domTree.size(), cfg_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[a], createExpectDom({entry, a}));
  EXPECT_EQ(domTree[b], createExpectDom({entry, b}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, a, exit}));

  DomTree const postDomTree = createPostDomTree(cfg_.raw_).toDomTree();
  ASSERT_EQ(postDomTree.size(), cfg_.size());

  EXPECT_EQ(postDomTree[entry], createExpectDom({exit, a, entry}));
  EXPECT_EQ(postDomTree[a], createExpectDom({exit, a}));
  EXPECT_EQ(postDomTree[b], createExpectDom({b}));
  EXPECT_EQ(postDomTree[exit], createExpectDom({exit}));
}

} // namespace warpo::passes::dom_tree_impl::ut

#endif
