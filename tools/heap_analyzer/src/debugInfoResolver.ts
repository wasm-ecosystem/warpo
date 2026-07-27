// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { TypeKind } from "wasmparser/dist/cjs/WasmParser.js";

import { DwarfClassInfoResolver, type ClassLayout } from "../../dwarf/classDebugInfo.js";
import {
  DW_AT,
  DW_TAG,
  buildOffsetMap,
  getAttr,
  parseWasmDebugInfo,
  type DwarfDIE,
  type WasmGlobalEntry,
} from "../../dwarf/dwarfParser.js";
import type { GlobalRoot } from "./types.js";

export { attachBuiltinKind, resolveClassLayouts } from "../../dwarf/classDebugInfo.js";

type ResolvedTypeInfo = { name?: string };

interface GlobalVariableDebugInfo {
  name: string;
  typeName: string;
  index: number;
}

/**
 * Resolves class layouts and global-root metadata from WebAssembly debug
 * information and provides helper queries for reference scanning.
 */
export class DebugInfoResolver {
  private readonly classInfoResolver: DwarfClassInfoResolver;
  private readonly globalVariableDebugInfos: GlobalVariableDebugInfo[];
  private readonly wasmGlobalEntries: WasmGlobalEntry[];

  private constructor(
    classInfoResolver: DwarfClassInfoResolver,
    globalVariableDebugInfos: GlobalVariableDebugInfo[],
    wasmGlobalEntries: WasmGlobalEntry[]
  ) {
    this.classInfoResolver = classInfoResolver;
    this.globalVariableDebugInfos = globalVariableDebugInfos;
    this.wasmGlobalEntries = wasmGlobalEntries;
  }

  static fromWasm(wasmBinary: Uint8Array | ArrayBuffer): DebugInfoResolver {
    const debugInfo = parseWasmDebugInfo(wasmBinary);
    const globalVariableDebugInfos: GlobalVariableDebugInfo[] = [];

    for (const unit of debugInfo.compilationUnits) {
      const resolver = new CompilationUnitGlobalResolver(unit.rootDIE);
      for (const globalVariableDebugInfo of resolver.resolveGlobalVariableDebugInfos(unit.rootDIE)) {
        globalVariableDebugInfos.push(globalVariableDebugInfo);
      }
    }

    const classInfoResolver = DwarfClassInfoResolver.fromWasm(wasmBinary);
    const classNames = new Set(classInfoResolver.getLayouts().map((layout) => layout.name));

    return new DebugInfoResolver(
      classInfoResolver,
      globalVariableDebugInfos.filter((globalVariableDebugInfo) => classNames.has(globalVariableDebugInfo.typeName)),
      debugInfo.globals
    );
  }

  getLayouts(): ClassLayout[] {
    return this.classInfoResolver.getLayouts();
  }

  getClassName(classId: number): string {
    return this.classInfoResolver.getClassName(classId);
  }

  getClassDef(classId: number): ClassLayout | undefined {
    return this.classInfoResolver.getClassDef(classId);
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

  private buildI32GlobalValueMap(mutableI32GlobalValues: number[]): Map<number, number> {
    const values = new Map<number, number>();
    let mutableI32Slot = 0;

    for (const wasmGlobalEntry of this.wasmGlobalEntries) {
      if (wasmGlobalEntry.type.kind !== TypeKind.i32) {
        continue;
      }

      if (wasmGlobalEntry.mutable) {
        if (mutableI32Slot >= mutableI32GlobalValues.length) {
          mutableI32Slot++;
          continue;
        }

        const value = mutableI32GlobalValues[mutableI32Slot];
        mutableI32Slot++;
        values.set(wasmGlobalEntry.index, value);
        continue;
      }

      values.set(wasmGlobalEntry.index, wasmGlobalEntry.initialValue);
    }

    return values;
  }
}

class CompilationUnitGlobalResolver {
  private readonly offsetMap: Map<number, DwarfDIE>;

  constructor(root: DwarfDIE) {
    this.offsetMap = buildOffsetMap(root);
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
      return {};
    }

    return { name: getAttr(typeDie, DW_AT.name)?.value as string | undefined };
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
}
