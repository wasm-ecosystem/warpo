#include <argparse/argparse.hpp>
#include <cstddef>
#include <cstring>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <regex>
#include <string>

#include "warpo/common/ConfigProvider.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/passes/Runner.hpp"
#include "warpo/passes/RunnerForTest.hpp"
#include "warpo/support/FileSystem.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo {
static cli::Opt<std::string> functionRegex{
    cli::Category::All,
    "--func",
    [](argparse::Argument &arg) -> void { arg.help("function name").required(); },
};
} // namespace warpo

int main(int argc, char const *argv[]) {
  using namespace warpo;

  try {
    frontend::init();
    passes::init();
    argparse::ArgumentParser program("warpo_test_runner");
    cli::init(cli::Category::All, program, argc, argv);

    std::optional<std::filesystem::path> const outputPath = common::ConfigProvider::instance().outputPath();
    if (!outputPath.has_value())
      throw std::runtime_error{"Output path not specified. Use -o or --output to specify the output file."};

    frontend::CompilationResult const result = frontend::compile(nullptr);
    std::string const wat = passes::runOnWatForTest(result.m, std::regex{functionRegex.get()});
    writeBinaryFile(outputPath.value(), wat);
  } catch (const std::exception &e) {
    fmt::print(stderr, "ERROR: {}\n", e.what());
    return 1;
  }
}
