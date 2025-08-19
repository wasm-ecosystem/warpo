#include <array>
#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <fmt/base.h>
#include <map>
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

static StackInsertPoint getShadowStackInsertPoint(std::string_view const funcName, StackPosition const &stackPosition,
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
    fmt::print("[" PASS_NAME "] fn {}:\n - validPrologue: {}\n - validEpilogue: {}\n", funcName,
               validPrologue.toString(), validEpilogue.toString());
  }

  // remove basic block inside loop
  DynBitset const outsideLoop = ~cfg->getBlockInsideLoop();
  validPrologue &= outsideLoop;
  validEpilogue &= outsideLoop;
  if (support::isDebug(PASS_NAME, funcName)) {
    fmt::println("[" PASS_NAME "] After skip BB inside loop, fn {}:", funcName);
    fmt::println(" - validPrologue: {}", validPrologue.toString());
    fmt::println(" - validEpilogue: {}", validEpilogue.toString());
  }

  // shrink for entry and exit
  BasicBlock const *prologueInsertBB = cfg->getEntry();
  wasm::Expression *epilogueInsertExpr = nullptr;
  assert(validPrologue.get(prologueInsertBB->getIndex()) && "Entry block should be valid for prologue");

  if (support::isDebug(PASS_NAME, funcName)) {
    validEpilogue.forEachTrue([&](size_t epilogueIndex) {
      fmt::println("[" PASS_NAME "] dom of epilogue candidate: BB{}: {}", epilogueIndex,
                   domTree.getDominators(&(*cfg)[epilogueIndex]).toString());
    });
  }
  validPrologue.forEachTrue([&](size_t prologueIndex) -> void {
    BasicBlock const *const prologueBB = &(*cfg)[prologueIndex];
    if (prologueBB->size() == 0U)
      return;
    if (prologueIndex == prologueInsertBB->getIndex())
      return;
    if (!domTree.getDominators(prologueBB).get(prologueInsertBB->getIndex()))
      return;
    for (size_t epilogueIndex = 0; epilogueIndex < n; ++epilogueIndex) {
      if (!validEpilogue.get(epilogueIndex))
        continue;
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
  if (prologueInsertBB == cfg->getEntry()) {
    return {.prologue = nullptr, .epilogue = nullptr};
  }
  assert(prologueInsertBB->size() > 0);
  return {.prologue = *prologueInsertBB->begin(), .epilogue = epilogueInsertExpr};
}

void ShrinkWrapAnalysis::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition const &stackPosition = stackPositions_->at(func);

  // no stack position, nothing to do
  if (stackPosition.empty())
    return;

  // FIXME: design framework to avoid duplicate calculate CFG
  std::shared_ptr<CFG> const cfg = std::make_shared<CFG>(CFG::fromFunction(func));
  StackInsertPoint const stackInsertPoint = getShadowStackInsertPoint(func->name.str, stackPosition, cfg);
  shadowStackPoints_->insert_or_assign(func, stackInsertPoint);
}

} // namespace warpo::passes::gc

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

namespace warpo::passes::gc::ut {

struct ShrinkWrapTest : public ::testing::Test {
  CFGTestWrapper cfg{};
  StackPosition stackPosition{};
  MixedArena arena{};
  std::map<size_t, std::array<wasm::Call *, 2U>> callMap;

