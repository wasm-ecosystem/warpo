// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import assert from "node:assert/strict";
import { existsSync } from "node:fs";
import { readFile } from "node:fs/promises";
import * as path from "node:path";
import { DwarfClassInfoResolver, type ClassLayout } from "../dwarf/classDebugInfo.js";
import {
  DwarfFunctionInfoResolver,
  getClosureVariableLevels,
  getScopeChainInFunctionAtBytecodeOffset,
  getVariablesInFunctionAtBytecodeOffset,
  type DwarfClosureVariableLevel,
  type DwarfFunctionInfo,
  type DwarfGlobalVariableInfo,
  type DwarfLocalVariableInfo,
  type DwarfScopeInfo,
} from "../dwarf/functionDebugInfo.js";
import { readULEB128 } from "../common/leb128.js";
import { SourceMapConsumer, type BasicSourceMapConsumer, type RawSourceMap } from "source-map";
import {
  BinaryReader,
  BinaryReaderState,
  NameType,
  OperatorCode,
  type IElementSegment,
  type IFunctionNameEntry,
  type IOperatorInformation,
} from "wasmparser";
import { normalizeDebugPath } from "./debugPath.js";

export type ParsedSourceMap = BasicSourceMapConsumer;

interface WasmFunctionTableInfo {
  functionIndicesByTableIndex: Map<number, number>;
  namesByFunctionIndex: Map<number, string>;
}

export interface DebuggerBreakpointInfo {
  id: number;
  line: number;
  verified: boolean;
  source: string;
}

interface DebuggerSourceVariableInfoBase {
  name: string;
  typeName: string;
}

export interface DebuggerWasmLocalVariableInfo extends DebuggerSourceVariableInfoBase {
  kind: "wasm-local";
  localIndex: number;
}

export interface DebuggerClosureVariableInfo extends DebuggerSourceVariableInfoBase {
  kind: "closure";
  closureEnvLocalIndex: number;
  fieldOffset: number;
}

export interface DebuggerWasmGlobalVariableInfo extends DebuggerSourceVariableInfoBase {
  kind: "wasm-global";
  globalIndex: number;
}

export type DebuggerSourceVariableInfo =
  | DebuggerWasmLocalVariableInfo
  | DebuggerClosureVariableInfo
  | DebuggerWasmGlobalVariableInfo;

export interface DebuggerVariableScope {
  name: string;
  variables: DebuggerSourceVariableInfo[];
  closureEnvLocalIndex?: number;
  rootClosureEnvLocalIndex?: number;
  tupleLevel?: number;
}

export interface DebuggerBreakpointLocation {
  wasmBytecodeOffset: number;
  sourceLine: number;
}

export interface DebuggerSourceLocation {
  sourcePath: string;
  sourceLine: number;
}

export function getNextBytecodeOffsetAfterCall(bytecode: Uint8Array, wasmBytecodeOffset: number): number | undefined {
  if (wasmBytecodeOffset < 0 || wasmBytecodeOffset >= bytecode.byteLength) {
    return undefined;
  }

  const opcode = bytecode[wasmBytecodeOffset] as OperatorCode;
  if (opcode !== OperatorCode.call && opcode !== OperatorCode.call_indirect && opcode !== OperatorCode.call_ref) {
    return undefined;
  }

  const immediateOffset = wasmBytecodeOffset + 1;
  if (immediateOffset >= bytecode.byteLength) {
    return undefined;
  }

  try {
    const immediate = readULEB128(bytecode, immediateOffset);
    if (opcode === OperatorCode.call_indirect) {
      return readULEB128(bytecode, immediate.nextOffset).nextOffset;
    }
    return immediate.nextOffset;
  } catch {
    return undefined;
  }
}

export class DebuggerWasmModule {
  private readonly sourcesByPath: ReadonlyMap<string, string>;
  private readonly breakpointLocations = new Map<string, number[]>();

  private constructor(
    readonly scriptId: string,
    readonly url: string,
    readonly wasmFilePath: string,
    readonly sourceMapFilePath: string,
    readonly bytecode: Uint8Array,
    private readonly sourceMap: ParsedSourceMap,
    private readonly functionTableInfo: WasmFunctionTableInfo,
    private readonly functionInfoResolver: DwarfFunctionInfoResolver,
    private readonly classInfoResolver: DwarfClassInfoResolver
  ) {
    this.sourcesByPath = new Map(
      sourceMap.sources.map((source) => [DebuggerWasmModule.resolveSourcePath(sourceMapFilePath, source), source])
    );
  }

