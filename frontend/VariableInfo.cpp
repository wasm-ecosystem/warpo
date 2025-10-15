///
/// @file VariableInfo.cpp
/// @copyright Copyright (C) 2025 wasm-ecosystem
/// SPDX-License-Identifier: Apache-2.0
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <unordered_map>
#include <utility>
#include <vector>

#include "AsString.hpp"
#include "VariableInfo.hpp"

#include "src/core/common/function_traits.hpp"

// LLVM DWARF YAML includes for testing
#include "binaryen/src/support/istring.h"
#include "llvm/BinaryFormat/Dwarf.h"
#include "llvm/DebugInfo/DWARF/DWARFContext.h"
#include "llvm/DebugInfo/DWARF/DWARFDie.h"
#include "llvm/ObjectYAML/DWARFEmitter.h"
#include "llvm/ObjectYAML/DWARFYAML.h"
#include "llvm/Support/YAMLTraits.h"
#include "llvm/Support/raw_ostream.h"

namespace warpo::frontend {

class FieldInfo final {
  wasm::IString name_;
  wasm::IString type_;
  uint32_t offsetInClass_;
  bool nullable_;
};

class InterfaceInfo final {};

class ClassInfo final {
public:
  ClassInfo(wasm::IString name, wasm::IString parentName, uint32_t const rtid)
      : name_(std::move(name)), parentName_(std::move(parentName)), rtid_(rtid) {}

  uint32_t getSize() const noexcept {
    return 0U; // implement later
  }

  std::string_view const getName() const noexcept { return name_.str; }

  std::vector<FieldInfo> const &getFields() const noexcept { return fields_; }

private:
  wasm::IString name_;
  wasm::IString parentName_;
  uint32_t rtid_;
  std::vector<FieldInfo> fields_;
  std::vector<InterfaceInfo> interfaces_;
};

std::unordered_map<std::string, ClassInfo> classRegistry;

// Helper for automatic DWARF code assignment (since LLVM's DWARFYAML doesn't do it)
class DWARFAutoAssigner {
private:
  std::unordered_map<std::string, size_t> stringOffsets_;
  uint32_t nextAbbrevCode_ = 1;
  // Own copies of strings added to the debug_str so StringRefs remain valid
  std::vector<std::string> ownedStrings_;

public:
  // Assign abbreviation codes automatically if set to 0
  void assignAbbrevCode(llvm::DWARFYAML::Abbrev &abbrev) { abbrev.Code = nextAbbrevCode_++; }

