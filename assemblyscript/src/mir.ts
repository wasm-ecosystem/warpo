import { CommonFlags } from "./common";
import { ExpressionRef } from "./module";
import { Global, Local, Function, Class } from "./program";
import { Type, TypeFlags } from "./types";
import {
  _WarpoAddBaseClass,
  _WarpoAddField,
  _WarpoAddGlobal,
  _WarpoEnterScope,
  _WarpoLeaveScope,
  _WarpoAddLocal,
  _WarpoAddTupleLocal,
  _WarpoAddTupleParameter,
  _WarpoAddParameter,
  _WarpoAddSubProgram,
  _WarpoAddTemplateType,
  _WarpoCreateBaseType,
  _WarpoCreateClass,
  _WarpoAddHeapVariableStorageLocalIndex,
  _WarpoLeaveFunction,
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

export function addGlobal(variable: Global, type: Type): void {
  _WarpoAddGlobal(
    variable.internalName,
    decodeURIComponent(typeToMIRName(type)),
    type.is(TypeFlags.Nullable),
    !variable.is(CommonFlags.Const)
  );
}

export function addParameter(subprogram: Function, variable: Local): void {
  if (variable.isClosureVariable()) {
    _WarpoAddTupleParameter(
      variable.name,
      decodeURIComponent(typeToMIRName(variable.type)),
      variable.getTupleElementInfo().offset,
      variable.tupleAddressLocalIndex,
      variable.type.is(TypeFlags.Nullable)
    );
  } else {
    _WarpoAddParameter(
      variable.name,
      decodeURIComponent(typeToMIRName(variable.type)),
      variable.index,
      variable.type.is(TypeFlags.Nullable)
    );
  }
}
export function addLocal(subProgram: Function, variable: Local): void {
  if (variable.isClosureVariable()) {
    _WarpoAddTupleLocal(
      variable.name,
      decodeURIComponent(typeToMIRName(variable.type)),
      variable.getTupleElementInfo().offset,
      variable.tupleAddressLocalIndex,
      variable.type.is(TypeFlags.Nullable)
    );
  } else {
    _WarpoAddLocal(
      variable.name,
      decodeURIComponent(typeToMIRName(variable.type)),
      variable.index,
      variable.type.is(TypeFlags.Nullable)
    );
  }
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
  let body = subprogram.prototype.bodyNode;
  let startLine: u32 = 0;
  let endLine: u32 = 0;
  if (body !== null) {
    let source = body.range.source;
    startLine = source.lineAt(body.range.start);
    endLine = source.lineAt(body.range.end);
  }
  _WarpoAddSubProgram(
    subprogram.internalName,
    belongClassName,
    outerFunctionName,
    startLine,
    endLine
  );
}

export function addHeapVariableStorageLocalIndex(subprogram: Function, index: u32): void {
  _WarpoAddHeapVariableStorageLocalIndex(subprogram.internalName, index);
}

export function enterScope(startLine: u32, endLine: u32): void {
  _WarpoEnterScope(startLine, endLine);
}

export function leaveScope(): void {
  _WarpoLeaveScope();
}

export function leaveFunction(): void {
  _WarpoLeaveFunction();
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
