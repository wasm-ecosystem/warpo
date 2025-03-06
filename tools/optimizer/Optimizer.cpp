#include <cstddef>
#include <fstream>
#include <ios>
#include <span>

#include "passes/Runner.hpp"
#include "support/Options.hpp"

int main(int argc, char const *argv[]) {
  using namespace warpo;
  support::Opt<const char *> inputPath{"-i"};
  support::Opt<const char *> outputPath{"-o"};

  if (support::parser(std::span<const char *>{argv, static_cast<size_t>(argc)}, inputPath, outputPath))
    return 1;

  passes::init();

  std::ifstream f{inputPath, std::ios::binary | std::ios::in};
  std::vector<char> input{std::istreambuf_iterator<char>{f}, {}};

  std::vector<uint8_t> output = passes::run(input, {"extract-most-frequently-used-global"});

  std::ofstream of{outputPath, std::ios::binary | std::ios::out};
  of.write(reinterpret_cast<char const *>(output.data()), output.size());
}
