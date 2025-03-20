#include "Cleaner.hpp"
#include "fmt/base.h"
#include "support/Debug.hpp"
#include "wasm-builder.h"
#include "wasm.h"

#define DEBUG_PREFIX "[Cleaner] "

namespace warpo::passes {

void Cleaner::visitExpression(wasm::Expression *expr) {
  if (!fn_(*expr))
    return;
  if (support::isDebug())
    fmt::println(DEBUG_PREFIX "remove {}", static_cast<void *>(expr));
  wasm::Builder builder{*getModule()};
  replaceCurrent(builder.makeNop());
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gmock/gmock.h>
#include <gtest/gtest.h>

#include "Runner.hpp"
#include "pass.h"

namespace warpo::passes::ut {

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
  Cleaner cleaner{
      [&duplicate](wasm::Expression &expr) -> bool { return duplicate.contains(expr.dynCast<wasm::Store>()); }};
  wasm::PassRunner runner{m.get()};
  cleaner.setPassRunner(&runner);
  cleaner.runOnFunction(m.get(), f);

  EXPECT_EQ(body.size(), 3);
  EXPECT_EQ(body[0], e0);
  EXPECT_TRUE(body[1]->is<wasm::Nop>()); // removed as NOP
  EXPECT_EQ(body[2], e2);
}

} // namespace warpo::passes::ut

#endif