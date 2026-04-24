import { DW_AT, DW_TAG, buildOffsetMap, findDIEsByTag, getAttr, parseDwarf, type DwarfDIE } from "./dwarfParser.js";
import type { ClassField, ClassLayout } from "./types.js";

class ClassLayoutResolver {
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
      base: null,
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
  const dwarf = parseDwarf(wasmBinary);
  const classes: ClassLayout[] = [];

  for (const unit of dwarf.compilationUnits) {
    const resolver = new ClassLayoutResolver(unit.rootDIE);
    classes.push(...resolver.resolve(unit.rootDIE));
  }

  return classes;
}
