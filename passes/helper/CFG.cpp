/// copy and modify from third_party/binaryen/src/analysis/cfg.cpp

#include <algorithm>
#include <cassert>
#include <iterator>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "CFG.hpp"
#include "cfg/cfg-traversal.h"
#include "support/DynBitSet.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {

void BasicBlock::print(std::ostream &os, wasm::Module *wasm, size_t start, IInfoPrinter const &infoPrinter) const {
  os << ";; preds: [";
  for (const auto *pred : preds()) {
    if (pred != *preds().begin()) {
      os << ", ";
    }
    os << "BB" << pred->index;
  }
  os << "], succs: [";

  for (const auto *succ : succs()) {
    if (succ != *succs().begin()) {
      os << ", ";
    }
    os << "BB" << succ->index;
  }
  os << "]\n";

  os << "BB" << index << ": ;;";
  if (isEntry())
    os << "entry ";
  if (isExit())
    os << "exit ";
  os << '\n';

  size_t instIndex = start;
  for (auto *inst : *this) {
    os << "  " << instIndex++ << ": " << wasm::ShallowExpression{inst, wasm};
    std::optional<std::string> label = infoPrinter.onExpr(inst);
    if (label.has_value())
      os << " ;; " << label.value();
    os << '\n';
  }
}

CFG CFG::fromFunction(wasm::Function *func) {
  struct CFGBuilder
      : wasm::CFGWalker<CFGBuilder, wasm::UnifiedExpressionVisitor<CFGBuilder>, std::vector<wasm::Expression *>> {
    void visitExpression(wasm::Expression *curr) {
      if (currBasicBlock) {
        currBasicBlock->contents.push_back(curr);
      }
    }
  };

  CFGBuilder builder;
  builder.walkFunction(func);
  builder.unlinkDeadBlocks(builder.findLiveBlocks());

  size_t numBlocks = builder.basicBlocks.size();

  CFG cfg;
  cfg.blocks = std::vector<BasicBlock>(numBlocks);

  // From here the addresses of the new basic blocks are stable.
  std::unordered_map<CFGBuilder::BasicBlock *, BasicBlock *> oldToNewBlocks;
  for (size_t i = 0; i < numBlocks; ++i) {
    oldToNewBlocks[builder.basicBlocks[i].get()] = &cfg.blocks[i];
  }

  for (size_t i = 0; i < numBlocks; ++i) {
    auto &oldBlock = *builder.basicBlocks[i];
    auto &newBlock = cfg.blocks[i];
    newBlock.index = i;
    newBlock.insts = std::move(oldBlock.contents);
    newBlock.predecessors.reserve(oldBlock.in.size());
    for (auto *oldPred : oldBlock.in) {
      newBlock.predecessors.push_back(oldToNewBlocks.at(oldPred));
    }
    newBlock.successors.reserve(oldBlock.out.size());
    for (auto *oldSucc : oldBlock.out) {
      newBlock.successors.push_back(oldToNewBlocks.at(oldSucc));
    }
  }

  assert(!cfg.blocks.empty());
  cfg.blocks[0].entry = true;
  if (builder.exit) {
    oldToNewBlocks.at(builder.exit)->exit = true;
  }

  // Move-construct a new CFG to get mandatory copy elision, preserving basic
  // block addresses through the return.
  return CFG(std::move(cfg));
}

void CFG::print(std::ostream &os, wasm::Module *wasm, IInfoPrinter const &infoPrinter) const {
  size_t start = 0;
  for (auto &block : *this) {
    if (&block != &*begin()) {
      os << '\n';
    }
    block.print(os, wasm, start, infoPrinter);
    start += block.size();
  }
}

template <class Parent> class PostOrderActorBase {
  DynBitset visited_;
  std::vector<BasicBlock const *> postOrder_;

public:
  explicit PostOrderActorBase(size_t n) : visited_(n), postOrder_{} { postOrder_.reserve(n); }
  void action(BasicBlock const &bb) {
    size_t const index = bb.getIndex();
    if (visited_.get(index))
      return;
    visited_.set(index, true);
    for (BasicBlock const *succ : Parent::getSuccs(bb)) {
      action(*succ);
    }
    postOrder_.push_back(&bb);
  }

  std::vector<BasicBlock const *> getReserverPostOrder() const {
    std::vector<BasicBlock const *> ret{};
    ret.reserve(postOrder_.size());
    std::reverse_copy(postOrder_.begin(), postOrder_.end(), std::back_inserter(ret));
    return ret;
  }
};

