///
/// @brief clean GC operator when it also involve leaf function call
/// @details
/// We only need to store local to shadow stack in following pattern
/// ```
/// local.set 0  -> store local 0 to shadow stack since in callee GC may happen.
/// call <non GC leaf function>
/// local.get 0
/// ```
///
/// Lattice: enum State { InitialValue , MayHasGet , MayHasGCCall };
/// Transfer function:
///   - local.get (current element):              InitialValue -> MayHasGet
///   - local.set (element with same index):      MayHasGet -> InitialValue
///   - non leaf call (all elements):             MayHasGet -> MayHasGCCall
///

#include <cassert>
#include <cstddef>
#include <cstdint>
#include <fmt/base.h>
#include <fmt/ranges.h>
#include <iostream>
#include <map>
#include <memory>
#include <set>
#include <utility>
#include <vector>

#include "BuildGCModel.hpp"
#include "CleanDirectLocalUsesGC.hpp"
#include "CollectGCLeafFunction.hpp"
#include "analysis/lattices/int.h"
#include "analysis/lattices/vector.h"
#include "analysis/monotone-analyzer.h"
#include "analysis/visitor-transfer-function.h"
#include "pass.h"
#include "support/Container.hpp"
#include "support/Debug.hpp"
#include "support/Range.hpp"
#include "support/index.h"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

#define DEBUG_PREFIX "[CleanDirectLocalUsesGC] "

