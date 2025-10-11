// Copyright 2016 WebAssembly Community Group participants
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// origin third_party/binaryen/src/passes/Inlining.cpp

#include <algorithm>
#include <atomic>
#include <cassert>
#include <cstdint>
#include <memory>

#include "AdvancedInlining.hpp"
#include "DoInlining.hpp"
#include "fmt/base.h"
#include "helper/CostModel.hpp"
#include "ir/module-utils.h"
#include "ir/type-updating.h"
#include "ir/utils.h"
#include "pass.h"
#include "passes/pass-utils.h"
#include "support/name.h"
#include "warpo/common/OptLevel.hpp"
#include "warpo/support/Debug.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm.h"

#define PASS_NAME "AdvInline"

using namespace wasm;

namespace warpo::passes {

static cli::Opt<uint32_t> AdvInlineTolerableInstructionIncrease{
    cli::Category::Optimization,
    "--adv-inline-tolerable-instruction-increase",
    [](argparse::Argument &arg) {
      arg.help("Tolerable instruction increase for each inline function").default_value(64U);
    },
};

namespace {

enum class InliningMode {
  // We do not know yet if this function can be inlined, as that has
  // not been computed yet.
  Unknown,
  // This function cannot be inlined in any way.
  Uninlineble,
  // This function can be inlined fully, that is, normally: the entire function
  // can be inlined. This is in contrast to split/partial inlining, see below.
  Full,
};

// Useful into on a function, helping us decide if we can inline it
struct FunctionInfo {
  std::atomic<Index> refs{0};
  float functionCost = 0.0F;
  float inlinedCost = 0.0F;
  bool hasCalls = false;
  bool hasLoops = false;
  // Something is used globally if there is a reference to it in a table or
  // export etc.
  bool usedGlobally = false;
  // We consider a function to be a trivial call if the body is just a call with
  // trivial arguments, like this:
  //
  //  (func $forward (param $x) (param $y)
  //    (call $target (local.get $x) (local.get $y))
  //  )
  //
  // Specifically the body must be a call, and the operands to the call must be
  // of size 1 (generally, LocalGet or Const).
  InliningMode inliningMode = InliningMode::Unknown;

  // See pass.h for how defaults for these options were chosen.
  bool worthFullInlining(wasm::Name const &funcName) {
    if (refs == 0) {
      return false;
    }
    float budget = static_cast<float>(AdvInlineTolerableInstructionIncrease.get());
    if (!usedGlobally) {
      // when the function is not used in global scope. we can delete this function after inlining.
      budget += functionCost;
    }
    // calculate delta for each call
    float const sizeCostDelta = inlinedCost - getOpcodeSizeCost(Opcode::CALL);
    float const performanceCostDelta = 0.0F - getOpcodePerformanceCost(Opcode::CALL) - getFunctionPerformanceCost();

    float const optimizationLevel = static_cast<float>(common::getOptimizationLevel()) + 0.0001F;
    float const shrinkLevel = static_cast<float>(common::getShrinkLevel()) + 0.0001F;
    float const optRatio = 0.5F * optimizationLevel / (optimizationLevel + shrinkLevel);
    float const shrinkRatio = 0.5F + 0.5F * shrinkLevel / (optimizationLevel + shrinkLevel);
    float const delta = performanceCostDelta * optRatio + sizeCostDelta * shrinkRatio;

    budget -= static_cast<float>(refs) * delta;

    // TODO: how can we handle potential optimization? e.g. const parameters
    // TODO: handle recursive calls?

    bool const shouldInline = budget >= 0.0F;
    if (support::isDebug(PASS_NAME, funcName.str)) {
      fmt::println("[" PASS_NAME "] {} '{}', func_cost={}, delta={}, refs={}, budget={}",
                   shouldInline ? "inline" : "not inline", funcName.str, functionCost, delta, refs.load(), budget);
    }
    return shouldInline;
  }
};

bool canHandleParams(Function *const func) {
  // We cannot inline a function if we cannot handle placing its params in a
  // locals, as all params become locals.
  for (auto param : func->getParams()) {
    if (!TypeUpdating::canHandleAsLocal(param)) {
      return false;
    }
  }
  return true;
}

using NameInfoMap = std::unordered_map<Name, FunctionInfo>;

struct FunctionInfoScanner : public WalkerPass<PostWalker<FunctionInfoScanner>> {
  bool isFunctionParallel() override { return true; }

