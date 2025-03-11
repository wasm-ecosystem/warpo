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

  passes::init();

  std::ifstream ifstream{inputPath, std::ios::binary | std::ios::in};
  if (!ifstream.good()) {
    fmt::println("ERROR: failed to open file: {}", static_cast<const char *>(inputPath));
    return 1;
  }
  std::vector<char> input{std::istreambuf_iterator<char>{ifstream}, {}};

  std::vector<const char *> const passNames{
      "extract-most-frequently-used-global",
      "inline-setter-function",
  };
  std::vector<uint8_t> output = passes::run(input, passNames);

  std::ofstream ofstream{outputPath, std::ios::binary | std::ios::out};
  if (!ofstream.good()) {
    fmt::println("ERROR: failed to open file: {}", static_cast<const char *>(outputPath));
    return 1;
  }
  ofstream.write(reinterpret_cast<char const *>(output.data()), output.size());
}
