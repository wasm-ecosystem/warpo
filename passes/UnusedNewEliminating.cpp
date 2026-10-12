// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <memory>
#include <string_view>
#include <vector>

#include "UnusedNewEliminating.hpp"
#include "pass.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {
namespace {

constexpr std::string_view CONSTRUCTOR_MARKER = "#constructor";
constexpr std::string_view OBJECT_CONSTRUCTOR = "~lib/object/Object#constructor";
constexpr std::string_view TMP_TO_STACK_FUNCTION = "~lib/rt/__tmptostack";
constexpr std::string_view LOCAL_TO_STACK_FUNCTION = "~lib/rt/__localtostack";
constexpr std::string_view ITCMS_NEW_FUNCTION = "~lib/rt/itcms/__new";
constexpr std::string_view TCMS_NEW_FUNCTION = "~lib/rt/tcms/__new";

bool isGcRootingFunction(wasm::Name const name) noexcept {
  std::string_view const value = name.view();
  return value == TMP_TO_STACK_FUNCTION || value == LOCAL_TO_STACK_FUNCTION;
}

wasm::Expression *unwrapGcRootingCall(wasm::Expression *expression) noexcept {
  wasm::Call *const call = expression->dynCast<wasm::Call>();
  if (call == nullptr || !isGcRootingFunction(call->target) || call->operands.size() != 1)
    return expression;
  return call->operands[0];
}

bool isRuntimeNew(wasm::Call const *const call) noexcept {
  if (call == nullptr || call->operands.empty() || call->operands.size() > 2)
    return false;
  std::string_view const target = call->target.view();
  if (target != ITCMS_NEW_FUNCTION && target != TCMS_NEW_FUNCTION)
    return false;

  for (wasm::Expression *const operand : call->operands)
    if (!operand->is<wasm::Const>())
      return false;
  return true;
}

bool isConstructorName(wasm::Name const name) noexcept {
  std::string_view const value = name.view();
  return value.size() >= CONSTRUCTOR_MARKER.size() &&
         value.substr(value.size() - CONSTRUCTOR_MARKER.size()) == CONSTRUCTOR_MARKER;
}

bool isLocalGet(wasm::Expression const *const expression, wasm::Index const index) noexcept {
  wasm::LocalGet const *const localGet = expression->dynCast<wasm::LocalGet>();
  return localGet != nullptr && localGet->index == index;
}

// Match this generated shape, where Base#constructor recursively matches the
// same pattern until Object#constructor:
//   (func $Derived#constructor (param i32) (result i32)
//     (local.set 0
//       (call $~lib/rt/__localtostack
//         (call $Base#constructor
//           (call $~lib/rt/__tmptostack (local.get 0)))))
//     (local.get 0))
// Object#constructor itself must reduce to (local.get 0).
bool isTrivialObjectConstructor(wasm::Module &module, wasm::Function *constructor) {
  if (constructor == nullptr || constructor->imported() || constructor->body == nullptr ||
      constructor->getParams().size() != 1 || constructor->getResults() != wasm::Type::i32)
    return false;

  if (constructor == module.getFunctionOrNull(OBJECT_CONSTRUCTOR)) {
    wasm::Expression *bodyExpression = constructor->body;
    wasm::Block const *const block = bodyExpression->dynCast<wasm::Block>();
    if (block != nullptr && block->list.size() == 1)
      bodyExpression = block->list[0];
    return isLocalGet(bodyExpression, 0);
  }

  wasm::Block const *const body = constructor->body->dynCast<wasm::Block>();
  if (body == nullptr || body->list.size() != 2 || !isLocalGet(body->list[1], 0))
    return false;

  wasm::LocalSet const *const localSet = body->list[0]->dynCast<wasm::LocalSet>();
  if (localSet == nullptr || localSet->index != 0 || localSet->isTee())
    return false;

  wasm::Call const *const localToStack = localSet->value->dynCast<wasm::Call>();
  if (localToStack == nullptr || localToStack->target != LOCAL_TO_STACK_FUNCTION || localToStack->operands.size() != 1)
    return false;

  wasm::Call const *const objectConstructor = localToStack->operands[0]->dynCast<wasm::Call>();
  if (objectConstructor == nullptr || !isConstructorName(objectConstructor->target) ||
      objectConstructor->operands.size() != 1)
    return false;

  wasm::Call const *const tmpToStack = objectConstructor->operands[0]->dynCast<wasm::Call>();
  if (tmpToStack == nullptr || tmpToStack->target != TMP_TO_STACK_FUNCTION || tmpToStack->operands.size() != 1 ||
      !isLocalGet(tmpToStack->operands[0], 0))
    return false;

  return isTrivialObjectConstructor(module, module.getFunctionOrNull(objectConstructor->target));
}

wasm::Call *getRemovableRuntimeNew(wasm::Expression *expression) noexcept {
  expression = unwrapGcRootingCall(expression);
  wasm::Call *const allocationCall = expression->dynCast<wasm::Call>();
  return isRuntimeNew(allocationCall) ? allocationCall : nullptr;
}

wasm::Call *getRemovableConstructorCall(wasm::Module &module, wasm::Expression *expression) noexcept {
  expression = unwrapGcRootingCall(expression);
  wasm::Call *const constructorCall = expression->dynCast<wasm::Call>();
  if (constructorCall == nullptr || !isConstructorName(constructorCall->target) || constructorCall->operands.empty())
    return nullptr;

  wasm::Function *const constructor = module.getFunctionOrNull(constructorCall->target);
  if (!isTrivialObjectConstructor(module, constructor))
    return nullptr;

  wasm::Expression *allocation = constructorCall->operands[0];
  wasm::Call *const rootingCall = allocation->dynCast<wasm::Call>();
  if (rootingCall == nullptr || rootingCall->target != TMP_TO_STACK_FUNCTION || rootingCall->operands.size() != 1)
    return nullptr;

  wasm::Call *const allocationCall = unwrapGcRootingCall(rootingCall->operands[0])->dynCast<wasm::Call>();
  return isRuntimeNew(allocationCall) ? constructorCall : nullptr;
}

class AllocationCallRemover : public wasm::PostWalker<AllocationCallRemover> {
public:
  explicit AllocationCallRemover(wasm::Module &module) noexcept : module_{module} {}

