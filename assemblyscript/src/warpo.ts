import { ExpressionRef } from "./module";

declare function _WarpoMarkDataElementImmutable(begin: u32, size: u32): void;

declare function _WarpoCreateBaseType(typeName: string): void;
declare function _WarpoCreateClass(className: string, parentClassName: string | null, rtid: u32): void;
declare function _WarpoAddTemplateType(className: string, templateTypeName: string): void;

declare function _WarpoAddField(className: string, fieldName: string, typeName: string, offset: u32, nullable: bool): void;
declare function _WarpoAddGlobal(variableName: string, typeName: string, nullable: bool): void;

declare function _WarpoAddSubProgram(subProgramName: string, belongClassName: string | null): void;
declare function _WarpoAddParameter(subProgramName: string, variableName: string, typeName: string, index: u32, nullable: bool): void;
declare function _WarpoAddLocal(subProgramName: string, variableName: string, typeName: string, index: u32, scopeId: u32, nullable: bool): void;
declare function _WarpoAddScope(startExpression: ExpressionRef, endExpression: ExpressionRef): u32;

export function markDataElementImmutable(begin: i64, size: i32): void {
  _WarpoMarkDataElementImmutable(i64_low(begin), <u32>size);
}

export function createBaseType(typeName: string): void {
  _WarpoCreateBaseType(typeName);
}
export function createClass(className: string, parentClassName: string | null, rtid: u32): void {
  _WarpoCreateClass(className, parentClassName, rtid);
}

export function addField(className: string, fieldName: string, typeName: string, offset: u32, nullable: bool): void {
  _WarpoAddField(className, fieldName, typeName, offset, nullable);
}

export function addTemplateType(className: string, templateTypeName: string): void {
  _WarpoAddTemplateType(className, templateTypeName);
}

export function addGlobal(variableName: string, typeName: string, nullable: bool): void {
  _WarpoAddGlobal(variableName, typeName, nullable);
}

export function addSubProgram(subProgramName: string, belongClassName: string | null): void {
  _WarpoAddSubProgram(subProgramName, belongClassName);
}

export function addParameter(subProgramName: string, variableName: string, typeName: string, index: u32, nullable: bool): void {
  _WarpoAddParameter(subProgramName, variableName, typeName, index, nullable);
}

export function addLocal(subProgramName: string, variableName: string, typeName: string, index: u32, scopeId: u32, nullable: bool): void {
  _WarpoAddLocal(subProgramName, variableName, typeName, index, scopeId, nullable);
}

export function addScope(startExpression: ExpressionRef, endExpression: ExpressionRef): u32 {
  return _WarpoAddScope(startExpression, endExpression);
}
