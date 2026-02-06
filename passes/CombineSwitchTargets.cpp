// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cstddef>
#include <ir/utils.h>
#include <memory>
#include <pass.h>
#include <unordered_map>
#include <utility>
#include <vector>
#include <wasm-traversal.h>
#include <wasm.h>

#include "CombineSwitchTargets.hpp"
#include "warpo/support/Unreachable.hpp"

namespace warpo::passes {
namespace {

std::size_t hashCombine(std::size_t seed, std::size_t value) {
  return seed ^ (value + 0x9e3779b97f4a7c15ULL + (seed << 6U) + (seed >> 2U));
}

struct ContinuationView {
  // A lightweight view of a "case continuation": the suffix of the parent block that
  // executes after a particular case label's block ends.
  //
  // We represent continuations as (parent block, start index) so we can hash and
  // compare the continuation bodies without copying or re-owning any expressions.
  wasm::Block *parent = nullptr;
  wasm::Index start = 0;

  bool valid() const { return parent != nullptr; }

  wasm::Index size() const {
    if (!valid())
      return 0;
    return static_cast<wasm::Index>(parent->list.size()) - start;
  }

  wasm::Expression *back() const {
    if (!valid() || start >= parent->list.size())
      return nullptr;
    return parent->list.back();
  }

  bool endsUnreachable() const {
    wasm::Expression *const last = back();
    if (last == nullptr)
      return false;
    return last->type == wasm::Type::unreachable;
  }
};

std::size_t hashContinuation(ContinuationView const &continuation) {
  if (!continuation.valid())
    return 0;
  std::size_t digest = 0;
  digest = hashCombine(digest, static_cast<std::size_t>(continuation.size()));
  for (wasm::Index index = continuation.start; index < continuation.parent->list.size(); index++) {
    digest = hashCombine(digest, wasm::ExpressionAnalyzer::hash(continuation.parent->list[index]));
  }
  return digest;
}

bool equalContinuation(ContinuationView const &left, ContinuationView const &right) {
  if (!left.valid() || !right.valid())
    return false;
  if (left.size() != right.size())
    return false;
  for (wasm::Index offset = 0; offset < left.size(); offset++) {
    wasm::Expression *const leftExpression = left.parent->list[left.start + offset];
    wasm::Expression *const rightExpression = right.parent->list[right.start + offset];
    if (!wasm::ExpressionAnalyzer::equal(leftExpression, rightExpression))
      return false;
  }
  return true;
}

struct TargetInfo {
  struct SwitchTargetRef {
    wasm::Index index = 0;
    bool isDefault = false;

    static SwitchTargetRef makeIndex(wasm::Index targetIndex) {
      return SwitchTargetRef{.index = targetIndex, .isDefault = false};
    }
    static SwitchTargetRef makeDefault() { return SwitchTargetRef{.index = 0, .isDefault = true}; }
  };

  wasm::Name name;
  wasm::Index stackIndex = 0;
  SwitchTargetRef switchTarget;
  ContinuationView continuation;
};

wasm::Index findChildIndex(wasm::Block const *parent, wasm::Expression const *child) {
  for (wasm::Index index = 0; index < parent->list.size(); index++) {
    if (parent->list[index] == child)
      return index;
  }
  assert(false && "child not found in parent");
  WARPO_UNREACHABLE;
}

void rewriteSwitchTarget(wasm::Switch *expr, TargetInfo const &targetInfo, wasm::Name const &toName) {
  if (targetInfo.switchTarget.isDefault) {
    expr->default_ = toName;
  } else {
    expr->targets[targetInfo.switchTarget.index] = toName;
  }
}

TargetInfo const *chooseCanonical(std::vector<TargetInfo> const &targetGroup) {
  // use the most outside block as canonical
  TargetInfo const *canonicalTarget = &targetGroup.front();
  for (auto const &targetInfo : targetGroup) {
    if (targetInfo.stackIndex < canonicalTarget->stackIndex)
      canonicalTarget = &targetInfo;
  }
  return canonicalTarget;
}

std::vector<std::vector<TargetInfo>> groupByContinuationEquality(std::vector<TargetInfo> const &targetBucket) {
  std::vector<std::vector<TargetInfo>> groupedTargets;
  for (auto const &targetCandidate : targetBucket) {
    bool wasPlaced = false;
    for (auto &existingGroup : groupedTargets) {
      if (equalContinuation(targetCandidate.continuation, existingGroup.front().continuation)) {
        existingGroup.push_back(targetCandidate);
        wasPlaced = true;
        break;
      }
    }
    if (!wasPlaced) {
      groupedTargets.push_back({targetCandidate});
    }
  }
  return groupedTargets;
}

// This pass looks for the common switch-lowering pattern:
//
//   block $break
//     block $caseN
//       ...
//         block $case0
//           <cond>
//           br_table $case0 ... $caseN $break
//         end
//         ;; case0 body (continuation)
//       end
//       ;; caseN body (continuation)
//     end
//
// If multiple case continuations are identical (and do not fallthrough), then
// redirect inner case labels to an outer equivalent case label.
struct CombineSwitchTargets final
    : public wasm::WalkerPass<
          wasm::ExpressionStackWalker<CombineSwitchTargets, wasm::UnifiedExpressionVisitor<CombineSwitchTargets>>> {

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<CombineSwitchTargets>(); }

