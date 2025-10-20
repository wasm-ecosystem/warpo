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
#include <cassert>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <regex>
#include <unordered_map>
#include <utility>
#include <vector>

#include "AsString.hpp"
#include "VariableInfo.hpp"

#include "src/core/common/function_traits.hpp"

// LLVM DWARF YAML includes for testing
#include "binaryen/src/support/istring.h"
#include "binaryen/third_party/llvm-project/DWARFVisitor.h"
#include "llvm/BinaryFormat/Dwarf.h"
#include "llvm/DebugInfo/DWARF/DWARFContext.h"
#include "llvm/DebugInfo/DWARF/DWARFDie.h"
#include "llvm/ObjectYAML/DWARFEmitter.h"
#include "llvm/ObjectYAML/DWARFYAML.h"
#include "llvm/Support/LEB128.h"
#include "llvm/Support/YAMLTraits.h"
#include "llvm/Support/raw_ostream.h"

namespace warpo::frontend {

class FieldInfo final {
public:
  FieldInfo(wasm::IString name, wasm::IString type, uint32_t offsetInClass, bool nullable)
      : name_(std::move(name)), type_(normalizeTypeName(type)), offsetInClass_(offsetInClass), nullable_(nullable) {}

  std::string_view getName() const noexcept { return name_.str; }
  std::string_view getType() const noexcept { return type_.str; }
  uint32_t getOffsetInClass() const noexcept { return offsetInClass_; }
  bool isNullable() const noexcept { return nullable_; }

private:
  // Normalize short basic type names to full AssemblyScript type names
  // e.g., "i32" -> "~lib/number/I32", "usize" -> "~lib/number/Usize"
  // Assumes input is already lowercase
  static wasm::IString normalizeTypeName(const wasm::IString &type) noexcept {
    std::string_view typeStr = type.str;

    // Map of lowercase short names to full type names
    static const std::unordered_map<std::string_view, std::string_view> basicTypeMap = {
        {"i8", "~lib/number/I8"},   {"u8", "~lib/number/U8"},       {"i16", "~lib/number/I16"},
        {"u16", "~lib/number/U16"}, {"i32", "~lib/number/I32"},     {"u32", "~lib/number/U32"},
        {"i64", "~lib/number/I64"}, {"u64", "~lib/number/U64"},     {"f32", "~lib/number/F32"},
        {"f64", "~lib/number/F64"}, {"usize", "~lib/number/Usize"},
    };

    // Check if it's a basic type that needs mapping
    auto it = basicTypeMap.find(typeStr);
    if (it != basicTypeMap.end()) {
      return wasm::IString(std::string(it->second).c_str());
    }

    // Return original if not a basic type
    return type;
  }

  wasm::IString name_;
  wasm::IString type_;
  uint32_t offsetInClass_;
  bool nullable_;
};

class InterfaceInfo final {};

class ClassInfo final {
public:
  ClassInfo(wasm::IString name, wasm::IString parentName, uint32_t const size, uint32_t const rtid)
      : name_(std::move(name)), parentName_(std::move(parentName)), size_(size), rtid_(rtid),
        debugInfoOffset_(SIZE_MAX) {}

  uint32_t getSize() const noexcept { return size_; }

  std::string_view const getName() const noexcept { return name_.str; }

  std::vector<FieldInfo> const &getFields() const noexcept { return fields_; }

  void addMember(wasm::IString name, wasm::IString type, uint32_t offsetInClass, bool nullable) {
    fields_.emplace_back(FieldInfo{std::move(name), std::move(type), offsetInClass, nullable});
  }

  void setDebugInfoOffset(uint64_t offset) noexcept { debugInfoOffset_ = offset; }

  uint64_t getDebugInfoOffset() const noexcept { return debugInfoOffset_; }

