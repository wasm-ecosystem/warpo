#pragma once

#include <array>
#include <cassert>
#include <compare>
#include <cstdint>
#include <iostream>
#include <ostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

namespace warpo {

class DynBitset {
  using Element = uint32_t;
  std::vector<Element> data_;
  size_t bitSize_;

  static constexpr size_t block_size = sizeof(Element) * 8U;

public:
  template <size_t N> explicit DynBitset(std::array<bool, N> init) : DynBitset(N) {
    for (size_t i = 0; i < N; i++) {
      set(i, init[i]);
    }
  }
  explicit DynBitset(size_t size) : bitSize_(size) { data_.resize((size + (block_size - 1U)) / block_size, 0); }

  size_t size() const { return bitSize_; }

  void resize(size_t size) {
    bitSize_ = size;
    data_.resize((size + (block_size - 1U)) / block_size, 0);
  }

  void set(size_t index, bool value) {
    if (index >= bitSize_) {
      throw std::out_of_range("Index out of range");
    }
    size_t block_index = index / block_size;
    size_t bit_index = index % block_size;
    if (value) {
      data_[block_index] |= (1U << bit_index);
    } else {
      data_[block_index] &= ~(1U << bit_index);
    }
  }
  bool get(size_t index) const {
    if (index >= bitSize_) {
      throw std::out_of_range("Index out of range");
    }
    size_t block_index = index / block_size;
    size_t bit_index = index % block_size;
    return ((data_[block_index] >> bit_index) & 1U) == 1U;
  }

  size_t count() const {
    size_t count = 0;
    for (size_t i = 0; i < data_.size(); ++i) {
      count += __builtin_popcount(data_[i]);
    }
    return count;
  }

  std::string toString() const {
    std::stringstream ss{};
    ss << (*this);
    return ss.str();
  }
  friend std::ostream &operator<<(std::ostream &os, DynBitset const &bitset) {
    for (size_t i = 0; i < bitset.size(); ++i)
      os << (bitset.get(i) ? '1' : '0');
    return os;
  }
  std::strong_ordering operator<=>(DynBitset const &other) const {
    assert(bitSize_ == other.bitSize_);
    for (size_t i = 0; i < data_.size(); ++i) {
      if (data_[i] != other.data_[i])
        return data_[i] <=> other.data_[i];
    }
    return std::strong_ordering::equal;
  }
  bool operator!=(DynBitset const &other) const {
    assert(bitSize_ == other.bitSize_);
    for (size_t i = 0; i < data_.size(); ++i) {
      if (data_[i] != other.data_[i])
        return true;
    }
    return false;
  }
  bool operator==(DynBitset const &other) const { return !(*this != other); }
  DynBitset operator|(DynBitset const &b) const {
    assert(bitSize_ == b.bitSize_);
    DynBitset ret{bitSize_};
    for (size_t i = 0; i < data_.size(); ++i) {
      ret.data_[i] = data_[i] | b.data_[i];
    }
    return ret;
  }
  DynBitset &operator|=(DynBitset const &b) {
    assert(bitSize_ == b.bitSize_);
    for (size_t i = 0; i < data_.size(); ++i) {
      data_[i] |= b.data_[i];
    }
    return *this;
  }
  DynBitset operator&(DynBitset const &b) const {
    assert(bitSize_ == b.bitSize_);
    DynBitset ret{bitSize_};
    for (size_t i = 0; i < data_.size(); ++i) {
      ret.data_[i] = data_[i] & b.data_[i];
    }
    return ret;
  }
  DynBitset operator^(DynBitset const &b) const {
    assert(bitSize_ == b.bitSize_);
    DynBitset ret{bitSize_};
    for (size_t i = 0; i < data_.size(); ++i) {
      ret.data_[i] = data_[i] ^ b.data_[i];
    }
    return ret;
  }
  DynBitset &operator&=(DynBitset const &b) {
    assert(bitSize_ == b.bitSize_);
    for (size_t i = 0; i < data_.size(); ++i) {
      data_[i] &= b.data_[i];
    }
    return *this;
  }
  DynBitset operator~() const {
    DynBitset ret{bitSize_};
    for (size_t i = 0; i < data_.size(); ++i) {
      ret.data_[i] = ~data_[i];
    }
    return ret;
  }
};

} // namespace warpo
