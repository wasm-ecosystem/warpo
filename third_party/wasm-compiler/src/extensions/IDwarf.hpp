#ifndef SRC_CORE_COMPILER_EXTENSIONS_IDWARF_HPP
#define SRC_CORE_COMPILER_EXTENSIONS_IDWARF_HPP

#include <cstdint>

#include "src/core/compiler/common/StackElement.hpp"
#include "src/core/compiler/common/StackType.hpp"

namespace vb {
namespace extension {

/// @brief abstract interface for DWARF5 generator in WARP
class IDwarf5Generator {
public:
  /// @brief virtual destructor for IDwarf5Generator
  virtual ~IDwarf5Generator() = default;

  /// @brief prepare defer action for later usage
  virtual void registerPendingDeferAction(StackElement const *stackElement, uint32_t const sourceOffset) = 0;

  /// @brief start code gen for stack element which must be prepared before
  virtual void startOp(StackElement const *stackElement) = 0;
  /// @brief start code gen for op
  virtual void startOp(uint32_t const sourceOffset) = 0;
  /// @brief finish code gen for op
  virtual void finishOp() = 0;

  /// @brief record a location in the debug info
  virtual void record(uint32_t const destinationOffset) = 0;

  /// @brief start code gen for function
  virtual void startFunction(uint32_t const destinationOffset) = 0;
  /// @brief finish code gen for function
  virtual void finishFunction(uint32_t const destinationOffset) = 0;
};

} // namespace extension
} // namespace vb

#endif // SRC_CORE_COMPILER_EXTENSIONS_IDWARF_HPP
