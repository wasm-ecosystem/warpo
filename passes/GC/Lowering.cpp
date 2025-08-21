#include <algorithm>
#include <cassert>
#include <cstddef>
#include <functional>
#include <memory>
#include <string>

#include "CollectLeafFunction.hpp"
#include "GCInfo.hpp"
#include "LeafFunctionFilter.hpp"
#include "Lowering.hpp"
#include "MergeSSA.hpp"
#include "ObjLivenessAnalyzer.hpp"
#include "SSAObj.hpp"
#include "ShrinkWrap.hpp"
#include "StackAssigner.hpp"
#include "ToStackLower.hpp"
#include "argparse/argparse.hpp"
#include "literal.h"
#include "pass.h"
#include "passes/passes.h"
#include "support/Opt.hpp"
#include "support/name.h"
#include "wasm-builder.h"
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
          ToStackCallLower::getToStackFunctionName(offset), wasm::Signature(i32, i32), {},
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
  std::shared_ptr<gc::StackInsertPoints> stackInsertPositions = gc::ShrinkWrapAnalysis::addToPass(runner, livenessInfo);
  runner.add(std::unique_ptr<wasm::Pass>(new gc::ToStackCallLower(stackInsertPositions, stackPositions)));
  runner.add(std::unique_ptr<wasm::Pass>(new gc::PostLowering(stackPositions)));

  runner.run();
}

} // namespace warpo::passes
