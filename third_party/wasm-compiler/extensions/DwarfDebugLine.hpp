#ifndef EXTENSIONS_DWARF_DEBUG_LINE_HPP
#define EXTENSIONS_DWARF_DEBUG_LINE_HPP

#include <cstdint>
#include <string>
#include <vector>

namespace vb {
namespace extension {

/// @brief DebugLineOpCode
struct DebugLineOpCode {
  /// @brief OpCodeKind
  enum class OpCodeKind : uint8_t {
    advance_pc,
    advance_line,
    copy,
  };
  OpCodeKind kind_; ///< kind of op code
  /// @brief AdvancePC
  struct AdvancePC {
    uint32_t offset_; ///< offset in bytes
  };
  /// @brief AdvanceLine
  struct AdvanceLine {
    int32_t offset_; ///< offset in bytes
  };
  /// @brief Copy
  struct Copy {};
  /// @brief DebugLineOpCodeUnion
  union DebugLineOpCodeUnion {
    AdvancePC advancePC_;     ///< DW_LNS_advance_pc
    AdvanceLine advanceLine_; ///< DW_LNS_advance_line
    Copy copy_;               ///< DW_LNS_copy
  };

  DebugLineOpCodeUnion v_; ///< union of debug line op codes
};

/// @brief DebugLine
struct DebugLine {
  std::string fileName_;
  std::vector<DebugLineOpCode> sequences_; ///< sequence of op codes
};

} // namespace extension
} // namespace vb

#endif // EXTENSIONS_DWARF_DEBUG_LINE_HPP
