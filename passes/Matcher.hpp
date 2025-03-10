#pragma once

#include <functional>

#include "support/index.h"
#include "wasm.h"

namespace warpo::passes::matcher {

template <class T> struct M {
  explicit M(std::function<bool(T const &)> matcher) : m_matcher(std::move(matcher)) {}
  std::function<bool(T const &)> m_matcher;
  bool operator()(T const &expr) const { return m_matcher(expr); }
};

template <class T, class P> struct IsMatcherImpl {
  template <class... E> M<P> operator()(M<E> const &...m) const {
    return M<P>([m...](P const &expr) -> bool {
      if (!expr.template is<T>())
        return false;
      T const &t = *expr.template cast<T>();
      return (m(t) && ...);
    });
  }
};

constexpr IsMatcherImpl<wasm::Store, wasm::Expression> isStore;
static inline M<wasm::Store> hasPtr(M<wasm::Expression> const &m) {
  return M<wasm::Store>([m](wasm::Store const &expr) -> bool { return m(*expr.ptr); });
}
static inline M<wasm::Store> hasValue(M<wasm::Expression> const &m) {
  return M<wasm::Store>([m](wasm::Store const &expr) -> bool { return m(*expr.value); });
}

constexpr IsMatcherImpl<wasm::LocalGet, wasm::Expression> isLocalGet;
static inline M<wasm::LocalGet> hasIndex(wasm::Index index) {
  return M<wasm::LocalGet>([index](wasm::LocalGet const &expr) -> bool { return index == expr.index; });
}

} // namespace warpo::passes::matcher
