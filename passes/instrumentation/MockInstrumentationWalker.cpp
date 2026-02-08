// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <array>
#include <binaryen-c.h>
#include <sstream>
#include <string_view>
#include <wasm-type.h>
#include <wasm.h>

#include "MockInstrumentationWalker.hpp"
#include "Name.hpp"

namespace warpo::passes::instrumentation {

void MockInstrumentationWalker::visitCall(wasm::Call *const curr) noexcept {
  /* generate expect infos */
  if (std::any_of(this->expectTestFuncNames.begin(), this->expectTestFuncNames.end(),
                  [&curr](std::string_view str) noexcept {
                    auto lastIndex = curr->target.str.find_last_of(">");
                    if (lastIndex != std::string_view::npos) {
                      return curr->target.str.substr(lastIndex + 1) == str;
                    }
                    return false;
                  })) {
    const auto &currDebugLocations = getFunction()->debugLocations;
    const auto currentDebugLocationIterator = currDebugLocations.find(curr);
    if (currentDebugLocationIterator != currDebugLocations.cend() && currentDebugLocationIterator->second) {
      const wasm::Function::DebugLocation &currDebugLocation = *(currentDebugLocationIterator->second);
      const std::string &fileName = m->debugInfoFileNames[currDebugLocation.fileIndex];
      std::stringstream expectInfo;
      expectInfo << fileName << ":" << currDebugLocation.lineNumber << ":" << currDebugLocation.columnNumber;
      expectInfos[expectIndex] = expectInfo.str();
    }
    curr->operands.back() = b.makeConst(wasm::Literal(expectIndex));
    expectIndex++;
  }

  /* Function Call Mock */
  const auto functionRefsIterator = funcRefs.find(curr->target.str);
  if (functionRefsIterator != funcRefs.end()) {
    const wasm::Index localIdx = wasm::Builder::addVar(getFunction(), wasm::Type::i32);
    const auto &[tableName, originFuncIdx] = functionRefsIterator->second;
    const std::array<wasm::Expression *, 2U> callArgs = {b.makeConst(originFuncIdx), b.makeConst(true)};
    wasm::If *const mockReplacement = b.makeIf(
        b.makeBinary(wasm::BinaryOp::NeInt32,
                     b.makeLocalTee(localIdx, b.makeCall(checkMockInternalFunctionName, callArgs, wasm::Type::i32),
                                    wasm::Type::i32),
                     b.makeConst(-1)),
        b.makeCallIndirect(tableName, b.makeLocalGet(localIdx, wasm::Type::i32), curr->operands,
                           getModule()->getFunction(curr->target)->type.getHeapType()),
        curr);
    replaceCurrent(mockReplacement);
  }
}

void MockInstrumentationWalker::visitCallIndirect(wasm::CallIndirect *const curr) noexcept {
  if (funcRefs.size() == 0U) {
    return;
  }
  const std::array<wasm::Expression *, 2U> args = {curr->target, b.makeConst(false)};
  curr->target = b.makeCall(checkMockInternalFunctionName, args, wasm::Type::i32);
}

void MockInstrumentationWalker::mockWalk() noexcept {
  std::array<BinaryenType, 2U> ii_ = std::array<BinaryenType, 2U>{BinaryenTypeInt32(), BinaryenTypeInt32()};
  const BinaryenType ii = BinaryenTypeCreate(ii_.data(), ii_.size());
  BinaryenAddFunctionImport(m, checkMockInternalFunctionName, unittestFrameworkEnvModuleName, checkMockFunctionName, ii,
                            BinaryenTypeInt32());
  wasm::ModuleUtils::iterDefinedFunctions(
      *m, [this](wasm::Function *const func) noexcept { walkFunctionInModule(func, this->m); });
}

} // namespace warpo::passes::instrumentation

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "../Runner.hpp"

