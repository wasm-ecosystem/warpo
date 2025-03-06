#pragma once

#include <map>
#include <span>

namespace warpo::support {

namespace detail {
struct OptBasic {
  explicit OptBasic(std::string prefix) : prefix_(prefix), value_(nullptr) {}

  std::string prefix_;
  const char *value_;
};

/// @return true when parser failed
[[nodiscard]] bool parseImpl(std::map<std::string, OptBasic *> const &map, std::span<const char *> args);
} // namespace detail

template <class T> struct Opt : public detail::OptBasic {
  explicit Opt(std::string prefix) : detail::OptBasic(prefix) {}

  operator T() const;
};

/// @return true when parser failed
template <class... Args> [[nodiscard]] bool parser(std::span<const char *> args, Opt<Args> &...opt) {
  std::map<std::string, detail::OptBasic *> optMap{};
  ((optMap[opt.prefix_] = &opt), ...);
  return detail::parseImpl(optMap, args);
}

} // namespace warpo::support