  static async load(
    wasmFilePath: string,
    runtimeInfo?: { scriptId?: string; url?: string }
  ): Promise<DebuggerWasmModule> {
    const sourceMapFilePath = `${wasmFilePath}.map`;
    const [bytecode, sourceMap] = await Promise.all([
      readFile(wasmFilePath),
      DebuggerWasmModule.loadSourceMap(sourceMapFilePath),
    ]);

    return new DebuggerWasmModule(
      runtimeInfo?.scriptId ?? "",
      runtimeInfo?.url ?? "",
      wasmFilePath,
      sourceMapFilePath,
      bytecode,
      sourceMap,
      parseWasmFunctionTableInfo(bytecode),
      DwarfFunctionInfoResolver.fromWasm(bytecode),
      DwarfClassInfoResolver.fromWasm(bytecode)
    );
  }

  dispose(): void {
    this.sourceMap.destroy();
  }

  resolveBreakpointLocations(breakpoint: DebuggerBreakpointInfo): DebuggerBreakpointLocation[] {
    const { source: sourcePath, line } = breakpoint;
    const source = this.findSource(sourcePath);
    if (!source) {
      return [];
    }

    const cacheKey = `${source}:${line}`;
    const cachedWasmBytecodeOffsets = this.breakpointLocations.get(cacheKey);
    if (cachedWasmBytecodeOffsets !== undefined) {
      return cachedWasmBytecodeOffsets.map((wasmBytecodeOffset) => ({ wasmBytecodeOffset, sourceLine: line }));
    }

    const wasmBytecodeOffsetsByFunction = new Map<DwarfFunctionInfo, number>();
    let firstWasmBytecodeOffsetWithoutFunction: number | undefined;
    this.sourceMap.eachMapping((mapping) => {
      if (mapping.source !== source || mapping.originalLine !== line || mapping.generatedLine !== 1) {
        return;
      }

      const functionInfo = this.functionInfoResolver.findFunctionByBytecodeOffset(mapping.generatedColumn);
      if (!functionInfo) {
        if (
          firstWasmBytecodeOffsetWithoutFunction === undefined ||
          mapping.generatedColumn < firstWasmBytecodeOffsetWithoutFunction
        ) {
          firstWasmBytecodeOffsetWithoutFunction = mapping.generatedColumn;
        }
        return;
      }

      const existingOffset = wasmBytecodeOffsetsByFunction.get(functionInfo);
      if (existingOffset === undefined || mapping.generatedColumn < existingOffset) {
        wasmBytecodeOffsetsByFunction.set(functionInfo, mapping.generatedColumn);
      }
    });

    const wasmBytecodeOffsets = Array.from(wasmBytecodeOffsetsByFunction.values());
    if (firstWasmBytecodeOffsetWithoutFunction !== undefined) {
      wasmBytecodeOffsets.push(firstWasmBytecodeOffsetWithoutFunction);
    }
    const sortedWasmBytecodeOffsets = wasmBytecodeOffsets.toSorted((left, right) => left - right);
    this.breakpointLocations.set(cacheKey, sortedWasmBytecodeOffsets);
    return sortedWasmBytecodeOffsets.map((wasmBytecodeOffset) => ({ wasmBytecodeOffset, sourceLine: line }));
  }

  resolveBreakpointLocation(breakpoint: DebuggerBreakpointInfo): DebuggerBreakpointLocation | undefined {
    return this.resolveBreakpointLocations(breakpoint)[0];
  }

  findBytecodeOffset(sourcePath: string, line: number): number | undefined {
    return this.resolveBreakpointLocation({
      id: 0,
      line,
      verified: true,
      source: sourcePath,
    })?.wasmBytecodeOffset;
  }

  getNextBytecodeOffsetAfterCall(wasmBytecodeOffset: number): number | undefined {
    return getNextBytecodeOffsetAfterCall(this.bytecode, wasmBytecodeOffset);
  }

  getFunctionNameByTableIndex(tableIndex: number): string | undefined {
    const functionIndex = this.functionTableInfo.functionIndicesByTableIndex.get(tableIndex);
    return functionIndex === undefined ? undefined : this.functionTableInfo.namesByFunctionIndex.get(functionIndex);
  }