  bool isBasicType() const noexcept {
    // Match basic type patterns like:
    // ~lib/number/F32, ~lib/number/F64
    // ~lib/number/U8, ~lib/number/I8
    // ~lib/number/U16, ~lib/number/I16
    // ~lib/number/U32, ~lib/number/I32
    // ~lib/number/U64, ~lib/number/I64
    // ~lib/number/Usize
    static const std::regex basicTypePattern(R"(~lib/number/(F32|F64|U8|I8|U16|I16|U32|I32|U64|I64|Usize))");
    return std::regex_match(name_.str.begin(), name_.str.end(), basicTypePattern);
  }

private:
  wasm::IString name_;
  wasm::IString parentName_;
  uint32_t size_;
  uint32_t rtid_;
  size_t debugInfoOffset_;
  std::vector<FieldInfo> fields_;
  std::vector<InterfaceInfo> interfaces_;
};

std::unordered_map<std::string, ClassInfo> classRegistry;

// Calculate DIE offsets by traversing the entries and updating classRegistry
class DIEOffsetCalculator : public llvm::DWARFYAML::Visitor {
private:
  uint64_t currentOffset_ = 0;
  std::unordered_map<std::string, ClassInfo> &classRegistry_;

  void onStartCompileUnit([[maybe_unused]] llvm::DWARFYAML::Unit &CU) override {
    // CU header: length(4) + version(2) + abbr_offset(4) + addr_size(1) = 11 bytes
    currentOffset_ = 11;
  }

  void onStartDIE([[maybe_unused]] llvm::DWARFYAML::Unit &CU, llvm::DWARFYAML::Entry &DIE) override {
    // Store the offset of this DIE before processing it
    uint64_t dieOffset = currentOffset_;

    // Find the abbreviation for this DIE to extract its name
    for (const auto &abbrev : DebugInfo.AbbrevDecls) {
      if (abbrev.Code == DIE.AbbrCode.value) {
        // Check if this abbrev has a DW_AT_name attribute
        size_t valueIndex = 0;
        for (const auto &attr : abbrev.Attributes) {
          if (attr.Attribute == llvm::dwarf::DW_AT_name && valueIndex < DIE.Values.size()) {
            // Extract the name from the form value
            const auto &nameValue = DIE.Values[valueIndex];
            if (!nameValue.CStr.empty()) {
              // This DIE has a name, update the class registry with its offset
              std::string dieName(nameValue.CStr.data(), nameValue.CStr.size());
              auto it = classRegistry_.find(dieName);
              if (it != classRegistry_.end()) {
                it->second.setDebugInfoOffset(dieOffset);
              }
            }
          }
          valueIndex++;
        }
        break;
      }
    }

    // Add size of abbrev code (ULEB128 - typically 1 byte for codes < 128)
    currentOffset_ += llvm::getULEB128Size(DIE.AbbrCode.value);
  }

