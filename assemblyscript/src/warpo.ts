// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { ExpressionRef } from "./module";

declare function _WarpoMarkDataElementImmutable(begin: u32, size: u32): void;
declare function _WarpoMarkCallInlined(expr: ExpressionRef): void;

export declare function _WarpoCreateBaseType(typeName: string): void;
export declare function _WarpoCreateClass(className: string, rtid: u32): void;
export declare function _WarpoCreateClassWithoutRtid(className: string): void;
export declare function _WarpoAddBaseClass(className: string, parentClassName: string | null): void;
export declare function _WarpoAddTemplateType(className: string, templateTypeName: string): void;

export declare function _WarpoAddField(
  className: string,
  fieldName: string,
  typeName: string,
  offset: u32,
  nullable: bool
): void;
export declare function _WarpoAddGlobal(variableName: string, typeName: string, nullable: bool, isMutable: bool): void;

export declare function _WarpoAddSubProgram(
  subProgramName: string,
  belongClassName: string | null,
  outerFunctionName: string | null
): void;
export declare function _WarpoAddParameter(
  variableName: string,
  typeName: string,
  index: u32,
  nullable: bool
): void;
export declare function _WarpoAddLocal(
  variableName: string,
  typeName: string,
  index: u32,
  nullable: bool
): void;
export declare function _WarpoAddTupleLocal(
  variableName: string,
  typeName: string,
  tupleFieldOffset: u32,
  storageLocalIndex: u32,
  nullable: bool
): void;
export declare function _WarpoAddTupleParameter(
  variableName: string,
  typeName: string,
  tupleFieldOffset: u32,
  storageLocalIndex: u32,
  nullable: bool
): void;

export declare function _WarpoAddHeapVariableStorageLocalIndex(subProgramName: string, index: u32): void;
export declare function _WarpoEnterScope(startLine: u32, endLine: u32): void;
export declare function _WarpoLeaveScope(): void;

export function markDataElementImmutable(begin: i64, size: i32): void {
  _WarpoMarkDataElementImmutable(i64_low(begin), <u32>size);
}

export function markCallInlined(expr: ExpressionRef): void {
  _WarpoMarkCallInlined(expr);
}
