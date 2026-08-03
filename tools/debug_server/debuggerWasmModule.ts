// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { existsSync } from "node:fs";
import { readFile } from "node:fs/promises";
import * as path from "node:path";
import { DwarfClassInfoResolver, type ClassLayout } from "../dwarf/classDebugInfo.js";
import {
  DwarfFunctionInfoResolver,
  getScopeChainInFunctionAtBytecodeOffset,
  getVariablesInFunctionAtBytecodeOffset,
  type DwarfLocalVariableInfo,
  type DwarfScopeInfo,
} from "../dwarf/functionDebugInfo.js";
import { SourceMapConsumer, type BasicSourceMapConsumer, type RawSourceMap } from "source-map";
import { normalizeDebugPath } from "./debugPath.js";

export type ParsedSourceMap = BasicSourceMapConsumer;

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

export type DebuggerSourceVariableInfo = DebuggerWasmLocalVariableInfo | DebuggerClosureVariableInfo;

export interface DebuggerVariableScope {
  name: string;
  variables: DebuggerSourceVariableInfo[];
}

export interface DebuggerBreakpointLocation {
  wasmBytecodeOffset: number;
  sourceLine: number;
}

export interface DebuggerSourceLocation {
  sourcePath: string;
  sourceLine: number;
}

export class DebuggerWasmModule {
  private readonly sourcesByPath: ReadonlyMap<string, string>;

  private constructor(
    readonly scriptId: string,
    readonly url: string,
    readonly wasmFilePath: string,
    readonly sourceMapFilePath: string,
    readonly bytecode: Uint8Array,
    private readonly sourceMap: ParsedSourceMap,
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
      DwarfFunctionInfoResolver.fromWasm(bytecode),
      DwarfClassInfoResolver.fromWasm(bytecode)
    );
  }

  dispose(): void {
    this.sourceMap.destroy();
  }

  resolveBreakpointLocation(breakpoint: DebuggerBreakpointInfo): DebuggerBreakpointLocation | undefined {
    const { source: sourcePath, line } = breakpoint;
    const source = this.findSource(sourcePath);
    if (!source) {
      return undefined;
    }

    const generatedPositions = this.sourceMap.allGeneratedPositionsFor({ source, line, column: 0 });

    let firstColumn: number | undefined;
    for (const generatedPosition of generatedPositions) {
      if (generatedPosition.line === null || generatedPosition.column === null) {
        continue;
      }

      if (firstColumn === undefined || generatedPosition.column < firstColumn) {
        firstColumn = generatedPosition.column;
      }
    }

    if (firstColumn === undefined) {
      return undefined;
    }

    return {
      wasmBytecodeOffset: firstColumn,
      sourceLine: line,
    };
  }

  findBytecodeOffset(sourcePath: string, line: number): number | undefined {
    return this.resolveBreakpointLocation({
      id: 0,
      line,
      verified: true,
      source: sourcePath,
    })?.wasmBytecodeOffset;
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

    const scopeChain = getScopeChainInFunctionAtBytecodeOffset(functionInfo, wasmBytecodeOffset);
    const scopes: DebuggerVariableScope[] = [];
    const functionName = DebuggerWasmModule.getFunctionBaseName(functionInfo);

    for (const scope of scopeChain.toReversed()) {
      if (scope.variables.length > 0) {
        scopes.push(DebuggerWasmModule.toVariableScope(`Block: ${functionName}`, scope));
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
      scopes.push({
        name: `Local: ${functionName}`,
        variables: functionVariables.map((variable) => DebuggerWasmModule.toSourceVariableInfo(variable)),
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

  private static toVariableScope(name: string, scope: DwarfScopeInfo): DebuggerVariableScope {
    return {
      name,
      variables: scope.variables.map((variable) => DebuggerWasmModule.toSourceVariableInfo(variable)),
    };
  }

  private static getFunctionBaseName(functionInfo: { name: string }): string {
    const lastSlash = functionInfo.name.lastIndexOf("/");
    return lastSlash >= 0 ? functionInfo.name.slice(lastSlash + 1) : functionInfo.name;
  }

  private static toSourceVariableInfo(variable: DwarfLocalVariableInfo): DebuggerSourceVariableInfo {
    if (variable.fieldOffset !== undefined) {
      return {
        kind: "closure",
        name: variable.name,
        typeName: variable.typeName,
        closureEnvLocalIndex: variable.localIndex,
        fieldOffset: variable.fieldOffset,
      };
    }

    return {
      kind: "wasm-local",
      name: variable.name,
      typeName: variable.typeName,
      localIndex: variable.localIndex,
    };
  }
}
