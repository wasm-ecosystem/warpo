// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstddef>
#include <cstdint>
#include <iterator>

namespace warpo {

template <int32_t Step = 1> class Range {
  std::size_t m_begin;
  std::size_t m_end;

public:
  explicit Range(std::size_t begin, std::size_t end) : m_begin(begin), m_end(end) {}
  explicit Range(std::size_t end) : Range(0, end) {}

  class RangeIterator {
    std::size_t m_cnt;

  public:
    explicit RangeIterator(std::size_t cnt) : m_cnt(cnt) {}

    size_t &operator*() { return m_cnt; }
    RangeIterator &operator++() {
      m_cnt += static_cast<size_t>(Step);
      return *this;
    }

    using iterator_category = std::forward_iterator_tag;
    using value_type = std::size_t;
    using difference_type = std::ptrdiff_t;
    using pointer = std::size_t *;
    using reference = std::size_t &;

    bool operator!=(RangeIterator const &o) const { return m_cnt != o.m_cnt; }
    bool operator==(RangeIterator const &o) const { return m_cnt == o.m_cnt; }
  };

  RangeIterator begin() const { return RangeIterator(m_begin); }
  RangeIterator end() const { return RangeIterator(m_end); }
};

} // namespace warpo