  explicit FunctionInfoScanner(NameInfoMap &infos) : infos(infos) {}

  std::unique_ptr<Pass> create() override { return std::make_unique<FunctionInfoScanner>(infos); }

  void visitLoop(Loop *curr) {
    static_cast<void>(curr);
    // having a loop
    infos[getFunction()->name].hasLoops = true;
  }

  void visitCall(Call *curr) {
    // can't add a new element in parallel
    assert(infos.count(curr->target) > 0);
    infos[curr->target].refs++;
    // having a call
    infos[getFunction()->name].hasCalls = true;
  }

  void visitFunction(Function *curr) {
    auto &info = infos[curr->name];

    if (!canHandleParams(curr)) {
      info.inliningMode = InliningMode::Uninlineble;
    }

    float const bodyCost = measureSizeCost(curr->body);
    info.functionCost = bodyCost + getFunctionSizeCost();
    info.inlinedCost = bodyCost;
  }

private:
  NameInfoMap &infos;
};

struct InliningState {
  // Maps functions worth inlining to the mode with which we can inline them.
  std::unordered_map<Name, InliningMode> inlinableFunctions;
  // function name => actions that can be performed in it
  std::unordered_map<Name, std::vector<InliningAction>> actionsForFunction;
};

struct Planner : public WalkerPass<TryDepthWalker<Planner>> {
  bool isFunctionParallel() override { return true; }

  explicit Planner(InliningState *state) : state(state) {}

  std::unique_ptr<Pass> create() override { return std::make_unique<Planner>(state); }

  void visitCall(Call *curr) {
    // plan to inline if we know this is valid to inline, and if the call is
    // actually performed - if it is dead code, it's pointless to inline.
    // we also cannot inline ourselves.
    bool isUnreachable;
    if (curr->isReturn) {
      // Tail calls are only actually unreachable if an argument is
      isUnreachable = std::any_of(curr->operands.begin(), curr->operands.end(),
                                  [](Expression *op) { return op->type == Type::unreachable; });
    } else {
      isUnreachable = curr->type == Type::unreachable;
    }
    if ((state->inlinableFunctions.count(curr->target) != 0U) && !isUnreachable &&
        curr->target != getFunction()->name) {
      // can't add a new element in parallel
      assert(state->actionsForFunction.count(getFunction()->name) > 0);
      state->actionsForFunction[getFunction()->name].emplace_back(getCurrentPointer(),
                                                                  getModule()->getFunction(curr->target), tryDepth > 0);
    }
  }

private:
  InliningState *state;
};

struct Inlining : public Pass {
  // This pass changes locals and parameters.
  // FIXME DWARF updating does not handle local changes yet.
  bool invalidatesDWARF() override { return true; }

  // the information for each function. recomputed in each iteraction
  NameInfoMap infos;

  Module *module = nullptr;

