// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <fmt/base.h>
#include <ir/module-utils.h>
#include <memory>
#include <passes/pass-utils.h>
#include <set>
#include <sstream>
#include <support/name.h>
#include <utility>
#include <vector>
#include <wasm-traversal.h>
#include <wasm.h>

#include "DoInlining.hpp"
#include "InlinedDecoratorLower.hpp"
#include "pass.h"
#include "warpo/common/AsModule.hpp"
#include "warpo/support/Container.hpp"
#include "warpo/support/Debug.hpp"

#define PASS_NAME "InlinedDecoratorLower"

namespace warpo::passes {
namespace {

struct InlineFinder : public wasm::WalkerPass<wasm::PostWalker<InlineFinder>> {
  ForceInlineHints const &forceInlineHints_;
  ChosenActions &actions_;
  wasm::Index uuid_ = 0U;

public:
  explicit InlineFinder(ForceInlineHints const &forceInlineHints, ChosenActions &actions)
      : forceInlineHints_(forceInlineHints), actions_(actions) {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override {
    return std::unique_ptr<Pass>{new InlineFinder(forceInlineHints_, actions_)};
  }

  void visitCall(wasm::Call *expr) {
    if (!forceInlineHints_.contains(expr))
      return;
    wasm::Function *const function = getModule()->getFunction(expr->target);
    if (function->imported())
      return;
    uuid_++;
    actions_[getFunction()->name].emplace_back(InliningAction{getCurrentPointer(), function, false, uuid_});
  }
};

ChosenActions createChosenActions(wasm::Module &m) {
  ChosenActions actions{};
  wasm::ModuleUtils::iterDefinedFunctions(
      m, [&actions](wasm::Function *f) { actions[f->name] = std::vector<InliningAction>{}; });
  return actions;
}

// do postorder traversal to resolve the deps.
// so that force inlined function can be inlined step by step.
class ChosenActionsLayer {
  ChosenActions actions_;
  std::unordered_map<wasm::Name, size_t> pendingInlineCallCountInEachFunc_;

public:
  std::vector<ChosenActions> layeredActions_;

  explicit ChosenActionsLayer(ChosenActions actions) : actions_(std::move(actions)) {
    pendingInlineCallCountInEachFunc_.reserve(actions_.size());
    for (auto it = actions_.begin(); it != actions_.end();) {
      if (it->second.empty()) {
        it = actions_.erase(it);
      } else {
        ++it;
      }
    }
    for (auto const &[callerSiteFuncName, actions] : actions_) {
      if (actions.empty())
        continue;
      std::set<wasm::Function *> inlinedFunctionInCurrentFunction;
      for (InliningAction const &action : actions) {
        inlinedFunctionInCurrentFunction.insert(action.contents);
      }
      if (!inlinedFunctionInCurrentFunction.empty()) {
        pendingInlineCallCountInEachFunc_[callerSiteFuncName] = inlinedFunctionInCurrentFunction.size();
      }
    }
  }

