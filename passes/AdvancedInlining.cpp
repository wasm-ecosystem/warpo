/*
 * Copyright 2016 WebAssembly Community Group participants
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// copy and modified from third_party/binaryen/src/passes/Inlining.cpp

#include <atomic>
#include <cstdint>
#include <memory>

#include "AdvancedInlining.hpp"
#include "fmt/base.h"
#include "helper/CostModel.hpp"
#include "ir/branch-utils.h"
#include "ir/debuginfo.h"
#include "ir/drop.h"
#include "ir/find_all.h"
#include "ir/literal-utils.h"
#include "ir/localize.h"
#include "ir/module-utils.h"
#include "ir/names.h"
#include "ir/type-updating.h"
#include "ir/utils.h"
#include "parsing.h"
#include "pass.h"
#include "passes/pass-utils.h"
#include "support/Debug.hpp"
#include "support/Opt.hpp"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm.h"

#define PASS_NAME "AdvInline"

using namespace wasm;

namespace warpo::passes {

static const cli::Opt<uint32_t> AdvInlineTolerableInstructionIncrease{
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
  float functionCost = 0.0f;
  float inlinedCost = 0.0f;
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
    float delta = inlinedCost - getOpcodeCost(Opcode::CALL);

    budget -= refs * delta;

    // TODO: how can we handle potential optimization? e.g. const parameters
    // TODO: handle recursive calls?

    bool const shouldInline = budget >= 0.0f;
    if (support::isDebug(PASS_NAME, funcName.str)) {
      fmt::println("[" PASS_NAME "] {} '{}', func_cost={}, refs={}, budget={}", shouldInline ? "inline" : "not inline",
                   funcName.str, functionCost, refs.load(), budget);
    }
    return shouldInline;
  }
};

static bool canHandleParams(Function *func) {
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

  FunctionInfoScanner(NameInfoMap &infos) : infos(infos) {}

  std::unique_ptr<Pass> create() override { return std::make_unique<FunctionInfoScanner>(infos); }

  void visitLoop(Loop *curr) {
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

    float const bodyCost = measureCost(curr->body);
    info.functionCost = bodyCost + getFunctionCost();
    info.inlinedCost = bodyCost;
  }

private:
  NameInfoMap &infos;
};

struct InliningAction {
  Expression **callSite;
  Function *contents;
  bool insideATry;

  // An optional name hint can be provided, which will then be used in the name
  // of the block we put the inlined code in. Using a unique name hint in each
  // inlining can reduce the risk of name overlaps (which cause fixup work in
  // UniqueNameMapper::uniquify).
  Index nameHint = 0;

  InliningAction(Expression **callSite, Function *contents, bool insideATry, Index nameHint = 0)
      : callSite(callSite), contents(contents), insideATry(insideATry), nameHint(nameHint) {}
};

struct InliningState {
  // Maps functions worth inlining to the mode with which we can inline them.
  std::unordered_map<Name, InliningMode> inlinableFunctions;
  // function name => actions that can be performed in it
  std::unordered_map<Name, std::vector<InliningAction>> actionsForFunction;
};

struct Planner : public WalkerPass<TryDepthWalker<Planner>> {
  bool isFunctionParallel() override { return true; }

  Planner(InliningState *state) : state(state) {}

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
    if (state->inlinableFunctions.count(curr->target) && !isUnreachable && curr->target != getFunction()->name) {
      // can't add a new element in parallel
      assert(state->actionsForFunction.count(getFunction()->name) > 0);
      state->actionsForFunction[getFunction()->name].emplace_back(getCurrentPointer(),
                                                                  getModule()->getFunction(curr->target), tryDepth > 0);
    }
  }

private:
  InliningState *state;
};

struct Updater : public TryDepthWalker<Updater> {
  Module *module;
  std::map<Index, Index> localMapping;
  Name returnName;
  Type resultType;
  bool isReturn;
  Builder *builder;
  PassOptions &options;

  struct ReturnCallInfo {
    // The original `return_call` or `return_call_indirect` or `return_call_ref`
    // with its operands replaced with `local.get`s.
    Expression *call;
    // The branch that is serving as the "return" part of the original
    // `return_call`.
    Break *branch;
  };

  // Collect information on return_calls in the inlined body. Each will be
  // turned into branches out of the original inlined body followed by
  // non-return version of the original `return_call`, followed by a branch out
  // to the caller. The branch labels will be filled in at the end of the walk.
  std::vector<ReturnCallInfo> returnCallInfos;

  Updater(PassOptions &options) : options(options) {}

  void visitReturn(Return *curr) { replaceCurrent(builder->makeBreak(returnName, curr->value)); }

  template <typename T> void handleReturnCall(T *curr, Signature sig) {
    if (isReturn || !curr->isReturn) {
      // If the inlined callsite was already a return_call, then we can keep
      // return_calls in the inlined function rather than downgrading them.
      // That is, if A->B and B->C and both those calls are return_calls
      // then after inlining A->B we want to now have A->C be a
      // return_call.
      return;
    }

    if (tryDepth == 0) {
      // Return calls in inlined functions should only break out of
      // the scope of the inlined code, not the entire function they
      // are being inlined into. To achieve this, make the call a
      // non-return call and add a break. This does not cause
      // unbounded stack growth because inlining and return calling
      // both avoid creating a new stack frame.
      curr->isReturn = false;
      curr->type = sig.results;
      // There might still be unreachable children causing this to be
      // unreachable.
      curr->finalize();
      if (sig.results.isConcrete()) {
        replaceCurrent(builder->makeBreak(returnName, curr));
      } else {
        replaceCurrent(builder->blockify(curr, builder->makeBreak(returnName)));
      }
    } else {
      // Set the children to locals as necessary, then add a branch out of the
      // inlined body. The branch label will be set later when we create branch
      // targets for the calls.
      Block *childBlock = ChildLocalizer(curr, getFunction(), *module, options).getChildrenReplacement();
      Break *branch = builder->makeBreak(Name());
      childBlock->list.push_back(branch);
      childBlock->type = Type::unreachable;
      replaceCurrent(childBlock);

      curr->isReturn = false;
      curr->type = sig.results;
      returnCallInfos.push_back({curr, branch});
    }
  }

  void visitCall(Call *curr) { handleReturnCall(curr, module->getFunction(curr->target)->getSig()); }

  void visitCallIndirect(CallIndirect *curr) { handleReturnCall(curr, curr->heapType.getSignature()); }

  void visitCallRef(CallRef *curr) {
    Type targetType = curr->target->type;
    if (!targetType.isSignature()) {
      // We don't know what type the call should return, but it will also never
      // be reached, so we don't need to do anything here.
      return;
    }
    handleReturnCall(curr, targetType.getHeapType().getSignature());
  }

  void visitLocalGet(LocalGet *curr) { curr->index = localMapping[curr->index]; }

  void visitLocalSet(LocalSet *curr) { curr->index = localMapping[curr->index]; }

  void walk(Expression *&curr) {
    PostWalker<Updater>::walk(curr);
    if (returnCallInfos.empty()) {
      return;
    }

    Block *body = builder->blockify(curr);
    curr = body;
    auto blockNames = BranchUtils::BranchAccumulator::get(body);

    for (Index i = 0; i < returnCallInfos.size(); ++i) {
      auto &info = returnCallInfos[i];

      // Add a block containing the previous body and a branch up to the caller.
      // Give the block a name that will allow this return_call's original
      // callsite to branch out of it then execute the call before returning to
      // the caller.
      auto name = Names::getValidName("__return_call", [&](Name test) { return !blockNames.count(test); }, i);
      blockNames.insert(name);
      info.branch->name = name;
      Block *oldBody = builder->makeBlock(body->list, body->type);
      body->list.clear();

      if (resultType.isConcrete()) {
        body->list.push_back(builder->makeBlock(name, {builder->makeBreak(returnName, oldBody)}, Type::none));
      } else {
        oldBody->list.push_back(builder->makeBreak(returnName));
        oldBody->name = name;
        oldBody->type = Type::none;
        body->list.push_back(oldBody);
      }
      body->list.push_back(info.call);
      body->finalize(resultType);
    }
  }
};

// Core inlining logic. Modifies the outside function (adding locals as
// needed) by copying the inlined code into it.
static void doCodeInlining(Module *module, Function *into, const InliningAction &action, PassOptions &options) {
  Function *from = action.contents;
  auto *call = (*action.callSite)->cast<Call>();

  // Works for return_call, too
  Type retType = module->getFunction(call->target)->getResults();

  // Build the block that will contain the inlined contents.
  Builder builder(*module);
  auto *block = builder.makeBlock();
  auto name = std::string("__inlined_func$") + from->name.toString();
  if (action.nameHint) {
    name += '$' + std::to_string(action.nameHint);
  }
  block->name = Name(name);

  // In the unlikely event that the function already has a branch target with
  // this name, fix that up, as otherwise we can get unexpected capture of our
  // branches, that is, we could end up with this:
  //
  //  (block $X             ;; a new block we add as the target of returns
  //    (from's contents
  //      (block $X         ;; a block in from's contents with a colliding name
  //        (br $X          ;; a new br we just added that replaces a return
  //
  // Here the br wants to go to the very outermost block, to represent a
  // return from the inlined function's code, but it ends up captured by an
  // internal block. We also need to be careful of the call's children:
  //
  //  (block $X             ;; a new block we add as the target of returns
  //    (local.set $param
  //      (call's first parameter
  //        (br $X)         ;; nested br in call's first parameter
  //      )
  //    )
  //
  // (In this case we could use a second block and define the named block $X
  // after the call's parameters, but that adds work for an extremely rare
  // situation.) The latter case does not apply if the call is a
  // return_call inside a try, because in that case the call's
  // children do not appear inside the same block as the inlined body.
  bool hoistCall = call->isReturn && action.insideATry;
  if (BranchUtils::hasBranchTarget(from->body, block->name) ||
      (!hoistCall && BranchUtils::BranchSeeker::has(call, block->name))) {
    auto fromNames = BranchUtils::getBranchTargets(from->body);
    auto callNames = hoistCall ? BranchUtils::NameSet{} : BranchUtils::BranchAccumulator::get(call);
    block->name =
        Names::getValidName(block->name, [&](Name test) { return !fromNames.count(test) && !callNames.count(test); });
  }

  // Prepare to update the inlined code's locals and other things.
  Updater updater(options);
  updater.setFunction(into);
  updater.module = module;
  updater.resultType = from->getResults();
  updater.returnName = block->name;
  updater.isReturn = call->isReturn;
  updater.builder = &builder;
  // Set up a locals mapping
  for (Index i = 0; i < from->getNumLocals(); i++) {
    updater.localMapping[i] = builder.addVar(into, from->getLocalType(i));
  }

  if (hoistCall) {
    // Wrap the existing function body in a block we can branch out of before
    // entering the inlined function body. This block must have a name that is
    // different from any other block name above the branch.
    auto intoNames = BranchUtils::BranchAccumulator::get(into->body);
    auto bodyName = Names::getValidName(Name("__original_body"), [&](Name test) { return !intoNames.count(test); });
    if (retType.isConcrete()) {
      into->body = builder.makeBlock(bodyName, {builder.makeReturn(into->body)}, Type::none);
    } else {
      into->body = builder.makeBlock(bodyName, {into->body, builder.makeReturn()}, Type::none);
    }

    // Sequence the inlined function body after the original caller body.
    into->body = builder.makeSequence(into->body, block, retType);

    // Replace the original callsite with an expression that assigns the
    // operands into the params and branches out of the original body.
    auto numParams = from->getParams().size();
    if (numParams) {
      auto *branchBlock = builder.makeBlock();
      for (Index i = 0; i < numParams; i++) {
        branchBlock->list.push_back(builder.makeLocalSet(updater.localMapping[i], call->operands[i]));
      }
      branchBlock->list.push_back(builder.makeBreak(bodyName));
      branchBlock->finalize(Type::unreachable);
      *action.callSite = branchBlock;
    } else {
      *action.callSite = builder.makeBreak(bodyName);
    }
  } else {
    // Assign the operands into the params
    for (Index i = 0; i < from->getParams().size(); i++) {
      block->list.push_back(builder.makeLocalSet(updater.localMapping[i], call->operands[i]));
    }
    // Zero out the vars (as we may be in a loop, and may depend on their
    // zero-init value
    for (Index i = 0; i < from->vars.size(); i++) {
      auto type = from->vars[i];
      if (!LiteralUtils::canMakeZero(type)) {
        // Non-zeroable locals do not need to be zeroed out. As they have no
        // zero value they by definition should not be used before being written
        // to, so any value we set here would not be observed anyhow.
        continue;
      }
      block->list.push_back(builder.makeLocalSet(updater.localMapping[from->getVarIndexBase() + i],
                                                 LiteralUtils::makeZero(type, *module)));
    }
    if (call->isReturn) {
      assert(!action.insideATry);
      if (retType.isConcrete()) {
        *action.callSite = builder.makeReturn(block);
      } else {
        *action.callSite = builder.makeSequence(block, builder.makeReturn());
      }
    } else {
      *action.callSite = block;
    }
  }

  // Generate and update the inlined contents
  auto *contents = ExpressionManipulator::copy(from->body, *module);
  debuginfo::copyBetweenFunctions(from->body, contents, from, into);
  updater.walk(contents);
  block->list.push_back(contents);
  block->type = retType;

  // The ReFinalize below will handle propagating unreachability if we need to
  // do so, that is, if the call was reachable but now the inlined content we
  // replaced it with was unreachable. The opposite case requires special
  // handling: ReFinalize works under the assumption that code can become
  // unreachable, but it does not go back from that state. But inlining can
  // cause that:
  //
  //  (call $A                               ;; an unreachable call
  //    (unreachable)
  //  )
  // =>
  //  (block $__inlined_A_body (result i32)  ;; reachable code after inlining
  //    (unreachable)
  //  )
  //
  // That is, if the called function wraps the input parameter in a block with a
  // declared type, then the block is not unreachable. And then we might error
  // if the outside expects the code to be unreachable - perhaps it only
  // validates that way. To fix this, if the call was unreachable then we make
  // the inlined code unreachable as well. That also maximizes DCE
  // opportunities by propagating unreachability as much as possible.
  //
  // (Note that we don't need to do this for a return_call, which is always
  // unreachable anyhow.)
  if (call->type == Type::unreachable && !call->isReturn) {
    // Make the replacement code unreachable. Note that we can't just add an
    // unreachable at the end, as the block might have breaks to it (returns are
    // transformed into those).
    Expression *old = block;
    if (old->type.isConcrete()) {
      old = builder.makeDrop(old);
    }
    *action.callSite = builder.makeSequence(old, builder.makeUnreachable());
  }
}

// Updates the outer function after we inline into it. This is a general
// operation that does not depend on what we inlined, it just makes sure that we
// refinalize everything, have no duplicate break labels, etc.
static void updateAfterInlining(Module *module, Function *into) {
  // Anything we inlined into may now have non-unique label names, fix it up.
  // Note that we must do this before refinalization, as otherwise duplicate
  // block labels can lead to errors (the IR must be valid before we
  // refinalize).
  wasm::UniqueNameMapper::uniquify(into->body);
  // Inlining unreachable contents can make things in the function we inlined
  // into unreachable.
  ReFinalize().walkFunctionInModule(into, module);
  // New locals we added may require fixups for nondefaultability.
  // FIXME Is this not done automatically?
  TypeUpdating::handleNonDefaultableLocals(into, *module);
}

static void doInlining(Module *module, Function *into, const InliningAction &action, PassOptions &options) {
  doCodeInlining(module, into, action, options);
  updateAfterInlining(module, into);
}

// A map of function names to the inlining actions we've decided to actually
// perform in them.
using ChosenActions = std::unordered_map<Name, std::vector<InliningAction>>;

// A pass that calls doInlining() on a bunch of actions that were chosen to
// perform.
struct DoInlining : public Pass {
  bool isFunctionParallel() override { return true; }

  std::unique_ptr<Pass> create() override { return std::make_unique<DoInlining>(chosenActions); }

  DoInlining(const ChosenActions &chosenActions) : chosenActions(chosenActions) {}

  void runOnFunction(Module *module, Function *func) override {
    auto iter = chosenActions.find(func->name);
    // We must be called on a function that we actually want to inline into.
    assert(iter != chosenActions.end());
    const auto &actions = iter->second;
    assert(!actions.empty());

    // Inline all the code first, then update func once at the end (which saves
    // e.g. running ReFinalize after each action, of which there might be many).
    for (auto action : actions) {
      doCodeInlining(module, func, action, getPassOptions());
    }
    updateAfterInlining(module, func);
  }

private:
  const ChosenActions &chosenActions;
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
        infos[ex->value].usedGlobally = true;
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
      InliningMode inliningMode = getInliningMode(func->name);
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
      if (inlinedUses.count(func->name)) {
        continue;
      }
      for (auto &action : state.actionsForFunction[name]) {
        auto *inlinedFunction = action.contents;
        // if we've inlined into a function, don't inline it in this iteration,
        // avoid risk of races
        // note that we do not risk stalling progress, as each iteration() will
        // inline at least one call before hitting this
        if (inlinedInto.count(inlinedFunction)) {
          continue;
        }
        Name inlinedName = inlinedFunction->name;
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
      return inlinedUses.count(name) && inlinedUses[name] == info.refs && !info.usedGlobally;
    });
  }

  // See explanation in InliningAction.
  Index inlinedNameHint = 0;

  // Decide for a given function whether to inline, and if so in what mode.
  InliningMode getInliningMode(Name name) {
    wasm::Function *func = module->getFunction(name);
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
    InliningMode inliningMode = infos[func->name].inliningMode;
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
    auto estimatedBinarySize = Measurer::BytesPerExpr * combinedSize;
    // The limit is arbitrary, but based on the links above. It is a very high
    // value that should appear very rarely in practice (for example, it does
    // not occur on the Emscripten benchmark suite of real-world codebases).
    const Index MaxCombinedBinarySize = 400 * 1024;
    return estimatedBinarySize < MaxCombinedBinarySize;
  }
};

} // anonymous namespace

//
// InlineMain
//
// Inline __original_main into main, if they exist. This works around the odd
// thing that clang/llvm currently do, where __original_main contains the user's
// actual main (this is done as a workaround for main having two different
// possible signatures).
//

static const char *MAIN = "main";
static const char *ORIGINAL_MAIN = "__original_main";

struct InlineMainPass : public Pass {
  void run(Module *module) override {
    auto *main = module->getFunctionOrNull(MAIN);
    auto *originalMain = module->getFunctionOrNull(ORIGINAL_MAIN);
    if (!main || main->imported() || !originalMain || originalMain->imported()) {
      return;
    }
    FindAllPointers<Call> calls(main->body);
    Expression **callSite = nullptr;
    for (auto *call : calls.list) {
      if ((*call)->cast<Call>()->target == ORIGINAL_MAIN) {
        if (callSite) {
          // More than one call site.
          return;
        }
        callSite = call;
      }
    }
    if (!callSite) {
      // No call at all.
      return;
    }
    doInlining(module, main, InliningAction(callSite, originalMain, true), getPassOptions());
  }
};

} // namespace warpo::passes

wasm::Pass *warpo::passes::createAdvancedInliningPass() { return new Inlining(); }
