import { CommonFlags } from "./common";
import { ExpressionRef } from "./module";
import { Global, Local, Function, Class } from "./program";
import { Type, TypeFlags } from "./types";
import {
  _WarpoAddBaseClass,
  _WarpoAddField,
  _WarpoAddGlobal,
  _WarpoAddLocal,
  _WarpoAddParameter,
  _WarpoAddScope,
  _WarpoAddSubProgram,
  _WarpoAddTemplateType,
  _WarpoCreateBaseType,
  _WarpoCreateClass,
} from "./warpo";

function typeToMIRName(type: Type): string {
  if (type.isReference) {
    let classReference = type.getClass();
    if (classReference) {
      return classReference.internalName;
    } else {
      let signatureReference = type.getSignature();
      if (signatureReference) {
        return `~lib/function/Function<${signatureReference.toString(true)}>`;
      } else {
        return type.kindToString();
      }
    }
  }
  if (type == Type.auto) {
    return "auto";
  }
  return type.kindToString();
}

function classToMIRName(clazz: Class): string {
  return typeToMIRName(clazz.type);
}

export function addScope(subprogram: Function, startExpression: ExpressionRef, endExpression: ExpressionRef): u32 {
  return _WarpoAddScope(decodeURIComponent(subprogram.internalName), startExpression, endExpression);
}

export function addGlobal(variable: Global, type: Type): void {
  _WarpoAddGlobal(
    variable.internalName,
    decodeURIComponent(typeToMIRName(type)),
    type.is(TypeFlags.Nullable),
    !variable.is(CommonFlags.Const)
  );
}

export function addParameter(subprogram: Function, variable: Local): void {
  _WarpoAddParameter(
    decodeURIComponent(subprogram.internalName),
    variable.name,
    decodeURIComponent(typeToMIRName(variable.type)),
    variable.index,
    variable.type.is(TypeFlags.Nullable)
  );
}
export function addLocal(subProgram: Function, variable: Local, scopeId: u32): void {
  _WarpoAddLocal(
    decodeURIComponent(subProgram.internalName),
    variable.name,
    decodeURIComponent(typeToMIRName(variable.type)),
    variable.index,
    scopeId,
    variable.type.is(TypeFlags.Nullable)
  );
}

export function createBaseType(type: Type): void {
  _WarpoCreateBaseType(typeToMIRName(type));
}

export function addSubProgram(subprogram: Function, belongClass: Class | null): void {
  let belongClassName: string | null = null;
  if (belongClass !== null) {
    belongClassName = decodeURIComponent(typeToMIRName(belongClass.type));
  }
  _WarpoAddSubProgram(decodeURIComponent(subprogram.internalName), belongClassName);
}

export function createClass(clazz: Class): void {
  _WarpoCreateClass(decodeURIComponent(classToMIRName(clazz)), clazz.id);
}

export function addBaseClass(clazz: Class, baseClass: Class): void {
  _WarpoAddBaseClass(decodeURIComponent(classToMIRName(clazz)), decodeURIComponent(classToMIRName(baseClass)));
}

export function addField(clazz: Class, fieldName: string, fieldType: Type, offset: u32): void {
  _WarpoAddField(
    decodeURIComponent(classToMIRName(clazz)),
    fieldName,
    decodeURIComponent(typeToMIRName(fieldType)),
    offset,
    fieldType.is(TypeFlags.Nullable)
  );
}

export function addTemplateType(clazz: Class, templateType: Type): void {
  _WarpoAddTemplateType(decodeURIComponent(classToMIRName(clazz)), decodeURIComponent(typeToMIRName(templateType)));
}
