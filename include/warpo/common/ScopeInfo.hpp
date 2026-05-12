// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <memory>
#include <vector>

#include "LocalInfo.hpp"

namespace warpo {

class ScopeInfo {
public:
  enum class Kind { Block, SubProgram };

  Kind getKind() const noexcept { return kind_; }

  std::vector<std::unique_ptr<ScopeInfo>> const &getChildren() const noexcept { return children_; }
  std::vector<LocalInfo> const &getLocals() const noexcept { return locals_; }

  void addLocal(LocalInfo local) noexcept { locals_.push_back(std::move(local)); }

  ScopeInfo &addChild(std::unique_ptr<ScopeInfo> child) noexcept {
    ScopeInfo &ref = *child;
    children_.push_back(std::move(child));
    return ref;
  }

  virtual ~ScopeInfo() = default;

  ScopeInfo(ScopeInfo const &) = delete;
  ScopeInfo &operator=(ScopeInfo const &) = delete;
  ScopeInfo(ScopeInfo &&) = default;
  ScopeInfo &operator=(ScopeInfo &&) = default;

protected:
  explicit ScopeInfo(Kind const k) noexcept : kind_(k) {}

private:
  Kind kind_;
  std::vector<std::unique_ptr<ScopeInfo>> children_;
  std::vector<LocalInfo> locals_;
};

} // namespace warpo
