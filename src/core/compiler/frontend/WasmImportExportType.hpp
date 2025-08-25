///
/// @file WasmImportExportType.hpp
/// @copyright Copyright (C) 2021 BMW Group
///

#ifndef WASMIMPORTEXPORTTYPE_HPP
#define WASMIMPORTEXPORTTYPE_HPP

#include <cstdint>

namespace vb {

///
/// @brief WebAssembly import and export types
///
enum class WasmImportExportType : uint8_t { FUNC = 0x00, TABLE = 0x01, MEM = 0x02, GLOBAL = 0x03 };

} // namespace vb

#endif
