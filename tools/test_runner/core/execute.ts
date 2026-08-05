import { instantiate, Imports as ASImports } from "@assemblyscript/loader";
import { ExecutionResultSummary } from "../executionResult.js";
import { Imports, ImportsArgument } from "../interface.js";
import { ExecutionRecorder, ExecutionResult } from "./executionRecorder.js";
import { MockStatusRecorder } from "./mockStatusRecorder.js";
import { CoverageRecorder } from "./covRecorder.js";
import { ExecutionError, handleWebAssemblyError } from "../utils/errorTraceHandler.js";
import { WebAssemblyModule } from "../utils/wasm.js";
import { injectDefaultFunction } from "../utils/index.js";
import * as inspector from "node:inspector";

async function nodeExecutor(
  wasmModule: WebAssemblyModule,
  filterByName: (fullTestName: string) => boolean,
  imports?: Imports
): Promise<ExecutionResult> {
  const executionRecorder = new ExecutionRecorder();
  const coverageRecorder = new CoverageRecorder();
  const mockStatusRecorder = new MockStatusRecorder();

  const importsArg = new ImportsArgument(executionRecorder);
  const userDefinedImportsObject = imports === undefined || imports === null ? {} : imports(importsArg);
  const importObject: ASImports = {
    __unittest_framework_env: {
      ...executionRecorder.getCollectionFuncSet(importsArg),
      ...mockStatusRecorder.getMockFuncSet(),
      ...coverageRecorder.getCollectionFuncSet(),
    },
    ...userDefinedImportsObject,
  } as ASImports;
  const wasmImports = await wasmModule.getImports();
  injectDefaultFunction(wasmImports, importObject, importsArg);
  const ins = await instantiate(await wasmModule.getModule(), importObject);
  importsArg.module = ins.module;
  importsArg.instance = ins.instance;
  importsArg.exports = ins.exports;

  if (inspector.url() !== undefined) {
    inspector.waitForDebugger();
  }

  let isCrashed = false; // we don't want to crash any code after crash. AS' heap may be broken.

  const exceptionHandler = async (error: unknown) => {
    if (error instanceof WebAssembly.RuntimeError) {
      isCrashed = true;
      const errorMessage: ExecutionError = await handleWebAssemblyError(error, wasmModule);
      executionRecorder.notifyTestCrash(errorMessage);
      return;
    }
    // unrecoverable error, rethrow
    if (error instanceof Error) {
      console.error(error.stack);
    }
    throw new Error("node executor abort");
  };

  await executionRecorder.runTestFunction(
    `${wasmModule.baseName} - init`,
    () => {
      const exports = ins.exports as typeof ins.exports & { __unit_test_start?: () => void };
      const unitTestStart = exports.__unit_test_start;
      if (typeof unitTestStart !== "function") {
        throw new TypeError("missing __unit_test_start export");
      }
      unitTestStart();
    },
    exceptionHandler
  );

  const execTestFunction = (functionIndex: number) => {
    const table = ins.exports.table;
    if (!(table instanceof WebAssembly.Table)) {
      throw new TypeError("missing wasm function table");
    }

    const fn = table.get(functionIndex) as (() => void) | undefined;
    if (typeof fn !== "function") {
      throw new TypeError(`missing wasm table function at index ${functionIndex}`);
    }
    fn();
  };

  for (const testCase of executionRecorder.testCases) {
    if (isCrashed) {
      break;
    }
    const { fullName, functionIndex, setupFunctions, teardownFunctions } = testCase;
    if (filterByName(fullName)) {
      await executionRecorder.runTestFunction(
        fullName,
        () => {
          for (const setupFuncIndex of setupFunctions) {
            execTestFunction(setupFuncIndex);
          }
          execTestFunction(functionIndex);
          for (const teardownFuncIndex of teardownFunctions) {
            execTestFunction(teardownFuncIndex);
          }
        },
        exceptionHandler
      );
      mockStatusRecorder.clear();
    }
  }

  coverageRecorder.outputTrace(wasmModule.traceFile);
  return executionRecorder.result;
}

export async function execWasmBinaries(
  wasmModule: WebAssemblyModule,
  filterByName: (fullTestName: string) => boolean,
  imports?: Imports
): Promise<ExecutionResultSummary> {
  const assertRes = new ExecutionResultSummary();
  const result: ExecutionResult = await nodeExecutor(wasmModule, filterByName, imports);
  await assertRes.merge(result, wasmModule);
  return assertRes;
}
