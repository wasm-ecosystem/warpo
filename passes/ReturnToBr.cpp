// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

// Design:
// 1. Count reachable exits, including fallthrough.
// 2. Find the first CFG split; leave preceding statements outside the exit block.
// 3. Reuse a compatible body block or wrap the remaining suffix in an exit block.
// 4. Replace each return with a br to the exit, carrying its original value.
// 5. Add a fallthrough br, carrying the tail value for non-void functions.
// 6. ReFinalize the IR to update expression types.

#include <algorithm>
#include <cassert>
#include <cstddef>
#include <fmt/format.h>
#include <memory>
#include <vector>

#include "ReturnToBr.hpp"
#include "helper/CFG.hpp"
#include "helper/FindExpr.hpp"
#include "helper/ReturnPoints.hpp"
#include "ir/utils.h"
#include "warpo/support/Debug.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

#define PASS_NAME "ReturnToBr"

namespace warpo::passes {
namespace {

wasm::Expression *findFirstCFGSplit(CFG const &cfg) {
  BasicBlock const *bb = cfg.getEntry();
  for (std::size_t visited = 0; bb != nullptr && visited < cfg.size(); ++visited) {
    if (bb->succs().size() > 1)
      return bb->size() != 0 ? *bb->rbegin() : nullptr;
    if (bb->succs().size() != 1)
      return nullptr;
    bb = bb->succs().front();
  }
  return nullptr;
}

std::size_t findExitStart(wasm::Block &body, wasm::Expression *firstSplit) {
  auto const statement = std::find_if(body.list.begin(), body.list.end(), [firstSplit](wasm::Expression *&expr) {
    return findExprPointer(firstSplit, expr) != nullptr;
  });
  assert(statement != body.list.end());
  return static_cast<std::size_t>(statement - body.list.begin());
}

void appendFallthroughBranch(wasm::Builder &builder, wasm::Block *exit, wasm::Type resultType) {
  if (exit->list.back()->type == wasm::Type::unreachable)
    return;
  if (resultType == wasm::Type::none)
    exit->list.push_back(builder.makeBreak(exit->name));
  else
    exit->list.back() = builder.makeBreak(exit->name, exit->list.back());
}

struct ReturnRewriter : wasm::PostWalker<ReturnRewriter> {
  wasm::Builder &builder_;
  wasm::Name const exitName_;
  bool changed_ = false;

  ReturnRewriter(wasm::Builder &builder, wasm::Name exitName) : builder_(builder), exitName_(exitName) {}

  void visitReturn(wasm::Return *expr) {
    replaceCurrent(builder_.makeBreak(exitName_, expr->value));
    changed_ = true;
  }
};

struct ReturnToBr final : wasm::Pass {
  ReturnToBr() { name = PASS_NAME; }

  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<ReturnToBr>(); }
  bool isFunctionParallel() override { return true; }
  bool modifiesBinaryenIR() override { return true; }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override { convertReturnsToBranches(m, func); }
};

} // namespace

void convertReturnsToBranches(wasm::Module *m, wasm::Function *func) {
  if (func->imported())
    return;

  auto const returnPoints = computeReturnPoints(m, func);
  constexpr std::size_t threshold = 1;
  if (returnPoints.size() <= threshold)
    return;

  CFG const cfg = CFG::fromFunction(m, func);
  wasm::Expression *const firstSplit = findFirstCFGSplit(cfg);
  if (firstSplit == nullptr)
    return;

  wasm::Builder builder{*m};
  wasm::Type const resultType = func->getResults();
  auto *body = func->body->dynCast<wasm::Block>();
  if (body == nullptr)
    body = builder.makeBlock(wasm::Name{}, {func->body}, resultType);
  std::size_t const start = findExitStart(*body, firstSplit);
  bool const reuseBody = start == 0 && body->type == resultType;
  wasm::Name const exitName =
      reuseBody && !body->name.isNull() ? body->name : wasm::Name{fmt::format("~RETURN_TO_BR/{}", func->name.view())};

  auto *const exit =
      reuseBody ? body
                : builder.makeBlock(exitName,
                                    std::vector<wasm::Expression *>{
                                        body->list.begin() + static_cast<std::ptrdiff_t>(start), body->list.end()},
                                    resultType);

  ReturnRewriter rewriter{builder, exitName};
  wasm::Expression *exitBody = exit;
  rewriter.walk(exitBody);
  if (!rewriter.changed_)
    return;

  if (support::isDebug(PASS_NAME, func->name.view())) {
    fmt::println("[" PASS_NAME "] fn '{}' shares {} exit points at '{}' (threshold {})", func->name.view(),
                 returnPoints.size(), exitName.view(), threshold);
  }

  exit->name = exitName;
  if (!reuseBody) {
    body->list.resize(start);
    body->list.push_back(exit);
  }
  func->body = body;
  appendFallthroughBranch(builder, exit, resultType);

  // Propagate the branch-carried results through the enclosing expressions.
  wasm::ReFinalize{}.walkFunctionInModule(func, m);
}

