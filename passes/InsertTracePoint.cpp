// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <cstddef>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fstream>
#include <iostream>
#include <memory>
#include <string>

#include "InsertTracePoint.hpp"
#include "literal.h"
#include "pass.h"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/IncMap.hpp"
#include "warpo/support/Opt.hpp"
#include "wasm-builder.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "Tracing"
#define DEBUG_PREFIX "[Tracing] "

constexpr const char *tracePointFunctionName = "~/lib/trace_point";
constexpr size_t traceOffset = 0x1'000000;

namespace warpo::passes {
namespace {

struct FunctionIndexMap : private IncMap<wasm::Function *> {
  using IncMap::contains;
  size_t getIndex(wasm::Function *func) const { return IncMap::getIndex(func) + traceOffset; }

  static FunctionIndexMap create(wasm::Module *m) {
    FunctionIndexMap functionIndexes{};
    for (std::unique_ptr<wasm::Function> const &func : m->functions) {
      if (func->name.startsWith("~lib"))
        continue;
      functionIndexes.insert(func.get());
    }
    return functionIndexes;
  }
  template <class Fn> void forEach(Fn &&fn) const {
    for (auto const &[func, index] : *this) {
      fn(func, index + traceOffset);
    }
  }
};

struct TracingInserter : public wasm::Pass {
  FunctionIndexMap const &functionIndexes_;
  explicit TracingInserter(FunctionIndexMap const &functionIndexes) noexcept : functionIndexes_(functionIndexes) {}
  bool isFunctionParallel() override { return true; }
  bool modifiesBinaryenIR() override { return true; }
  std::unique_ptr<wasm::Pass> create() override { return std::make_unique<TracingInserter>(functionIndexes_); }

  void runOnFunction(wasm::Module *m, wasm::Function *func) override {
    struct WrapperCall : public wasm::PostWalker<WrapperCall> {
      FunctionIndexMap const &functionIndexes_;
      explicit WrapperCall(FunctionIndexMap const &functionIndexes) : functionIndexes_(functionIndexes) {}
      void visitCall(wasm::Call *expr) {
        wasm::Function *func = getModule()->getFunction(expr->target);
        if (!func->imported())
          return;
        assert(functionIndexes_.contains(func));
        int32_t const index = static_cast<int32_t>(functionIndexes_.getIndex(func));
        wasm::Builder b{*getModule()};
        wasm::Type const resultType = func->getResults();
        if (func->getResults() == wasm::Type::none) {
          replaceCurrent(b.makeBlock(
              {
                  b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal(index))}, wasm::Type::none),
                  expr,
                  b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal(-index))}, wasm::Type::none),
              },
              wasm::Type::none));
        } else {
          wasm::Index const localIdx = wasm::Builder::addVar(getFunction(), resultType);
          replaceCurrent(b.makeBlock(
              {
                  b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal(index))}, wasm::Type::none),
                  b.makeLocalSet(localIdx, expr),
                  b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal(-index))}, wasm::Type::none),
                  b.makeLocalGet(localIdx, resultType),
              },
              resultType));
        }
      }
    };

    WrapperCall wrapperCall{functionIndexes_};
    wrapperCall.walkFunctionInModule(func, m);

    if (!functionIndexes_.contains(func))
      return;

    const int32_t currentIndex = static_cast<int32_t>(functionIndexes_.getIndex(func));
    assert(currentIndex > 0);

    struct ReturnWithResultReplacer : public wasm::PostWalker<ReturnWithResultReplacer> {
      wasm::Index const scratchReturnValueLocalIndex_;
      int32_t const currentIndex_;
      wasm::Type const &resultType_;
      explicit ReturnWithResultReplacer(wasm::Index const scratchReturnValueLocalIndex, int32_t const currentIndex,
                                        wasm::Type const &returnType)
          : scratchReturnValueLocalIndex_(scratchReturnValueLocalIndex), currentIndex_(currentIndex),
            resultType_(returnType) {}
      void visitReturn(wasm::Return *expr) {
        wasm::Builder b{*getModule()};
        assert(expr->value);
        replaceCurrent(b.makeBlock(
            {
                b.makeLocalSet(scratchReturnValueLocalIndex_, expr->value),
                b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal(-currentIndex_))}, wasm::Type::none),
                expr,
            },
            wasm::Type::unreachable));
        expr->value = b.makeLocalGet(scratchReturnValueLocalIndex_, resultType_);
      }
    };
    struct ReturnWithoutResultReplacer : public wasm::PostWalker<ReturnWithoutResultReplacer> {
      int32_t const currentIndex_;
      explicit ReturnWithoutResultReplacer(int32_t const currentIndex) : currentIndex_(currentIndex) {}
      void visitReturn(wasm::Return *expr) {
        wasm::Builder b{*getModule()};
        replaceCurrent(b.makeBlock(
            {
                b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal{-currentIndex_})}, wasm::Type::none),
                expr,
            },
            wasm::Type::unreachable));
      }
    };

    wasm::Builder b{*m};
    wasm::Type const resultType = func->getResults();
    if (resultType == wasm::Type::none) {
      func->body = b.makeBlock(
          {
              b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal(currentIndex))}, wasm::Type::none, false),
              func->body,
              b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal(-currentIndex))}, wasm::Type::none, false),
          },
          func->getResults());
      ReturnWithoutResultReplacer returnReplacer{currentIndex};
      returnReplacer.walkFunctionInModule(func, m);
    } else {
      wasm::Index const scratchReturnValueLocalIndex = wasm::Builder::addVar(func, resultType);
      func->body = b.makeBlock(
          {
              b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal(currentIndex))}, wasm::Type::none, false),
              b.makeLocalSet(scratchReturnValueLocalIndex, func->body),
              b.makeCall(tracePointFunctionName, {b.makeConst(wasm::Literal(-currentIndex))}, wasm::Type::none, false),
              b.makeLocalGet(scratchReturnValueLocalIndex, resultType),
          },
          func->getResults());
      ReturnWithResultReplacer returnReplacer{scratchReturnValueLocalIndex, currentIndex, resultType};
      returnReplacer.walkFunctionInModule(func, m);
    }
  }
};

