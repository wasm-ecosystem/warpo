#pragma once

#include <argparse/argparse.hpp>
#include <cassert>
#include <functional>

namespace warpo::cli {

namespace detail {
void registerCallback(std::function<void(argparse::ArgumentParser &)> &&fn);
}

template <typename T> struct Opt {
  Opt(const char *name, std::function<void(argparse::Argument &)> &&fn) {
    detail::registerCallback([fn = std::move(fn), name, this](argparse::ArgumentParser &argparser) -> void {
      fn(argparser.add_argument(name).store_into(v_));
    });
  }
  Opt(const char *shortName, const char *longName, std::function<void(argparse::Argument &)> &&fn) {
    detail::registerCallback(
        [fn = std::move(fn), shortName, longName, this](argparse::ArgumentParser &argparser) -> void {
          fn(argparser.add_argument(shortName, longName).store_into(v_));
        });
  }

  T const &get() const { return v_; }

private:
  T v_{};
};

void init(argparse::ArgumentParser &program, int argc, char const *argv[]);

} // namespace warpo::cli
