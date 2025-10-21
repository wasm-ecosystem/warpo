// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <ir/manipulation.h>
#include <map>
#include <memory>
#include <optional>

#include "../helper/BinaryenExt.hpp"
#include "GCInfo.hpp"
#include "StackAssigner.hpp"
#include "ToStackReplacer.hpp"
#include "support/index.h"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "ToStackReplacer"

namespace warpo::passes::gc {

void ToStackReplacer::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition const &stackPosition = stackPositions_->at(func);
  replaceToStackCallExpr(m, func, stackPosition);
}

/// There are a few expressions that can be copied without any issues.
static bool allowedCopy(wasm::Expression *expr) { return isOneOf<wasm::Const, wasm::LocalGet, wasm::GlobalGet>(expr); }

namespace {

struct CallReplacer : public wasm::PostWalker<CallReplacer> {
  StackPosition const &stackPosition_;
  wasm::Function *func_;
  std::optional<wasm::Index> tempLocalIndex_;
  explicit CallReplacer(StackPosition const &input, wasm::Function *func) : stackPosition_(input), func_(func) {}
  void visitCall(wasm::Call *expr) {
    if (expr->target != FnLocalToStack && expr->target != FnTmpToStack)
      return;
    assert(expr->operands.size() == 1);

    auto it = stackPosition_.find(expr);
    if (it == stackPosition_.end()) {
      // no need to tostack
      replaceCurrent(expr->operands.front());
    } else {
      wasm::Module *const m = getModule();
      uint32_t const offset = it->second;
      wasm::Builder b{*m};
      wasm::Name const memoryName = m->memories.front()->name;
      wasm::Expression *const valueExpr = expr->operands.front();
      if (allowedCopy(valueExpr)) {
        wasm::Block *const newExpr = b.makeBlock(
            {
                b.makeStore(4, offset, 1, b.makeGlobalGet(VarStackPointer, wasm::Type::i32), valueExpr, wasm::Type::i32,
                            memoryName),
                wasm::ExpressionManipulator::copy(valueExpr, *m),
            },
            wasm::Type::i32);
        replaceCurrent(newExpr);
      } else {
        wasm::Index const tempLocalIndex = ensureTempLocal();
        wasm::Block *const newExpr = b.makeBlock(
            {
                b.makeLocalSet(tempLocalIndex, valueExpr),
                b.makeStore(4, offset, 1, b.makeGlobalGet(VarStackPointer, wasm::Type::i32),
                            b.makeLocalGet(tempLocalIndex, wasm::Type::i32), wasm::Type::i32, memoryName),
                b.makeLocalGet(tempLocalIndex, wasm::Type::i32),
            },
            wasm::Type::i32);
        replaceCurrent(newExpr);
      }
    }
  }
  wasm::Index ensureTempLocal() {
    if (!tempLocalIndex_)
      tempLocalIndex_ = wasm::Builder::addVar(func_, wasm::Type::i32);
    return *tempLocalIndex_;
  }
};

} // namespace

void ToStackReplacer::replaceToStackCallExpr(wasm::Module *m, wasm::Function *func,
                                             StackPosition const &stackPosition) {
  CallReplacer callReplacer{stackPosition, func};
  callReplacer.walkFunctionInModule(func, m);
}

} // namespace warpo::passes::gc

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "../Runner.hpp"
#include "../helper/Matcher.hpp"

namespace warpo::passes::gc::ut {

TEST(ToStackReplaceTest, Ignore) {
  auto m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (memory 1)
      (func $main (param $0 i32) (result i32)
        (local $1 i32)

        (local.set $1 (local.get $0))
        (call $~lib/rt/__tmptostack (local.get $1))
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");

  StackPosition const stackPosition{};
  CallReplacer replace{stackPosition, func};
  replace.walkFunctionInModule(func, m.get());

  ASSERT_TRUE(func->body->is<wasm::Block>());
  // unwrap tostack call
  EXPECT_TRUE(func->body->cast<wasm::Block>()->list[1]->is<wasm::LocalGet>());
}

TEST(ToStackReplaceTest, ReplaceWithLocalGet) {
  auto m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (import "env" "fn" (func $fn (result i32)))
      (memory 1)
      (func $main (param $0 i32) (result i32)
        (local $1 i32)

        (local.set $1 (local.get $0))
        (call $~lib/rt/__tmptostack (call $fn))
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");

  StackPosition stackPosition{};
  stackPosition.insert_or_assign(func->body->cast<wasm::Block>()->list[1]->cast<wasm::Call>(), 16U);
  CallReplacer replace{stackPosition, func};
  replace.walkFunctionInModule(func, m.get());

  using namespace matcher;
  auto match = isBlock(allOf({
      block::at(0, isLocalSet(local_set::v(isCall()))),
      block::at(1, isStore(store::v(isLocalGet()), store::ptr(isGlobalGet()))),
      block::at(2, isLocalGet()),
  }));
  isMatched(match, func->body->cast<wasm::Block>()->list[1]);
}

TEST(ToStackReplaceTest, ReplaceWithCopy) {
  auto m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (memory 1)
      (func $main (param $0 i32) (result i32)
        (local $1 i32)

        (local.set $1 (local.get $0))
        (call $~lib/rt/__tmptostack (i32.const 100))
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");

  StackPosition stackPosition{};
  stackPosition.insert_or_assign(func->body->cast<wasm::Block>()->list[1]->cast<wasm::Call>(), 16U);
  CallReplacer replace{stackPosition, func};
  replace.walkFunctionInModule(func, m.get());

  using namespace matcher;
  auto match = isBlock(allOf({
      block::at(0, isStore(store::v(isConst()))),
      // get value from the const again instead of temp local
      block::at(1, isConst()),
  }));
  isMatched(match, func->body->cast<wasm::Block>()->list[1]);
}

} // namespace warpo::passes::gc::ut

#endif
