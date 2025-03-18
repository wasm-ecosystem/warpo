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
#include <fmt/format.h>
#include <memory>
#include <set>

#include "BuildGCModel.hpp"
#include "Cleaner.hpp"
#include "Matcher.hpp"
#include "RemoveDuplicateStoreLocalInGC.hpp"
#include "analysis/cfg.h"
#include "analysis/liveness-transfer-function.h"
#include "analysis/monotone-analyzer.h"
#include "fmt/base.h"
#include "support/Debug.hpp"
#include "wasm.h"

#define DEBUG_PREFIX "[RemoveDuplicateStoreLocalInGC] "

namespace warpo::passes::matcher {
M<wasm::Expression> const isStoreLocalToStackPointer = isStore(
    store::ptr(isGlobalGet(global_get::name(as_gc::stackPointerName))), store::v(isLocalGet().bind("local.get")));
};

namespace warpo::passes::as_gc {

namespace {

struct ShadowStackLivenessTransferFunction
    : public wasm::analysis::VisitorTransferFunc<ShadowStackLivenessTransferFunction,
                                                 wasm::analysis::FiniteIntPowersetLattice,
                                                 wasm::analysis::AnalysisDirection::Forward> {
  using Super =
      wasm::analysis::VisitorTransferFunc<ShadowStackLivenessTransferFunction, wasm::analysis::FiniteIntPowersetLattice,
                                          wasm::analysis::AnalysisDirection::Forward>;
  static constexpr bool MayNotInShadowStack = true;
  static constexpr bool MustInShadowStack = false; // join is OR

  std::set<wasm::Store *> storeCanBeRemoved_{};
  explicit ShadowStackLivenessTransferFunction() : Super{} {}

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
    assert(currState);
    if (support::isDebug())
      if (!collectingResults)
        fmt::println(DEBUG_PREFIX "kill local {}", expr->index);
    currState->set(expr->index, MayNotInShadowStack);
  }
  void visitStore(wasm::Store *expr) {
    assert(currState);
    matcher::Context ctx{};
    if (!matcher::isStoreLocalToStackPointer(*expr, ctx))
      return;
    auto const *localGet = ctx.getBinding<wasm::LocalGet>("local.get");
    assert(localGet != nullptr);
    if (support::isDebug())
      if (!collectingResults)
        fmt::println(DEBUG_PREFIX "local {} live in shadow shadow stack", localGet->index);
    if (collectingResults) {
      if (currState->get(localGet->index) == MustInShadowStack) {
        if (support::isDebug())
          fmt::println(DEBUG_PREFIX "store local {} ({}) to shadow stack when it is already in stack", localGet->index,
                       static_cast<void *>(expr));
        storeCanBeRemoved_.insert(expr);
      }
    }
    currState->set(localGet->index, MustInShadowStack);
  }
};

static std::set<wasm::Store *> findDuplicateStoreLocal(wasm::Function *f) {
  wasm::analysis::FiniteIntPowersetLattice lattice{f->getNumLocals()};
  wasm::analysis::CFG cfg = wasm::analysis::CFG::fromFunction(f);
  ShadowStackLivenessTransferFunction transfer{};

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
        (func $f (local i32 i32 i32 i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 3))
          (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (i32.add (local.get 0) (i32.const 4)))
        )
      )
    )");

  wasm::ExpressionList const &body = m->getFunction("f")->body->cast<wasm::Block>()->list;
  {
    matcher::Context ctx{};
    EXPECT_TRUE(matcher::isStoreLocalToStackPointer(*body[0], ctx));
    EXPECT_EQ(ctx.getBinding<wasm::LocalGet>("local.get")->index, 3);
  }
  {
    EXPECT_FALSE(matcher::isStoreLocalToStackPointer(*body[1]));
  }
}

TEST(RemoveDuplicateStoreLocalInGC, Pass) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 1))
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
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 1))
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

} // namespace warpo::passes::ut

#endif