namespace warpo::passes::as_gc {
namespace {

struct GetLikeExpr {
  wasm::Expression *expr_ = nullptr;
  wasm::Index getIndex() const {
    if (auto *get = expr_->dynCast<wasm::LocalGet>())
      return get->index;
    if (auto *set = expr_->dynCast<wasm::LocalSet>())
      return set->index;
    __builtin_unreachable();
  }
  auto operator<=>(GetLikeExpr const &other) const { return expr_ <=> other.expr_; }
};

class GetUsagePoison
    : public wasm::ExpressionStackWalker<GetUsagePoison, wasm::UnifiedExpressionVisitor<GetUsagePoison>> {
  std::set<wasm::Name> const &leaf_;
  std::set<GetLikeExpr> activeGets_{}; // when meet call, those get will be poisoned
  struct OnMeetCtx {
    GetLikeExpr expr_;
    wasm::Expression *current_;
  };
  std::map<wasm::Expression *, std::vector<OnMeetCtx>>
      onMeets_{}; // when meet target expression, update current node value

  void addOnMeetCallback(wasm::Expression *target, OnMeetCtx ctx) {
    onMeets_.try_emplace(target, std::vector<OnMeetCtx>{}).first->second.push_back(std::move(ctx));
  }

  enum class ParentKind {
    Forward,  // LOOP BLOCK IF
    Consume,  // NORMAL OPCode
    Poisoned, // GC Call
  };
  ParentKind getParentKind(wasm::Expression *parent, wasm::Expression *current) {
    if (parent->is<wasm::Loop>() || parent->is<wasm::Block>())
      return ParentKind::Forward;
    if (auto *ifExpr = parent->dynCast<wasm::If>()) {
      if (ifExpr->condition != current)
        return ParentKind::Forward;
    }
    if (auto *tee = parent->dynCast<wasm::LocalSet>()) {
      if (tee->isTee())
        return ParentKind::Forward;
    }
    if (auto *call = parent->dynCast<wasm::Call>()) {
      if (!leaf_.contains(call->target))
        return ParentKind::Poisoned;
    }
    return ParentKind::Consume;
  }

  void onMeetCallback(wasm::Expression *current, OnMeetCtx const &ctx) {
    switch (getParentKind(current, ctx.current_)) {
    case ParentKind::Forward:
      addOnMeetCallback(getParent(), OnMeetCtx{ctx.expr_, current});
      break;
    case ParentKind::Consume:
      activeGets_.erase(ctx.expr_);
      break;
    case ParentKind::Poisoned:
      poisonedGets_.insert(ctx.expr_);
      break;
    default:
      __builtin_unreachable();
    }
  }

  void visitGetLikeImpl(GetLikeExpr expr) {
    activeGets_.insert(expr);
    addOnMeetCallback(getParent(), OnMeetCtx{expr, expr.expr_});
  }

  void visitCallImpl(wasm::Call *expr) {
    if (leaf_.contains(expr->target))
      return;
    for (GetLikeExpr get : activeGets_) {
      poisonedGets_.insert(get);
    }
    activeGets_.clear();
  }

public:
  explicit GetUsagePoison(std::set<wasm::Name> const &leaf) : leaf_(leaf) {}
  std::set<GetLikeExpr> poisonedGets_{};

  void visitExpression(wasm::Expression *expr) {
    if (auto it = onMeets_.find(expr); it != onMeets_.end())
      for (OnMeetCtx const &ctx : it->second)
        onMeetCallback(expr, ctx);
    if (auto *e = expr->dynCast<wasm::LocalGet>()) {
      visitGetLikeImpl({e});
    } else if (auto *e = expr->dynCast<wasm::LocalSet>()) {
      if (e->isTee())
        visitGetLikeImpl({expr});
    } else if (auto *e = expr->dynCast<wasm::Call>()) {
      visitCallImpl(e);
    }
  }
};

class LocalsGetterLattice : public wasm::analysis::Vector<wasm::analysis::Integer<uint8_t>> {
  using Super = wasm::analysis::Vector<wasm::analysis::Integer<uint8_t>>;
  // in lattice, we store local.get as [0 0 0 1 2 2 2 2]
  // then each local.get can be find by localOffsetLookupTable_[local.get->index] + localgetsLookupTable_[local.get]
  // localOffsetLookupTable_ is [0 3 4 8]
  std::vector<size_t> localOffsetLookupTable_{};
  std::map<wasm::LocalGet *, size_t> localGetsLookupTable_{};
  explicit LocalsGetterLattice(size_t size, std::vector<size_t> localLookupTable,
                               std::map<wasm::LocalGet *, size_t> localgetsLookupTable)
      : Super(wasm::analysis::Integer<uint8_t>{}, size), localOffsetLookupTable_(std::move(localLookupTable)),
        localGetsLookupTable_(std::move(localgetsLookupTable)) {};

public:
  static LocalsGetterLattice create(wasm::Function &f) {
    struct LocalGetCollector : public wasm::PostWalker<LocalGetCollector> {
      std::vector<wasm::Index> counter_;
      std::map<wasm::LocalGet *, size_t> localgetsLookupTable_;
      explicit LocalGetCollector(wasm::Function &f) : counter_(f.getNumLocals(), 0) {}
      void visitLocalGet(wasm::LocalGet *expr) {
        localgetsLookupTable_.insert_or_assign(expr, counter_[expr->index]);
        counter_[expr->index]++;
      }
    };
    LocalGetCollector collector{f};
    collector.walkFunction(&f);
    std::vector<size_t> localLookupTable;
    size_t cnt = 0;
    for (size_t count : collector.counter_) {
      localLookupTable.push_back(cnt);
      cnt += count;
    }
    localLookupTable.push_back(cnt);
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "local lookup table: {}", fmt::join(localLookupTable, ","));
    return LocalsGetterLattice{cnt, localLookupTable, std::move(collector.localgetsLookupTable_)};
  }

