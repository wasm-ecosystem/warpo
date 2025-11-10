///
/// @file DwarfGenerator.cpp
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

#include "AbbrevFactory.hpp"
#include "DebugStringManager.hpp"
#include "binaryen/third_party/llvm-project/DWARFVisitor.h"
#include "llvm/BinaryFormat/Dwarf.h"
#include "llvm/DebugInfo/DWARF/DWARFContext.h"
#include "llvm/ObjectYAML/DWARFEmitter.h"
#include "llvm/ObjectYAML/DWARFYAML.h"
#include "llvm/Support/LEB128.h"
#include "llvm/Support/YAMLTraits.h"
#include "llvm/Support/raw_ostream.h"
#include "warpo/common/VariableInfo.hpp"
#include "warpo/passes/DwarfGenerator/DwarfGenerator.hpp"

namespace warpo::passes {
class DIEOffsetCalculator : public llvm::DWARFYAML::Visitor {
public:
  explicit DIEOffsetCalculator(llvm::DWARFYAML::Data &DI) : llvm::DWARFYAML::Visitor(DI) {}

  uint64_t getOffset(std::string_view const name) const {
    std::unordered_map<std::string_view, uint64_t>::const_iterator const it = offsetMap_.find(name);
    assert(it != offsetMap_.end());
    return it->second;
  }

  std::unordered_map<std::string_view, uint64_t> const &getOffsetMap() const { return offsetMap_; }

private:
  uint64_t currentOffset_ = 0U;
  std::unordered_map<std::string_view, uint64_t> offsetMap_;

  void onStartCompileUnit([[maybe_unused]] llvm::DWARFYAML::Unit &CU) override {
    constexpr uint64_t lengthFieldSize = 4U;
    constexpr uint64_t versionFieldSize = 2U;
    constexpr uint64_t abbrevOffsetFieldSize = 4U;
    constexpr uint64_t addressSizeFieldSize = 1U;
    currentOffset_ = lengthFieldSize + versionFieldSize + abbrevOffsetFieldSize + addressSizeFieldSize;
  }

  void onStartDIE([[maybe_unused]] llvm::DWARFYAML::Unit &CU, llvm::DWARFYAML::Entry &DIE) override {
    uint64_t const dieOffset = currentOffset_;
    if (DIE.AbbrCode.value != 0U) {

      llvm::DWARFYAML::Abbrev const &abbrev = DebugInfo.AbbrevDecls[DIE.AbbrCode.value - 1U];
      assert(abbrev.Code == DIE.AbbrCode.value);
      if ((abbrev.Tag == llvm::dwarf::Tag::DW_TAG_class_type) || (abbrev.Tag == llvm::dwarf::Tag::DW_TAG_base_type)) {

        constexpr size_t nameIndex = 0U;
        [[maybe_unused]] llvm::DWARFYAML::AttributeAbbrev const &attr = abbrev.Attributes[nameIndex];
        assert(attr.Attribute == llvm::dwarf::DW_AT_name);

        llvm::DWARFYAML::FormValue const &nameValue = DIE.Values[nameIndex];
        assert(!nameValue.CStr.empty());
        std::string_view const dieName(nameValue.CStr.data(), nameValue.CStr.size());
        offsetMap_[dieName] = dieOffset;
      }
    }

    currentOffset_ += llvm::getULEB128Size(DIE.AbbrCode.value);
  }

