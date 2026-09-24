// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <atomic>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <unordered_map>
#include <unordered_set>
#include <utility>

#include "UnusedFieldStoreEliminating.hpp"
#include "ir/local-utils.h"
#include "pass.h"
#include "warpo/common/ClassHierarchy.hpp"
#include "warpo/common/VariableInfo.hpp"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

namespace warpo::passes {
namespace {

constexpr std::string_view SETTER_MARKER = "#set:";
constexpr std::string_view GETTER_MARKER = "#get:";
constexpr std::string_view ITCMS_LINK_FUNCTION = "~lib/rt/itcms/__link";
constexpr std::string_view TCMS_LINK_FUNCTION = "~lib/rt/tcms/__link";
constexpr std::string_view LOCAL_TO_STACK_FUNCTION = "~lib/rt/__localtostack";
constexpr std::string_view TMP_TO_STACK_FUNCTION = "~lib/rt/__tmptostack";

class AccessorName {
public:
  AccessorName(std::string_view const owner, std::string_view const field) noexcept : owner_{owner}, field_{field} {}

  std::string_view getOwner() const noexcept { return owner_; }
  std::string_view getField() const noexcept { return field_; }

private:
  std::string_view owner_;
  std::string_view field_;
};

bool isLocalGet(wasm::Expression const *const expression, wasm::Index const index) noexcept {
  wasm::LocalGet const *const localGet = expression->dynCast<wasm::LocalGet>();
  return localGet != nullptr && localGet->index == index;
}

bool isGcLinkFunction(wasm::Name const name) noexcept {
  std::string_view const value = name.view();
  return value == ITCMS_LINK_FUNCTION || value == TCMS_LINK_FUNCTION;
}

bool isGcRootingFunction(wasm::Name const name) noexcept {
  std::string_view const value = name.view();
  return value == LOCAL_TO_STACK_FUNCTION || value == TMP_TO_STACK_FUNCTION;
}

std::optional<AccessorName> parseAccessorName(wasm::Name const name, std::string_view const marker) noexcept;

wasm::Expression *unwrapGcRootingCall(wasm::Expression *expression) noexcept {
  wasm::Call *const call = expression->dynCast<wasm::Call>();
  if (call == nullptr || !isGcRootingFunction(call->target) || call->operands.size() != 1)
    return expression;
  return call->operands[0];
}

bool isTrivialFieldGetter(wasm::Function const *const getter) noexcept {
  if (getter == nullptr || getter->imported() || getter->body == nullptr)
    return false;
  wasm::Load const *const load = getter->body->dynCast<wasm::Load>();
  return load != nullptr && !load->isAtomic() && isLocalGet(load->ptr, 0);
}

bool isFieldGcLink(wasm::Expression const *const expression) noexcept {
  wasm::Call const *const call = expression->dynCast<wasm::Call>();
  return call != nullptr && isGcLinkFunction(call->target) && call->type == wasm::Type::none && !call->isReturn &&
         call->operands.size() == 3 && isLocalGet(call->operands[0], 0) && isLocalGet(call->operands[1], 1) &&
         call->operands[2]->is<wasm::Const>();
}

std::optional<AccessorName> parseAccessorName(wasm::Name const name, std::string_view const marker) noexcept {
  std::string_view const value = name.view();
  size_t const markerPosition = value.rfind(marker);
  if (markerPosition == std::string_view::npos)
    return std::nullopt;
  return AccessorName{value.substr(0, markerPosition), value.substr(markerPosition + marker.size())};
}

std::optional<uint32_t> getTrivialFieldSetterOffset(wasm::Function &setter) noexcept {
  if (setter.imported())
    return std::nullopt;
  if (setter.body == nullptr)
    return std::nullopt;
  if (setter.getResults() != wasm::Type::none)
    return std::nullopt;
  if (setter.getParams().size() != 2)
    return std::nullopt;

  wasm::Expression const *storeExpression = setter.body;
  if (wasm::Block const *const block = setter.body->dynCast<wasm::Block>()) {
    if (block->list.size() != 2 || !isFieldGcLink(block->list[1]))
      return std::nullopt;
    storeExpression = block->list[0];
  }

  wasm::Store const *const store = storeExpression->dynCast<wasm::Store>();
  if (store == nullptr)
    return std::nullopt;
  if (store->isAtomic())
    return std::nullopt;

  wasm::LocalGet const *const object = store->ptr->dynCast<wasm::LocalGet>();
  wasm::LocalGet const *const value = store->value->dynCast<wasm::LocalGet>();
  if (object == nullptr || object->index != 0 || value == nullptr || value->index != 1)
    return std::nullopt;
  return static_cast<uint32_t>(store->offset);
}

wasm::Name getGetterName(std::string_view const owner, std::string_view const field) {
  std::string getterName;
  getterName.reserve(owner.size() + GETTER_MARKER.size() + field.size());
  getterName.append(owner);
  getterName.append(GETTER_MARKER);
  getterName.append(field);
  return getterName;
}

bool isRedeclaredField(VariableInfo const *const variableInfo, AccessorName const &setter,
                       uint32_t const setterOffset) {
  if (variableInfo == nullptr)
    return false;

  ClassHierarchy const hierarchy{*variableInfo};
  std::vector<std::string_view> relatedClasses = hierarchy.getAncestors(setter.getOwner());
  relatedClasses.push_back(setter.getOwner());
  std::vector<std::string_view> descendants = hierarchy.getDescendants(setter.getOwner());
  relatedClasses.insert(relatedClasses.end(), descendants.begin(), descendants.end());

  VariableInfo::ClassRegistry const &classRegistry = variableInfo->getClassRegistry();
  for (std::string_view const className : relatedClasses) {
    VariableInfo::ClassRegistry::const_iterator const classIt = classRegistry.find(className);
    if (classIt != classRegistry.end()) {
      for (FieldInfo const &field : classIt->second.getDeclaredFields()) {
        if (field.getName() == setter.getField() && field.isRedeclared())
          return true;
      }
    }
  }
  return false;
}

class AccessorAnalysis : public wasm::PostWalker<AccessorAnalysis> {
public:
  AccessorAnalysis(wasm::Module &m, VariableInfo const *const variableInfo) : m_{m}, variableInfo_{variableInfo} {}

