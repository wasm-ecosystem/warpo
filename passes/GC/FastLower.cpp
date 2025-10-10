// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <concepts>
#include <fmt/base.h>
#include <map>
#include <memory>
#include <set>
#include <stack>

#include "../helper/BinaryenExt.hpp"
#include "../helper/Matcher.hpp"
#include "BaseLower.hpp"
#include "FastLower.hpp"
#include "GCInfo.hpp"
#include "PrologEpilogInserter.hpp"
#include "pass.h"
#include "support/index.h"
#include "support/name.h"
#include "warpo/support/Debug.hpp"
#include "warpo/support/DynBitSet.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "GCFastLower"

namespace warpo::passes::gc {

namespace {

struct ToStackReplacer : public wasm::WalkerPass<wasm::PostWalker<ToStackReplacer>> {
  std::shared_ptr<MaxShadowStackOffsets> maxShadowStackOffsets_;
  struct CallInfo {
    std::set<uint32_t> slotsUsedByCall;
  };
  std::stack<CallInfo> nestedCallInfos_;
  std::map<wasm::Index, uint32_t> localMappedSlots_;
  DynBitset currentAllocatedSlots_{0U};

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::unique_ptr<Pass>{new ToStackReplacer(maxShadowStackOffsets_)}; }

  static void doEnterCallLike(ToStackReplacer *self, wasm::Expression **currp) {
    if (auto expr = (*currp)->dynCast<wasm::Call>())
      return self->enter(expr);
    if (auto expr = (*currp)->dynCast<wasm::CallIndirect>())
      return self->enter(expr);
  }
  static void doLeaveCallLike(ToStackReplacer *self, wasm::Expression **currp) {
    if ((*currp)->dynCast<wasm::Call>() != nullptr)
      return self->leave();
    if ((*currp)->dynCast<wasm::CallIndirect>() != nullptr)
      return self->leave();
  }
  static void scan(ToStackReplacer *self, wasm::Expression **currp) {
    wasm::Expression const *const curr = *currp;
    if (curr->is<wasm::Call>() || curr->is<wasm::CallIndirect>())
      self->pushTask(ToStackReplacer::doLeaveCallLike, currp);

    wasm::PostWalker<ToStackReplacer>::scan(self, currp);

    if (curr->is<wasm::Call>() || curr->is<wasm::CallIndirect>())
      self->pushTask(ToStackReplacer::doEnterCallLike, currp);
  }

  void visitLocalSet(wasm::LocalSet *expr) {
    using namespace matcher;
    auto m = isLocalSet(local_set::v(isCall(call::callee(FnLocalToStack))));
    if (!m(*expr))
      return;
    wasm::Call *const call = expr->value->cast<wasm::Call>();
    if (call->operands.size() != 1U)
      __builtin_trap();
    wasm::Builder b{*getModule()};
    uint32_t const slot = allocSlotForLocal(expr->index);
    call->operands.push_back(b.makeConst(wasm::Literal(4U * slot)));
  }

  template <class T>
    requires(std::same_as<T, wasm::Call> || std::same_as<T, wasm::CallIndirect>)
  void enter(T *expr) {
    // reserve stack space for local
    wasm::Function *const f = getFunction();
    CallInfo callInfo;
    wasm::Builder b{*getModule()};
    for (wasm::Expression *operand : expr->operands) {
      wasm::Call *const tostackCall = operand->dynCast<wasm::Call>();
      if (tostackCall && tostackCall->target == FnTmpToStack) {
        uint32_t const slot = allocSlot();
        tostackCall->operands.push_back(b.makeConst(wasm::Literal{4U * slot}));
        callInfo.slotsUsedByCall.insert(slot);
      }
    }
    if (support::isDebug(PASS_NAME, f->name.str))
      for (uint32_t const slot : callInfo.slotsUsedByCall)
        fmt::println("[" PASS_NAME "] in fn '{}' alloc {}", f->name.str, slot);
    nestedCallInfos_.push(callInfo);
  }
  void leave() {
    CallInfo const &callInfo = nestedCallInfos_.top();
    for (uint32_t const slot : callInfo.slotsUsedByCall)
      freeSlot(slot);
    wasm::Function *const f = getFunction();
    if (support::isDebug(PASS_NAME, f->name.str))
      for (uint32_t const slot : callInfo.slotsUsedByCall)
        fmt::println("[" PASS_NAME "] in fn '{}' free {}", f->name.str, slot);
    nestedCallInfos_.pop();
  }

