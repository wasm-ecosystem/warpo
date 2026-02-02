// ref: https://v8.dev/docs/stack-trace-api

import { readFile } from "node:fs/promises";
import { parseSourceMapPath } from "./wasmparser.js";
import { BasicSourceMapConsumer, IndexedSourceMapConsumer, SourceMapConsumer } from "source-map";
import chalk from "chalk";

export interface WebAssemblyCallSite {
  functionName: string;
  fileName: string;
  lineNumber: number;
  columnNumber: number;
}

interface WebAssemblyModuleInfo {
  wasmPath: string;
  sourceMapConsumer: SourceMapHandler | null;
}

type SourceMapHandler = BasicSourceMapConsumer | IndexedSourceMapConsumer;

interface SourceLocation {
  fileName: string;
  lineNumber: number;
  columnNumber: number;
}

function getOriginLocationWithSourceMap(
  line: number | null,
  column: number | null,
  sourceMapConsumer: SourceMapHandler | null
): SourceLocation | null {
  if (sourceMapConsumer === null || line === null || column === null) {
    return null;
  }
  const originPosition = sourceMapConsumer.originalPositionFor({
    line: line,
    column: column,
  });
  if (originPosition.source === null || originPosition.line === null || originPosition.column === null) {
    return null;
  }
  return {
    fileName: originPosition.source,
    lineNumber: originPosition.line,
    columnNumber: originPosition.column,
  };
}

function getWebAssemblyFunctionName(callSite: NodeJS.CallSite): string {
  return callSite.getFunctionName() ?? `wasm-function[${callSite.getFunction()?.toString() ?? "unknown"}]`;
}

function createWebAssemblyCallSite(
  callSite: NodeJS.CallSite,
  moduleInfo: WebAssemblyModuleInfo
): WebAssemblyCallSite | null {
  if (!callSite.getFileName()?.startsWith("wasm")) {
    // ignore non-wasm call sites
    return null;
  }
  const line: number | null = callSite.getLineNumber();
  const column: number | null = callSite.getColumnNumber();
  const originalPosition: SourceLocation | null = getOriginLocationWithSourceMap(
    line,
    column,
    moduleInfo.sourceMapConsumer
  );
  if (originalPosition) {
    return {
      fileName: originalPosition.fileName,
      functionName: getWebAssemblyFunctionName(callSite),
      lineNumber: originalPosition.lineNumber,
      columnNumber: originalPosition.columnNumber,
    };
  }
  // fallback to the original call site
  return {
    fileName: moduleInfo.wasmPath,
    functionName: getWebAssemblyFunctionName(callSite),
    lineNumber: line || -1,
    columnNumber: column || -1,
  };
}

export interface ExecutionError {
  message: string;
  stacks: WebAssemblyCallSite[];
}

async function getSourceMapConsumer(sourceMapPath: string | null): Promise<SourceMapHandler | null> {
  if (sourceMapPath === null) {
    return null;
  }
  const sourceMapContent: string | null = await (async () => {
    try {
      return await readFile(sourceMapPath, "utf8");
    } catch (error) {
      if (error instanceof Error) {
        console.log(chalk.yellow(`Failed to read source map file: ${sourceMapPath} due to ${error}`));
      }
      return null;
    }
  })();
  if (sourceMapContent === null) {
    return null;
  }
  return await new SourceMapConsumer(sourceMapContent, undefined);
}

export async function handleWebAssemblyError(
  error: WebAssembly.RuntimeError,
  wasmPath: string
): Promise<ExecutionError> {
  let stackTrace: NodeJS.CallSite[] = [];
  // eslint-disable-next-line @typescript-eslint/unbound-method
  const originalPrepareStackTrace = Error.prepareStackTrace;
  Error.prepareStackTrace = (_: Error, structuredStackTrace: NodeJS.CallSite[]) => {
    stackTrace = structuredStackTrace;
  };
  // eslint-disable-next-line @typescript-eslint/no-unused-expressions
  error.stack; // trigger prepareStackTrace
  Error.prepareStackTrace = originalPrepareStackTrace;

  const wasmBuffer = await readFile(wasmPath);
  const sourceMapPath = parseSourceMapPath(
    wasmBuffer.buffer.slice(wasmBuffer.byteOffset, wasmBuffer.byteLength) as ArrayBuffer
  );
  const sourceMapConsumer: SourceMapHandler | null = await getSourceMapConsumer(sourceMapPath);
  const stacks = stackTrace
    .map((callSite) => createWebAssemblyCallSite(callSite, { wasmPath, sourceMapConsumer }))
    .filter((callSite) => callSite !== null);
  sourceMapConsumer?.destroy(); // clean up the source map consumer
  return {
    message: error.message,
    stacks,
  };
}
