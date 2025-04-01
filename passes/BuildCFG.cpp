/// copy and modify from third_party/binaryen/src/analysis/cfg.cpp

#include "BuildCFG.hpp"
#include "cfg/cfg-traversal.h"
#include "wasm-traversal.h"

namespace warpo::passes {

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

} // namespace warpo::passes