  void run() {
    while (!pendingInlineCallCountInEachFunc_.empty()) {
      if (support::isDebug(PASS_NAME))
        fmt::println("[" PASS_NAME "] start new loop");
      if (support::isDebug(PASS_NAME))
        for (auto const [name, cnt] : pendingInlineCallCountInEachFunc_)
          fmt::println("[" PASS_NAME "]   pending inline '{}' deps {} other fn", name.str, cnt);
      std::set<wasm::Name> currentLayer;
      for (auto &[callerSiteFuncName, actions] : actions_) {
        if (support::isDebug(PASS_NAME)) {
          fmt::println("[" PASS_NAME "]   check '{}' whether can be processed", callerSiteFuncName.str);
        }
        bool const canBeInlined = all_of(actions, [&](InliningAction const &action) -> bool {
          // no deps
          if (support::isDebug(PASS_NAME)) {
            bool const has = pendingInlineCallCountInEachFunc_.contains(action.contents->name);
            fmt::println("[" PASS_NAME "]     sub fn '{}' {} processed", action.contents->name.str,
                         has ? "didn't" : "did");
          }
          return !pendingInlineCallCountInEachFunc_.contains(action.contents->name);
        });
        if (canBeInlined) {
          currentLayer.insert(callerSiteFuncName);
        }
      }

      if (currentLayer.empty()) {
        // must be recursive inline, give up
        std::stringstream ss;
        for (auto const &[name, _] : pendingInlineCallCountInEachFunc_)
          ss << "\n  " << name;
        fmt::println("[" PASS_NAME "] give up inline due to recursive inline decorators{}", std::move(ss).str());
        break;
      }

      // construct layered action
      ChosenActions currentLayeredActions;
      for (wasm::Name const &callerSiteFuncName : currentLayer) {
        currentLayeredActions.insert_or_assign(callerSiteFuncName, std::move(actions_.at(callerSiteFuncName)));
        actions_.erase(callerSiteFuncName);
        if (support::isDebug(PASS_NAME)) {
          fmt::println("[" PASS_NAME "]   process inline in fn '{}'", callerSiteFuncName.str);
          for (auto action : currentLayeredActions.at(callerSiteFuncName))
            fmt::println("[" PASS_NAME "]     will inline fn '{}'", action.contents->name.str);
        }
      }
      layeredActions_.push_back(std::move(currentLayeredActions));
      // update deps
      for (wasm::Name const &callerSiteFuncName : currentLayer) {
        pendingInlineCallCountInEachFunc_.erase(callerSiteFuncName);
      }
    }
  }
};

wasm::PassUtils::FuncSet createPassFunctionSet(wasm::Module &m, ChosenActions const &actions) {
  wasm::PassUtils::FuncSet set{};
  for (auto const &[name, _] : actions) {
    set.insert(m.getFunction(name));
  }
  return set;
}

class InlinedDecoratorLower : public wasm::Pass {
  std::shared_ptr<ForceInlineHints> forceInlineHints_;

public:
  explicit InlinedDecoratorLower(std::shared_ptr<ForceInlineHints> const &forceInlineHints)
      : forceInlineHints_{forceInlineHints} {}
  void run(wasm::Module *m) override {
    if (forceInlineHints_ == nullptr)
      return;
    ChosenActions actions = createChosenActions(*m);
    wasm::PassRunner runner{getPassRunner()};
    runner.add(std::unique_ptr<wasm::Pass>{new InlineFinder(*forceInlineHints_, actions)});
    runner.run();

    ChosenActionsLayer layer{std::move(actions)};
    layer.run();

    for (ChosenActions const &subActions : layer.layeredActions_) {
      wasm::PassUtils::FuncSet const relevantFuncs = createPassFunctionSet(*m, subActions);
      wasm::PassUtils::FilteredPassRunner runner{m, relevantFuncs, getPassRunner()->options};
      runner.setIsNested(true);
      runner.add(std::unique_ptr<wasm::Pass>{new DoInlining(subActions)});
      runner.run();
    }
  }
};

} // namespace
} // namespace warpo::passes

wasm::Pass *warpo::passes::createInlinedDecoratorLower(std::shared_ptr<ForceInlineHints> const &forceInlineHints) {
  return new InlinedDecoratorLower(forceInlineHints);
}

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>
#include <list>
#include <string_view>

namespace warpo::passes::ut {

struct InlinedDecoratorLowerTest : public ::testing::Test {
  ChosenActions actions;

  std::list<wasm::Expression *> exprPtrs;
  std::vector<std::unique_ptr<wasm::Expression>> exprs;
  std::map<std::string_view, std::unique_ptr<wasm::Function>> funcs;

