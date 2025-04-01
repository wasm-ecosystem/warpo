#pragma once

#include <cassert>
#include <cstddef>
#include <cstring>

namespace warpo {

namespace result::detail {
struct Void {};
struct Failed {};
} // namespace result::detail
template <typename T, typename E = result::detail::Void> class [[nodiscard]] Result {
private:
  static constexpr size_t max_size = sizeof(T) > sizeof(E) ? sizeof(T) : sizeof(E);
  alignas(alignof(T) > alignof(E) ? alignof(T) : alignof(E)) std::byte data[max_size];
  bool success_;

  template <class U> Result(U const &u, bool success) : success_(success) {
    static_assert(sizeof(U) <= max_size, "value too large to store in shared memory.");
    new (data) U(u);
  }

public:
  static Result succeed(T const &v) { return Result(v, true); }
  static Result failed(E const &e) { return Result(e, false); }

  Result(result::detail::Failed) : Result(E{}, false) {}

  T const &value() const {
    assert(success_ && "Attempted to get value of type T when stored type is E");
    return *reinterpret_cast<T const *>(data);
  }
  E const &err() const {
    assert(!success_ && "Attempted to get value of type T when stored type is E");
    return *reinterpret_cast<E const *>(data);
  }

  bool ok() const { return success_; }
  bool nok() const { return !ok(); }

  ~Result() {
    if (success_) {
      reinterpret_cast<T *>(data)->~T();
    } else {
      reinterpret_cast<E *>(data)->~E();
    }
  }
};

inline result::detail::Failed failed() { return result::detail::Failed{}; }
template <class T> inline Result<T> succeed(T const &t) { return Result<T>::succeed(t); }

} // namespace warpo
