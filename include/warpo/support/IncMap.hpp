#pragma once

#include <cassert>
#include <cstddef>
#include <map>
#include <vector>

template <class T> struct IncMap : private std::map<T, size_t> {
  using Map = std::map<T, size_t>;
  void insert(T const &v) {
    assert(!contains(v));
    Map::insert_or_assign(v, size());
  }
  size_t getIndex(T const &v) const {
    auto it = Map::find(v);
    assert(it != end());
    return it->second;
  }
  using Map::begin;
  using Map::contains;
  using Map::end;
  using Map::size;
  using typename Map::const_iterator;
};

template <class T> struct IncBiMap : private std::map<T, size_t>, private std::vector<T> {
  using Map = std::map<T, size_t>;
  using Vec = std::vector<T>;
  void insert(T const &v) {
    assert(!contains(v));
    Map::insert_or_assign(v, size());
    Vec::push_back(v);
  }
  size_t getIndex(T const &v) const {
    auto it = Map::find(v);
    assert(it != end());
    return it->second;
  }
  T const &getValue(size_t index) const { return Vec::at(index); }

  using Map::begin;
  using Map::contains;
  using Map::end;
  using Map::size;
};