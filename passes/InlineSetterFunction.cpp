/// @brief pass to inline AS default setter function
///
/// @details
/// most default setter functions are just store the parameter to memory pointed by another parameter
/// this pass will inline these functions
/// local.get $0
/// local.get $1
/// i32.store offset=x

#include <cassert>
#include <fmt/format.h>
#include <map>
#include <memory>

#include "InlineSetterFunction.hpp"
#include "Matcher.hpp"
#include "literal.h"
#include "pass.h"
#include "support/Debug.hpp"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

#define DEBUG_PREFIX "[InlineSetterFunction] "

namespace warpo::passes {

namespace {

using InlinableFunctionMap = std::map<wasm::Name, wasm::Function *>;
struct Scanner : public wasm::WalkerPass<wasm::PostWalker<Scanner>> {
  explicit Scanner(InlinableFunctionMap &setterFunction)
      : wasm::WalkerPass<wasm::PostWalker<Scanner>>{}, setterFunction_(setterFunction) {}
  bool modifiesBinaryenIR() override { return false; }
  void visitFunction(wasm::Function *func);

private:
  InlinableFunctionMap &setterFunction_;
};

void Scanner::visitFunction(wasm::Function *curr) {
  if (curr->body == nullptr)
    return;
  using namespace matcher;
  if (curr->getNumParams() != 2)
    return;
  auto const matcher = isStore(store::ptr(isLocalGet(local_get::index(0))), store::v(isLocalGet(local_get::index(1))));
  if (!matcher(*curr->body))
    return;
  bool success = setterFunction_.insert_or_assign(curr->name, curr).second;
  assert(success);
  if (support::isDebug())
    fmt::println(DEBUG_PREFIX "function '{}' can be inlined", curr->name.str);
}

struct Replacer : wasm::WalkerPass<wasm::PostWalker<Replacer>> {
  explicit Replacer(InlinableFunctionMap const &inlinableFunction)
      : wasm::WalkerPass<wasm::PostWalker<Replacer>>{}, inlinableFunction_(inlinableFunction) {}

  bool modifiesBinaryenIR() override { return true; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<Replacer>(inlinableFunction_); }

  void visitCall(wasm::Call *curr) {
    if (curr->target) {
    }
    InlinableFunctionMap::const_iterator it = inlinableFunction_.find(curr->target);
    if (it == inlinableFunction_.end()) {
      return;
    }

    wasm::Builder builder(*getModule());
    wasm::Store const *store = it->second->body->cast<wasm::Store>();
    assert(curr->operands.size() == 2);
    wasm::Expression *ptr = curr->operands[0];
    wasm::Expression *value = curr->operands[1];
    wasm::Store *replace =
        builder.makeStore(store->bytes, store->offset, store->align, ptr, value, store->valueType, store->memory);
    if (support::isDebug()) {
      fmt::println(DEBUG_PREFIX "replace 'call {}' with '{}.store offset={}'", curr->target.str,
                   replace->valueType.toString(), replace->offset.addr);
    }
    replaceCurrent(replace);
  }

private:
  InlinableFunctionMap const &inlinableFunction_;
};

void clean(wasm::Module *m, InlinableFunctionMap const &inlinableFunction) {
  if (support::isDebug())
    for (auto const &[name, _] : inlinableFunction)
      fmt::println(DEBUG_PREFIX "remove function '{}'", name.str);
  m->removeFunctions([&inlinableFunction](wasm::Function *f) -> bool { return inlinableFunction.contains(f->name); });
}

} // namespace

struct InlineSetterFunction : public wasm::Pass {
  void run(wasm::Module *m) override;
};

void InlineSetterFunction::run(wasm::Module *m) {
  InlinableFunctionMap inlinableFunction{};
  Scanner scanner{inlinableFunction};
  scanner.run(getPassRunner(), m);
  if (support::isDebug())
    fmt::println(DEBUG_PREFIX "can be inlined functions count: {}", inlinableFunction.size());
  Replacer replacer{inlinableFunction};
  replacer.run(getPassRunner(), m);
  clean(m, inlinableFunction);
}

} // namespace warpo::passes

namespace warpo {

wasm::Pass *passes::createInlineSetterFunctionPass() { return new passes::InlineSetterFunction(); }

} // namespace warpo

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "pass.h"
#include "unittests/Helper.hpp"

namespace warpo::passes::ut {

TEST(InlineSetterFunctionTest, ScannerI32Store) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (func (param i32 i32)
          (i32.store offset=1
            (local.get 0)
            (local.get 1)
          )
        )
      )
    )");

  InlinableFunctionMap map{};
  Scanner scanner{map};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  EXPECT_EQ(map.size(), 1);
}

TEST(InlineSetterFunctionTest, ScannerF64Store) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (func (param i32 f64)
          (f64.store offset=1
            (local.get 0)
            (local.get 1)
          )
        )
      )
    )");

  InlinableFunctionMap map{};
  Scanner scanner{map};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  EXPECT_EQ(map.size(), 1);
}

TEST(InlineSetterFunctionTest, ScannerNotThreeArgs) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (func (param i32 i32 i32)
          (i32.store offset=1
            (local.get 0)
            (local.get 1)
          )
        )
      )
    )");

  InlinableFunctionMap map{};
  Scanner scanner{map};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  EXPECT_EQ(map.size(), 0);
}

TEST(InlineSetterFunctionTest, ScannerNotOneArgs) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (func (param i32) (local i32)
          (i32.store offset=1
            (local.get 0)
            (local.get 1)
          )
        )
      )
    )");

  InlinableFunctionMap map{};
  Scanner scanner{map};
  wasm::PassRunner runner{m.get()};
  scanner.run(&runner, m.get());

  EXPECT_EQ(map.size(), 0);
}

constexpr const char *replacedFunc = "replaced_func";
constexpr const char *targetFunc = "target_func";

TEST(InlineSetterFunctionTest, Replace) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (func $replaced_func (param i32) (param i32)
          (i32.store offset=3
            (local.get 0)
            (local.get 1)
          )
        )
        (func $target_func
          (call 0
            (i32.const 0)
            (i32.const 1)
          )
        )
      )
    )");

  InlinableFunctionMap const map{
      {replacedFunc, m->getFunction(replacedFunc)},
  };
  Replacer replacer{map};
  wasm::PassRunner runner{m.get()};
  replacer.run(&runner, m.get());
  wasm::Expression *expr = m->getFunction(targetFunc)->body;
  using namespace matcher;
  M<wasm::Expression> matcher =
      isStore(store::ptr(isConst(const_::v(wasm::Literal{static_cast<int32_t>(0)}))),
              store::v(isConst(const_::v(wasm::Literal{static_cast<int32_t>(1)}))), store::offset(3));
  EXPECT_MATCHER(matcher, expr);
}

TEST(InlineSetterFunctionTest, Pass) {
  auto m = loadWat(R"(
      (module
        (memory 1)
        (func (param i32) (param i32)
          (i32.store offset=3
            (local.get 0)
            (local.get 1)
          )
        )
        (func $target_func
          (call 0
            (i32.const 0)
            (i32.const 1)
          )
        )
      )
    )");
  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>(createInlineSetterFunctionPass()));
  runner.run();

  ASSERT_EQ(m->functions.size(), 1);
  ASSERT_EQ(m->functions[0]->name, wasm::Name{targetFunc});
  ASSERT_TRUE(m->functions[0]->body->is<wasm::Store>());
}

} // namespace warpo::passes::ut

#endif
