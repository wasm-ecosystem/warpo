#pragma once

#include <cstdint>
#include <vector>

namespace warpo::passes {

void init();

struct Output {
  std::string wat;
  std::vector<uint8_t> wasm;
};

Output runOnWasm(std::vector<char> const &input, std::vector<const char *> const &passNames);
Output runOnWat(std::string const &input, std::vector<const char *> const &passNames);

} // namespace warpo::passes
