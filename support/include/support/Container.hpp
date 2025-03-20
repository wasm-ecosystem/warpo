#pragma once

#include <algorithm>
#include <concepts>
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

/// @return true iff @param subset is a subset of @param superset.
template <class T> bool subset(std::set<T> const &superset, std::set<T> const &subset) {
  return intersect(subset, superset).size() == subset.size();
}

template <class E, class T, class Fn>
concept Transformable = requires(T const &t, Fn const &fn) {
  { fn(t) } -> std::same_as<E>;
};

template <class E, class T, class Fn>
std::vector<E> transform(std::vector<T> const &v, Fn const &fn)
  requires Transformable<E, T, Fn>
{
  std::vector<E> result{};
  result.reserve(v.size());
  for (auto const &e : v)
    result.push_back(fn(e));
  return result;
}

template <class T, class Fn> bool all_of(T &&container, Fn &&fn) {
  return std::all_of(container.begin(), container.end(), std::forward<Fn>(fn));
}

} // namespace warpo
