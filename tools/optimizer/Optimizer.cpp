#include <argparse/argparse.hpp>
#include <cstddef>
#include <fmt/format.h>
#include <fstream>
#include <ios>

#include "fmt/base.h"
#include "passes/Runner.hpp"

int main(int argc, char const *argv[]) {
  using namespace warpo;

  passes::init();

  argparse::ArgumentParser program("warpo");
  program.add_argument("-i", "--input").help("input file").required();
  program.add_argument("-o", "--output").help("output file").required();
  program.parse_args(argc, argv);
  auto const inputPath = program.get<std::string>("--input");
  auto const outputPath = program.get<std::string>("--output");

  if (!inputPath.ends_with("wat") && !inputPath.ends_with("wast")) {
    fmt::println("ERROR: invalid file extension: {}, expected 'wat' or 'wast'", inputPath);
    return 1;
  }
  std::ifstream ifstream{inputPath, std::ios::in};
  if (!ifstream.good()) {
    fmt::println("ERROR: failed to open file: {}", inputPath);
    return 1;
  }
  std::string input{std::istreambuf_iterator<char>{ifstream}, {}};
  passes::Output output = passes::runOnWat(input);

  std::string watPathStr{};
  std::string wasmPathStr{};
  if (outputPath.ends_with("wat")) {
    watPathStr = outputPath;
    wasmPathStr = outputPath.substr(0, outputPath.size() - 3) + "wasm";
  } else if (outputPath.ends_with("wasm")) {
    watPathStr = outputPath.substr(0, outputPath.size() - 4) + "wat";
    wasmPathStr = outputPath;
  } else {
    fmt::println("ERROR: invalid file extension: {}", outputPath);
    return 1;
  }
  std::ofstream wasmOf{wasmPathStr, std::ios::binary | std::ios::out};
  if (!wasmOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPath);
    return 1;
  }
  wasmOf.write(reinterpret_cast<char const *>(output.wasm.data()), static_cast<std::streamsize>(output.wasm.size()));
  std::ofstream watOf{watPathStr, std::ios::out};
  if (!watOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPath);
    return 1;
  }
  watOf.write(output.wat.data(), static_cast<std::streamsize>(output.wat.size()));
}