struct TracePointInserter : public wasm::Pass {
  std::string const tracePointMappingFile_;
  explicit TracePointInserter(std::string const &tracePointMappingFile)
      : tracePointMappingFile_(tracePointMappingFile) {}
  void run(wasm::Module *m) override {
    wasm::Builder const b{*m};
    if (m->getFunctionOrNull(tracePointFunctionName) == nullptr) {
      std::unique_ptr<wasm::Function> func = wasm::Builder::makeFunction(
          tracePointFunctionName, wasm::Signature{wasm::Type::i32, wasm::Type::none}, {}, nullptr);
      func->module = "builtin";
      func->base = "tracePoint";
      m->addFunction(std::move(func));
    }
    FunctionIndexMap const functionIndexes = FunctionIndexMap::create(m);

    wasm::PassRunner runner{getPassRunner()};
    runner.add(std::unique_ptr<wasm::Pass>(new TracingInserter(functionIndexes)));
    runner.run();

    if (!tracePointMappingFile_.empty()) {
      std::ofstream of{tracePointMappingFile_, std::ios::out};
      ensureFileDirectory(tracePointMappingFile_);
      functionIndexes.forEach([&](wasm::Function *func, size_t index) { of << index << " " << func->name << "\n"; });
    }
  }
};

struct TracePointInserterPlaceHolder : public wasm::Pass {
  bool modifiesBinaryenIR() override { return false; }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<wasm::Pass> create() override {
    return std::unique_ptr<wasm::Pass>{new TracePointInserterPlaceHolder()};
  }
  void run([[maybe_unused]] wasm::Module *m) override {}
  void runOnFunction([[maybe_unused]] wasm::Module *m, [[maybe_unused]] wasm::Function *func) override {}
};

} // namespace
} // namespace warpo::passes

