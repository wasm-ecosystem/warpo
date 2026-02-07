import { instantiate, Imports as ASImports } from "@assemblyscript/loader";
import { ExecutionResultSummary } from "../executionResult.js";
import { Imports, ImportsArgument } from "../interface.js";
import { ExecutionRecorder, ExecutionResult } from "./executionRecorder.js";
import { MockStatusRecorder } from "./mockStatusRecorder.js";
import { CoverageRecorder } from "./covRecorder.js";
import { ExecutionError, handleWebAssemblyError } from "../utils/errorTraceHandler.js";
import { WebAssemblyModule } from "../utils/wasm.js";
import { injectDefaultFunction } from "../utils/index.js";

async function nodeExecutor(
  wasmModule: WebAssemblyModule,
  filterByName: (fullTestName: string) => boolean,
  imports?: Imports
): Promise<ExecutionResult> {
  const executionRecorder = new ExecutionRecorder();
  const coverageRecorder = new CoverageRecorder();
  const mockStatusRecorder = new MockStatusRecorder();

  const importsArg = new ImportsArgument(executionRecorder);
  const userDefinedImportsObject = imports === undefined ? {} : imports!(importsArg);
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
      (ins.exports["__unit_test_start"] as () => void)();
    },
    exceptionHandler
  );

  const execTestFunction = (functionIndex: number) => {
    ins.exports.table!.get(functionIndex)();
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
