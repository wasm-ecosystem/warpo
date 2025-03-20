#pragma once

#include <functional>
#include <initializer_list>
#include <map>
#include <string>
#include <type_traits>

#include "support/Container.hpp"
#include "support/index.h"
#include "wasm.h"

namespace warpo::passes::matcher {

struct Context {
  std::map<std::string, wasm::Expression const *> bindings{};
  template <class T> T const *getBinding(std::string const &name) const {
    static_assert(std::is_base_of_v<wasm::Expression, T>, "bind only support subclass of wasm::Expression");
    auto it = bindings.find(name);
    if (it == bindings.end())
      return nullptr;
    return it->second->cast<T>();
  }
};

template <class T> struct M {
  explicit M(std::function<bool(T const &, Context &ctx)> matcher) : m_matcher(std::move(matcher)) {}
  std::function<bool(T const &, Context &)> m_matcher;

  bool operator()(T const &expr) const {
    Context ctx{};
    return (*this)(expr, ctx);
  }
  bool operator()(T const &expr, Context &ctx) const { return m_matcher(expr, ctx); }

  M bind(std::string const &name) {
    return M{[self = *this, name](T const &expr, Context &ctx) -> bool {
      bool const ret = self(expr, ctx);
      if (ret)
        ctx.bindings.insert_or_assign(name, &expr);
      return ret;
    }};
  }
};

template <class T, class P> struct IsMatcherImpl {
  template <class... E> M<P> operator()(M<E> const &...m) const {
    return M<P>{[m...](P const &expr, Context &ctx) -> bool {
      if (!expr.template is<T>())
        return false;
      T const &t = *expr.template cast<T>();
      return (m(t, ctx) && ...);
    }};
  }
};

template <class T> M<T> anyOf(std::initializer_list<M<T>> ms) {
  return M<T>([ms = std::vector<M<T>>{ms}](T const &expr, Context &ctx) -> bool {
    return std::any_of(ms.begin(), ms.end(), [&expr, &ctx](M<T> const &m) { return m(expr, ctx); });
  });
}

constexpr IsMatcherImpl<wasm::Nop, wasm::Expression> isNop;

constexpr IsMatcherImpl<wasm::Store, wasm::Expression> isStore;
namespace store {
static inline M<wasm::Store> ptr(M<wasm::Expression> const &m) {
  return M<wasm::Store>([m](wasm::Store const &expr, Context &ctx) -> bool { return m(*expr.ptr, ctx); });
}
static inline M<wasm::Store> v(M<wasm::Expression> const &m) {
  return M<wasm::Store>([m](wasm::Store const &expr, Context &ctx) -> bool { return m(*expr.value, ctx); });
}
static inline M<wasm::Store> offset(wasm::Address const &offset) {
  return M<wasm::Store>([offset](wasm::Store const &expr, Context &ctx) -> bool { return expr.offset == offset; });
}
} // namespace store

constexpr IsMatcherImpl<wasm::LocalGet, wasm::Expression> isLocalGet;
namespace local_get {
static inline M<wasm::LocalGet> index(wasm::Index index) {
  return M<wasm::LocalGet>([index](wasm::LocalGet const &expr, Context &ctx) -> bool { return index == expr.index; });
}
} // namespace local_get

constexpr IsMatcherImpl<wasm::LocalSet, wasm::Expression> isLocalSet;
namespace local_set {
static inline M<wasm::LocalSet> index(wasm::Index index) {
  return M<wasm::LocalSet>([index](wasm::LocalSet const &expr, Context &ctx) -> bool { return index == expr.index; });
}
static inline M<wasm::LocalSet> v(M<wasm::Expression> const &m) {
  return M<wasm::LocalSet>([m](wasm::LocalSet const &expr, Context &ctx) -> bool { return m(*expr.value, ctx); });
}
static inline M<wasm::LocalSet> tee() {
  return M<wasm::LocalSet>([](wasm::LocalSet const &expr, Context &ctx) -> bool { return expr.isTee(); });
}
} // namespace local_set

constexpr IsMatcherImpl<wasm::GlobalGet, wasm::Expression> isGlobalGet;
namespace global_get {
static inline M<wasm::GlobalGet> name(wasm::Name name) {
  return M<wasm::GlobalGet>([name](wasm::GlobalGet const &expr, Context &ctx) -> bool { return name == expr.name; });
}
} // namespace global_get
constexpr IsMatcherImpl<wasm::GlobalSet, wasm::Expression> isGlobalSet;
namespace global_set {
static inline M<wasm::GlobalSet> v(M<wasm::Expression> const &m) {
  return M<wasm::GlobalSet>([m](wasm::GlobalSet const &expr, Context &ctx) -> bool { return m(*expr.value, ctx); });
}
static inline M<wasm::GlobalSet> name(wasm::Name name) {
  return M<wasm::GlobalSet>([name](wasm::GlobalSet const &expr, Context &ctx) -> bool { return name == expr.name; });
}
} // namespace global_set

constexpr IsMatcherImpl<wasm::Const, wasm::Expression> isConst;
namespace const_ {
static inline M<wasm::Const> v(wasm::Literal value) {
  return M<wasm::Const>([value](wasm::Const const &expr, Context &ctx) -> bool { return value == expr.value; });
}
} // namespace const_

constexpr IsMatcherImpl<wasm::Binary, wasm::Expression> isBinary;
namespace binary {
static inline M<wasm::Binary> op(wasm::BinaryOp op) {
  return M<wasm::Binary>([op](wasm::Binary const &expr, Context &ctx) -> bool { return op == expr.op; });
}
static inline M<wasm::Binary> op(std::vector<wasm::BinaryOp> ops) {
  return M<wasm::Binary>(
      [ops = std::move(ops)](wasm::Binary const &expr, Context &ctx) -> bool { return contains(ops, expr.op); });
}
static inline M<wasm::Binary> lhs(M<wasm::Expression> const &m) {
  return M<wasm::Binary>([m](wasm::Binary const &expr, Context &ctx) -> bool { return m(*expr.left, ctx); });
}
static inline M<wasm::Binary> rhs(M<wasm::Expression> const &m) {
  return M<wasm::Binary>([m](wasm::Binary const &expr, Context &ctx) -> bool { return m(*expr.right, ctx); });
}
static inline M<wasm::Binary> each(M<wasm::Expression> const &m1, M<wasm::Expression> const &m2) {
  return M<wasm::Binary>([m1, m2](wasm::Binary const &expr, Context &ctx) -> bool {
    return (m1(*expr.left, ctx) && m2(*expr.right, ctx)) || (m1(*expr.right, ctx) && m2(*expr.left, ctx));
  });
}
} // namespace binary

constexpr IsMatcherImpl<wasm::Drop, wasm::Expression> isDrop;
namespace drop {
static inline M<wasm::Drop> v(M<wasm::Expression> const &m) {
  return M<wasm::Drop>([m](wasm::Drop const &expr, Context &ctx) -> bool { return m(*expr.value, ctx); });
}
} // namespace drop

constexpr IsMatcherImpl<wasm::Call, wasm::Expression> isCall;
namespace call {
static inline M<wasm::Call> callee(wasm::Name name) {
  return M<wasm::Call>([name](wasm::Call const &expr, Context &ctx) -> bool { return name == expr.target; });
}
} // namespace call

constexpr IsMatcherImpl<wasm::MemoryFill, wasm::Expression> isMemoryFill;
namespace memory_fill {
static inline M<wasm::MemoryFill> dest(M<wasm::Expression> const &m) {
  return M<wasm::MemoryFill>([m](wasm::MemoryFill const &expr, Context &ctx) -> bool { return m(*expr.dest, ctx); });
}
static inline M<wasm::MemoryFill> v(M<wasm::Expression> const &m) {
  return M<wasm::MemoryFill>([m](wasm::MemoryFill const &expr, Context &ctx) -> bool { return m(*expr.value, ctx); });
}
static inline M<wasm::MemoryFill> size(M<wasm::Expression> const &m) {
  return M<wasm::MemoryFill>([m](wasm::MemoryFill const &expr, Context &ctx) -> bool { return m(*expr.size, ctx); });
}
} // namespace memory_fill

} // namespace warpo::passes::matcher