  void visitDrop(wasm::Drop *drop) { removeConstructorCall(drop->value); }

  size_t getRemovedCallCount() const noexcept { return removedCallCount_; }

private:
  // Remove these dropped allocation shapes:
  //   (drop (call $__new (i32.const 16)))
  //   (drop (call $Item#constructor
  //     (call $~lib/rt/__tmptostack
  //       (call $__new (i32.const 16)))))
  // The constructor form is removable only when its constructor chain merely
  // forwards the allocated object to Object#constructor.
  void removeConstructorCall(wasm::Expression *expression) {
    wasm::Builder builder{module_};
    if (getRemovableRuntimeNew(expression) != nullptr) {
      ++removedCallCount_;
      replaceCurrent(builder.makeNop());
    } else {
      wasm::Call *const call = getRemovableConstructorCall(module_, expression);
      if (call == nullptr)
        return;

      std::vector<wasm::Expression *> preservedOperands;
      preservedOperands.reserve(call->operands.size() - 1);
      for (wasm::Index i = 1; i < call->operands.size(); ++i)
        preservedOperands.push_back(builder.makeDrop(unwrapGcRootingCall(call->operands[i])));

      ++removedCallCount_;
      replaceCurrent(builder.makeBlock(preservedOperands));
    }
  }

  wasm::Module &module_;
  size_t removedCallCount_{0};
};

class UnusedNewEliminating : public wasm::Pass {
public:
  void run(wasm::Module *module) override {
    while (true) {
      bool modified = false;
      for (std::unique_ptr<wasm::Function> const &function : module->functions) {
        if (function->imported() || function->body == nullptr)
          continue;

        AllocationCallRemover remover{*module};
        remover.walkFunctionInModule(function.get(), module);
        if (remover.getRemovedCallCount() == 0)
          continue;

        modified = true;
      }
      if (!modified)
        return;

      wasm::PassRunner runner{getPassRunner()};
      runner.add("vacuum");
      runner.run();
    }
  }
};

} // namespace

wasm::Pass *createUnusedNewEliminatingPass() { return new UnusedNewEliminating(); }

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"

namespace warpo::passes::ut {
namespace {

void runUnusedNewEliminating(wasm::Module &module) {
  wasm::PassRunner runner{&module};
  runner.add(std::unique_ptr<wasm::Pass>{createUnusedNewEliminatingPass()});
  runner.add("vacuum");
  runner.run();
}

TEST(UnusedNewEliminatingTest, RemovesUnusedAllocationAndConstructor) {
  std::unique_ptr<wasm::Module> module = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack"
        (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (import "as-builtin-fn" "~lib/rt/__localtostack"
        (func $~lib/rt/__localtostack (param i32) (result i32)))
      (import "rt" "new" (func $~lib/rt/itcms/__new (param i32) (result i32)))
      (func $~lib/object/Object#constructor (param i32) (result i32)
        (local.get 0)
      )
      (func $Base#constructor (param i32) (result i32)
        (local.set 0
          (call $~lib/rt/__localtostack
            (call $~lib/object/Object#constructor
              (call $~lib/rt/__tmptostack (local.get 0))
            )
          )
        )
        (local.get 0)
      )
      (func $Item#constructor (param i32) (result i32)
        (local.set 0
          (call $~lib/rt/__localtostack
            (call $Base#constructor
              (call $~lib/rt/__tmptostack (local.get 0))
            )
          )
        )
        (local.get 0)
      )
      (func $entry
        (drop
          (call $Item#constructor
            (call $~lib/rt/__tmptostack
              (call $~lib/rt/itcms/__new (i32.const 16))
            )
          )
        )
        (drop
          (call $~lib/rt/itcms/__new (i32.const 16))
        )
      )
    )
  )");

