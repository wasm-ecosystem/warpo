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

#include "../BuildCFG.hpp"
#include "../Powerset.hpp"
#include "GCInfo.hpp"
#include "ObjLivenessAnalyzer.hpp"
#include "SSAObj.hpp"
#include "analysis/lattices/inverted.h"
#include "analysis/monotone-analyzer.h"
#include "analysis/visitor-transfer-function.h"
#include "support/Debug.hpp"
#include "support/MultipleMap.hpp"
#include "support/Range.hpp"
#include "support/index.h"
#include "wasm-traversal.h"
#include "wasm-type.h"
#include "wasm.h"

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

// after this LocalGet, corresponding SSA value is not used anymore
struct LocalsLastUses : private MultipleMap<wasm::LocalGet *, size_t> {
  static LocalsLastUses create(wasm::Function *func, SSAMap const &ssaMap, wasm::analysis::CFG &cfg);
  using S = MultipleMap<wasm::LocalGet *, size_t>;
  using S::at;
  using S::begin;
  using S::contains;
  using S::end;
  using S::insert_or_assign;
};

/// @brief backward analysis to find the last use of each SSA
class LocalsLastUsesTransferFn
    : public wasm::analysis::VisitorTransferFunc<LocalsLastUsesTransferFn,
                                                 wasm::analysis::Inverted<FiniteIntPowersetLattice>,
                                                 wasm::analysis::AnalysisDirection::Backward> {
  using S =
      wasm::analysis::VisitorTransferFunc<LocalsLastUsesTransferFn, wasm::analysis::Inverted<FiniteIntPowersetLattice>,
                                          wasm::analysis::AnalysisDirection::Backward>;
  LocalsUses const &localUses_;
  SSAMap const &ssaMap_;
  LocalsLastUses &localsLastUses_;

  bool isActive(size_t index) const { return currState->get(index) == true; }
  bool isInactive(size_t index) const { return currState->get(index) == false; }
  void setActive(size_t index) { currState->set(index, true); }
  void setInactive(size_t index) { currState->set(index, false); }

public:
  FiniteIntPowersetLattice lattice_;
  explicit LocalsLastUsesTransferFn(LocalsUses const &localUses, SSAMap const &ssaMap, LocalsLastUses &localsLastUses)
      : localUses_(localUses), ssaMap_(ssaMap), localsLastUses_(localsLastUses), lattice_(ssaMap.size()) {}

  void visitLocalGet(wasm::LocalGet *expr) {
    if (!localUses_.contains(expr))
      return;
    if (collectingResults) {
      for (size_t const &index : localUses_.at(expr)) {
        // inactive -> active => last use
        if (isInactive(index))
          localsLastUses_.insert_or_assign(expr, index);
      }
    }
    for (size_t const &index : localUses_.at(expr))
      setActive(index);
  }
  void visitLocalSet(wasm::LocalSet *expr) {
    if (!ssaMap_.contains(SSAValue{expr}))
      return;
    setInactive(ssaMap_.getIndex(SSAValue{expr}));
  }
  void visitCall(wasm::Call *expr) {
    if (!ssaMap_.contains(SSAValue{expr}))
      return;
    setInactive(ssaMap_.getIndex(SSAValue{expr}));
  }
};

