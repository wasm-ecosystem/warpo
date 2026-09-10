// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <unordered_set>
#include <vector>

#include "CFG.hpp"
#include "ReturnPoints.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {

namespace {

void addReturnPointsFromExpr(wasm::Expression *expr, std::vector<ReturnPoint> &returnPoints) {
  if (expr == nullptr)
    return;

  if (auto *const ifExpr = expr->dynCast<wasm::If>()) {
    addReturnPointsFromExpr(ifExpr->ifTrue, returnPoints);
    if (ifExpr->ifFalse != nullptr)
      addReturnPointsFromExpr(ifExpr->ifFalse, returnPoints);
    return;
  }

  if (auto *const block = expr->dynCast<wasm::Block>()) {
    if (!block->list.empty())
      addReturnPointsFromExpr(block->list.back(), returnPoints);
    return;
  }

  returnPoints.push_back(ReturnPoint{expr});
}

class CFGReturnPointFinder {
public:
  static std::vector<ReturnPoint> find(wasm::Module *m, wasm::Function *func) {
    CFG const cfg = CFG::fromFunction(m, func);
    BasicBlock const *const exit = cfg.getExit();
    if (exit == nullptr)
      return {};

    std::vector<ReturnPoint> returnPoints;
    std::unordered_set<BasicBlock const *> visited;

    auto visitBB = [&](auto const &self, BasicBlock const *bb) -> void {
      if (bb == nullptr || !visited.insert(bb).second)
        return;

      // Find the last and second-to-last valuable instructions in this basic block.
      // Skipping AST container nodes (Block, Loop) is necessary because CFGBuilder
      // appends them to basic block instruction lists at block closure during post-order walk:
      //
      // 1. Pure join/merge point:
      //      (block $merge (result i32)
      //        (if (local.get $c)
      //          (then (br $merge (local.get $a)))
      //          (else (br $merge (local.get $a)))))
      //    The exit block after $merge only contains [ (block $merge ...) ]. Skipping it yields
      //    lastInst == nullptr, so the analysis checks incoming predecessor paths.
      //
      // 2. Linear statements followed by closed block(s) in the same basic block:
      //      (block $outer (result i32)
      //        (block $inner (result i32)
      //          (local.get $this)))
      //    CFGBuilder appends [ (local.get $this), (block $inner ...), (block $outer ...) ].
      //    Reverse iteration skips the closing containers to inspect the actual value (local.get $this).
      //
      // 3. Statements after an inner block closes:
      //      (block (nop))
      //      (local.get $this)
      //    CFGBuilder appends [ (nop), (block ...), (local.get $this) ].
      //    Reverse iteration immediately encounters (local.get $this) first.
      wasm::Expression *lastInst = nullptr;
      wasm::Expression *secondLastInst = nullptr;
      // NOLINTNEXTLINE(modernize-loop-convert)
      for (BasicBlock::reverse_iterator it = bb->rbegin(); it != bb->rend(); ++it) {
        wasm::Expression *const expr = *it;
        if (expr == nullptr || expr->is<wasm::Block>() || expr->is<wasm::Loop>())
          continue;
        if (lastInst == nullptr)
          lastInst = expr;
        else {
          secondLastInst = expr;
          break;
        }
      }

      // 1. Empty join block or branching condition (If): return value flows from predecessors.
      if (lastInst == nullptr || lastInst->is<wasm::If>()) {
        for (BasicBlock const *const pred : bb->preds())
          self(self, pred);
        // 2. Explicit return: handle value return, adjacent void return, or trace predecessors.
      } else if (auto *const ret = lastInst->dynCast<wasm::Return>()) {
        if (ret->value != nullptr) {
          addReturnPointsFromExpr(ret->value, returnPoints);
        } else if (secondLastInst != nullptr && secondLastInst->type != wasm::Type::unreachable) {
          addReturnPointsFromExpr(secondLastInst, returnPoints);
        } else {
          for (BasicBlock const *const pred : bb->preds())
            self(self, pred);
        }
        // 3. Break branch: handle value branch, adjacent void break, or trace predecessors.
      } else if (auto *const br = lastInst->dynCast<wasm::Break>()) {
        if (br->value != nullptr) {
          addReturnPointsFromExpr(br->value, returnPoints);
        } else if (secondLastInst != nullptr && secondLastInst->type != wasm::Type::unreachable) {
          addReturnPointsFromExpr(secondLastInst, returnPoints);
        } else {
          for (BasicBlock const *const pred : bb->preds())
            self(self, pred);
        }
        // 4. Switch branch: handle value switch, adjacent void switch, or trace predecessors.
      } else if (auto *const sw = lastInst->dynCast<wasm::Switch>()) {
        if (sw->value != nullptr) {
          addReturnPointsFromExpr(sw->value, returnPoints);
        } else if (secondLastInst != nullptr && secondLastInst->type != wasm::Type::unreachable) {
          addReturnPointsFromExpr(secondLastInst, returnPoints);
        } else {
          for (BasicBlock const *const pred : bb->preds())
            self(self, pred);
        }
        // 5. Fallthrough: concrete instruction (value or void) reaching exit without explicit terminator.
      } else if (lastInst->type != wasm::Type::unreachable) {
        addReturnPointsFromExpr(lastInst, returnPoints);
      } else {
        assert(lastInst->type == wasm::Type::unreachable);
      }
    };

    visitBB(visitBB, exit);
    return returnPoints;
  }
};

} // namespace

