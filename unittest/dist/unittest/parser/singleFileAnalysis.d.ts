import { FileCoverageResult, FunctionCoverageResult } from "../interface.js";
export declare class SingleFileCoverageAnalysis {
    result: FileCoverageResult;
    constructor(fileName: string, source: string);
    setTotalFunction(count: number): void;
    merge(results: FunctionCoverageResult[]): void;
    getResult(): FileCoverageResult;
}
//# sourceMappingURL=singleFileAnalysis.d.ts.map