  void addReferencedFunction(wasm::Name const functionName) {
    referencedFunctionNames_.insert(functionName);
    if (parseAccessorName(functionName, GETTER_MARKER).has_value())
      usedGetterNames_.insert(functionName);
  }

  void addElementSegmentFunctions() {
    for (std::unique_ptr<wasm::ElementSegment> const &segment : m_.elementSegments) {
      for (wasm::Expression *const element : segment->data) {
        wasm::RefFunc *const refFunc = element->dynCast<wasm::RefFunc>();
        if (refFunc != nullptr)
          addReferencedFunction(refFunc->func);
      }
    }
  }

  void visitCall(wasm::Call *call) {
    if (parseAccessorName(call->target, GETTER_MARKER).has_value())
      usedGetterNames_.insert(call->target);

    std::optional<AccessorName> const setter = parseAccessorName(call->target, SETTER_MARKER);
    if (!setter)
      return;
    if (referencedFunctionNames_.contains(call->target))
      return;

    wasm::Function *const setterFunction = m_.getFunctionOrNull(call->target);
    if (setterFunction == nullptr)
      return;
    std::optional<uint32_t> const setterOffset = getTrivialFieldSetterOffset(*setterFunction);
    if (!setterOffset.has_value())
      return;
    if (variableInfo_ != nullptr && variableInfo_->getMemoryExposureTypeRegistry().contains(setter->getOwner()))
      return;
    if (isRedeclaredField(variableInfo_, *setter, *setterOffset))
      return;
    setterOffsets_.emplace(call->target, *setterOffset);
  }

  void visitRefFunc(wasm::RefFunc *refFunc) { addReferencedFunction(refFunc->func); }