  size_t getIndex(wasm::LocalGet *get) const {
    return localOffsetLookupTable_.at(get->index) + localGetsLookupTable_.at(get);
  }
  Range getIndexRange(wasm::LocalSet *set) const {
    return Range{localOffsetLookupTable_.at(set->index), localOffsetLookupTable_.at(set->index + 1U)};
  }
  std::vector<wasm::LocalGet *> getLocalGetsLookupTable() {
    std::vector<wasm::LocalGet *> ret{};
    ret.resize(Super::size, nullptr);
    for (auto const &[get, index] : localGetsLookupTable_) {
      ret.at(localOffsetLookupTable_.at(get->index) + index) = get;
    }
    return ret;
  }
};

std::set<GetLikeExpr> getPoisonedGetLikeExpr(wasm::Function *func, std::set<wasm::Name> const &leaf) {
  GetUsagePoison finder{leaf};
  finder.walkFunction(func);
  if (support::isDebug()) {
    fmt::println(DEBUG_PREFIX "poisoned get size: {}", finder.poisonedGets_.size());
  }
  return std::move(finder.poisonedGets_);
}

class LocalsGetterTransferFn : public wasm::analysis::VisitorTransferFunc<LocalsGetterTransferFn, LocalsGetterLattice,
                                                                          wasm::analysis::AnalysisDirection::Backward> {
  using Super = wasm::analysis::VisitorTransferFunc<LocalsGetterTransferFn, LocalsGetterLattice,
                                                    wasm::analysis::AnalysisDirection::Backward>;
  std::set<wasm::Name> const &leaf_;
  static constexpr uint8_t MayHasGCCall = 2U; // TOP
  static constexpr uint8_t MayHasGet = 1U;
  static constexpr uint8_t InitialValue = 0U;
  std::set<GetLikeExpr> poisonedGets_{};

public:
  std::set<wasm::LocalSet *> results_{};
  LocalsGetterLattice lattice_;

  explicit LocalsGetterTransferFn(wasm::Function &f, std::set<wasm::Name> const &leaf)
      : Super{}, lattice_(LocalsGetterLattice::create(f)), leaf_(leaf),
        poisonedGets_{getPoisonedGetLikeExpr(&f, leaf)} {}
  void visitCall(wasm::Call *expr) {
    // we force on GC call
    if (leaf_.contains(expr->target))
      return;
    for (uint8_t &element : *currState) {
      if (element == MayHasGet) {
        element = MayHasGCCall;
      }
    }
  }
  void visitLocalGet(wasm::LocalGet *expr) {
    uint8_t &element = currState->at(lattice_.getIndex(expr));
    // treat parameter of non leaf function call as HasGCCall also.
    if (element == InitialValue)
      element = MayHasGet;
    if (poisonedGets_.contains(GetLikeExpr{.expr_ = expr}))
      element = MayHasGCCall;
  }
  void visitLocalSet(wasm::LocalSet *expr) {
    if (collectingResults) {
      bool const notInfluencedByGCCall =
          all_of(lattice_.getIndexRange(expr), [this](size_t i) -> bool { return currState->at(i) != MayHasGCCall; });
      bool const teePoisoned = expr->isTee() && poisonedGets_.contains(GetLikeExpr{.expr_ = expr});
      if (notInfluencedByGCCall && !teePoisoned) {
        results_.insert(expr);
      }
    }
    for (size_t i : lattice_.getIndexRange(expr)) {
      uint8_t &element = currState->at(i);
      element = InitialValue;
    }
  }
};

static std::set<wasm::LocalSet *> scanTemporaryObjectLocalSet(wasm::Function *f,
                                                              std::set<wasm::Name> const &leafFunctions) {
  LocalsGetterTransferFn transfer{*f, leafFunctions};
  wasm::analysis::CFG cfg = wasm::analysis::CFG::fromFunction(f);
  using Analyzer = wasm::analysis::MonotoneCFGAnalyzer<LocalsGetterLattice, LocalsGetterTransferFn>;
  Analyzer analyzer{transfer.lattice_, transfer, cfg};
  analyzer.evaluateAndCollectResults();
  std::set<wasm::LocalSet *> results = std::move(transfer.results_);
  // temporary object may be leaked by (local.set 0 (local.get 1)). We should make sure leaked object is also temporary.
  struct LeakAnalyzer : public wasm::PostWalker<LeakAnalyzer> {
    std::set<wasm::LocalSet *> &temporaryObjectLocalSets_;
    explicit LeakAnalyzer(std::set<wasm::LocalSet *> &temporaryObjectLocalSets)
        : temporaryObjectLocalSets_(temporaryObjectLocalSets) {}
    void visitLocalSet(wasm::LocalSet *expr) {
      if (temporaryObjectLocalSets_.contains(expr))
        return;
      if (auto const *value = expr->value->dynCast<wasm::LocalGet>(); value != nullptr)
        std::erase_if(temporaryObjectLocalSets_,
                      [index = value->index](wasm::LocalSet *set) { return set->index == index; });
      if (auto *value = expr->value->dynCast<wasm::LocalSet>(); value != nullptr)
        temporaryObjectLocalSets_.erase(value);
    }
  };
  runUntilImmutable(
      [&results, f]() {
        LeakAnalyzer leakAnalyzer{results};
        leakAnalyzer.walkFunction(f);
      },
      [&results]() { return results.size(); });
  return results;
}

struct StoreCleaner : public wasm::PostWalker<StoreCleaner> {
  std::set<wasm::LocalSet *> const &target_;
  explicit StoreCleaner(std::set<wasm::LocalSet *> const &target) : target_{target} {}
  explicit StoreCleaner(std::set<wasm::LocalSet *> &&target) = delete;
  void visitStore(wasm::Store *expr) {
    if (!matcher::isGCStore(*expr))
      return;
    wasm::LocalSet *v = expr->value->dynCast<wasm::LocalSet>();
    if (v == nullptr || !target_.contains(v))
      return;
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "remove GC store {} which contain local.set {}", static_cast<void *>(expr),
                   static_cast<void *>(v));
    wasm::Builder builder{*getModule()};
    replaceCurrent(builder.makeDrop(expr->value));
  }
};

