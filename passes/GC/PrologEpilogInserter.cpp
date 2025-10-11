// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <algorithm>
#include <cassert>
#include <cstddef>
#include <map>
#include <memory>
#include <optional>

#include "../helper/ExprInserter.hpp"
#include "../helper/FindExpr.hpp"
#include "../helper/ToString.hpp"
#include "GCInfo.hpp"
#include "PrologEpilogInserter.hpp"
#include "ShrinkWrap.hpp"
#include "fmt/base.h"
#include "literal.h"
#include "support/index.h"
#include "support/name.h"
#include "warpo/support/Debug.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "PrologEpilogInserter"

namespace warpo::passes::gc {

uint32_t MaxShadowStackOffsetsFromStackPositions::at(wasm::Function *func) const {
  StackPosition const &stackPosition = stackPositions_->at(func);
  auto const maxElement = std::max_element(stackPosition.begin(), stackPosition.end(),
                                           [](auto const &a, auto const &b) { return a.second < b.second; });
  return maxElement != stackPosition.end() ? maxElement->second + ShadowStackElementSize : 0U;
}

void PrologEpilogInserter::runOnFunction(wasm::Module *m, wasm::Function *func) {
  uint32_t const maxShadowStackOffset = maxShadowStackOffsets_->at(func);
  InsertPositionHint const insertPointHint =
      insertPositionHints_ ? insertPositionHints_->at(func) : InsertPositionHint{};
  if (maxShadowStackOffset == 0)
    return;
  wasm::Type const resultType = func->getResults();
  std::optional<wasm::Index> const scratchReturnValueLocalIndex =
      (func->getResults() == wasm::Type::none) ? std::nullopt
                                               : std::optional<wasm::Index>{wasm::Builder::addVar(func, resultType)};
  enum class OptInsertState { None, PrologueOnly, PrologueAndEpilogue };
  OptInsertState optState = OptInsertState::None;
  if (insertPointHint.prologue != nullptr && insertPointHint.epilogue != nullptr) {
    bool const success = tryInsertPrologueAndEpilogue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex,
                                                      insertPointHint.prologue, insertPointHint.epilogue);
    if (success)
      optState = OptInsertState::PrologueAndEpilogue;
  }
  if (insertPointHint.prologue != nullptr && insertPointHint.epilogue == nullptr) {
    // when inserting prologue, we should make sure epilogue is in the exit BB.
    bool const success =
        tryInsertPrologue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex, insertPointHint.prologue);
    if (success)
      optState = OptInsertState::PrologueOnly;
  }
  switch (optState) {
  case OptInsertState::None:
    if (support::isDebug(PASS_NAME, func->name.str)) {
      fmt::println("[" PASS_NAME "] fn '{}' insert prologue in {}, epilogue in {}", func->name.str, "entry", "exit");
    }
    replaceReturnExprWithEpilogue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex);
    insertDefaultPrologueAndEpilogue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex);
    break;
  case OptInsertState::PrologueOnly:
    if (support::isDebug(PASS_NAME, func->name.str)) {
      fmt::println("[" PASS_NAME "] fn '{}' insert prologue in {}, epilogue in {}", func->name.str, "opt", "exit");
    }
    replaceReturnExprWithEpilogue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex);
    insertDefaultEpilogue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex);
    break;
  case OptInsertState::PrologueAndEpilogue:
    if (support::isDebug(PASS_NAME, func->name.str)) {
      fmt::println("[" PASS_NAME "] fn '{}' insert prologue in {}, epilogue in {}", func->name.str, "opt", "opt");
    }
    break;
  }
}

void PrologEpilogInserter::replaceReturnExprWithEpilogue(
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
              b.makeCall(FnIncreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset_))}, wasm::Type::none),
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
              b.makeCall(FnIncreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset_))}, wasm::Type::none),
              expr,
          },
          wasm::Type::unreachable));
    }
  };
  wasm::Type const resultType = func->getResults();
  wasm::Builder const b{*m};
  if (resultType == wasm::Type::none) {
    ReturnWithoutResultReplacer returnReplacer{maxShadowStackOffset};
    returnReplacer.walkFunctionInModule(func, m);
  } else {
    ReturnWithResultReplacer returnReplacer{scratchReturnValueLocalIndex.value(), maxShadowStackOffset, resultType};
    returnReplacer.walkFunctionInModule(func, m);
  }
}

