
#include <cassert>
#include <cstddef>
#include <iostream>
#include <vector>

#include "CFG.hpp"
#include "DomTreeImpl.hpp"
#include "support/DynBitSet.hpp"

namespace warpo::passes::dom_tree_impl {

namespace {
template <class Handler>
concept IsHandler = requires(Handler h, BasicBlock const *bb) {
  { h.preds(bb) } -> std::same_as<std::vector<const BasicBlock *> const &>;
};

} // namespace

template <IsHandler Handler> ImmediateDomTree createDomTreeImpl(Handler h, std::vector<BasicBlock const *> const &bbs) {
  // http://www.hipersoft.rice.edu/grads/publications/dom14.pdf
  auto const isStartNode = [&h](BasicBlock const *bb) { return h.preds(bb).empty(); };

  const size_t n = bbs.size();
  constexpr size_t undef = -1;
  ImmediateDomTree idoms{}; // index is BasicBlock::getIndex()

  std::vector<size_t> indexToSequenceIndex{}; // index is BasicBlock::getIndex()
  indexToSequenceIndex.resize(n, 0);
  for (size_t i = 0; i < n; i++)
    indexToSequenceIndex[bbs[i]->getIndex()] = i;
#ifdef WARPO_ENABLE_UNIT_TESTS
  std::cerr << "indexToSequenceIndex: ";
  for (size_t i = 0; i < n; i++)
    std::cerr << indexToSequenceIndex[i] << " ";
  std::cerr << std::endl;
#endif
  auto const lessThan = [&indexToSequenceIndex](size_t a, size_t b) -> bool {
    return indexToSequenceIndex[a] < indexToSequenceIndex[b];
  };

  auto const dump =
#ifdef WARPO_ENABLE_UNIT_TESTS
      [&idoms]() {
        for (size_t i = 0; i < idoms.size(); ++i) {
          std::cerr << "idoms[" << i << "]";
          if (idoms[i] == undef)
            std::cerr << "undef";
          else
            std::cerr << idoms[i];
          std::cerr << " ";
        }
        std::cerr << "\n";
      };
#else
      []() {};
#endif

  idoms.resize(n, undef);
  for (BasicBlock const *bb : bbs) {
    if (isStartNode(bb))
      idoms[bb->getIndex()] = bb->getIndex();
  }

  bool isChanged = true;
  while (isChanged) {
    dump();
    isChanged = false;
    for (BasicBlock const *bb : bbs) {
      if (isStartNode(bb)) {
        // skip start node
        continue;
      }
      size_t newIdom = undef;
      for (BasicBlock const *pred : h.preds(bb)) {
        size_t const predIndex = pred->getIndex();
        if (idoms[predIndex] == undef)
          continue;
        // pred is calculated
        if (newIdom == undef) {
          newIdom = predIndex;
        } else {
          size_t finger1 = predIndex;
          size_t finger2 = newIdom;
          while (finger1 != finger2) {
            while (lessThan(finger2, finger1)) {
              finger1 = idoms[finger1];
            }
            while (lessThan(finger1, finger2)) {
              finger2 = idoms[finger2];
            }
          }
          newIdom = finger1;
        }
      }
      size_t const index = bb->getIndex();
      if (idoms[index] != newIdom) {
        idoms[index] = newIdom;
        isChanged = true;
      }
    }
  }
  return idoms;
}

DomTree ImmediateDomTree::toDomTree() const {
  size_t const n = this->size();
  DomTree doms{};
  doms.resize(n, DynBitset{n});
  for (size_t index = 0; index < n; ++index) {
    size_t idomIndex = index;
    while (true) {
      doms[index].set(idomIndex, true);
      // stop loop when idom is itself (start node)
      if (idomIndex == (*this)[idomIndex])
        break;
      idomIndex = (*this)[idomIndex];
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
} // namespace warpo::passes::dom_tree_impl

warpo::passes::dom_tree_impl::ImmediateDomTree warpo::passes::dom_tree_impl::createDomTree(CFG const &cfg) {
#ifdef WARPO_ENABLE_UNIT_TESTS
  std::cerr << __PRETTY_FUNCTION__ << "\n";
#endif
  std::vector<BasicBlock const *> bbs = cfg.getReversePostOrder();
  return createDomTreeImpl(NormalHandler{}, bbs);
}
warpo::passes::dom_tree_impl::ImmediateDomTree warpo::passes::dom_tree_impl::createPostDomTree(CFG const &cfg) {
#ifdef WARPO_ENABLE_UNIT_TESTS
  std::cerr << __PRETTY_FUNCTION__ << "\n";
#endif
  std::vector<BasicBlock const *> bbs = cfg.getReversePostOrderOnReverseGraph();
  return createDomTreeImpl(ReverseHandler{}, bbs);
}

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

namespace warpo::passes::dom_tree_impl::ut {

struct DomTreeImplTest : public ::testing::Test {
  CFG cfg_{};

  size_t size() { return CFGForTest::blocks(cfg_).size(); }

  size_t addBB() {
    size_t const index = size();
    CFGForTest::blocks(cfg_).emplace_back();
    BasicBlockForTest::index(CFGForTest::blocks(cfg_).back()) = index;
    return index;
  }

  void linkBBs(size_t from, size_t to) {
    BasicBlockForTest::successors(CFGForTest::blocks(cfg_)[from]).push_back(&CFGForTest::blocks(cfg_)[to]);
    BasicBlockForTest::predecessors(CFGForTest::blocks(cfg_)[to]).push_back(&CFGForTest::blocks(cfg_)[from]);
  }

  DynBitset createExpectDom(std::initializer_list<size_t> domIndexes) {
    DynBitset expectDom{CFGForTest::blocks(cfg_).size()};
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

  DomTree const domTree = createDomTree(cfg_).toDomTree();
  ASSERT_EQ(domTree.size(), size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, exit}));

  DomTree const postDomTree = createPostDomTree(cfg_).toDomTree();
  ASSERT_EQ(postDomTree.size(), size());

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

  DomTree const domTree = createDomTree(cfg_).toDomTree();
  ASSERT_EQ(domTree.size(), size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[a], createExpectDom({entry, a}));
  EXPECT_EQ(domTree[b], createExpectDom({entry, b}));
  EXPECT_EQ(domTree[c], createExpectDom({entry, a, c}));
  EXPECT_EQ(domTree[d], createExpectDom({entry, a, d}));
  EXPECT_EQ(domTree[e], createExpectDom({entry, b, e}));
  EXPECT_EQ(domTree[f], createExpectDom({entry, a, c, f}));
  EXPECT_EQ(domTree[g], createExpectDom({entry, g}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, exit}));

  DomTree const postDomTree = createPostDomTree(cfg_).toDomTree();
  ASSERT_EQ(postDomTree.size(), size());

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

  DomTree const domTree = createDomTree(cfg_).toDomTree();
  ASSERT_EQ(domTree.size(), size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[a], createExpectDom({entry, a}));
  EXPECT_EQ(domTree[b], createExpectDom({entry, a, b}));
  EXPECT_EQ(domTree[c], createExpectDom({entry, a, c}));
  EXPECT_EQ(domTree[d], createExpectDom({entry, a, b, d}));
  EXPECT_EQ(domTree[e], createExpectDom({entry, a, c, e}));
  EXPECT_EQ(domTree[f], createExpectDom({entry, a, c, e, f}));
  EXPECT_EQ(domTree[g], createExpectDom({entry, a, g}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, a, g, exit}));

  DomTree const postDomTree = createPostDomTree(cfg_).toDomTree();
  ASSERT_EQ(postDomTree.size(), size());

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
