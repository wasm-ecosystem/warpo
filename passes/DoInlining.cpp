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

#include <cassert>

#include "DoInlining.hpp"
#include "ir/branch-utils.h"
#include "ir/drop.h"
#include "ir/literal-utils.h"
#include "ir/localize.h"
#include "ir/metadata.h"
#include "ir/names.h"
#include "ir/type-updating.h"
#include "ir/utils.h"
#include "parsing.h"
#include "pass.h"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm.h"

namespace warpo::passes {

struct Updater final : public wasm::TryDepthWalker<Updater> {
  wasm::Module *module;
  std::map<wasm::Index, wasm::Index> localMapping;
  wasm::Name returnName;
  wasm::Type resultType;
  bool isReturn;
  wasm::Builder *builder;
  wasm::PassOptions &options;

  struct ReturnCallInfo {
    // The original `return_call` or `return_call_indirect` or `return_call_ref`
    // with its operands replaced with `local.get`s.
    wasm::Expression *call;
    // The branch that is serving as the "return" part of the original
    // `return_call`.
    wasm::Break *branch;
  };

  // Collect information on return_calls in the inlined body. Each will be
  // turned into branches out of the original inlined body followed by
  // non-return version of the original `return_call`, followed by a branch out
  // to the caller. The branch labels will be filled in at the end of the walk.
  std::vector<ReturnCallInfo> returnCallInfos;

  explicit Updater(wasm::PassOptions &options) : module(nullptr), isReturn(false), builder(nullptr), options(options) {}

  void visitReturn(wasm::Return *curr) { replaceCurrent(builder->makeBreak(returnName, curr->value)); }

  template <typename T> void handleReturnCall(T *curr, wasm::Signature sig) {
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
      wasm::Block *const childBlock =
          wasm::ChildLocalizer(curr, getFunction(), *module, options).getChildrenReplacement();
      wasm::Break *const branch = builder->makeBreak(wasm::Name());
      childBlock->list.push_back(branch);
      childBlock->type = wasm::Type::unreachable;
      replaceCurrent(childBlock);

      curr->isReturn = false;
      curr->type = sig.results;
      returnCallInfos.push_back({curr, branch});
    }
  }

  void visitCall(wasm::Call *curr) { handleReturnCall(curr, module->getFunction(curr->target)->getSig()); }

  void visitCallIndirect(wasm::CallIndirect *curr) { handleReturnCall(curr, curr->heapType.getSignature()); }

  void visitCallRef(wasm::CallRef *curr) {
    wasm::Type const targetType = curr->target->type;
    if (!targetType.isSignature()) {
      // We don't know what type the call should return, but it will also never
      // be reached, so we don't need to do anything here.
      return;
    }
    handleReturnCall(curr, targetType.getHeapType().getSignature());
  }

  void visitLocalGet(wasm::LocalGet *curr) { curr->index = localMapping[curr->index]; }

  void visitLocalSet(wasm::LocalSet *curr) { curr->index = localMapping[curr->index]; }

  void walk(wasm::Expression *&curr) {
    PostWalker<Updater>::walk(curr);
    if (returnCallInfos.empty()) {
      return;
    }

    wasm::Block *body = builder->blockify(curr);
    curr = body;
    auto blockNames = wasm::BranchUtils::BranchAccumulator::get(body);

    for (wasm::Index i = 0; i < returnCallInfos.size(); ++i) {
      auto &info = returnCallInfos[i];

      // Add a block containing the previous body and a branch up to the caller.
      // Give the block a name that will allow this return_call's original
      // callsite to branch out of it then execute the call before returning to
      // the caller.
      auto name =
          wasm::Names::getValidName("__return_call", [&](wasm::Name test) { return blockNames.count(test) == 0U; }, i);
      blockNames.insert(name);
      info.branch->name = name;
      wasm::Block *const oldBody = builder->makeBlock(body->list, body->type);
      body->list.clear();

      if (resultType.isConcrete()) {
        body->list.push_back(builder->makeBlock(name, {builder->makeBreak(returnName, oldBody)}, wasm::Type::none));
      } else {
        oldBody->list.push_back(builder->makeBreak(returnName));
        oldBody->name = name;
        oldBody->type = wasm::Type::none;
        body->list.push_back(oldBody);
      }
      body->list.push_back(info.call);
      body->finalize(resultType);
    }
  }
};

