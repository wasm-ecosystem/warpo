/// @brief remove the duplicated (i32.store (global.get offset={} $~lib/memory/__stack_pointer) (local.get {}))
///
/// @details
/// AS need to store object pointer in ShadowStack. Then during GC, runtime can know which object is still used by
/// local.
/// If this local is already stored in ShadowStack, if yes, then we don't need to store it again.
/// It is "forward" "must analyzer".
/// Lattice is used to track the liveness of local in ShadowStack. The bottom is 0b000...000, which means all locals are
/// in ShadowStack. The join operator is OR.
/// The transfer function is:
///  - local.set kill the local in ShadowStack
///  - i32.store (global.get $~lib/memory/__stack_pointer) (local.get {}) set the local in ShadowStack
///  - other instructions don't change the liveness of local in ShadowStack

#include <cassert>
#include <cstdint>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fmt/ranges.h>
#include <map>
#include <memory>
#include <optional>
#include <set>
#include <utility>

#include "BuildCFG.hpp"
#include "BuildGCModel.hpp"
#include "Cleaner.hpp"
#include "Matcher.hpp"
#include "RemoveDuplicateStoreLocalInGC.hpp"
#include "analysis/cfg.h"
#include "analysis/liveness-transfer-function.h"
#include "analysis/monotone-analyzer.h"
#include "support/Container.hpp"
#include "support/Debug.hpp"
#include "support/Err.hpp"
#include "support/index.h"
#include "wasm.h"

#define DEBUG_PREFIX "[RemoveDuplicateStoreLocalInGC] "

namespace warpo::passes::matcher {
M<wasm::Expression> const isStoreLocalToStackPointer =
    isStore(store::ptr(getSP), store::v(anyOf({isLocalGet().bind("get"), isLocalSet(local_set::tee()).bind("tee")})));
};

namespace warpo::passes::as_gc {
namespace {

/// @return nullopt when meeting invalid function
Result<std::optional<int64_t>> getBlockStartOffset(wasm::Function *const f, BasicBlock const &block,
                                                   std::map<BasicBlock const *, int64_t> const &blockEndOffset) {
  if (block.preds().empty()) {
    return succeed(std::optional<int64_t>{0U});
  }
  std::optional<int64_t> offset = std::nullopt;
  for (BasicBlock const *pred : block.preds()) {
    if (blockEndOffset.contains(pred)) {
      int64_t const &predOffset = blockEndOffset.at(pred);
      if (offset.has_value()) {
        if (offset.value() != predOffset) {
          fmt::println(DEBUG_PREFIX "skipped because SP not same ({} vs {}) in pred basic block '{}'", offset.value(),
                       predOffset, f->name.str);
          if (support::isDebug())
            fmt::println(DEBUG_PREFIX "skipped because SP not same ({} vs {}) in pred basic block '{}'", offset.value(),
                         predOffset, f->name.str);
          return failed();
        }
      } else {
        offset = predOffset;
      }
    }
  }
  return succeed(offset);
}

bool hasUnresolvedPreds(BasicBlock const &block, std::map<BasicBlock const *, int64_t> const &blockEndOffset) {
  return any_of(block.preds(),
                [&blockEndOffset](BasicBlock const *pred) -> bool { return !blockEndOffset.contains(pred); });
}

struct StoreToSpOffset : private std::map<wasm::Store *, int64_t> {
  using std::map<wasm::Store *, int64_t>::insert_or_assign;

  template <class Fn> void forEach(Fn &&fn) const {
    for (auto const &[store, offset] : *this) {
      std::forward<Fn>(fn)(store, offset + store->offset.addr);
    }
  }

