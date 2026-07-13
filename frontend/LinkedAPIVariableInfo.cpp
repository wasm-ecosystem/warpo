// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <utility>
#include <warpo/warp_runner/WarpRunner.hpp>

#include "CompilerImpl.hpp"
#include "LinkedAPI.hpp"
#include "warpo/common/AsModule.hpp"

#include "src/core/common/function_traits.hpp"

namespace warpo::frontend {

namespace {

void createBaseType(uint32_t const typeNamePtr, vb::WasmModule const *const ctx) {
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.createBaseType(WarpRunner::getString(ctx, typeNamePtr));
}

void createClass(uint32_t const classNamePtr, uint32_t const rtid, vb::WasmModule const *const ctx) {
  std::string const className{WarpRunner::getString(ctx, classNamePtr)};
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.createClass(className, rtid);
}

void addBaseClass(uint32_t const classNamePtr, uint32_t const parentNamePtr, vb::WasmModule const *const ctx) {
  std::string const className = WarpRunner::getString(ctx, classNamePtr);
  std::string parentClassName;
  if (parentNamePtr != 0U) {
    parentClassName = WarpRunner::getString(ctx, parentNamePtr);
    FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
    pCompiler->asModule_.variableInfo_.addBaseClass(className, parentClassName);
  }
}

void addField(uint32_t const classNamePtr, uint32_t const fieldNamePtr, uint32_t const typeNamePtr,
              uint32_t const offset, uint32_t const nullable, vb::WasmModule const *const ctx) {
  std::string const className = WarpRunner::getString(ctx, classNamePtr);
  std::string fieldName = WarpRunner::getString(ctx, fieldNamePtr);
  std::string typeName = WarpRunner::getString(ctx, typeNamePtr);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addField(className, std::move(fieldName), std::move(typeName), offset, nullable);
}

void addTemplateType(uint32_t const classNamePtr, uint32_t const templateTypeNamePtr, vb::WasmModule const *const ctx) {
  std::string const className = WarpRunner::getString(ctx, classNamePtr);
  std::string const templateTypeName = WarpRunner::getString(ctx, templateTypeNamePtr);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addTemplateType(className, templateTypeName);
}

void addGlobal(uint32_t const variableNamePtr, uint32_t const typeNamePtr, uint32_t const nullable, uint32_t isMutable,
               vb::WasmModule const *const ctx) {
  std::string variableName = WarpRunner::getString(ctx, variableNamePtr);
  std::string const typeName = WarpRunner::getString(ctx, typeNamePtr);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addGlobalType(std::move(variableName), typeName, nullable != 0, isMutable != 0);
}

void addSubProgram(uint32_t const subProgramNamePtr, uint32_t const belongClassNamePtr,
                   uint32_t const outerFunctionNamePtr, uint32_t const startLine, uint32_t const endLine,
                   vb::WasmModule const *const ctx) {
  std::string subProgramName = WarpRunner::getString(ctx, subProgramNamePtr);
  std::string const belongClassName = WarpRunner::getString(ctx, belongClassNamePtr);
  std::string const outerFunctionName = WarpRunner::getString(ctx, outerFunctionNamePtr);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addSubProgram(std::move(subProgramName), belongClassName, outerFunctionName,
                                                   startLine, endLine);
}

void addParameter(uint32_t const variableNamePtr, uint32_t const typeNamePtr, uint32_t const index,
                  uint32_t const nullable, vb::WasmModule const *const ctx) {
  std::string variableName = WarpRunner::getString(ctx, variableNamePtr);
  std::string const typeName = WarpRunner::getString(ctx, typeNamePtr);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addParameter(std::move(variableName), typeName, index, nullable != 0);
}

void addLocal(uint32_t const variableNamePtr, uint32_t const typeNamePtr, uint32_t const index, uint32_t const nullable,
              vb::WasmModule const *const ctx) {
  std::string variableName = WarpRunner::getString(ctx, variableNamePtr);
  std::string const typeName = WarpRunner::getString(ctx, typeNamePtr);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addLocal(std::move(variableName), typeName, index, nullable != 0);
}

void addTupleLocal(uint32_t const variableNamePtr, uint32_t const typeNamePtr, uint32_t const tupleFieldOffset,
                   uint32_t const storageLocalIndex, uint32_t const nullable, vb::WasmModule const *const ctx) {
  std::string variableName = WarpRunner::getString(ctx, variableNamePtr);
  std::string const typeName = WarpRunner::getString(ctx, typeNamePtr);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addTupleLocal(std::move(variableName), typeName, tupleFieldOffset,
                                                   storageLocalIndex, nullable != 0);
}

void addTupleParameter(uint32_t const variableNamePtr, uint32_t const typeNamePtr, uint32_t const tupleFieldOffset,
                       uint32_t const storageLocalIndex, uint32_t const nullable, vb::WasmModule const *const ctx) {
  std::string variableName = WarpRunner::getString(ctx, variableNamePtr);
  std::string const typeName = WarpRunner::getString(ctx, typeNamePtr);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addTupleParameter(std::move(variableName), typeName, tupleFieldOffset,
                                                       storageLocalIndex, nullable != 0);
}

void addHeapVariableStorageLocalIndex(uint32_t const subProgramNamePtr, uint32_t const index,
                                      vb::WasmModule const *const ctx) {
  std::string const subProgramName = WarpRunner::getString(ctx, subProgramNamePtr);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addHeapVariableStorageLocalIndex(subProgramName, index);
}

void enterScope(uint32_t const startLine, uint32_t const endLine, vb::WasmModule const *const ctx) {
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.enterScope(startLine, endLine);
}

void leaveScope(vb::WasmModule const *const ctx) {
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.leaveScope();
}

void leaveFunction(vb::WasmModule const *const ctx) {
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.leaveFunction();
}

} // namespace

std::vector<vb::NativeSymbol> createVariableInfoAPI() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("warpo", "_WarpoCreateBaseType", createBaseType),
      STATIC_LINK("warpo", "_WarpoCreateClass", createClass),
      STATIC_LINK("warpo", "_WarpoAddBaseClass", addBaseClass),
      STATIC_LINK("warpo", "_WarpoAddField", addField),
      STATIC_LINK("warpo", "_WarpoAddTemplateType", addTemplateType),
      STATIC_LINK("warpo", "_WarpoAddGlobal", addGlobal),
      STATIC_LINK("warpo", "_WarpoAddSubProgram", addSubProgram),
      STATIC_LINK("warpo", "_WarpoAddParameter", addParameter),
      STATIC_LINK("warpo", "_WarpoAddLocal", addLocal),
      STATIC_LINK("warpo", "_WarpoAddTupleLocal", addTupleLocal),
      STATIC_LINK("warpo", "_WarpoAddTupleParameter", addTupleParameter),
      STATIC_LINK("warpo", "_WarpoAddHeapVariableStorageLocalIndex", addHeapVariableStorageLocalIndex),
      STATIC_LINK("warpo", "_WarpoEnterScope", enterScope),
      STATIC_LINK("warpo", "_WarpoLeaveScope", leaveScope),
      STATIC_LINK("warpo", "_WarpoLeaveFunction", leaveFunction),
  };
}

} // namespace warpo::frontend
