#include <cstddef>
#include <fmt/format.h>
#include <fstream>
#include <ios>
#include <span>

#include "fmt/base.h"
#include "passes/Runner.hpp"
#include "support/Options.hpp"

int main(int argc, char const *argv[]) {
  using namespace warpo;
  support::Opt<const char *> inputPath{"-i"};
  support::Opt<const char *> outputPath{"-o"};

  if (support::parser(std::span<const char *>{argv, static_cast<size_t>(argc)}, inputPath, outputPath))
    return 1;
  if (static_cast<const char *>(inputPath) == nullptr) {
    fmt::println("ERROR: missing input path");
    return 1;
  }
  if (static_cast<const char *>(outputPath) == nullptr) {
    fmt::println("ERROR: missing output path");
    return 1;
  }

  passes::Output output;
  std::string const inputPathStr{static_cast<const char *>(inputPath)};
  if (inputPathStr.ends_with("wasm")) {
    std::ifstream ifstream{inputPathStr, std::ios::binary | std::ios::in};
    if (!ifstream.good()) {
      fmt::println("ERROR: failed to open file: {}", inputPathStr);
      return 1;
    }
    std::vector<char> input{std::istreambuf_iterator<char>{ifstream}, {}};
    output = passes::runOnWasm(input);
  } else if (inputPathStr.ends_with("wat")) {
    std::ifstream ifstream{inputPathStr, std::ios::in};
    if (!ifstream.good()) {
      fmt::println("ERROR: failed to open file: {}", inputPathStr);
      return 1;
    }
    std::string input{std::istreambuf_iterator<char>{ifstream}, {}};
    output = passes::runOnWat(input);
  } else {
    fmt::println("ERROR: invalid file extension: {}", inputPathStr);
    return 1;
  }

  std::string const outputPathStr{static_cast<const char *>(outputPath)};
  std::string watPathStr{};
  std::string wasmPathStr{};
  if (outputPathStr.ends_with("wat")) {
    watPathStr = outputPathStr;
    wasmPathStr = outputPathStr.substr(0, outputPathStr.size() - 3) + "wasm";
  } else if (outputPathStr.ends_with("wasm")) {
    watPathStr = outputPathStr.substr(0, outputPathStr.size() - 4) + "wat";
    wasmPathStr = outputPathStr;
  } else {
    fmt::println("ERROR: invalid file extension: {}", outputPathStr);
    return 1;
  }
  std::ofstream wasmOf{wasmPathStr, std::ios::binary | std::ios::out};
  if (!wasmOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPathStr);
    return 1;
  }
  wasmOf.write(reinterpret_cast<char const *>(output.wasm.data()), static_cast<std::streamsize>(output.wasm.size()));
  std::ofstream watOf{watPathStr, std::ios::out};
  if (!watOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPathStr);
    return 1;
  }
  watOf.write(output.wat.data(), static_cast<std::streamsize>(output.wat.size()));
}