LocalsLastUses LocalsLastUses::create(wasm::Function *func, SSAMap const &ssaMap, wasm::analysis::CFG &cfg) {
  LocalsUses localsUses = LocalsUses::create(func, ssaMap, cfg);
  LocalsLastUses uses;
  LocalsLastUsesTransferFn transfer{localsUses, ssaMap, uses};
  using Analyzer = wasm::analysis::MonotoneCFGAnalyzer<FiniteIntPowersetLattice, LocalsLastUsesTransferFn>;
  Analyzer analyzer{transfer.lattice_, transfer, cfg};
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

class SSALivenessTransferFn
    : public wasm::analysis::VisitorTransferFunc<SSALivenessTransferFn, FiniteIntPowersetLattice,
                                                 wasm::analysis::AnalysisDirection::Forward> {
  using S = wasm::analysis::VisitorTransferFunc<SSALivenessTransferFn, FiniteIntPowersetLattice,
                                                wasm::analysis::AnalysisDirection::Forward>;
  LocalsLastUses const &localsLastUses_;
  TmpUses const &tmpUses_;
  SSAMap const &ssaMap_;
  LivenessMap &livenessMap_;
  LocalToSSALookupTable localToSSA_;

  bool isActive(size_t index) { return currState->get(index) == true; }
  void setActive(size_t index) { currState->set(index, true); }
  void setInactive(size_t index) { currState->set(index, false); }

  void handleTmpUses(wasm::Expression *expr) {
    if (tmpUses_.contains(expr)) {
      for (size_t const index : tmpUses_.at(expr)) {
        setInactive(index);
      }
    }
  }

public:
  FiniteIntPowersetLattice lattice_;
  explicit SSALivenessTransferFn(LocalsLastUses const &localUses, TmpUses const &tmpUses, SSAMap const &ssaMap,
                                 LivenessMap &livenessMap)
      : localsLastUses_(localUses), tmpUses_(tmpUses), ssaMap_(ssaMap), livenessMap_(livenessMap),
        localToSSA_(LocalToSSALookupTable::create(ssaMap)), lattice_(ssaMap.size()) {}

  void evaluateFunctionEntry(wasm::Function *func, FiniteIntPowersetLattice::Element &element) {
    currState = &element;
    for (wasm::Index paramIndex : Range{func->getNumParams()}) {
      if (func->getParams()[paramIndex] == wasm::Type::i32) {
        setActive(ssaMap_.getIndex(SSAValue{paramIndex}));
      }
    }
    currState = nullptr;
  }

  void visitLocalGet(wasm::LocalGet *expr) {
    if (localsLastUses_.contains(expr)) {
      for (size_t const &index : localsLastUses_.at(expr))
        setInactive(index);
    }
  }
  void visitLocalSet(wasm::LocalSet *expr) {
    if (ssaMap_.contains(SSAValue{expr}))
      setActive(ssaMap_.getIndex(SSAValue{expr}));
  }
  void visitCall(wasm::Call *expr) {
    if (ssaMap_.contains(SSAValue{expr}))
      setActive(ssaMap_.getIndex(SSAValue{expr}));
  }
  void visitImpl(wasm::Expression *expr) {
    handleTmpUses(expr);
    S::visit(expr);
  }
  bool isTarget(wasm::Expression *expr) const {
    if (expr->is<wasm::Call>())
      return true;
    if (expr->is<wasm::CallIndirect>())
      return true;
    if (expr->is<wasm::LocalGet>())
      return true;
    if (expr->is<wasm::LocalSet>())
      return true;
    if (tmpUses_.contains(expr))
      return true;
    return false;
  }

  void visit(wasm::Expression *expr) {
    if (collectingResults && isTarget(expr)) {
      livenessMap_.ensureExpression(expr);
      size_t const base = livenessMap_.getIndexBase(expr).value();
      for (size_t index : Range{ssaMap_.size()})
        livenessMap_.set(base, LivenessMap::Pos::Before, index, isActive(index));
      visitImpl(expr);
      for (size_t index : Range{ssaMap_.size()})
        livenessMap_.set(base, LivenessMap::Pos::After, index, isActive(index));
    } else {
      visitImpl(expr);
    }
  }
};

void updateLivenessInfo(LivenessMap &liveness, LocalsLastUses const &localUses, TmpUses const &tmpUses,
                        SSAMap const &ssaMap, wasm::analysis::CFG &cfg) {
  SSALivenessTransferFn fn{localUses, tmpUses, ssaMap, liveness};
  using Analyzer = wasm::analysis::MonotoneCFGAnalyzer<FiniteIntPowersetLattice, SSALivenessTransferFn>;
  Analyzer analyzer{fn.lattice_, fn, cfg};
  analyzer.evaluateAndCollectResults();
}

struct InfoPrinter : public IInfoPrinter {
  // TODO: merge same code
  LocalsLastUses const &localsLastUses_;
  TmpUses const &tmpUses_;
  SSAMap const &ssaMap_;

  explicit InfoPrinter(LocalsLastUses const &localsLastUses, TmpUses const &tmpUses, SSAMap const &ssaMap)
      : localsLastUses_(localsLastUses), tmpUses_(tmpUses), ssaMap_(ssaMap) {}

  std::optional<std::string> onExpr(wasm::Expression *expr) override {
    std::stringstream ss;
    // ssa
    std::optional<size_t> const index = ssaMap_.tryGetIndexFromExpr(expr);
    if (index.has_value()) {
      ss << "[ssa " << index.value() << "] ";
    }
    // use
    if (auto get = expr->dynCast<wasm::LocalGet>()) {
      if (localsLastUses_.contains(get)) {
        ss << "[local last use: ";
        for (size_t const &index : localsLastUses_.at(get)) {
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

void dumpInfo(wasm::Module *m, wasm::Function *func, LocalsLastUses const &localsLastUses, TmpUses const &tmpUses,
              SSAMap const &ssaMap) {
  CFG const cfg = CFG::fromFunction(func);
  InfoPrinter infoPrinter{localsLastUses, tmpUses, ssaMap};
  cfg.print(std::cout, m, infoPrinter);
}

} // namespace

void ObjLivenessAnalyzer::runOnFunction(wasm::Module *m, wasm::Function *func) {
  SSAMap const &ssaMap = moduleLevelSSAMap_.at(func);
  wasm::analysis::CFG cfg = wasm::analysis::CFG::fromFunction(func);

  LocalsLastUses const localsLastUses = LocalsLastUses::create(func, ssaMap, cfg);
  TmpUses const tmpUses = TmpUses::create(func, ssaMap);

  LivenessMap &livenessMap = info_.at(func);
  livenessMap = LivenessMap{ssaMap};

  updateLivenessInfo(livenessMap, localsLastUses, tmpUses, ssaMap, cfg);

  if (support::isDebug()) {
    std::cout << "================== " << func->name << " liveness analysis ===============\n";
    dumpInfo(m, func, localsLastUses, tmpUses, ssaMap);
    std::cout << "\n============\n";
    livenessMap.dump(m, func);
    std::cout << "=================================\n";
  }
}

} // namespace warpo::passes::gc
