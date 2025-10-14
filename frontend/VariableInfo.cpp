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

private:
  wasm::IString name_;
  wasm::IString parentName_;
  uint32_t rtid_;
  std::vector<FieldInfo> fields_;
  std::vector<InterfaceInfo> interfaces_;
};

std::unordered_map<std::string, ClassInfo> classRegistry;

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

  // 1. Create debug abbreviation of root node with DW_AT_producer attribute
  std::vector<llvm::DWARFYAML::Abbrev> abbrevDecls;

  llvm::DWARFYAML::Abbrev rootAbbrev;
  rootAbbrev.Code = 1;
  rootAbbrev.Tag = llvm::dwarf::DW_TAG_compile_unit;
  rootAbbrev.Children = llvm::dwarf::DW_CHILDREN_yes;
  rootAbbrev.ListOffset = 0;

  // Add DW_AT_producer attribute with DW_FORM_strp form
  llvm::DWARFYAML::AttributeAbbrev producerAttr;
  producerAttr.Attribute = llvm::dwarf::DW_AT_producer;
  producerAttr.Form = llvm::dwarf::DW_FORM_strp;
  producerAttr.Value = 0;
  rootAbbrev.Attributes.push_back(producerAttr);

  abbrevDecls.push_back(rootAbbrev);

  // Add terminator (code 0)
  llvm::DWARFYAML::Abbrev terminator;
  terminator.Code = 0;
  terminator.Tag = llvm::dwarf::DW_TAG_null;
  terminator.Children = llvm::dwarf::DW_CHILDREN_no;
  terminator.ListOffset = 0;
  abbrevDecls.push_back(terminator);

  dwarfData.AbbrevDecls = abbrevDecls;

  // 2. Add debug string "AssemblyScript"
  std::vector<llvm::StringRef> debugStrings;
  debugStrings.emplace_back("AssemblyScript");
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
  rootEntry.AbbrCode = 1; // Use the root abbreviation we defined

  // Create form value for the producer string (points to offset 0 in debug_str)
  llvm::DWARFYAML::FormValue producerValue;
  producerValue.Value = 0; // Offset 0 in the debug_str section (points to "AssemblyScript")
  rootEntry.Values.push_back(producerValue);

  rootUnit.Entries.push_back(rootEntry);
  compileUnits.push_back(rootUnit);
  dwarfData.CompileUnits = compileUnits;

  std::cout << "Length before fixup: " << rootUnit.Length.getLength() << "\n";

  // Use LLVM's built-in EmitDebugSections with ApplyFixups=true to automatically calculate lengths
  auto debugSections = llvm::DWARFYAML::EmitDebugSections(dwarfData, true);

  std::cout << "Length after fixup: " << dwarfData.CompileUnits[0].Length.getLength() << "\n";

  // Extract the binary data from the generated sections
  std::string abbrevData, strData, infoData;

  if (debugSections.count("debug_abbrev")) {
    auto &abbrevBuffer = debugSections["debug_abbrev"];
    abbrevData = abbrevBuffer->getBuffer().str();
  }

  if (debugSections.count("debug_str")) {
    auto &strBuffer = debugSections["debug_str"];
    strData = strBuffer->getBuffer().str();
  }

  if (debugSections.count("debug_info")) {
    auto &infoBuffer = debugSections["debug_info"];
    infoData = infoBuffer->getBuffer().str();
  }

  // Display the results
  std::cout << "Generated debug_abbrev (" << abbrevData.size() << " bytes):\n";
  for (size_t i = 0; i < abbrevData.size(); ++i) {
    printf("%02x ", static_cast<uint8_t>(abbrevData[i]));
    if ((i + 1) % 16 == 0)
      printf("\n");
  }
  if (abbrevData.size() % 16 != 0)
    printf("\n");

  std::cout << "\nGenerated debug_str (" << strData.size() << " bytes):\n";
  for (size_t i = 0; i < strData.size(); ++i) {
    char c = strData[i];
    if (c >= 32 && c <= 126) {
      printf("%c", c);
    } else {
      printf("\\%02x", static_cast<uint8_t>(c));
    }
  }
  printf("\n");

  std::cout << "\nGenerated debug_info (" << infoData.size() << " bytes):\n";
  for (size_t i = 0; i < infoData.size(); ++i) {
    printf("%02x ", static_cast<uint8_t>(infoData[i]));
    if ((i + 1) % 16 == 0)
      printf("\n");
  }
  if (infoData.size() % 16 != 0)
    printf("\n");

  // Output as YAML for validation
  std::cout << "\nDWARF Data as YAML:\n";
  llvm::yaml::Output yamlOut(llvm::outs());
  yamlOut << dwarfData;

  // Create a proper DWARF context from the generated sections for human-readable output
  std::cout << "\n=== Human-readable DWARF dump (using LLVM's built-in dumper) ===\n";

  // Create DWARF context from the generated binary sections
  uint8_t addrSize = 4;
  bool isLittleEndian = true;
  auto dwarfContext = llvm::DWARFContext::create(debugSections, addrSize, isLittleEndian);

  // Use LLVM's high-level dump functionality - no manual iteration needed!
  std::cout << "\n=== Complete DWARF dump (like llvm-dwarfdump) ===\n";

  // Create dump options for controlling the output format
  llvm::DIDumpOptions dumpOptions;
  dumpOptions.ShowChildren = true;
  dumpOptions.ShowParents = false;
  dumpOptions.ShowForm = false;
  dumpOptions.SummarizeTypes = false;
  dumpOptions.Verbose = false;
  dumpOptions.DisplayRawContents = false;

  // This is the correct way - pass DIDumpOptions to dump()
  dwarfContext->dump(llvm::outs(), dumpOptions);

  std::cout << "\n=== End DWARF Debug Information ===\n\n";
}

std::vector<vb::NativeSymbol> VariableInfo::createVariableInfoAPI() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("warpo", "_WarpoCreateClass", createClass),
  };
}
} // namespace warpo::frontend