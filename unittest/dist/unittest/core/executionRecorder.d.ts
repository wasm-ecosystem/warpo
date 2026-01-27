import { UnitTestFramework, ImportsArgument, AssertFailMessage, IExecutionResult, FailedLogMessages, CrashInfo } from "../interface.js";
import { ExecutionError } from "../utils/errorTraceHandler.js";
declare class LogRecorder {
    #private;
    addLog(msg: string): void;
    markTestFailed(): void;
    reset(): void;
    onFinishTest(): string[] | null;
}
export declare class ExecutionResult implements IExecutionResult {
    total: number;
    fail: number;
    failedInfo: AssertFailMessage;
    crashInfo: CrashInfo;
    failedLogMessages: FailedLogMessages;
}
declare class TestBlock {
    description: string;
    constructor(description: string);
    setupFunctions: number[];
    teardownFunctions: number[];
}
export declare class TestCase {
    functionIndex: number;
    fullName: string;
    setupFunctions: number[];
    teardownFunctions: number[];
    constructor(testBlockStack: TestBlock[], functionIndex: number);
}
export declare class ExecutionRecorder implements UnitTestFramework {
    #private;
    result: ExecutionResult;
    testBlockStack: TestBlock[];
    testCases: TestCase[];
    currentExecutedTestCaseFullName: string;
    logRecorder: LogRecorder;
    _addDescription(description: string): void;
    _removeDescription(): void;
    get lastTestBlock(): TestBlock | undefined;
    _registerSetup(functionIndex: number): boolean;
    _registerTeardown(functionIndex: number): boolean;
    _addTestCase(functionIndex: number): void;
    _startTestFunction(fullName: string): void;
    _finishTestFunction(): void;
    runTestFunction(fullName: string, runner: () => Promise<void> | void, exceptionHandler: (error: unknown) => Promise<void>): Promise<void>;
    notifyTestCrash(error: ExecutionError): void;
    collectCheckResult(result: boolean, codeInfoIndex: number, actualValue: string, expectValue: string): void;
    log(msg: string): void;
    getCollectionFuncSet(arg: ImportsArgument): Record<string, unknown>;
}
export {};
//# sourceMappingURL=executionRecorder.d.ts.map