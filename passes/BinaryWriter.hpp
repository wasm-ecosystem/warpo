// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#pragma once

#include <llvm/ADT/StringMap.h>
#include <llvm/Support/MemoryBuffer.h>
#include <memory>
#include <pass.h>
#include <sstream>
#include <wasm-binary.h>

#include "warpo/common/AsModule.hpp"

namespace warpo::passes {

class BinaryWriter {
  wasm::PassOptions const options_;
  AsModule const &m_;
  wasm::BufferWithRandomAccess buffer_;
  std::stringstream sourceMapStream_;
  wasm::WasmBinaryWriter writer_;
  bool emitDwarf_ = false;
  llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> debugSections_;

public:
  explicit BinaryWriter(AsModule const &m)
      : options_(wasm::PassOptions::getWithoutOptimization()), m_(m), writer_{m.get(), buffer_, options_} {}
  void setSourceMapEnabled(bool enabled, std::string const &sourceMapURL) {
    if (enabled)
      writer_.setSourceMap(&sourceMapStream_, sourceMapURL);
    else
      writer_.setSourceMap(nullptr, "");
  }
  void setNameSectionEnabled(bool enabled) { writer_.setNamesSection(enabled); }
  void setDwarfEnabled(bool enabled) { emitDwarf_ = enabled; }

  void write();

  wasm::WasmBinaryWriter const &raw() const { return writer_; }
  std::vector<uint8_t> getBinary() const { return std::vector<uint8_t>{buffer_.begin(), buffer_.end()}; }
  std::string getSourceMap() const { return sourceMapStream_.str(); }
  std::string dumpDwarf() const;
};

} // namespace warpo::passes
