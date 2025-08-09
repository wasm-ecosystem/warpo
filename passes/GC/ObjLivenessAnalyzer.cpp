#include <cassert>
#include <cstdlib>
#include <fmt/base.h>
#include <fmt/ranges.h>
#include <iostream>
#include <map>
#include <optional>
#include <ostream>
#include <sstream>
#include <string>
#include <vector>

#include "../helper/BuildCFG.hpp"
#include "../helper/Powerset.hpp"
#include "GCInfo.hpp"
#include "ObjLivenessAnalyzer.hpp"
#include "SSAObj.hpp"
#include "analysis/cfg.h"
#include "analysis/monotone-analyzer.h"
#include "analysis/visitor-transfer-function.h"
#include "support/Debug.hpp"
#include "support/DynBitSet.hpp"
#include "support/MultipleMap.hpp"
#include "support/Range.hpp"
#include "support/index.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "ObjLivenessAnalyzer"
#define DEBUG_PREFIX "[ObjLivenessAnalyzer] "

namespace warpo::passes::gc {
namespace {

struct LocalToSSALookupTable : private std::map<size_t, std::vector<size_t>> {
  static LocalToSSALookupTable create(SSAMap const &ssaMap) {
    LocalToSSALookupTable ret{};
    for (auto &[ssa, index] : ssaMap) {
      std::optional<wasm::Index> const localIndex = ssa.tryGetLocalIndex();
      if (localIndex.has_value())
        ret.try_emplace(localIndex.value(), std::vector<size_t>{}).first->second.push_back(index);
    }
    return ret;
  }
  std::vector<size_t> const &getSSAMapIndexs(wasm::Index localIndex) const {
    static std::vector<size_t> const empty{};
    if (contains(localIndex))
      return at(localIndex);
    return empty;
  }
};

/// @brief which value is used in LocalGet
struct LocalsUses : private MultipleMap<wasm::LocalGet *, size_t> {
  static LocalsUses create(wasm::Function *func, SSAMap const &ssaMap, wasm::analysis::CFG &cfg);
  using S = MultipleMap<wasm::LocalGet *, size_t>;
  using S::at;
  using S::begin;
  using S::contains;
  using S::end;
  using S::insert_or_assign;

private:
  friend class LiveLocalTransferFn;
};

/// @brief forward analysis to find out which SSA is lived.
class LiveLocalTransferFn : public wasm::analysis::VisitorTransferFunc<LiveLocalTransferFn, FiniteIntPowersetLattice,
                                                                       wasm::analysis::AnalysisDirection::Forward> {
  using S = wasm::analysis::VisitorTransferFunc<LiveLocalTransferFn, FiniteIntPowersetLattice,
                                                wasm::analysis::AnalysisDirection::Forward>;
  SSAMap const &ssaMap_;
  LocalsUses &uses_;
  LocalToSSALookupTable localToSSA_;

  static bool isActive(FiniteIntPowersetLattice::Element &s, size_t index) { return s.get(index) == true; }
  static void setActive(FiniteIntPowersetLattice::Element &s, size_t index) { s.set(index, true); }
  static void setInactive(FiniteIntPowersetLattice::Element &s, size_t index) { s.set(index, false); }

public:
  FiniteIntPowersetLattice lattice_;

  explicit LiveLocalTransferFn(wasm::Function *func, SSAMap const &ssaMap, LocalsUses &uses)
      : S{}, lattice_(ssaMap.size()), ssaMap_(ssaMap), uses_(uses), localToSSA_(LocalToSSALookupTable::create(ssaMap)) {
  }

  void evaluateFunctionEntry(wasm::Function *func, FiniteIntPowersetLattice::Element &element) {
    for (wasm::Index paramIndex : Range{func->getNumParams()}) {
      if (func->getParams()[paramIndex] == wasm::Type::i32) {
        setActive(element, ssaMap_.getIndex(SSAValue{paramIndex}));
      }
    }
  }
  void visitLocalGet(wasm::LocalGet *expr) {
    if (collectingResults) {
      for (size_t const index : localToSSA_.getSSAMapIndexs(expr->index)) {
        if (isActive(*currState, index))
          uses_.insert_or_assign(expr, index);
      }
    }
  }
  void visitLocalSet(wasm::LocalSet *expr) {
    for (size_t const index : localToSSA_.getSSAMapIndexs(expr->index))
      setInactive(*currState, index);
    SSAValue const value{expr};
    if (ssaMap_.contains(value))
      setActive(*currState, ssaMap_.getIndex(value));
  }
};

LocalsUses LocalsUses::create(wasm::Function *func, SSAMap const &ssaMap, wasm::analysis::CFG &cfg) {
  LocalsUses uses;
  LiveLocalTransferFn transfer{func, ssaMap, uses};
  using Analyzer = wasm::analysis::MonotoneCFGAnalyzer<FiniteIntPowersetLattice, LiveLocalTransferFn>;
  Analyzer analyzer{transfer.lattice_, transfer, cfg};
  analyzer.evaluateFunctionEntry(func);
  analyzer.evaluateAndCollectResults();
  return uses;
}

// uses of temporary SSA values
struct TmpUses : private std::map<wasm::Expression *, std::vector<size_t>> {
  static TmpUses create(wasm::Function *func, SSAMap const &ssaMap);
  using S = std::map<wasm::Expression *, std::vector<size_t>>;
  using S::at;
  using S::contains;
};

TmpUses TmpUses::create(wasm::Function *func, SSAMap const &ssaMap) {
  struct Collector : public wasm::ExpressionStackWalker<Collector> {
    TmpUses &tmpUses_;
    SSAMap const &ssaMap_;
    explicit Collector(TmpUses &tmpUses, SSAMap const &ssaMap) : tmpUses_(tmpUses), ssaMap_(ssaMap) {}
    void visitCall(wasm::Call *expr) {
      if (expr->target == FnTmpToStack) {
        assert(ssaMap_.contains(SSAValue{expr}));
        for (size_t index : Range<-1>{expressionStack.size() - 1, 0}) {
          wasm::Expression *const current = expressionStack[index];
          wasm::Expression *const parent = expressionStack[index - 1];
          if (parent->is<wasm::Block>() || parent->is<wasm::Loop>() ||
              (parent->is<wasm::If>() && parent->cast<wasm::If>()->condition != current)) {
            // skip control flow opcode
            continue;
          }
          tmpUses_.try_emplace(parent, std::vector<size_t>{}).first->second.push_back(ssaMap_.getIndex(SSAValue{expr}));
          return;
        }
        // as function return value
        tmpUses_.try_emplace(nullptr, std::vector<size_t>{}).first->second.push_back(ssaMap_.getIndex(SSAValue{expr}));
        return;
      }
      if (expr->target == FnLocalToStack) {
        if (!getParent()->is<wasm::LocalSet>()) {
          assert(false && "LocalToStack should not be used in other place");
          std::abort();
        }
        return;
      }
    }
  };
  TmpUses tmpUses{};
  Collector collector{tmpUses, ssaMap};
  collector.walkFunction(func);
  return tmpUses;
}

class SSALivenessForwardTFn
    : public wasm::analysis::VisitorTransferFunc<SSALivenessForwardTFn, FiniteIntPowersetLattice,
                                                 wasm::analysis::AnalysisDirection::Forward> {
  using S = wasm::analysis::VisitorTransferFunc<SSALivenessForwardTFn, FiniteIntPowersetLattice,
                                                wasm::analysis::AnalysisDirection::Forward>;
  SSAMap const &ssaMap_;
  LivenessMap &livenessMap_;

  bool isActive(size_t index) { return currState->get(index) == true; }
  void setActive(size_t index) { currState->set(index, true); }

public:
  FiniteIntPowersetLattice lattice_;
  explicit SSALivenessForwardTFn(SSAMap const &ssaMap, LivenessMap &livenessMap)
      : ssaMap_(ssaMap), livenessMap_(livenessMap), lattice_(ssaMap.size()) {}

  void evaluateFunctionEntry(wasm::Function *func, FiniteIntPowersetLattice::Element &element) {
    currState = &element;
    for (wasm::Index paramIndex : Range{func->getNumParams()}) {
      if (func->getParams()[paramIndex] == wasm::Type::i32) {
        // parameters
        setActive(ssaMap_.getIndex(SSAValue{paramIndex}));
      }
    }
    currState = nullptr;
  }

  void visitLocalSet(wasm::LocalSet *expr) {
    // local
    if (ssaMap_.contains(SSAValue{expr}))
      setActive(ssaMap_.getIndex(SSAValue{expr}));
  }
  void visitCall(wasm::Call *expr) {
    // tmp
    if (ssaMap_.contains(SSAValue{expr}))
      setActive(ssaMap_.getIndex(SSAValue{expr}));
  }

  void visit(wasm::Expression *expr) {
    if (collectingResults && livenessMap_.getExprMap().contains(expr)) {
      size_t const base = livenessMap_.getIndexBase(expr).value();
      for (size_t index : Range{ssaMap_.size()})
        livenessMap_.set(base, LivenessMap::Pos::Before, index, isActive(index));
      S::visit(expr);
      for (size_t index : Range{ssaMap_.size()})
        livenessMap_.set(base, LivenessMap::Pos::After, index, isActive(index));
    } else {
      S::visit(expr);
    }
  }
};

class SSALivenessBackwardTFn
    : public wasm::analysis::VisitorTransferFunc<SSALivenessBackwardTFn, FiniteIntPowersetLattice,
                                                 wasm::analysis::AnalysisDirection::Backward> {
  using S = wasm::analysis::VisitorTransferFunc<SSALivenessBackwardTFn, FiniteIntPowersetLattice,
                                                wasm::analysis::AnalysisDirection::Backward>;
  SSAMap const &ssaMap_;
  LocalsUses const &localUses_;
  TmpUses const &tmpUses_;
  LivenessMap &livenessMap_;

  bool isActive(size_t index) const { return currState->get(index) == true; }
  void setActive(size_t index) { currState->set(index, true); }
  void setInactive(size_t index) { currState->set(index, false); }

  void visitImpl(wasm::Expression *expr) {
    handleTmpUses(expr);
    S::visit(expr);
  }
  void handleTmpUses(wasm::Expression *expr) {
    if (tmpUses_.contains(expr))
      for (size_t const index : tmpUses_.at(expr))
        setActive(index);
  }

public:
  FiniteIntPowersetLattice lattice_;
  explicit SSALivenessBackwardTFn(SSAMap const &ssaMap, LocalsUses const &localUses, TmpUses const &tmpUses,
                                  LivenessMap &livenessMap)
      : ssaMap_(ssaMap), localUses_(localUses), tmpUses_(tmpUses), livenessMap_(livenessMap), lattice_(ssaMap.size()) {}

  void evaluateFunctionExit(wasm::Function *func, FiniteIntPowersetLattice::Element &element) {
    currState = &element;
    handleTmpUses(nullptr);
    currState = nullptr;
  }

  void visitLocalGet(wasm::LocalGet *expr) {
    if (localUses_.contains(expr))
      for (size_t const &index : localUses_.at(expr))
        setActive(index);
  }
  void visitLocalSet(wasm::LocalSet *expr) {
    // local
    if (ssaMap_.contains(SSAValue{expr}))
      setInactive(ssaMap_.getIndex(SSAValue{expr}));
  }
  void visitCall(wasm::Call *expr) {
    // tmp
    if (ssaMap_.contains(SSAValue{expr}))
      setInactive(ssaMap_.getIndex(SSAValue{expr}));
  }

  void visit(wasm::Expression *expr) {
    if (collectingResults && livenessMap_.getExprMap().contains(expr)) {
      size_t const base = livenessMap_.getIndexBase(expr).value();
      for (size_t index : Range{ssaMap_.size()})
        livenessMap_.set(base, LivenessMap::Pos::After, index, isActive(index));
      visitImpl(expr);
      for (size_t index : Range{ssaMap_.size()})
        livenessMap_.set(base, LivenessMap::Pos::Before, index, isActive(index));
    } else {
      visitImpl(expr);
    }
  }
};
static void updateLivenessInfo(wasm::Function *func, LivenessMap &livenessMap, LocalsUses const &localUses,
                               TmpUses const &tmpUses, SSAMap const &ssaMap, wasm::analysis::CFG &cfg) {
  SSALivenessForwardTFn forwardFn{ssaMap, livenessMap};
  using ForwardAnalyzer = wasm::analysis::MonotoneCFGAnalyzer<FiniteIntPowersetLattice, SSALivenessForwardTFn>;
  ForwardAnalyzer forwardAnalyzer{forwardFn.lattice_, forwardFn, cfg};
  forwardAnalyzer.evaluateFunctionEntry(func);
  forwardAnalyzer.evaluateAndCollectResults();
  // reset liveness map
  DynBitset const forwardBitSet = std::move(livenessMap.storage_);
  livenessMap.storage_ = DynBitset{forwardBitSet.size()};

  SSALivenessBackwardTFn backwardFn{ssaMap, localUses, tmpUses, livenessMap};
  using BackwardAnalyzer = wasm::analysis::MonotoneCFGAnalyzer<FiniteIntPowersetLattice, SSALivenessBackwardTFn>;
  BackwardAnalyzer backwardAnalyzer{backwardFn.lattice_, backwardFn, cfg};
  backwardAnalyzer.evaluateFunctionExit(func);
  backwardAnalyzer.evaluateAndCollectResults();

  livenessMap.storage_ &= forwardBitSet; // overlap of forward and backward is the real liveness
}

struct InfoPrinter : public IInfoPrinter {
  LocalsUses const &localsUses_;
  TmpUses const &tmpUses_;
  SSAMap const &ssaMap_;

