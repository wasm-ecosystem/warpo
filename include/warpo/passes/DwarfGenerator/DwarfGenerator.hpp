// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <cstdint>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <string_view>

#include "llvm/ADT/StringMap.h"
#include "llvm/Support/MemoryBuffer.h"
#include "warpo/common/VariableInfo.hpp"

namespace warpo::passes {

struct TypeRefFixup final {
  size_t entryIndex;
  size_t valueIndex;
  std::string_view typeName;
};

class DwarfGenerator final {
public:
  using GlobalIndexResolver = std::function<std::optional<uint32_t>(std::string_view)>;

  static llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>>
  generateDebugSections(VariableInfo const &variableInfo, GlobalIndexResolver globalIndexResolver);
  static std::string dumpDwarf(llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> const &debugSections);

  struct AbbrevCodes final {
    uint32_t subprogram;
    uint32_t closureSubprogram;
    uint32_t formalParameter;
    uint32_t tupleFieldFormalParameter;
    uint32_t lexicalBlock;
    uint32_t localVariable;
    uint32_t tupleFieldLocalVariable;
  };
};

} // namespace warpo::passes