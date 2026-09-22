// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
#pragma once

#include <cstdint>
#include <deque>
#include <optional>
#include <string_view>
#include <vector>

#include "FieldInfo.hpp"
#include "SubProgramInfo.hpp"

namespace warpo {

class InterfaceInfo final {
public:
  explicit InterfaceInfo(std::string_view const name) noexcept : name_(name) {}

  std::string_view getName() const noexcept { return name_; }
  void addBaseInterface(std::string_view const parentName) noexcept { parentName_ = parentName; }
  std::string_view getParentName() const noexcept { return parentName_; }

  // Layout fields introduce a new storage entry; redeclarations are not included.
  void addLayoutField(std::string name, std::string_view const type, uint32_t const offsetInClass, bool const nullable);
  std::vector<FieldInfo> const &getLayoutFields() const noexcept { return layoutFields_; }
  // Declared fields contain every declaration, including redeclarations that reuse an inherited offset.
  void addDeclaredField(std::string name, std::string_view const type, uint32_t const offsetInClass,
                        bool const nullable);
  std::vector<FieldInfo> const &getDeclaredFields() const noexcept { return declaredFields_; }

  void addTemplateType(std::string_view const typeName) noexcept { templateTypes_.push_back(typeName); }
  std::vector<std::string_view> const &getTemplateTypes() const noexcept { return templateTypes_; }

  SubProgramInfo &addSubProgram(std::string_view const subProgramName, std::string_view const sourcePath,
                                uint32_t const startLine, uint32_t const endLine,
                                std::optional<std::string_view> const outerFunction = std::nullopt) {
    return memberFunctions_.emplace_back(subProgramName, sourcePath, startLine, endLine, outerFunction);
  }

  std::deque<SubProgramInfo> const &getSubPrograms() const noexcept { return memberFunctions_; }

private:
  std::string_view name_;
  std::string_view parentName_;
  std::vector<FieldInfo> layoutFields_;
  std::vector<FieldInfo> declaredFields_;
  std::vector<std::string_view> templateTypes_;
  std::deque<SubProgramInfo> memberFunctions_;
};

class ClassInfo final {
public:
  explicit ClassInfo(std::string_view const name, uint32_t const rtid) noexcept : name_(name), rtid_(rtid) {}
  explicit ClassInfo(std::string_view const name) noexcept : name_(name) {}

  std::string_view getName() const noexcept { return name_; }
  std::optional<uint32_t> getRtid() const noexcept { return rtid_; }
  // Layout fields introduce a new storage entry; redeclarations are not included.
  std::vector<FieldInfo> const &getLayoutFields() const noexcept { return layoutFields_; }
  // Declared fields contain every declaration, including redeclarations that reuse an inherited offset.
  std::vector<FieldInfo> const &getDeclaredFields() const noexcept { return declaredFields_; }

  void addLayoutField(std::string name, std::string_view const type, uint32_t const offsetInClass, bool const nullable);
  void addDeclaredField(std::string name, std::string_view const type, uint32_t const offsetInClass,
                        bool const nullable);

  void setDebugInfoOffset(uint64_t offset) noexcept { debugInfoOffset_ = offset; }
  uint64_t getDebugInfoOffset() const noexcept { return debugInfoOffset_; }

  void addTemplateType(std::string_view const typeName) noexcept { templateTypes_.push_back(typeName); }
  void addBaseClass(std::string_view const parentName) noexcept { parentName_ = parentName; }
  std::string_view getParentName() const noexcept { return parentName_; }
  void addInterface(std::string_view const interfaceName) { interfaces_.push_back(interfaceName); }
  std::vector<std::string_view> const &getInterfaces() const noexcept { return interfaces_; }

  std::vector<std::string_view> const &getTemplateTypes() const noexcept { return templateTypes_; }

  SubProgramInfo &addSubProgram(std::string_view const subProgramName, std::string_view const sourcePath,
                                uint32_t const startLine, uint32_t const endLine,
                                std::optional<std::string_view> const outerFunction = std::nullopt) {
    return memberFunctions_.emplace_back(subProgramName, sourcePath, startLine, endLine, outerFunction);
  }

  std::deque<SubProgramInfo> const &getSubPrograms() const noexcept { return memberFunctions_; }

private:
  std::string_view name_;
  std::optional<uint32_t> rtid_;
  std::string_view parentName_;
  size_t debugInfoOffset_{SIZE_MAX};
  std::vector<FieldInfo> layoutFields_;
  std::vector<FieldInfo> declaredFields_;
  std::vector<std::string_view> interfaces_;
  std::vector<std::string_view> templateTypes_;
  std::deque<SubProgramInfo> memberFunctions_;
};

} // namespace warpo
