// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <functional>
#include <memory>
#include <string>

#include "BaseLower.hpp"
#include "CollectLeafFunction.hpp"
#include "GCInfo.hpp"
#include "ImmutableGlobalToStackRemover.hpp"
#include "LeafFunctionFilter.hpp"
#include "MergeSSA.hpp"
#include "ObjLivenessAnalyzer.hpp"
#include "OptLower.hpp"
#include "PrologEpilogInserter.hpp"
#include "SSAObj.hpp"
#include "ShrinkWrap.hpp"
#include "StackAssigner.hpp"
#include "ToStackReplacer.hpp"
#include "argparse/argparse.hpp"
#include "pass.h"
#include "passes/passes.h"
#include "support/name.h"
#include "warpo/support/Opt.hpp"
#include "wasm.h"

#define PASS_NAME "GCOptLower"

namespace warpo::passes::gc {

static cli::Opt<bool> NoImmutableGlobalToStackRemover{
    cli::Category::OnlyForTest,
    "--no-gc-immutable-global-to-stack-remover",
    [](argparse::Argument &arg) { arg.flag().hidden(); },
};
static cli::Opt<bool> NoLeafFunctionFilter{
    cli::Category::OnlyForTest,
    "--no-gc-leaf-function-filter",
    [](argparse::Argument &arg) { arg.help("Disable leaf function filter during GC lowering").flag().hidden(); },
};
static cli::Opt<bool> NoMergeSSA{
    cli::Category::OnlyForTest,
    "--no-gc-merge-ssa",
    [](argparse::Argument &arg) { arg.help("Disable SSA merging during GC lowering").flag().hidden(); },
};
static cli::Opt<bool> NoOptimizedStackPositionAssigner{
    cli::Category::OnlyForTest,
    "--no-gc-optimized-stack-position-assigner",
    [](argparse::Argument &arg) {
      arg.help("Disable optimized stack position assigner during GC lowering").flag().hidden();
    },
};
static cli::Opt<bool> NoShrinkWrap{
    cli::Category::OnlyForTest,
    "--no-gc-shrink-wrap",
    [](argparse::Argument &arg) { arg.help("Disable shrink wrap during GC lowering").flag().hidden(); },
};

static cli::Opt<bool> TestOnlyControlGroup{
    cli::Category::OnlyForTest,
    "--gc-test-only-control-group",
    [](argparse::Argument &arg) { arg.flag().hidden(); },
};

void OptLower::preprocess(wasm::PassRunner &runner) {
  // cleanup without changing the overall code structure
  runner.add("vacuum");
  // reduce basic blocks count to avoid to many fixed pointer calculations
  runner.add("merge-blocks");
}

void OptLower::run(wasm::Module *m) {
  wasm::PassRunner runner{getPassRunner()};

  preprocess(runner);

  // only for test purpose
  if (TestOnlyControlGroup.get())
    return;

  // TODO: NoImmutableGlobalToStackRemover does not work. Fix it later.
  if (!NoImmutableGlobalToStackRemover.get())
    runner.add(std::unique_ptr<wasm::Pass>(new ImmutableGlobalToStackRemover(variableInfo_)));

  ModuleLevelSSAMap const moduleLevelSSAMap = ModuleLevelSSAMap::create(m);

  std::shared_ptr<CallGraph const> const cg = CallGraphBuilder::addToPass(runner);

  std::shared_ptr<LeafFunc const> const leafFunc =
      NoLeafFunctionFilter.get() ? nullptr : LeafFunctionCollector::addToPass(runner, cg);

  std::shared_ptr<ObjLivenessInfo> const livenessInfo = ObjLivenessAnalyzer::addToPass(runner, moduleLevelSSAMap);

  if (!NoMergeSSA.get()) {
    // now merge ssa should be done firstly, it is depends on liveness info as local's possible values.
    // After LeafFunctionFilter, liveness info is not correct anymore.
    // TODO: use def-uses chain instead of liveness info
    MergeSSA::addToPass(runner, moduleLevelSSAMap, livenessInfo);
  }

  LeafFunctionFilter::addToPass(runner, leafFunc, livenessInfo);

  StackAssigner::Mode const stackAssignerMode =
      NoOptimizedStackPositionAssigner.get() ? StackAssigner::Mode::Vanilla : StackAssigner::Mode::GreedyConflictGraph;
  std::shared_ptr<StackPositions const> const stackPositions =
      StackAssigner::addToPass(runner, stackAssignerMode, livenessInfo);
  std::shared_ptr<InsertPositionHints const> const stackInsertPositions =
      NoShrinkWrap.get() ? ShrinkWrapAnalysis::dummy(runner) : ShrinkWrapAnalysis::addToPass(runner, livenessInfo);
  runner.add(std::unique_ptr<wasm::Pass>(
      new PrologEpilogInserter(stackInsertPositions, MaxShadowStackOffsetsFromStackPositions::create(stackPositions))));
  runner.add(std::unique_ptr<wasm::Pass>(new ToStackReplacer(stackPositions)));

  runner.run();

  m->removeFunction(FnLocalToStack);
  m->removeFunction(FnTmpToStack);
  addStackStackOperationFunction(m);
}

} // namespace warpo::passes::gc
