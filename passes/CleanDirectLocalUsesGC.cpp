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

class LocalsGetterTransferFn : public wasm::analysis::VisitorTransferFunc<LocalsGetterTransferFn, LocalsGetterLattice,
                                                                          wasm::analysis::AnalysisDirection::Backward> {
  static constexpr uint8_t MayHasGCCall = 2U; // TOP
  static constexpr uint8_t MayHasGet = 1U;
  static constexpr uint8_t InitialValue = 0U;

  std::set<wasm::LocalGet *> callOperands_{};

public:
  std::set<wasm::LocalSet *> results_{};
  LocalsGetterLattice lattice_;
  std::set<wasm::Name> const &leaf_;

  explicit LocalsGetterTransferFn(wasm::Function &f, std::set<wasm::Name> const &leaf)
      : lattice_(LocalsGetterLattice::create(f)), leaf_(leaf) {}
  explicit LocalsGetterTransferFn(wasm::Function &f, std::set<wasm::Name> &&leaf) = delete;

  void visitCall(wasm::Call *expr) {
    // we force on GC call
    if (leaf_.contains(expr->target))
      return;
    for (uint8_t &element : *currState) {
      if (element == MayHasGet) {
        element = MayHasGCCall;
      }
    }
    for (wasm::Expression *operand : expr->operands) {
      if (wasm::LocalGet *get = operand->dynCast<wasm::LocalGet>()) {
        callOperands_.insert(get);
      }
    }
  }
  void visitLocalGet(wasm::LocalGet *expr) {
    // set
    uint8_t &element = currState->at(lattice_.getIndex(expr));
    // treat parameter of non leaf function call as HasGCCall also.
    auto const it = callOperands_.find(expr);
    if (it != callOperands_.end()) {
      element = MayHasGCCall;
      callOperands_.erase(it);
      return;
    }
    if (element == InitialValue)
      element = MayHasGet;
  }
  void visitLocalSet(wasm::LocalSet *expr) {
    if (collectingResults) {
      if (all_of(lattice_.getIndexRange(expr), [this](size_t i) -> bool { return currState->at(i) != MayHasGCCall; })) {
        results_.insert(expr);
      }
    }
    // kill
    for (size_t i : lattice_.getIndexRange(expr))
      currState->at(i) = InitialValue;
  }
};

static std::set<wasm::LocalSet *> scanRemovableSet(wasm::Function *f, std::set<wasm::Name> const &leafFunctions_) {
  LocalsGetterTransferFn transfer{*f, leafFunctions_};
  wasm::analysis::CFG cfg = wasm::analysis::CFG::fromFunction(f);
  using Analyzer = wasm::analysis::MonotoneCFGAnalyzer<LocalsGetterLattice, LocalsGetterTransferFn>;
  Analyzer analyzer{transfer.lattice_, transfer, cfg};
  analyzer.evaluateAndCollectResults();
  return std::move(transfer.results_);
}

struct StoreCleaner : public wasm::PostWalker<StoreCleaner> {
  std::set<wasm::LocalSet *> const &target_;
  explicit StoreCleaner(std::set<wasm::LocalSet *> const &target) : target_{target} {}
  explicit StoreCleaner(std::set<wasm::LocalSet *> &&target) = delete;
  void visitStore(wasm::Store *expr) {
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
    std::set<wasm::LocalSet *> const target = scanRemovableSet(f, leafFunctions_);
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
using testing::Not;

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetBase) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_THAT(targets, Contains(body[0]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetCallLeaf) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_THAT(targets, Contains(body[0]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetCallNonLeaf) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_THAT(targets, Not(Contains(body[0]->cast<wasm::LocalSet>())));
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetCallAfterGet) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_THAT(targets, Contains(body[0]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetCallAsLeafParameters) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_THAT(targets, Contains(body[0]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetCallAsNonLeafParameters) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_THAT(targets, Not(Contains(body[0]->cast<wasm::LocalSet>())));
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalMultipleSet) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_THAT(targets, Not(Contains(body[0]->cast<wasm::LocalSet>())));
  EXPECT_THAT(targets, Contains(body[3]->cast<wasm::LocalSet>()));
  EXPECT_THAT(targets, Contains(body[5]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalMultipleLocal) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_THAT(targets, Not(Contains(body[0]->cast<wasm::LocalSet>())));
  EXPECT_THAT(targets, Contains(body[3]->cast<wasm::LocalSet>()));
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetCondition) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_EQ(targets.size(), 0);
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetCondition2) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_EQ(targets.size(), 1);
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetConditionGet) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_EQ(targets.size(), 1);
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetConditionMultipleGet) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_EQ(targets.size(), 0);
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetLoop) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_EQ(targets.size(), 1);
}

TEST(CleanDirectLocalUsesGC, ScanRemovableLocalSetLoop2) {
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
  std::set<wasm::LocalSet *> const targets = scanRemovableSet(f, leaf);
  EXPECT_EQ(targets.size(), 2);
}

} // namespace warpo::passes::ut

#endif