  void onValue([[maybe_unused]] uint8_t const U) override { currentOffset_ += 1U; }
  void onValue([[maybe_unused]] uint16_t const U) override { currentOffset_ += 2U; }
  void onValue([[maybe_unused]] uint32_t const U) override { currentOffset_ += 4U; }
  void onValue(uint64_t const U, bool const LEB) override {
    if (LEB)
      currentOffset_ += llvm::getULEB128Size(U);
    else
      currentOffset_ += 8U;
  }
  void onValue(int64_t const S, bool const LEB) override {
    if (LEB)
      currentOffset_ += llvm::getSLEB128Size(S);
    else
      currentOffset_ += 8U;
  }
  void onValue(llvm::StringRef const String) override { currentOffset_ += String.size() + 1U; }
  void onValue(llvm::MemoryBufferRef const MBR) override { currentOffset_ += MBR.getBufferSize(); }
};

llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>>
DwarfGenerator::generateDebugSections(VariableInfo const &variableInfo) {
  VariableInfo::ClassRegistry const &classRegistry = variableInfo.getClassRegistry();
  VariableInfo::GlobalTypes const &globalTypes = variableInfo.getGlobalTypes();

  llvm::DWARFYAML::Data dwarfData;
  dwarfData.IsLittleEndian = true;

  DebugStringManager stringManager;
  AbbrevFactory abbrevFactory;

  std::vector<llvm::DWARFYAML::Abbrev> abbrevDecls;

  llvm::DWARFYAML::Abbrev rootAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_compile_unit, llvm::dwarf::DW_CHILDREN_yes);

  llvm::DWARFYAML::AttributeAbbrev producerAttr{};
  producerAttr.Attribute = llvm::dwarf::DW_AT_producer;
  producerAttr.Form = llvm::dwarf::DW_FORM_strp;
  producerAttr.Value = 0U;
  rootAbbrev.Attributes.push_back(producerAttr);

  abbrevDecls.push_back(rootAbbrev);

