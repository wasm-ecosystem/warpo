// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import {
  DW_AT,
  DW_TAG,
  buildOffsetMap,
  findDIEsByTag,
  getAttr,
  parseWasmDebugInfo,
  type DwarfDIE,
  type WasmGlobalEntry,
} from "./dwarfParser.js";
import type { ClassField, ClassLayout, GlobalRoot, RuntimeGlobals } from "./types.js";

const I32_TYPE_KIND = -1;

interface GlobalVariableDebugInfo {
  name: string;
  typeName: string;
  index: number;
}

/**
 * Resolves class layouts and global-root metadata from WebAssembly debug
 * information and provides helper queries for reference scanning.
 *
 * Only classes with a runtime ID (`DW_AT_signature`) are included.
 */
export class DebugInfoResolver {
  private readonly layoutMap: Map<number, ClassLayout>;
  private readonly globalVariables: GlobalVariableDebugInfo[];
  private readonly wasmGlobals: WasmGlobalEntry[];

  private constructor(
    layouts: ClassLayout[],
    globalVariables: GlobalVariableDebugInfo[],
    wasmGlobals: WasmGlobalEntry[]
  ) {
    this.layoutMap = new Map(layouts.map((l) => [l.rtid, l]));
    this.globalVariables = globalVariables;
    this.wasmGlobals = wasmGlobals;
  }

  static fromWasm(wasmBinary: Uint8Array | ArrayBuffer): DebugInfoResolver {
    const debugInfo = parseWasmDebugInfo(wasmBinary);
    const classes: ClassLayout[] = [];
    const globalVariables: GlobalVariableDebugInfo[] = [];

    for (const unit of debugInfo.compilationUnits) {
      const resolver = new CompilationUnitResolver(unit.rootDIE);
      for (const layout of resolver.resolve(unit.rootDIE)) {
        classes.push(layout);
      }
      for (const globalVariable of resolver.resolveGlobalVariables(unit.rootDIE)) {
        globalVariables.push(globalVariable);
      }
    }

    flattenInheritedFields(classes);
    const classNames = new Set(classes.map((layout) => layout.name));

    return new DebugInfoResolver(
      classes,
      globalVariables.filter((globalVariable) => classNames.has(globalVariable.typeName)),
      debugInfo.globals
    );
  }

  getLayouts(): ClassLayout[] {
    return Array.from(this.layoutMap.values());
  }

  /** Returns class name, or "Class#<id>" if not found in debug info */
  getClassName(classId: number): string {
    const layout = this.layoutMap.get(classId);
    return layout ? layout.name : `Class#${classId}`;
  }

  /** Returns ClassDef or undefined */
  getClassDef(classId: number): ClassLayout | undefined {
    return this.layoutMap.get(classId);
  }

  getGlobalRoots(rtGlobals: RuntimeGlobals): GlobalRoot[] {
    const i32ValuesByGlobalIndex = this.buildI32GlobalValueMap(rtGlobals);
    const globalRoots: GlobalRoot[] = [];

    for (const globalVariable of this.globalVariables) {
      const value = i32ValuesByGlobalIndex.get(globalVariable.index);
      if (value === undefined) {
        continue;
      }

      globalRoots.push({
        name: globalVariable.name,
        className: globalVariable.typeName,
        globalIndex: globalVariable.index,
        value,
      });
    }

    return globalRoots;
  }

  /**
   * Check if a type has no managed references (no reference fields, no reference elements).
   * Derived from field layout and elementIsReference rather than flags.
   */
  isPointerfree(classId: number): boolean {
    const layout = this.layoutMap.get(classId);
    if (!layout) {
      return false;
    }

    if (layout.elementIsReference === true) {
      return false;
    }

    for (const field of layout.fields) {
      if (field.isReference) {
        return false;
      }
    }

    return true;
  }

  /**
   * Returns all reference fields (isReference == true) for this class,
   * walking the full inheritance chain via base.
   */
  getReferenceFields(classId: number): ClassField[] {
    const layout = this.layoutMap.get(classId);
    if (!layout) {
      return [];
    }
    return layout.fields.filter((f) => f.isReference);
  }

  private buildI32GlobalValueMap(rtGlobals: RuntimeGlobals): Map<number, number> {
    const values = new Map<number, number>();
    let mutableI32Slot = 0;

    for (const globalEntry of this.wasmGlobals) {
      if (globalEntry.type.kind !== I32_TYPE_KIND) {
        continue;
      }

      if (globalEntry.mutable) {
        const value = rtGlobals.mutableI32Globals[mutableI32Slot];
        mutableI32Slot++;
        if (value === undefined) {
          continue;
        }
        values.set(globalEntry.index, value);
        continue;
      }

      values.set(globalEntry.index, globalEntry.initialValue);
    }

    return values;
  }
}

class CompilationUnitResolver {
  private readonly offsetMap: Map<number, DwarfDIE>;
  private readonly baseTypeNames: Set<string>;

  constructor(root: DwarfDIE) {
    this.offsetMap = buildOffsetMap(root);

    this.baseTypeNames = new Set<string>();
    for (const die of findDIEsByTag(root, DW_TAG.base_type)) {
      const name = getAttr(die, DW_AT.name)?.value as string | undefined;
      if (name) {
        this.baseTypeNames.add(name);
      }
    }
  }

