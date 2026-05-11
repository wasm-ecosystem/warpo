// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <fmt/base.h>
#include <queue>
#include <unordered_set>

#include "../helper/BinaryenExt.hpp"
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

  std::optional<uint64_t> getOffset(std::string_view const name) const {
    std::unordered_map<std::string_view, uint64_t>::const_iterator const it = offsetMap_.find(name);
    // we cannot make sure all types are recorded.
    // if field is A | null, but A is never used, then A won't be recorded.
    if (it == offsetMap_.end())
      return std::nullopt;
    return it->second;
  }

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

static void collectTypesFromBlock(BlockInfo const &blockInfo, std::unordered_set<std::string_view> &reachableTypes) {
  for (LocalInfo const &local : blockInfo.getLocals()) {
    reachableTypes.insert(local.getType());
  }

  for (std::unique_ptr<BlockInfo> const &child : blockInfo.getChildren()) {
    collectTypesFromBlock(*child, reachableTypes);
  }
}

static void collectTypesFromSubPrograms(std::deque<SubProgramInfo> const &subPrograms,
                                        std::unordered_set<std::string_view> &reachableTypes) {
  for (SubProgramInfo const &subProgram : subPrograms) {
    for (ParameterInfo const &param : subProgram.getParameters()) {
      reachableTypes.insert(param.getType());
    }
    for (LocalInfo const &local : subProgram.getLocals()) {
      reachableTypes.insert(local.getType());
    }
    for (std::unique_ptr<BlockInfo> const &block : subProgram.getBlocks()) {
      collectTypesFromBlock(*block, reachableTypes);
    }
  }
}

static std::unordered_set<std::string_view> collectReachableTypes(VariableInfo const &variableInfo) {
  VariableInfo::ClassRegistry const &classRegistry = variableInfo.getClassRegistry();
  VariableInfo::GlobalTypes const &globalTypes = variableInfo.getGlobalTypes();

  std::unordered_set<std::string_view> reachableTypes;

  // Seed from global variables
  for (auto const &[name, info] : globalTypes) {
    reachableTypes.insert(info.typeName);
  }

  // Seed from global functions' params and locals
  collectTypesFromSubPrograms(variableInfo.getSubProgramRegistry().getList(), reachableTypes);

  // Seed from class member functions' params and locals
  for (auto const &[className, classInfo] : classRegistry) {
    collectTypesFromSubPrograms(classInfo.getSubProgramRegistry().getList(), reachableTypes);
  }

  // BFS: transitively collect types referenced by reachable classes
  std::vector<std::string_view> worklist;
  for (std::string_view const typeName : reachableTypes) {
    worklist.push_back(typeName);
  }

  while (!worklist.empty()) {
    std::string_view const current = worklist.back();
    worklist.pop_back();

    auto const it = classRegistry.find(current);
    if (it == classRegistry.end())
      continue;

    ClassInfo const &classInfo = it->second;

    std::string_view const parentName = classInfo.getParentName();
    if (!parentName.empty() && reachableTypes.insert(parentName).second) {
      worklist.push_back(parentName);
    }

    for (FieldInfo const &field : classInfo.getFields()) {
      if (reachableTypes.insert(field.getType()).second) {
        worklist.push_back(field.getType());
      }
    }

    for (std::string_view const templateType : classInfo.getTemplateTypes()) {
      if (reachableTypes.insert(templateType).second) {
        worklist.push_back(templateType);
      }
    }
  }

  return reachableTypes;
}