  std::optional<int64_t> getSpOffset(wasm::Store *store) const {
    auto it = this->find(store);
    if (it == this->end())
      return std::nullopt;
    return it->second + store->offset.addr;
  }
};

/// @brief get mapping of store to current SP position
std::optional<StoreToSpOffset> getStoreToCurrentSPOffset(wasm::Function *f) {
  bool finished = false;
  StoreToSpOffset ret{};
  std::map<BasicBlock const *, int64_t> blockEndOffset{};
  CFG cfg = CFG::fromFunction(f);
  while (!finished) {
    finished = true;
    for (BasicBlock const &block : cfg) {
      if (hasUnresolvedPreds(block, blockEndOffset))
        finished = false;
      Result<std::optional<int64_t>> offset = getBlockStartOffset(f, block, blockEndOffset);
      if (offset.nok())
        return std::nullopt;
      // no available pred basic block
      if (!offset.value().has_value())
        continue;

      int64_t currentOffset = offset.value().value();
      for (wasm::Expression *expr : block) {
        matcher::Context ctx{};
        if (matcher::isGCUpdate(*expr, ctx)) {
          int64_t v = ctx.getBinding<wasm::Const>("value")->value.getInteger();
          if (ctx.getBinding<wasm::Binary>("op")->op == wasm::BinaryOp::SubInt32)
            v = -v;
          currentOffset += v;
        } else {
          if (auto *set = expr->dynCast<wasm::GlobalSet>()) {
            // unknown global.set SP
            if (set->name == stackPointerName) {
              if (support::isDebug())
                fmt::println(DEBUG_PREFIX "skipped because set SP by unknown way in '{}'", f->name.str);
              return std::nullopt;
            }
          }
        }
        if (matcher::isStoreLocalToStackPointer(*expr, ctx)) {
          ret.insert_or_assign(expr->cast<wasm::Store>(), currentOffset);
        }
      }
      blockEndOffset.insert_or_assign(&block, currentOffset);
    }
  }
  return ret;
}

/// @brief get mapping of SP offset to local index
std::map<int64_t, wasm::Index> getSpOffsetToIndex(StoreToSpOffset const &storeSpOffset) {
  std::map<int64_t, wasm::Index> ret{};
  std::set<int64_t> blackLists{};
  storeSpOffset.forEach([&](wasm::Store *store, int64_t offset) -> void {
    if (blackLists.contains(offset))
      return;
    matcher::Context ctx{};
    if (!matcher::isStoreLocalToStackPointer(*store, ctx))
      assert(false);
    auto *localGet = ctx.getBinding<wasm::LocalGet>("get");
    auto *localTee = ctx.getBinding<wasm::LocalSet>("tee");
    assert(localGet != nullptr || localTee != nullptr);
    wasm::Index const localIndex = localGet != nullptr ? localGet->index : localTee->index;
    auto it = ret.find(offset);
    if (it == ret.end()) {
      ret.insert_or_assign(offset, localIndex);
      return;
    }
    if (it->second != localIndex) {
      if (support::isDebug())
        fmt::println(DEBUG_PREFIX "skip offset={} which mapped to multiple local ({} and {})", offset, it->second,
                     localIndex);
      blackLists.insert(offset);
      ret.erase(it);
    }
  });
  return ret;
};

class ShadowStackLivenessTransferFunction
    : public wasm::analysis::VisitorTransferFunc<ShadowStackLivenessTransferFunction,
                                                 wasm::analysis::FiniteIntPowersetLattice,
                                                 wasm::analysis::AnalysisDirection::Forward> {
  static constexpr bool MayNotInShadowStack = true;
  static constexpr bool MustInShadowStack = false; // join is OR

  StoreToSpOffset storeToSpOffset_{};
  std::map<int64_t, wasm::Index> spOffsetToIndex_{};

  std::optional<wasm::Index> getLocalIndexOfStoreToExclusiveSpOffset(wasm::Store *store) {
    auto const address = storeToSpOffset_.getSpOffset(store);
    if (!address.has_value())
      return std::nullopt;
    auto const indexIt = spOffsetToIndex_.find(address.value());
    if (indexIt == spOffsetToIndex_.end())
      return std::nullopt;
    return indexIt->second;
  }

public:
  std::set<wasm::Store *> storeCanBeRemoved_{};
  explicit ShadowStackLivenessTransferFunction(wasm::Function &f) {
    std::optional<StoreToSpOffset> storeToSpOffset = getStoreToCurrentSPOffset(&f);
    if (!storeToSpOffset.has_value())
      return;
    storeToSpOffset_ = std::move(storeToSpOffset.value());
    spOffsetToIndex_ = getSpOffsetToIndex(storeToSpOffset_);
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "participated locals in {}: [{}]", f.getNumLocals(), fmt::join(spOffsetToIndex_, ", "));
  }

