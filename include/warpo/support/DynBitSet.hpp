#pragma once

#include <array>
#include <cassert>
#include <compare>
#include <cstdint>
#include <iostream>
#include <ostream>
#include <string>
#include <vector>

namespace warpo {

class DynBitset {
  using Element = uint64_t;
  std::vector<Element> data_;
  size_t bitSize_;

public:
  static constexpr size_t block_size = sizeof(Element) * 8U;

  template <size_t N> explicit DynBitset(std::array<bool, N> init) : DynBitset(N) {
    for (size_t i = 0; i < N; i++) {
      set(i, init[i]);
    }
  }
  explicit DynBitset(size_t size) : bitSize_(size) { data_.resize((size + (block_size - 1U)) / block_size, 0); }

  std::string toString() const;
  friend std::ostream &operator<<(std::ostream &os, DynBitset const &bitset);

  size_t size() const { return bitSize_; }

  void resize(size_t size) {
    bitSize_ = size;
    data_.resize((size + (block_size - 1U)) / block_size, 0);
  }

  void set(size_t index, bool value);
  bool get(size_t index) const;
  size_t count() const;

  template <class Fn> void forEachTrue(Fn &&fn) {
    for (size_t i = 0; i < bitSize_; i++) {
      if (get(i))
        fn(i);
    }
  }

  std::strong_ordering operator<=>(DynBitset const &other) const;
  bool operator!=(DynBitset const &other) const;
  bool operator==(DynBitset const &other) const;
  DynBitset operator|(DynBitset const &b) const;
  DynBitset &operator|=(DynBitset const &b);
  DynBitset operator&(DynBitset const &b) const;
  DynBitset &operator&=(DynBitset const &b);
  DynBitset operator~() const;
};

} // namespace warpo
