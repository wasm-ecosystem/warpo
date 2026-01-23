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
  // A simple hash combiner (similar to boost::hash_combine).
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
};

bool hasNoFallthrough(ContinuationView const &c) {
  wasm::Expression *const last = c.back();
  if (last == nullptr)
    return false;
  return last->type == wasm::Type::unreachable;
}

std::size_t hashContinuation(ContinuationView const &c) {
  if (!c.valid())
    return 0;
  std::size_t digest = 0;
  digest = hashCombine(digest, static_cast<std::size_t>(c.size()));
  for (wasm::Index i = c.start; i < c.parent->list.size(); i++) {
    digest = hashCombine(digest, wasm::ExpressionAnalyzer::hash(c.parent->list[i]));
  }
  return digest;
}

bool equalContinuation(ContinuationView const &a, ContinuationView const &b) {
  if (!a.valid() || !b.valid())
    return false;
  if (a.size() != b.size())
    return false;
  for (wasm::Index i = 0; i < a.size(); i++) {
    wasm::Expression *const ae = a.parent->list[a.start + i];
    wasm::Expression *const be = b.parent->list[b.start + i];
    if (!wasm::ExpressionAnalyzer::equal(ae, be))
      return false;
  }
  return true;
}

struct TargetInfo {
  wasm::Name name;
  wasm::Index stackIndex = 0;
  ContinuationView cont;
};

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
  bool changed_ = false;

  bool isFunctionParallel() override { return true; }
  bool modifiesBinaryenIR() override { return changed_; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<CombineSwitchTargets>(); }

  void visitSwitch(wasm::Switch *sw) {
    // Collect info for each label in the switch.
    std::vector<TargetInfo> infos;
    infos.reserve(sw->targets.size() + 1U);

    auto addTarget = [&](wasm::Name const &name) {
      if (name.isNull())
        return;
      wasm::Expression *const target = this->findBreakTarget(name);
      if (!target)
        return;
      auto *const targetBlock = target->dynCast<wasm::Block>();
      if (!targetBlock)
        return;

      // Find the target in the expression stack to get its parent.
      wasm::Index idx = 0;
      bool found = false;
      for (wasm::Index i = 0; i < this->expressionStack.size(); i++) {
        if (this->expressionStack[i] == target) {
          idx = i;
          found = true;
          break;
        }
      }
      if (!found || idx == 0)
        return;

      auto *const parentBlock = this->expressionStack[idx - 1]->dynCast<wasm::Block>();
      if (!parentBlock)
        return;

      // Find the exact child position in the parent list.
      wasm::Index childPos = 0;
      bool inList = false;
      for (wasm::Index i = 0; i < parentBlock->list.size(); i++) {
        if (parentBlock->list[i] == target) {
          childPos = i;
          inList = true;
          break;
        }
      }
      if (!inList)
        return;

      ContinuationView const cont{.parent = parentBlock, .start = childPos + 1U};
      if (!cont.valid() || cont.start > cont.parent->list.size())
        return;

      infos.push_back(TargetInfo{.name = name, .stackIndex = idx, .cont = cont});
    };

    for (auto const &t : sw->targets) {
      addTarget(t);
    }
    addTarget(sw->default_);

    if (infos.size() < 2U)
      return;

    // Bucket by hash first, then verify by structural equality.
    std::unordered_map<std::size_t, std::vector<TargetInfo>> buckets;
    buckets.reserve(infos.size());
    for (auto const &info : infos) {
      // Only merge targets whose case body does not fallthrough.
      if (!hasNoFallthrough(info.cont))
        continue;
      buckets[hashContinuation(info.cont)].push_back(info);
    }

    for (auto &it : buckets) {
      auto &bucket = it.second;
      if (bucket.size() < 2U)
        continue;

      // Partition by exact equality inside the bucket.
      std::vector<std::vector<TargetInfo>> groups;
      for (auto const &candidate : bucket) {
        bool placed = false;
        for (auto &group : groups) {
          if (equalContinuation(candidate.cont, group.front().cont)) {
            group.push_back(candidate);
            placed = true;
            break;
          }
        }
        if (!placed) {
          groups.push_back({candidate});
        }
      }

      for (auto &group : groups) {
        if (group.size() < 2U)
          continue;

        // Choose the outermost equivalent label (smallest stack index).
        TargetInfo const *canonical = &group[0];
        for (auto const &g : group) {
          if (g.stackIndex < canonical->stackIndex)
            canonical = &g;
        }

        for (auto const &g : group) {
          if (g.name == canonical->name)
            continue;
          for (auto &t : sw->targets) {
            if (t == g.name) {
              t = canonical->name;
              changed_ = true;
            }
          }
          if (sw->default_ == g.name) {
            sw->default_ = canonical->name;
            changed_ = true;
          }
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