std::vector<ReturnPoint> computeReturnPoints(wasm::Module *m, wasm::Function *func) {
  if (func == nullptr || func->body == nullptr || func->imported())
    return {};

  return CFGReturnPointFinder::find(m, func);
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "../Runner.hpp"

namespace warpo::passes::ut {

TEST(ReturnPointsTest, SingleReturnPoint) {
  auto m = loadWat(R"(
    (module
      (func $foo (result i32)
        i32.const 42
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 1U);
  ASSERT_TRUE(rps[0].expr->is<wasm::Const>());
  EXPECT_EQ(rps[0].expr->cast<wasm::Const>()->value.geti32(), 42);
}

TEST(ReturnPointsTest, ExplicitReturn) {
  auto m = loadWat(R"(
    (module
      (func $foo (result i32)
        i32.const 10
        return
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 1U);
  ASSERT_TRUE(rps[0].expr->is<wasm::Const>());
  EXPECT_EQ(rps[0].expr->cast<wasm::Const>()->value.geti32(), 10);
}

TEST(ReturnPointsTest, VoidCallFollowedByReturn) {
  auto m = loadWat(R"(
    (module
      (func $callee)
      (func $caller
        call $callee
        return
      )
    )
  )");
  auto *const func = m->getFunction("caller");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 1U);
  ASSERT_TRUE(rps[0].expr->is<wasm::Call>());
  EXPECT_EQ(rps[0].expr->cast<wasm::Call>()->target, "callee");
}

TEST(ReturnPointsTest, IfElseBranches) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c i32) (result i32)
        (if (result i32) (local.get $c)
          (then (i32.const 1))
          (else (i32.const 2))
        )
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 2U);
  std::vector<int32_t> values;
  for (auto const &rp : rps) {
    ASSERT_TRUE(rp.expr->is<wasm::Const>());
    values.push_back(rp.expr->cast<wasm::Const>()->value.geti32());
  }
  EXPECT_TRUE((values[0] == 1 && values[1] == 2) || (values[0] == 2 && values[1] == 1));
}

TEST(ReturnPointsTest, BrTableExit) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $i i32) (result i32)
        (block $out (result i32)
          (br_table $out $out
            (i32.const 99)
            (local.get $i)
          )
        )
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 1U);
  ASSERT_TRUE(rps[0].expr->is<wasm::Const>());
  EXPECT_EQ(rps[0].expr->cast<wasm::Const>()->value.geti32(), 99);
}