  void evaluateFunctionEntry(wasm::Function *func, wasm::analysis::FiniteIntPowersetLattice::Element &element) {
    size_t numParams = func->getNumParams();
    if (support::isDebug())
      if (numParams > 0)
        fmt::println(DEBUG_PREFIX "param 0 ~ {} live in shadow stack", numParams - 1);
    for (size_t i = 0; i < numParams; i++) {
      element.set(i, MustInShadowStack);
    }
    for (size_t i = numParams; i < func->getNumLocals(); i++) {
      element.set(i, MayNotInShadowStack);
    }
  }
  void visitLocalSet(wasm::LocalSet *expr) {
    if (support::isDebug())
      if (!collectingResults)
        fmt::println(DEBUG_PREFIX "kill local {}", expr->index);
    currState->set(expr->index, MayNotInShadowStack);
  }
  bool mustInShadowStack(wasm::Expression const *value) {
    return value->is<wasm::LocalGet>() && currState->get(value->cast<wasm::LocalGet>()->index) == MustInShadowStack;
  }
  void visitStore(wasm::Store *expr) {
    std::optional<wasm::Index> const localIndexOpt = getLocalIndexOfStoreToExclusiveSpOffset(expr);
    if (!localIndexOpt.has_value())
      return;
    wasm::Index const localIndex = localIndexOpt.value();
    if (support::isDebug())
      if (!collectingResults)
        fmt::println(DEBUG_PREFIX "local {} live in shadow shadow stack", localIndex);
    if (collectingResults && mustInShadowStack(expr->value)) {
      if (support::isDebug())
        fmt::println(DEBUG_PREFIX "store local {} ({}) to shadow stack when it is already in stack", localIndex,
                     static_cast<void *>(expr));
      storeCanBeRemoved_.insert(expr);
    }
    currState->set(localIndex, MustInShadowStack);
  }
};

static std::set<wasm::Store *> findDuplicateStoreLocal(wasm::Function *f) {
  wasm::analysis::FiniteIntPowersetLattice lattice{f->getNumLocals()};
  wasm::analysis::CFG cfg = wasm::analysis::CFG::fromFunction(f);
  ShadowStackLivenessTransferFunction transfer{*f};

  using Analyzer = wasm::analysis::MonotoneCFGAnalyzer<wasm::analysis::FiniteIntPowersetLattice,
                                                       ShadowStackLivenessTransferFunction>;
  Analyzer analyzer{lattice, transfer, cfg};
  analyzer.evaluateFunctionEntry(f);
  analyzer.evaluateAndCollectResults();
  return transfer.storeCanBeRemoved_;
}

} // namespace

struct RemoveDuplicateStoreLocalInGC : public wasm::Pass {
  void runOnFunction(wasm::Module *m, wasm::Function *f) override;
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<RemoveDuplicateStoreLocalInGC>(); }
};

void RemoveDuplicateStoreLocalInGC::runOnFunction(wasm::Module *m, wasm::Function *f) {
  if (m->getGlobalOrNull(stackPointerName) == nullptr) {
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "skipped because symbol '{}' cannot be found", stackPointerName);
    return;
  }
  if (support::isDebug())
    fmt::println(DEBUG_PREFIX "finding duplicate store local in function '{}'", f->name.str);
  std::set<wasm::Store *> const duplicateStoreLocal = findDuplicateStoreLocal(f);
  Cleaner cleaner{[&duplicateStoreLocal](wasm::Expression &expr) -> bool {
    return duplicateStoreLocal.contains(expr.dynCast<wasm::Store>());
  }};
  cleaner.setPassRunner(getPassRunner());
  cleaner.runOnFunction(m, f);
}

} // namespace warpo::passes::as_gc

