// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { TypeKind } from "wasmparser/dist/cjs/WasmParser.js";

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
import { BuiltinContainerKind, type ClassField, type ClassLayout, type EntryLayout, type GlobalRoot } from "./types.js";

type ResolvedTypeInfo = { name?: string; size: number; isReference: boolean };

interface GlobalVariableDebugInfo {
  name: string;
  typeName: string;
  index: number;
}

function computeFieldExtent(fields: ClassField[]): number {
  let size = 0;
  for (const field of fields) {
    size = Math.max(size, field.offset + field.size);
  }
  return size;
}

function resolveEntryClassName(className: string): string | undefined {
  if (className.startsWith("~lib/set/Set<")) {
    return className.replace("~lib/set/Set<", "~lib/set/SetEntry<");
  }

  if (className.startsWith("~lib/map/Map<")) {
    return className.replace("~lib/map/Map<", "~lib/map/MapEntry<");
  }

  return undefined;
}

function attachEntryLayouts(classes: ClassLayout[]): void {
  const classByName = new Map(classes.map((classLayout) => [classLayout.name, classLayout]));

  for (const classLayout of classes) {
    if (classLayout.builtinKind !== BuiltinContainerKind.MapOrSet) {
      continue;
    }

    const entryClassName = resolveEntryClassName(classLayout.name);
    if (!entryClassName) {
      continue;
    }

    const entryClass = classByName.get(entryClassName);
    if (!entryClass) {
      continue;
    }

    const referenceOffsets = entryClass.fields
      .filter((field) => field.name !== "taggedNext" && field.isReference)
      .map((field) => field.offset);
    const size = entryClass.byteSize || computeFieldExtent(entryClass.fields);
    if (size === 0) {
      continue;
    }

    const entryLayout: EntryLayout = {
      size,
      referenceOffsets,
    };
    classLayout.entryLayout = entryLayout;
  }
}

/**
 * Resolves class layouts and global-root metadata from WebAssembly debug
 * information and provides helper queries for reference scanning.
 *
 * Only classes with a runtime ID (`DW_AT_signature`) are included.
 */
export class DebugInfoResolver {
  // Resolved runtime class layouts keyed by runtime type id.
  private readonly layoutMap: Map<number, ClassLayout>;
  // Resolved global variable debug info.
  private readonly globalVariableDebugInfos: GlobalVariableDebugInfo[];
  // Raw wasm global entries in module order, including mutability, type, and initial value.
  private readonly wasmGlobalEntries: WasmGlobalEntry[];

  private constructor(
    layouts: ClassLayout[],
    globalVariableDebugInfos: GlobalVariableDebugInfo[],
    wasmGlobalEntries: WasmGlobalEntry[]
  ) {
    this.layoutMap = new Map(layouts.map((l) => [l.rtid, l]));
    this.globalVariableDebugInfos = globalVariableDebugInfos;
    this.wasmGlobalEntries = wasmGlobalEntries;
  }

