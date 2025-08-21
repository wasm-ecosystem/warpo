#pragma once

#include <cstddef>
#include <optional>

#include "SSAObj.hpp"
#include "support/DynBitSet.hpp"
#include "wasm.h"

namespace warpo::passes::gc {

/// @brief SSA value liveness information at a specific expr in the function.
class Liveness {
  DynBitset before_;
  DynBitset after_;

public:
  explicit Liveness(size_t size, DynBitset invalid) : before_(size), after_(size) {}
  void setBefore(size_t index, bool isLive) { before_.set(index, isLive); }
  void setAfter(size_t index, bool isLive) { after_.set(index, isLive); }
  DynBitset const &before() const { return before_; }
  DynBitset const &after() const { return after_; }

  void applyInvalid(DynBitset const &invalid) {
    before_ &= ~invalid;
    after_ &= ~invalid;
  }
};

struct LivenessMap {
  LivenessMap() : storage_(0U), map_{}, dimension_(0), invalid_(0) {}
  explicit LivenessMap(SSAMap const &ssaMap)
      : storage_(0U), map_{}, dimension_(ssaMap.size()), invalid_(ssaMap.size()) {}
  enum class Pos { Before, After };
  void set(size_t base, Pos pos, size_t index, bool isLive) {
    storage_.set((2 * base + (pos == Pos::Before ? 0 : 1)) * dimension_ + index, isLive);
  }
  void set(wasm::Expression *expr, Pos pos, size_t index, bool isLive) {
    set(getIndexBase(expr).value(), pos, index, isLive);
  }
  bool get(ssize_t base, Pos pos, size_t index) const {
    return storage_.get((2 * base + (pos == Pos::Before ? 0 : 1)) * dimension_ + index);
  }
  void ensureExpression(wasm::Expression *expr) {
    if (map_.contains(expr))
      return;
    map_.insert(expr);
    storage_.resize(storage_.size() + dimension_ * 2);
  }
  size_t getDimension() const { return dimension_; }
  std::optional<size_t> getIndexBase(wasm::Expression *expr) const {
    if (!map_.contains(expr))
      return std::nullopt;
    return map_.getIndex(expr);
  }
  std::optional<Liveness> getLiveness(wasm::Expression *expr) const;
  Liveness getLiveness(size_t exprIndex) const;

  void setInvalid(DynBitset invalid) { invalid_ |= invalid; }

  void dump(wasm::Function *func) const;

  enum class MergeOperator { OR };
  void mergeByColumns(size_t targetColumn, size_t sourceColumn, MergeOperator op);

  IncMap<wasm::Expression *> const &getExprMap() const { return map_; }

  DynBitset storage_;

  size_t getValidDimension() const { return dimension_ - invalid_.count(); }

private:
  IncMap<wasm::Expression *> map_;
  size_t dimension_;
  DynBitset invalid_;
};

/// @brief colored vector for SSA values
class ColorVec : private std::vector<size_t> {
  static constexpr size_t InvalidColor = -1;

public:
  explicit ColorVec(size_t dim) { resize(dim, InvalidColor); }
  size_t getColor(size_t ssaIndex) const { return (*this)[ssaIndex]; }
  size_t setColor(size_t ssaIndex, size_t color) { return (*this)[ssaIndex] = color; }
  bool hasColor(size_t ssaIndex) const { return getColor(ssaIndex) != InvalidColor; }
  void dump() const;
};

/// @brief conflict graph for SSA values
class ConflictGraph {
  DynBitset conflictAdjacencyMatrix_;
  size_t dim_;

public:
  explicit ConflictGraph(size_t nodeCount) : conflictAdjacencyMatrix_(nodeCount * nodeCount), dim_(nodeCount) {}
  void addEdge(size_t a, size_t b) {
    conflictAdjacencyMatrix_.set(a * dim_ + b, true);
    conflictAdjacencyMatrix_.set(b * dim_ + a, true);
  }
  bool isAdjacent(size_t a, size_t b) const { return conflictAdjacencyMatrix_.get(a * dim_ + b); }

  ColorVec color() const;

  static ConflictGraph create(LivenessMap const &livenessMap);
  void dump() const;
};

} // namespace warpo::passes::gc
