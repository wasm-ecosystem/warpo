#include <algorithm>
#include <cassert>
#include <cstddef>
#include <map>
#include <memory>
#include <optional>

#include "../helper/FindExpr.hpp"
#include "../helper/ToString.hpp"
#include "GCInfo.hpp"
#include "ShrinkWrap.hpp"
#include "StackAssigner.hpp"
#include "ToStackLower.hpp"
#include "fmt/base.h"
#include "literal.h"
#include "support/Debug.hpp"
#include "support/index.h"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "TO_STACK_LOWER"

namespace warpo::passes::gc {

void ToStackCallLower::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition const &stackPosition = stackPositions_->at(func);
  StackInsertPoint const &insertPoint = stackInsertPositions_->at(func);
  uint32_t const maxShadowStackOffset = replaceCallExprrunOnFunction(m, func, stackPosition);
  if (maxShadowStackOffset == 0)
    return;
  wasm::Type const resultType = func->getResults();
  std::optional<wasm::Index> const scratchReturnValueLocalIndex =
      (func->getResults() == wasm::Type::none) ? std::nullopt
                                               : std::optional<wasm::Index>{wasm::Builder::addVar(func, resultType)};
  enum class OptInsertState { None, PrologueOnly, PrologueAndEpilogue };
  OptInsertState optState = OptInsertState::None;
  if (insertPoint.prologue != nullptr && insertPoint.epilogue != nullptr) {
    bool const success = tryInsertPrologueAndEpilogue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex,
                                                      insertPoint.prologue, insertPoint.epilogue);
    if (success)
      optState = OptInsertState::PrologueAndEpilogue;
  }
  if (insertPoint.prologue != nullptr && insertPoint.epilogue == nullptr) {
    // when inserting prologue, we should make sure epilogue is in the exit BB.
    bool const success =
        tryInsertPrologue(m, func, maxShadowStackOffset, scratchReturnValueLocalIndex, insertPoint.prologue);
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

uint32_t ToStackCallLower::replaceCallExprrunOnFunction(wasm::Module *m, wasm::Function *func,
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
void ToStackCallLower::replaceReturnExprWithEpilogue(wasm::Module *m, wasm::Function *func,
                                                     uint32_t maxShadowStackOffset,
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

static bool canInsertBefore(wasm::Function *func, wasm::Expression *targetExpr) {
  if (targetExpr->is<wasm::GlobalGet>() || targetExpr->is<wasm::LocalGet>() || targetExpr->is<wasm::Const>())
    return true;
  fmt::println("[" PASS_NAME "] fn '{}', insert before {}", func->name.str, toString(targetExpr));
  return false;
}
static void insertBefore(wasm::Function *func, wasm::Expression *targetExpr, wasm::Builder &b,
                         wasm::Expression *insertedExpr) {
  assert(insertedExpr->type == wasm::Type::none);
  wasm::Expression **ptr = findExpressionPointer(targetExpr, func);
  switch (targetExpr->_id) {
  case wasm::Expression::GlobalGetId:
  case wasm::Expression::LocalGetId:
  case wasm::Expression::ConstId:
    *ptr = b.makeBlock({insertedExpr, *ptr}, (*ptr)->type);
    break;
  default:
    __builtin_unreachable();
  }
}
static bool canInsertAfter(wasm::Function *func, wasm::Expression *targetExpr) {
  if (targetExpr->type == wasm::Type::none)
    return true;
  if (targetExpr->is<wasm::Return>())
    return true;
  fmt::println("[" PASS_NAME "] fn '{}', insert after {}", func->name.str, toString(targetExpr));
  return false;
}
static void insertAfter(wasm::Function *func, wasm::Expression *targetExpr, wasm::Builder &b,
                        wasm::Expression *insertedExpr) {
  assert(insertedExpr->type == wasm::Type::none);
  if (targetExpr->type == wasm::Type::none) {
    wasm::Expression **ptr = findExpressionPointer(targetExpr, func);
    *ptr = b.makeBlock({*ptr, insertedExpr}, wasm::Type::none);
    return;
  }
  if (auto *const returnExpr = targetExpr->dynCast<wasm::Return>()) {
    if (returnExpr->value == nullptr) {
      returnExpr->value = insertedExpr;
    } else {
      wasm::Type const localType = returnExpr->value->type;
      wasm::Index const tmpLocal = b.addVar(func, localType);
      returnExpr->value = b.makeBlock(
          {b.makeLocalSet(tmpLocal, returnExpr->value), insertedExpr, b.makeLocalGet(tmpLocal, localType)}, localType);
    }
    return;
  }
}

bool ToStackCallLower::tryInsertPrologueAndEpilogue(wasm::Module *m, wasm::Function *func,
                                                    uint32_t maxShadowStackOffset,
                                                    std::optional<wasm::Index> const &scratchReturnValueLocalIndex,
                                                    wasm::Expression *prologue, wasm::Expression *epilogue) {
  wasm::Type const resultType = func->getResults();
  wasm::Builder b{*m};

  bool const isInsertedPrologue = canInsertBefore(func, prologue);
  bool const isInsertedEpilogue = canInsertAfter(func, epilogue);
  if (isInsertedPrologue && isInsertedEpilogue) {
    insertBefore(
        func, prologue, b,
        b.makeCall("~lib/rt/__decrease_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    insertAfter(
        func, epilogue, b,
        b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
  }
  return isInsertedPrologue && isInsertedEpilogue;
}

bool ToStackCallLower::tryInsertPrologue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                         std::optional<wasm::Index> const &scratchReturnValueLocalIndex,
                                         wasm::Expression *prologue) {
  wasm::Type const resultType = func->getResults();
  bool const isInsertedPrologue = canInsertBefore(func, prologue);
  wasm::Builder b{*m};
  if (isInsertedPrologue) {
    fmt::println("[" PASS_NAME "] insert prologue to function '{}' before {}", func->name.str, toString(prologue));
    insertBefore(
        func, prologue, b,
        b.makeCall("~lib/rt/__decrease_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
  }
  return isInsertedPrologue;
}

void ToStackCallLower::insertDefaultPrologueAndEpilogue(
    wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
    std::optional<wasm::Index> const &scratchReturnValueLocalIndex) {
  wasm::Type const resultType = func->getResults();
  wasm::Builder b{*m};
  wasm::Block *const block = b.makeBlock(std::initializer_list<wasm::Expression *>{}, resultType);
  if (resultType == wasm::Type::none) {
    block->list.push_back(
        b.makeCall("~lib/rt/__decrease_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(func->body);
    block->list.push_back(
        b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    func->body = block;
  } else {
    block->list.push_back(
        b.makeCall("~lib/rt/__decrease_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(b.makeLocalSet(scratchReturnValueLocalIndex.value(), func->body));
    block->list.push_back(
        b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(b.makeLocalGet(scratchReturnValueLocalIndex.value(), resultType));
  }
  func->body = block;
}

void ToStackCallLower::insertDefaultEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                             std::optional<wasm::Index> const &scratchReturnValueLocalIndex) {
  wasm::Type const resultType = func->getResults();
  wasm::Builder b{*m};
  wasm::Block *const block = b.makeBlock(std::initializer_list<wasm::Expression *>{}, resultType);
  if (resultType == wasm::Type::none) {
    block->list.push_back(func->body);
    block->list.push_back(
        b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    func->body = block;
  } else {
    block->list.push_back(b.makeLocalSet(scratchReturnValueLocalIndex.value(), func->body));
    block->list.push_back(
        b.makeCall("~lib/rt/__increase_sp", {b.makeConst(wasm::Literal(maxShadowStackOffset))}, wasm::Type::none));
    block->list.push_back(b.makeLocalGet(scratchReturnValueLocalIndex.value(), resultType));
  }
  func->body = block;
}

} // namespace warpo::passes::gc