  std::unordered_map<wasm::Name, uint32_t> const &getSetterOffsets() const noexcept { return setterOffsets_; }
  std::unordered_set<wasm::Name> const &getUsedGetterNames() const noexcept { return usedGetterNames_; }
  std::unordered_set<wasm::Name> const &getReferencedFunctionNames() const noexcept { return referencedFunctionNames_; }

private:
  wasm::Module &m_;
  VariableInfo const *variableInfo_;
  std::unordered_map<wasm::Name, uint32_t> setterOffsets_;
  std::unordered_set<wasm::Name> usedGetterNames_;
  std::unordered_set<wasm::Name> referencedFunctionNames_;
};

std::unordered_set<wasm::Name> analyzeRemovableSetters(wasm::Module *const m, VariableInfo const *const variableInfo) {
  AccessorAnalysis analysis{*m, variableInfo};
  analysis.addElementSegmentFunctions();
  for (std::unique_ptr<wasm::Export> const &export_ : m->exports) {
    if (export_->kind == wasm::ExternalKind::Function)
      analysis.addReferencedFunction(*export_->getInternalName());
  }
  if (m->start.is())
    analysis.addReferencedFunction(m->start);
  analysis.walkModule(m);

  std::unordered_set<wasm::Name> removableSetterNames;
  for (std::pair<wasm::Name const, uint32_t> const &setter : analysis.getSetterOffsets()) {
    wasm::Name const &setterName = setter.first;
    if (analysis.getReferencedFunctionNames().contains(setterName))
      continue;
    std::optional<AccessorName> const setterAccessor = parseAccessorName(setterName, SETTER_MARKER);
    if (!setterAccessor.has_value())
      continue;
    if (analysis.getUsedGetterNames().contains(getGetterName(setterAccessor->getOwner(), setterAccessor->getField())))
      continue;
    removableSetterNames.insert(setterName);
  }
  return removableSetterNames;
}

class RemovalCounter {
public:
  void increment() noexcept { count_.fetch_add(1, std::memory_order_relaxed); }
  size_t get() const noexcept { return count_.load(std::memory_order_relaxed); }

private:
  std::atomic<size_t> count_{0};
};

class SetterCallRemover : public wasm::WalkerPass<wasm::PostWalker<SetterCallRemover>> {
public:
  SetterCallRemover(std::unordered_set<wasm::Name> removableSetterNames, std::shared_ptr<RemovalCounter> counter)
      : removableSetterNames_{std::move(removableSetterNames)}, counter_{std::move(counter)} {}

  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override {
    return std::make_unique<SetterCallRemover>(removableSetterNames_, counter_);
  }

  void visitCall(wasm::Call *call) {
    if (!removableSetterNames_.contains(call->target) || call->type != wasm::Type::none || call->isReturn)
      return;

    counter_->increment();
    wasm::Builder builder{*getModule()};
    replaceCurrent(builder.makeBlock({builder.makeDrop(unwrapGcRootingCall(call->operands[0])),
                                      builder.makeDrop(unwrapGcRootingCall(call->operands[1]))}));
  }

private:
  std::unordered_set<wasm::Name> removableSetterNames_;
  std::shared_ptr<RemovalCounter> counter_;
};

class UnusedGetterCallRemover : public wasm::PostWalker<UnusedGetterCallRemover> {
public:
  UnusedGetterCallRemover(wasm::Module &m, std::vector<wasm::Index> const &localGetCounts) noexcept
      : m_{m}, localGetCounts_{localGetCounts} {}

  void visitLocalSet(wasm::LocalSet *localSet) {
    if (localSet->type != wasm::Type::none || localGetCounts_[localSet->index] != 0 ||
        !isRemovableGetterCall(localSet->value))
      return;
    ++removedCallCount_;
    replaceCurrent(wasm::Builder{m_}.makeNop());
  }

  void visitDrop(wasm::Drop *drop) {
    if (!isRemovableGetterCall(drop->value))
      return;
    ++removedCallCount_;
    replaceCurrent(wasm::Builder{m_}.makeNop());
  }

  size_t getRemovedCallCount() const noexcept { return removedCallCount_; }

private:
  bool isRemovableGetterCall(wasm::Expression *expression) const noexcept {
    expression = unwrapGcRootingCall(expression);
    wasm::Call const *const call = expression->dynCast<wasm::Call>();
    if (call == nullptr || call->operands.size() != 1 ||
        unwrapGcRootingCall(call->operands[0])->dynCast<wasm::LocalGet>() == nullptr ||
        !parseAccessorName(call->target, GETTER_MARKER).has_value())
      return false;

    return isTrivialFieldGetter(m_.getFunctionOrNull(call->target));
  }