  getVariablesAtBytecodeOffset(wasmBytecodeOffset: number): DebuggerSourceVariableInfo[] | undefined {
    const functionInfo = this.functionInfoResolver.findFunctionByBytecodeOffset(wasmBytecodeOffset);
    if (!functionInfo) {
      return undefined;
    }

    const variables: DebuggerSourceVariableInfo[] = [];
    for (const variable of getVariablesInFunctionAtBytecodeOffset(functionInfo, wasmBytecodeOffset)) {
      variables.push(DebuggerWasmModule.toSourceVariableInfo(variable));
    }
    return variables;
  }

  getVariableScopesAtBytecodeOffset(wasmBytecodeOffset: number): DebuggerVariableScope[] | undefined {
    const functionInfo = this.functionInfoResolver.findFunctionByBytecodeOffset(wasmBytecodeOffset);
    if (!functionInfo) {
      return undefined;
    }

    return this.getVariableScopes(functionInfo, wasmBytecodeOffset);
  }

  private getVariableScopes(
    functionInfo: ReturnType<DwarfFunctionInfoResolver["findFunctionByBytecodeOffset"]>,
    wasmBytecodeOffset: number
  ): DebuggerVariableScope[] {
    assert(functionInfo !== undefined);
    const scopeChain = getScopeChainInFunctionAtBytecodeOffset(functionInfo, wasmBytecodeOffset);
    const scopes: DebuggerVariableScope[] = [];
    const functionName = DebuggerWasmModule.getFunctionBaseName(functionInfo.name);
    const closureEnvLocalIndex = functionInfo.closureEnvLocalIndex;
    const currentTupleLevel = closureEnvLocalIndex === undefined ? undefined : 0;

    for (const scope of scopeChain.toReversed()) {
      if (scope.variables.length > 0) {
        scopes.push(
          DebuggerWasmModule.toVariableScope(`Block: ${functionName}`, scope, closureEnvLocalIndex, currentTupleLevel)
        );
      }
    }

    const functionVariables: DwarfLocalVariableInfo[] = [];
    for (const parameter of functionInfo.parameters) {
      functionVariables.push(parameter);
    }
    for (const variable of functionInfo.variables) {
      functionVariables.push(variable);
    }
    if (functionVariables.length > 0) {
      const localClosureEnvLocalIndex =
        closureEnvLocalIndex ?? DebuggerWasmModule.findClosureEnvLocalIndex(functionVariables);
      scopes.push({
        name: `Local: ${functionName}`,
        variables: functionVariables.map((variable) => DebuggerWasmModule.toSourceVariableInfo(variable)),
        closureEnvLocalIndex: localClosureEnvLocalIndex,
        rootClosureEnvLocalIndex: localClosureEnvLocalIndex,
        tupleLevel: localClosureEnvLocalIndex === undefined ? undefined : 0,
      });
    }

    const closureLevels = getClosureVariableLevels(functionInfo);
    for (const level of closureLevels) {
      if (level.level === 0) {
        continue;
      }
      if (level.variables.length > 0) {
        scopes.push(DebuggerWasmModule.toClosureVariableScope(level, closureEnvLocalIndex ?? -1));
      }
    }

    const globals = this.functionInfoResolver.getGlobals();
    if (globals.length > 0) {
      scopes.push({
        name: "Global",
        variables: globals.map((variable) => DebuggerWasmModule.toGlobalSourceVariableInfo(variable)),
      });
    }

    return scopes;
  }

  getClassLayout(typeName: string): ClassLayout | undefined {
    return this.classInfoResolver.getClassLayout(typeName);
  }

  getInternalClassLayout(typeName: string): ClassLayout | undefined {
    return this.classInfoResolver.getInternalClassLayout(typeName);
  }

  getClassLayoutByRtid(rtid: number): ClassLayout | undefined {
    return this.classInfoResolver.getClassDef(rtid);
  }

  resolveSourceLine(wasmBytecodeOffset: number): number | undefined {
    const position = this.sourceMap.originalPositionFor({
      line: 1,
      column: wasmBytecodeOffset,
    });
    return position.line ?? undefined;
  }

