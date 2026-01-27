import { FailedInfoMap, IExecutionResult } from "./interface.js";
export declare class ExecutionResultSummary {
    #private;
    fail: number;
    total: number;
    failedInfos: FailedInfoMap;
    merge(result: IExecutionResult, expectInfoFilePath: string): Promise<void>;
    writeFailures(failuresPath: string): Promise<void>;
    print(log: (msg: string) => void): void;
}
//# sourceMappingURL=executionResult.d.ts.map