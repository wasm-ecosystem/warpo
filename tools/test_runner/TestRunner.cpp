#include <argparse/argparse.hpp>
#include <cstddef>
#include <cstring>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <iostream>
#include <regex>
#include <string>

#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/passes/RunnerForTest.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo {
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

  try {
    std::cout << __FILE__ << ":" << __LINE__ << "\n";
    frontend::init();
    std::cout << __FILE__ << ":" << __LINE__ << "\n";
    passes::init();
    std::cout << __FILE__ << ":" << __LINE__ << "\n";
    argparse::ArgumentParser program("warpo_test_runner");
    std::cout << __FILE__ << ":" << __LINE__ << "\n";
    cli::init(cli::Category::All, program, argc, argv);
    std::cout << __FILE__ << ":" << __LINE__ << "\n";

    frontend::CompilationResult const result = frontend::compile(nullptr);
    std::cout << __FILE__ << ":" << __LINE__ << "\n";
    std::string const wat = passes::runOnWatForTest(result.m, std::regex{functionRegex.get()});
    std::cout << __FILE__ << ":" << __LINE__ << "\n";
    writeBinaryFile(outputPath.get(), wat);
    std::cout << __FILE__ << ":" << __LINE__ << "\n";
  } catch (const std::exception &e) {
    fmt::print(stderr, "ERROR: {}\n", e.what());
    return 1;
  }
}
