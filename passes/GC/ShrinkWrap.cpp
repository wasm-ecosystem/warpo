#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <fmt/base.h>
#include <memory>

#include "../helper/CFG.hpp"
#include "../helper/DomTree.hpp"
#include "ShrinkWrap.hpp"
#include "StackAssigner.hpp"
#include "support/Debug.hpp"
#include "support/DynBitSet.hpp"
#include "wasm.h"

#define PASS_NAME "SHRINK_WRAP"

namespace warpo::passes::gc {

static ShadowStackInsertPoint getShadowStackInsertPoint(std::string_view const funcName,
                                                        StackPosition const &stackPosition,
                                                        std::shared_ptr<CFG> const &cfg) {
  // FIXME: we do not handle noreturn function at this moment to simply implementation
  if (cfg->getExit() == nullptr)
    return {.prologue = nullptr, .epilogue = nullptr};

  DomTree const domTree = DomTree::create(cfg);

  size_t const n = cfg->size();

  DynBitset validPrologue = ~DynBitset{n};
  DynBitset validEpilogue = ~DynBitset{n};

  // collect stack positions' bb
  for (BasicBlock const &bb : *cfg) {
    for (wasm::Expression *expr : bb) {
      if (auto *call = expr->dynCast<wasm::Call>()) {
        if (stackPosition.contains(call)) {
          // prologue should dominate all stack usage
          validPrologue &= domTree.getDominators(&bb);
          // epilogue should post dominate all stack usage
          validEpilogue &= domTree.getPostDominators(&bb);
        }
      }
    }
  }
  if (support::isDebug(PASS_NAME, funcName)) {
    fmt::print("[" PASS_NAME "]: fn {}:\n - validPrologue: {}\n - validEpilogue: {}\n", funcName,
               validPrologue.toString(), validEpilogue.toString());
  }

  // remove basic block inside loop
  DynBitset const outsideLoop = ~cfg->getBlockInsideLoop();
  validPrologue &= outsideLoop;
  validEpilogue &= outsideLoop;
  if (support::isDebug(PASS_NAME, funcName)) {
    fmt::print("[" PASS_NAME "]: After skip BB inside loop, fn {}:\n - validPrologue: {}\n - validEpilogue: {}\n",
               funcName, validPrologue.toString(), validEpilogue.toString());
  }

  // shrink for entry and exit
  BasicBlock const *prologueInsertBB = cfg->getEntry();
  wasm::Expression *epilogueInsertExpr = nullptr;
  assert(validPrologue.get(prologueInsertBB->getIndex()) && "Entry block should be valid for prologue");

  auto const isFulfillRequirements = [&](BasicBlock const *prologueBB) -> bool {
    bool result = false;
    validEpilogue.forEachTrue([&](size_t epilogueIndex) {

    });
    return result;
  };

  validPrologue.forEachTrue([&](size_t prologueIndex) -> void {
    BasicBlock const *const prologueBB = &(*cfg)[prologueIndex];
    if (prologueBB->size() == 0U)
      return;
    if (prologueIndex == prologueInsertBB->getIndex())
      return;
    if (!domTree.getDominators(prologueBB).get(prologueInsertBB->getIndex()))
      return;
    for (size_t epilogueIndex = 0; epilogueIndex < n; ++epilogueIndex) {
      BasicBlock const *const epilogueBB = &(*cfg)[epilogueIndex];
      bool const isValid = domTree.getDominators(epilogueBB).get(prologueBB->getIndex()) &&
                           domTree.getPostDominators(prologueBB).get(epilogueBB->getIndex());
      if (isValid && (epilogueBB->isExit() || epilogueBB->size() > 0U)) {
        prologueInsertBB = prologueBB;
        if (epilogueBB->isExit()) {
          epilogueInsertExpr = nullptr;
        } else {
          // epilogueBB->size() > 0U
          epilogueInsertExpr = *epilogueBB->rbegin();
        }
        break;
      }
    }
  });
  return {.prologue = *prologueInsertBB->begin(), .epilogue = epilogueInsertExpr};
}

void ShrinkWrapAnalysis::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition const &stackPosition = stackPositions_.at(func);

  // no stack position, nothing to do
  if (stackPosition.empty())
    return;

  // FIXME: design framework to avoid duplicate calculate CFG
  std::shared_ptr<CFG> const cfg = std::make_shared<CFG>(CFG::fromFunction(func));

  // FIXME: we do not handle noreturn function at this moment to simply implementation
  if (cfg->getExit() == nullptr)
    return;

  DomTree const domTree = DomTree::create(cfg);

  size_t const n = cfg->size();

  DynBitset validPrologue = ~DynBitset{n};
  DynBitset validEpilogue = ~DynBitset{n};

  // collect stack positions' bb
  for (BasicBlock const &bb : *cfg) {
    for (wasm::Expression *expr : bb) {
      if (auto *call = expr->dynCast<wasm::Call>()) {
        if (stackPosition.contains(call)) {
          // prologue should dominate all stack usage
          validPrologue &= domTree.getDominators(&bb);
          // epilogue should post dominate all stack usage
          validEpilogue &= domTree.getPostDominators(&bb);
        }
      }
    }
  }
  if (support::isDebug(PASS_NAME, func->name.str)) {
    fmt::print("[" PASS_NAME "]: fn {}:\n - validPrologue: {}\n - validEpilogue: {}\n", func->name.str,
               validPrologue.toString(), validEpilogue.toString());
  }

  // remove basic block inside loop
  DynBitset const outsideLoop = ~cfg->getBlockInsideLoop();
  validPrologue &= outsideLoop;
  validEpilogue &= outsideLoop;
  if (support::isDebug(PASS_NAME, func->name.str)) {
    fmt::print("[" PASS_NAME "]: After skip BB inside loop, fn {}:\n - validPrologue: {}\n - validEpilogue: {}\n",
               func->name.str, validPrologue.toString(), validEpilogue.toString());
  }

  // shrink for entry and exit
  BasicBlock const *prologueInsertBB = cfg->getEntry();
  assert(validPrologue.get(prologueInsertBB->getIndex()) && "Entry block should be valid for prologue");

  auto const isFulfillRequirements = [&](BasicBlock const *prologueBB) -> bool {
    bool result = false;
    validEpilogue.forEachTrue([&](size_t epilogueIndex) {
      BasicBlock const *const epilogueBB = &(*cfg)[epilogueIndex];
      result |= domTree.getDominators(epilogueBB).get(prologueBB->getIndex()) &&
                domTree.getPostDominators(prologueBB).get(epilogueBB->getIndex());
    });
    return result;
  };

  validPrologue.forEachTrue([&](size_t prologueIndex) {
    if (prologueIndex == prologueInsertBB->getIndex())
      return;
    if (!domTree.getDominators(&(*cfg)[prologueIndex]).get(prologueInsertBB->getIndex()))
      return;
    if (isFulfillRequirements(&(*cfg)[prologueIndex])) {
      prologueInsertBB = &(*cfg)[prologueIndex];
    }
  });
}

} // namespace warpo::passes::gc

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "../Runner.hpp"

namespace warpo::passes::gc::ut {

TEST(ShrinkWrap, Base) {
  auto m = loadWat(R"(
      (module
        (func $base
          
        
        )
      )
    )");
}

} // namespace warpo::passes::gc::ut

#endif
