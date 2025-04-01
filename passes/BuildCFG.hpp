/// copy and modify from third_party/binaryen/src/analysis/cfg.h

#pragma once

#include "wasm.h"

namespace warpo::passes {

struct CFG;

struct BasicBlock {
  using iterator = std::vector<wasm::Expression *>::const_iterator;
  // Iterate through instructions.
  iterator begin() const { return insts.cbegin(); }
  iterator end() const { return insts.cend(); }
  size_t size() const { return insts.size(); }

  using reverse_iterator = std::vector<wasm::Expression *>::const_reverse_iterator;
  reverse_iterator rbegin() const { return insts.rbegin(); }
  reverse_iterator rend() const { return insts.rend(); }

  const std::vector<const BasicBlock *> &preds() const { return predecessors; }
  const std::vector<const BasicBlock *> &succs() const { return successors; }

  wasm::Index getIndex() const { return index; }

  bool isEntry() const { return entry; }
  bool isExit() const { return exit; }

private:
  wasm::Index index;
  bool entry = false;
  bool exit = false;
  std::vector<wasm::Expression *> insts;
  std::vector<const BasicBlock *> predecessors;
  std::vector<const BasicBlock *> successors;

  friend CFG;
};

struct CFG {
  // Iterate through basic blocks.
  using iterator = std::vector<BasicBlock>::const_iterator;
  iterator begin() const { return blocks.cbegin(); }
  iterator end() const { return blocks.cend(); }
  size_t size() const { return blocks.size(); }

  using reverse_iterator = std::vector<BasicBlock>::const_reverse_iterator;
  reverse_iterator rbegin() const { return blocks.rbegin(); }
  reverse_iterator rend() const { return blocks.rend(); }

  const BasicBlock &operator[](size_t i) const { return *(begin() + i); }

  static CFG fromFunction(wasm::Function *func);

private:
  std::vector<BasicBlock> blocks;

  friend BasicBlock;
};

} // namespace warpo::passes
