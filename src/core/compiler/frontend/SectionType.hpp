///
/// @file SectionType.hpp
/// @copyright Copyright (C) 2025 BMW Group
///

#ifndef SRC_CORE_COMPILER_FRONTEND_SECTIONTYPE_HPP
#define SRC_CORE_COMPILER_FRONTEND_SECTIONTYPE_HPP

#include <cstdint>

namespace vb {

///
/// @brief WebAssembly section IDs
///
enum class SectionType : uint8_t {
  CUSTOM = 0,
  TYPE,
  IMPORT,
  FUNCTION,
  TABLE,
  MEMORY,
  GLOBAL,
  EXPORT,
  START,
  ELEMENT,
  CODE,
  DATA,
  DATA_COUNT,
  PLACEHOLDER ///< module end
};

} // namespace vb

#endif // SRC_CORE_COMPILER_FRONTEND_SECTIONTYPE_HPP