  static fromWasm(wasmBinary: Uint8Array | ArrayBuffer): DebugInfoResolver {
    const debugInfo = parseWasmDebugInfo(wasmBinary);
    const classes: ClassLayout[] = [];
    const globalVariableDebugInfos: GlobalVariableDebugInfo[] = [];

    for (const unit of debugInfo.compilationUnits) {
      const resolver = new CompilationUnitResolver(unit.rootDIE);
      for (const layout of resolver.resolve(unit.rootDIE)) {
        classes.push(layout);
      }
      for (const globalVariableDebugInfo of resolver.resolveGlobalVariableDebugInfos(unit.rootDIE)) {
        globalVariableDebugInfos.push(globalVariableDebugInfo);
      }
    }

    flattenInheritedFields(classes);
    attachEntryLayouts(classes);
    const classNames = new Set(classes.map((layout) => layout.name));

    return new DebugInfoResolver(
      classes,
      globalVariableDebugInfos.filter((globalVariableDebugInfo) => classNames.has(globalVariableDebugInfo.typeName)),
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

  getGlobalRoots(mutableI32GlobalValues: number[]): GlobalRoot[] {
    const i32ValuesByGlobalIndex = this.buildI32GlobalValueMap(mutableI32GlobalValues);
    const globalRoots: GlobalRoot[] = [];

    for (const globalVariableDebugInfo of this.globalVariableDebugInfos) {
      const value = i32ValuesByGlobalIndex.get(globalVariableDebugInfo.index);
      if (value === undefined) {
        continue;
      }

      globalRoots.push({
        name: globalVariableDebugInfo.name,
        className: globalVariableDebugInfo.typeName,
        globalIndex: globalVariableDebugInfo.index,
        value,
      });
    }

    return globalRoots;
  }

  /** Maps i32 wasm global indices to runtime mutable values or immutable initial values. */
  private buildI32GlobalValueMap(mutableI32GlobalValues: number[]): Map<number, number> {
    const values = new Map<number, number>();
    let mutableI32Slot = 0;

    for (const wasmGlobalEntry of this.wasmGlobalEntries) {
      if (wasmGlobalEntry.type.kind !== TypeKind.i32) {
        continue;
      }

      if (wasmGlobalEntry.mutable) {
        const value = mutableI32GlobalValues[mutableI32Slot];
        mutableI32Slot++;
        if (value === undefined) {
          continue;
        }
        values.set(wasmGlobalEntry.index, value);
        continue;
      }

      values.set(wasmGlobalEntry.index, wasmGlobalEntry.initialValue);
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

  resolveGlobalVariableDebugInfos(root: DwarfDIE): GlobalVariableDebugInfo[] {
    const globalVariableDebugInfos: GlobalVariableDebugInfo[] = [];

    for (const child of root.children) {
      if (child.tag !== DW_TAG.variable) {
        continue;
      }

      const globalVariableDebugInfo = this.resolveGlobalVariableDebugInfo(child);
      if (globalVariableDebugInfo) {
        globalVariableDebugInfos.push(globalVariableDebugInfo);
      }
    }

    return globalVariableDebugInfos;
  }

  private resolveTypeInfo(typeRef: number): ResolvedTypeInfo {
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

  private resolveTemplateType(classDie: DwarfDIE): ResolvedTypeInfo | undefined {
    const templateParam = classDie.children.find((c) => c.tag === DW_TAG.template_type_parameter);
    if (!templateParam) {
      return undefined;
    }

    const typeAttr = getAttr(templateParam, DW_AT.type);
    if (!typeAttr) {
      return undefined;
    }

    return this.resolveTypeInfo(typeAttr.value as number);
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

  private resolveGlobalVariableDebugInfo(variableDie: DwarfDIE): GlobalVariableDebugInfo | null {
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

  private resolveBuiltinKind(className: string): BuiltinContainerKind | undefined {
    if (className.startsWith("~lib/array/Array<")) {
      return BuiltinContainerKind.Array;
    }

    if (className.startsWith("~lib/staticarray/StaticArray<")) {
      return BuiltinContainerKind.StaticArray;
    }

    if (className.startsWith("~lib/map/Map<") || className.startsWith("~lib/set/Set<")) {
      return BuiltinContainerKind.MapOrSet;
    }

    if (className === "~lib/tuple/SmallTuple") {
      return BuiltinContainerKind.SmallTuple;
    }

    return undefined;
  }

  private resolveClassLayout(classDie: DwarfDIE): ClassLayout | null {
    const nameAttr = getAttr(classDie, DW_AT.name);
    if (nameAttr === undefined) {
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

    const templateType = this.resolveTemplateType(classDie);
    const className = nameAttr.value as string;
    const byteSizeAttr = getAttr(classDie, DW_AT.byte_size);

    const layout: ClassLayout = {
      rtid: sigAttr.value as number,
      name: className,
      base: this.resolveBaseName(classDie),
      byteSize: byteSizeAttr === undefined ? computeFieldExtent(fields) : (byteSizeAttr.value as number),
      fields,
      builtinKind: this.resolveBuiltinKind(className),
      templateType: templateType?.name,
      templateTypeIsReference: templateType?.isReference,
    };

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
