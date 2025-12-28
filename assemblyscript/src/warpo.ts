// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { ExpressionRef } from "./module";

declare function _WarpoMarkDataElementImmutable(begin: u32, size: u32): void;
declare function _WarpoMarkCallInlined(expr: ExpressionRef): void;

declare function _WarpoCreateBaseType(typeName: string): void;
declare function _WarpoCreateClass(className: string, parentClassName: string | null, rtid: u32): void;
declare function _WarpoAddTemplateType(className: string, templateTypeName: string): void;

declare function _WarpoAddField(
  className: string,
  fieldName: string,
  typeName: string,
  offset: u32,
  nullable: bool
): void;
declare function _WarpoAddGlobal(variableName: string, typeName: string, nullable: bool): void;

declare function _WarpoAddSubProgram(subProgramName: string, belongClassName: string | null): void;
declare function _WarpoAddParameter(
  subProgramName: string,
  variableName: string,
  typeName: string,
  index: u32,
  nullable: bool
): void;
declare function _WarpoAddLocal(
  subProgramName: string,
  variableName: string,
  typeName: string,
  index: u32,
  scopeId: u32,
  nullable: bool
): void;
declare function _WarpoAddScope(
  functionName: string,
  startExpression: ExpressionRef,
  endExpression: ExpressionRef
): u32;

export function markDataElementImmutable(begin: i64, size: i32): void {
  _WarpoMarkDataElementImmutable(i64_low(begin), <u32>size);
}

export function markCallInlined(expr: ExpressionRef): void {
  _WarpoMarkCallInlined(expr);
}

export function createBaseType(typeName: string): void {
  _WarpoCreateBaseType(typeName);
}
export function createClass(className: string, parentClassName: string | null, rtid: u32): void {
  if (parentClassName !== null) {
    parentClassName = decodeURIComponent(parentClassName);
  }
  _WarpoCreateClass(decodeURIComponent(className), parentClassName, rtid);
}

export function addField(className: string, fieldName: string, typeName: string, offset: u32, nullable: bool): void {
  _WarpoAddField(decodeURIComponent(className), fieldName, decodeURIComponent(typeName), offset, nullable);
}

export function addTemplateType(className: string, templateTypeName: string): void {
  _WarpoAddTemplateType(decodeURIComponent(className), decodeURIComponent(templateTypeName));
}

export function addGlobal(variableName: string, typeName: string, nullable: bool): void {
  _WarpoAddGlobal(variableName, decodeURIComponent(typeName), nullable);
}

export function addSubProgram(subProgramName: string, belongClassName: string | null): void {
  if (belongClassName !== null) {
    belongClassName = decodeURIComponent(belongClassName);
  }
  _WarpoAddSubProgram(subProgramName, belongClassName);
}

export function addParameter(
  subProgramName: string,
  variableName: string,
  typeName: string,
  index: u32,
  nullable: bool
): void {
  _WarpoAddParameter(decodeURIComponent(subProgramName), variableName, decodeURIComponent(typeName), index, nullable);
}

export function addLocal(
  subProgramName: string,
  variableName: string,
  typeName: string,
  index: u32,
  scopeId: u32,
  nullable: bool
): void {
  _WarpoAddLocal(
    decodeURIComponent(subProgramName),
    variableName,
    decodeURIComponent(typeName),
    index,
    scopeId,
    nullable
  );
}

export function addScope(functionName: string, startExpression: ExpressionRef, endExpression: ExpressionRef): u32 {
  return _WarpoAddScope(decodeURIComponent(functionName), startExpression, endExpression);
}