wasm::Pass *warpo::passes::as_gc::createRemoveDuplicateStoreLocalInGCPass() {
  return new RemoveDuplicateStoreLocalInGC();
}

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "Matcher.hpp"
#include "Runner.hpp"
#include "pass.h"
#include "unittests/Helper.hpp"

namespace warpo::passes::ut {
using namespace as_gc;

TEST(RemoveDuplicateStoreLocalInGC, MatchStoreToShadowStack) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $expected (local i32 i32 i32 i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 3))
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.tee 3 (i32.const 0x20)))
        )
        (func $unexpected (local i32 i32 i32 i32)
          (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (i32.add (local.get 0) (i32.const 4)))
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (global.get $~lib/memory/__stack_pointer))
        )
      )
    )");

  wasm::ExpressionList const &expected = m->getFunction("expected")->body->cast<wasm::Block>()->list;
  {
    matcher::Context ctx{};
    EXPECT_TRUE(matcher::isStoreLocalToStackPointer(*expected[0], ctx));
    auto get = ctx.getBinding<wasm::LocalGet>("get");
    ASSERT_NE(get, nullptr);
    EXPECT_EQ(get->index, 3);
  }
  {
    matcher::Context ctx{};
    EXPECT_TRUE(matcher::isStoreLocalToStackPointer(*expected[1], ctx));
    auto tee = ctx.getBinding<wasm::LocalSet>("tee");
    ASSERT_NE(tee, nullptr);
    EXPECT_EQ(tee->index, 3);
    EXPECT_TRUE(tee->isTee());
  }
  wasm::ExpressionList const &unexpected = m->getFunction("unexpected")->body->cast<wasm::Block>()->list;
  {
    EXPECT_FALSE(matcher::isStoreLocalToStackPointer(*unexpected[0]));
    EXPECT_FALSE(matcher::isStoreLocalToStackPointer(*unexpected[1]));
  }
}

TEST(RemoveDuplicateStoreLocalInGC, Pass) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (local.get 1))
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;
  std::vector<wasm::Expression *> const oldBody{body.begin(), body.end()};

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{createRemoveDuplicateStoreLocalInGCPass()});
  runner.run();
  EXPECT_EQ(oldBody[0], body[0]);
  EXPECT_EQ(oldBody[1], body[1]);
  EXPECT_NE(oldBody[2], body[2]);
  using namespace matcher;
  EXPECT_MATCHER(isNop(), body[2]);
}

TEST(RemoveDuplicateStoreLocalInGC, FindDuplicateStoreLocalBase) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (local.get 1))
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList const &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(f);
  EXPECT_EQ(duplicate.size(), 1);
  EXPECT_THAT(duplicate, testing::Contains(body[2]->cast<wasm::Store>()));
}

TEST(RemoveDuplicateStoreLocalInGC, FindDuplicateStoreLocalTee) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.tee 0 (i32.const 4)))
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList const &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(f);
  EXPECT_EQ(duplicate.size(), 1);
  EXPECT_THAT(duplicate, testing::Contains(body[1]->cast<wasm::Store>()));
}

TEST(RemoveDuplicateStoreLocalInGC, FindDuplicateStoreLocalKill) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (local.set 0 (i32.const 4))
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(f);
  EXPECT_EQ(duplicate.size(), 0);
}

TEST(RemoveDuplicateStoreLocalInGC, FindDuplicateStoreLocalKillByTee) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (drop (local.tee 0 (i32.const 4)))
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(f);
  EXPECT_EQ(duplicate.size(), 0);
}

