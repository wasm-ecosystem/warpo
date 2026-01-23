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

namespace warpo::passes {
namespace {

std::size_t hashCombine(std::size_t seed, std::size_t value) {
  return seed ^ (value + 0x9e3779b97f4a7c15ULL + (seed << 6U) + (seed >> 2U));
}

struct ContinuationView {
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
  wasm::Name name;
  wasm::Index stackIndex = 0;
  ContinuationView continuation;
};

bool findChildIndex(wasm::Block const *parent, wasm::Expression const *child, wasm::Index &outIndex) {
  for (wasm::Index index = 0; index < parent->list.size(); index++) {
    if (parent->list[index] == child) {
      outIndex = index;
      return true;
    }
  }
  return false;
}

void rewriteSwitchTarget(wasm::Switch *switchInstruction, wasm::Name const &fromName, wasm::Name const &toName) {
  for (auto &targetName : switchInstruction->targets) {
    if (targetName == fromName) {
      targetName = toName;
    }
  }
  if (switchInstruction->default_ == fromName) {
    switchInstruction->default_ = toName;
  }
}

TargetInfo const *chooseCanonical(std::vector<TargetInfo> const &targetGroup) {
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

  void appendTargetInfo(wasm::Name const &name, std::vector<TargetInfo> &targetInfos) {
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

    auto *const parentBlock = this->expressionStack[stackIndex - 1]->dynCast<wasm::Block>();
    if (parentBlock == nullptr)
      return;

    wasm::Index childIndex = 0;
    if (!findChildIndex(parentBlock, target, childIndex))
      return;

    ContinuationView const continuation{.parent = parentBlock, .start = childIndex + 1U};
    if (continuation.start > continuation.parent->list.size())
      return;

    targetInfos.push_back(TargetInfo{.name = name, .stackIndex = stackIndex, .continuation = continuation});
  }

  void visitSwitch(wasm::Switch *switchInstruction) {
    std::vector<TargetInfo> targetInfos;
    targetInfos.reserve(switchInstruction->targets.size() + 1U);
    for (auto const &targetName : switchInstruction->targets)
      appendTargetInfo(targetName, targetInfos);
    appendTargetInfo(switchInstruction->default_, targetInfos);

    if (targetInfos.size() < 2U)
      return;

    std::unordered_map<std::size_t, std::vector<TargetInfo>> targetsByHash;
    targetsByHash.reserve(targetInfos.size());
    for (auto const &targetInfo : targetInfos) {
      if (!targetInfo.continuation.endsUnreachable())
        continue;
      targetsByHash[hashContinuation(targetInfo.continuation)].push_back(targetInfo);
    }

    for (auto &bucketEntry : targetsByHash) {
      auto &targetBucket = bucketEntry.second;
      if (targetBucket.size() < 2U)
        continue;

      for (auto &targetGroup : groupByContinuationEquality(targetBucket)) {
        if (targetGroup.size() < 2U)
          continue;

        TargetInfo const *const canonicalTarget = chooseCanonical(targetGroup);
        for (auto const &targetInfo : targetGroup) {
          if (targetInfo.name == canonicalTarget->name)
            continue;
          rewriteSwitchTarget(switchInstruction, targetInfo.name, canonicalTarget->name);
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

} // namespace warpo::passes::ut

#endif
