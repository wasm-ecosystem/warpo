// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

#include <cassert>
#include <utility>

#include "AsString.hpp"
#include "CompilerImpl.hpp"
#include "LinkedAPI.hpp"
#include "warpo/common/AsModule.hpp"

#include "src/core/common/function_traits.hpp"

namespace warpo::frontend {

namespace {

void createClass(uint32_t const classNamePtr, uint32_t const parentNamePtr, uint32_t const rtid,
                 vb::WasmModule const *const ctx) {
  std::string className{AsString::get(classNamePtr, ctx)};
  std::string parentName{AsString::get(parentNamePtr, ctx)};

  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.createClass(std::move(className), std::move(parentName), rtid);
}

void addField(uint32_t const classNamePtr, uint32_t const fieldNamePtr, uint32_t const typeNamePtr,
              uint32_t const offset, uint32_t const nullable, vb::WasmModule const *const ctx) {
  std::string const className = AsString::get(classNamePtr, ctx);
  std::string fieldName = AsString::get(fieldNamePtr, ctx);
  std::string typeName = AsString::get(typeNamePtr, ctx);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addField(className, std::move(fieldName), std::move(typeName), offset, nullable);
}

void addTemplateType(uint32_t const classNamePtr, uint32_t const templateTypeNamePtr, vb::WasmModule const *const ctx) {
  std::string const className = AsString::get(classNamePtr, ctx);
  std::string const templateTypeName = AsString::get(templateTypeNamePtr, ctx);
  FrontendCompiler *const pCompiler = static_cast<FrontendCompiler *>(ctx->getContext());
  pCompiler->asModule_.variableInfo_.addTemplateType(className, templateTypeName);
}
} // namespace

std::vector<vb::NativeSymbol> createVariableInfoAPI() {
  return std::vector<vb::NativeSymbol>{
      STATIC_LINK("warpo", "_WarpoCreateClass", createClass),
      STATIC_LINK("warpo", "_WarpoAddField", addField),
      STATIC_LINK("warpo", "_WarpoAddTemplateType", addTemplateType),
  };
}

} // namespace warpo::frontend
