#pragma once

#include <algorithm>
#include <set>

namespace warpo {

template <class T, class E> bool contains(T const &t, E const &e) {
  return std::find(t.begin(), t.end(), e) != t.end();
}

template <class T> std::set<T> intersect(std::set<T> const &a, std::set<T> const &b) {
  std::set<T> result{};
  std::set_intersection(a.begin(), a.end(), b.begin(), b.end(), std::inserter(result, result.begin()));
  return result;
}

} // namespace warpo
