#ifndef __ASC_COV_MOCKINSTRUMENTATION_WALKER_HPP__
#define __ASC_COV_MOCKINSTRUMENTATION_WALKER_HPP__
#include <cassert>
#include <cstddef>
#include <cstdint>
#include <iostream>
#include <string_view>
#include <utility>
#include <vector>
#include "binaryen-c.h"
#include "ir/module-utils.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"
namespace wasmInstrumentation {
///
///@brief Mock instrumentation walker class
///
// mock test will be tested with wasm-testing-framework project, escape this class
// LCOV_EXCL_START
class MockInstrumentationWalker final : public wasm::PostWalker<MockInstrumentationWalker> {
public:
  ///
  /// @brief Constructor for MockInstrumentationWalker
  ///
  /// @param _module
  /// @param _checkMock
  explicit MockInstrumentationWalker(
      wasm::Module *const _module,
      const std::string _checkMock = "__unittest_framework_env/checkMock") noexcept
      : module(_module), checkMock(_checkMock), moduleBuilder(wasm::Builder(*_module)) {
    for (const auto &elemSegment : _module->elementSegments) {
      if (elemSegment->type.isFunction()) {
        const auto &data = elemSegment->data;
        const size_t dataSize = data.size();
        for (std::size_t i = 0; i < dataSize; ++i) {
          const wasm::RefFunc *funcRef = data[i]->cast<wasm::RefFunc>();
          std::string_view functionName = funcRef->func.str;
          const std::string_view nameSuffix = "@varargs";
          if (functionName.size() >= nameSuffix.size() &&
              std::equal(nameSuffix.begin(), nameSuffix.end(),
                         functionName.end() - nameSuffix.size())) {
            functionName.remove_suffix(nameSuffix.size());
          }
          funcRefs[functionName] =
              std::make_pair(elemSegment->table, static_cast<wasm::Index>(i + 1));
        }
      }
    }
  }

  MockInstrumentationWalker(const MockInstrumentationWalker &src) = delete;
  MockInstrumentationWalker(MockInstrumentationWalker &&src) = delete;
  MockInstrumentationWalker &operator=(const MockInstrumentationWalker &) = delete;
  MockInstrumentationWalker &operator=(MockInstrumentationWalker &&) = delete;
  ///
  /// @brief Destructor for MockInstrumentationWalker
  ///
  ~MockInstrumentationWalker() noexcept = default;
  ///
  /// @brief Get expect infos
  ///
  /// @return expect infos, if assert fail, return the expect infos with debug info
  const std::unordered_map<uint32_t, std::string> &getExpectInfos() const noexcept {
    return expectInfos;
  }

  ///
  /// @brief Visit call instruction
  ///
  /// @param curr Current expression reference
  void visitCall(wasm::Call *const curr) noexcept;

  static void doPreVisit(MockInstrumentationWalker *self, wasm::Expression **currp) {
    wasm::Expression *curr = *currp;
    auto &locs = self->getFunction()->debugLocations;
    auto &expressionStack = self->expressionStack;
    if (locs.find(curr) == locs.end()) {
      // No debug location, see if we should inherit one.
      if (wasm::Expression *previous = self->getPrevious()) {
        auto it = locs.find(previous);
        if (it != locs.end()) {
          locs[curr] = it->second;
        }
      }
    }
    expressionStack.push_back(curr);
  }

  static void doPostVisit(MockInstrumentationWalker *self, wasm::Expression **currp) {
    auto &exprStack = self->expressionStack;
    while (exprStack.back() != *currp) {
      // pop all the child expressions and keep current expression in stack.
      exprStack.pop_back();
    }
  }

  static void scan(MockInstrumentationWalker *self, wasm::Expression **currp) {
    self->pushTask(MockInstrumentationWalker::doPostVisit, currp);

    PostWalker<MockInstrumentationWalker>::scan(self, currp);

    self->pushTask(MockInstrumentationWalker::doPreVisit, currp);
  }

  wasm::Expression *replaceCurrent(wasm::Expression *expression) {
    PostWalker<MockInstrumentationWalker>::replaceCurrent(expression);
    // also update the stack
    expressionStack.back() = expression;
    return expression;
  }

  wasm::Expression *getPrevious() {
    if (expressionStack.empty()) {
      return nullptr;
    }
    assert(expressionStack.size() >= 1);
    return expressionStack[expressionStack.size() - 1];
  }

  ///
  /// @brief Visit call indirect instruction
  ///
  /// @param curr Current expression reference
  void visitCallIndirect(wasm::CallIndirect *const curr) noexcept;

  ///
  /// @brief Check mock function duplicated
  ///
  /// @brief bool, true when the mock function is duplicated imported
  bool mockFunctionDuplicateImportedCheck() const noexcept;

  ///
  /// @brief Add export function executeTestFunction()
  ///
  void addExecuteTestFunction() noexcept;

  ///
  /// @brief Main API for mock instrumentation
  ///
  uint32_t mockWalk() noexcept;

private:
  wasm::Module *const module;  ///< working module
  const std::string checkMock; ///< mock check string
  wasm::Builder moduleBuilder; ///< module builder
  uint32_t expectIndex = 0U;   ///< expectation index, auto increase
  wasm::ExpressionStack expressionStack;
  std::unordered_map<std::string_view, std::pair<wasm::Name, wasm::Index>>
      funcRefs;                                          ///< cache function references
  std::unordered_map<uint32_t, std::string> expectInfos; ///< cache expectation infos
  const std::vector<std::string_view> expectTestFuncNames{
      "#isNull",   "#notNull",         "#equal",
      "#notEqual", "#greaterThan",     "#greaterThanOrEqual",
      "#lessThan", "#lessThanOrEqual", "#closeTo"}; ///< expectation functions list
};

} // namespace wasmInstrumentation

#endif
// LCOV_EXCL_STOP