bool PrologEpilogInserter::tryInsertPrologueAndEpilogue(wasm::Module *m, wasm::Function *func,
                                                        uint32_t maxShadowStackOffset,
                                                        std::optional<wasm::Index> const &scratchReturnValueLocalIndex,
                                                        wasm::Expression *prologue, wasm::Expression *epilogue) {
  static_cast<void>(scratchReturnValueLocalIndex);
  wasm::Builder b{*m};

  ExprInserter inserter{func};

  bool const isInsertedPrologue = inserter.canInsertBefore(prologue);
  bool const isInsertedEpilogue = inserter.canInsertAfter(epilogue);
  if (isInsertedPrologue && isInsertedEpilogue) {
    wasm::Expression **const prologuePtr = findExprPointer(prologue, func);
    wasm::Expression **const epiloguePtr = findExprPointer(epilogue, func);
    assert(prologuePtr != nullptr);
    assert(epiloguePtr != nullptr);
    if (support::isDebug(PASS_NAME, func->name.str))
      fmt::println("[" PASS_NAME "] fn '{}' insert prologue in {}", func->name.str, toString(prologue));
    if (support::isDebug(PASS_NAME, func->name.str))
      fmt::println("[" PASS_NAME "] fn '{}' insert epilogue in {}", func->name.str, toString(epilogue));
    inserter.insertBefore(
        b, b.makeCall(FnDecreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none), prologuePtr);
    inserter.insertAfter(
        b, b.makeCall(FnIncreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none), epiloguePtr);
  }
  return isInsertedPrologue && isInsertedEpilogue;
}

bool PrologEpilogInserter::tryInsertPrologue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                             std::optional<wasm::Index> const &scratchReturnValueLocalIndex,
                                             wasm::Expression *prologue) {
  static_cast<void>(scratchReturnValueLocalIndex);
  ExprInserter inserter{func};
  bool const isInsertedPrologue = inserter.canInsertBefore(prologue);
  wasm::Builder b{*m};
  if (isInsertedPrologue) {
    wasm::Expression **const prologuePtr = findExprPointer(prologue, func);
    assert(prologuePtr != nullptr);
    if (support::isDebug(PASS_NAME, func->name.str))
      fmt::println("[" PASS_NAME "] fn '{}' insert prologue in {}", func->name.str, toString(prologue));
    inserter.insertBefore(
        b, b.makeCall(FnDecreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none), prologuePtr);
  }
  return isInsertedPrologue;
}

void PrologEpilogInserter::insertDefaultPrologueAndEpilogue(
    wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
    std::optional<wasm::Index> const &scratchReturnValueLocalIndex) {
  wasm::Type const resultType = func->getResults();
  wasm::Builder b{*m};
  wasm::Block *const block = b.makeBlock(std::initializer_list<wasm::Expression *>{}, resultType);
  if (resultType == wasm::Type::none) {
    block->list.push_back(
        b.makeCall(FnDecreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(func->body);
    block->list.push_back(
        b.makeCall(FnIncreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    func->body = block;
  } else {
    block->list.push_back(
        b.makeCall(FnDecreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(b.makeLocalSet(scratchReturnValueLocalIndex.value(), func->body));
    block->list.push_back(
        b.makeCall(FnIncreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(b.makeLocalGet(scratchReturnValueLocalIndex.value(), resultType));
  }
  func->body = block;
}

void PrologEpilogInserter::insertDefaultEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                                 std::optional<wasm::Index> const &scratchReturnValueLocalIndex) {
  wasm::Type const resultType = func->getResults();
  wasm::Builder b{*m};
  wasm::Block *const block = b.makeBlock(std::initializer_list<wasm::Expression *>{}, resultType);
  if (resultType == wasm::Type::none) {
    block->list.push_back(func->body);
    block->list.push_back(
        b.makeCall(FnIncreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    func->body = block;
  } else {
    block->list.push_back(b.makeLocalSet(scratchReturnValueLocalIndex.value(), func->body));
    block->list.push_back(
        b.makeCall(FnIncreaseSP, {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(b.makeLocalGet(scratchReturnValueLocalIndex.value(), resultType));
  }
  func->body = block;
}

} // namespace warpo::passes::gc
