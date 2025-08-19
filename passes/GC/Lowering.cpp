#include <algorithm>
#include <cassert>
#include <cstddef>
#include <functional>
#include <map>
#include <memory>
#include <optional>
#include <string>

#include "../helper/FindExpr.hpp"
#include "../helper/ToString.hpp"
#include "CollectLeafFunction.hpp"
#include "GCInfo.hpp"
#include "LeafFunctionFilter.hpp"
#include "Lowering.hpp"
#include "MergeSSA.hpp"
#include "ObjLivenessAnalyzer.hpp"
#include "SSAObj.hpp"
#include "ShrinkWrap.hpp"
#include "StackAssigner.hpp"
#include "argparse/argparse.hpp"
#include "fmt/base.h"
#include "fmt/format.h"
#include "literal.h"
#include "pass.h"
#include "passes/passes.h"
#include "support/Opt.hpp"
#include "support/index.h"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "GCLowering"

namespace warpo::passes {

static cli::Opt<bool> NoLeafFunctionFilter{
    "--no-gc-leaf-function-filter",
    [](argparse::Argument &arg) { arg.help("Disable leaf function filter during GC lowering").flag(); },
};
static cli::Opt<bool> NoMergeSSA{
    "--no-gc-merge-ssa",
    [](argparse::Argument &arg) { arg.help("Disable SSA merging during GC lowering").flag(); },
};
static cli::Opt<bool> NoOptimizedStackPositionAssigner{
    "--no-gc-optimized-stack-position-assigner",
    [](argparse::Argument &arg) { arg.help("Disable optimized stack position assigner during GC lowering").flag(); },
};

static cli::Opt<bool> TestOnlyControlGroup{
    "--gc-test-only-control-group",
    [](argparse::Argument &arg) { arg.flag().hidden(); },
};

namespace gc {

static wasm::Name getToStackFunctionName(uint32_t offset) {
  return wasm::Name{fmt::format("~lib/rt/__tostack<{}>", offset)};
}

// localtostack/tmptostack => tostack(v, i32.const offset)
// insert to begin => decrease SP
// insert to end => increase SP
struct ToStackCallLowering : public wasm::Pass {
  std::shared_ptr<gc::StackInsertPoints const> stackInsertPositions_;
  std::shared_ptr<StackPositions const> stackPositions_;
  explicit ToStackCallLowering(std::shared_ptr<gc::StackInsertPoints const> stackInsertPositions,
                               std::shared_ptr<StackPositions const> const &stackPositions)
      : stackInsertPositions_(stackInsertPositions), stackPositions_(stackPositions) {
    name = "LowerToStackCall";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override {
    return std::make_unique<ToStackCallLowering>(stackInsertPositions_, stackPositions_);
  }
  bool modifiesBinaryenIR() override { return true; }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override;

private:
  uint32_t replaceCallExprrunOnFunction(wasm::Module *m, wasm::Function *func, StackPosition const &stackPosition);
  void replaceReturnExprWithEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                     std::optional<wasm::Index> const &scratchReturnValueLocalIndex);
  void insertPrologueAndEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                 std::optional<wasm::Index> const &scratchReturnValueLocalIndex,
                                 wasm::Expression *prologue, wasm::Expression *epilogue);
};

void ToStackCallLowering::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition const &stackPosition = stackPositions_->at(func);
  StackInsertPoint const &insertPoint = stackInsertPositions_->at(func);
  uint32_t const maxShadowStackOffset = replaceCallExprrunOnFunction(m, func, stackPosition);
  if (maxShadowStackOffset == 0)
    return;
  wasm::Type const resultType = func->getResults();
  std::optional<wasm::Index> const scratchReturnValueLocalIndex =
      (func->getResults() == wasm::Type::none) ? std::nullopt
                                               : std::optional<wasm::Index>{wasm::Builder::addVar(func, resultType)};
  if (insertPoint.prologue == nullptr || insertPoint.epilogue == nullptr) {
    // epilogue == nullptr means we should insert to exit BB, which may be a virtual BB linked with all return
    replaceReturnExprWithEpilogue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex);
  }
  insertPrologueAndEpilogue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex, insertPoint.prologue,
                            insertPoint.epilogue);
}