  resolveSourceLocation(wasmBytecodeOffset: number): DebuggerSourceLocation | undefined {
    const position = this.sourceMap.originalPositionFor({
      line: 1,
      column: wasmBytecodeOffset,
    });
    if (!position.source || position.line === null) {
      return undefined;
    }

    return {
      sourcePath: DebuggerWasmModule.resolveSourcePath(this.sourceMapFilePath, position.source),
      sourceLine: position.line,
    };
  }

  hasSource(sourcePath: string): boolean {
    return this.findSource(sourcePath) !== undefined;
  }

  private findSource(sourcePath: string): string | undefined {
    const directSource = this.sourcesByPath.get(sourcePath);
    if (directSource) {
      return directSource;
    }

    for (const source of this.sourceMap.sources) {
      if (sourcePath === source || sourcePath.endsWith(`/${source}`)) {
        return source;
      }
    }

    return undefined;
  }

  private static async loadSourceMap(sourceMapFilePath: string): Promise<ParsedSourceMap> {
    const rawSourceMap = JSON.parse(await readFile(sourceMapFilePath, "utf8")) as RawSourceMap;
    return new SourceMapConsumer(rawSourceMap);
  }

  private static resolveSourcePath(sourceMapFilePath: string, sourcePath: string): string {
    if (path.isAbsolute(sourcePath)) {
      return normalizeDebugPath(sourcePath);
    }

    const sourceMapDir = path.dirname(sourceMapFilePath);
    const sourceMapDirCandidate = path.resolve(sourceMapDir, sourcePath);
    if (existsSync(sourceMapDirCandidate)) {
      return normalizeDebugPath(sourceMapDirCandidate);
    }

    const sourceMapParentCandidate = path.resolve(sourceMapDir, "..", sourcePath);
    if (existsSync(sourceMapParentCandidate)) {
      return normalizeDebugPath(sourceMapParentCandidate);
    }

    return normalizeDebugPath(sourceMapDirCandidate);
  }

  private static toVariableScope(
    name: string,
    scope: DwarfScopeInfo,
    functionClosureEnvLocalIndex?: number,
    tupleLevel?: number
  ): DebuggerVariableScope {
    const closureEnvLocalIndex =
      scope.closureEnvLocalIndex ??
      DebuggerWasmModule.findClosureEnvLocalIndex(scope.variables) ??
      functionClosureEnvLocalIndex;
    return {
      name,
      variables: scope.variables.map((variable) => DebuggerWasmModule.toSourceVariableInfo(variable)),
      closureEnvLocalIndex,
      rootClosureEnvLocalIndex: closureEnvLocalIndex,
      tupleLevel: tupleLevel ?? (closureEnvLocalIndex === undefined ? undefined : 0),
    };
  }

  private static findClosureEnvLocalIndex(variables: DwarfLocalVariableInfo[]): number | undefined {
    for (const variable of variables) {
      if (variable.fieldOffset !== undefined) {
        return variable.localIndex;
      }
    }
    return undefined;
  }

  private static toClosureVariableScope(
    level: DwarfClosureVariableLevel,
    rootClosureEnvLocalIndex: number
  ): DebuggerVariableScope {
    return {
      name: level.kind === "scope" ? "Scope" : `Closure(${DebuggerWasmModule.getClosureFunctionName(level.name)})`,
      variables: level.variables.map((variable) => DebuggerWasmModule.toClosureSourceVariableInfo(variable)),
      closureEnvLocalIndex: level.closureEnvLocalIndex,
      rootClosureEnvLocalIndex,
      tupleLevel: level.level,
    };
  }

  private static getFunctionBaseName(name: string): string {
    const lastSlash = name.lastIndexOf("/");
    if (lastSlash === -1) {
      return name;
    }
    return name.slice(lastSlash + 1);
  }

  private static getClosureFunctionName(name: string): string {
    const functionName = DebuggerWasmModule.getFunctionBaseName(name);
    const lastSeparator = functionName.lastIndexOf("~");
    if (lastSeparator === -1) {
      return functionName;
    }
    return functionName.slice(lastSeparator + 1);
  }

  private static toSourceVariableInfo(variable: DwarfLocalVariableInfo): DebuggerSourceVariableInfo {
    if (variable.fieldOffset !== undefined) {
      return DebuggerWasmModule.toClosureSourceVariableInfo(variable);
    }

    return {
      kind: "wasm-local",
      name: variable.name,
      typeName: variable.typeName,
      localIndex: variable.localIndex,
    };
  }

