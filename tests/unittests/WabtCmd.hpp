#include <cstdint>
#include <string>
#include <vector>
namespace vb {
namespace test {
class WabtCmd final {
public:
  static std::vector<uint8_t> const loadWasmFromWat(std::string_view const watStr);

private:
  static std::vector<uint8_t> parseHexDump(const std::string &hexDump);
};
} // namespace test
} // namespace vb