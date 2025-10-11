// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <memory>
#include <vector>

#include "ExprInserter.hpp"
#include "ToString.hpp"
#include "fmt/base.h"
#include "wasm-builder.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "EXPR_INSERTER"

namespace warpo::passes {

static bool isTerminator(wasm::Expression *expr) {
  return expr->is<wasm::Return>() || expr->is<wasm::Unreachable>() || expr->is<wasm::Break>();
}

bool ExprInserter::canInsertBefore(wasm::Expression *insertPosition) {
  // those instruction does not have children, so we can insert before them directly.
  if (insertPosition->is<wasm::GlobalGet>() || insertPosition->is<wasm::LocalGet>() ||
      insertPosition->is<wasm::Const>() || insertPosition->is<wasm::MemorySize>())
    return true;
  // those instruction should be inserted after the last operand
  if (insertPosition->is<wasm::Call>()) {
    wasm::Call *const call = insertPosition->cast<wasm::Call>();
    if (call->operands.empty())
      return true;
    if (canInsertAfter(call->operands.back()))
      return true;
  }
  if (insertPosition->is<wasm::LocalSet>()) {
    wasm::LocalSet *const localSet = insertPosition->cast<wasm::LocalSet>();
    if (canInsertAfter(localSet->value))
      return true;
  }
  fmt::println("[" PASS_NAME "] fn '{}', failed to insert before {}", func_->name.str, toString(insertPosition));
  return false;
}

void ExprInserter::insertBefore(wasm::Builder &b, wasm::Expression *insertedExpr,
                                wasm::Expression **insertPositionPtr) {
  assert(insertedExpr->type == wasm::Type::none);
  wasm::Expression *const insertPosition = *insertPositionPtr;
  switch (insertPosition->_id) {
  case wasm::Expression::GlobalGetId:
  case wasm::Expression::LocalGetId:
  case wasm::Expression::ConstId:
  case wasm::Expression::MemorySizeId:
    *insertPositionPtr = b.makeBlock({insertedExpr, insertPosition}, insertPosition->type);
    break;
  case wasm::Expression::CallId: {
    wasm::Call *const call = insertPosition->cast<wasm::Call>();
    if (call->operands.empty()) {
      *insertPositionPtr = b.makeBlock({insertedExpr, insertPosition}, insertPosition->type);
    } else {
      insertAfter(b, insertedExpr, &call->operands.back());
    }
    break;
  }
  case wasm::Expression::LocalSetId: {
    wasm::LocalSet *const localSet = insertPosition->cast<wasm::LocalSet>();
    insertAfter(b, insertedExpr, &localSet->value);
    break;
  }
  default:
    __builtin_unreachable();
  }
}

bool ExprInserter::canInsertAfter(wasm::Expression *insertPosition) {
  if (isTerminator(insertPosition)) {
    // special handler for terminator
    if (insertPosition->is<wasm::Unreachable>())
      return true;
    if (wasm::Return const *const expr = insertPosition->dynCast<wasm::Return>(); expr != nullptr) {
      return true;
      if (expr->value == nullptr)
        return true;
      if (canInsertAfter(expr->value))
        return true;
    }
    if (wasm::Break const *const expr = insertPosition->dynCast<wasm::Break>();
        expr != nullptr && expr->condition == nullptr) {
      return true;
      if (expr->value == nullptr)
        return true;
      if (canInsertAfter(expr->value))
        return true;
    }
  } else {
    if (insertPosition->type == wasm::Type::none)
      return true;
    if (insertPosition->type != wasm::Type::unreachable)
      return true;
  }
  fmt::println("[" PASS_NAME "] fn '{}', failed to insert after {}", func_->name.str, toString(insertPosition));
  return false;
}

void ExprInserter::insertAfter(wasm::Builder &b, wasm::Expression *insertedExpr, wasm::Expression **insertPositionPtr) {
  assert(insertedExpr->type == wasm::Type::none);
  wasm::Expression *const insertPosition = *insertPositionPtr;

  if (isTerminator(insertPosition)) {
    if (insertPosition->is<wasm::Unreachable>()) {
      *insertPositionPtr = b.makeBlock({insertedExpr, insertPosition}, wasm::Type::unreachable);
      return;
    }
    if (wasm::Return *const expr = insertPosition->dynCast<wasm::Return>(); expr != nullptr) {
      if (expr->value == nullptr) {
        *insertPositionPtr = b.makeBlock({insertedExpr, insertPosition}, wasm::Type::unreachable);
        return;
      }
      insertAfter(b, insertedExpr, &expr->value);
      return;
    }
    if (wasm::Break *const expr = insertPosition->dynCast<wasm::Break>();
        expr != nullptr && expr->condition == nullptr) {
      if (expr->value == nullptr) {
        *insertPositionPtr = b.makeBlock({insertedExpr, insertPosition}, wasm::Type::unreachable);
        return;
      }
      insertAfter(b, insertedExpr, &expr->value);
      return;
    }
  } else {
    wasm::Type const exprType = insertPosition->type;
    if (exprType == wasm::Type::none) {
      *insertPositionPtr = b.makeBlock({insertPosition, insertedExpr}, wasm::Type::none);
      return;
    }
    if (exprType != wasm::Type::unreachable) {
      wasm::Index const tmpLocal = wasm::Builder::addVar(func_, exprType);
      *insertPositionPtr = b.makeBlock(
          {
              b.makeLocalSet(tmpLocal, insertPosition),
              insertedExpr,
              b.makeLocalGet(tmpLocal, exprType),
          },
          exprType);
      return;
    }
  }
  __builtin_unreachable();
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "FindExpr.hpp"
#include "Matcher.hpp"

namespace warpo::passes::ut {

using wasm::Const, wasm::Block, wasm::Nop, wasm::Call, wasm::LocalGet, wasm::LocalSet, wasm::If, wasm::Return,
    wasm::Loop, wasm::Break;
using wasm::Type;

TEST(ExprInserter, InsertBeforeNoOperand) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeConst(1);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertBefore(insertPos));
  inserter.insertBefore(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Const>());
}

TEST(ExprInserter, InsertBeforeCallWithoutOperands) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeCall("call_tmp", {}, Type::none);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertBefore(insertPos));
  inserter.insertBefore(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Call>());
}

