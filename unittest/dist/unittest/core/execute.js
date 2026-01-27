import { WASI } from "node:wasi";
import { promises } from "node:fs";
import { ensureDirSync } from "fs-extra";
import { instantiate } from "@assemblyscript/loader";
import { ExecutionResultSummary } from "../executionResult.js";
import { ImportsArgument } from "../interface.js";
import { supplyDefaultFunction } from "../utils/index.js";
import { parseImportFunctionInfo } from "../utils/wasmparser.js";
import { ExecutionRecorder } from "./executionRecorder.js";
import { MockStatusRecorder } from "./mockStatusRecorder.js";
import { CoverageRecorder } from "./covRecorder.js";
import assert from "node:assert";
import { handleWebAssemblyError } from "../utils/errorTraceHandler.js";
const readFile = promises.readFile;
async function nodeExecutor(instrumentResult, outFolder, filterByName, imports) {
    const wasi = new WASI({
        args: ["node", instrumentResult.baseName],
        env: process.env,
        preopens: {
            "/": outFolder,
        },
        version: "preview1",
    });
    const executionRecorder = new ExecutionRecorder();
    const coverageRecorder = new CoverageRecorder();
    const mockStatusRecorder = new MockStatusRecorder();
    const importsArg = new ImportsArgument(executionRecorder);
    const userDefinedImportsObject = imports === undefined ? {} : imports(importsArg);
    const importObject = {
        wasi_snapshot_preview1: wasi.wasiImport,
        __unittest_framework_env: {
            ...executionRecorder.getCollectionFuncSet(importsArg),
            ...mockStatusRecorder.getMockFuncSet(),
            ...coverageRecorder.getCollectionFuncSet(),
        },
        ...userDefinedImportsObject,
    };
    const binaryBuffer = await readFile(instrumentResult.instrumentedWasm);
    const binary = binaryBuffer.buffer.slice(binaryBuffer.byteOffset, binaryBuffer.byteOffset + binaryBuffer.byteLength);
    const importFuncList = parseImportFunctionInfo(binary);
    supplyDefaultFunction(importFuncList, importObject, importsArg);
    const ins = await instantiate(binary, importObject);
    importsArg.module = ins.module;
    importsArg.instance = ins.instance;
    importsArg.exports = ins.exports;
    let isCrashed = false; // we don't want to crash any code after crash. AS' heap may be broken.
    const exceptionHandler = async (error) => {
        if (error instanceof WebAssembly.RuntimeError) {
            isCrashed = true;
            const errorMessage = await handleWebAssemblyError(error, instrumentResult.instrumentedWasm);
            executionRecorder.notifyTestCrash(errorMessage);
            return;
        }
        // unrecoverable error, rethrow
        if (error instanceof Error) {
            console.error(error.stack);
        }
        throw new Error("node executor abort");
    };
    await executionRecorder.runTestFunction(`${instrumentResult.baseName} - init`, () => {
        ins.exports["__unit_test_start"]();
    }, exceptionHandler);
    const execTestFunction = ins.exports["executeTestFunction"];
    assert(typeof execTestFunction === "function");
    for (const testCase of executionRecorder.testCases) {
        if (isCrashed) {
            break;
        }
        const { fullName, functionIndex, setupFunctions, teardownFunctions } = testCase;
        if (filterByName(fullName)) {
            await executionRecorder.runTestFunction(fullName, () => {
                for (const setupFuncIndex of setupFunctions) {
                    execTestFunction(setupFuncIndex);
                }
                execTestFunction(functionIndex);
                for (const teardownFuncIndex of teardownFunctions) {
                    execTestFunction(teardownFuncIndex);
                }
            }, exceptionHandler);
            mockStatusRecorder.clear();
        }
    }
    coverageRecorder.outputTrace(instrumentResult.traceFile);
    return executionRecorder.result;
}
export async function execWasmBinaries(outFolder, instrumentResults, filterByName, imports) {
    const assertRes = new ExecutionResultSummary();
    ensureDirSync(outFolder);
    await Promise.all(instrumentResults.map(async (instrumentResult) => {
        const result = await nodeExecutor(instrumentResult, outFolder, filterByName, imports);
        await assertRes.merge(result, instrumentResult.expectInfo);
    }));
    return assertRes;
}
//# sourceMappingURL=execute.js.map