  wasm::Module &m_;
  std::vector<wasm::Index> const &localGetCounts_;
  size_t removedCallCount_{0};
};

size_t removeUnusedGetterCalls(wasm::Module *const m) {
  size_t removedCallCount = 0;
  for (std::unique_ptr<wasm::Function> const &function : m->functions) {
    if (function->body == nullptr)
      continue;
    wasm::LocalGetCounter const localGetCounter{function.get()};
    UnusedGetterCallRemover remover{*m, localGetCounter.num};
    remover.walkFunctionInModule(function.get(), m);
    removedCallCount += remover.getRemovedCallCount();
  }
  return removedCallCount;
}

class UnusedFieldStoreEliminating : public wasm::Pass {
public:
  explicit UnusedFieldStoreEliminating(VariableInfo const *const variableInfo) : variableInfo_{variableInfo} {}

  void run(wasm::Module *m) override {
    std::shared_ptr<RemovalCounter> const counter = std::make_shared<RemovalCounter>();
    while (true) {
      std::unordered_set<wasm::Name> removableSetterNames = analyzeRemovableSetters(m, variableInfo_);
      if (removableSetterNames.empty())
        return;

      size_t const removedCallCountBefore = counter->get();
      wasm::PassRunner runner{getPassRunner()};
      runner.add(std::make_unique<SetterCallRemover>(std::move(removableSetterNames), counter));
      runner.run();
      if (counter->get() == removedCallCountBefore)
        return;

      removeUnusedGetterCalls(m);
    }
  }

private:
  VariableInfo const *variableInfo_;
};

} // namespace

wasm::Pass *createUnusedFieldStoreEliminatingPass(VariableInfo const *const variableInfo) {
  return new UnusedFieldStoreEliminating(variableInfo);
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"

namespace warpo::passes::ut {
namespace {

void runUnusedFieldStoreEliminating(wasm::Module &m, VariableInfo const *const variableInfo = nullptr) {
  wasm::PassRunner runner{&m};
  runner.add(std::unique_ptr<wasm::Pass>{createUnusedFieldStoreEliminatingPass(variableInfo)});
  runner.run();
}

void expectOperandDrops(wasm::Expression *const expression) {
  wasm::Block const *const block = expression->dynCast<wasm::Block>();
  ASSERT_NE(block, nullptr);
  ASSERT_EQ(block->list.size(), 2);
  EXPECT_TRUE(block->list[0]->is<wasm::Drop>());
  EXPECT_TRUE(block->list[1]->is<wasm::Drop>());
}

TEST(UnusedFieldStoreEliminatingTest, RemovesSetterCallForUnreadField) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $write
        (call $Packet#set:unused
          (i32.const 8)
          (i32.load (i32.const 4))
        )
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  expectOperandDrops(m->getFunction("write")->body);
  wasm::Block const *const body = m->getFunction("write")->body->dynCast<wasm::Block>();
  ASSERT_NE(body, nullptr);
  wasm::Drop const *const valueDrop = body->list[1]->dynCast<wasm::Drop>();
  ASSERT_NE(valueDrop, nullptr);
  EXPECT_TRUE(valueDrop->value->is<wasm::Load>());
}

TEST(UnusedFieldStoreEliminatingTest, RemovesReferenceFieldSetterWithGcLink) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $~lib/rt/itcms/__link (param i32 i32 i32))
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
        (call $~lib/rt/itcms/__link (local.get 0) (local.get 1) (i32.const 1))
      )
      (func $write
        (call $Packet#set:unused (i32.const 8) (i32.const 16))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  expectOperandDrops(m->getFunction("write")->body);
}

TEST(UnusedFieldStoreEliminatingTest, PreservesOuterSetterUsedByDroppedReceiver) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__localtostack"
        (func $~lib/rt/__localtostack (param i32) (result i32)))
      (import "as-builtin-fn" "~lib/rt/__tmptostack"
        (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (memory 1)
      (func $~lib/rt/tcms/__link (param i32 i32 i32))
      (func $A#set:b (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
        (call $~lib/rt/tcms/__link (local.get 0) (local.get 1) (i32.const 1))
      )
      (func $A#get:b (param i32) (result i32)
        (i32.load offset=4 (local.get 0))
      )
      (func $B#set:y (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $initialize (param i32 i32) (local i32)
        (call $A#set:b (local.get 0) (local.get 1))
        (local.set 2
          (call $~lib/rt/__localtostack
            (call $A#get:b (call $~lib/rt/__tmptostack (local.get 0)))
          )
        )
        (call $B#set:y (local.get 2) (i32.const 42))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  wasm::Block const *const body = m->getFunction("initialize")->body->dynCast<wasm::Block>();
  ASSERT_NE(body, nullptr);
  ASSERT_EQ(body->list.size(), 3);
  wasm::Call const *const outerSetter = body->list[0]->dynCast<wasm::Call>();
  ASSERT_NE(outerSetter, nullptr);
  EXPECT_EQ(outerSetter->target, "A#set:b");
  EXPECT_TRUE(body->list[1]->is<wasm::LocalSet>());
  expectOperandDrops(body->list[2]);
}

TEST(UnusedFieldStoreEliminatingTest, KeepsStoreFollowedByUnrelatedCall) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $observe (param i32 i32 i32))
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
        (call $observe (local.get 0) (local.get 1) (i32.const 1))
      )
      (func $write
        (call $Packet#set:unused (i32.const 8) (i32.const 16))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  EXPECT_TRUE(m->getFunction("write")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, KeepsSetterCallForReadField) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Packet#set:used (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $Packet#get:used (param i32) (result i32)
        (i32.load offset=4 (local.get 0))
      )
      (func $write
        (call $Packet#set:used (i32.const 8) (i32.const 1))
      )
      (func $read (result i32)
        (call $Packet#get:used (i32.const 8))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  EXPECT_TRUE(m->getFunction("write")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, RemovesSetterCallPreservingEffectfulOperand) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (global $state (mut i32) (i32.const 0))
      (memory 1)
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $getValue (result i32)
        (global.set $state (i32.const 1))
        (i32.const 2)
      )
      (func $write
        (call $Packet#set:unused (i32.const 8) (call $getValue))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  expectOperandDrops(m->getFunction("write")->body);
}

TEST(UnusedFieldStoreEliminatingTest, RemovesSetterCallPreservingLocalTeeOperand) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $write (param i32) (local i32)
        (call $Packet#set:unused
          (i32.const 8)
          (local.tee 1 (local.get 0))
        )
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  expectOperandDrops(m->getFunction("write")->body);
}

TEST(UnusedFieldStoreEliminatingTest, RemovesSetterCallPreservingControlFlowOperand) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $write
        (call $Packet#set:unused
          (i32.const 8)
          (block (result i32)
            (i32.const 1)
          )
        )
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  expectOperandDrops(m->getFunction("write")->body);
}

TEST(UnusedFieldStoreEliminatingTest, RemovesSetterCallPreservingUnknownBuiltinImportOperand) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (import "builtin.math" "value" (func $builtin.value (result i32)))
      (memory 1)
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $write
        (call $Packet#set:unused (i32.const 8) (call $builtin.value))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  expectOperandDrops(m->getFunction("write")->body);
}

TEST(UnusedFieldStoreEliminatingTest, RemovesSetterCallPreservingLinkedMemoryGetterOperand) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (import "builtin" "getU8FromLinkedMemory"
        (func $builtin.getU8FromLinkedMemory (param i32) (result i32)))
      (memory 1)
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $write
        (call $Packet#set:unused
          (i32.const 8)
          (call $builtin.getU8FromLinkedMemory (i32.const 0))
        )
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  expectOperandDrops(m->getFunction("write")->body);
}

TEST(UnusedFieldStoreEliminatingTest, RemovesSetterCallPreservingTmpToStackOperand) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (import "as-builtin-fn" "~lib/rt/__tmptostack"
        (func $~lib/rt/__tmptostack (param i32) (result i32)))
      (memory 1)
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $write
        (call $Packet#set:unused
          (i32.const 8)
          (call $~lib/rt/__tmptostack (i32.load (i32.const 0)))
        )
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  expectOperandDrops(m->getFunction("write")->body);
}

TEST(UnusedFieldStoreEliminatingTest, RemovesSetterCallPreservingNonBuiltinImportOperand) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (import "host" "value" (func $host.value (result i32)))
      (memory 1)
      (func $Packet#set:unused (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $write
        (call $Packet#set:unused (i32.const 8) (call $host.value))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  expectOperandDrops(m->getFunction("write")->body);
}

TEST(UnusedFieldStoreEliminatingTest, KeepsNonTrivialSetter) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (global $state (mut i32) (i32.const 0))
      (func $Packet#set:unused (param i32 i32)
        (global.set $state (local.get 1))
      )
      (func $write
        (call $Packet#set:unused (i32.const 8) (i32.const 1))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  EXPECT_TRUE(m->getFunction("write")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, KeepsSetterWhenGetterIsExported) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (export "get" (func $Packet#get:used))
      (func $Packet#set:used (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $Packet#get:used (param i32) (result i32)
        (i32.load offset=4 (local.get 0))
      )
      (func $write
        (call $Packet#set:used (i32.const 8) (i32.const 1))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  EXPECT_TRUE(m->getFunction("write")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, KeepsSetterWhenGetterIsInTable) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (table 1 funcref)
      (elem (i32.const 0) $Packet#get:used)
      (func $Packet#set:used (param i32 i32)
        (i32.store offset=4 (local.get 0) (local.get 1))
      )
      (func $Packet#get:used (param i32) (result i32)
        (i32.load offset=4 (local.get 0))
      )
      (func $write
        (call $Packet#set:used (i32.const 8) (i32.const 1))
      )
    )
  )");

  runUnusedFieldStoreEliminating(*m);

  EXPECT_TRUE(m->getFunction("write")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, KeepsSetterForExposedClassHierarchy) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Derived#set:value (param i32 i32)
        (i32.store (local.get 0) (local.get 1))
      )
      (func $write
        (call $Derived#set:value (i32.const 8) (i32.const 1))
      )
    )
  )");
  VariableInfo variableInfo;
  variableInfo.createClass("Base", 1);
  variableInfo.createClass("Derived", 2);
  variableInfo.addBaseClass("Derived", "Base");
  variableInfo.addMemoryExposureType("Base");
  variableInfo.finalizeMemoryExposure();

  runUnusedFieldStoreEliminating(*m, &variableInfo);

  EXPECT_TRUE(m->getFunction("write")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, KeepsSetterForBaseOfExposedClassHierarchy) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Base#set:value (param i32 i32)
        (i32.store (local.get 0) (local.get 1))
      )
      (func $write
        (call $Base#set:value (i32.const 8) (i32.const 1))
      )
    )
  )");
  VariableInfo variableInfo;
  variableInfo.createClass("Base", 1);
  variableInfo.createClass("Derived", 2);
  variableInfo.addBaseClass("Derived", "Base");
  variableInfo.addMemoryExposureType("Derived");
  variableInfo.finalizeMemoryExposure();

  runUnusedFieldStoreEliminating(*m, &variableInfo);

  EXPECT_TRUE(m->getFunction("write")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, KeepsSetterForInterfaceImplementation) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Impl#set:value (param i32 i32)
        (i32.store (local.get 0) (local.get 1))
      )
      (func $BaseImpl#set:value (param i32 i32)
        (i32.store (local.get 0) (local.get 1))
      )
      (func $writeImpl
        (call $Impl#set:value (i32.const 8) (i32.const 1))
      )
      (func $writeBaseImpl
        (call $BaseImpl#set:value (i32.const 8) (i32.const 1))
      )
    )
  )");
  VariableInfo variableInfo;
  variableInfo.createInterface("BaseReadable");
  variableInfo.createInterface("Readable");
  variableInfo.addBaseInterface("Readable", "BaseReadable");
  variableInfo.createClass("Impl", 1);
  variableInfo.createClass("BaseImpl", 2);
  variableInfo.addInterface("Impl", "Readable");
  variableInfo.addInterface("BaseImpl", "BaseReadable");
  variableInfo.addMemoryExposureType("BaseReadable");
  variableInfo.finalizeMemoryExposure();

  runUnusedFieldStoreEliminating(*m, &variableInfo);

  EXPECT_TRUE(m->getFunction("writeImpl")->body->is<wasm::Call>());
  EXPECT_TRUE(m->getFunction("writeBaseImpl")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, KeepsSetterForRelatedSameNameGetter) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Base#set:value (param i32 i32)
        (i32.store (local.get 0) (local.get 1))
      )
      (func $Derived#set:value (param i32 i32)
        (i32.store (local.get 0) (local.get 1))
      )
      (func $Base#get:value (param i32) (result i32)
        (i32.load (local.get 0))
      )
      (func $Derived#get:value (param i32) (result i32)
        (i32.load (local.get 0))
      )
      (func $writeBase
        (call $Base#set:value (i32.const 8) (i32.const 1))
      )
      (func $writeDerived
        (call $Derived#set:value (i32.const 8) (i32.const 1))
      )
      (func $readBase (result i32)
        (call $Base#get:value (i32.const 8))
      )
      (func $readDerived (result i32)
        (call $Derived#get:value (i32.const 8))
      )
    )
  )");
  VariableInfo variableInfo;
  variableInfo.createClass("Base", 1);
  variableInfo.createClass("Derived", 2);
  variableInfo.addBaseClass("Derived", "Base");
  variableInfo.addField("Base", "value", "i32", 0, 0);
  variableInfo.addFieldDeclaration("Base", "value", "i32", 0, 0, false);
  variableInfo.addFieldDeclaration("Derived", "value", "i32", 0, 0, true);

  runUnusedFieldStoreEliminating(*m, &variableInfo);

  EXPECT_TRUE(m->getFunction("writeBase")->body->is<wasm::Call>());
  EXPECT_TRUE(m->getFunction("writeDerived")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, KeepsSetterWhenRedeclaredGetterIsUsed) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Base#set:value (param i32 i32)
        (i32.store (local.get 0) (local.get 1))
      )
      (func $Derived#get:value (param i32) (result i32)
        (i32.load (local.get 0))
      )
      (func $write
        (call $Base#set:value (i32.const 8) (i32.const 1))
      )
      (func $read (result i32)
        (call $Derived#get:value (i32.const 8))
      )
    )
  )");
  VariableInfo variableInfo;
  variableInfo.createClass("Base", 1);
  variableInfo.createClass("Derived", 2);
  variableInfo.addBaseClass("Derived", "Base");
  variableInfo.addFieldDeclaration("Base", "value", "i32", 0, 0, false);
  variableInfo.addFieldDeclaration("Derived", "value", "i32", 0, 0, true);

  runUnusedFieldStoreEliminating(*m, &variableInfo);

  EXPECT_TRUE(m->getFunction("write")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, KeepsSetterForRedeclaredFieldWhenGetterIsUnused) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $Base#set:value (param i32 i32)
        (i32.store (local.get 0) (local.get 1))
      )
      (func $Derived#get:value (param i32) (result i32)
        (i32.load (local.get 0))
      )
      (func $write
        (call $Base#set:value (i32.const 8) (i32.const 1))
      )
    )
  )");
  VariableInfo variableInfo;
  variableInfo.createClass("Base", 1);
  variableInfo.createClass("Derived", 2);
  variableInfo.addBaseClass("Derived", "Base");
  variableInfo.addFieldDeclaration("Base", "value", "i32", 0, 0, false);
  variableInfo.addFieldDeclaration("Derived", "value", "i32", 0, 0, true);

  runUnusedFieldStoreEliminating(*m, &variableInfo);

  EXPECT_TRUE(m->getFunction("write")->body->is<wasm::Call>());
}

TEST(UnusedFieldStoreEliminatingTest, DoesNotMatchGetterFromUnrelatedClass) {
  std::unique_ptr<wasm::Module> m = loadWat(R"(
    (module
      (memory 1)
      (func $First#set:value (param i32 i32)
        (i32.store (local.get 0) (local.get 1))
      )
      (func $Second#get:value (param i32) (result i32)
        (i32.load (local.get 0))
      )
      (func $write
        (call $First#set:value (i32.const 8) (i32.const 1))
      )
      (func $read (result i32)
        (call $Second#get:value (i32.const 8))
      )
    )
  )");
  VariableInfo variableInfo;
  variableInfo.createClass("First", 1);
  variableInfo.createClass("Second", 2);
  variableInfo.addField("First", "value", "i32", 0, 0);
  variableInfo.addField("Second", "value", "i32", 0, 0);
  variableInfo.addFieldDeclaration("First", "value", "i32", 0, 0, false);
  variableInfo.addFieldDeclaration("Second", "value", "i32", 0, 0, false);

  runUnusedFieldStoreEliminating(*m, &variableInfo);

  expectOperandDrops(m->getFunction("write")->body);
  EXPECT_TRUE(m->getFunction("read")->body->is<wasm::Call>());
}

} // namespace
} // namespace warpo::passes::ut

#endif