
#include <cassert>
#include <cstddef>
#include <iostream>
#include <vector>

#include "CFG.hpp"
#include "DomTreeImpl.hpp"
#include "support/Container.hpp"
#include "support/DynBitSet.hpp"

namespace warpo::passes::dom_tree_impl {

namespace {
template <class Handler>
concept IsHandler = requires(Handler h, BasicBlock const *bb) {
  { h.preds(bb) } -> std::same_as<std::vector<const BasicBlock *> const &>;
};

} // namespace

template <IsHandler Handler> DomTree createDomTreeImpl(Handler h, std::vector<BasicBlock const *> const &bbs) {
  // TODO: optimize with IDOM
  const size_t n = bbs.size();
  DomTree doms{};
  doms.reserve(n);
  for (BasicBlock const *bb : bbs)
    doms.push_back(~DynBitset{n});
#ifdef WARPO_ENABLE_UNIT_TESTS
  std::cerr << doms << "\n";
#endif
  for (BasicBlock const *bb : bbs) {
    if (h.preds(bb).empty()) {
      DynBitset dom{n};
      dom.set(bb->getIndex(), true);
      doms[bb->getIndex()] = std::move(dom);
    }
  }

  bool isChanged = true;
  while (isChanged) {
#ifdef WARPO_ENABLE_UNIT_TESTS
    std::cerr << doms << "\n";
#endif
    isChanged = false;
    for (BasicBlock const *bb : bbs) {
      if (h.preds(bb).empty()) {
        // skip entry block
        continue;
      }
      DynBitset newDom = ~DynBitset{n};
      for (BasicBlock const *pred : h.preds(bb)) {
        newDom &= doms[pred->getIndex()];
      }
      size_t const index = bb->getIndex();
      newDom.set(index, true);
      if (newDom != doms[index]) {
        doms[index] = std::move(newDom);
        isChanged = true;
      }
    }
  }
  return doms;
}

namespace {
struct NormalHandler {
  std::vector<const BasicBlock *> const &preds(BasicBlock const *bb) const { return bb->preds(); }
};
struct ReverseHandler {
  // In reverse graph, successors are predecessors in the original graph.
  std::vector<const BasicBlock *> const &preds(BasicBlock const *bb) const { return bb->succs(); }
};
} // namespace
DomTree createDomTree(CFG const &cfg) {
#ifdef WARPO_ENABLE_UNIT_TESTS
  std::cerr << __PRETTY_FUNCTION__ << "\n";
#endif
  std::vector<BasicBlock const *> bbs = cfg.getReversePostOrder();
  return createDomTreeImpl(NormalHandler{}, bbs);
}
DomTree createPostDomTree(CFG const &cfg) {
#ifdef WARPO_ENABLE_UNIT_TESTS
  std::cerr << __PRETTY_FUNCTION__ << "\n";
#endif
  std::vector<BasicBlock const *> bbs = cfg.getReversePostOrderOnReverseGraph();
  return createDomTreeImpl(ReverseHandler{}, bbs);
}

} // namespace warpo::passes::dom_tree_impl

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

struct warpo::passes::BasicBlockForTest {
  static auto &index(BasicBlock &bb) { return bb.index; }
  static auto &entry(BasicBlock &bb) { return bb.entry; }
  static auto &exit(BasicBlock &bb) { return bb.exit; }
  static auto &predecessors(BasicBlock &bb) { return bb.predecessors; }
  static auto &successors(BasicBlock &bb) { return bb.successors; }
};

namespace warpo::passes::dom_tree_impl::ut {

struct DomTreeImplTest : public ::testing::Test {
  std::vector<BasicBlock> storage_{};

  size_t addBB() {
    size_t const index = storage_.size();
    storage_.emplace_back();
    BasicBlockForTest::index(storage_.back()) = index;
    return index;
  }

  void linkBBs(size_t from, size_t to) {
    BasicBlockForTest::successors(storage_[from]).push_back(&storage_[to]);
    BasicBlockForTest::predecessors(storage_[to]).push_back(&storage_[from]);
  }