  wasm::Expression **allocExpr() {
    exprs.push_back(std::unique_ptr<wasm::Expression>{new wasm::Expression(wasm::Expression::Id::CallId)});
    exprPtrs.push_back(exprs.back().get());
    return &exprPtrs.back();
  }
  wasm::Function *ensureFunc(std::string_view name) {
    if (funcs.contains(name))
      return funcs.at(name).get();
    auto func = std::unique_ptr<wasm::Function>{new wasm::Function()};
    func->name = name;
    return funcs.insert_or_assign(name, std::move(func)).first->second.get();
  }
};

TEST_F(InlinedDecoratorLowerTest, ChosenActionsLayerEmpty) {
  actions.insert_or_assign("f", std::vector<InliningAction>{});
  ChosenActionsLayer layer{std::move(actions)};
  layer.run();
  EXPECT_TRUE(layer.layeredActions_.empty());
}

TEST_F(InlinedDecoratorLowerTest, ChosenActionsLayerBase) {
  ChosenActions actions{};
  std::string_view const caller = "f1";
  std::string_view const callee = "f2";

  wasm::Expression **const callSite = allocExpr();
  actions[caller].push_back(InliningAction{callSite, ensureFunc(callee), false});

  ChosenActionsLayer layer{std::move(actions)};
  layer.run();
  ASSERT_EQ(layer.layeredActions_.size(), 1);
  ASSERT_EQ(layer.layeredActions_[0].size(), 1U);
  ASSERT_EQ(layer.layeredActions_[0].at(caller).size(), 1);
  EXPECT_EQ(layer.layeredActions_[0].at(caller)[0].callSite, callSite);
}

TEST_F(InlinedDecoratorLowerTest, ChosenActionsLayerNest) {
  ChosenActions actions{};
  // f1 -> f2 -> f3
  std::string_view const f1 = "f1";
  std::string_view const f2 = "f2";
  std::string_view const f3 = "f3";

  wasm::Expression **const f1CallF2 = allocExpr();
  wasm::Expression **const f2CallF3 = allocExpr();
  actions[f1].push_back(InliningAction{f1CallF2, ensureFunc(f2), false});
  actions[f2].push_back(InliningAction{f2CallF3, ensureFunc(f3), false});

  ChosenActionsLayer layer{std::move(actions)};
  layer.run();
  ASSERT_EQ(layer.layeredActions_.size(), 2U);

  ASSERT_EQ(layer.layeredActions_[0].size(), 1U);
  ASSERT_EQ(layer.layeredActions_[0].at(f2).size(), 1);
  EXPECT_EQ(layer.layeredActions_[0].at(f2)[0].callSite, f2CallF3);

  ASSERT_EQ(layer.layeredActions_[1].size(), 1U);
  ASSERT_EQ(layer.layeredActions_[1].at(f1).size(), 1);
  EXPECT_EQ(layer.layeredActions_[1].at(f1)[0].callSite, f1CallF2);
}

TEST_F(InlinedDecoratorLowerTest, ChosenActionsLayerParallel) {
  ChosenActions actions{};
  // f1 -> f2 -> f3
  std::string_view const f1 = "f1";
  std::string_view const f2 = "f2";
  std::string_view const f3 = "f3";

  // f4 -> f5
  std::string_view const f4 = "f4";
  std::string_view const f5 = "f5";

  wasm::Expression **const f1CallF2 = allocExpr();
  wasm::Expression **const f2CallF3 = allocExpr();
  actions[f1].push_back(InliningAction{f1CallF2, ensureFunc(f2), false});
  actions[f2].push_back(InliningAction{f2CallF3, ensureFunc(f3), false});
  wasm::Expression **const f4CallF5 = allocExpr();
  actions[f4].push_back(InliningAction{f4CallF5, ensureFunc(f5), false});

  ChosenActionsLayer layer{std::move(actions)};
  layer.run();
  ASSERT_EQ(layer.layeredActions_.size(), 2U);
  ASSERT_EQ(layer.layeredActions_[0].size(), 2U);
  ASSERT_EQ(layer.layeredActions_[0].at(f2).size(), 1U);
  EXPECT_EQ(layer.layeredActions_[0].at(f2)[0].callSite, f2CallF3);
  ASSERT_EQ(layer.layeredActions_[0].at(f4).size(), 1U);
  EXPECT_EQ(layer.layeredActions_[0].at(f4)[0].callSite, f4CallF5);

  ASSERT_EQ(layer.layeredActions_[1].size(), 1U);
  ASSERT_EQ(layer.layeredActions_[1].at(f1).size(), 1U);
  EXPECT_EQ(layer.layeredActions_[1].at(f1)[0].callSite, f1CallF2);
}

TEST_F(InlinedDecoratorLowerTest, ChosenActionsLayerRecursive) {
  ChosenActions actions{};
  // f1 -> f2 -> f3 -> f1
  // f1 -> f4
  std::string_view const f1 = "f1";
  std::string_view const f2 = "f2";
  std::string_view const f3 = "f3";
  std::string_view const f4 = "f4";

  wasm::Expression **const f1CallF2 = allocExpr();
  wasm::Expression **const f1CallF4 = allocExpr();
  wasm::Expression **const f2CallF3 = allocExpr();
  wasm::Expression **const f3CallF1 = allocExpr();
  actions[f1].push_back(InliningAction{f1CallF2, ensureFunc(f2), false});
  actions[f1].push_back(InliningAction{f1CallF4, ensureFunc(f4), false});
  actions[f2].push_back(InliningAction{f2CallF3, ensureFunc(f3), false});
  actions[f3].push_back(InliningAction{f3CallF1, ensureFunc(f1), false});

  ChosenActionsLayer layer{std::move(actions)};
  layer.run();
  ASSERT_EQ(layer.layeredActions_.size(), 0U);
}

} // namespace warpo::passes::ut

#endif