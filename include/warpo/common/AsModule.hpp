// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <binaryen/src/binaryen-c.h>
#include <compare>
#include <cstddef>
#include <memory>
#include <set>
#include <utility>

namespace warpo {

class BinaryenModule {
  BinaryenModuleRef ref_;

public:
  BinaryenModule(BinaryenModule const &) = delete;
  BinaryenModule(BinaryenModule &&o) noexcept : ref_(o.ref_) {
    if (&o != this)
      o.ref_ = nullptr;
  }
  BinaryenModule &operator=(BinaryenModule const &) = delete;
  BinaryenModule &operator=(BinaryenModule &&o) noexcept {
    if (&o == this)
      return *this;
    // NOLINTNEXTLINE(misc-misplaced-const)
    BinaryenModuleRef const tmp = ref_;
    ref_ = o.ref_;
    o.ref_ = tmp;
    return *this;
  }

  BinaryenModule() noexcept : BinaryenModule(nullptr) {}
  explicit BinaryenModule(BinaryenModuleRef ref) noexcept : ref_(ref) {}
  ~BinaryenModule() noexcept {
    if (ref_ != nullptr)
      BinaryenModuleDispose(ref_);
  }

  BinaryenModuleRef get() const noexcept { return static_cast<BinaryenModuleRef>(ref_); }

  bool operator==(std::nullptr_t) const { return ref_ == nullptr; }
};

/// range of data elements
class DataElementRange {
public:
  uint32_t begin_;
  uint32_t end_;

  DataElementRange(uint32_t begin, uint32_t end) : begin_(begin), end_(end) {}

  std::partial_ordering operator<=>(DataElementRange const &other) const {
    if (begin_ == other.begin_ && end_ == other.end_)
      return std::partial_ordering::equivalent;
    if (begin_ < other.begin_ && end_ < other.begin_)
      return std::partial_ordering::less;
    if (begin_ > other.end_ && end_ > other.end_)
      return std::partial_ordering::greater;
    return std::partial_ordering::unordered;
  }
};

struct ImmutableDataElementRanges : private std::set<DataElementRange> {
  using std::set<DataElementRange>::insert;
  bool contains(uint32_t offset, uint32_t size) const;
};

class AsModule {
  BinaryenModule raw_;

public:
  std::shared_ptr<ImmutableDataElementRanges> immutableRanges_;
  // TODO: more information fields

  AsModule() = default;
  explicit AsModule(BinaryenModuleRef ref) : raw_{ref}, immutableRanges_{nullptr} {}

  void set(BinaryenModule raw) { raw_ = std::move(raw); }
  BinaryenModuleRef get() const { return raw_.get(); }
  bool valid() const { return raw_ != nullptr; }
  bool invalid() const { return !valid(); }
};

} // namespace warpo
