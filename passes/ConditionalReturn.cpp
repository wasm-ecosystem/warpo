// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <deque>
#include <fmt/format.h>
#include <memory>

#include "ConditionalReturn.hpp"
#include "fmt/base.h"
#include "helper/Matcher.hpp"
#include "pass.h"
#include "support/name.h"
#include "warpo/support/Debug.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "CONDITION_RETURN"

namespace warpo::passes {
namespace {

struct Scanner : public wasm::PostWalker<Scanner> {
  std::deque<wasm::Expression **> targetIfs_;
  void visitIf(wasm::If *expr) {
    using namespace matcher;
    M const matcher = isIf(!_if::hasFalse(), _if::ifTrue(isReturn()));
    if (matcher(*expr)) {
      targetIfs_.push_back(getCurrentPointer());
    }
  }
};

wasm::Name getBlockName(size_t id) { return fmt::format(PASS_NAME "#{}", id); }

wasm::Name getValidBlockName(wasm::Function *func) {
  struct Visitor final : public wasm::PostWalker<Visitor> {
    wasm::Name name;
    bool found = false;
    explicit Visitor(wasm::Name const &name) : name(name) {}
    void visitBlock(wasm::Block *expr) {
      if (expr->name == name) {
        found = true;
      }
    }
    void visitLoop(wasm::Loop *expr) {
      if (expr->name == name) {
        found = true;
      }
    }
  };
  if (auto *const block = func->body->dynCast<wasm::Block>()) {
    if (!block->name.isNull())
      return block->name;
  }

  size_t id = 0;
  while (true) {
    wasm::Name name = getBlockName(id);
    Visitor visitor(name);
    visitor.visit(func->body);
    if (!visitor.found)
      return name;
    id++;
  }
}

struct ConditionalReturnOptimizer : public wasm::Pass {
  std::unique_ptr<Pass> create() override { return std::make_unique<ConditionalReturnOptimizer>(); }
  bool isFunctionParallel() override { return true; }
  bool modifiesBinaryenIR() override { return true; }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override {
    // to simplify the implement, we only handle functions return void
    if (func->getResults() != wasm::Type::none)
      return;
    Scanner scanner{};
    scanner.walk(func->body);

    if (!scanner.targetIfs_.empty()) {
      if (support::isDebug(PASS_NAME, func->name.str)) {
        fmt::println("[" PASS_NAME
                     "] fn '{}' has {} (if (cond) (return)) patterns which can be converted to (br_if (cond))",
                     func->name.str, scanner.targetIfs_.size());
      }
      wasm::Builder b{*m};
      wasm::Name const targetName = getValidBlockName(func);
      for (wasm::Expression **const expr : scanner.targetIfs_) {
        assert((*expr)->is<wasm::If>());
        *expr = b.makeBreak(targetName, nullptr, (*expr)->cast<wasm::If>()->condition);
      }
      // func->body could be IfExpr, we should update it at the end.
      wasm::Block *targetBlock;
      if (auto *const block = func->body->dynCast<wasm::Block>()) {
        targetBlock = block;
      } else {
        targetBlock = b.makeBlock(func->body);
      }
      targetBlock->name = targetName;

      func->body = targetBlock;
    }
  }
};

} // namespace
} // namespace warpo::passes

wasm::Pass *warpo::passes::createConditionalReturnPass() { return new ConditionalReturnOptimizer(); }

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "pass.h"

namespace warpo::passes::ut {

TEST(ConditionalReturnTest, FunctionBodyIsBlock) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32)
        local.get 0
        if
          return
        end
          local.get 0
        drop
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");
  wasm::Expression *const condition = func->body->cast<wasm::Block>()->list[0]->cast<wasm::If>()->condition;

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>(createConditionalReturnPass()));
  runner.runOnFunction(func);

  ASSERT_TRUE(func->body->is<wasm::Block>());
  wasm::Block *const block = func->body->cast<wasm::Block>();
  EXPECT_EQ(block->name, getBlockName(0U));
  ASSERT_EQ(block->list.size(), 2U);
  ASSERT_TRUE(block->list[0]->is<wasm::Break>());
  wasm::Break *const break_ = block->list[0]->cast<wasm::Break>();
  EXPECT_EQ(break_->name, getBlockName(0U));
  EXPECT_EQ(break_->condition, condition);
}