uint32_t ToStackCallLowering::replaceCallExprrunOnFunction(wasm::Module *m, wasm::Function *func,
                                                           StackPosition const &stackPosition) {
  struct CallReplacer : public wasm::PostWalker<CallReplacer> {
    wasm::Function *func;
    StackPosition const &stackPosition_;
    uint32_t maxShadowStackOffset_ = 0;
    explicit CallReplacer(StackPosition const &input, wasm::Function *func) : stackPosition_(input), func(func) {}
    void visitCall(wasm::Call *expr) {
      if (expr->target != FnLocalToStack && expr->target != FnTmpToStack)
        return;

      auto it = stackPosition_.find(expr);
      if (it == stackPosition_.end()) {
        // no need to tostack
        assert(expr->operands.size() == 1);
        replaceCurrent(expr->operands.front());
      } else {
        uint32_t const offset = it->second;
        maxShadowStackOffset_ = std::max(offset + 4U, maxShadowStackOffset_);
        wasm::Builder builder{*getModule()};
        expr->target = getToStackFunctionName(offset);
      }
    }
  };
  CallReplacer callReplacer{stackPosition, func};
  callReplacer.walkFunctionInModule(func, m);
  return callReplacer.maxShadowStackOffset_;
}
void ToStackCallLowering::replaceReturnExprWithEpilogue(
    wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
    std::optional<wasm::Index> const &scratchReturnValueLocalIndex) {
  struct ReturnWithResultReplacer : public wasm::PostWalker<ReturnWithResultReplacer> {
    wasm::Index const scratchReturnValueLocalIndex_;
    uint32_t const maxShadowStackOffset_;
    wasm::Type const &resultType_;
    explicit ReturnWithResultReplacer(wasm::Index const scratchReturnValueLocalIndex,
                                      uint32_t const maxShadowStackOffset, wasm::Type const &returnType)
        : scratchReturnValueLocalIndex_(scratchReturnValueLocalIndex), maxShadowStackOffset_(maxShadowStackOffset),
          resultType_(returnType) {}
    void visitReturn(wasm::Return *expr) {
      wasm::Builder b{*getModule()};
      assert(expr->value);
      replaceCurrent(b.makeBlock(
          {
              b.makeLocalSet(scratchReturnValueLocalIndex_, expr->value),
              b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset_))},
                         wasm::Type::none),
              expr,
          },
          wasm::Type::unreachable));
      expr->value = b.makeLocalGet(scratchReturnValueLocalIndex_, resultType_);
    }
  };
  struct ReturnWithoutResultReplacer : public wasm::PostWalker<ReturnWithoutResultReplacer> {
    uint32_t const maxShadowStackOffset_;
    explicit ReturnWithoutResultReplacer(uint32_t const maxShadowStackOffset)
        : maxShadowStackOffset_(maxShadowStackOffset) {}
    void visitReturn(wasm::Return *expr) {
      wasm::Builder b{*getModule()};
      replaceCurrent(b.makeBlock(
          {
              b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset_))},
                         wasm::Type::none),
              expr,
          },
          wasm::Type::unreachable));
    }
  };
  wasm::Type const resultType = func->getResults();
  wasm::Builder b{*m};
  if (resultType == wasm::Type::none) {
    ReturnWithoutResultReplacer returnReplacer{maxShadowStackOffset};
    returnReplacer.walkFunctionInModule(func, m);
  } else {

    ReturnWithResultReplacer returnReplacer{scratchReturnValueLocalIndex.value(), maxShadowStackOffset, resultType};
    returnReplacer.walkFunctionInModule(func, m);
  }
}

static bool tryInsertBefore(wasm::Function *func, wasm::Expression *targetExpr,
                            std::function<wasm::Expression *()> insertedExprGetter) {
  fmt::println("[" PASS_NAME "] in fn '{}', insert before {}", func->name.str, toString(targetExpr));
  return false;
  // wasm::Expression **ptr = findExpressionPointer(targetExpr, func);
}
static bool tryInsertAfter(wasm::Function *func, wasm::Expression *targetExpr,
                           std::function<wasm::Expression *()> insertedExprGetter) {
  fmt::println("[" PASS_NAME "] in fn '{}', insert after {}", func->name.str, toString(targetExpr));
  return false;
}