wasm::Pass *createReturnToBrPass() { return new ReturnToBr{}; }

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "GC/GCInfo.hpp"
#include "GC/PrologEpilogInserter.hpp"
#include "Runner.hpp"
#include "wasm-validator.h"

namespace warpo::passes::ut {

namespace {

struct ReturnScanner : wasm::PostWalker<ReturnScanner> {
  std::vector<wasm::Return *> returns_;

  void visitReturn(wasm::Return *expr) { returns_.push_back(expr); }
};

struct CallCounter : wasm::PostWalker<CallCounter> {
  wasm::Name const target_;
  std::size_t calls_ = 0;

  explicit CallCounter(wasm::Name target) : target_(target) {}

  void visitCall(wasm::Call *expr) {
    if (expr->target == target_)
      ++calls_;
  }
};

} // namespace

TEST(ReturnToBrTest, AtLeastTwoReturnsAreRequiredAndTailReturnsCount) {
  auto m = loadWat(R"(
    (module
      (func $single (result i32) (return (i32.const 7)))
      (func $main (param i32) (result i32)
        (if (local.get 0) (then (return (i32.const 42))))
        (return (i32.const 10))
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const single = m->getFunction("single");
  auto *const singleBody = single->body;

  convertReturnsToBranches(m.get(), single);
  EXPECT_EQ(single->body, singleBody);
  EXPECT_TRUE(single->body->is<wasm::Return>());
  ReturnScanner before;
  before.walk(func->body);
  EXPECT_EQ(before.returns_.size(), 2U);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createReturnToBrPass()});
  runner.runOnFunction(func);

  ReturnScanner after;
  after.walk(func->body);
  EXPECT_TRUE(after.returns_.empty());
  EXPECT_EQ(func->body->type, wasm::Type::i32);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, RootReturnWithNestedReturnGetsAnExit) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32) (result i32)
        (return
          (block (result i32)
            (if (local.get 0) (then (return (i32.const 42))))
            (i32.const 10)
          )
        )
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const originalBody = func->body;
  auto *const value = originalBody->cast<wasm::Return>()->value;

  convertReturnsToBranches(m.get(), func);