std::vector<BasicBlock const *> CFG::getReversePostOrder() const {
  size_t const n = size();
  std::vector<BasicBlock> postOrder{};
  postOrder.reserve(n);

  struct PostOrderActor : public PostOrderActorBase<PostOrderActor> {
    static std::vector<BasicBlock const *> const &getSuccs(BasicBlock const &bb) { return bb.succs(); }
    using PostOrderActorBase::PostOrderActorBase;
  };

  PostOrderActor actor{n};
  for (BasicBlock const &bb : *this) {
    if (bb.preds().empty()) {
      actor.action(bb);
    }
  }
  return actor.getReserverPostOrder();
}

std::vector<BasicBlock const *> CFG::getReversePostOrderOnReverseGraph() const {
  size_t const n = size();
  std::vector<BasicBlock> postOrder{};
  postOrder.reserve(n);

  struct PostOrderActor : public PostOrderActorBase<PostOrderActor> {
    static std::vector<BasicBlock const *> const &getSuccs(BasicBlock const &bb) { return bb.preds(); }
    using PostOrderActorBase::PostOrderActorBase;
  };

  PostOrderActor actor{n};
  for (BasicBlock const &bb : *this) {
    if (bb.isExit()) {
      actor.action(bb);
    }
  }
  return actor.getReserverPostOrder();
}

DynBitset CFG::getBlockInsideLoop() const {
  if (blocks.empty())
    return DynBitset{0U};

  struct BasicBlockDeepFirstVisitor {
    DynBitset active_;
    std::vector<BasicBlock const *> stack_;
    DynBitset insideLoop_;

    explicit BasicBlockDeepFirstVisitor(size_t size) : active_(size), insideLoop_(size) {}
    void visit(BasicBlock const *bb) {
      active_.set(bb->getIndex(), true);
      stack_.push_back(bb);
      for (BasicBlock const *succ : bb->succs()) {
        // back edge means loop, back edge targeted bb is loop entry
        if (active_.get(succ->getIndex()))
          markLoop(succ);
        else
          visit(succ);
      }
    }

  private:
    void markLoop(BasicBlock const *loopEntry) {
      auto it = std::find(stack_.begin(), stack_.end(), loopEntry);
      assert(it != stack_.end());
      for (; it != stack_.end(); ++it)
        insideLoop_.set((*it)->getIndex(), true);
    }
  };
  BasicBlockDeepFirstVisitor visitor{size()};
  assert(blocks[0].isEntry());
  visitor.visit(&blocks[0]);

  return visitor.insideLoop_;
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

namespace warpo::passes::ut {

TEST(CFGTest, getBlockInsideLoop) {
  CFGTestWrapper cfg{};
  /*
        entry
        /   \
       a    b<--|
       |    |   e
       c    d---|
  */
  size_t a = cfg.addBB();
  size_t b = cfg.addBB();
  size_t c = cfg.addBB();
  size_t d = cfg.addBB();
  size_t e = cfg.addBB();

  cfg.linkBBs(cfg.entry_, a);
  cfg.linkBBs(a, c);
  cfg.linkBBs(cfg.entry_, b);
  cfg.linkBBs(b, d);
  cfg.linkBBs(d, e);
  cfg.linkBBs(e, b);

  DynBitset const insideLoop = cfg.raw_.getBlockInsideLoop();
  ASSERT_EQ(insideLoop.size(), cfg.size());

  EXPECT_FALSE(insideLoop.get(a));
  EXPECT_FALSE(insideLoop.get(c));

  EXPECT_TRUE(insideLoop.get(b));
  EXPECT_TRUE(insideLoop.get(d));
  EXPECT_TRUE(insideLoop.get(e));
}

} // namespace warpo::passes::ut

#endif // WARPO_ENABLE_UNIT_TESTS
