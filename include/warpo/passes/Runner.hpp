#pragma once

#include <binaryen/src/binaryen-c.h>
#include <cstdint>
#include <regex>
#include <string>
#include <vector>

namespace warpo::passes {

struct Output {
  std::string wat;
  std::vector<uint8_t> wasm;
};

void init();
Output runOnWat(std::string const &input);
Output runOnModule(BinaryenModuleRef const module);

std::string runOnWatForTesting(std::string const &input, std::regex const &targetFunctionRegex);

} // namespace warpo::passes