  void onValue([[maybe_unused]] const uint8_t U) override { currentOffset_ += 1; }
  void onValue([[maybe_unused]] const uint16_t U) override { currentOffset_ += 2; }
  void onValue([[maybe_unused]] const uint32_t U) override { currentOffset_ += 4; }
  void onValue(const uint64_t U, const bool LEB = false) override {
    if (LEB)
      currentOffset_ += llvm::getULEB128Size(U);
    else
      currentOffset_ += 8;
  }
  void onValue(const int64_t S, const bool LEB = false) override {
    if (LEB)
      currentOffset_ += llvm::getSLEB128Size(S);
    else
      currentOffset_ += 8;
  }
  void onValue(const llvm::StringRef String) override { currentOffset_ += String.size() + 1; }
  void onValue(const llvm::MemoryBufferRef MBR) override { currentOffset_ += MBR.getBufferSize(); }

public:
  DIEOffsetCalculator(llvm::DWARFYAML::Data &DI, std::unordered_map<std::string, ClassInfo> &registry)
      : llvm::DWARFYAML::Visitor(DI), classRegistry_(registry) {}
};

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

void VariableInfo::addField(uint32_t const classNamePtr, uint32_t const fieldNamePtr, uint32_t const typeNamePtr,
                            uint32_t const offset, uint32_t const nullable, vb::WasmModule const *const ctx) {
  std::string const className{AsString::get(classNamePtr, ctx)};
  std::string const fieldName{AsString::get(fieldNamePtr, ctx)};
  std::string const typeName{AsString::get(typeNamePtr, ctx)};
  std::cout << "  field " << fieldName << " type " << typeName << " at offset " << offset
            << (nullable ? " nullable" : "") << std::endl;

  auto classIt = classRegistry.find(className);
  assert(classIt != classRegistry.end());
  classIt->second.addMember(wasm::IString(fieldName), wasm::IString(typeName), offset, nullable != 0);
}

void VariableInfo::createClass(uint32_t const classNamePtr, uint32_t const parentNamePtr, uint32_t const size,
                               uint32_t const rtid, vb::WasmModule const *const ctx) {
  std::string const className{AsString::get(classNamePtr, ctx)};
  std::string const parentName{AsString::get(parentNamePtr, ctx)};
  std::cout << className << " extends " << parentName << " rtid=" << rtid << std::endl;

  classRegistry.emplace(className, ClassInfo{wasm::IString(className), wasm::IString(parentName), size, rtid});
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
  classAbbrev.Children = llvm::dwarf::DW_CHILDREN_yes;
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

  // 4. Create debug abbreviation for base type with DW_AT_name and DW_AT_byte_size
  llvm::DWARFYAML::Abbrev baseTypeAbbrev;
  baseTypeAbbrev.Code = 0; // Will be auto-assigned by assigner
  baseTypeAbbrev.Tag = llvm::dwarf::DW_TAG_base_type;
  baseTypeAbbrev.Children = llvm::dwarf::DW_CHILDREN_no;
  baseTypeAbbrev.ListOffset = 0;

  // Add DW_AT_name attribute with DW_FORM_string form
  llvm::DWARFYAML::AttributeAbbrev baseTypeNameAttr;
  baseTypeNameAttr.Attribute = llvm::dwarf::DW_AT_name;
  baseTypeNameAttr.Form = llvm::dwarf::DW_FORM_string;
  baseTypeNameAttr.Value = 0;
  baseTypeAbbrev.Attributes.push_back(baseTypeNameAttr);

  // Add DW_AT_byte_size attribute with DW_FORM_data1 form
  llvm::DWARFYAML::AttributeAbbrev baseTypeSizeAttr;
  baseTypeSizeAttr.Attribute = llvm::dwarf::DW_AT_byte_size;
  baseTypeSizeAttr.Form = llvm::dwarf::DW_FORM_data1;
  baseTypeSizeAttr.Value = 0;
  baseTypeAbbrev.Attributes.push_back(baseTypeSizeAttr);

  // Auto-assign abbreviation code
  assigner.assignAbbrevCode(baseTypeAbbrev);
  abbrevDecls.push_back(baseTypeAbbrev);

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

  // STEP 1: Build complete DIE structure with members, but use placeholder type references
  // Track which member entries need their type references fixed up
  struct MemberFixup {
    size_t entryIndex;    // Index in rootUnit.Entries
    std::string typeName; // Name of the type this member references
  };
  std::vector<MemberFixup> memberFixups;

  std::cout << "Adding " << classRegistry.size() << " classes to debug info\n";
  for (const auto &[className, classInfo] : classRegistry) {
    bool const isBasicType = classInfo.isBasicType();

    llvm::DWARFYAML::Entry classEntry;

    // Use base type abbreviation for basic types, class abbreviation for others
    if (isBasicType) {
      classEntry.AbbrCode = baseTypeAbbrev.Code;
    } else {
      classEntry.AbbrCode = classAbbrev.Code;
    }

    // Add DW_AT_name value (inline string)
    llvm::DWARFYAML::FormValue classNameValue;
    classNameValue.CStr = className;
    classEntry.Values.push_back(classNameValue);

    // Add DW_AT_byte_size value
    llvm::DWARFYAML::FormValue classSizeValue;
    classSizeValue.Value = classInfo.getSize();
    classEntry.Values.push_back(classSizeValue);

    rootUnit.Entries.push_back(classEntry);
    std::cout << "  Added " << (isBasicType ? "base type" : "class") << ": " << className
              << " (size: " << classInfo.getSize() << ")\n";

    // For classes (not basic types), add members now
    if (!isBasicType) {
      std::vector<FieldInfo> const &fields = classInfo.getFields();
      for (const auto &field : fields) {
        llvm::DWARFYAML::Entry memberEntry;
        memberEntry.AbbrCode = memberAbbrev.Code;

        // Add DW_AT_name value
        llvm::DWARFYAML::FormValue memberNameValue;
        std::string_view fieldNameView = field.getName();
        memberNameValue.CStr = llvm::StringRef(fieldNameView.data(), fieldNameView.size());
        memberEntry.Values.push_back(memberNameValue);

        // Add DW_AT_type value (placeholder for now)
        llvm::DWARFYAML::FormValue memberTypeValue;
        memberTypeValue.Value = 0xDEADBEEF; // Obvious placeholder that will be fixed
        memberEntry.Values.push_back(memberTypeValue);

        // Add DW_AT_data_member_location value
        llvm::DWARFYAML::FormValue memberLocationValue;
        memberLocationValue.Value = field.getOffsetInClass();
        memberEntry.Values.push_back(memberLocationValue);

        // Remember this member needs its type reference fixed
        size_t memberIndex = rootUnit.Entries.size();
        memberFixups.push_back({memberIndex, std::string(field.getType())});

        rootUnit.Entries.push_back(memberEntry);
        std::cout << "    Added member: " << field.getName() << " (type: " << field.getType()
                  << ", offset: " << field.getOffsetInClass() << ") - needs fixup\n";
      }

      // Add terminator entry to mark end of children
      llvm::DWARFYAML::Entry childTerminator;
      childTerminator.AbbrCode = 0;
      rootUnit.Entries.push_back(childTerminator);
    }
  }

  compileUnits.push_back(rootUnit);
  dwarfData.CompileUnits = compileUnits;

  // STEP 2: Now that all DIEs are in place, calculate their offsets and update classRegistry
  std::cout << "\n=== Calculating DIE offsets ===\n";
  DIEOffsetCalculator offsetCalculator(dwarfData, classRegistry);
  offsetCalculator.traverseDebugInfo();

  // STEP 3: Fix up all member type references with actual DIE offsets
  std::cout << "=== Fixing up member type references ===\n";
  for (const auto &fixup : memberFixups) {
    // Strip nullable suffix " | null" if present
    std::string typeName = fixup.typeName;
    size_t nullablePos = typeName.find(" | null");
    if (nullablePos != std::string::npos) {
      typeName = typeName.substr(0, nullablePos);
    }

    // Look up the type directly in the registry (types are already normalized by FieldInfo)
    uint64_t typeOffset = 0;
    auto it = classRegistry.find(typeName);
    if (it != classRegistry.end()) {
      typeOffset = it->second.getDebugInfoOffset();
    }

    if (typeOffset > 0 && typeOffset != SIZE_MAX) {
      // The type reference is at Values[1] (0=name, 1=type, 2=location)
      dwarfData.CompileUnits[0].Entries[fixup.entryIndex].Values[1].Value = typeOffset;
      std::cout << "  Fixed member @ entry[" << fixup.entryIndex << "] type='" << fixup.typeName << "' @ offset=0x"
                << std::hex << typeOffset << std::dec << "\n";
    } else {
      std::cerr << "  ERROR: Could not find DIE offset for type '" << fixup.typeName << "' (after stripping nullable: '"
                << typeName << "')\n";
    }
  }
  std::cout << "========================================" << std::endl;

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
      STATIC_LINK("warpo", "_WarpoAddField", addField),
  };
}
} // namespace warpo::frontend