import { CodeSnippetIndex, CovInfo, FunctionCoverageResult, UncoveredBasicBlocks } from "../interface.js";
type BranchGraph = Map<number, Map<number, boolean>>;
export declare class SingleFunctionCoverageAnalysis {
    covInfo: CovInfo;
    result: FunctionCoverageResult;
    branchGraph: BranchGraph;
    notFullyCoveredBasicBlock: UncoveredBasicBlocks;
    constructor(covInfo: CovInfo, name: string);
    update(indexSerialInSingleFunction: CodeSnippetIndex[]): FunctionCoverageResult;
    updateLine(indexSerialInSingleFunction: CodeSnippetIndex[]): void;
    updateBranch(indexSerialInSingleFunction: CodeSnippetIndex[]): void;
    private markCoveredBranches;
    private calculateBranchCoverage;
    private addUncoveredLines;
}
export {};
//# sourceMappingURL=singleFunctionAnalysis.d.ts.map