void ToStackCallLowering::insertPrologueAndEpilogue(wasm::Module *m, wasm::Function *func,
                                                    uint32_t maxShadowStackOffset,
                                                    std::optional<wasm::Index> const &scratchReturnValueLocalIndex,
                                                    wasm::Expression *prologue, wasm::Expression *epilogue) {
  wasm::Type const resultType = func->getResults();
  wasm::Builder b{*m};

  bool isInsertedPrologue = false;
  bool isInsertedEpilogue = false;

  if (prologue != nullptr) {
    isInsertedPrologue = tryInsertBefore(func, prologue, [&]() -> wasm::Expression * {
      return b.makeCall("~lib/rt/__decrease_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none);
    });
  }
  if (epilogue != nullptr) {
    isInsertedEpilogue = tryInsertAfter(func, epilogue, [&]() -> wasm::Expression * {
      return b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none);
    });
  }
  if (resultType == wasm::Type::none) {
    wasm::Block *block = b.makeBlock(std::initializer_list<wasm::Expression *>{}, resultType);
    if (!isInsertedPrologue)
      block->list.push_back(
          b.makeCall("~lib/rt/__decrease_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(func->body);
    block->list.push_back(
        b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    func->body = block;
  } else {
    wasm::Block *block = b.makeBlock(std::initializer_list<wasm::Expression *>{}, resultType);
    if (!isInsertedPrologue)
      block->list.push_back(
          b.makeCall("~lib/rt/__decrease_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(b.makeLocalSet(scratchReturnValueLocalIndex.value(), func->body));
    block->list.push_back(
        b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(b.makeLocalGet(scratchReturnValueLocalIndex.value(), resultType));
    func->body = block;
  }
}

struct PostLowering : public wasm::Pass {
  std::shared_ptr<gc::StackPositions> stackPosition_;
  explicit PostLowering(std::shared_ptr<gc::StackPositions> stackPosition) : stackPosition_(stackPosition) {
    name = "PostLowering";
  }
  void run(wasm::Module *m) override {
    wasm::Builder b{*m};
    wasm::Name const memoryName = m->memories.front()->name;
    wasm::Type const i32 = wasm::Type::i32;
    m->addFunction(b.makeFunction(
        "~lib/rt/__decrease_sp", wasm::Signature(i32, wasm::Type::none), {},
        b.makeBlock({
            b.makeGlobalSet(
                VarStackPointer,
                b.makeBinary(wasm::BinaryOp::SubInt32, b.makeGlobalGet(VarStackPointer, i32), b.makeLocalGet(0, i32))),
            b.makeMemoryFill(b.makeGlobalGet(VarStackPointer, i32), b.makeConst(wasm::Literal::makeZero(i32)),
                             b.makeLocalGet(0, i32), memoryName),
            b.makeIf(b.makeBinary(wasm::BinaryOp::LtSInt32, b.makeGlobalGet(VarStackPointer, i32),
                                  b.makeGlobalGet(VarDataEnd, i32)),
                     b.makeUnreachable()),

        })));
    m->addFunction(
        b.makeFunction("~lib/rt/__increase_sp", wasm::Signature(i32, wasm::Type::none), {},
                       b.makeBlock({
                           b.makeGlobalSet(VarStackPointer,
                                           b.makeBinary(wasm::BinaryOp::AddInt32, b.makeGlobalGet(VarStackPointer, i32),
                                                        b.makeLocalGet(0, i32))),

                       })));
    uint32_t const maxShadowStackOffset = getMaxShadowStackOffset();
    for (size_t offset = 0U; offset <= maxShadowStackOffset; offset += 4U) {
      m->addFunction(b.makeFunction(
          getToStackFunctionName(offset), wasm::Signature(i32, i32), {},
          b.makeBlock({
              b.makeStore(4, offset, 1, b.makeGlobalGet(VarStackPointer, i32), b.makeLocalGet(0, i32), i32, memoryName),
              b.makeLocalGet(0, i32),
          })));
    }

    m->removeFunction(FnLocalToStack);
    m->removeFunction(FnTmpToStack);
  }

private:
  uint32_t getMaxShadowStackOffset() const {
    uint32_t maxOffset = 0;
    for (auto const &[_, offsets] : *stackPosition_) {
      for (auto const &offset : offsets) {
        maxOffset = std::max(maxOffset, offset.second);
      }
    }
    return maxOffset;
  }
};

} // namespace gc

void GCLowering::preprocess(wasm::PassRunner &runner) {
  // cleanup without changing the overall code structure
  runner.add("vacuum");
  // reduce basic blocks count to avoid to many fixed pointer calculations
  runner.add("merge-blocks");
}

void GCLowering::run(wasm::Module *m) {
  wasm::PassRunner runner{getPassRunner()};

  preprocess(runner);

  if (TestOnlyControlGroup.get()) {
    // only for test purpose
    return;
  }

  gc::ModuleLevelSSAMap const moduleLevelSSAMap = gc::ModuleLevelSSAMap::create(m);

  std::shared_ptr<CallGraph const> cg = CallGraphBuilder::addToPass(runner);

  std::shared_ptr<gc::LeafFunc> leafFunc;
  if (!NoLeafFunctionFilter.get()) {
    leafFunc = gc::LeafFunctionCollector::addToPass(runner, cg);
  }

  std::shared_ptr<gc::ObjLivenessInfo> livenessInfo = gc::ObjLivenessAnalyzer::addToPass(runner, moduleLevelSSAMap);

  if (!NoMergeSSA.get()) {
    // now merge ssa should be done firstly, it is depends on liveness info as local's possible values.
    // After LeafFunctionFilter, liveness info is not correct anymore.
    // TODO: use def-uses chain instead of liveness info
    gc::MergeSSA::addToPass(runner, moduleLevelSSAMap, livenessInfo);
  }

  if (!NoLeafFunctionFilter.get()) {
    assert(leafFunc != nullptr);
    runner.add(std::unique_ptr<wasm::Pass>(new gc::LeafFunctionFilter(leafFunc, livenessInfo)));
  }

  gc::StackAssigner::Mode const stackAssignerMode = NoOptimizedStackPositionAssigner.get()
                                                        ? gc::StackAssigner::Mode::Vanilla
                                                        : gc::StackAssigner::Mode::GreedyConflictGraph;
  std::shared_ptr<gc::StackPositions> stackPositions =
      gc::StackAssigner::addToPass(runner, stackAssignerMode, livenessInfo);
  std::shared_ptr<gc::StackInsertPoints> stackInsertPositions =
      gc::ShrinkWrapAnalysis::addToPass(runner, stackPositions);
  runner.add(std::unique_ptr<wasm::Pass>(new gc::ToStackCallLowering(stackInsertPositions, stackPositions)));
  runner.add(std::unique_ptr<wasm::Pass>(new gc::PostLowering(stackPositions)));

  runner.run();
}

} // namespace warpo::passes
