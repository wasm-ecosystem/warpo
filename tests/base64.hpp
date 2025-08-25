#ifndef TESTS_BASE64
#define TESTS_BASE64

#include <cstdint>
#include <string>
#include <vector>

namespace Base64 {
std::vector<uint8_t> b64decode(std::string const &str);
} // namespace Base64

#endif