static void emitLocalVariableEntry(LocalInfo const &local, llvm::DWARFYAML::Unit &rootUnit,
                                   uint32_t const localVariableAbbrevCode,
                                   uint32_t const tupleFieldLocalVariableAbbrevCode,
                                   std::vector<TypeRefFixup> &typeRefFixups) {
  llvm::DWARFYAML::Entry localEntry;
  VariableLocation const &location = local.getLocation();
  bool const isTupleField = std::holds_alternative<TupleFieldLocation>(location);
  localEntry.AbbrCode = isTupleField ? tupleFieldLocalVariableAbbrevCode : localVariableAbbrevCode;

  llvm::DWARFYAML::FormValue localNameValue;
  localNameValue.Value = 0;
  std::string_view const localName = local.getName();
  localNameValue.CStr = llvm::StringRef(localName.data(), localName.size());
  localEntry.Values.push_back(localNameValue);

  llvm::DWARFYAML::FormValue localTypeValue;
  localTypeValue.Value = 0xDEADBEEFU;
  localEntry.Values.push_back(localTypeValue);

  if (isTupleField) {
    TupleFieldLocation const &tupleField = std::get<TupleFieldLocation>(location);
    llvm::DWARFYAML::FormValue tupleFieldOffsetValue;
    tupleFieldOffsetValue.Value = tupleField.offset;
    localEntry.Values.push_back(tupleFieldOffsetValue);

    llvm::DWARFYAML::FormValue tupleLocalIndexValue;
    tupleLocalIndexValue.Value = tupleField.localIndex;
    localEntry.Values.push_back(tupleLocalIndexValue);
  } else {
    llvm::DWARFYAML::FormValue localLocationValue;
    localLocationValue.Value = std::get<LocalIndexLocation>(location).index;
    localEntry.Values.push_back(localLocationValue);
  }

  size_t const localIndex = rootUnit.Entries.size();
  typeRefFixups.push_back({localIndex, 1U, local.getType()});
  rootUnit.Entries.push_back(localEntry);
}

static void emitScopeEntry(BlockInfo const &blockInfo, llvm::DWARFYAML::Unit &rootUnit,
                           uint32_t const lexicalBlockAbbrevCode, uint32_t const localVariableAbbrevCode,
                           uint32_t const tupleFieldLocalVariableAbbrevCode, std::vector<TypeRefFixup> &typeRefFixups) {
  llvm::DWARFYAML::Entry blockEntry;
  blockEntry.AbbrCode = lexicalBlockAbbrevCode;

  llvm::DWARFYAML::FormValue blockLowPcValue;
  blockLowPcValue.Value = blockInfo.getStartLine();
  blockEntry.Values.push_back(blockLowPcValue);

  llvm::DWARFYAML::FormValue blockHighPcValue;
  blockHighPcValue.Value = blockInfo.getEndLine();
  blockEntry.Values.push_back(blockHighPcValue);

  rootUnit.Entries.push_back(blockEntry);

  for (LocalInfo const &local : blockInfo.getLocals())
    emitLocalVariableEntry(local, rootUnit, localVariableAbbrevCode, tupleFieldLocalVariableAbbrevCode, typeRefFixups);

  for (std::unique_ptr<BlockInfo> const &child : blockInfo.getChildren()) {
    emitScopeEntry(*child, rootUnit, lexicalBlockAbbrevCode, localVariableAbbrevCode, tupleFieldLocalVariableAbbrevCode,
                   typeRefFixups);
  }
}

static void emitScopeTerminator(llvm::DWARFYAML::Unit &rootUnit) {
  llvm::DWARFYAML::Entry blockTerminator;
  blockTerminator.AbbrCode = 0U;
  rootUnit.Entries.push_back(blockTerminator);
}

llvm::StringMap<std::unique_ptr<llvm::MemoryBuffer>>