struct DirectLocalUsedGCCleaner : public wasm::WalkerPass<wasm::PostWalker<DirectLocalUsedGCCleaner>> {
  std::set<wasm::Name> const &leafFunctions_;
  explicit DirectLocalUsedGCCleaner(std::set<wasm::Name> &&leafFunctions) = delete;
  explicit DirectLocalUsedGCCleaner(std::set<wasm::Name> const &leafFunctions) : leafFunctions_(leafFunctions) {
    name = "DirectLocalUsedGCCleaner";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<DirectLocalUsedGCCleaner>(leafFunctions_); }
  bool modifiesBinaryenIR() override { return true; }

  void runOnFunction(wasm::Module *m, wasm::Function *f) override {
    if (leafFunctions_.contains(f->name))
      // leaf function should not have GC operation
      return;
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "analysis local uses in '{}' ", f->name.str);
    std::set<wasm::LocalSet *> const target = scanTemporaryObjectLocalSet(f, leafFunctions_);
    StoreCleaner cleaner{target};
    cleaner.walkFunctionInModule(f, m);
  }
};

struct CleanDirectLocalUsesGC : public wasm::Pass {
  CleanDirectLocalUsesGC() { name = "DirectLocalUsesGCCleaner"; }
  void run(wasm::Module *m) override {
    if (m->getFunctionOrNull(newFunctionName) == nullptr) {
      if (support::isDebug())
        fmt::println(DEBUG_PREFIX "skipped because '{}' is not found", newFunctionName);
      return;
    }
    CallGraph callGraph = CallCollector::createCallGraph(*m);
    std::set<wasm::Name> const taints{newFunctionName, collectFunctionName};
    std::set<wasm::Name> leafFunctions{};

    wasm::PassRunner runner{getPassRunner()};
    runner.add(std::unique_ptr<wasm::Pass>{new CallCollector(callGraph)});
    runner.add(std::unique_ptr<wasm::Pass>{new LeafFunctionCollector(callGraph, taints, leafFunctions)});
    runner.add(std::unique_ptr<wasm::Pass>{new DirectLocalUsedGCCleaner(leafFunctions)});
    runner.run();
  }
};

} // namespace
} // namespace warpo::passes::as_gc

wasm::Pass *warpo::passes::as_gc::createCleanDirectLocalUsesGC() { return new CleanDirectLocalUsesGC(); }

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "Runner.hpp"

