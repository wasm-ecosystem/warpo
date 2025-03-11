#include <fmt/format.h>
#include <map>
#include <span>
#include <string>

#include "support/Options.hpp"

namespace warpo ::support {

bool detail::parseImpl(std::map<std::string, OptBasic *> const &map, std::span<const char *> args) {
  for (size_t i = 1U; i < args.size(); ++i) {
    auto arg = args[i];
    auto it = map.find(arg);
    if (it == map.end()) {
      fmt::println("ERROR: unknown arg {}\n", arg);
      return true;
    }
    ++i;
    if (i >= args.size()) {
      fmt::println("ERROR: invalid arg {}\n", arg);
      return true;
    }
    OptBasic &opt = *it->second;
    opt.value_ = args[i];
  }
  return false;
}

template <> Opt<const char *>::operator const char *() const { return value_; }

} // namespace warpo::support
