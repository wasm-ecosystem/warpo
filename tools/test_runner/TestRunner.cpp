#include <argparse/argparse.hpp>
#include <cstddef>
#include <cstring>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <regex>
#include <string>

#include "warpo/passes/Runner.hpp"
#include "warpo/passes/RunnerForTest.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo {
static cli::Opt<std::filesystem::path> inputPath{
    cli::Category::All,
    "-i",
    "--input",
    [](argparse::Argument &arg) -> void { arg.help("input file").required(); },
};
static cli::Opt<std::filesystem::path> outputPath{
    cli::Category::All,
    "-o",
    "--output",
    [](argparse::Argument &arg) -> void { arg.help("output file").required(); },
};
static cli::Opt<std::string> functionRegex{
    cli::Category::All,
    "--func",
    [](argparse::Argument &arg) -> void { arg.help("function name").required(); },
};
} // namespace warpo

int main(int argc, char const *argv[]) {
  using namespace warpo;

  passes::init();
  argparse::ArgumentParser program("warpo_test_runner");

  try {
    cli::init(cli::Category::All, program, argc, argv);
    std::string const input = readBinaryFile(inputPath.get());
    std::string const wat = passes::runOnWatForTest(input, std::regex{functionRegex.get()});
    writeBinaryFile(outputPath.get(), wat);
  } catch (const std::exception &e) {
    fmt::print(stderr, "ERROR: {}\n", e.what());
    return 1;
  }
}
