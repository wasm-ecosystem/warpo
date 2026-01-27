#include "MockInstrumentationWalker.hpp"
#include <asmjs/shared-constants.h>
#include <binaryen-c.h>
#include <string_view>
#include <support/index.h>
#include <wasm-type.h>
#include <wasm.h>
// mock test will be tested with wasm-testing-framework project, escape this class
// LCOV_EXCL_START
namespace wasmInstrumentation {

void MockInstrumentationWalker::visitCall(wasm::Call *const curr) noexcept {
  /* generate expect infos */
  if (std::any_of(this->expectTestFuncNames.begin(), this->expectTestFuncNames.end(),
                  [&curr](std::string_view str) noexcept {
                    auto lastIndex = curr->target.str.find_last_of(">");
                    if (lastIndex != std::string_view::npos) {
                      return curr->target.str.substr(lastIndex + 1) == str;
                    }
                    return false;
                  })) {
    const std::unordered_map<wasm::Expression *, wasm::Function::DebugLocation>
        &currDebugLocations = getFunction()->debugLocations;

    const auto currentDebugLocationIterator = currDebugLocations.find(curr);
    if (currentDebugLocationIterator != currDebugLocations.cend()) {
      wasm::Function::DebugLocation const &currDebugLocation = currentDebugLocationIterator->second;
      const std::string &fileName = module->debugInfoFileNames[currDebugLocation.fileIndex];
      std::stringstream expectInfo;
      expectInfo << fileName << ":" << currDebugLocation.lineNumber << ":"
                 << currDebugLocation.columnNumber;
      expectInfos[expectIndex] = expectInfo.str();
    }
    curr->operands.back() = moduleBuilder.makeConst(wasm::Literal(expectIndex));
    expectIndex++;
  }

  /* Function Call Mock */
  const auto functionRefsIterator = funcRefs.find(curr->target.str);
  if (functionRefsIterator != funcRefs.end()) {
    const wasm::Index localIdx = wasm::Builder::addVar(getFunction(), wasm::Type::i32);
    const auto &[tableName, originFuncIdx] = functionRefsIterator->second;
    const std::array<wasm::Expression *, 2U> callArgs = {moduleBuilder.makeConst(originFuncIdx),
                                                         moduleBuilder.makeConst(true)};
    wasm::If *const mockReplacement = moduleBuilder.makeIf(
        moduleBuilder.makeBinary(
            wasm::BinaryOp::NeInt32,
            moduleBuilder.makeLocalTee(localIdx,
                                       moduleBuilder.makeCall(checkMock, callArgs, wasm::Type::i32),
                                       wasm::Type::i32),
            moduleBuilder.makeConst(-1)),
        moduleBuilder.makeCallIndirect(
            tableName, moduleBuilder.makeLocalGet(localIdx, wasm::Type::i32), curr->operands,
            getModule()->getFunction(curr->target)->type),
        curr);
    replaceCurrent(mockReplacement);
  }
}

void MockInstrumentationWalker::visitCallIndirect(wasm::CallIndirect *const curr) noexcept {
  if (funcRefs.size() == 0U) {
    return;
  }
  const std::array<wasm::Expression *, 2U> args = {curr->target, moduleBuilder.makeConst(false)};
  curr->target = moduleBuilder.makeCall(checkMock, args, wasm::Type::i32);
}

bool MockInstrumentationWalker::mockFunctionDuplicateImportedCheck() const noexcept {
  bool checkRepeat = false;
  wasm::ModuleUtils::iterDefinedFunctions(
      *module, [&checkRepeat, this](const BinaryenFunctionRef &func) noexcept {
        if (func->name.str == this->checkMock) {
          checkRepeat = true;
        }
      });
  wasm::ModuleUtils::iterImportedFunctions(
      *module, [&checkRepeat, this](const BinaryenFunctionRef &func) noexcept {
        if (func->name.str == this->checkMock) {
          checkRepeat = true;
        }
      });
  if (!checkRepeat) {
    std::array<BinaryenType, 2U> ii_ =
        std::array<BinaryenType, 2U>{BinaryenTypeInt32(), BinaryenTypeInt32()};
    const BinaryenType ii = BinaryenTypeCreate(ii_.data(), ii_.size());
    BinaryenAddFunctionImport(module, this->checkMock.data(), "__unittest_framework_env", "checkMock", ii,
                              BinaryenTypeInt32());
  }
  return checkRepeat;
}

void MockInstrumentationWalker::addExecuteTestFunction() noexcept {
  std::vector<BinaryenExpressionRef> operands{};
  if (module->tables.empty()) {
    auto * table = module->addTable(wasm::Builder::makeTable(wasm::Name::fromInt(0)));
    table->base = "__indirect_function_table";
  }
  BinaryenExpressionRef body = moduleBuilder.makeCallIndirect(
    module->tables[0]->name, 
    BinaryenLocalGet(module, 0, wasm::Type::i32), 
    operands,
    wasm::Signature(wasm::Type::none, wasm::Type::none)
  );

  body->finalize();
  BinaryenAddFunction(module, "executeTestFunction", BinaryenTypeInt32(), BinaryenTypeNone(), {}, 0, body);
  BinaryenAddFunctionExport(module, "executeTestFunction", "executeTestFunction");
}

uint32_t MockInstrumentationWalker::mockWalk() noexcept {
  if (mockFunctionDuplicateImportedCheck()) {
    return 1U; // failed
  } else {
    wasm::ModuleUtils::iterDefinedFunctions(*module, [this](wasm::Function *const func) noexcept {
      walkFunctionInModule(func, this->module);
    });
    addExecuteTestFunction();
    return 0U;
  }
}
// LCOV_EXCL_STOP
} // namespace wasmInstrumentation
