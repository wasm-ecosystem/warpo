#ifndef SRC_CORE_COMPILER_ANALYTICS_DWARF_DEBUG_INFO_HPP
#define SRC_CORE_COMPILER_ANALYTICS_DWARF_DEBUG_INFO_HPP

#include <cstdint>
#include <vector>

namespace vb {
namespace extension {

/// @brief information needed by debug info section
struct DebugInfo final {
  /// @brief function information for DWARF debug info
  struct Function {
    uint32_t lowPC;  ///< Low program counter (start address)
    uint32_t highPC; ///< High program counter (end address)
  };
  std::vector<Function> functions_; ///< List of functions with their address ranges
};

} // namespace extension
} // namespace vb

#endif // SRC_CORE_COMPILER_ANALYTICS_DWARF_DEBUG_INFO_HPP