  llvm::DWARFYAML::Abbrev classAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_class_type, llvm::dwarf::DW_CHILDREN_yes);

  llvm::DWARFYAML::AttributeAbbrev nameAttr{};
  nameAttr.Attribute = llvm::dwarf::DW_AT_name;
  nameAttr.Form = llvm::dwarf::DW_FORM_string;
  nameAttr.Value = 0U;
  classAbbrev.Attributes.push_back(nameAttr);

  llvm::DWARFYAML::AttributeAbbrev classSignatureAttr{};
  classSignatureAttr.Attribute = llvm::dwarf::DW_AT_signature;
  classSignatureAttr.Form = llvm::dwarf::DW_FORM_data4;
  classSignatureAttr.Value = 0U;
  classAbbrev.Attributes.push_back(classSignatureAttr);

  abbrevDecls.push_back(classAbbrev);

  llvm::DWARFYAML::Abbrev memberAbbrev = abbrevFactory.create(llvm::dwarf::DW_TAG_member, llvm::dwarf::DW_CHILDREN_no);

  llvm::DWARFYAML::AttributeAbbrev memberNameAttr{};
  memberNameAttr.Attribute = llvm::dwarf::DW_AT_name;
  memberNameAttr.Form = llvm::dwarf::DW_FORM_string;
  memberNameAttr.Value = 0U;
  memberAbbrev.Attributes.push_back(memberNameAttr);

  llvm::DWARFYAML::AttributeAbbrev memberTypeAttr{};
  memberTypeAttr.Attribute = llvm::dwarf::DW_AT_type;
  memberTypeAttr.Form = llvm::dwarf::DW_FORM_ref4;
  memberTypeAttr.Value = 0U;
  memberAbbrev.Attributes.push_back(memberTypeAttr);

  llvm::DWARFYAML::AttributeAbbrev memberLocationAttr{};
  memberLocationAttr.Attribute = llvm::dwarf::DW_AT_data_member_location;
  memberLocationAttr.Form = llvm::dwarf::DW_FORM_data4;
  memberLocationAttr.Value = 0U;
  memberAbbrev.Attributes.push_back(memberLocationAttr);

  abbrevDecls.push_back(memberAbbrev);

  llvm::DWARFYAML::Abbrev baseTypeAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_base_type, llvm::dwarf::DW_CHILDREN_no);

  llvm::DWARFYAML::AttributeAbbrev baseTypeNameAttr{};
  baseTypeNameAttr.Attribute = llvm::dwarf::DW_AT_name;
  baseTypeNameAttr.Form = llvm::dwarf::DW_FORM_string;
  baseTypeNameAttr.Value = 0U;
  baseTypeAbbrev.Attributes.push_back(baseTypeNameAttr);

  abbrevDecls.push_back(baseTypeAbbrev);

  llvm::DWARFYAML::Abbrev templateTypeParamAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_template_type_parameter, llvm::dwarf::DW_CHILDREN_no);

  llvm::DWARFYAML::AttributeAbbrev templateTypeParamTypeAttr{};
  templateTypeParamTypeAttr.Attribute = llvm::dwarf::DW_AT_type;
  templateTypeParamTypeAttr.Form = llvm::dwarf::DW_FORM_ref4;
  templateTypeParamTypeAttr.Value = 0U;
  templateTypeParamAbbrev.Attributes.push_back(templateTypeParamTypeAttr);

  abbrevDecls.push_back(templateTypeParamAbbrev);

  llvm::DWARFYAML::Abbrev variableAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_variable, llvm::dwarf::DW_CHILDREN_no);

  llvm::DWARFYAML::AttributeAbbrev variableNameAttr{};
  variableNameAttr.Attribute = llvm::dwarf::DW_AT_name;
  variableNameAttr.Form = llvm::dwarf::DW_FORM_string;
  variableNameAttr.Value = 0U;
  variableAbbrev.Attributes.push_back(variableNameAttr);

  llvm::DWARFYAML::AttributeAbbrev variableTypeAttr{};
  variableTypeAttr.Attribute = llvm::dwarf::DW_AT_type;
  variableTypeAttr.Form = llvm::dwarf::DW_FORM_ref4;
  variableTypeAttr.Value = 0U;
  variableAbbrev.Attributes.push_back(variableTypeAttr);

  abbrevDecls.push_back(variableAbbrev);

  llvm::DWARFYAML::Abbrev terminator;
  terminator.Code = 0U;
  terminator.Tag = llvm::dwarf::DW_TAG_null;
  terminator.Children = llvm::dwarf::DW_CHILDREN_no;
  terminator.ListOffset = 0U;
  abbrevDecls.push_back(terminator);

  dwarfData.AbbrevDecls = abbrevDecls;

  size_t const producerOffset = stringManager.addString("warpo");

  std::vector<llvm::DWARFYAML::Unit> compileUnits;

  llvm::DWARFYAML::Unit rootUnit;
  rootUnit.Length.setLength(0U);
  rootUnit.Version = 4U;
  rootUnit.AbbrOffset = 0U;
  rootUnit.AddrSize = 4U;

  llvm::DWARFYAML::Entry rootEntry;
  rootEntry.AbbrCode = rootAbbrev.Code;

  llvm::DWARFYAML::FormValue producerValue;
  producerValue.Value = producerOffset;
  rootEntry.Values.push_back(producerValue);

  rootUnit.Entries.push_back(rootEntry);

  struct TypeRefFixup final {
    size_t entryIndex;
    size_t valueIndex;
    std::string_view typeName;
  };
  std::vector<TypeRefFixup> typeRefFixups;

  for (std::pair<std::string_view const, ClassInfo> const &entry : classRegistry) {
    std::string_view const className = entry.first;
    ClassInfo const &classInfo = entry.second;
    bool const isBasicType = classInfo.isBasicType();

    if (isBasicType) {
      // Handle basic type
      llvm::DWARFYAML::Entry baseTypeEntry;
      baseTypeEntry.AbbrCode = baseTypeAbbrev.Code;

      llvm::DWARFYAML::FormValue baseTypeNameValue;
      baseTypeNameValue.CStr = llvm::StringRef(className.data(), className.size());
      baseTypeEntry.Values.push_back(baseTypeNameValue);

      rootUnit.Entries.push_back(baseTypeEntry);
    } else {
      // Handle class type
      llvm::DWARFYAML::Entry classEntry;
      classEntry.AbbrCode = classAbbrev.Code;

      llvm::DWARFYAML::FormValue classNameValue;
      classNameValue.CStr = llvm::StringRef(className.data(), className.size());
      classEntry.Values.push_back(classNameValue);

      llvm::DWARFYAML::FormValue classSignatureValue;
      classSignatureValue.Value = classInfo.getRtid();
      classEntry.Values.push_back(classSignatureValue);

      rootUnit.Entries.push_back(classEntry);

      // Add member fields
      std::vector<FieldInfo> const &fields = classInfo.getFields();
      for (FieldInfo const &field : fields) {
        llvm::DWARFYAML::Entry memberEntry;
        memberEntry.AbbrCode = memberAbbrev.Code;

        llvm::DWARFYAML::FormValue memberNameValue;
        std::string_view const fieldNameView = field.getName();
        memberNameValue.CStr = llvm::StringRef(fieldNameView.data(), fieldNameView.size());
        memberEntry.Values.push_back(memberNameValue);

        llvm::DWARFYAML::FormValue memberTypeValue;
        memberTypeValue.Value = 0xDEADBEEFU;
        memberEntry.Values.push_back(memberTypeValue);

        llvm::DWARFYAML::FormValue memberLocationValue;
        memberLocationValue.Value = field.getOffsetInClass();
        memberEntry.Values.push_back(memberLocationValue);

        size_t const memberIndex = rootUnit.Entries.size();
        typeRefFixups.push_back({memberIndex, 1U, field.getType()});

        rootUnit.Entries.push_back(memberEntry);
      }

      // Add template type parameters
      std::vector<std::string_view> const &templateTypes = classInfo.getTemplateTypes();
      for (std::string_view const templateTypeName : templateTypes) {
        llvm::DWARFYAML::Entry templateTypeParamEntry;
        templateTypeParamEntry.AbbrCode = templateTypeParamAbbrev.Code;

        llvm::DWARFYAML::FormValue templateTypeValue;
        templateTypeValue.Value = 0xDEADBEEFU;
        templateTypeParamEntry.Values.push_back(templateTypeValue);

        size_t const templateTypeIndex = rootUnit.Entries.size();
        typeRefFixups.push_back({templateTypeIndex, 0U, templateTypeName});

        rootUnit.Entries.push_back(templateTypeParamEntry);
      }

      // Add terminator for class children
      llvm::DWARFYAML::Entry childTerminator;
      childTerminator.AbbrCode = 0U;
      rootUnit.Entries.push_back(childTerminator);
    }
  }

  // Add global variables
  for (std::pair<std::string const, std::string_view> const &globalEntry : globalTypes) {
    std::string const &variableName = globalEntry.first;
    std::string_view const typeName = globalEntry.second;

    llvm::DWARFYAML::Entry variableEntry;
    variableEntry.AbbrCode = variableAbbrev.Code;

    llvm::DWARFYAML::FormValue variableNameValue;
    variableNameValue.CStr = llvm::StringRef(variableName.data(), variableName.size());
    variableEntry.Values.push_back(variableNameValue);

    llvm::DWARFYAML::FormValue variableTypeValue;
    variableTypeValue.Value = 0xDEADBEEFU;
    variableEntry.Values.push_back(variableTypeValue);

    size_t const variableIndex = rootUnit.Entries.size();
    typeRefFixups.push_back({variableIndex, 1U, typeName});

    rootUnit.Entries.push_back(variableEntry);
  }

  compileUnits.push_back(rootUnit);
  dwarfData.CompileUnits = compileUnits;

  DIEOffsetCalculator offsetCalculator(dwarfData);
  offsetCalculator.traverseDebugInfo();

  for (TypeRefFixup const &fixup : typeRefFixups) {
    std::string_view const typeName = fixup.typeName;
    uint64_t const typeOffset = offsetCalculator.getOffset(typeName);
    assert(typeOffset != 0U);
    dwarfData.CompileUnits[0U].Entries[fixup.entryIndex].Values[fixup.valueIndex].Value = typeOffset;
  }

  dwarfData.DebugStrings = stringManager.getDebugStrings();

  llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> debugSections =
      llvm::DWARFYAML::EmitDebugSections(dwarfData, true);
  return debugSections;
}

std::string DwarfGenerator::dumpDwarf(llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>> const &debugSections) {
  std::unique_ptr<llvm::DWARFContext> dwarfContext = llvm::DWARFContext::create(debugSections, 4U, true);
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
  return dumpOutput;
}

} // namespace warpo::passes