  std::vector<BasicBlock const *> getBBs() const {
    return transform<BasicBlock const *>(storage_, [](BasicBlock const &bb) { return &bb; });
  }

  DynBitset createExpectDom(std::initializer_list<size_t> domIndexes) {
    DynBitset expectDom{storage_.size()};
    for (size_t domIndex : domIndexes) {
      expectDom.set(domIndex, true);
    }
    return expectDom;
  }
};

TEST_F(DomTreeImplTest, Base) {
  size_t const entry = addBB();
  size_t const exit = addBB();
  linkBBs(entry, exit);

  DomTree const domTree = createDomTreeImpl(NormalHandler{}, getBBs());
  ASSERT_EQ(domTree.size(), storage_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, exit}));

  DomTree const postDomTree = createDomTreeImpl(ReverseHandler{}, getBBs());
  ASSERT_EQ(postDomTree.size(), storage_.size());

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
  size_t const entry = addBB();
  size_t const a = addBB();
  size_t const b = addBB();
  size_t const c = addBB();
  size_t const d = addBB();
  size_t const e = addBB();
  size_t const f = addBB();
  size_t const g = addBB();
  size_t const exit = addBB();
  linkBBs(entry, a);
  linkBBs(entry, b);
  linkBBs(a, c);
  linkBBs(a, d);
  linkBBs(b, e);
  linkBBs(c, f);
  linkBBs(d, g);
  linkBBs(e, g);
  linkBBs(f, exit);
  linkBBs(g, exit);

  DomTree const domTree = createDomTreeImpl(NormalHandler{}, getBBs());
  ASSERT_EQ(domTree.size(), storage_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[a], createExpectDom({entry, a}));
  EXPECT_EQ(domTree[b], createExpectDom({entry, b}));
  EXPECT_EQ(domTree[c], createExpectDom({entry, a, c}));
  EXPECT_EQ(domTree[d], createExpectDom({entry, a, d}));
  EXPECT_EQ(domTree[e], createExpectDom({entry, b, e}));
  EXPECT_EQ(domTree[f], createExpectDom({entry, a, c, f}));
  EXPECT_EQ(domTree[g], createExpectDom({entry, g}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, exit}));

  DomTree const postDomTree = createDomTreeImpl(ReverseHandler{}, getBBs());
  ASSERT_EQ(postDomTree.size(), storage_.size());

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
  size_t const entry = addBB();
  size_t const a = addBB();
  size_t const b = addBB();
  size_t const c = addBB();
  size_t const d = addBB();
  size_t const e = addBB();
  size_t const f = addBB();
  size_t const g = addBB();
  size_t const exit = addBB();
  linkBBs(entry, a);
  linkBBs(a, b);
  linkBBs(a, c);
  linkBBs(b, d);
  linkBBs(c, e);
  linkBBs(d, g);
  linkBBs(e, f);
  linkBBs(e, g);
  linkBBs(f, c);
  linkBBs(g, exit);

  DomTree const domTree = createDomTreeImpl(NormalHandler{}, getBBs());
  ASSERT_EQ(domTree.size(), storage_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[a], createExpectDom({entry, a}));
  EXPECT_EQ(domTree[b], createExpectDom({entry, a, b}));
  EXPECT_EQ(domTree[c], createExpectDom({entry, a, c}));
  EXPECT_EQ(domTree[d], createExpectDom({entry, a, b, d}));
  EXPECT_EQ(domTree[e], createExpectDom({entry, a, c, e}));
  EXPECT_EQ(domTree[f], createExpectDom({entry, a, c, e, f}));
  EXPECT_EQ(domTree[g], createExpectDom({entry, a, g}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, a, g, exit}));

  DomTree const postDomTree = createDomTreeImpl(ReverseHandler{}, getBBs());
  ASSERT_EQ(postDomTree.size(), storage_.size());

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

} // namespace warpo::passes::dom_tree_impl::ut

#endif
