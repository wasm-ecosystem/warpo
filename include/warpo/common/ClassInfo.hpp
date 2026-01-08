// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <cstdint>
#include <string_view>
#include <vector>

#include "FieldInfo.hpp"
#include "SubProgramRegistry.hpp"

namespace warpo {

class InterfaceInfo final {};

class ClassInfo final {
public:
  inline ClassInfo(std::string_view const name, std::string_view const parentName, uint32_t const rtid) noexcept
      : name_(name), parentName_(parentName), rtid_(rtid), debugInfoOffset_(SIZE_MAX) {}

  inline std::string_view getName() const noexcept { return name_; }
  inline uint32_t getRtid() const noexcept { return rtid_; }
  inline std::vector<FieldInfo> const &getFields() const noexcept { return fields_; }

  void addMember(std::string name, std::string_view const type, uint32_t const offsetInClass, bool const nullable);

  inline void setDebugInfoOffset(uint64_t offset) noexcept { debugInfoOffset_ = offset; }
  inline uint64_t getDebugInfoOffset() const noexcept { return debugInfoOffset_; }

  inline void addTemplateType(std::string_view const typeName) noexcept { templateTypes_.push_back(typeName); }

  std::vector<std::string_view> const &getTemplateTypes() const noexcept { return templateTypes_; }

  inline SubProgramInfo &addSubProgram(std::string subProgramName) {
    return classMemberFunctionRegistry_.addSubProgram(std::move(subProgramName));
  }

  inline SubProgramRegistry const &getSubProgramRegistry() const noexcept { return classMemberFunctionRegistry_; }

private:
  std::string_view name_;
  std::string_view parentName_;
  uint32_t rtid_;
  size_t debugInfoOffset_;
  std::vector<FieldInfo> fields_;
  std::vector<InterfaceInfo> interfaces_;
  std::vector<std::string_view> templateTypes_;
  SubProgramRegistry classMemberFunctionRegistry_;
};

} // namespace warpo