  void applyWasmCallForEachBB() {
    for (size_t i = 0; i < cfg.raw_.size(); i++) {
      wasm::Call *const beginCall = new wasm::Call{arena};
      wasm::Call *const endCall = new wasm::Call{arena};
      cfg.addExpr(beginCall, i);
      cfg.addExpr(endCall, i);
      callMap.insert_or_assign(i, std::array<wasm::Call *, 2U>{beginCall, endCall});
      fmt::println("added calls for basic block[{}] {} - {}", i, static_cast<void *>(beginCall),
                   static_cast<void *>(endCall));
    }
  }
};

TEST_F(ShrinkWrapTest, SingleBB) {
  support::ForceEnableRAII const forceEnableRAII{true};
  /*
          Entry
          /   \
         a     b
         |     |
         |     c <- use shadowstack
         |    /
         Exit
  */
  size_t const a = cfg.addBB();
  size_t const b = cfg.addBB();
  size_t const c = cfg.addBB();
  size_t const exit = cfg.addExitBB();
  cfg.linkBBs(cfg.entry_, a);
  cfg.linkBBs(a, exit);
  cfg.linkBBs(cfg.entry_, b);
  cfg.linkBBs(b, c);
  cfg.linkBBs(c, exit);

  applyWasmCallForEachBB();
  stackPosition.insert_or_assign(callMap[c][0], 0U);

  StackInsertPoint const shadowStackInsertPoint =
      getShadowStackInsertPoint("test", stackPosition, std::make_shared<CFG>(cfg.raw_));

  EXPECT_EQ(shadowStackInsertPoint.prologue, callMap.at(c)[0]);
  EXPECT_EQ(shadowStackInsertPoint.epilogue, callMap.at(c)[1]);
}

TEST_F(ShrinkWrapTest, SequenceBB) {
  support::ForceEnableRAII const forceEnableRAII{true};
  /*
          Entry
          /   \
         a     b <- use shadowstack
         |     |
         |     c <- use shadowstack
         |    /
         Exit
  */
  size_t const a = cfg.addBB();
  size_t const b = cfg.addBB();
  size_t const c = cfg.addBB();
  size_t const exit = cfg.addExitBB();
  cfg.linkBBs(cfg.entry_, a);
  cfg.linkBBs(a, exit);
  cfg.linkBBs(cfg.entry_, b);
  cfg.linkBBs(b, c);
  cfg.linkBBs(c, exit);

  applyWasmCallForEachBB();
  stackPosition.insert_or_assign(callMap[b][0], 0U);
  stackPosition.insert_or_assign(callMap[c][0], 0U);

  StackInsertPoint const shadowStackInsertPoint =
      getShadowStackInsertPoint("test", stackPosition, std::make_shared<CFG>(cfg.raw_));

  EXPECT_EQ(shadowStackInsertPoint.prologue, callMap.at(b)[0]);
  EXPECT_EQ(shadowStackInsertPoint.epilogue, callMap.at(c)[1]);
}

TEST_F(ShrinkWrapTest, DifferentBranch) {
  support::ForceEnableRAII const forceEnableRAII{true};
  /*
                     Entry
                     /   \
                    a     b
                    |     |
 use shadowstack -> c     d <- use shadowstack
                    |    /
                    Exit
  */
  size_t const a = cfg.addBB();
  size_t const b = cfg.addBB();
  size_t const c = cfg.addBB();
  size_t const d = cfg.addBB();
  size_t const exit = cfg.addExitBB();
  cfg.linkBBs(cfg.entry_, a);
  cfg.linkBBs(a, c);
  cfg.linkBBs(cfg.entry_, b);
  cfg.linkBBs(b, d);
  cfg.linkBBs(c, exit);
  cfg.linkBBs(d, exit);

  applyWasmCallForEachBB();
  stackPosition.insert_or_assign(callMap[c][0], 0U);
  stackPosition.insert_or_assign(callMap[d][0], 0U);

  StackInsertPoint const shadowStackInsertPoint =
      getShadowStackInsertPoint("test", stackPosition, std::make_shared<CFG>(cfg.raw_));

  EXPECT_EQ(shadowStackInsertPoint.prologue, callMap.at(cfg.entry_)[0]);
  EXPECT_EQ(shadowStackInsertPoint.epilogue, nullptr);
}

TEST_F(ShrinkWrapTest, Loop) {
  support::ForceEnableRAII const forceEnableRAII{true};
  /*
          Entry
            |
            e
          /    \
         a  |-> b
         |  |   |
         |  |- c <- use shadowstack
         \     /
           Exit
  */
  size_t const e = cfg.addBB();
  size_t const a = cfg.addBB();
  size_t const b = cfg.addBB();
  size_t const c = cfg.addBB();
  size_t const exit = cfg.addExitBB();
  cfg.linkBBs(cfg.entry_, e);
  cfg.linkBBs(e, a);
  cfg.linkBBs(a, exit);
  cfg.linkBBs(e, b);
  cfg.linkBBs(b, c);
  cfg.linkBBs(c, b);
  cfg.linkBBs(c, exit);

  applyWasmCallForEachBB();
  stackPosition.insert_or_assign(callMap[c][0], 0U);

  StackInsertPoint const shadowStackInsertPoint =
      getShadowStackInsertPoint("test", stackPosition, std::make_shared<CFG>(cfg.raw_));

  EXPECT_EQ(shadowStackInsertPoint.prologue, callMap.at(e)[0]);
  EXPECT_EQ(shadowStackInsertPoint.epilogue, nullptr);
}

} // namespace warpo::passes::gc::ut

#endif
