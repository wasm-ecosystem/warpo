#ifdef WARPO_ENABLE_UNIT_TESTS

#include <cassert>
#include <cstddef>
#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <initializer_list>
#include <vector>

#include "DomTreeImpl.hpp"
#include "support/DynBitSet.hpp"

namespace warpo::passes::dom_tree_impl::ut {
namespace {
struct TestBB {
  using reference_type = TestBB const *;
  size_t id_;
  std::vector<reference_type> in_;
  std::vector<reference_type> out_;
  bool isEntry_ = false;
  bool isExit_ = false;
  std::vector<reference_type> const &preds() const { return in_; }
  std::vector<reference_type> const &succs() const { return out_; }
  bool isEntry() const { return isEntry_; }
  bool isExit() const { return isExit_; }
  size_t getId() const { return id_; }
};

static_assert(IsDomTreeBB<TestBB>, "");
static_assert(IsPostDomTreeBB<TestBB>, "");
static_assert(IsDomTreeBB<PostDomTreeBB<TestBB>>, "PostDomTree still fullfull the DomTreeBB concept");

struct DomTreeImplTest : public ::testing::Test {
  std::vector<TestBB> bbs_{};

  size_t addBB() {
    size_t const index = bbs_.size();
    bbs_.emplace_back(TestBB{.id_ = index, .in_ = {}, .out_ = {}, .isEntry_ = false, .isExit_ = false});
    return index;
  }
  size_t addEntryBB() {
    size_t const index = bbs_.size();
    bbs_.emplace_back(TestBB{.id_ = index, .in_ = {}, .out_ = {}, .isEntry_ = true, .isExit_ = false});
    return index;
  }
  size_t addExitBB() {
    size_t const index = bbs_.size();
    bbs_.emplace_back(TestBB{.id_ = index, .in_ = {}, .out_ = {}, .isEntry_ = false, .isExit_ = true});
    return index;
  }

  void linkBBs(size_t from, size_t to) {
    assert(from < bbs_.size() && to < bbs_.size());
    bbs_[from].out_.push_back(&bbs_[to]);
    bbs_[to].in_.push_back(&bbs_[from]);
  }

  DynBitset createExpectDom(std::initializer_list<size_t> domIndexes) {
    DynBitset expectDom{bbs_.size()};
    for (size_t domIndex : domIndexes) {
      expectDom.set(domIndex, true);
    }
    return expectDom;
  }
};
} // namespace

TEST_F(DomTreeImplTest, Base) {
  size_t const entry = addEntryBB();
  size_t const exit = addExitBB();
  linkBBs(entry, exit);

  DomTree const domTree = createDomTree(bbs_);
  ASSERT_EQ(domTree.size(), bbs_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, exit}));

  DomTree const postDomTree = createPostDomTree(bbs_);
  ASSERT_EQ(postDomTree.size(), bbs_.size());

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
  size_t const entry = addEntryBB();
  size_t const a = addBB();
  size_t const b = addBB();
  size_t const c = addBB();
  size_t const d = addBB();
  size_t const e = addBB();
  size_t const f = addBB();
  size_t const g = addBB();
  size_t const exit = addExitBB();
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

  DomTree const domTree = createDomTree(bbs_);
  ASSERT_EQ(domTree.size(), bbs_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[a], createExpectDom({entry, a}));
  EXPECT_EQ(domTree[b], createExpectDom({entry, b}));
  EXPECT_EQ(domTree[c], createExpectDom({entry, a, c}));
  EXPECT_EQ(domTree[d], createExpectDom({entry, a, d}));
  EXPECT_EQ(domTree[e], createExpectDom({entry, b, e}));
  EXPECT_EQ(domTree[f], createExpectDom({entry, a, c, f}));
  EXPECT_EQ(domTree[g], createExpectDom({entry, g}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, exit}));

  DomTree const postDomTree = createPostDomTree(bbs_);
  ASSERT_EQ(postDomTree.size(), bbs_.size());

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
  size_t const entry = addEntryBB();
  size_t const a = addBB();
  size_t const b = addBB();
  size_t const c = addBB();
  size_t const d = addBB();
  size_t const e = addBB();
  size_t const f = addBB();
  size_t const g = addBB();
  size_t const exit = addExitBB();
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

  DomTree const domTree = createDomTree(bbs_);
  ASSERT_EQ(domTree.size(), bbs_.size());

  EXPECT_EQ(domTree[entry], createExpectDom({entry}));
  EXPECT_EQ(domTree[a], createExpectDom({entry, a}));
  EXPECT_EQ(domTree[b], createExpectDom({entry, a, b}));
  EXPECT_EQ(domTree[c], createExpectDom({entry, a, c}));
  EXPECT_EQ(domTree[d], createExpectDom({entry, a, b, d}));
  EXPECT_EQ(domTree[e], createExpectDom({entry, a, c, e}));
  EXPECT_EQ(domTree[f], createExpectDom({entry, a, c, e, f}));
  EXPECT_EQ(domTree[g], createExpectDom({entry, a, g}));
  EXPECT_EQ(domTree[exit], createExpectDom({entry, a, g, exit}));

  DomTree const postDomTree = createPostDomTree(bbs_);
  ASSERT_EQ(postDomTree.size(), bbs_.size());

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
