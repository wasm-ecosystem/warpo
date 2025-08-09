#include <cassert>
#include <cstddef>
#include <cstdlib>
#include <fmt/base.h>
#include <map>
#include <optional>

#include "../helper/Matcher.hpp"
#include "../helper/ToString.hpp"
#include "GCInfo.hpp"
#include "Liveness.hpp"
#include "StackAssigner.hpp"
#include "support/Debug.hpp"
#include "support/Err.hpp"
#include "support/Range.hpp"
#include "wasm-traversal.h"
#include "wasm.h"

#define PASS_NAME "STACK_ASSIGNER"

namespace warpo::passes::gc {

namespace {

struct IAssigner {
  static constexpr const size_t ShadowStackElementSize = 4U;
  virtual ~IAssigner() = default;
  virtual size_t getStackPosition(size_t ssaIndex) = 0;
};

struct GreedyAssigner : public IAssigner {
  ColorVec const &color_;
  GreedyAssigner(ColorVec const &color) : color_(color) {}
  size_t getStackPosition(size_t ssaIndex) override { return color_.getColor(ssaIndex) * ShadowStackElementSize; }
};

struct VanillaAssigner : public IAssigner {
  std::map<size_t, size_t> map_;
  size_t getStackPosition(size_t ssaIndex) override {
    if (map_.contains(ssaIndex))
      return map_.at(ssaIndex) * ShadowStackElementSize;
    size_t const cnt = map_.size();
    map_.insert_or_assign(ssaIndex, cnt);
    return cnt * ShadowStackElementSize;
  }
};

struct Process : public wasm::PostWalker<Process, wasm::UnifiedExpressionVisitor<Process>> {
  IAssigner &assigner_;
  LivenessMap const &livenessMap_;
  StackPosition &stackPosition_;
  Process(IAssigner &assigner, LivenessMap const &livenessMap, StackPosition &stackPosition)
      : assigner_(assigner), livenessMap_(livenessMap), stackPosition_(stackPosition) {}

  Result<wasm::Call *> extractCall(wasm::Expression *expr, Liveness const &l) {
    if (auto set = expr->dynCast<wasm::LocalSet>()) {
      // localtostack
      if (!matcher::isCall(matcher::call::callee(FnLocalToStack))(*set->value)) {
        // some parameter will be treat as GC object by mistake.
        return failed();
      }
      return succeed(set->value->cast<wasm::Call>());
    }
    if (auto call = expr->dynCast<wasm::Call>()) {
      // tmptostack
      if (call->target != FnTmpToStack && call->target != FnLocalToStack) {
        fmt::println("unknown {}: {} -> {}", toString(expr), l.before().toString(), l.after().toString());
        std::abort();
      }
      return succeed(call);
    }
    fmt::println("unknown {}: {} -> {}", toString(expr), l.before().toString(), l.after().toString());
    std::abort();
  };

  void visitExpression(wasm::Expression *expr) {
    std::optional<Liveness> const currentLiveness = livenessMap_.getLiveness(expr);
    if (!currentLiveness.has_value())
      return;
    for (size_t const ssaIndex : Range{livenessMap_.getDimension()}) {
      if (currentLiveness->before().get(ssaIndex) == false && currentLiveness->after().get(ssaIndex) == true) {
        Result<wasm::Call *> const callExpr = extractCall(expr, currentLiveness.value());
        if (callExpr.ok()) {
          assert(!stackPosition_.contains(callExpr.value()) && "call -> store is 1 - 1 mapping");
          stackPosition_.insert_or_assign(callExpr.value(), assigner_.getStackPosition(ssaIndex));
        }
      }
    }
  }
};

} // namespace

static void calStackPositionWithVanillaAlgorithm(wasm::Function *func, StackPosition &stackPosition,
                                                 LivenessMap const &livenessMap) {
  VanillaAssigner assigner{};
  Process process{assigner, livenessMap, stackPosition};
  process.walkFunction(func);
}

static void calStackPositionWithGreedyConflictGraphAlgorithm(wasm::Function *func, StackPosition &stackPosition,
                                                             LivenessMap const &livenessMap) {
  ConflictGraph const conflictGraph = ConflictGraph::create(livenessMap);
  ColorVec const color = conflictGraph.color();
  if (support::isDebug(PASS_NAME, func->name.str)) {
    fmt::println("=========ConflictGraph=========");
    fmt::println("{}", func->name.str);
    conflictGraph.dump();
    color.dump();
    fmt::println("===============================");
  }
  GreedyAssigner assigner{color};
  Process process{assigner, livenessMap, stackPosition};
  process.walkFunction(func);
}

void StackAssigner::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition &stackPosition = stackPositions_->at(func);
  LivenessMap const &livenessMap = livenessInfo_->at(func);

  switch (mode_) {
  case Mode::Vanilla:
    calStackPositionWithVanillaAlgorithm(func, stackPosition, livenessMap);
    break;
  case Mode::GreedyConflictGraph:
    calStackPositionWithGreedyConflictGraphAlgorithm(func, stackPosition, livenessMap);
    break;
  }
}

} // namespace warpo::passes::gc
