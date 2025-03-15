/// @brief pass to recover GC model of AssemblyScript

#include <cassert>
#include <fmt/format.h>
#include <memory>
#include <set>

#include "BuildGCModel.hpp"
#include "RemoveDuplicateStoreLocalInGC.hpp"
#include "analysis/cfg.h"
#include "analysis/liveness-transfer-function.h"
#include "analysis/monotone-analyzer.h"
#include "fmt/base.h"
#include "support/Debug.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

#define DEBUG_PREFIX "[RemoveDuplicateStoreLocalInGC] "

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

  ShadowStackInfo const &info_;
  std::set<wasm::Store *> storeCanBeRemoved_{};
  explicit ShadowStackLivenessTransferFunction(ShadowStackInfo const &info) : Super{}, info_(info) {}

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
    if (!info_.storeToShadownStack_.contains(expr))
      return;
    auto const *localGet = expr->value->dynCast<wasm::LocalGet>();
    if (localGet == nullptr)
      return;
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

class RemoveDuplicateStoreLocalInGCImpl : public wasm::Pass {
  ShadowStackInfoMap const &info_;

public:
  explicit RemoveDuplicateStoreLocalInGCImpl(ShadowStackInfoMap const &info) : info_(info) {}
  std::unique_ptr<Pass> create() override { return std::make_unique<RemoveDuplicateStoreLocalInGCImpl>(info_); }
  bool isFunctionParallel() override { return true; }
  void runOnFunction(wasm::Module *m, wasm::Function *f) override;
};

static std::set<wasm::Store *> findDuplicateStoreLocal(ShadowStackInfo const &info, wasm::Function *f) {
  wasm::analysis::FiniteIntPowersetLattice lattice{f->getNumLocals()};
  wasm::analysis::CFG cfg = wasm::analysis::CFG::fromFunction(f);
  ShadowStackLivenessTransferFunction transfer{info};

  using Analyzer = wasm::analysis::MonotoneCFGAnalyzer<wasm::analysis::FiniteIntPowersetLattice,
                                                       ShadowStackLivenessTransferFunction>;
  Analyzer analyzer{lattice, transfer, cfg};
  analyzer.evaluateFunctionEntry(f);
  analyzer.evaluateAndCollectResults();
  return transfer.storeCanBeRemoved_;
}

struct Cleaner : public wasm::WalkerPass<wasm::PostWalker<Cleaner>> {
  std::set<wasm::Store *> storeCanBeRemoved_;
  explicit Cleaner(std::set<wasm::Store *> const &storeCanBeRemoved) : storeCanBeRemoved_(storeCanBeRemoved) {}
  void visitStore(wasm::Store *expr) {
    if (storeCanBeRemoved_.contains(expr)) {
      if (support::isDebug())
        fmt::println(DEBUG_PREFIX "remove store ({}) to shadow stack", static_cast<void *>(expr));
      wasm::Builder builder{*getModule()};
      replaceCurrent(builder.makeNop());
    }
  }
};

void RemoveDuplicateStoreLocalInGCImpl::runOnFunction(wasm::Module *m, wasm::Function *f) {
  if (f->imported())
    return;
  ShadowStackInfo const &info = info_.at(f->name);
  if (info.storeToShadownStack_.empty())
    return;
  std::set<wasm::Store *> const duplicateStoreLocal = findDuplicateStoreLocal(info, f);
  Cleaner cleaner{duplicateStoreLocal};
  cleaner.setPassRunner(getPassRunner());
  cleaner.runOnFunction(m, f);
}

} // namespace

struct RemoveDuplicateStoreLocalInGC : public wasm::Pass {
  void runOnFunction(wasm::Module *m, wasm::Function *f) override;
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<RemoveDuplicateStoreLocalInGC>(); }
};

void RemoveDuplicateStoreLocalInGC::runOnFunction(wasm::Module *m, wasm::Function *f) {
  auto infoMap = BuildGCModel::createShadowStackInfoMap(*m);
  BuildGCModel buildGCModel{infoMap};
  RemoveDuplicateStoreLocalInGCImpl removeDuplicateStoreLocalInGC{infoMap};
  buildGCModel.setPassRunner(getPassRunner());
  removeDuplicateStoreLocalInGC.setPassRunner(getPassRunner());
  buildGCModel.runOnFunction(m, f);
  removeDuplicateStoreLocalInGC.runOnFunction(m, f);
}

} // namespace warpo::passes::as_gc

