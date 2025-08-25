// clang-format-off
#include <array>
#include <cstdint>
#include <cstdlib>

std::array<uint8_t, 1> constexpr bytecode = {0U};

const uint8_t *bytecodeStart = bytecode.data();
size_t bytecodeLength = bytecode.size();

// clang-format-on