namespace warpo::passes::instrumentation::ut {

TEST(MockInstrumentationWalkerTest, CollectsExpectInfo) {
  auto m = loadWat(R"(
    (module
      (func $Function<test>#equal (param i32 i32) (result i32)
        local.get 0
        local.get 1
        i32.sub
      )
      (func $expectCaller (param i32 i32) (result i32)
        local.get 0
        local.get 1
        call $Function<test>#equal
      )
    )
  )");

  wasm::Function *const expectCaller = m->getFunction("expectCaller");
  wasm::Call *const expectCall = expectCaller->body->cast<wasm::Call>();

  m->debugInfoFileNames.emplace_back("expect.ts");
  wasm::Function::DebugLocation loc{};
  loc.fileIndex = 0;
  loc.lineNumber = 12;
  loc.columnNumber = 3;
  expectCaller->debugLocations.emplace(expectCall, loc);

  MockInstrumentationWalker walker(m.get());
  walker.mockWalk();

  EXPECT_NE(m->getFunctionOrNull(checkMockInternalFunctionName), nullptr);

  const auto &expectInfos = walker.getExpectInfos();
  ASSERT_EQ(expectInfos.size(), 1U);
  auto infoIt = expectInfos.find(0U);
  ASSERT_NE(infoIt, expectInfos.end());
  EXPECT_EQ(infoIt->second, "expect.ts:12:3");

  ASSERT_EQ(expectCall->operands.size(), 2U);
  ASSERT_TRUE(expectCall->operands[1]->is<wasm::Const>());
  EXPECT_EQ(expectCall->operands[1]->cast<wasm::Const>()->value, wasm::Literal(0));
}

TEST(MockInstrumentationWalkerTest, MocksCalls) {
  auto m = loadWat(R"(
    (module
      (type $t0 (func (param i32 i32) (result i32)))
      (table $tbl 2 funcref)
      (elem (i32.const 0) $mocked)
      (func $mocked (param i32 i32) (result i32)
        local.get 0
        local.get 1
        i32.add
      )
      (func $caller (param i32 i32) (result i32)
        local.get 0
        local.get 1
        call $mocked
      )
      (func $indirectCaller (param i32 i32 i32) (result i32)
        local.get 0
        local.get 1
        local.get 2
        call_indirect (type $t0)
      )
    )
  )");

  MockInstrumentationWalker walker(m.get());
  walker.mockWalk();

  EXPECT_NE(m->getFunctionOrNull(checkMockInternalFunctionName), nullptr);

  wasm::Function *const caller = m->getFunction("caller");
  ASSERT_TRUE(caller->body->is<wasm::If>());
  wasm::If *const mockIf = caller->body->cast<wasm::If>();
  ASSERT_TRUE(mockIf->condition->is<wasm::Binary>());
  wasm::Binary *const condition = mockIf->condition->cast<wasm::Binary>();
  EXPECT_EQ(condition->op, wasm::BinaryOp::NeInt32);
  ASSERT_TRUE(condition->left->is<wasm::LocalSet>());
  wasm::LocalSet *const tee = condition->left->cast<wasm::LocalSet>();
  EXPECT_TRUE(tee->isTee());
  const wasm::Index localIndex = tee->index;
  ASSERT_TRUE(tee->value->is<wasm::Call>());
  wasm::Call *const checkCall = tee->value->cast<wasm::Call>();
  EXPECT_EQ(checkCall->target, checkMockInternalFunctionName);
  ASSERT_EQ(checkCall->operands.size(), 2U);
  ASSERT_TRUE(checkCall->operands[0]->is<wasm::Const>());
  EXPECT_EQ(checkCall->operands[0]->cast<wasm::Const>()->value, wasm::Literal(1));
  ASSERT_TRUE(checkCall->operands[1]->is<wasm::Const>());
  EXPECT_EQ(checkCall->operands[1]->cast<wasm::Const>()->value, wasm::Literal(1));
  ASSERT_TRUE(condition->right->is<wasm::Const>());
  EXPECT_EQ(condition->right->cast<wasm::Const>()->value, wasm::Literal(-1));

  ASSERT_TRUE(mockIf->ifTrue->is<wasm::CallIndirect>());
  wasm::CallIndirect *const indirect = mockIf->ifTrue->cast<wasm::CallIndirect>();
  EXPECT_EQ(indirect->table, wasm::Name("tbl"));
  ASSERT_TRUE(indirect->target->is<wasm::LocalGet>());
  EXPECT_EQ(indirect->target->cast<wasm::LocalGet>()->index, localIndex);
  ASSERT_EQ(indirect->operands.size(), 2U);

  ASSERT_TRUE(mockIf->ifFalse->is<wasm::Call>());
  EXPECT_EQ(mockIf->ifFalse->cast<wasm::Call>()->target, "mocked");

  wasm::Function *const indirectCaller = m->getFunction("indirectCaller");
  ASSERT_TRUE(indirectCaller->body->is<wasm::CallIndirect>());
  wasm::CallIndirect *const originalIndirect = indirectCaller->body->cast<wasm::CallIndirect>();
  ASSERT_TRUE(originalIndirect->target->is<wasm::Call>());
  wasm::Call *const indirectTarget = originalIndirect->target->cast<wasm::Call>();
  EXPECT_EQ(indirectTarget->target, checkMockInternalFunctionName);
  ASSERT_EQ(indirectTarget->operands.size(), 2U);
  ASSERT_TRUE(indirectTarget->operands[0]->is<wasm::LocalGet>());
  EXPECT_EQ(indirectTarget->operands[0]->cast<wasm::LocalGet>()->index, 2U);
  ASSERT_TRUE(indirectTarget->operands[1]->is<wasm::Const>());
  EXPECT_EQ(indirectTarget->operands[1]->cast<wasm::Const>()->value, wasm::Literal(0));
}

} // namespace warpo::passes::instrumentation::ut

#endif
