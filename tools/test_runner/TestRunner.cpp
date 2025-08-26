#include <argparse/argparse.hpp>
#include <cstddef>
#include <cstring>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fstream>
#include <ios>
#include <regex>
#include <string>

#include "support/Opt.hpp"
#include "warpo/passes/Runner.hpp"

static warpo::cli::Opt<std::string> inputPath{
    "-i",
    "--input",
    [](argparse::Argument &arg) -> void { arg.help("input file").required(); },
};
static warpo::cli::Opt<std::string> outputPath{
    "-o",
    "--output",
    [](argparse::Argument &arg) -> void { arg.help("output file").required(); },
};
static warpo::cli::Opt<std::string> functionRegex{
    "--func",
    [](argparse::Argument &arg) -> void { arg.help("function name").required(); },
};

int main(int argc, char const *argv[]) {
  using namespace warpo;

  passes::init();

  argparse::ArgumentParser program("warpo_test_runner");
  try {
    cli::init(program, argc, argv);
  } catch (const std::exception &e) {
    fmt::print(stderr, "ERROR: {}\n", e.what());
    return 1;
  }
  std::ifstream ifstream{inputPath.get(), std::ios::in};
  if (!ifstream.good()) {
    fmt::println("ERROR: failed to open file: {}", inputPath.get());
    return 1;
  }
  std::string input{std::istreambuf_iterator<char>{ifstream}, {}};

  std::string wat = passes::runOnWatForTesting(input, std::regex{functionRegex.get()});

  std::ofstream watOf{outputPath.get(), std::ios::out};
  if (!watOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPath.get());
    return 1;
  }
  watOf.write(wat.data(), static_cast<std::streamsize>(wat.size()));
}