TEST(ReturnPointsTest, LoopWithEarlyBreak) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c i32) (result i32)
        (block $exit (result i32)
          (loop $loop (result i32)
            (if
              (local.get $c)
              (then (br $exit (i32.const 100)))
            )
            (br $loop)
          )
        )
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 1U);
  ASSERT_TRUE(rps[0].expr->is<wasm::Const>());
  EXPECT_EQ(rps[0].expr->cast<wasm::Const>()->value.geti32(), 100);
}

TEST(ReturnPointsTest, AssertTrapBranchIgnoredByCFG) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c i32) (result i32)
        (if
          (local.get $c)
          (then (unreachable))
        )
        (i32.const 77)
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 1U);
  ASSERT_TRUE(rps[0].expr->is<wasm::Const>());
  EXPECT_EQ(rps[0].expr->cast<wasm::Const>()->value.geti32(), 77);
}

TEST(ReturnPointsTest, NestedBlocksTreeConvergence) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (result i32)
        (block $b1 (result i32)
          (block $b2 (result i32)
            (if
              (local.get $c1)
              (then (br $b1 (i32.const 1)))
            )
            (if
              (local.get $c2)
              (then (br $b2 (i32.const 2)))
            )
            (i32.const 3)
          )
        )
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 3U);
  std::unordered_set<int32_t> values;
  for (auto const &rp : rps) {
    ASSERT_TRUE(rp.expr->is<wasm::Const>());
    values.insert(rp.expr->cast<wasm::Const>()->value.geti32());
  }
  EXPECT_EQ(values.size(), 3U);
  EXPECT_TRUE(values.contains(1));
  EXPECT_TRUE(values.contains(2));
  EXPECT_TRUE(values.contains(3));
}

TEST(ReturnPointsTest, VoidCallFallthrough) {
  auto m = loadWat(R"(
    (module
      (func $callee)
      (func $caller
        call $callee
      )
    )
  )");
  auto *const func = m->getFunction("caller");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 1U);
  ASSERT_TRUE(rps[0].expr->is<wasm::Call>());
  EXPECT_EQ(rps[0].expr->cast<wasm::Call>()->target, "callee");
}

TEST(ReturnPointsTest, VoidIfElseFallthrough) {
  auto m = loadWat(R"(
    (module
      (func $foo)
      (func $goo)
      (func $caller (param $c i32)
        local.get $c
        if
          call $foo
        else
          call $goo
        end
      )
    )
  )");
  auto *const func = m->getFunction("caller");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 2U);
  std::unordered_set<wasm::Name> callees;
  for (auto const &rp : rps) {
    ASSERT_TRUE(rp.expr->is<wasm::Call>());
    callees.insert(rp.expr->cast<wasm::Call>()->target);
  }
  EXPECT_EQ(callees.size(), 2U);
  EXPECT_TRUE(callees.contains("foo"));
  EXPECT_TRUE(callees.contains("goo"));
}

TEST(ReturnPointsTest, BrIfValueFallthrough) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c i32) (result i32)
        (block $b (result i32)
          (drop
            (br_if $b (i32.const 1) (local.get $c))
          )
          (i32.const 2)
        )
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 2U);
  std::vector<int32_t> values;
  for (auto const &rp : rps) {
    ASSERT_TRUE(rp.expr->is<wasm::Const>());
    values.push_back(rp.expr->cast<wasm::Const>()->value.geti32());
  }
  EXPECT_TRUE((values[0] == 1 && values[1] == 2) || (values[0] == 2 && values[1] == 1));
}

TEST(ReturnPointsTest, BrValueBranchVsFallthrough) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c i32) (result i32)
        (block $out (result i32)
          (if
            (local.get $c)
            (then
              (br $out (i32.const 10))
            )
          )
          (i32.const 20)
        )
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 2U);
  std::unordered_set<int32_t> values;
  for (auto const &rp : rps) {
    ASSERT_TRUE(rp.expr->is<wasm::Const>());
    values.insert(rp.expr->cast<wasm::Const>()->value.geti32());
  }
  EXPECT_EQ(values.size(), 2U);
  EXPECT_TRUE(values.contains(10));
  EXPECT_TRUE(values.contains(20));
}

