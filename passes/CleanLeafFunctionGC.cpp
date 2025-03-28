/// @brief clean GC operator in leaf functions

#include <cassert>
#include <fmt/base.h>
#include <memory>
#include <set>

#include "BuildGCModel.hpp"
#include "CleanLeafFunctionGC.hpp"
#include "CollectGCLeafFunction.hpp"
#include "Matcher.hpp"
#include "pass.h"
#include "support/Debug.hpp"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

#define DEBUG_PREFIX "[CleanLeafFunctionGC] "

namespace warpo::passes::as_gc {
namespace {

class LeafFunctionGCOperationVerifier : public wasm::PostWalker<LeafFunctionGCOperationVerifier> {
  std::set<wasm::GlobalGet const *> globalGets_{};
  bool hasInvalidGlobalSet_ = false;

public:
  bool ok() const { return !hasInvalidGlobalSet_ && globalGets_.empty(); }

  void visitGlobalGet(wasm::GlobalGet *expr) {
    if (!matcher::getSP(*expr))
      return;
    globalGets_.insert(expr);
  }
  void visitStore(wasm::Store *expr) {
    matcher::Context ctx{};
    if (!matcher::isGCStore(*expr, ctx))
      return;
    globalGets_.erase(ctx.getBinding<wasm::GlobalGet>("sp"));
  }
  void visitGlobalSet(wasm::GlobalSet *expr) {
    matcher::Context ctx{};
    if (!matcher::isGCUpdate(*expr, ctx)) {
      // we has strange global update
      hasInvalidGlobalSet_ |= expr->name == as_gc::stackPointerName;
      return;
    }
    globalGets_.erase(ctx.getBinding<wasm::GlobalGet>("sp"));
  }
  void visitMemoryFill(wasm::MemoryFill *expr) {
    matcher::Context ctx{};
    if (!matcher::isGCFill(*expr))
      return;
    globalGets_.erase(ctx.getBinding<wasm::GlobalGet>("sp"));
  }
  void visitCall(wasm::Call *expr) {
    matcher::Context ctx{};
    if (!matcher::isCallStackCheck(*expr))
      return;
    if (auto const *sp = ctx.getBinding<wasm::GlobalGet>("sp"); sp != nullptr)
      globalGets_.erase(sp);
  }
};

bool verifyLeafFunctionGCOperation(wasm::Function *func) {
  LeafFunctionGCOperationVerifier verifier{};
  verifier.walk(func->body);
  if (support::isDebug())
    if (!verifier.ok())
      fmt::print(DEBUG_PREFIX "invalid GC operation in '{}':\n", func->name.str);
  return verifier.ok();
}

struct LeafFunctionGCOperationCleaner : public wasm::WalkerPass<wasm::PostWalker<LeafFunctionGCOperationCleaner>> {
  std::set<wasm::Name> const &leafFunctions_;
  explicit LeafFunctionGCOperationCleaner(std::set<wasm::Name> const &leafFunctions) : leafFunctions_(leafFunctions) {
    name = "LeafFunctionGCOperationCleaner";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override {
    return std::make_unique<LeafFunctionGCOperationCleaner>(leafFunctions_);
  }
  bool modifiesBinaryenIR() override { return true; }

  void doWalkFunction(wasm::Function *func) {
    if (!leafFunctions_.contains(func->name))
      return;
    if (!verifyLeafFunctionGCOperation(func))
      return;
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "clean GC operation in leaf function '{}'", getFunction()->name.str);
    walk(func->body);
  }
  void visitStore(wasm::Store *expr) {
    if (!matcher::isGCStore(*expr))
      return;
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "remove GC store in '{}'", static_cast<void *>(expr));
    wasm::Builder builder{*getModule()};
    replaceCurrent(builder.makeDrop(expr->value));
  }
  void visitGlobalSet(wasm::GlobalSet *expr) {
    if (!matcher::isGCUpdate(*expr))
      return;
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "remove GC update SP in '{}'", static_cast<void *>(expr));
    wasm::Builder builder{*getModule()};
    replaceCurrent(builder.makeNop());
  }
  void visitMemoryFill(wasm::MemoryFill *expr) {
    if (!matcher::isGCFill(*expr))
      return;
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "remove GC fill in '{}'", static_cast<void *>(expr));
    wasm::Builder builder{*getModule()};
    replaceCurrent(builder.makeNop());
  }
  void visitCall(wasm::Call *expr) {
    if (!matcher::isCallStackCheck(*expr))
      return;
    if (support::isDebug())
      fmt::println(DEBUG_PREFIX "remove GC stack check in '{}'", getFunction()->name.str);
    wasm::Builder builder{*getModule()};
    replaceCurrent(builder.makeNop());
  }
};

struct CleanLeafFunctionGC : public wasm::Pass {
  CleanLeafFunctionGC() { name = "CleanLeafFunctionGC"; }
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
    runner.add(std::unique_ptr<wasm::Pass>{new LeafFunctionGCOperationCleaner(leafFunctions)});
    runner.run();
  }
};

} // namespace
} // namespace warpo::passes::as_gc

wasm::Pass *warpo::passes::as_gc::createCleanLeafFunctionGC() { return new CleanLeafFunctionGC(); }

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "Runner.hpp"
#include "unittests/Helper.hpp"

namespace warpo::passes::ut {

using namespace as_gc;

TEST(CleanLeafFunctionGCTest, LeafFunctionGCOperationVerifierStore) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (nop)
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  EXPECT_TRUE(verifyLeafFunctionGCOperation(f));
}

TEST(CleanLeafFunctionGCTest, LeafFunctionGCOperationVerifierSet) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (global.set $~lib/memory/__stack_pointer (i32.add (i32.const 4) (global.get $~lib/memory/__stack_pointer)))
          (nop)
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  EXPECT_TRUE(verifyLeafFunctionGCOperation(f));
}

TEST(CleanLeafFunctionGCTest, LeafFunctionGCOperationVerifierOther) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (local.set 0 (global.get $~lib/memory/__stack_pointer))
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  EXPECT_FALSE(verifyLeafFunctionGCOperation(f));
}

TEST(CleanLeafFunctionGCTest, LeafFunctionGCOperationCleaner) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32) (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (nop)
        )
      )
    )");
  wasm::Function *const f = m->getFunction("f");
  wasm::ExpressionList &body = f->body->cast<wasm::Block>()->list;
  std::vector<wasm::Expression *> const oldBody{body.begin(), body.end()};

  std::set<wasm::Name> leaf{"f"};
  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new LeafFunctionGCOperationCleaner(leaf)});
  runner.run();
  using namespace matcher;
  EXPECT_MATCHER(isDrop(drop::v(isLocalGet(local_get::index(0)))), body[0]);
}

} // namespace warpo::passes::ut

#endif
