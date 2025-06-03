#include <algorithm>
#include <cassert>
#include <map>
#include <memory>

#include "CollectLeafFunction.hpp"
#include "GCInfo.hpp"
#include "LeafFunctionFilter.hpp"
#include "Lowering.hpp"
#include "MergeSSA.hpp"
#include "ObjLivenessAnalyzer.hpp"
#include "SSAObj.hpp"
#include "StackAssigner.hpp"
#include "argparse/argparse.hpp"
#include "literal.h"
#include "pass.h"
#include "passes/passes.h"
#include "support/Opt.hpp"
#include "support/index.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

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

// localtostack/tmptostack => tostack(v, i32.const offset)
// insert to begin => decrease SP
// insert to end => increase SP
struct ToStackCallLowering : public wasm::Pass {
  std::shared_ptr<StackPositions const> stackPositions_;
  explicit ToStackCallLowering(std::shared_ptr<StackPositions const> const &stackPositions)
      : stackPositions_(stackPositions) {
    name = "LowerToStackCall";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<ToStackCallLowering>(stackPositions_); }
  bool modifiesBinaryenIR() override { return true; }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override;
};
void ToStackCallLowering::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition const &stackPosition = stackPositions_->at(func);
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
        expr->operands.push_back(builder.makeConst(wasm::Literal(offset)));
        expr->target = "~lib/rt/__tostack";
      }
    }
  };
  CallReplacer callReplacer{stackPosition, func};
  callReplacer.walkFunctionInModule(func, m);

  if (callReplacer.maxShadowStackOffset_ == 0)
    return;

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
    func->body = b.makeBlock(
        {
            b.makeCall("~lib/rt/__decrease_sp", {b.makeConst(wasm::Literal(callReplacer.maxShadowStackOffset_))},
                       wasm::Type::none),
            func->body,
            b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(callReplacer.maxShadowStackOffset_))},
                       wasm::Type::none),
        },
        resultType);
    ReturnWithoutResultReplacer returnReplacer{callReplacer.maxShadowStackOffset_};
    returnReplacer.walkFunctionInModule(func, m);
  } else {
    wasm::Index const scratchReturnValueLocalIndex = wasm::Builder::addVar(func, resultType);
    func->body = b.makeBlock(
        {
            b.makeCall("~lib/rt/__decrease_sp", {b.makeConst(wasm::Literal(callReplacer.maxShadowStackOffset_))},
                       wasm::Type::none),
            b.makeLocalSet(scratchReturnValueLocalIndex, func->body),
            b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(callReplacer.maxShadowStackOffset_))},
                       wasm::Type::none),
            b.makeLocalGet(scratchReturnValueLocalIndex, resultType),
        },
        resultType);
    ReturnWithResultReplacer returnReplacer{scratchReturnValueLocalIndex, callReplacer.maxShadowStackOffset_,
                                            resultType};
    returnReplacer.walkFunctionInModule(func, m);
  }
}

struct PostLowering : public wasm::Pass {
  explicit PostLowering() { name = "PostLowering"; }
  bool modifiesBinaryenIR() override { return true; }
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
    m->addFunction(
        b.makeFunction("~lib/rt/__tostack", wasm::Signature(std::vector<wasm::Type>{i32, i32}, i32), {},
                       b.makeBlock({
                           b.makeStore(4, 0, 1,
                                       b.makeBinary(wasm::BinaryOp::AddInt32, b.makeGlobalGet(VarStackPointer, i32),
                                                    b.makeLocalGet(1, i32)),
                                       b.makeLocalGet(0, i32), i32, memoryName),
                           b.makeLocalGet(0, i32),
                       })));
    m->removeFunction(FnLocalToStack);
    m->removeFunction(FnTmpToStack);
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

  runner.add(std::unique_ptr<wasm::Pass>(new gc::ToStackCallLowering(stackPositions)));

  runner.add(std::unique_ptr<wasm::Pass>(new gc::PostLowering()));

  runner.run();
}

} // namespace warpo::passes
