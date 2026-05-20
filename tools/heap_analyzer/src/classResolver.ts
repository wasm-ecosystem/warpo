// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { DW_AT, DW_TAG, buildOffsetMap, findDIEsByTag, getAttr, parseDwarf, type DwarfDIE } from "./dwarfParser.js";
import type { ClassField, ClassLayout } from "./types.js";

/**
 * Resolves class layouts from DWARF debug information embedded in a
 * WebAssembly binary and provides helper queries for reference scanning.
 *
 * Only classes with a runtime ID (`DW_AT_signature`) are included.
 */
export class ClassResolver {
  private readonly layoutMap: Map<number, ClassLayout>;

  private constructor(layouts: ClassLayout[]) {
    this.layoutMap = new Map(layouts.map((l) => [l.rtid, l]));
  }

  static fromWasm(wasmBinary: Uint8Array | ArrayBuffer): ClassResolver {
    const dwarf = parseDwarf(wasmBinary);
    const classes: ClassLayout[] = [];

    for (const unit of dwarf.compilationUnits) {
      const resolver = new CompilationUnitResolver(unit.rootDIE);
      for (const layout of resolver.resolve(unit.rootDIE)) {
        classes.push(layout);
      }
    }

    flattenInheritedFields(classes);
    return new ClassResolver(classes);
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
  return ClassResolver.fromWasm(wasmBinary).getLayouts();
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