  static std::shared_ptr<MaxShadowStackOffsets> addToPass(wasm::PassRunner &runner) {
    std::shared_ptr<MaxShadowStackOffsets> maxShadowStackOffsets{new MaxShadowStackOffsets()};
    for (std::unique_ptr<wasm::Function> const &f : runner.wasm->functions) {
      (*maxShadowStackOffsets)[f.get()] = 0U;
    }
    runner.add(std::unique_ptr<wasm::Pass>(new ToStackReplacer(maxShadowStackOffsets)));
    return maxShadowStackOffsets;
  }

private:
  uint32_t allocSlotForLocal(wasm::Index const localIndex) {
    auto it = localMappedSlots_.find(localIndex);
    if (it != localMappedSlots_.end())
      return it->second;
    uint32_t const slot = allocSlot();
    localMappedSlots_[localIndex] = slot;
    wasm::Function *const f = getFunction();
    if (support::isDebug(PASS_NAME, f->name.str))
      fmt::println("[" PASS_NAME "] in fn '{}' local idx {} -> {}", f->name.str, localIndex, slot);
    return slot;
  }
  void freeSlot(uint32_t slot) {
    assert(currentAllocatedSlots_.get(slot) == true && "double free?");
    currentAllocatedSlots_.set(slot, false);
  }
  uint32_t allocSlot() {
    for (size_t i = 0, k = currentAllocatedSlots_.size(); i < k; i++) {
      if (!currentAllocatedSlots_.get(i)) {
        currentAllocatedSlots_.set(i, true);
        return i;
      }
    }
    size_t const size = currentAllocatedSlots_.size();
    currentAllocatedSlots_.resize(size + 1U);
    currentAllocatedSlots_.set(size, true);
    (*maxShadowStackOffsets_)[getFunction()] = ShadowStackElementSize * currentAllocatedSlots_.size();
    return size;
  }

  explicit ToStackReplacer(std::shared_ptr<MaxShadowStackOffsets> const &maxShadowStackOffsets)
      : maxShadowStackOffsets_(maxShadowStackOffsets) {}
};

} // namespace

void FastLower::run(wasm::Module *m) {
  wasm::PassRunner runner{getPassRunner()};
  std::shared_ptr<MaxShadowStackOffsets> const maxShadowStackOffsets_ = ToStackReplacer::addToPass(runner);
  runner.add(std::unique_ptr<Pass>(new PrologEpilogInserter(nullptr, maxShadowStackOffsets_)));
  runner.run();

  wasm::Type const i32 = wasm::Type::i32;
  wasm::Builder b{*m};
  wasm::Name const memoryName = m->memories.front()->name;

  addStackStackOperationFunction(m);

  if (wasm::Function *const tmpToStack = m->getFunctionOrNull(FnTmpToStack); tmpToStack) {
    setAsUnImported(tmpToStack);
    tmpToStack->setParams(wasm::Type{i32, i32});
    assert(tmpToStack->getResults() == i32);
    wasm::Expression *const address =
        b.makeBinary(wasm::BinaryOp::AddInt32, b.makeGlobalGet(VarStackPointer, i32), b.makeLocalGet(1, i32));
    tmpToStack->body = b.makeBlock({
        b.makeStore(4, 0, 1, address, b.makeLocalGet(0, i32), i32, memoryName),
        b.makeLocalGet(0, i32),
    });
  }

  if (wasm::Function *const localToStack = m->getFunctionOrNull(FnLocalToStack); localToStack) {
    setAsUnImported(localToStack);
    localToStack->setParams(wasm::Type{i32, i32});
    assert(localToStack->getResults() == i32);
    wasm::Expression *const address =
        b.makeBinary(wasm::BinaryOp::AddInt32, b.makeGlobalGet(VarStackPointer, i32), b.makeLocalGet(1, i32));
    localToStack->body = b.makeBlock({
        b.makeStore(4, 0, 1, address, b.makeLocalGet(0, i32), i32, memoryName),
        b.makeLocalGet(0, i32),
    });
  }
}

} // namespace warpo::passes::gc