  resolve(root: DwarfDIE): ClassLayout[] {
    const layouts: ClassLayout[] = [];
    for (const classDie of findDIEsByTag(root, DW_TAG.class_type)) {
      const layout = this.resolveClassLayout(classDie);
      if (layout) {
        layouts.push(layout);
      }
    }
    return layouts;
  }

  resolveGlobalVariables(root: DwarfDIE): GlobalVariableDebugInfo[] {
    const globalVariables: GlobalVariableDebugInfo[] = [];

    for (const child of root.children) {
      if (child.tag !== DW_TAG.variable) {
        continue;
      }

      const globalVariable = this.resolveGlobalVariable(child);
      if (globalVariable) {
        globalVariables.push(globalVariable);
      }
    }

    return globalVariables;
  }

  private resolveTypeInfo(typeRef: number): { name?: string; size: number; isReference: boolean } {
    const typeDie = this.offsetMap.get(typeRef);
    if (!typeDie) {
      return { size: 4, isReference: false };
    }
    const name = getAttr(typeDie, DW_AT.name)?.value as string | undefined;
    const isReference = name === undefined ? false : !this.baseTypeNames.has(name);
    const byteSize = getAttr(typeDie, DW_AT.byte_size);
    const size = byteSize === undefined ? 4 : (byteSize.value as number);
    return { name, size, isReference };
  }

  private resolveField(memberDie: DwarfDIE): ClassField | null {
    const nameAttr = getAttr(memberDie, DW_AT.name);
    const offsetAttr = getAttr(memberDie, DW_AT.data_member_location);
    const typeAttr = getAttr(memberDie, DW_AT.type);
    if (!nameAttr || offsetAttr === undefined || !typeAttr) {
      return null;
    }

    const { size, isReference } = this.resolveTypeInfo(typeAttr.value as number);
    return {
      name: nameAttr.value as string,
      offset: offsetAttr.value as number,
      size,
      isReference,
    };
  }

  private resolveTemplateType(classDie: DwarfDIE): string | undefined {
    const templateParam = classDie.children.find((c) => c.tag === DW_TAG.template_type_parameter);
    if (!templateParam) {
      return undefined;
    }

    const typeAttr = getAttr(templateParam, DW_AT.type);
    if (!typeAttr) {
      return undefined;
    }

    return this.resolveTypeInfo(typeAttr.value as number).name;
  }

  private resolveBaseName(classDie: DwarfDIE): string | null {
    const inheritanceDie = classDie.children.find((c) => c.tag === DW_TAG.inheritance);
    if (!inheritanceDie) {
      return null;
    }

    const typeAttr = getAttr(inheritanceDie, DW_AT.type);
    if (!typeAttr) {
      return null;
    }

    const parentDie = this.offsetMap.get(typeAttr.value as number);
    if (!parentDie) {
      return null;
    }

    return (getAttr(parentDie, DW_AT.name)?.value as string) ?? null;
  }

  private resolveGlobalVariable(variableDie: DwarfDIE): GlobalVariableDebugInfo | null {
    const nameAttr = getAttr(variableDie, DW_AT.name);
    const typeAttr = getAttr(variableDie, DW_AT.type);
    const locationAttr = getAttr(variableDie, DW_AT.location);
    if (!nameAttr || !typeAttr || !locationAttr) {
      return null;
    }

    const { name: typeName } = this.resolveTypeInfo(typeAttr.value as number);
    if (typeName === undefined) {
      return null;
    }

    return {
      name: nameAttr.value as string,
      typeName,
      index: locationAttr.value as number,
    };
  }

  private resolveClassLayout(classDie: DwarfDIE): ClassLayout | null {
    const nameAttr = getAttr(classDie, DW_AT.name);
    if (!nameAttr) {
      return null;
    }

    const sigAttr = getAttr(classDie, DW_AT.signature);
    if (sigAttr === undefined) {
      return null;
    }

    const members = classDie.children.filter((c) => c.tag === DW_TAG.member);
    const fields: ClassField[] = [];
    for (const member of members) {
      const field = this.resolveField(member);
      if (field) {
        fields.push(field);
      }
    }

    const layout: ClassLayout = {
      rtid: sigAttr.value as number,
      name: nameAttr.value as string,
      base: this.resolveBaseName(classDie),
      fields,
    };

    const templateType = this.resolveTemplateType(classDie);
    if (templateType !== undefined) {
      layout.templateType = templateType;
    }

    return layout;
  }
}

/**
 * Resolve all class layouts from DWARF debug information embedded in a
 * WebAssembly binary.
 *
 * Only classes with a runtime ID (`DW_AT_signature`) are included.
 */
export function resolveClassLayouts(wasmBinary: Uint8Array | ArrayBuffer): ClassLayout[] {
  return DebugInfoResolver.fromWasm(wasmBinary).getLayouts();
}

function flattenInheritedFields(classes: ClassLayout[]): void {
  const byName = new Map(classes.map((c) => [c.name, c]));
  const flattened = new Set<string>();

  function flatten(cls: ClassLayout): void {
    if (flattened.has(cls.name)) {
      return;
    }
    flattened.add(cls.name);

    if (!cls.base) {
      return;
    }

    const parent = byName.get(cls.base);
    if (!parent) {
      return;
    }

    flatten(parent);
    cls.fields = [...parent.fields, ...cls.fields];
  }

  for (const cls of classes) {
    flatten(cls);
  }
}