  wasm::Index findInExpressionStack(wasm::Expression *needle) const {
    for (wasm::Index index = 0; index < this->expressionStack.size(); index++) {
      if (this->expressionStack[index] == needle)
        return index;
    }
    return static_cast<wasm::Index>(-1);
  }

  void appendTargetInfo(wasm::Name const &name, std::vector<TargetInfo> &targetInfos,
                        TargetInfo::SwitchTargetRef switchTarget) {
    if (name.isNull())
      return;

    wasm::Expression *const target = this->findBreakTarget(name);
    if (target == nullptr)
      return;
    if (!target->is<wasm::Block>())
      return;

    wasm::Index const stackIndex = findInExpressionStack(target);
    if (stackIndex == static_cast<wasm::Index>(-1) || stackIndex == 0)
      return;

    // limit parenet as a block. otherwise the result of continuation view may have different usage.
    auto *const parentBlock = this->expressionStack[stackIndex - 1]->dynCast<wasm::Block>();
    if (parentBlock == nullptr)
      return;

    // br to block means jump to the end of the block. It means we will start to execute the next expr after the block
    // in its parent block.
    wasm::Index const childIndex = findChildIndex(parentBlock, target);
    ContinuationView const continuation{.parent = parentBlock, .start = childIndex + 1U};

    // no further expressions after the target block
    if (continuation.start >= parentBlock->list.size())
      return;

    // only merge continuations that end in unreachable to avoid there have different usage.
    if (!continuation.endsUnreachable())
      return;

    targetInfos.push_back(
        TargetInfo{.name = name, .stackIndex = stackIndex, .switchTarget = switchTarget, .continuation = continuation});
  }

  void visitSwitch(wasm::Switch *expr) {
    std::vector<TargetInfo> targetInfos;
    targetInfos.reserve(expr->targets.size() + 1U);
    for (wasm::Index targetIndex = 0; targetIndex < expr->targets.size(); targetIndex++)
      appendTargetInfo(expr->targets[targetIndex], targetInfos, TargetInfo::SwitchTargetRef::makeIndex(targetIndex));
    appendTargetInfo(expr->default_, targetInfos, TargetInfo::SwitchTargetRef::makeDefault());

    if (targetInfos.size() < 2U)
      return;

    // hash can avoid expensive equal check for most cases
    std::unordered_map<std::size_t, std::vector<TargetInfo>> targetsByHash;
    targetsByHash.reserve(targetInfos.size());
    for (auto const &targetInfo : targetInfos)
      targetsByHash[hashContinuation(targetInfo.continuation)].push_back(targetInfo);

    for (auto &bucketEntry : targetsByHash) {
      auto &targetBucket = bucketEntry.second;
      if (targetBucket.size() < 2U)
        continue;

      for (std::vector<TargetInfo> const &targetGroup : groupByContinuationEquality(targetBucket)) {
        if (targetGroup.size() < 2U)
          continue;

        TargetInfo const *const canonicalTarget = chooseCanonical(targetGroup);
        for (TargetInfo const &targetInfo : targetGroup) {
          if (targetInfo.name != canonicalTarget->name)
            rewriteSwitchTarget(expr, targetInfo, canonicalTarget->name);
        }
      }
    }
  }
};

} // namespace
} // namespace warpo::passes

wasm::Pass *warpo::passes::createCombineSwitchTargetsPass() { return new CombineSwitchTargets(); }

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"

