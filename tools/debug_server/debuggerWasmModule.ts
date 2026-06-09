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

interface LineMappedPosition {
  source: string;
  line: number;
  column?: number;
}

interface LineLookupSourceMap {
  allGeneratedPositionsFor(originalPosition: LineMappedPosition): Array<{ line: number | null; column: number | null }>;
}

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

  findBytecodeOffset(sourcePath: string, line: number): number | undefined {
    const source = this.findSource(sourcePath);
    if (!source) {
      return undefined;
    }

    const generatedPositions = (this.sourceMap as LineLookupSourceMap).allGeneratedPositionsFor({ source, line });

    let firstOffset: number | undefined;
    for (const generatedPosition of generatedPositions) {
      if (generatedPosition.line === null || generatedPosition.column === null) {
        continue;
      }

      if (firstOffset === undefined || generatedPosition.column < firstOffset) {
        firstOffset = generatedPosition.column;
      }
    }

    return firstOffset;
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
    const rawSourceMap = JSON.parse(await readFile(sourceMapFilePath, "utf8")) as RawParsedSourceMap;
    return new SourceMapConsumer(rawSourceMap);
  }

  private static resolveSourcePath(sourceMapFilePath: string, sourcePath: string): string {
    return path.resolve(path.dirname(sourceMapFilePath), sourcePath).replaceAll("\\", "/");
  }
}
