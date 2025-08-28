#include <argparse/argparse.hpp>
#include <cstddef>
#include <fmt/format.h>
#include <fstream>
#include <ios>

#include "fmt/base.h"
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

int main(int argc, char const *argv[]) {
  using namespace warpo;

  passes::init();

  argparse::ArgumentParser program("warpo");
  cli::init(program, argc, argv);

  if (!inputPath.get().ends_with("wat") && !inputPath.get().ends_with("wast")) {
    fmt::println("ERROR: invalid file extension: {}, expected 'wat' or 'wast'", inputPath.get());
    return 1;
  }
  std::ifstream ifstream{inputPath.get(), std::ios::in};
  if (!ifstream.good()) {
    fmt::println("ERROR: failed to open file: {}", inputPath.get());
    return 1;
  }
  std::string input{std::istreambuf_iterator<char>{ifstream}, {}};
  passes::Output output = passes::runOnWat(input);

  std::string watPathStr{};
  std::string wasmPathStr{};
  if (outputPath.get().ends_with("wat")) {
    watPathStr = outputPath.get();
    wasmPathStr = outputPath.get().substr(0, outputPath.get().size() - 3) + "wasm";
  } else if (outputPath.get().ends_with("wasm")) {
    watPathStr = outputPath.get().substr(0, outputPath.get().size() - 4) + "wat";
    wasmPathStr = outputPath.get();
  } else {
    fmt::println("ERROR: invalid file extension: {}", outputPath.get());
    return 1;
  }
  std::ofstream wasmOf{wasmPathStr, std::ios::binary | std::ios::out};
  if (!wasmOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPath.get());
    return 1;
  }
  wasmOf.write(reinterpret_cast<char const *>(output.wasm.data()), static_cast<std::streamsize>(output.wasm.size()));
  std::ofstream watOf{watPathStr, std::ios::out};
  if (!watOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPath.get());
    return 1;
  }
  watOf.write(output.wat.data(), static_cast<std::streamsize>(output.wat.size()));
}
