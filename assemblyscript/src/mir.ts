import { CommonFlags } from "./common";
import { ExpressionRef } from "./module";
import { Global, Local, Function, Class } from "./program";
import { Type, TypeFlags } from "./types";
import {
  _WarpoAddBaseClass,
  _WarpoAddField,
  _WarpoAddGlobal,
  _WarpoAddLocal,
  _WarpoAddTupleLocal,
  _WarpoAddParameter,
  _WarpoAddScope,
  _WarpoAddSubProgram,
  _WarpoAddTemplateType,
  _WarpoCreateBaseType,
  _WarpoCreateClass,
  _WarpoCreateClassWithoutRtid,
  _WarpoAddHeapVariableStorageLocalIndex,
} from "./warpo";

function typeToMIRName(type: Type): string {
  if (type.isReference) {
    let classReference = type.getClass();
    if (classReference) {
      if (type.isTuple) {
        let tupleInfo = type.tupleInfo!;
        let elementNames = new Array<string>(tupleInfo.elementCount);
        for (let i = 0; i < tupleInfo.elementCount; i++) {
          elementNames[i] = typeToMIRName(tupleInfo.elements[i].type);
        }
        return `[${elementNames.join(",")}]`;
      } else {
        return classReference.internalName;
      }
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
  return _WarpoAddScope(subprogram.internalName, startExpression, endExpression);
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
    subprogram.internalName,
    variable.name,
    decodeURIComponent(typeToMIRName(variable.type)),
    variable.index,
    variable.type.is(TypeFlags.Nullable)
  );
}
export function addLocal(subProgram: Function, variable: Local, scopeId: u32): void {
  if (variable.isClosureVariable()) {
    _WarpoAddTupleLocal(
      subProgram.internalName,
      variable.name,
      decodeURIComponent(typeToMIRName(variable.type)),
      variable.getTupleElementInfo().offset,
      scopeId,
      variable.type.is(TypeFlags.Nullable)
    );
  } else {
    _WarpoAddLocal(
      subProgram.internalName,
      variable.name,
      decodeURIComponent(typeToMIRName(variable.type)),
      variable.index,
      scopeId,
      variable.type.is(TypeFlags.Nullable)
    );
  }
}

export function addTupleLocal(
  subProgram: Function,
  variableName: string,
  variableType: Type,
  tupleFieldOffset: u32,
  scopeId: u32
): void {
  _WarpoAddTupleLocal(
    subProgram.internalName,
    variableName,
    decodeURIComponent(typeToMIRName(variableType)),
    tupleFieldOffset,
    scopeId,
    variableType.is(TypeFlags.Nullable)
  );
}

export function createBaseType(type: Type): void {
  _WarpoCreateBaseType(typeToMIRName(type));
}

export function addSubProgram(
  subprogram: Function,
  belongClass: Class | null,
  outerFunctionName: string | null = null
): void {
  let belongClassName: string | null = null;
  if (belongClass !== null) {
    belongClassName = decodeURIComponent(typeToMIRName(belongClass.type));
  }
  _WarpoAddSubProgram(subprogram.internalName, belongClassName, outerFunctionName);
}

export function addHeapVariableStorageLocalIndex(subprogram: Function, index: u32): void {
  _WarpoAddHeapVariableStorageLocalIndex(subprogram.internalName, index);
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

export function getTupleMIRName(tupleType: Type): string {
  return typeToMIRName(tupleType);
}

export function createTupleType(tupleType: Type): void {
  const tupleInfo = tupleType.tupleInfo;
  if (!tupleInfo) return;

  const decodedClassName = decodeURIComponent(typeToMIRName(tupleType));
  _WarpoCreateClassWithoutRtid(decodedClassName);

  // Add each element as a field
  for (let i = 0; i < tupleInfo.elements.length; i++) {
    const elementInfo = tupleInfo.elements[i];
    _WarpoAddField(
      decodedClassName,
      `${i}`,
      decodeURIComponent(typeToMIRName(elementInfo.type)),
      elementInfo.offset,
      elementInfo.type.is(TypeFlags.Nullable)
    );
  }
}