namespace warpo::passes::ut {

using namespace as_gc;
using testing::Contains;
using testing::IsEmpty;
using testing::Not;

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetBase) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (drop (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, Contains(body[0]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetCallLeaf) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $non-leaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (call $leaf)
          (drop (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, Contains(body[0]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetCallNonLeaf) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (call $nonleaf)
          (drop (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, Not(Contains(body[0]->cast<wasm::LocalSet>())));
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetCallAfterGet) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (drop (local.get 0))
          (call $nonleaf)
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, Contains(body[0]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetCallAsLeafParameters) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf (param i32))
        (func $nonleaf (param i32))
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (call $leaf (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, Contains(body[0]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetCallAsNonLeafParameters) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf (param i32))
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (call $nonleaf (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, Not(Contains(body[0]->cast<wasm::LocalSet>())));
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectMultipleSet) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100)) ;; 0
          (call $nonleaf)               ;; 1
          (drop (local.get 0))          ;; 2

          (local.set 0 (i32.const 200)) ;; 3
          (drop (local.get 0))          ;; 4

          (local.set 0 (i32.const 300)) ;; 5
          (call $nonleaf)               ;; 6
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, Not(Contains(body[0]->cast<wasm::LocalSet>())));
  EXPECT_THAT(targets, Contains(body[3]->cast<wasm::LocalSet>()));
  EXPECT_THAT(targets, Contains(body[5]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectMultipleLocal) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100)) ;; 0
          (call $nonleaf)               ;; 1
          (drop (local.get 1))          ;; 2
          
          (local.set 1 (i32.const 200)) ;; 3
          (drop (local.get 0))          ;; 4
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, Not(Contains(body[0]->cast<wasm::LocalSet>())));
  EXPECT_THAT(targets, Contains(body[3]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetCondition) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (if
            (local.get 1)
            (then (call $leaf))
            (else (call $nonleaf))
          )
          (drop (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, IsEmpty());
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetCondition2) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (if
            (local.get 1)
            (then (call $leaf))
          )
          (drop (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_EQ(targets.size(), 1);
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetConditionGet) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (if
            (local.get 1)
            (then (call $nonleaf))
            (else (drop (local.get 0)))
          )
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_EQ(targets.size(), 1);
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetConditionMultipleGet) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (local.set 0 (i32.const 100))
          (if
            (local.get 1)
            (then
              (call $nonleaf)
              (drop (local.get 0))
            )
            (else (drop (local.get 0)))
          )
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, IsEmpty());
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetLoop) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (loop
            (drop (local.get 0))
            (call $nonleaf)
            (local.set 0 (i32.const 100))
            (br_if 0 (local.get 1))
          )
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_EQ(targets.size(), 1);
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectSetLoop2) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (local i32) (local i32)
          (loop
            (local.set 0 (i32.const 100))
            (drop (local.get 0))
            (call $nonleaf)
            (local.set 0 (i32.const 200))
            (br_if 0 (local.get 1))
          )
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_EQ(targets.size(), 2);
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectUseLazy) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (result i32)
          (local i32 i32)
          (local.set 0 (i32.const 100))
            local.get 0   ;; get to operand stack
            call $nonleaf
          drop          ;; lazy use
            local.get 0   ;; get to operand stack
            call $nonleaf
          return          ;; lazy use
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, IsEmpty());
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectLazyCrossBasicBlock) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (result i32)
          (local i32 i32)
          (local.set 0 (i32.const 100))
              local.get 1
            if (result i32)
              local.get 0   ;; get to operand stack
              call $nonleaf
            else
              i32.const 0
            end
          return            ;; lazy use
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, IsEmpty());
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectLazyCrossBasicBlock2) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (result i32)
          (local i32 i32)
          (local.set 0 (i32.const 100))
              local.get 1
            if (result i32)
              local.get 0   ;; get to operand stack
            else
              i32.const 0
              call $nonleaf
            end
          return            ;; lazy use
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, IsEmpty()); // FIXME: should be detect.
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectLazyTee) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (result i32)
          (local i32 i32)
              i32.const 100
            local.tee 0
            i32.const 0
            call $nonleaf
          i32.add            ;; lazy use
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, IsEmpty());
}

TEST(CleanDirectLocalUsesGC, TemporaryObjectLazyCrossSet) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $leaf)
        (func $nonleaf)
        (func $f (result i32)
          (local i32 i32)
              i32.const 100
            local.tee 0
              i32.const 200
            local.tee 0
            call $nonleaf
          i32.add            ;; lazy use
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");

  std::set<wasm::Name> const leaf{"leaf"};
  std::set<wasm::LocalSet *> const targets = scanTemporaryObjectLocalSet(f, leaf);
  EXPECT_THAT(targets, IsEmpty());
}

} // namespace warpo::passes::ut

#endif