  // Assign string offsets automatically. Copies the string into owned storage so
  // returned StringRefs remain valid even if the caller passes a temporary.
  size_t assignStringOffset(llvm::StringRef str, std::vector<llvm::StringRef> &debugStrings) {
    auto it = stringOffsets_.find(str.str());
    if (it != stringOffsets_.end()) {
      return it->second; // Reuse existing string
    }

    // Calculate current offset (before adding the new string)
    size_t offset = 0;
    for (const auto &existing : debugStrings) {
      offset += existing.size() + 1; // +1 for null terminator
    }

    // Copy string into owned storage and reference it
    ownedStrings_.emplace_back(str.str());
    stringOffsets_[ownedStrings_.back()] = offset;
    debugStrings.emplace_back(ownedStrings_.back());

    return offset;
  }
};

void VariableInfo::createClass(uint32_t const classNamePtr, uint32_t const parentNamePtr, uint32_t const rtid,
                               vb::WasmModule const *const ctx) {
  std::string const className{AsString::get(classNamePtr, ctx)};
  std::string const parentName{AsString::get(parentNamePtr, ctx)};
  std::cout << className << " extends " << parentName << " rtid=" << rtid << std::endl;

  classRegistry.emplace(className, ClassInfo{wasm::IString(className), wasm::IString(parentName), rtid});
}

void VariableInfo::dumpElf() {
  std::cout << "\n=== Creating DWARF Debug Information ===\n";

  // Create DWARF YAML data structure
  llvm::DWARFYAML::Data dwarfData;
  dwarfData.IsLittleEndian = true;

  // Initialize auto-assigner for DWARF codes and offsets
  DWARFAutoAssigner assigner;

  // 1. Create debug abbreviation of root node with DW_AT_producer attribute
  std::vector<llvm::DWARFYAML::Abbrev> abbrevDecls;

  llvm::DWARFYAML::Abbrev rootAbbrev;
  rootAbbrev.Code = 0; // Will be auto-assigned by assigner
  rootAbbrev.Tag = llvm::dwarf::DW_TAG_compile_unit;
  rootAbbrev.Children = llvm::dwarf::DW_CHILDREN_yes;
  rootAbbrev.ListOffset = 0;

  // Add DW_AT_producer attribute with DW_FORM_strp form
  llvm::DWARFYAML::AttributeAbbrev producerAttr;
  producerAttr.Attribute = llvm::dwarf::DW_AT_producer;
  producerAttr.Form = llvm::dwarf::DW_FORM_strp;
  producerAttr.Value = 0;
  rootAbbrev.Attributes.push_back(producerAttr);

  // Auto-assign abbreviation code
  assigner.assignAbbrevCode(rootAbbrev);
  abbrevDecls.push_back(rootAbbrev);

  // 2. Create debug abbreviation for class type with DW_AT_name and DW_AT_byte_size
  llvm::DWARFYAML::Abbrev classAbbrev;
  classAbbrev.Code = 0; // Will be auto-assigned by assigner
  classAbbrev.Tag = llvm::dwarf::DW_TAG_class_type;
  classAbbrev.Children = llvm::dwarf::DW_CHILDREN_no;
  classAbbrev.ListOffset = 0;

  // Add DW_AT_name attribute with DW_FORM_string form
  llvm::DWARFYAML::AttributeAbbrev nameAttr;
  nameAttr.Attribute = llvm::dwarf::DW_AT_name;
  nameAttr.Form = llvm::dwarf::DW_FORM_string;
  nameAttr.Value = 0;
  classAbbrev.Attributes.push_back(nameAttr);

  // Add DW_AT_byte_size attribute with DW_FORM_data1 form
  llvm::DWARFYAML::AttributeAbbrev byteSizeAttr;
  byteSizeAttr.Attribute = llvm::dwarf::DW_AT_byte_size;
  byteSizeAttr.Form = llvm::dwarf::DW_FORM_data4;
  byteSizeAttr.Value = 0;
  classAbbrev.Attributes.push_back(byteSizeAttr);

  // Auto-assign abbreviation code
  assigner.assignAbbrevCode(classAbbrev);
  abbrevDecls.push_back(classAbbrev);

  // 3. Create debug abbreviation for member (field) with DW_AT_name, DW_AT_type, and DW_AT_data_member_location
  llvm::DWARFYAML::Abbrev memberAbbrev;
  memberAbbrev.Code = 0; // Will be auto-assigned by assigner
  memberAbbrev.Tag = llvm::dwarf::DW_TAG_member;
  memberAbbrev.Children = llvm::dwarf::DW_CHILDREN_no;
  memberAbbrev.ListOffset = 0;

  // Add DW_AT_name attribute with DW_FORM_string form
  llvm::DWARFYAML::AttributeAbbrev memberNameAttr;
  memberNameAttr.Attribute = llvm::dwarf::DW_AT_name;
  memberNameAttr.Form = llvm::dwarf::DW_FORM_string;
  memberNameAttr.Value = 0;
  memberAbbrev.Attributes.push_back(memberNameAttr);

  // Add DW_AT_type attribute with DW_FORM_ref4 form
  llvm::DWARFYAML::AttributeAbbrev memberTypeAttr;
  memberTypeAttr.Attribute = llvm::dwarf::DW_AT_type;
  memberTypeAttr.Form = llvm::dwarf::DW_FORM_ref4;
  memberTypeAttr.Value = 0;
  memberAbbrev.Attributes.push_back(memberTypeAttr);

  // Add DW_AT_data_member_location attribute with DW_FORM_data4 form
  llvm::DWARFYAML::AttributeAbbrev memberLocationAttr;
  memberLocationAttr.Attribute = llvm::dwarf::DW_AT_data_member_location;
  memberLocationAttr.Form = llvm::dwarf::DW_FORM_data4;
  memberLocationAttr.Value = 0;
  memberAbbrev.Attributes.push_back(memberLocationAttr);

  // Auto-assign abbreviation code
  assigner.assignAbbrevCode(memberAbbrev);
  abbrevDecls.push_back(memberAbbrev);

  // Add terminator (code 0 - never auto-assigned)
  llvm::DWARFYAML::Abbrev terminator;
  terminator.Code = 0;
  terminator.Tag = llvm::dwarf::DW_TAG_null;
  terminator.Children = llvm::dwarf::DW_CHILDREN_no;
  terminator.ListOffset = 0;
  abbrevDecls.push_back(terminator);

  dwarfData.AbbrevDecls = abbrevDecls;

  // 2. Add debug strings with auto-offset assignment (now owned by assigner)
  std::vector<llvm::StringRef> debugStrings;
  size_t producerOffset = assigner.assignStringOffset("warpo", debugStrings);
  dwarfData.DebugStrings = debugStrings;

  // 3. Add debug info tree root node
  std::vector<llvm::DWARFYAML::Unit> compileUnits;

  llvm::DWARFYAML::Unit rootUnit;
  rootUnit.Length.setLength(0); // Will be auto-calculated
  rootUnit.Version = 4;
  rootUnit.AbbrOffset = 0;
  rootUnit.AddrSize = 4; // 32-bit addresses for wasm32

  // Create the root DIE (Debug Information Entry)
  llvm::DWARFYAML::Entry rootEntry;
  rootEntry.AbbrCode = rootAbbrev.Code; // Use the auto-indexed abbreviation code

  // Create form value for the producer string (auto-indexed offset)
  llvm::DWARFYAML::FormValue producerValue;
  producerValue.Value = producerOffset; // Auto-calculated offset in debug_str section
  rootEntry.Values.push_back(producerValue);

  rootUnit.Entries.push_back(rootEntry);

  // Add class DIEs for each class in the registry
  std::cout << "Adding " << classRegistry.size() << " classes to debug info\n";
  for (const auto &[className, classInfo] : classRegistry) {
    llvm::DWARFYAML::Entry classEntry;
    classEntry.AbbrCode = classAbbrev.Code; // Use the class abbreviation

    // Add DW_AT_name value (inline string)
    llvm::DWARFYAML::FormValue classNameValue;
    classNameValue.CStr = className; // DW_FORM_string - inline string uses CStr field
    classEntry.Values.push_back(classNameValue);

    // Add DW_AT_byte_size value
    llvm::DWARFYAML::FormValue classSizeValue;
    classSizeValue.Value = classInfo.getSize(); // DW_FORM_data4 - 4 bytes, uses Value field
    classEntry.Values.push_back(classSizeValue);

    rootUnit.Entries.push_back(classEntry);
    std::cout << "  Added class: " << className << " (size: " << classInfo.getSize() << ")\n";
  }

  compileUnits.push_back(rootUnit);
  dwarfData.CompileUnits = compileUnits;

  std::cout << "Length before fixup: " << rootUnit.Length.getLength() << "\n";

  // Use LLVM's built-in EmitDebugSections with ApplyFixups=true to automatically calculate lengths
  llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> const debugSections =
      llvm::DWARFYAML::EmitDebugSections(dwarfData, true);

  std::cout << "Length after fixup: " << dwarfData.CompileUnits[0].Length.getLength() << "\n";

  // Create DWARF context and save human-readable dump
  auto dwarfContext = llvm::DWARFContext::create(debugSections, 4, true);

  // NOTE: Binaryen stubs out raw_fd_ostream to only write to stdout,
  // so we capture to string then write to file
  std::string dumpOutput;
  llvm::raw_string_ostream dumpStream(dumpOutput);
  llvm::DIDumpOptions dumpOptions;
  dumpOptions.ShowChildren = true;
  dumpOptions.ShowParents = false;
  dumpOptions.ShowForm = false;
  dumpOptions.SummarizeTypes = false;
  dumpOptions.Verbose = false;
  dumpOptions.DisplayRawContents = false;
  dwarfContext->dump(dumpStream, dumpOptions);
  dumpStream.flush();

  // Write to file
  std::ofstream outFile("/home/jcq/workspace/warpo/debug_info_dump.txt");
  if (outFile) {
    outFile << dumpOutput;
    outFile.close();
    std::cout << "DWARF dump saved to: debug_info_dump.txt (" << dumpOutput.size() << " bytes)\n";
  } else {
    std::cerr << "Failed to create debug_info_dump.txt\n";
  }

  std::cout << "\n=== End DWARF Debug Information ===\n\n";
}

std::vector<vb::NativeSymbol> VariableInfo::createVariableInfoAPI() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("warpo", "_WarpoCreateClass", createClass),
  };
}
} // namespace warpo::frontend