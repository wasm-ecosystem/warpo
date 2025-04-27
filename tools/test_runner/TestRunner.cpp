#include <argparse/argparse.hpp>
#include <cstddef>
#include <cstring>
#include <fmt/base.h>
#include <fmt/format.h>
#include <fstream>
#include <ios>
#include <optional>
#include <regex>
#include <string>

#include "passes/Runner.hpp"

int main(int argc, char const *argv[]) {
  using namespace warpo;

  passes::init();

  argparse::ArgumentParser program("warpo_test_runner");
  program.add_argument("-i", "--input").help("input file").required();
  program.add_argument("-o", "--output").help("output file").required();
  program.add_argument("--pass").help("pass name").required();
  program.add_argument("--func").help("function name");
  program.parse_args(argc, argv);
  auto const inputPath = program.get<std::string>("--input");
  auto const outputPath = program.get<std::string>("--output");
  auto const presetOptName = program.get<std::string>("--pass");
  auto const functionRegex = program.present<std::string>("--func");

  passes::PresetOpt presetOpt;
  try {
    presetOpt = passes::getPresetOpt(presetOptName);
  } catch (std::exception const &e) {
    fmt::println("ERROR: {}", e.what());
    return 1;
  }

  std::ifstream ifstream{inputPath, std::ios::in};
  if (!ifstream.good()) {
    fmt::println("ERROR: failed to open file: {}", inputPath);
    return 1;
  }
  std::string input{std::istreambuf_iterator<char>{ifstream}, {}};

  std::string wat = passes::runOnWat(input, presetOpt,
                                     functionRegex.has_value() ? std::make_optional<std::regex>(functionRegex.value())
                                                               : std::nullopt);

  std::ofstream watOf{outputPath, std::ios::out};
  if (!watOf.good()) {
    fmt::println("ERROR: failed to open file: {}", outputPath);
    return 1;
  }
  watOf.write(wat.data(), static_cast<std::streamsize>(wat.size()));
}