  auto *const exit = func->body->cast<wasm::Block>();
  ASSERT_EQ(exit->list.size(), 1U);
  auto *const branch = exit->list[0]->cast<wasm::Break>();
  EXPECT_EQ(branch->name, exit->name);
  EXPECT_EQ(branch->value, value);
  EXPECT_EQ(branch->condition, nullptr);
  EXPECT_EQ(exit->type, wasm::Type::i32);
  ReturnScanner scanner;
  scanner.walk(func->body);
  EXPECT_TRUE(scanner.returns_.empty());
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, CompatibleUnnamedBodyIsReused) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32 i32) (result i32)
        (if (local.get 0) (then (return (i32.const 42))))
        (if (local.get 1) (then (return (i32.const 24))))
        (i32.const 10)
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const body = func->body->cast<wasm::Block>();
  auto *const firstGuard = body->list[0]->cast<wasm::If>();
  auto *const secondGuard = body->list[1]->cast<wasm::If>();
  auto *const firstValue = firstGuard->ifTrue->cast<wasm::Return>()->value;
  auto *const secondValue = secondGuard->ifTrue->cast<wasm::Return>()->value;
  ASSERT_TRUE(body->name.isNull());

  convertReturnsToBranches(m.get(), func);

  EXPECT_EQ(func->body, body);
  EXPECT_FALSE(body->name.isNull());
  EXPECT_EQ(body->list[0], firstGuard);
  EXPECT_EQ(body->list[1], secondGuard);
  EXPECT_EQ(firstGuard->ifTrue->cast<wasm::Break>()->value, firstValue);
  EXPECT_EQ(secondGuard->ifTrue->cast<wasm::Break>()->value, secondValue);
  EXPECT_EQ(firstGuard->ifTrue->cast<wasm::Break>()->condition, nullptr);
  EXPECT_EQ(secondGuard->ifTrue->cast<wasm::Break>()->condition, nullptr);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, CompatibleNamedBodyAndExistingBranchAreReused) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32 i32 i32) (result i32)
        (block $existing (result i32)
          (drop (br_if $existing (i32.const 7) (local.get 2)))
          (if (local.get 0) (then (return (i32.const 42))))
          (if (local.get 1) (then (return (i32.const 24))))
          (i32.const 10)
        )
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const body = func->body->cast<wasm::Block>();
  auto *const existingBranch = body->list[0]->cast<wasm::Drop>()->value->cast<wasm::Break>();

  convertReturnsToBranches(m.get(), func);

  EXPECT_EQ(func->body, body);
  EXPECT_EQ(body->name, "existing");
  EXPECT_EQ(body->list[0]->cast<wasm::Drop>()->value, existingBranch);
  EXPECT_EQ(existingBranch->name, "existing");
  EXPECT_NE(existingBranch->condition, nullptr);
  EXPECT_EQ(body->list[1]->cast<wasm::If>()->ifTrue->cast<wasm::Break>()->name, "existing");
  EXPECT_EQ(body->list[2]->cast<wasm::If>()->ifTrue->cast<wasm::Break>()->name, "existing");
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, BranchBlocksAndTailCallsPreserveAllOperands) {
  auto m = loadWat(R"(
    (module
      (func $condition (param i32) (result i32) (local.get 0))
      (func $value (param i32) (result i32) (local.get 0))
      (func $work (param i32))
      (func $main (param i32 i32) (result i32)
        (if (call $condition (local.get 0))
          (then
            (block $first
              (call $work (i32.const 1))
              (return (call $value (i32.const 42)))
            )
          )
        )
        (if (call $condition (local.get 1))
          (then
            (block $second
              (call $work (i32.const 2))
              (block $wrapped
                (return (call $value (i32.const 24)))
              )
            )
          )
        )
        (return (call $value (i32.const 10)))
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const body = func->body->cast<wasm::Block>();
  auto *const firstGuard = body->list[0]->cast<wasm::If>();
  auto *const secondGuard = body->list[1]->cast<wasm::If>();
  auto *const firstCondition = firstGuard->condition;
  auto *const secondCondition = secondGuard->condition;
  auto *const firstBlock = firstGuard->ifTrue->cast<wasm::Block>();
  auto *const secondBlock = secondGuard->ifTrue->cast<wasm::Block>();
  auto *const wrapped = secondBlock->list[1]->cast<wasm::Block>();
  auto *const firstWork = firstBlock->list[0];
  auto *const secondWork = secondBlock->list[0];
  auto *const firstValue = firstBlock->list[1]->cast<wasm::Return>()->value;
  auto *const secondValue = wrapped->list[0]->cast<wasm::Return>()->value;
  auto *const tailValue = body->list[2]->cast<wasm::Return>()->value;

  convertReturnsToBranches(m.get(), func);

  auto *const exit = func->body->cast<wasm::Block>();
  EXPECT_EQ(exit, body);
  ASSERT_EQ(exit->list.size(), 3U);
  EXPECT_EQ(firstGuard->condition, firstCondition);
  EXPECT_EQ(secondGuard->condition, secondCondition);
  EXPECT_EQ(firstGuard->ifTrue, firstBlock);
  EXPECT_EQ(secondGuard->ifTrue, secondBlock);
  EXPECT_EQ(firstBlock->list[0], firstWork);
  EXPECT_EQ(secondBlock->list[0], secondWork);
  EXPECT_EQ(secondBlock->list[1], wrapped);
  EXPECT_EQ(firstBlock->name, "first");
  EXPECT_EQ(secondBlock->name, "second");
  EXPECT_EQ(wrapped->name, "wrapped");
  EXPECT_EQ(firstBlock->list[1]->cast<wasm::Break>()->value, firstValue);
  EXPECT_EQ(wrapped->list[0]->cast<wasm::Break>()->value, secondValue);
  EXPECT_EQ(body->list[2]->cast<wasm::Break>()->value, tailValue);
  EXPECT_EQ(firstBlock->list[1]->cast<wasm::Break>()->name, exit->name);
  EXPECT_EQ(wrapped->list[0]->cast<wasm::Break>()->name, exit->name);
  EXPECT_EQ(body->list[2]->cast<wasm::Break>()->name, exit->name);
  CallCounter conditions{"condition"};
  conditions.walk(func->body);
  EXPECT_EQ(conditions.calls_, 2U);
  CallCounter values{"value"};
  values.walk(func->body);
  EXPECT_EQ(values.calls_, 3U);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, VoidReturnsInIfAndLoopTargetTheFunctionExit) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32 i32)
        (if (local.get 0) (then (return)))
        (loop $again
          (if (local.get 1) (then (br $again)))
          (return)
        )
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const body = func->body->cast<wasm::Block>();
  auto *const guard = body->list[0]->cast<wasm::If>();
  auto *const loop = body->list[1]->cast<wasm::Loop>();
  auto *const loopBody = loop->body->cast<wasm::Block>();
  auto *const continueGuard = loopBody->list[0]->cast<wasm::If>();
  auto *const originalContinue = continueGuard->ifTrue;

  convertReturnsToBranches(m.get(), func);

  EXPECT_EQ(func->body, body);
  ASSERT_EQ(body->list.size(), 1U);
  auto *const exit = body->list.front()->cast<wasm::Block>();
  EXPECT_EQ(exit->list[0], guard);
  EXPECT_EQ(exit->list[1], loop);
  EXPECT_EQ(loop->body, loopBody);
  EXPECT_EQ(continueGuard->ifTrue, originalContinue);
  EXPECT_EQ(originalContinue->cast<wasm::Break>()->name, "again");
  EXPECT_EQ(guard->ifTrue->cast<wasm::Break>()->name, exit->name);
  EXPECT_EQ(guard->ifTrue->cast<wasm::Break>()->value, nullptr);
  EXPECT_EQ(guard->ifTrue->cast<wasm::Break>()->condition, nullptr);
  EXPECT_EQ(loopBody->list[1]->cast<wasm::Break>()->name, exit->name);
  EXPECT_EQ(exit->type, wasm::Type::none);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, NestedReturnAndImplicitExitAreCountedSeparately) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32 i32)
        (if (local.get 0)
          (then (if (local.get 1) (then (return))))
        )
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const body = func->body;
  ReturnScanner before;
  before.walk(func->body);
  ASSERT_EQ(before.returns_.size(), 1U);
  ASSERT_EQ(computeReturnPoints(m.get(), func).size(), 2U);

  convertReturnsToBranches(m.get(), func);

  auto *const exit = func->body->cast<wasm::Block>();
  ASSERT_EQ(exit->list.size(), 2U);
  EXPECT_EQ(exit->list[0], body);
  EXPECT_EQ(body->cast<wasm::If>()->ifTrue->cast<wasm::If>()->ifTrue->cast<wasm::Break>()->name, exit->name);
  EXPECT_EQ(exit->list.back()->cast<wasm::Break>()->name, exit->name);
  ReturnScanner scanner;
  scanner.walk(func->body);
  EXPECT_TRUE(scanner.returns_.empty());
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, GeneratedExitNameUsesFunctionName) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32) (result i32)
        (block $inner (nop))
        (if (local.get 0) (then (return (i32.const 42))))
        (return (i32.const 10))
      )
    )
  )");
  auto *const func = m->getFunction("main");
  ASSERT_EQ(computeReturnPoints(m.get(), func).size(), 2U);
  auto *const originalBody = func->body->cast<wasm::Block>();
  auto *const innerBlock = originalBody->list[0]->cast<wasm::Block>();
  wasm::Name const originalName = innerBlock->name;

  convertReturnsToBranches(m.get(), func);

  EXPECT_EQ(func->body, originalBody);
  ASSERT_EQ(originalBody->list.size(), 2U);
  EXPECT_EQ(originalBody->list.front(), innerBlock);
  auto *const exit = originalBody->list.back()->cast<wasm::Block>();
  EXPECT_EQ(exit->name, "~RETURN_TO_BR/main");
  EXPECT_EQ(innerBlock->name, originalName);
  EXPECT_EQ(exit->list.front()->cast<wasm::If>()->ifTrue->cast<wasm::Break>()->name, exit->name);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, PrefixBeforeFirstCFGSplitStaysOutsideExit) {
  auto m = loadWat(R"(
    (module
      (func $work)
      (func $main (param i32) (result i32)
        (call $work)
        (loop $once (call $work))
        (if (local.get 0) (then (return (i32.const 42))))
        (return (i32.const 10))
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const body = func->body->cast<wasm::Block>();
  auto *const prefixCall = body->list[0];
  auto *const prefixLoop = body->list[1];
  auto *const guard = body->list[2]->cast<wasm::If>();
  auto *const condition = guard->condition;
  CFG const cfg = CFG::fromFunction(m.get(), func);
  ASSERT_EQ(cfg.getEntry()->succs().size(), 1U);
  ASSERT_EQ(findFirstCFGSplit(cfg), condition);

  convertReturnsToBranches(m.get(), func);

  EXPECT_EQ(func->body, body);
  EXPECT_TRUE(body->name.isNull());
  ASSERT_EQ(body->list.size(), 3U);
  EXPECT_EQ(body->list[0], prefixCall);
  EXPECT_EQ(body->list[1], prefixLoop);
  auto *const exit = body->list[2]->cast<wasm::Block>();
  ASSERT_EQ(exit->list.size(), 2U);
  EXPECT_EQ(exit->list[0], guard);
  EXPECT_EQ(guard->condition, condition);
  EXPECT_EQ(guard->ifTrue->cast<wasm::Break>()->name, exit->name);
  EXPECT_EQ(exit->list[1]->cast<wasm::Break>()->name, exit->name);
  EXPECT_EQ(exit->type, wasm::Type::i32);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, ScalarResultTypesArePreserved) {
  for (char const *const type : {"i32", "i64", "f32", "f64"}) {
    SCOPED_TRACE(type);
    auto m = loadWat(fmt::format(R"(
      (module
        (func $main (param i32) (result {0})
          (if (local.get 0) (then (return ({0}.const 42))))
          (return ({0}.const 10))
        )
      )
    )",
                                 type));
    auto *const func = m->getFunction("main");

    convertReturnsToBranches(m.get(), func);

    EXPECT_EQ(func->body->type, func->getResults());
    EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
  }
}

TEST(ReturnToBrTest, MultiValueResultsArePreserved) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32) (result i32 i64)
        (if (local.get 0)
          (then (return (i32.const 42) (i64.const 24)))
        )
        (return (i32.const 10) (i64.const 7))
      )
    )
  )");
  auto *const func = m->getFunction("main");

  convertReturnsToBranches(m.get(), func);

  EXPECT_EQ(func->body->type, func->getResults());
  ReturnScanner scanner;
  scanner.walk(func->body);
  EXPECT_TRUE(scanner.returns_.empty());
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, ActualTailCallsStayTailCalls) {
  auto m = loadWat(R"(
    (module
      (func $callee (result i32) (i32.const 10))
      (func $tail (result i32) (call $callee))
      (func $main (param i32 i32) (result i32)
        (if (local.get 0) (then (return (i32.const 42))))
        (if (local.get 1) (then (return (i32.const 24))))
        (call $callee)
      )
    )
  )");
  m->features.setTailCall();
  auto *const tailFunc = m->getFunction("tail");
  auto *const originalTail = tailFunc->body;
  auto *const func = m->getFunction("main");
  auto *const body = func->body->cast<wasm::Block>();
  auto *const tailCall = body->list[2]->cast<wasm::Call>();
  originalTail->cast<wasm::Call>()->isReturn = true;
  originalTail->cast<wasm::Call>()->finalize();
  tailCall->isReturn = true;
  tailCall->finalize();
  ASSERT_TRUE(tailCall->isReturn);

  convertReturnsToBranches(m.get(), tailFunc);
  EXPECT_EQ(tailFunc->body, originalTail);

  convertReturnsToBranches(m.get(), func);

  EXPECT_EQ(body->list[2], tailCall);
  EXPECT_TRUE(tailCall->isReturn);
  EXPECT_TRUE(body->list[0]->cast<wasm::If>()->ifTrue->is<wasm::Break>());
  EXPECT_TRUE(body->list[1]->cast<wasm::If>()->ifTrue->is<wasm::Break>());
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, NoReturnsAndImportedFunctionsStayUnchanged) {
  auto m = loadWat(R"(
    (module
      (import "env" "imported" (func $imported))
      (func $main (result i32) (i32.const 42))
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const body = func->body;

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createReturnToBrPass()});
  runner.run();
  convertReturnsToBranches(m.get(), m->getFunction("imported"));

  EXPECT_EQ(func->body, body);
  EXPECT_EQ(m->getFunction("imported")->body, nullptr);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, RepeatedRunDoesNotAddAnotherExit) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32) (result i32)
        (if (local.get 0) (then (return (i32.const 42))))
        (return (i32.const 10))
      )
    )
  )");
  auto *const func = m->getFunction("main");
  convertReturnsToBranches(m.get(), func);
  auto *const exit = func->body;

  convertReturnsToBranches(m.get(), func);

  EXPECT_EQ(func->body, exit);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, DefaultGCPathDoesNotRewriteReturns) {
  auto m = loadWat(R"(
    (module
      (func $~lib/rt/__decrease_sp (param i32))
      (func $~lib/rt/__increase_sp (param i32))
      (func $main (param i32) (result i32)
        (if (local.get 0) (then (return (i32.const 42))))
        (i32.const 10)
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto const offsets = std::make_shared<gc::MaxShadowStackOffsets>();
  (*offsets)[func] = gc::ShadowStackElementSize;
  gc::PrologEpilogInserter inserter{nullptr, offsets};

  inserter.runOnFunction(m.get(), func);

  ReturnScanner scanner;
  scanner.walk(func->body);
  EXPECT_EQ(scanner.returns_.size(), 1U);
  CallCounter restores{gc::FnIncreaseSP};
  restores.walk(func->body);
  EXPECT_EQ(restores.calls_, 2U);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, EnabledGCPathSharesOneEpilogue) {
  auto m = loadWat(R"(
    (module
      (func $~lib/rt/__decrease_sp (param i32))
      (func $~lib/rt/__increase_sp (param i32))
      (func $main (param i32) (result i32)
        (if (local.get 0) (then (return (i32.const 42))))
        (i32.const 10)
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto const offsets = std::make_shared<gc::MaxShadowStackOffsets>();
  (*offsets)[func] = gc::ShadowStackElementSize;
  gc::PrologEpilogInserter inserter{nullptr, offsets, true};

  inserter.runOnFunction(m.get(), func);

  CallCounter restores{gc::FnIncreaseSP};
  restores.walk(func->body);
  EXPECT_EQ(restores.calls_, 1U);
  ReturnScanner scanner;
  scanner.walk(func->body);
  EXPECT_TRUE(scanner.returns_.empty());
  EXPECT_EQ(func->body->type, wasm::Type::i32);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, FallthroughBranchSharesOneGCEpilogue) {
  auto m = loadWat(R"(
    (module
      (func $~lib/rt/__decrease_sp (param i32))
      (func $~lib/rt/__increase_sp (param i32))
      (func $work)
      (func $main (param i32)
        (call $work)
        (if (local.get 0) (then (return)))
        (call $work)
      )
    )
  )");
  auto *const func = m->getFunction("main");
  ASSERT_EQ(computeReturnPoints(m.get(), func).size(), 2U);
  auto *const originalBody = func->body->cast<wasm::Block>();
  auto *const guard = originalBody->list[1]->cast<wasm::If>();
  auto *const tailWork = originalBody->list.back();
  auto const offsets = std::make_shared<gc::MaxShadowStackOffsets>();
  (*offsets)[func] = gc::ShadowStackElementSize;
  gc::PrologEpilogInserter inserter{nullptr, offsets, true};

  inserter.runOnFunction(m.get(), func);

  auto *const wrapper = func->body->cast<wasm::Block>();
  ASSERT_EQ(wrapper->list.size(), 3U);
  EXPECT_EQ(wrapper->list.front()->cast<wasm::Call>()->target, gc::FnDecreaseSP);
  EXPECT_EQ(wrapper->list[1], originalBody);
  ASSERT_EQ(originalBody->list.size(), 2U);
  EXPECT_EQ(originalBody->list.front()->cast<wasm::Call>()->target, "work");
  auto *const exit = originalBody->list.back()->cast<wasm::Block>();
  ASSERT_EQ(exit->list.size(), 3U);
  EXPECT_EQ(exit->list.front(), guard);
  EXPECT_EQ(exit->list[1], tailWork);
  auto *const earlyExit = guard->ifTrue->cast<wasm::Break>();
  auto *const fallthroughExit = exit->list.back()->cast<wasm::Break>();
  EXPECT_FALSE(exit->name.isNull());
  EXPECT_EQ(earlyExit->name, exit->name);
  EXPECT_EQ(fallthroughExit->name, exit->name);
  EXPECT_EQ(fallthroughExit->condition, nullptr);
  EXPECT_EQ(fallthroughExit->value, nullptr);
  EXPECT_EQ(wrapper->list.back()->cast<wasm::Call>()->target, gc::FnIncreaseSP);
  CallCounter restores{gc::FnIncreaseSP};
  restores.walk(func->body);
  EXPECT_EQ(restores.calls_, 1U);
  CallCounter work{"work"};
  work.walk(func->body);
  EXPECT_EQ(work.calls_, 2U);
  ReturnScanner scanner;
  scanner.walk(func->body);
  EXPECT_TRUE(scanner.returns_.empty());
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, GCCloneSharesOneEpilogue) {
  auto m = loadWat(R"(
    (module
      (func $~lib/rt/__decrease_sp (param i32))
      (func $~lib/rt/__increase_sp (param i32))
      (func $main (param i32) (result i32)
        (if (local.get 0) (then (return (i32.const 42))))
        (return (i32.const 10))
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto const offsets = std::make_shared<gc::MaxShadowStackOffsets>();
  (*offsets)[func] = gc::ShadowStackElementSize;
  gc::PrologEpilogInserter inserter{nullptr, offsets, true};
  auto clone = inserter.create();

  clone->runOnFunction(m.get(), func);

  ReturnScanner scanner;
  scanner.walk(func->body);
  EXPECT_TRUE(scanner.returns_.empty());
  CallCounter restores{gc::FnIncreaseSP};
  restores.walk(func->body);
  EXPECT_EQ(restores.calls_, 1U);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

TEST(ReturnToBrTest, ZeroShadowStackDoesNotRewriteReturns) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32) (result i32)
        (if (local.get 0) (then (return (i32.const 42))))
        (return (i32.const 10))
      )
    )
  )");
  auto *const func = m->getFunction("main");
  auto *const body = func->body;
  auto const offsets = std::make_shared<gc::MaxShadowStackOffsets>();
  (*offsets)[func] = 0;
  gc::PrologEpilogInserter inserter{nullptr, offsets, true};

  inserter.runOnFunction(m.get(), func);

  EXPECT_EQ(func->body, body);
  EXPECT_TRUE(wasm::WasmValidator{}.validate(*m));
}

} // namespace warpo::passes::ut

#endif