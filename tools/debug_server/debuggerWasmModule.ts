// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { readFile } from "node:fs/promises";
import * as path from "node:path";
import {
  SourceMapConsumer,
  type BasicSourceMapConsumer,
  type IndexedSourceMapConsumer,
  type RawIndexMap,
  type RawSourceMap,
} from "source-map";

export type ParsedSourceMap = BasicSourceMapConsumer | IndexedSourceMapConsumer;

export interface DebuggerBreakpointInfo {
  id: number;
  line: number;
  verified: boolean;
  source: string;
}

type RawParsedSourceMap = RawSourceMap | RawIndexMap;

export class DebuggerWasmModule {
  private readonly sourcesByPath: ReadonlyMap<string, string>;

  private constructor(
    readonly scriptId: string,
    readonly url: string,
    readonly wasmFilePath: string,
    readonly sourceMapFilePath: string,
    readonly bytecode: Uint8Array,
    readonly sourceMap: ParsedSourceMap,
    sourcesByPath: ReadonlyMap<string, string>
  ) {
    this.sourcesByPath = sourcesByPath;
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
    const sourcesByPath = new Map(
      sourceMap.sources.map((source) => [DebuggerWasmModule.resolveSourcePath(sourceMapFilePath, source), source])
    );

    return new DebuggerWasmModule(
      runtimeInfo?.scriptId ?? "",
      runtimeInfo?.url ?? "",
      wasmFilePath,
      sourceMapFilePath,
      bytecode,
      sourceMap,
      sourcesByPath
    );
  }

  dispose(): void {
    this.sourceMap.destroy();
  }

  findBytecodeOffset(sourcePath: string, line: number, column = 0): number | undefined {
    const source = this.sourcesByPath.get(sourcePath);
    if (!source) {
      return undefined;
    }

    const generatedPosition = this.sourceMap.generatedPositionFor({
      source,
      line,
      column,
      bias: SourceMapConsumer.LEAST_UPPER_BOUND,
    });
    if (generatedPosition.line === null || generatedPosition.column === null) {
      return undefined;
    }

    return generatedPosition.column;
  }

  hasSource(sourcePath: string): boolean {
    return this.sourcesByPath.has(sourcePath);
  }

  private static async loadSourceMap(sourceMapFilePath: string): Promise<ParsedSourceMap> {
    const rawSourceMap = JSON.parse(await readFile(sourceMapFilePath, "utf8")) as RawParsedSourceMap;
    return new SourceMapConsumer(rawSourceMap);
  }

  private static resolveSourcePath(sourceMapFilePath: string, sourcePath: string): string {
    return path.resolve(path.dirname(sourceMapFilePath), sourcePath).replaceAll("\\", "/");
  }
}