TEST(ConditionalReturnTest, FunctionBodyIsBlockWithName) {
  constexpr const char *BlockName = "block_name";
  auto m = loadWat(fmt::format(R"(
    (module
      (func $main (param i32)
        block ${}
          local.get 0
          if
            return
          end
            local.get 0
          drop
        end
      )
    )
  )",
                               BlockName));
  wasm::Function *const func = m->getFunction("main");
  wasm::Expression *const condition = func->body->cast<wasm::Block>()->list[0]->cast<wasm::If>()->condition;

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>(createConditionalReturnPass()));
  runner.runOnFunction(func);

  ASSERT_TRUE(func->body->is<wasm::Block>());
  wasm::Block *const block = func->body->cast<wasm::Block>();
  EXPECT_EQ(block->name, BlockName);
  ASSERT_EQ(block->list.size(), 2U);
  ASSERT_TRUE(block->list[0]->is<wasm::Break>());
  wasm::Break *const break_ = block->list[0]->cast<wasm::Break>();
  EXPECT_EQ(break_->name, BlockName);
  EXPECT_EQ(break_->condition, condition);
}

TEST(ConditionalReturnTest, FunctionBodyIsTarget) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32)
        local.get 0
        if
          return
        end
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");

  wasm::Expression *const condition = func->body->cast<wasm::If>()->condition;

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>(createConditionalReturnPass()));
  runner.runOnFunction(func);

  ASSERT_TRUE(func->body->is<wasm::Block>());
  wasm::Block *const block = func->body->cast<wasm::Block>();
  EXPECT_EQ(block->name, getBlockName(0U));
  ASSERT_EQ(block->list.size(), 1U);
  ASSERT_TRUE(block->list[0]->is<wasm::Break>());
  wasm::Break *const break_ = block->list[0]->cast<wasm::Break>();
  EXPECT_EQ(break_->name, getBlockName(0U));
  EXPECT_EQ(break_->condition, condition);
}

TEST(ConditionalReturnTest, IfIsInside) {
  auto m = loadWat(R"(
    (module
      (func $main (param i32 i32 i32)
        local.get 0
        if
          local.get 1
          if
            return
          end
        else
          local.get 2
          if
            return
          end
        end
      )
    )
  )");
  wasm::Function *const func = m->getFunction("main");

  wasm::Expression *const conditionInTrue = func->body->cast<wasm::If>()->ifTrue->cast<wasm::If>()->condition;
  wasm::Expression *const conditionInFalse = func->body->cast<wasm::If>()->ifFalse->cast<wasm::If>()->condition;

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>(createConditionalReturnPass()));
  runner.runOnFunction(func);

  wasm::Block *const block = func->body->cast<wasm::Block>();
  EXPECT_EQ(block->name, getBlockName(0U));

  wasm::Expression *ifTrue = block->list[0]->cast<wasm::If>()->ifTrue;
  ASSERT_TRUE(ifTrue->is<wasm::Break>());
  EXPECT_EQ(ifTrue->cast<wasm::Break>()->name, getBlockName(0U));
  EXPECT_EQ(ifTrue->cast<wasm::Break>()->condition, conditionInTrue);

  wasm::Expression *ifFalse = block->list[0]->cast<wasm::If>()->ifFalse;
  ASSERT_TRUE(ifFalse->is<wasm::Break>());
  EXPECT_EQ(ifFalse->cast<wasm::Break>()->name, getBlockName(0U));
  EXPECT_EQ(ifFalse->cast<wasm::Break>()->condition, conditionInFalse);
}

} // namespace warpo::passes::ut

#endif