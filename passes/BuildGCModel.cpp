/// @brief pass to recover GC model of AssemblyScript

#include <cassert>
#include <fmt/format.h>
#include <memory>
#include <set>
#include <vector>

#include "BuildGCModel.hpp"
#include "Matcher.hpp"
#include "support/Debug.hpp"
#include "wasm.h"

#define DEBUG_PREFIX "[BuildGcModel] "

namespace warpo::passes::as_gc {

namespace {

struct ShadowStackInfoScanner : public wasm::WalkerPass<wasm::PostWalker<ShadowStackInfoScanner>> {
  explicit ShadowStackInfoScanner(ShadowStackInfoMap &info, wasm::Name const &stackPointerName)
      : info_(info), stackPointerName_(stackPointerName) {}
  bool modifiesBinaryenIR() override { return false; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<ShadowStackInfoScanner>(info_, stackPointerName_); }

  void visitGlobalSet(wasm::GlobalSet *expr);
  void visitStore(wasm::Store *expr);
  // FIXME: memory.fill

private:
  ShadowStackInfoMap &info_;
  wasm::Name const &stackPointerName_;
};

void ShadowStackInfoScanner::visitGlobalSet(wasm::GlobalSet *expr) {
  wasm::Function *currentFunction = getFunction();
  if (currentFunction == nullptr)
    return;
  using namespace matcher;
  auto const match =
      isGlobalSet(global_set::name(stackPointerName_),
                  global_set::value(isBinary(binary::op({wasm::BinaryOp::AddInt32, wasm::BinaryOp::SubInt32}),
                                             binary::each(isConst().bind("const"),
                                                          isGlobalGet(global_get::name(stackPointerName_)).bind("get")))
                                        .bind("bop")));
  Context ctx{};
  if (!match(*expr, ctx))
    return;
  bool const isAdd = ctx.getBinding<wasm::Binary>("bop")->op == wasm::BinaryOp::AddInt32;
  int64_t const delta = ctx.getBinding<wasm::Const>("const")->value.getInteger() * (isAdd ? 1 : -1);
  if (support::isDebug())
    fmt::println(DEBUG_PREFIX "update stack_pointer {}", delta);
  info_.at(currentFunction->name).stackPointerUpdate_.push_back({.size_ = delta});
}

void ShadowStackInfoScanner::visitStore(wasm::Store *expr) {
  wasm::Function *currentFunction = getFunction();
  assert(currentFunction != nullptr);
  using namespace matcher;
  auto const globalGet = isGlobalGet(global_get::name(stackPointerName_)).bind("get");
  auto const match = isStore(store::ptr(globalGet));
  Context ctx{};
  if (!match(*expr, ctx))
    return;
  if (support::isDebug()) {
    uint64_t address = expr->offset.addr;
    wasm::Expression *value = expr->value;
    if (auto *e = value->dynCast<wasm::Const>()) {
      fmt::println(DEBUG_PREFIX "store object {} in {}", e->value.getInteger(), address);
      if (e->value.type == wasm::Type::i64) {
        fmt::println(DEBUG_PREFIX "store object {} in {}", e->value.getInteger(), address + 4U);
      }
    } else if (auto *e = value->dynCast<wasm::LocalGet>()) {
      fmt::println(DEBUG_PREFIX "store object local.get {} in {}", e->index, address);
    } else {
      fmt::println(DEBUG_PREFIX "store object {} in {}", (void *)value, address);
    }
  }
  info_.at(currentFunction->name).storeToShadownStack_.insert(expr);
}

} // namespace

ShadowStackInfoMap BuildGCModel::createShadowStackInfoMap(wasm::Module const &m) {
  ShadowStackInfoMap map{};
  for (std::unique_ptr<wasm::Function> const &fn : m.functions) {
    bool const success = map.insert_or_assign(fn->name, ShadowStackInfo{}).second;
    assert(success);
  }
  return map;
}

void BuildGCModel::runOnFunction(wasm::Module *m, wasm::Function *f) {
  if (m->getGlobalOrNull(stackPointerName) == nullptr)
    return;
  ShadowStackInfoScanner scanner{infoMap_, stackPointerName};
  scanner.setPassRunner(getPassRunner());
  scanner.runOnFunction(m, f);
}

} // namespace warpo::passes::as_gc

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "pass.h"
#include "unittests/Helper.hpp"

namespace warpo::passes::ut {
using namespace as_gc;

TEST(BuildGCModelTest, ScannerStackPointerUpdate) {
  auto m = loadWat(R"(
      (module
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f
          (global.set $~lib/memory/__stack_pointer (i32.sub (global.get $~lib/memory/__stack_pointer) (i32.const 4)))
          (global.set $~lib/memory/__stack_pointer (i32.add (global.get $~lib/memory/__stack_pointer) (i32.const 8)))
          (global.set $~lib/memory/__stack_pointer (i32.sub (global.get $~lib/memory/__stack_pointer) (i32.const -12)))
        )
      )
    )");

  ShadowStackInfoMap map = BuildGCModel::createShadowStackInfoMap(*m);
  ShadowStackInfoScanner scanner{map, m->globals.at(0)->name};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  auto const &stackPointerUpdate = map.at("f").stackPointerUpdate_;

  EXPECT_EQ(stackPointerUpdate.size(), 3);
  EXPECT_EQ(stackPointerUpdate.at(0).size_, -4);
  EXPECT_EQ(stackPointerUpdate.at(1).size_, 8);
  EXPECT_EQ(stackPointerUpdate.at(2).size_, 12);
}

TEST(BuildGCModelTest, ScannerStoreToShadowStack) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $~lib/memory/__stack_pointer (mut i32) (i32.const 0))
        (func $f (local i32)
          (i32.store offset=0 (global.get $~lib/memory/__stack_pointer) (local.get 0))
          (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (i32.add (local.get 0) (i32.const 4)))
        )
      )
    )");

  ShadowStackInfoMap map = BuildGCModel::createShadowStackInfoMap(*m);
  ShadowStackInfoScanner scanner{map, m->globals.at(0)->name};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  auto const &storeToShadownStack = map.at("f").storeToShadownStack_;
  wasm::ExpressionList const &body = m->getFunction("f")->body->cast<wasm::Block>()->list;
  EXPECT_EQ(storeToShadownStack.size(), 2);
  EXPECT_TRUE(storeToShadownStack.contains(body[0]->cast<wasm::Store>()));
  EXPECT_TRUE(storeToShadownStack.contains(body[1]->cast<wasm::Store>()));
}

TEST(BuildGCModelTest, NoStackPointer) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (global $a (mut i32) (i32.const 0))
        (func $f (local i32)
        )
      )
    )");

  ShadowStackInfoMap map = BuildGCModel::createShadowStackInfoMap(*m);
  ShadowStackInfoScanner scanner{map, m->globals.at(0)->name};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  auto const &storeToShadownStack = map.at("f").storeToShadownStack_;
  EXPECT_EQ(storeToShadownStack.size(), 0);
}

} // namespace warpo::passes::ut

#endif