namespace warpo::passes::ut {

TEST(CombineSwitchTargetsTest, MergeEquivalentCaseContinuations) {
  auto m = loadWat(R"(
    (module
      (func $f (param $x i32)
        (block $break
          (block $case1
            (block $case0
              local.get $x
              br_table $case0 $case1 $break
            )
            i32.const 7
            drop
            br $break
          )
          i32.const 7
          drop
          br $break
        )
      )
    )
  )");

  wasm::Function *const f = m->getFunction("f");

  // Find the Switch in the function body.
  struct Finder : public wasm::PostWalker<Finder> {
    wasm::Switch *sw = nullptr;
    void visitSwitch(wasm::Switch *curr) { sw = curr; }
  } finder;
  finder.walk(f->body);
  ASSERT_NE(finder.sw, nullptr);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
  runner.run();

  // After merging, the first target should be redirected to the outer $case1.
  ASSERT_NE(finder.sw, nullptr);
  ASSERT_EQ(finder.sw->targets.size(), 2U);
  EXPECT_EQ(finder.sw->targets[0], wasm::Name("case1"));
  EXPECT_EQ(finder.sw->targets[1], wasm::Name("case1"));
  EXPECT_EQ(finder.sw->default_, wasm::Name("break"));
}

TEST(CombineSwitchTargetsTest, DoesNotMergeFallthroughCases) {
  auto m = loadWat(R"(
    (module
      (func $f (param $x i32)
        (block $break
          (block $case1
            (block $case0
              local.get $x
              br_table $case0 $case1 $break
            )
            i32.const 7
            drop
            ;; fallthrough (no branch)
          )
          i32.const 7
          drop
          br $break
        )
      )
    )
  )");

  wasm::Function *const f = m->getFunction("f");
  struct Finder : public wasm::PostWalker<Finder> {
    wasm::Switch *sw = nullptr;
    void visitSwitch(wasm::Switch *curr) { sw = curr; }
  } finder;
  finder.walk(f->body);
  ASSERT_NE(finder.sw, nullptr);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
  runner.run();

  ASSERT_EQ(finder.sw->targets.size(), 2U);
  EXPECT_EQ(finder.sw->targets[0], wasm::Name("case0"));
  EXPECT_EQ(finder.sw->targets[1], wasm::Name("case1"));
  EXPECT_EQ(finder.sw->default_, wasm::Name("break"));
}

TEST(CombineSwitchTargetsTest, DoesNotMergeWhenContinuationNotUnreachable) {
  auto m = loadWat(R"(
    (module
      (func $f (param $x i32)
        (block $break
          (block $case1
            (block $case0
              local.get $x
              br_table $case0 $case1 $break
            )
            local.get $x
            br_if $break
            i32.const 42
            drop
          )
          local.get $x
          br_if $break
          i32.const 42
          drop
        )
      )
    )
  )");

  wasm::Function *const f = m->getFunction("f");
  struct Finder : public wasm::PostWalker<Finder> {
    wasm::Switch *sw = nullptr;
    void visitSwitch(wasm::Switch *curr) { sw = curr; }
  } finder;
  finder.walk(f->body);
  ASSERT_NE(finder.sw, nullptr);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
  runner.run();

  ASSERT_EQ(finder.sw->targets.size(), 2U);
  EXPECT_EQ(finder.sw->targets[0], wasm::Name("case0"));
  EXPECT_EQ(finder.sw->targets[1], wasm::Name("case1"));
  EXPECT_EQ(finder.sw->default_, wasm::Name("break"));
}

TEST(CombineSwitchTargetsTest, DoesNotMergeWhenContinuationEndsWithLoop) {
  auto m = loadWat(R"(
    (module
      (func $f (param $x i32)
        (block $break
          (block $case1
            (block $case0
              local.get $x
              br_table $case0 $case1 $break
            )
            (loop $L
              nop
            )
          )
          (loop $L
            nop
          )
        )
      )
    )
  )");

  wasm::Function *const f = m->getFunction("f");
  struct Finder : public wasm::PostWalker<Finder> {
    wasm::Switch *sw = nullptr;
    void visitSwitch(wasm::Switch *curr) { sw = curr; }
  } finder;
  finder.walk(f->body);
  ASSERT_NE(finder.sw, nullptr);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
  runner.run();

  ASSERT_EQ(finder.sw->targets.size(), 2U);
  EXPECT_EQ(finder.sw->targets[0], wasm::Name("case0"));
  EXPECT_EQ(finder.sw->targets[1], wasm::Name("case1"));
  EXPECT_EQ(finder.sw->default_, wasm::Name("break"));
}

TEST(CombineSwitchTargetsTest, DoesNotMergeWhenParentIsNotBlock) {
  auto m = loadWat(R"(
    (module
      (func $f (param $x i32)
        (block $break
          (block $case1
            (if (i32.const 1)
              (then
                (block $case0
                  local.get $x
                  br_table $case0 $case1 $break
                )
              )
            )
            i32.const 7
            drop
            br $break
          )
          i32.const 7
          drop
          br $break
        )
      )
    )
  )");

  wasm::Function *const f = m->getFunction("f");
  struct Finder : public wasm::PostWalker<Finder> {
    wasm::Switch *sw = nullptr;
    void visitSwitch(wasm::Switch *curr) { sw = curr; }
  } finder;
  finder.walk(f->body);
  ASSERT_NE(finder.sw, nullptr);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
  runner.run();

  ASSERT_EQ(finder.sw->targets.size(), 2U);
  EXPECT_EQ(finder.sw->targets[0], wasm::Name("case0"));
  EXPECT_EQ(finder.sw->targets[1], wasm::Name("case1"));
  EXPECT_EQ(finder.sw->default_, wasm::Name("break"));
}

TEST(CombineSwitchTargetsTest, RewritesDefaultTargetWhenEquivalent) {
  auto m = loadWat(R"(
    (module
      (func $f (param $x i32)
        (block $break
          (block $case1
            (block $case0
              local.get $x
              br_table $case0 $case1 $case0
            )
            i32.const 7
            drop
            br $break
          )
          i32.const 7
          drop
          br $break
        )
      )
    )
  )");

  wasm::Function *const f = m->getFunction("f");
  struct Finder : public wasm::PostWalker<Finder> {
    wasm::Switch *sw = nullptr;
    void visitSwitch(wasm::Switch *curr) { sw = curr; }
  } finder;
  finder.walk(f->body);
  ASSERT_NE(finder.sw, nullptr);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
  runner.run();

  ASSERT_EQ(finder.sw->targets.size(), 2U);
  EXPECT_EQ(finder.sw->targets[0], wasm::Name("case1"));
  EXPECT_EQ(finder.sw->targets[1], wasm::Name("case1"));
  EXPECT_EQ(finder.sw->default_, wasm::Name("case1"));
}

TEST(CombineSwitchTargetsTest, ChoosesOutermostCanonicalTarget) {
  auto m = loadWat(R"(
    (module
      (func $f (param $x i32)
        (block $break
          (block $case2
            (block $case1
              (block $case0
                local.get $x
                br_table $case0 $case1 $case2 $break
              )
              i32.const 7
              drop
              br $break
            )
            i32.const 7
            drop
            br $break
          )
          i32.const 7
          drop
          br $break
        )
      )
    )
  )");

  wasm::Function *const f = m->getFunction("f");
  struct Finder : public wasm::PostWalker<Finder> {
    wasm::Switch *sw = nullptr;
    void visitSwitch(wasm::Switch *curr) { sw = curr; }
  } finder;
  finder.walk(f->body);
  ASSERT_NE(finder.sw, nullptr);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
  runner.run();

  ASSERT_EQ(finder.sw->targets.size(), 3U);
  EXPECT_EQ(finder.sw->targets[0], wasm::Name("case2"));
  EXPECT_EQ(finder.sw->targets[1], wasm::Name("case2"));
  EXPECT_EQ(finder.sw->targets[2], wasm::Name("case2"));
  EXPECT_EQ(finder.sw->default_, wasm::Name("break"));
}

TEST(CombineSwitchTargetsTest, DoesNotMergeWhenNoContinuation) {
  auto m = loadWat(R"(
    (module
      (func $f (param $x i32)
        (block $break
          (block $case1
            (block $case0
              local.get $x
              br_table $case0 $case1 $break
            )
          )
          i32.const 7
          drop
          br $break
        )
      )
    )
  )");

  wasm::Function *const f = m->getFunction("f");
  struct Finder : public wasm::PostWalker<Finder> {
    wasm::Switch *sw = nullptr;
    void visitSwitch(wasm::Switch *curr) { sw = curr; }
  } finder;
  finder.walk(f->body);
  ASSERT_NE(finder.sw, nullptr);

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createCombineSwitchTargetsPass()});
  runner.run();

  ASSERT_EQ(finder.sw->targets.size(), 2U);
  EXPECT_EQ(finder.sw->targets[0], wasm::Name("case0"));
  EXPECT_EQ(finder.sw->targets[1], wasm::Name("case1"));
  EXPECT_EQ(finder.sw->default_, wasm::Name("break"));
}

} // namespace warpo::passes::ut

#endif
