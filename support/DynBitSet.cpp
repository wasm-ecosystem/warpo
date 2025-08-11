#include <cassert>
#include <compare>
#include <cstddef>
#include <iostream>
#include <ostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

#include "support/DynBitSet.hpp"

namespace warpo {

std::string DynBitset::toString() const {
  std::stringstream ss{};
  ss << (*this);
  return ss.str();
}
std::ostream &operator<<(std::ostream &os, DynBitset const &bitset) {
  for (size_t i = 0; i < bitset.size(); ++i)
    os << (bitset.get(i) ? '1' : '0');
  return os;
}

void DynBitset::set(size_t index, bool value) {
  if (index >= bitSize_) {
    throw std::out_of_range("Index out of range");
  }
  size_t block_index = index / block_size;
  size_t bit_index = index % block_size;
  if (value) {
    data_[block_index] |= (static_cast<Element>(1U) << static_cast<Element>(bit_index));
  } else {
    data_[block_index] &= ~(static_cast<Element>(1U) << static_cast<Element>(bit_index));
  }
}
bool DynBitset::get(size_t index) const {
  if (index >= bitSize_) {
    throw std::out_of_range("Index out of range");
  }
  size_t const block_index = index / block_size;
  size_t const bit_index = index % block_size;
  return ((data_[block_index] >> static_cast<Element>(bit_index)) & 1U) == 1U;
}

std::strong_ordering DynBitset::operator<=>(DynBitset const &other) const {
  assert(bitSize_ == other.bitSize_);
  for (size_t i = 0; i < data_.size(); ++i) {
    if (data_[i] != other.data_[i])
      return data_[i] <=> other.data_[i];
  }
  return std::strong_ordering::equal;
}
bool DynBitset::operator!=(DynBitset const &other) const {
  assert(bitSize_ == other.bitSize_);
  for (size_t i = 0; i < data_.size(); ++i) {
    if (data_[i] != other.data_[i])
      return true;
  }
  return false;
}
bool DynBitset::operator==(DynBitset const &other) const { return !(*this != other); }
DynBitset DynBitset::operator|(DynBitset const &b) const {
  assert(bitSize_ == b.bitSize_);
  DynBitset ret{bitSize_};
  for (size_t i = 0; i < data_.size(); ++i) {
    ret.data_[i] = data_[i] | b.data_[i];
  }
  return ret;
}
DynBitset &DynBitset::operator|=(DynBitset const &b) {
  assert(bitSize_ == b.bitSize_);
  for (size_t i = 0; i < data_.size(); ++i) {
    data_[i] |= b.data_[i];
  }
  return *this;
}
DynBitset DynBitset::operator&(DynBitset const &b) const {
  assert(bitSize_ == b.bitSize_);
  DynBitset ret{bitSize_};
  for (size_t i = 0; i < data_.size(); ++i) {
    ret.data_[i] = data_[i] & b.data_[i];
  }
  return ret;
}
DynBitset &DynBitset::operator&=(DynBitset const &b) {
  assert(bitSize_ == b.bitSize_);
  for (size_t i = 0; i < data_.size(); ++i) {
    data_[i] &= b.data_[i];
  }
  return *this;
}
DynBitset DynBitset::operator~() const {
  DynBitset ret{bitSize_};
  for (size_t i = 0; i < data_.size(); ++i) {
    ret.data_[i] = ~data_[i];
  }
  if (bitSize_ % block_size != 0) {
    ret.data_.back() &= (static_cast<Element>(1) << (bitSize_ % block_size)) - 1U;
  }
  return ret;
}

} // namespace warpo

#ifdef WARPO_ENABLE_UNIT_TESTS
#include <gtest/gtest.h>
namespace warpo::ut {

TEST(DynBitSetTest, Nor) {
  DynBitset nor_v = ~DynBitset{2};
  EXPECT_EQ(nor_v.toString(), "11");
}

TEST(DynBitSetTest, NorAndResize) {
  DynBitset v{2};
  DynBitset nor_v = ~v;
  nor_v.resize(2U * DynBitset::block_size);
  std::string expected = DynBitset{DynBitset::block_size}.toString() + DynBitset{DynBitset::block_size}.toString();
  expected[0] = '1';
  expected[1] = '1';
  EXPECT_EQ(nor_v.toString(), expected);
}

TEST(DynBitSetTest, NorFull) {
  DynBitset nor_v = ~DynBitset{DynBitset::block_size};
  std::string expected(DynBitset::block_size, '1');
  EXPECT_EQ(nor_v.toString(), expected);
}

TEST(DynBitSetTest, Set) {
  DynBitset v{DynBitset::block_size};
  v.set(10, true);
  v.set(60, true);
  std::string expected(DynBitset::block_size, '0');
  expected[10] = '1';
  expected[60] = '1';
  EXPECT_EQ(v.toString(), expected);
}

} // namespace warpo::ut
#endif
