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
} from "./dwarfParser.js";

type ResolvedTypeInfo = { name?: string; size: number; isReference: boolean };

export interface ClassField {
  name: string;
  typeName: string;
  offset: number;
  size: number;
  isReference: boolean;
}

export enum BuiltinContainerKind {
  Array,
  StaticArray,
  MapOrSet,
  SmallTuple,
  Function,
}

export interface EntryLayout {
  size: number;
  referenceOffsets: number[];
}

export interface ClassLayout {
  rtid: number;
  name: string;
  base: string | null;
  byteSize: number;
  fields: ClassField[];
  builtinKind?: BuiltinContainerKind;
  templateType?: string;
  templateTypeIsReference?: boolean;
  entryLayout?: EntryLayout;
}

export function resolveArrayElementSize(typeName: string | undefined, isReference: boolean): number {
  if (isReference) {
    return 4;
  }

  switch (typeName) {
    case "bool":
    case "i8":
    case "u8": {
      return 1;
    }
    case "i16":
    case "u16": {
      return 2;
    }
    case "i64":
    case "u64":
    case "f64": {
      return 8;
    }
    default: {
      return 4;
    }
  }
}

function shouldKeepClassLayout(classLayout: ClassLayout): boolean {
  return classLayout.rtid !== 0 || classLayout.name === "~lib/object/Object";
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

    classLayout.entryLayout = {
      size,
      referenceOffsets,
    };
  }
}

export function attachBuiltinKind(classLayout: Pick<ClassLayout, "name" | "builtinKind">): void {
  const { name: className } = classLayout;

  if (className.startsWith("~lib/array/Array<")) {
    classLayout.builtinKind = BuiltinContainerKind.Array;
  } else if (className.startsWith("~lib/staticarray/StaticArray<")) {
    classLayout.builtinKind = BuiltinContainerKind.StaticArray;
  } else if (className.startsWith("~lib/map/Map<") || className.startsWith("~lib/set/Set<")) {
    classLayout.builtinKind = BuiltinContainerKind.MapOrSet;
  } else if (className.startsWith("~lib/function/Function<")) {
    classLayout.builtinKind = BuiltinContainerKind.Function;
  } else if (className === "~lib/tuple/SmallTuple") {
    classLayout.builtinKind = BuiltinContainerKind.SmallTuple;
  }
}

export class DwarfClassInfoResolver {
  private readonly layoutMap: Map<number, ClassLayout>;
  private readonly layoutsByName: Map<string, ClassLayout>;

  private constructor(layouts: ClassLayout[]) {
    this.layoutMap = new Map(layouts.map((layout) => [layout.rtid, layout]));
    this.layoutsByName = new Map(layouts.map((layout) => [layout.name, layout]));
  }

  static fromWasm(wasmBinary: Uint8Array | ArrayBuffer): DwarfClassInfoResolver {
    return new DwarfClassInfoResolver(resolveClassLayouts(wasmBinary));
  }

  getLayouts(): ClassLayout[] {
    return Array.from(this.layoutMap.values());
  }

  getClassName(classId: number): string {
    const layout = this.layoutMap.get(classId);
    return layout ? layout.name : `Class#${classId}`;
  }

  getClassDef(classId: number): ClassLayout | undefined {
    return this.layoutMap.get(classId);
  }

  getClassLayout(typeName: string): ClassLayout | undefined {
    return this.layoutsByName.get(typeName);
  }
}

export function resolveClassLayouts(wasmBinary: Uint8Array | ArrayBuffer): ClassLayout[] {
  const debugInfo = parseWasmDebugInfo(wasmBinary);
  const classes: ClassLayout[] = [];

  for (const unit of debugInfo.compilationUnits) {
    const resolver = new CompilationUnitClassResolver(unit.rootDIE);
    for (const layout of resolver.resolve(unit.rootDIE)) {
      classes.push(layout);
    }
  }

  flattenInheritedFields(classes);
  attachEntryLayouts(classes);

  return classes.filter(shouldKeepClassLayout);
}

class CompilationUnitClassResolver {
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

    const { name: typeName, size, isReference } = this.resolveTypeInfo(typeAttr.value as number);
    if (typeName === undefined) {
      return null;
    }

    return {
      name: nameAttr.value as string,
      typeName,
      offset: offsetAttr.value as number,
      size,
      isReference,
    };
  }

  private resolveTemplateType(classDie: DwarfDIE): ResolvedTypeInfo | undefined {
    const templateParam = classDie.children.find((child) => child.tag === DW_TAG.template_type_parameter);
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
    const inheritanceDie = classDie.children.find((child) => child.tag === DW_TAG.inheritance);
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

  private resolveClassLayout(classDie: DwarfDIE): ClassLayout | null {
    const nameAttr = getAttr(classDie, DW_AT.name);
    if (nameAttr === undefined) {
      return null;
    }

    const sigAttr = getAttr(classDie, DW_AT.signature);
    if (sigAttr === undefined) {
      return null;
    }

    const fields: ClassField[] = [];
    for (const member of classDie.children.filter((child) => child.tag === DW_TAG.member)) {
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
      templateType: templateType?.name,
      templateTypeIsReference: templateType?.isReference,
    };

    attachBuiltinKind(layout);

    return layout;
  }
}

function flattenInheritedFields(classes: ClassLayout[]): void {
  const byName = new Map(classes.map((classLayout) => [classLayout.name, classLayout]));
  const flattened = new Set<string>();

  function flatten(classLayout: ClassLayout): void {
    if (flattened.has(classLayout.name)) {
      return;
    }
    flattened.add(classLayout.name);

    if (!classLayout.base) {
      return;
    }

    const parent = byName.get(classLayout.base);
    if (!parent) {
      return;
    }

    flatten(parent);
    classLayout.fields = [...parent.fields, ...classLayout.fields];
  }

  for (const classLayout of classes) {
    flatten(classLayout);
  }
}