// Core inlining logic. Modifies the outside function (adding locals as
// needed) by copying the inlined code into it.
static void doCodeInlining(wasm::Module *module, wasm::Function *into, const InliningAction &action,
                           wasm::PassOptions &options) {
  wasm::Function *from = action.contents;
  auto *call = (*action.callSite)->cast<wasm::Call>();

  // Works for return_call, too
  wasm::Type retType = module->getFunction(call->target)->getResults();

  // Build the block that will contain the inlined contents.
  wasm::Builder builder(*module);
  auto *block = builder.makeBlock();
  auto name = std::string("__inlined_func$") + from->name.toString();
  if (action.nameHint != 0U) {
    name += '$' + std::to_string(action.nameHint);
  }
  block->name = wasm::Name(name);

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
  bool const hoistCall = call->isReturn && action.insideATry;
  if (wasm::BranchUtils::hasBranchTarget(from->body, block->name) ||
      (!hoistCall && wasm::BranchUtils::BranchSeeker::has(call, block->name))) {
    auto fromNames = wasm::BranchUtils::getBranchTargets(from->body);
    auto callNames = hoistCall ? wasm::BranchUtils::NameSet{} : wasm::BranchUtils::BranchAccumulator::get(call);
    block->name = wasm::Names::getValidName(
        block->name, [&](wasm::Name test) { return (fromNames.count(test) == 0U) && (callNames.count(test) == 0U); });
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
  for (wasm::Index i = 0; i < from->getNumLocals(); i++) {
    updater.localMapping[i] = wasm::Builder::addVar(into, from->getLocalType(i));
  }

  if (hoistCall) {
    // Wrap the existing function body in a block we can branch out of before
    // entering the inlined function body. This block must have a name that is
    // different from any other block name above the branch.
    auto intoNames = wasm::BranchUtils::BranchAccumulator::get(into->body);
    auto bodyName = wasm::Names::getValidName(wasm::Name("__original_body"),
                                              [&](wasm::Name test) { return (intoNames.count(test) == 0U); });
    if (retType.isConcrete()) {
      into->body = builder.makeBlock(bodyName, {builder.makeReturn(into->body)}, wasm::Type::none);
    } else {
      into->body = builder.makeBlock(bodyName, {into->body, builder.makeReturn()}, wasm::Type::none);
    }

    // Sequence the inlined function body after the original caller body.
    into->body = builder.makeSequence(into->body, block, retType);

    // Replace the original callsite with an expression that assigns the
    // operands into the params and branches out of the original body.
    auto numParams = from->getParams().size();
    if (numParams != 0U) {
      auto *branchBlock = builder.makeBlock();
      for (wasm::Index i = 0; i < numParams; i++) {
        branchBlock->list.push_back(builder.makeLocalSet(updater.localMapping[i], call->operands[i]));
      }
      branchBlock->list.push_back(builder.makeBreak(bodyName));
      branchBlock->finalize(wasm::Type::unreachable);
      *action.callSite = branchBlock;
    } else {
      *action.callSite = builder.makeBreak(bodyName);
    }
  } else {
    // Assign the operands into the params
    for (wasm::Index i = 0; i < from->getParams().size(); i++) {
      block->list.push_back(builder.makeLocalSet(updater.localMapping[i], call->operands[i]));
    }
    // Zero out the vars (as we may be in a loop, and may depend on their
    // zero-init value
    for (wasm::Index i = 0; i < from->vars.size(); i++) {
      auto type = from->vars[i];
      if (!wasm::LiteralUtils::canMakeZero(type)) {
        // Non-zeroable locals do not need to be zeroed out. As they have no
        // zero value they by definition should not be used before being written
        // to, so any value we set here would not be observed anyhow.
        continue;
      }
      block->list.push_back(builder.makeLocalSet(updater.localMapping[from->getVarIndexBase() + i],
                                                 wasm::LiteralUtils::makeZero(type, *module)));
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
  auto *contents = wasm::ExpressionManipulator::copy(from->body, *module);
  wasm::metadata::copyBetweenFunctions(from->body, contents, from, into);
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
  if (call->type == wasm::Type::unreachable && !call->isReturn) {
    // Make the replacement code unreachable. Note that we can't just add an
    // unreachable at the end, as the block might have breaks to it (returns are
    // transformed into those).
    wasm::Expression *old = block;
    if (old->type.isConcrete()) {
      old = builder.makeDrop(old);
    }
    *action.callSite = builder.makeSequence(old, builder.makeUnreachable());
  }
}

// Updates the outer function after we inline into it. This is a general
// operation that does not depend on what we inlined, it just makes sure that we
// refinalize everything, have no duplicate break labels, etc.
static void updateAfterInlining(wasm::Module *module, wasm::Function *into) {
  // Anything we inlined into may now have non-unique label names, fix it up.
  // Note that we must do this before refinalization, as otherwise duplicate
  // block labels can lead to errors (the IR must be valid before we
  // refinalize).
  wasm::UniqueNameMapper::uniquify(into->body);
  // Inlining unreachable contents can make things in the function we inlined
  // into unreachable.
  wasm::ReFinalize().walkFunctionInModule(into, module);
  // New locals we added may require fixups for nondefaultability.
  // FIXME Is this not done automatically?
  wasm::TypeUpdating::handleNonDefaultableLocals(into, *module);
}

void DoInlining::runOnFunction(wasm::Module *module, wasm::Function *func) {
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

} // namespace warpo::passes