  void run(Module *module_) override {
    module = module_;

    // No point to do more iterations than the number of functions, as it means
    // we are infinitely recursing (which should be very rare in practice, but
    // it is possible that a recursive call can look like it is worth inlining).
    Index iterationNumber = 0;

    auto numOriginalFunctions = module->functions.size();

    // Track in how many iterations a function was inlined into. We are willing
    // to inline many times into a function within an iteration, as e.g. that
    // helps the case of many calls of a small getter. However, if we only do
    // more inlining in separate iterations then it is likely code that was the
    // result of previous inlinings that is now being inlined into. That is, an
    // old inlining added a call to somewhere, and now we are inlining into that
    // call. This is typically recursion, which to some extent can help, but
    // then like loop unrolling it loses its benefit quickly, so set a limit
    // here.
    //
    // In addition to inlining into a function, we track how many times we do
    // other potentially repetitive operations like splitting a function before
    // inlining, as any such repetitive operation should be limited in how many
    // times we perform it. (An exception is how many times we inlined a
    // function, which we do not want to limit - it can be profitable to inline
    // a call into a great many callsites, over many iterations.)
    //
    // (Track names here, and not Function pointers, as we can remove functions
    // while inlining, and it may be confusing during debugging to have a
    // pointer to something that was removed.)
    std::unordered_map<Name, Index> iterationCounts;

    const size_t MaxIterationsForFunc = 5;

    while (iterationNumber <= numOriginalFunctions) {
      iterationNumber++;

      std::unordered_set<Function *> inlinedInto;

      prepare();
      iteration(inlinedInto);

      if (inlinedInto.empty()) {
        return;
      }

      for (auto *func : inlinedInto) {
        if (++iterationCounts[func->name] >= MaxIterationsForFunc) {
          return;
        }
      }
    }
  }

  void prepare() {
    infos.clear();
    // fill in info, as we operate on it in parallel (each function to its own
    // entry)
    for (auto &func : module->functions) {
      infos[func->name];
    }
    {
      FunctionInfoScanner scanner(infos);
      scanner.run(getPassRunner(), module);
      scanner.walkModuleCode(module);
    }
    for (std::unique_ptr<wasm::ElementSegment> const &elementSegment : module->elementSegments) {
      for (wasm::Expression const *const expr : elementSegment->data) {
        if (wasm::RefFunc const *const refFunc = expr->cast<wasm::RefFunc>()) {
          infos[refFunc->func].usedGlobally = true;
        }
      }
    }
    for (auto &ex : module->exports) {
      if (ex->kind == ExternalKind::Function) {
        infos[ex->name].usedGlobally = true;
      }
    }
    if (module->start.is()) {
      infos[module->start].usedGlobally = true;
    }
  }

  void iteration(std::unordered_set<Function *> &inlinedInto) {
    // decide which to inline
    InliningState state;
    ModuleUtils::iterDefinedFunctions(*module, [&](Function *func) {
      InliningMode const inliningMode = getInliningMode(func->name);
      assert(inliningMode != InliningMode::Unknown);
      if (inliningMode != InliningMode::Uninlineble) {
        state.inlinableFunctions[func->name] = inliningMode;
      }
    });
    if (state.inlinableFunctions.empty()) {
      return;
    }
    // Fill in actionsForFunction, as we operate on it in parallel (each
    // function to its own entry). Also generate a vector of the function names
    // so that in the later loop we can iterate on it deterministically and
    // without iterator invalidation.
    std::vector<Name> funcNames;
    for (auto &func : module->functions) {
      state.actionsForFunction[func->name];
      funcNames.push_back(func->name);
    }

    // Find and plan inlinings in parallel. This discovers inlining
    // opportunities, by themselves, but does not yet take into account
    // interactions between them (e.g. we don't want to both inline into a
    // function and then inline it as well).
    Planner(&state).run(getPassRunner(), module);

    // Choose which inlinings to perform. We do this sequentially so that we
    // can consider interactions between them, and avoid nondeterminism.
    ChosenActions chosenActions;

    // How many uses (calls of the function) we inlined.
    std::unordered_map<Name, Index> inlinedUses;

    for (auto name : funcNames) {
      auto *func = module->getFunction(name);
      // if we've inlined a function, don't inline into it in this iteration,
      // avoid risk of races
      // note that we do not risk stalling progress, as each iteration() will
      // inline at least one call before hitting this
      if (inlinedUses.count(func->name) != 0U) {
        continue;
      }
      for (auto &action : state.actionsForFunction[name]) {
        auto *inlinedFunction = action.contents;
        // if we've inlined into a function, don't inline it in this iteration,
        // avoid risk of races
        // note that we do not risk stalling progress, as each iteration() will
        // inline at least one call before hitting this
        if (inlinedInto.count(inlinedFunction) != 0U) {
          continue;
        }
        Name const inlinedName = inlinedFunction->name;
        if (!isUnderSizeLimit(func->name, inlinedName)) {
          continue;
        }

        // Update the action for the actual inlining we have chosen to perform
        // (when splitting, we will actually inline one of the split pieces and
        // not the original function itself; note how even if we do that then
        // we are still removing a call to the original function here, and so
        // we do not need to change anything else lower down - we still want to
        // note that we got rid of one use of the original function).
        action.contents = getActuallyInlinedFunction(action.contents);
        action.nameHint = inlinedNameHint++;
        chosenActions[func->name].push_back(action);
        inlinedUses[inlinedName]++;
        inlinedInto.insert(func);
        assert(inlinedUses[inlinedName] <= infos[inlinedName].refs);
      }
    }

    if (chosenActions.empty()) {
      // We found nothing to do.
      return;
    }

    // Perform the inlinings in parallel (sequentially inside each function we
    // inline into, but in parallel between them). If we are optimizing, do so
    // as well.
    {
      PassUtils::FilteredPassRunner runner(module, inlinedInto, getPassRunner()->options);
      runner.setIsNested(true);
      runner.add(std::make_unique<DoInlining>(chosenActions));
      runner.run();
    }

    // remove functions that we no longer need after inlining
    module->removeFunctions([&](Function *func) {
      auto name = func->name;
      auto &info = infos[name];
      return (inlinedUses.count(name) != 0U) && inlinedUses[name] == info.refs && !info.usedGlobally;
    });
  }