  explicit InfoPrinter(LocalsUses const &localsUses, TmpUses const &tmpUses, SSAMap const &ssaMap)
      : localsUses_(localsUses), tmpUses_(tmpUses), ssaMap_(ssaMap) {}

  std::optional<std::string> onExpr(wasm::Expression *expr) override {
    std::stringstream ss;
    // ssa
    std::optional<size_t> const index = ssaMap_.tryGetIndexFromExpr(expr);
    if (index.has_value()) {
      ss << "[ssa " << index.value() << "] ";
    }
    // use
    if (auto get = expr->dynCast<wasm::LocalGet>()) {
      if (localsUses_.contains(get)) {
        ss << "[local use: ";
        for (size_t const &index : localsUses_.at(get)) {
          ss << index << " ";
        }
        ss << "] ";
      }
    }
    if (tmpUses_.contains(expr)) {
      ss << "[tmp use: ";
      for (size_t const &index : tmpUses_.at(expr)) {
        ss << index << " ";
      }
      ss << "] ";
    }
    std::string s = ss.str();
    if (s.empty())
      return std::nullopt;
    return s;
  }
};

void dumpInfo(wasm::Module *m, wasm::Function *func, LocalsUses const &localsUses, TmpUses const &tmpUses,
              SSAMap const &ssaMap) {
  CFG const cfg = CFG::fromFunction(func);
  InfoPrinter infoPrinter{localsUses, tmpUses, ssaMap};
  cfg.print(std::cout, nullptr, infoPrinter);
}

} // namespace

void ObjLivenessAnalyzer::runOnFunction(wasm::Module *m, wasm::Function *func) {
  SSAMap const &ssaMap = moduleLevelSSAMap_.at(func);
  wasm::analysis::CFG cfg = wasm::analysis::CFG::fromFunction(func);

  LocalsUses const localsUses = LocalsUses::create(func, ssaMap, cfg);
  TmpUses const tmpUses = TmpUses::create(func, ssaMap);

  LivenessMap &livenessMap = info_->at(func);
  livenessMap = LivenessMap{ssaMap};

  for (wasm::analysis::BasicBlock const &bb : cfg) {
    for (wasm::Expression *expr : bb) {
      if (expr->is<wasm::Call>() || expr->is<wasm::CallIndirect>() || expr->is<wasm::LocalGet>() ||
          expr->is<wasm::LocalSet>() || tmpUses.contains(expr)) {
        livenessMap.ensureExpression(expr);
      }
    }
  }

  updateLivenessInfo(func, livenessMap, localsUses, tmpUses, ssaMap, cfg);

  if (support::isDebug(PASS_NAME, func->name.str)) {
    std::cout << "================== " << func->name << " liveness analysis ===============\n";
    dumpInfo(m, func, localsUses, tmpUses, ssaMap);
    std::cout << "\n============\n";
    livenessMap.dump(func);
    std::cout << "=================================\n";
  }
}

} // namespace warpo::passes::gc