wasm::Pass *warpo::passes::as_gc::createRemoveDuplicateStoreLocalInGCPass() {
  return new RemoveDuplicateStoreLocalInGC();
}

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "Runner.hpp"
#include "pass.h"

namespace warpo::passes::ut {
using namespace as_gc;

TEST(RemoveDuplicateStoreLocalInGC, Clean) {
  auto m = loadWat(R"(
    (module
      (memory 1)
      (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
      (func $f (local i32) (local i32)
        (nop)
        (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
        (nop)
      )
    )
  )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList const &body = f->body->cast<wasm::Block>()->list;

  std::set<wasm::Store *> const duplicate{
      body[1]->cast<wasm::Store>(),
  };
  wasm::Expression *const e0 = body[0];
  wasm::Expression *const e2 = body[2];
  Cleaner cleaner{duplicate};
  wasm::PassRunner runner{m.get()};
  cleaner.setPassRunner(&runner);
  cleaner.runOnFunction(m.get(), f);

  EXPECT_EQ(body.size(), 3);
  EXPECT_EQ(body[0], e0);
  EXPECT_TRUE(body[1]->is<wasm::Nop>()); // removed as NOP
  EXPECT_EQ(body[2], e2);
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

  auto infoMap = BuildGCModel::createShadowStackInfoMap(*m);
  BuildGCModel buildGCModel{infoMap};
  wasm::PassRunner runner{m.get()};
  buildGCModel.setPassRunner(&runner);
  buildGCModel.runOnFunction(m.get(), f);
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(infoMap.at("f"), f);
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
  wasm::ExpressionList const &body = f->body->cast<wasm::Block>()->list;

  auto infoMap = BuildGCModel::createShadowStackInfoMap(*m);
  BuildGCModel buildGCModel{infoMap};
  wasm::PassRunner runner{m.get()};
  buildGCModel.setPassRunner(&runner);
  buildGCModel.runOnFunction(m.get(), f);
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(infoMap.at("f"), f);
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
  wasm::ExpressionList const &body = f->body->cast<wasm::Block>()->list;

  auto infoMap = BuildGCModel::createShadowStackInfoMap(*m);
  BuildGCModel buildGCModel{infoMap};
  wasm::PassRunner runner{m.get()};
  buildGCModel.setPassRunner(&runner);
  buildGCModel.runOnFunction(m.get(), f);
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(infoMap.at("f"), f);
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
  wasm::ExpressionList const &body = f->body->cast<wasm::Block>()->list;

  auto infoMap = BuildGCModel::createShadowStackInfoMap(*m);
  BuildGCModel buildGCModel{infoMap};
  wasm::PassRunner runner{m.get()};
  buildGCModel.setPassRunner(&runner);
  buildGCModel.runOnFunction(m.get(), f);
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(infoMap.at("f"), f);
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
  wasm::ExpressionList const &body = f->body->cast<wasm::Block>()->list;

  auto infoMap = BuildGCModel::createShadowStackInfoMap(*m);
  BuildGCModel buildGCModel{infoMap};
  wasm::PassRunner runner{m.get()};
  buildGCModel.setPassRunner(&runner);
  buildGCModel.runOnFunction(m.get(), f);
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(infoMap.at("f"), f);
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
  wasm::ExpressionList const &body = f->body->cast<wasm::Block>()->list;

  auto infoMap = BuildGCModel::createShadowStackInfoMap(*m);
  BuildGCModel buildGCModel{infoMap};
  wasm::PassRunner runner{m.get()};
  buildGCModel.setPassRunner(&runner);
  buildGCModel.runOnFunction(m.get(), f);
  std::set<wasm::Store *> const duplicate = findDuplicateStoreLocal(infoMap.at("f"), f);
  EXPECT_EQ(duplicate.size(), 0);
}

} // namespace warpo::passes::ut

#endif
