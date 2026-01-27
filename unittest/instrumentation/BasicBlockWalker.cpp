#include "BasicBlockWalker.hpp"
#include <algorithm>
#include <cfg/cfg-traversal.h>
#include <iostream>
#include <memory>
#include <set>
#include <utility>
#include <wasm.h>
#include "ir/branch-utils.h"

namespace wasmInstrumentation {

void BasicBlockWalker::basicBlockWalk() noexcept {
  // Iterate DefinedFunctions, generate coverage infos
  wasm::ModuleUtils::iterDefinedFunctions(*module, [this](wasm::Function *const func) noexcept {
    if ((!func->debugLocations.empty()) && basicBlockAnalysis.shouldIncludeFile(func->name.str)) {
      walkFunctionInModule(func, module);
    }
  });
}

void BasicBlockWalker::visitExpression(wasm::Expression *curr) noexcept {
  if (currBasicBlock == nullptr || curr->is<wasm::Block>()) {
    return;
  }
  // push information
  wasm::Function *const currFun = getFunction();
  currBasicBlock->contents.exprs.push_back(curr);
  const auto debugLocationIterator = currFun->debugLocations.find(curr);
  if (debugLocationIterator != currFun->debugLocations.cend()) {
    const auto &debugLocation = debugLocationIterator->second;
    currBasicBlock->contents.debugLocations.insert(debugLocation);
  }
}

void BasicBlockWalker::doEndBlock(BasicBlockWalker *self, wasm::Expression **currp) {
  wasm::CFGWalker<BasicBlockWalker, wasm::UnifiedExpressionVisitor<BasicBlockWalker>,
  BasicBlockInfo>::doEndBlock(self, currp);
  if (self->currBasicBlock != nullptr) {
    self->currBasicBlock->contents.exprs.push_back(*currp);
  }
}

static bool
isBasicBlockContainUnreachable(BasicBlockWalker::BasicBlock &block,
                               std::set<BasicBlockWalker::BasicBlock *> unreachableBlocks) {
  return (!block.contents.exprs.empty() &&
          std::any_of(block.contents.exprs.begin(), block.contents.exprs.end(),
                      [](wasm::Expression *expr) {
                        return expr->is<wasm::Unreachable>();
                      })) ||
         (!block.in.empty() &&
          std::all_of(block.in.begin(), block.in.end(),
                      [&unreachableBlocks](BasicBlockWalker::BasicBlock *inBlock) {
                        return unreachableBlocks.find(inBlock) != unreachableBlocks.end();
                      }));
};

static void removeDuplicates(std::vector<BasicBlockWalker::BasicBlock *> &list) {
  std::sort(list.begin(), list.end());
  list.erase(std::unique(list.begin(), list.end()), list.end());
}

void BasicBlockWalker::cleanBlock() noexcept {
  bool isModified = true;
  std::set<BasicBlock *> unreachableBlocks{};
  while (isModified) {
    isModified = false;
    for (auto &block : basicBlocks) {
      if (isBasicBlockContainUnreachable(*block, unreachableBlocks)) {
        isModified |= unreachableBlocks.insert(block.get()).second;
      }
    }
  }
  std::set<BasicBlock *> emptyBlocks{};
  for (auto &block : basicBlocks) {
    if (block->contents.exprs.empty() && block->out.size() == 1) {
      emptyBlocks.insert(block.get());
    }
  }

  std::set<BasicBlock *> targetCleanBlocks{};
  targetCleanBlocks.insert(unreachableBlocks.begin(), unreachableBlocks.end());
  targetCleanBlocks.insert(emptyBlocks.begin(), emptyBlocks.end());

  for (auto &block : targetCleanBlocks) {
    for (auto &outBlock : block->out) {
      outBlock->in.erase(std::find(outBlock->in.begin(), outBlock->in.end(), block));
      outBlock->in.insert(outBlock->in.end(), block->in.begin(), block->in.end());
      removeDuplicates(outBlock->in);
    }
    for (auto &inBlock : block->in) {
      inBlock->out.erase(std::find(inBlock->out.begin(), inBlock->out.end(), block));
      inBlock->out.insert(inBlock->out.end(), block->out.begin(), block->out.end());
      removeDuplicates(inBlock->out);
    }
    block->in.clear();
    block->out.clear();
    basicBlocks.erase(std::find_if(basicBlocks.begin(), basicBlocks.end(),
                                   [&block](std::unique_ptr<BasicBlock> const &b) -> bool {
                                     return b.get() == block;
                                   }));
  }
}

void BasicBlockWalker::doWalkFunction(wasm::Function *const func) noexcept {
  wasm::CFGWalker<BasicBlockWalker, wasm::UnifiedExpressionVisitor<BasicBlockWalker>,
                  BasicBlockInfo>::doWalkFunction(func);
  cleanBlock();
  // LCOV_EXCL_START
  if (basicBlocks.size() > UINT32_MAX) {
    std::cerr << "Error: BasicBlocks length exceeds UINT32_MAX\n";
    ::exit(EXIT_FAILURE);
  }
  // LCOV_EXCL_STOP
  for (size_t i = 0; i < basicBlocks.size(); i++) {
    basicBlocks[i]->contents.basicBlockIndex = static_cast<wasm::Index>(i);
  }

  FunctionAnalysisResult analysisResult;
  analysisResult.functionIndex = functionIndex;
  functionIndex++;
  for (const auto &basicBlock : basicBlocks) {
    const wasm::Index currBasicBlockIndex = basicBlock->contents.basicBlockIndex;
    // Generate Branch coverage info
    if (basicBlock->out.size() > 1U) {
      for (const auto &out : basicBlock->out) {
        analysisResult.branchInfo.emplace_back(currBasicBlockIndex, out->contents.basicBlockIndex);
      }
    }
    // Generate Line coverage info
    analysisResult.basicBlocks.push_back(basicBlock->contents);

    // Generate CovInstrument position
    if (exit != nullptr && currBasicBlockIndex == exit->contents.basicBlockIndex) {
      // For exit basicBlock, we instrument at the end of function
      setCovInstrumentPosition(func->body, {currBasicBlockIndex, false});
      continue;
    }
    wasm::Expression *expr = nullptr;
    bool pre = false;
    if (basicBlock->contents.exprs.empty()) {
      for (const auto &inBlock : basicBlock->in) {
        assert(!inBlock->contents.exprs.empty());
        setCovInstrumentPosition(inBlock->contents.exprs.back(), {currBasicBlockIndex, false});
      }
    } else {
      wasm::Expression *const lastExpression = basicBlock->contents.exprs.back();
      if (lastExpression->is<wasm::Return>() || lastExpression->is<wasm::Break>() ||
          lastExpression->is<wasm::Switch>()) {
        if (basicBlock->contents.exprs.size() == 1U) {
          expr = lastExpression;
          pre = true;
        } else {
          expr = basicBlock->contents.exprs[basicBlock->contents.exprs.size() - 2];
        }
      } else if (lastExpression->is<wasm::Block>() && basicBlock->contents.exprs.size() > 1U) {
        // Special treatment for for-loop-continue case.
        expr = basicBlock->contents.exprs[basicBlock->contents.exprs.size() - 2];
      } else {
        expr = lastExpression;
      }

      setCovInstrumentPosition(expr, {currBasicBlockIndex, pre});
    }
  }
  this->results[func->name.str] = std::move(analysisResult);
}

wasm::Index
BasicBlockWalker::getFunctionIndexByName(const std::string_view &funcName) const noexcept {
  const auto functionResultIterator = results.find(funcName);
  if (functionResultIterator != results.cend()) {
    return functionResultIterator->second.functionIndex;
  }
  return static_cast<wasm::Index>(-1);
}

void BasicBlockWalker::setCovInstrumentPosition(wasm::Expression *const expr,
                                                const InstrumentPosition &position) noexcept {
  auto positions = covInstrumentPosition.find(expr);
  if (positions != covInstrumentPosition.end()) {
    positions->second.emplace_back(position);
  } else {
    covInstrumentPosition.emplace(expr, std::vector<InstrumentPosition>{position});
  }
}

const std::vector<InstrumentPosition> *
BasicBlockWalker::getCovInstrumentPosition(wasm::Expression *const expr) const noexcept {
  const auto iterator = covInstrumentPosition.find(expr);
  if (iterator != covInstrumentPosition.cend()) {
    return &(iterator->second);
  }
  return nullptr;
}

BasicBlockAnalysis BasicBlockWalker::getBasicBlockAnalysis() const noexcept {
  return basicBlockAnalysis;
}

} // namespace wasmInstrumentation