TEST(ExprInserter, InsertBeforeCallWithOperands) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeCall("call_tmp",
                                                 {
                                                     b.makeLocalGet(0, Type::i32),
                                                     b.makeIf(b.makeConst(0), b.makeConst(0), b.makeConst(0)),
                                                 },
                                                 Type::none);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertBefore(insertPos));
  inserter.insertBefore(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_EQ(f->body, insertPos);
  ASSERT_TRUE(insertPos->cast<Call>()->operands[0]->is<LocalGet>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->is<Block>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->cast<Block>()->list[0]->is<LocalSet>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->cast<Block>()->list[0]->cast<LocalSet>()->value->is<If>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->cast<Block>()->list[1]->is<Nop>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->cast<Block>()->list[2]->is<LocalGet>());
}

TEST(ExprInserter, InsertBeforeLocalSet) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeLocalSet(0, b.makeConst(1));
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertBefore(insertPos));
  inserter.insertBefore(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_EQ(f->body, insertPos);

  using namespace matcher;
  auto matcher = isLocalSet(local_set::v(isBlock(block::has(3), block::at(0, isLocalSet(local_set::v(isConst()))),
                                                 block::at(1, isNop()), block::at(2, isLocalGet()))));
  EXPECT_TRUE(matcher(*f->body));

  ASSERT_EQ(f->body, insertPos);
  ASSERT_TRUE(insertPos->cast<LocalSet>()->value->is<Block>());
  ASSERT_TRUE(insertPos->cast<LocalSet>()->value->cast<Block>()->list[0]->is<LocalSet>());
  ASSERT_TRUE(insertPos->cast<LocalSet>()->value->cast<Block>()->list[0]->cast<LocalSet>()->value->is<Const>());
  ASSERT_TRUE(insertPos->cast<LocalSet>()->value->cast<Block>()->list[1]->is<Nop>());
  ASSERT_TRUE(insertPos->cast<LocalSet>()->value->cast<Block>()->list[2]->is<LocalGet>());
}

TEST(ExprInserter, InsertAfterTypeNone) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeCall("empty", {}, Type::none);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Call>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Nop>());
}

TEST(ExprInserter, InsertAfterLoopWithoutType) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeLoop("", b.makeNop(), Type::none);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Loop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Nop>());
}

TEST(ExprInserter, InsertAfterLoopWithType) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeLoop("", b.makeConst(1), Type::i32);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<LocalSet>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->cast<LocalSet>()->value->is<Loop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[2]->is<LocalGet>());
}

TEST(ExprInserter, InsertAfterReturnWithoutValue) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeReturn();
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Return>());
}

TEST(ExprInserter, InsertAfterReturnWithValue) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeReturn(b.makeConst(1));
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_EQ(f->body, insertPos);
  ASSERT_TRUE(f->body->cast<Return>()->value->is<Block>());
  ASSERT_TRUE(f->body->cast<Return>()->value->cast<Block>()->list[0]->is<LocalSet>());
  ASSERT_TRUE(f->body->cast<Return>()->value->cast<Block>()->list[0]->cast<LocalSet>()->value->is<Const>());
  ASSERT_TRUE(f->body->cast<Return>()->value->cast<Block>()->list[1]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Return>()->value->cast<Block>()->list[2]->is<LocalGet>());
}

TEST(ExprInserter, InsertAfterBrWithoutValue) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeBreak("bb");
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Break>());
}

TEST(ExprInserter, InsertAfterBrWithValue) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeBreak("bb", b.makeConst(1));
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_EQ(f->body, insertPos);
  ASSERT_TRUE(f->body->cast<Break>()->value->is<Block>());
  ASSERT_TRUE(f->body->cast<Break>()->value->cast<Block>()->list[0]->is<LocalSet>());
  ASSERT_TRUE(f->body->cast<Break>()->value->cast<Block>()->list[0]->cast<LocalSet>()->value->is<Const>());
  ASSERT_TRUE(f->body->cast<Break>()->value->cast<Block>()->list[1]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Break>()->value->cast<Block>()->list[2]->is<LocalGet>());
}

} // namespace warpo::passes::ut

#endif