TEST(RemoveDuplicateStoreLocalInGC, FindDuplicateStoreLocalWithIf) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (if (local.get 0)
            (then
              (local.set 0 (i32.const 4))
            )
            (else
              (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 1))
            )
          )
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 1))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(f);
  EXPECT_EQ(duplicate.size(), 0);
}

TEST(RemoveDuplicateStoreLocalInGC, FindDuplicateStoreLocalWithIf2) {
  auto m = loadWat(R"(
    (module
      (memory 1)
      (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
      (func $f (local i32) (local i32)
        (if (local.get 0)
          (then
            (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 1))
          )
          (else
            (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 1))
          )
        )
        (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 1))
      )
    )
  )");
  wasm::Function *const f = m->getFunction("f");
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(f);
  EXPECT_EQ(duplicate.size(), 1);
}

TEST(RemoveDuplicateStoreLocalInGC, FindDuplicateStoreLocalWithLoop) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (loop
            (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0)) ;; killed by local.set in next line
            (local.set 0 (i32.const 4))
            (br_if 0 (local.get 0))
          )
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(f);
  EXPECT_EQ(duplicate.size(), 0);
}

TEST(RemoveDuplicateStoreLocalInGC, GetStoreToCurrentSPOffset) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (global.set $~lib/memory/__stack_pointer (i32.sub (i32.const 20) (global.get $~lib/memory/__stack_pointer)))
          ;; outBody[1]
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          ;; outBody[2]
          (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (local.get 1))
          (block
            (global.set $~lib/memory/__stack_pointer (i32.sub (i32.const 20) (global.get $~lib/memory/__stack_pointer)))
            ;; inBody[1]
            (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
            ;; inBody[2]
            (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (local.get 1))
            (global.set $~lib/memory/__stack_pointer (i32.add (i32.const 20) (global.get $~lib/memory/__stack_pointer)))
          )
          ;; outBody[4]
          (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          ;; outBody[5]
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 1))
          (global.set $~lib/memory/__stack_pointer (i32.add (i32.const 20) (global.get $~lib/memory/__stack_pointer)))
        )
      )
    )");

  wasm::Function *const f = m->getFunction("f");
  auto out = getStoreToCurrentSPOffset(f);
  ASSERT_TRUE(out.has_value());
  auto const &storeToSpOffset = out.value();
  wasm::ExpressionList &outBody = f->body->cast<wasm::Block>()->list;
  wasm::ExpressionList &inBody = outBody[3]->cast<wasm::Block>()->list;

  EXPECT_EQ(storeToSpOffset.getSpOffset(outBody[1]->cast<wasm::Store>()), -20);
  EXPECT_EQ(storeToSpOffset.getSpOffset(outBody[2]->cast<wasm::Store>()), -16);
  EXPECT_EQ(storeToSpOffset.getSpOffset(outBody[4]->cast<wasm::Store>()), -16);
  EXPECT_EQ(storeToSpOffset.getSpOffset(outBody[5]->cast<wasm::Store>()), -20);

  EXPECT_EQ(storeToSpOffset.getSpOffset(inBody[1]->cast<wasm::Store>()), -40);
  EXPECT_EQ(storeToSpOffset.getSpOffset(inBody[2]->cast<wasm::Store>()), -36);
}

TEST(RemoveDuplicateStoreLocalInGC, GetSpOffsetToIndex) {
  auto m = loadWat(R"(
    (module
      (memory 1)
      (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
      (func $f (local i32) (local i32)
        ;; outBody[1]
        (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
        ;; outBody[2]
        (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (local.get 1))
        ;; outBody[3]
        (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
      )
    )
  )");
  wasm::Function *const f = m->getFunction("f");
  auto out = getStoreToCurrentSPOffset(f);
  ASSERT_TRUE(out.has_value());
  auto const &storeToSpOffset = out.value();
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;

  auto spOffsetToIndex = getSpOffsetToIndex(storeToSpOffset);
  EXPECT_EQ(spOffsetToIndex[0], 0);
  EXPECT_EQ(spOffsetToIndex[4], 1);
}

} // namespace warpo::passes::ut

#endif