  runUnusedNewEliminating(*module);

  EXPECT_TRUE(module->getFunction("entry")->body->is<wasm::Nop>());
}

TEST(UnusedNewEliminatingTest, ReachesFixedPointFromCalleesToCallers) {
  std::unique_ptr<wasm::Module> module = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack"
        (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (import "as-builtin-fn" "~lib/rt/__localtostack"
        (func $~lib/rt/__localtostack (param i32) (result i32)))
      (import "rt" "new" (func $~lib/rt/itcms/__new (param i32 i32) (result i32)))
      (func $~lib/object/Object#constructor (param i32) (result i32)
        (local.get 0)
      )
      (func $Leaf#constructor (param i32) (result i32)
        (local.set 0
          (call $~lib/rt/__localtostack
            (call $~lib/object/Object#constructor
              (call $~lib/rt/__tmptostack (local.get 0))
            )
          )
        )
        (local.get 0)
      )
      (func $Inner#constructor (param i32) (result i32)
        (local.set 0
          (call $~lib/rt/__localtostack
            (call $~lib/object/Object#constructor
              (call $~lib/rt/__tmptostack (local.get 0))
            )
          )
        )
        (drop
          (call $Leaf#constructor
            (call $~lib/rt/__tmptostack
              (call $~lib/rt/itcms/__new (i32.const 16) (i32.const 1))
            )
          )
        )
        (local.get 0)
      )
      (func $Outer#constructor (param i32) (result i32)
        (local.set 0
          (call $~lib/rt/__localtostack
            (call $~lib/object/Object#constructor
              (call $~lib/rt/__tmptostack (local.get 0))
            )
          )
        )
        (drop
          (call $Inner#constructor
            (call $~lib/rt/__tmptostack
              (call $~lib/rt/itcms/__new (i32.const 16) (i32.const 1))
            )
          )
        )
        (local.get 0)
      )
      (func $entry
        (drop
          (call $Outer#constructor
            (call $~lib/rt/__tmptostack
              (call $~lib/rt/itcms/__new (i32.const 16) (i32.const 1))
            )
          )
        )
      )
    )
  )");

  runUnusedNewEliminating(*module);

  EXPECT_TRUE(module->getFunction("entry")->body->is<wasm::Nop>());
}

TEST(UnusedNewEliminatingTest, KeepsAllocationWithEffectfulRuntimeNewOperand) {
  std::unique_ptr<wasm::Module> module = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack"
        (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (import "as-builtin-fn" "~lib/rt/__localtostack"
        (func $~lib/rt/__localtostack (param i32) (result i32)))
      (import "rt" "new" (func $~lib/rt/itcms/__new (param i32 i32) (result i32)))
      (global $state (mut i32) (i32.const 0))
      (func $getSize (result i32)
        (global.set $state (i32.const 1))
        (i32.const 16)
      )
      (func $~lib/object/Object#constructor (param i32) (result i32)
        (local.get 0)
      )
      (func $Item#constructor (param i32) (result i32)
        (local.set 0
          (call $~lib/rt/__localtostack
            (call $~lib/object/Object#constructor
              (call $~lib/rt/__tmptostack (local.get 0))
            )
          )
        )
        (local.get 0)
      )
      (func $entry
        (drop
          (call $Item#constructor
            (call $~lib/rt/__tmptostack
              (call $~lib/rt/itcms/__new (call $getSize) (i32.const 1))
            )
          )
        )
      )
    )
  )");

  runUnusedNewEliminating(*module);

  EXPECT_TRUE(module->getFunction("entry")->body->is<wasm::Drop>());
}

TEST(UnusedNewEliminatingTest, KeepsConstructorWithAdditionalWork) {
  std::unique_ptr<wasm::Module> module = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack"
        (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (import "as-builtin-fn" "~lib/rt/__localtostack"
        (func $~lib/rt/__localtostack (param i32) (result i32)))
      (import "rt" "new" (func $~lib/rt/itcms/__new (param i32 i32) (result i32)))
      (global $state (mut i32) (i32.const 0))
      (func $~lib/object/Object#constructor (param i32) (result i32)
        (local.get 0)
      )
      (func $Item#constructor (param i32) (result i32)
        (local.set 0
          (call $~lib/rt/__localtostack
            (call $~lib/object/Object#constructor
              (call $~lib/rt/__tmptostack (local.get 0))
            )
          )
        )
        (global.set $state (i32.const 1))
        (local.get 0)
      )
      (func $entry
        (drop
          (call $Item#constructor
            (call $~lib/rt/__tmptostack
              (call $~lib/rt/itcms/__new (i32.const 16) (i32.const 1))
            )
          )
        )
      )
    )
  )");

  runUnusedNewEliminating(*module);

  EXPECT_TRUE(module->getFunction("entry")->body->is<wasm::Drop>());
}

} // namespace
} // namespace warpo::passes::ut

#endif