DwarfGenerator::generateDebugSections(VariableInfo const &variableInfo) {
  VariableInfo::ClassRegistry const &classRegistry = variableInfo.getClassRegistry();
  VariableInfo::GlobalTypes const &globalTypes = variableInfo.getGlobalTypes();
  VariableInfo::BaseTypeRegistry const &baseTypeRegistry = variableInfo.getBaseTypeRegistry();
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

  llvm::DWARFYAML::AttributeAbbrev classNameAttr{};
  classNameAttr.Attribute = llvm::dwarf::DW_AT_name;
  classNameAttr.Form = llvm::dwarf::DW_FORM_string;
  classNameAttr.Value = 0U;

  llvm::DWARFYAML::Abbrev classAbbrevWithRtid =
      abbrevFactory.create(llvm::dwarf::DW_TAG_class_type, llvm::dwarf::DW_CHILDREN_yes);
  classAbbrevWithRtid.Attributes.push_back(classNameAttr);

  llvm::DWARFYAML::AttributeAbbrev classSignatureAttr{};
  classSignatureAttr.Attribute = llvm::dwarf::DW_AT_signature;
  classSignatureAttr.Form = llvm::dwarf::DW_FORM_data4;
  classSignatureAttr.Value = 0U;
  classAbbrevWithRtid.Attributes.push_back(classSignatureAttr);

  abbrevDecls.push_back(classAbbrevWithRtid);

  llvm::DWARFYAML::Abbrev classAbbrevWithoutRtid =
      abbrevFactory.create(llvm::dwarf::DW_TAG_class_type, llvm::dwarf::DW_CHILDREN_yes);
  classAbbrevWithoutRtid.Attributes.push_back(classNameAttr);

  abbrevDecls.push_back(classAbbrevWithoutRtid);

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

  llvm::DWARFYAML::Abbrev inheritanceAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_inheritance, llvm::dwarf::DW_CHILDREN_no);

  llvm::DWARFYAML::AttributeAbbrev inheritanceTypeAttr{};
  inheritanceTypeAttr.Attribute = llvm::dwarf::DW_AT_type;
  inheritanceTypeAttr.Form = llvm::dwarf::DW_FORM_ref4;
  inheritanceTypeAttr.Value = 0U;
  inheritanceAbbrev.Attributes.push_back(inheritanceTypeAttr);

  abbrevDecls.push_back(inheritanceAbbrev);

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

  llvm::DWARFYAML::Abbrev localVariableAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_variable, llvm::dwarf::DW_CHILDREN_no);

  llvm::DWARFYAML::AttributeAbbrev localVarNameAttr{};
  localVarNameAttr.Attribute = llvm::dwarf::DW_AT_name;
  localVarNameAttr.Form = llvm::dwarf::DW_FORM_string;
  localVarNameAttr.Value = 0U;
  localVariableAbbrev.Attributes.push_back(localVarNameAttr);

  llvm::DWARFYAML::AttributeAbbrev localVarTypeAttr{};
  localVarTypeAttr.Attribute = llvm::dwarf::DW_AT_type;
  localVarTypeAttr.Form = llvm::dwarf::DW_FORM_ref4;
  localVarTypeAttr.Value = 0U;
  localVariableAbbrev.Attributes.push_back(localVarTypeAttr);

  llvm::DWARFYAML::AttributeAbbrev localVarLocationAttr{};
  localVarLocationAttr.Attribute = llvm::dwarf::DW_AT_location;
  localVarLocationAttr.Form = llvm::dwarf::DW_FORM_data4;
  localVarLocationAttr.Value = 0U;
  localVariableAbbrev.Attributes.push_back(localVarLocationAttr);

  abbrevDecls.push_back(localVariableAbbrev);

  llvm::DWARFYAML::Abbrev tupleFieldLocalVariableAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_variable, llvm::dwarf::DW_CHILDREN_no);
  tupleFieldLocalVariableAbbrev.Attributes.push_back(localVarNameAttr);
  tupleFieldLocalVariableAbbrev.Attributes.push_back(localVarTypeAttr);

  llvm::DWARFYAML::AttributeAbbrev tupleFieldOffsetAttr{};
  tupleFieldOffsetAttr.Attribute = llvm::dwarf::DW_AT_data_member_location;
  tupleFieldOffsetAttr.Form = llvm::dwarf::DW_FORM_data4;
  tupleFieldOffsetAttr.Value = 0U;
  tupleFieldLocalVariableAbbrev.Attributes.push_back(tupleFieldOffsetAttr);

  tupleFieldLocalVariableAbbrev.Attributes.push_back(localVarLocationAttr);

  abbrevDecls.push_back(tupleFieldLocalVariableAbbrev);

  llvm::DWARFYAML::Abbrev formalParameterAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_formal_parameter, llvm::dwarf::DW_CHILDREN_no);

  llvm::DWARFYAML::AttributeAbbrev formalParamNameAttr{};
  formalParamNameAttr.Attribute = llvm::dwarf::DW_AT_name;
  formalParamNameAttr.Form = llvm::dwarf::DW_FORM_string;
  formalParamNameAttr.Value = 0U;
  formalParameterAbbrev.Attributes.push_back(formalParamNameAttr);

  llvm::DWARFYAML::AttributeAbbrev formalParamTypeAttr{};
  formalParamTypeAttr.Attribute = llvm::dwarf::DW_AT_type;
  formalParamTypeAttr.Form = llvm::dwarf::DW_FORM_ref4;
  formalParamTypeAttr.Value = 0U;
  formalParameterAbbrev.Attributes.push_back(formalParamTypeAttr);

  llvm::DWARFYAML::AttributeAbbrev formalParamLocationAttr{};
  formalParamLocationAttr.Attribute = llvm::dwarf::DW_AT_location;
  formalParamLocationAttr.Form = llvm::dwarf::DW_FORM_data4;
  formalParamLocationAttr.Value = 0U;
  formalParameterAbbrev.Attributes.push_back(formalParamLocationAttr);

  abbrevDecls.push_back(formalParameterAbbrev);

  llvm::DWARFYAML::Abbrev tupleFieldFormalParameterAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_formal_parameter, llvm::dwarf::DW_CHILDREN_no);
  tupleFieldFormalParameterAbbrev.Attributes.push_back(formalParamNameAttr);
  tupleFieldFormalParameterAbbrev.Attributes.push_back(formalParamTypeAttr);

  llvm::DWARFYAML::AttributeAbbrev tupleFieldFormalParamOffsetAttr{};
  tupleFieldFormalParamOffsetAttr.Attribute = llvm::dwarf::DW_AT_data_member_location;
  tupleFieldFormalParamOffsetAttr.Form = llvm::dwarf::DW_FORM_data4;
  tupleFieldFormalParamOffsetAttr.Value = 0U;
  tupleFieldFormalParameterAbbrev.Attributes.push_back(tupleFieldFormalParamOffsetAttr);

  tupleFieldFormalParameterAbbrev.Attributes.push_back(formalParamLocationAttr);

  abbrevDecls.push_back(tupleFieldFormalParameterAbbrev);

  llvm::DWARFYAML::Abbrev lexicalBlockAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_lexical_block, llvm::dwarf::DW_CHILDREN_yes);

  llvm::DWARFYAML::AttributeAbbrev lexicalBlockLowPcAttr{};
  lexicalBlockLowPcAttr.Attribute = llvm::dwarf::DW_AT_low_pc;
  lexicalBlockLowPcAttr.Form = llvm::dwarf::DW_FORM_addr;
  lexicalBlockLowPcAttr.Value = 0U;
  lexicalBlockAbbrev.Attributes.push_back(lexicalBlockLowPcAttr);

  llvm::DWARFYAML::AttributeAbbrev lexicalBlockHighPcAttr{};
  lexicalBlockHighPcAttr.Attribute = llvm::dwarf::DW_AT_high_pc;
  lexicalBlockHighPcAttr.Form = llvm::dwarf::DW_FORM_addr;
  lexicalBlockHighPcAttr.Value = 0U;
  lexicalBlockAbbrev.Attributes.push_back(lexicalBlockHighPcAttr);

  abbrevDecls.push_back(lexicalBlockAbbrev);

  llvm::DWARFYAML::Abbrev subProgramAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_subprogram, llvm::dwarf::DW_CHILDREN_yes);

  llvm::DWARFYAML::AttributeAbbrev subProgramNameAttr{};
  subProgramNameAttr.Attribute = llvm::dwarf::DW_AT_name;
  subProgramNameAttr.Form = llvm::dwarf::DW_FORM_string;
  subProgramNameAttr.Value = 0U;
  subProgramAbbrev.Attributes.push_back(subProgramNameAttr);

  abbrevDecls.push_back(subProgramAbbrev);

  llvm::DWARFYAML::AttributeAbbrev outerFunctionAttr{};
  outerFunctionAttr.Attribute = llvm::dwarf::DW_AT_description;
  outerFunctionAttr.Form = llvm::dwarf::DW_FORM_string;
  outerFunctionAttr.Value = 0U;

  llvm::DWARFYAML::AttributeAbbrev heapStorageAttr{};
  heapStorageAttr.Attribute = llvm::dwarf::DW_AT_static_link;
  heapStorageAttr.Form = llvm::dwarf::DW_FORM_data4;
  heapStorageAttr.Value = 0U;

  llvm::DWARFYAML::Abbrev closureSubProgramAbbrev =
      abbrevFactory.create(llvm::dwarf::DW_TAG_subprogram, llvm::dwarf::DW_CHILDREN_yes);
  closureSubProgramAbbrev.Attributes.push_back(subProgramNameAttr);
  closureSubProgramAbbrev.Attributes.push_back(heapStorageAttr);
  closureSubProgramAbbrev.Attributes.push_back(outerFunctionAttr);

  abbrevDecls.push_back(closureSubProgramAbbrev);
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

  std::vector<TypeRefFixup> typeRefFixups;

  for (std::string_view const &baseType : baseTypeRegistry) {
    llvm::DWARFYAML::Entry baseTypeEntry;
    baseTypeEntry.AbbrCode = baseTypeAbbrev.Code;

    llvm::DWARFYAML::FormValue baseTypeNameValue;
    baseTypeNameValue.Value = 0;
    baseTypeNameValue.CStr = llvm::StringRef{baseType.data(), baseType.size()};
    baseTypeEntry.Values.push_back(baseTypeNameValue);

    rootUnit.Entries.push_back(baseTypeEntry);
  }

  DwarfGenerator::AbbrevCodes const abbrevCodes{
      subProgramAbbrev.Code,
      closureSubProgramAbbrev.Code,
      formalParameterAbbrev.Code,
      tupleFieldFormalParameterAbbrev.Code,
      lexicalBlockAbbrev.Code,
      localVariableAbbrev.Code,
      tupleFieldLocalVariableAbbrev.Code,
  };

  std::unordered_set<std::string_view> const reachableTypes = collectReachableTypes(variableInfo);

  for (auto const &[className, classInfo] : classRegistry) {
    if (reachableTypes.find(className) == reachableTypes.end())
      continue;

    std::optional<uint32_t> const rtid = classInfo.getRtid();

    llvm::DWARFYAML::Entry classEntry;
    classEntry.AbbrCode = rtid.has_value() ? classAbbrevWithRtid.Code : classAbbrevWithoutRtid.Code;

    llvm::DWARFYAML::FormValue classNameValue;
    classNameValue.Value = 0;
    classNameValue.CStr = llvm::StringRef(className.data(), className.size());
    classEntry.Values.push_back(classNameValue);

    if (rtid.has_value()) {
      llvm::DWARFYAML::FormValue classSignatureValue;
      classSignatureValue.Value = *rtid;
      classEntry.Values.push_back(classSignatureValue);
    }

    rootUnit.Entries.push_back(classEntry);

    // Add inheritance (base class) reference
    std::string_view const parentName = classInfo.getParentName();
    if (!parentName.empty()) {
      llvm::DWARFYAML::Entry inheritanceEntry;
      inheritanceEntry.AbbrCode = inheritanceAbbrev.Code;

      llvm::DWARFYAML::FormValue inheritanceTypeValue;
      inheritanceTypeValue.Value = 0xDEADBEEFU;
      inheritanceEntry.Values.push_back(inheritanceTypeValue);

      size_t const inheritanceIndex = rootUnit.Entries.size();
      typeRefFixups.push_back({inheritanceIndex, 0U, parentName});

      rootUnit.Entries.push_back(inheritanceEntry);
    }

    // Add member fields
    std::vector<FieldInfo> const &fields = classInfo.getFields();
    for (FieldInfo const &field : fields) {
      llvm::DWARFYAML::Entry memberEntry;
      memberEntry.AbbrCode = memberAbbrev.Code;

      llvm::DWARFYAML::FormValue memberNameValue;
      memberNameValue.Value = 0;
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

    // Add class member functions
    SubProgramRegistry const &memberFunctions = classInfo.getSubProgramRegistry();
    std::deque<SubProgramInfo> const &memberFunctionList = memberFunctions.getList();
    for (SubProgramInfo const &subProgram : memberFunctionList) {
      addSubProgramWithParameters(subProgram, rootUnit, abbrevCodes, typeRefFixups);
    }

    // Add terminator for class children
    llvm::DWARFYAML::Entry childTerminator;
    childTerminator.AbbrCode = 0U;
    rootUnit.Entries.push_back(childTerminator);
  }

  // Add global variables
  for (std::pair<std::string const, VariableInfo::GlobalTypeInfo> const &globalEntry : globalTypes) {
    std::string const &variableName = globalEntry.first;
    std::string_view const typeName = globalEntry.second.typeName;

    llvm::DWARFYAML::Entry variableEntry;
    variableEntry.AbbrCode = variableAbbrev.Code;

    llvm::DWARFYAML::FormValue variableNameValue;
    variableNameValue.Value = 0;
    variableNameValue.CStr = llvm::StringRef(variableName.data(), variableName.size());
    variableEntry.Values.push_back(variableNameValue);

    llvm::DWARFYAML::FormValue variableTypeValue;
    variableTypeValue.Value = 0xDEADBEEFU;
    variableEntry.Values.push_back(variableTypeValue);

    size_t const variableIndex = rootUnit.Entries.size();
    typeRefFixups.push_back({variableIndex, 1U, typeName});

    rootUnit.Entries.push_back(variableEntry);
  }

  // Add global functions
  SubProgramRegistry const &globalFunctions = variableInfo.getSubProgramRegistry();
  std::deque<SubProgramInfo> const &globalFunctionList = globalFunctions.getList();
  for (SubProgramInfo const &subProgram : globalFunctionList) {
    addSubProgramWithParameters(subProgram, rootUnit, abbrevCodes, typeRefFixups);
  }

  compileUnits.push_back(rootUnit);
  dwarfData.CompileUnits = compileUnits;

  DIEOffsetCalculator offsetCalculator(dwarfData);
  offsetCalculator.traverseDebugInfo();

  for (TypeRefFixup const &fixup : typeRefFixups) {
    std::string_view const typeName = fixup.typeName;
    std::optional<uint64_t> const typeOffset = offsetCalculator.getOffset(typeName);
    if (typeOffset.has_value()) {
      dwarfData.CompileUnits[0U].Entries[fixup.entryIndex].Values[fixup.valueIndex].Value = *typeOffset;
    } else {
      // for the types that are not used, we just skip the fixup.
      // it will introduce some invalid type references.
      fmt::println("Warning: DWARF type not found for fixup: {}", typeName);
      dwarfData.CompileUnits[0U].Entries[fixup.entryIndex].Values[fixup.valueIndex].Value = 0xDEADBEEFU;
    }
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
  dumpOptions.ShowAddresses = false;
  dwarfContext->dump(dumpStream, dumpOptions);
  dumpStream.flush();
  return dumpOutput;
}

void DwarfGenerator::addSubProgramWithParameters(SubProgramInfo const &subProgram, llvm::DWARFYAML::Unit &rootUnit,
                                                 DwarfGenerator::AbbrevCodes const &abbrevCodes,
                                                 std::vector<TypeRefFixup> &typeRefFixups) {
  llvm::DWARFYAML::Entry subprogramEntry;
  std::optional<uint32_t> const heapStorageLocalIndex = subProgram.getHeapVariableStorageLocalIndex();
  std::optional<std::string_view> const outerFunction = subProgram.getOuterFunction();
  bool const isClosureFunction = outerFunction.has_value();
  assert(!isClosureFunction || heapStorageLocalIndex.has_value());
  subprogramEntry.AbbrCode = isClosureFunction ? abbrevCodes.closureSubprogram : abbrevCodes.subprogram;

  llvm::DWARFYAML::FormValue subprogramNameValue;
  subprogramNameValue.Value = 0;
  std::string_view const subProgramName = subProgram.getName();
  subprogramNameValue.CStr = llvm::StringRef(subProgramName.data(), subProgramName.size());
  subprogramEntry.Values.push_back(subprogramNameValue);

  if (isClosureFunction) {
    llvm::DWARFYAML::FormValue heapStorageValue;
    heapStorageValue.Value = *heapStorageLocalIndex;
    subprogramEntry.Values.push_back(heapStorageValue);

    llvm::DWARFYAML::FormValue outerFunctionValue;
    outerFunctionValue.Value = 0U;
    outerFunctionValue.CStr = llvm::StringRef(outerFunction->data(), outerFunction->size());
    subprogramEntry.Values.push_back(outerFunctionValue);
  }

  rootUnit.Entries.push_back(subprogramEntry);

  // Add formal parameters
  std::vector<ParameterInfo> const &parameters = subProgram.getParameters();
  for (ParameterInfo const &param : parameters) {
    llvm::DWARFYAML::Entry paramEntry;
    VariableLocation const &paramLocation = param.getLocation();
    bool const isTupleField = std::holds_alternative<TupleFieldLocation>(paramLocation);
    paramEntry.AbbrCode = isTupleField ? abbrevCodes.tupleFieldFormalParameter : abbrevCodes.formalParameter;

    llvm::DWARFYAML::FormValue paramNameValue;
    paramNameValue.Value = 0;
    std::string_view const paramName = param.getName();
    paramNameValue.CStr = llvm::StringRef(paramName.data(), paramName.size());
    paramEntry.Values.push_back(paramNameValue);

    llvm::DWARFYAML::FormValue paramTypeValue;
    paramTypeValue.Value = 0xDEADBEEFU;
    paramEntry.Values.push_back(paramTypeValue);

    llvm::DWARFYAML::FormValue paramLocationValue;
    if (isTupleField) {
      TupleFieldLocation const &tupleField = std::get<TupleFieldLocation>(paramLocation);
      paramLocationValue.Value = tupleField.offset;
      paramEntry.Values.push_back(paramLocationValue);

      llvm::DWARFYAML::FormValue tupleLocalIndexValue;
      tupleLocalIndexValue.Value = tupleField.localIndex;
      paramEntry.Values.push_back(tupleLocalIndexValue);
    } else {
      paramLocationValue.Value = std::get<LocalIndexLocation>(paramLocation).index;
      paramEntry.Values.push_back(paramLocationValue);
    }

    size_t const paramIndex = rootUnit.Entries.size();
    typeRefFixups.push_back({paramIndex, 1U, param.getType()});

    rootUnit.Entries.push_back(paramEntry);
  }

  for (LocalInfo const &local : subProgram.getLocals())
    emitLocalVariableEntry(local, rootUnit, abbrevCodes.localVariable, abbrevCodes.tupleFieldLocalVariable,
                           typeRefFixups);

  for (std::unique_ptr<BlockInfo> const &block : subProgram.getBlocks()) {
    emitScopeEntry(*block, rootUnit, abbrevCodes.lexicalBlock, abbrevCodes.localVariable,
                   abbrevCodes.tupleFieldLocalVariable, typeRefFixups);
    emitScopeTerminator(rootUnit);
  }

  // Add terminator for subprogram children
  llvm::DWARFYAML::Entry subProgramTerminator;
  subProgramTerminator.AbbrCode = 0U;
  rootUnit.Entries.push_back(subProgramTerminator);
}

} // namespace warpo::passes