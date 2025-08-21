#ifndef PASSES_GC_TOSTACKLOWER_HPP
#define PASSES_GC_TOSTACKLOWER_HPP

#include <fmt/base.h>
#include <fmt/format.h>
#include <memory>
#include <optional>

#include "ShrinkWrap.hpp"
#include "StackAssigner.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

// localtostack/tmptostack => tostack(v, i32.const offset)
// insert to begin => decrease SP
// insert to end => increase SP
struct ToStackCallLower : public wasm::Pass {
  std::shared_ptr<gc::StackInsertPoints const> stackInsertPositions_;
  std::shared_ptr<StackPositions const> stackPositions_;
  explicit ToStackCallLower(std::shared_ptr<gc::StackInsertPoints const> stackInsertPositions,
                            std::shared_ptr<StackPositions const> const &stackPositions)
      : stackInsertPositions_(stackInsertPositions), stackPositions_(stackPositions) {
    name = "LowerToStackCall";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override {
    return std::make_unique<ToStackCallLower>(stackInsertPositions_, stackPositions_);
  }
  bool modifiesBinaryenIR() override { return true; }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override;

  static wasm::Name getToStackFunctionName(uint32_t offset) {
    return wasm::Name{fmt::format("~lib/rt/__tostack<{}>", offset)};
  }

private:
  uint32_t replaceCallExprrunOnFunction(wasm::Module *m, wasm::Function *func, StackPosition const &stackPosition);
  void replaceReturnExprWithEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                     std::optional<wasm::Index> const &scratchReturnValueLocalIndex);
  bool tryInsertPrologueAndEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                    std::optional<wasm::Index> const &scratchReturnValueLocalIndex,
                                    wasm::Expression *prologue, wasm::Expression *epilogue);
  bool tryInsertPrologue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                         std::optional<wasm::Index> const &scratchReturnValueLocalIndex, wasm::Expression *prologue);
  void insertDefaultPrologueAndEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                                        std::optional<wasm::Index> const &scratchReturnValueLocalIndex);
  void insertDefaultEpilogue(wasm::Module *m, wasm::Function *func, uint32_t maxShadowStackOffset,
                             std::optional<wasm::Index> const &scratchReturnValueLocalIndex);
};

} // namespace warpo::passes::gc

#endif // PASSES_GC_TOSTACKLOWER_HPP
