/// copy and modify from third_party/binaryen/src/analysis/cfg.cpp

#include <algorithm>
#include <iterator>
#include <optional>
#include <string>
#include <utility>

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
    if (bb.isEntry()) {
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
    if (bb.succs().empty()) {
      actor.action(bb);
    }
  }
  return actor.getReserverPostOrder();
}

} // namespace warpo::passes