  private static toClosureSourceVariableInfo(variable: DwarfLocalVariableInfo): DebuggerClosureVariableInfo {
    assert(variable.fieldOffset !== undefined);
    return {
      kind: "closure",
      name: variable.name,
      typeName: variable.typeName,
      closureEnvLocalIndex: variable.localIndex,
      fieldOffset: variable.fieldOffset,
    };
  }

  private static toGlobalSourceVariableInfo(variable: DwarfGlobalVariableInfo): DebuggerWasmGlobalVariableInfo {
    return {
      kind: "wasm-global",
      name: variable.name,
      typeName: variable.typeName,
      globalIndex: variable.globalIndex,
    };
  }
}

class WasmFunctionTableInfoParser {
  private readonly functionIndicesByTableIndex = new Map<number, number>();
  private readonly namesByFunctionIndex = new Map<number, string>();
  private readonly decoder = new TextDecoder();
  private activeTableIndex: number | undefined;
  private activeTableOffset: number | undefined;
  private activeElementIndex = 0;
  private elementFunctionIndex: number | undefined;

  parse(wasmBinary: Uint8Array): WasmFunctionTableInfo {
    const reader = new BinaryReader();
    reader.setData(wasmBinary.buffer as ArrayBuffer, wasmBinary.byteOffset, wasmBinary.byteLength);

    while (reader.read()) {
      this.handleReaderState(reader);
    }

    return {
      functionIndicesByTableIndex: this.functionIndicesByTableIndex,
      namesByFunctionIndex: this.namesByFunctionIndex,
    };
  }

  private handleReaderState(reader: BinaryReader): void {
    switch (reader.state) {
      case BinaryReaderState.BEGIN_ELEMENT_SECTION_ENTRY: {
        const segment = reader.result as IElementSegment;
        this.activeTableIndex = (segment.mode as number) === 0 ? (segment.tableIndex ?? 0) : undefined;
        this.activeTableOffset = undefined;
        this.activeElementIndex = 0;
        break;
      }
      case BinaryReaderState.OFFSET_EXPRESSION_OPERATOR: {
        const operator = reader.result as IOperatorInformation;
        if (operator.code === OperatorCode.i32_const && typeof operator.literal === "number") {
          this.activeTableOffset = Number(operator.literal);
        }
        break;
      }
      case BinaryReaderState.BEGIN_INIT_EXPRESSION_BODY: {
        this.elementFunctionIndex = undefined;
        break;
      }
      case BinaryReaderState.INIT_EXPRESSION_OPERATOR: {
        const operator = reader.result as IOperatorInformation;
        if (operator.code === OperatorCode.ref_func && typeof operator.funcIndex === "number") {
          this.elementFunctionIndex = operator.funcIndex;
        }
        break;
      }
      case BinaryReaderState.END_INIT_EXPRESSION_BODY: {
        this.recordElementInit();
        break;
      }
      case BinaryReaderState.END_ELEMENT_SECTION_ENTRY: {
        this.activeTableIndex = undefined;
        this.activeTableOffset = undefined;
        break;
      }
      case BinaryReaderState.NAME_SECTION_ENTRY: {
        this.recordFunctionName(reader.result as IFunctionNameEntry);
        break;
      }
      case BinaryReaderState.ERROR: {
        throw new Error("Failed to parse wasm function metadata");
      }
    }
  }

  private recordElementInit(): void {
    if (
      this.activeTableIndex !== undefined &&
      this.activeTableOffset !== undefined &&
      this.elementFunctionIndex !== undefined
    ) {
      this.functionIndicesByTableIndex.set(this.activeTableOffset + this.activeElementIndex, this.elementFunctionIndex);
    }
    this.activeElementIndex++;
  }

  private recordFunctionName(nameEntry: IFunctionNameEntry): void {
    if (nameEntry.type === NameType.Function) {
      for (const naming of nameEntry.names) {
        this.namesByFunctionIndex.set(naming.index, this.decoder.decode(naming.name));
      }
    }
  }
}

function parseWasmFunctionTableInfo(wasmBinary: Uint8Array): WasmFunctionTableInfo {
  return new WasmFunctionTableInfoParser().parse(wasmBinary);
}