  // See explanation in InliningAction.
  Index inlinedNameHint = 0;

  // Decide for a given function whether to inline, and if so in what mode.
  InliningMode getInliningMode(Name name) {
    wasm::Function *const func = module->getFunction(name);
    FunctionInfo &info = infos[name];
    if (info.inliningMode != InliningMode::Unknown) {
      return info.inliningMode;
    }

    // Check if the function itself is worth inlining as it is.
    if (!func->noFullInline && info.worthFullInlining(name)) {
      return info.inliningMode = InliningMode::Full;
    }

    // Cannot be fully or partially inlined => uninlineble.
    info.inliningMode = InliningMode::Uninlineble;
    return info.inliningMode;
  }

  // Gets the actual function to be inlined. Normally this is the function
  // itself, but if it is a function that we must first split (i.e., we only
  // want to partially inline it) then it will be the inlineble part of the
  // split.
  //
  // This is called right before actually performing the inlining, that is, we
  // are guaranteed to inline after this.
  Function *getActuallyInlinedFunction(Function *func) {
    InliningMode const inliningMode = infos[func->name].inliningMode;
    static_cast<void>(inliningMode);
    // If we want to inline this function itself, do so.
    assert(inliningMode == InliningMode::Full);
    return func;
  }

  // Checks if the combined size of the code after inlining is under the
  // absolute size limit. We have an absolute limit in order to avoid
  // extremely-large sizes after inlining, as they may hit limits in VMs and/or
  // slow down startup (measurements there indicate something like ~1 second to
  // optimize a 100K function). See e.g.
  // https://github.com/WebAssembly/binaryen/pull/3730#issuecomment-867939138
  // https://github.com/emscripten-core/emscripten/issues/13899#issuecomment-825073344
  bool isUnderSizeLimit(Name target, Name source) {
    // Estimate the combined binary size from the number of instructions.
    auto combinedSize = infos[target].inlinedCost + infos[source].inlinedCost;
    auto estimatedBinarySize = Measurer::BytesPerExpr * static_cast<double>(combinedSize);
    // The limit is arbitrary, but based on the links above. It is a very high
    // value that should appear very rarely in practice (for example, it does
    // not occur on the Emscripten benchmark suite of real-world codebases).
    const Index MaxCombinedBinarySize = 400 * 1024;
    return estimatedBinarySize < MaxCombinedBinarySize;
  }
};

} // anonymous namespace

} // namespace warpo::passes

wasm::Pass *warpo::passes::createAdvancedInliningPass() { return new Inlining(); }
