#include <argparse/argparse.hpp>
#include <cassert>
#include <functional>
#include <vector>

#include "support/Opt.hpp"

namespace warpo::cli {

struct LazyInitOptCallback {
  static LazyInitOptCallback &ins() {
    static LazyInitOptCallback instance{};
    return instance;
  }
  std::vector<std::function<void(argparse::ArgumentParser &)>> registerCallback_;
};

void detail::registerCallback(std::function<void(argparse::ArgumentParser &)> &&fn) {
  LazyInitOptCallback::ins().registerCallback_.push_back(std::move(fn));
}

} // namespace warpo::cli

void warpo::cli::init(argparse::ArgumentParser &program, int argc, char const *argv[]) {
  for (auto const &fn : LazyInitOptCallback::ins().registerCallback_) {
    fn(program);
  }
  program.parse_args(argc, argv);
}
