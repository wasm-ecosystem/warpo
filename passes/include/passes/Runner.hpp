#pragma once

#include <cstdint>
#include <vector>

namespace warpo::passes {

void init();

std::vector<uint8_t> run(std::vector<char> const &input, std::vector<const char *> const &passNames);

} // namespace warpo::passes
