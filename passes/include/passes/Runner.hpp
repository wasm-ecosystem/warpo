#pragma once

#include <cstdint>
#include <vector>

namespace warpo::passes {

struct Output {
  std::string wat;
  std::vector<uint8_t> wasm;
};

Output runOnWasm(std::vector<char> const &input);
Output runOnWat(std::string const &input);

} // namespace warpo::passes