namespace warpo {

static cli::Opt<std::string> tracePointMappingOption{
    cli::Category::Transformation,
    "--trace-point-mapping-file",
    [](argparse::Argument &arg) -> void { arg.help("File to write the trace output to."); },
};

wasm::Pass *passes::createInsertTracePointPass() {
  std::string const &tracePointMappingFile = tracePointMappingOption.get();
  if (tracePointMappingFile.empty())
    return new TracePointInserterPlaceHolder();
  return new TracePointInserter(tracePointMappingFile);
}

} // namespace warpo

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "Runner.hpp"
#include "helper/Matcher.hpp"
#include "pass.h"

namespace warpo::passes::ut {
namespace {

TEST(TracePointInserterTest, WithoutResult) {
  auto m = loadWat(R"(
    (module
      (func $empty)
      (func $fn_without_result
        call $empty
        call $empty
        call $empty
        call $empty
      )
    )
  )");

  wasm::Function *const fn = m->getFunction("fn_without_result");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new TracePointInserter(tracePointMappingOption.get())});
  runner.run();

  using namespace matcher;
  auto const match = isBlock(block::list(allOf({
      has(3),
      at(0, isCall(call::callee(tracePointFunctionName), call::operands(allOf({at(0, isConst())})))),
      at(1, isBlock(block::list(allOf({
                has(4),
                at(0, isCall(call::callee("empty"))),
                at(1, isCall(call::callee("empty"))),
                at(2, isCall(call::callee("empty"))),
                at(3, isCall(call::callee("empty"))),
            })))),
      at(2, isCall(call::callee(tracePointFunctionName), call::operands(allOf({at(0, isConst())})))),
  })));

  EXPECT_TRUE(match(*fn->body));
}

TEST(TracePointInserterTest, WithResult) {
  auto m = loadWat(R"(
    (module
      (func $empty)
      (func $fn_with_result (result i32)
        call $empty
        call $empty
        call $empty
        i32.const 10
      )
    )
  )");

  wasm::Function *const fn = m->getFunction("fn_with_result");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new TracePointInserter(tracePointMappingOption.get())});
  runner.run();

  using namespace matcher;
  auto const match = isBlock(block::list(allOf({
      has(4),
      at(0, isCall(call::callee(tracePointFunctionName), call::operands(allOf({at(0, isConst())})))),
      at(1, isLocalSet(local_set::v(isBlock(block::list(allOf({
                has(4),
                at(0, isCall(call::callee("empty"))),
                at(1, isCall(call::callee("empty"))),
                at(2, isCall(call::callee("empty"))),
                at(3, isConst()),
            })))))),
      at(2, isCall(call::callee(tracePointFunctionName), call::operands(allOf({at(0, isConst())})))),
      at(3, isLocalGet()),
  })));

  EXPECT_TRUE(match(*fn->body));
}

TEST(TracePointInserterTest, CallImport) {
  auto m = loadWat(R"(
    (module
      (import "env" "empty" (func $empty))
      (func $fn_call_import
        call $empty
      )
    )
  )");

  wasm::Function *const fn = m->getFunction("fn_call_import");

  wasm::PassRunner runner{m.get()};
  runner.add(std::unique_ptr<wasm::Pass>{new TracePointInserter(tracePointMappingOption.get())});
  runner.run();

  using namespace matcher;
  auto const match = isBlock(block::list(allOf({
      has(3),
      at(0, isCall(call::callee(tracePointFunctionName), call::operands(at(0, isConst())))),
      at(1, isBlock(block::list(allOf({
                has(3),
                at(0, isCall(call::callee(tracePointFunctionName))),
                at(1, isCall(call::callee("empty"))),
                at(2, isCall(call::callee(tracePointFunctionName))),
            })))),
      at(2, isCall(call::callee(tracePointFunctionName), call::operands(at(0, isConst())))),
  })));

  EXPECT_TRUE(match(*fn->body));
}

} // namespace
} // namespace warpo::passes::ut

#endif
