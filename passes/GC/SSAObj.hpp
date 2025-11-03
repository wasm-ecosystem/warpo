// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <map>

#include "warpo/support/DynBitSet.hpp"
#include "warpo/support/IncMap.hpp"
#include "warpo/support/Unreachable.hpp"
#include "wasm.h"

namespace warpo::passes::gc {

struct SSAValue {
  enum class Kind { Local, Tmp, Arg };
  union Value {
    wasm::LocalSet *local;
    wasm::Call *tmp;
    wasm::Index arg;
  };

  Kind kind_;
  Value value_;
  SSAValue() = default;
  explicit SSAValue(wasm::LocalSet *set) : kind_(Kind::Local), value_{.local = set} {}
  explicit SSAValue(wasm::Call *tmp) : kind_(Kind::Tmp), value_{.tmp = tmp} {}
  explicit SSAValue(wasm::Index paramIndex) : kind_(Kind::Arg), value_{.arg = paramIndex} {}
  std::strong_ordering operator<=>(SSAValue const &other) const {
    if (kind_ == other.kind_) {
      switch (kind_) {
      case Kind::Local:
        return value_.local <=> other.value_.local;
      case Kind::Tmp:
        return value_.tmp <=> other.value_.tmp;
      case Kind::Arg:
        return value_.arg <=> other.value_.arg;
      default:
        UNREACHABLE;
      }
    } else {
      return kind_ <=> other.kind_;
    }
  }
  wasm::Index getLocalIndex() const {
    switch (kind_) {
    case Kind::Local:
      return value_.local->index;
    case Kind::Arg:
      return value_.arg;
    default:
      UNREACHABLE;
    }
  }
  std::optional<wasm::Index> tryGetLocalIndex() const {
    switch (kind_) {
    case Kind::Local:
      return value_.local->index;
    case Kind::Arg:
      return value_.arg;
    default:
      return std::nullopt;
    }
  }
};

struct SSAMap : public IncBiMap<SSAValue> {
  static SSAMap create(wasm::Function *func);
  std::optional<size_t> tryGetIndexFromExpr(wasm::Expression *expr) const {
    if (auto set = expr->dynCast<wasm::LocalSet>()) {
      if (!this->contains(SSAValue{set}))
        return std::nullopt;
      return this->getIndex(SSAValue{set});
    } else if (auto call = expr->dynCast<wasm::Call>()) {
      if (!this->contains(SSAValue{call}))
        return std::nullopt;
      return this->getIndex(SSAValue{call});
    }
    return std::nullopt;
  }
  DynBitset getCallerManagedObject() const;
};

struct ModuleLevelSSAMap : public std::map<wasm::Function *, SSAMap> {
  static ModuleLevelSSAMap create(wasm::Module *m) {
    ModuleLevelSSAMap ssaMapModule{};
    for (auto &func : m->functions) {
      ssaMapModule[func.get()] = SSAMap::create(func.get());
    }
    return ssaMapModule;
  }
};

} // namespace warpo::passes::gc