TEST(ReturnPointsTest, VoidBrBranchVsFallthrough) {
  auto m = loadWat(R"(
    (module
      (func $foo)
      (func $goo)
      (func $caller (param $c i32)
        (block $out
          (if
            (local.get $c)
            (then
              call $foo
              br $out
            )
          )
          call $goo
        )
      )
    )
  )");
  auto *const func = m->getFunction("caller");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 2U);
  std::unordered_set<wasm::Name> callees;
  for (auto const &rp : rps) {
    ASSERT_TRUE(rp.expr->is<wasm::Call>());
    callees.insert(rp.expr->cast<wasm::Call>()->target);
  }
  EXPECT_EQ(callees.size(), 2U);
  EXPECT_TRUE(callees.contains("foo"));
  EXPECT_TRUE(callees.contains("goo"));
}

TEST(ReturnPointsTest, NestedBlocksBrIfAndFallthrough) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (result i32)
        (block $b0 (result i32)
          (block $b1
            (br_if $b1 (local.get $c1))
            (br $b0 (i32.const 1))
          )
          (if
            (local.get $c2)
            (then
              (br $b0 (i32.const 2))
            )
          )
          (i32.const 3)
        )
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 3U);
  std::unordered_set<int32_t> values;
  for (auto const &rp : rps) {
    ASSERT_TRUE(rp.expr->is<wasm::Const>());
    values.insert(rp.expr->cast<wasm::Const>()->value.geti32());
  }
  EXPECT_EQ(values.size(), 3U);
  EXPECT_TRUE(values.contains(1));
  EXPECT_TRUE(values.contains(2));
  EXPECT_TRUE(values.contains(3));
}

TEST(ReturnPointsTest, BrIfInsideIfWithFallthrough) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (result i32)
        (block $out (result i32)
          (if
            (local.get $c1)
            (then
              (drop
                (br_if $out (i32.const 10) (local.get $c2))
              )
              (br $out (i32.const 20))
            )
          )
          (i32.const 30)
        )
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 3U);
  std::unordered_set<int32_t> values;
  for (auto const &rp : rps) {
    ASSERT_TRUE(rp.expr->is<wasm::Const>());
    values.insert(rp.expr->cast<wasm::Const>()->value.geti32());
  }
  EXPECT_EQ(values.size(), 3U);
  EXPECT_TRUE(values.contains(10));
  EXPECT_TRUE(values.contains(20));
  EXPECT_TRUE(values.contains(30));
}

TEST(ReturnPointsTest, BrToOuterBlockVsInnerBlockFallthrough) {
  auto m = loadWat(R"(
    (module
      (func $foo (param $c1 i32) (param $c2 i32) (result i32)
        (block $b0 (result i32)
          (block $b1
            (if
              (local.get $c1)
              (then (br $b0 (i32.const 10)))
            )
            (if
              (local.get $c2)
              (then (br $b1))
            )
            (br $b0 (i32.const 20))
          )
          (i32.const 30)
        )
      )
    )
  )");
  auto *const func = m->getFunction("foo");
  auto const rps = computeReturnPoints(m.get(), func);
  ASSERT_EQ(rps.size(), 3U);
  std::unordered_set<int32_t> values;
  for (auto const &rp : rps) {
    ASSERT_TRUE(rp.expr->is<wasm::Const>());
    values.insert(rp.expr->cast<wasm::Const>()->value.geti32());
  }
  EXPECT_EQ(values.size(), 3U);
  EXPECT_TRUE(values.contains(10));
  EXPECT_TRUE(values.contains(20));
  EXPECT_TRUE(values.contains(30));
}

} // namespace warpo::passes::ut

#endif
