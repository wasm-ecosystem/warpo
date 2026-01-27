/**
 * This file define the interface of coverage information
 */
import { Type } from "wasmparser";
import { ASUtil } from "@assemblyscript/loader";
export declare class InstrumentResult {
    baseName: string;
    constructor(baseName: string);
    get sourceWasm(): string;
    get instrumentedWasm(): string;
    get sourceMap(): string;
    get debugInfo(): string;
    get expectInfo(): string;
    get traceFile(): string;
}
export type CodeSnippetIndex = number;
export type FunctionIndex = number;
export type LineIndex = number;
export type ColumnIndex = number;
export type FileIndex = number;
export type UncoveredBasicBlocks = Set<CodeSnippetIndex>;
export type UncoveredLines = Set<LineIndex>;
export type BranchInfo = [CodeSnippetIndex, CodeSnippetIndex];
export type BranchInfos = BranchInfo[];
export type LineRange = [FileIndex, LineIndex, ColumnIndex][];
export type LineInfos = (LineRange | null)[];
export type LineInfoMap = Map<number, Set<LineIndex>>;
export interface CovDebugInfo {
    branchInfo: BranchInfos;
    index: FunctionIndex;
    lineInfo: LineInfos;
}
export interface CovInfo {
    branchInfo: BranchInfos;
    lineInfo: LineInfoMap;
}
export interface DebugInfo {
    debugInfos: Record<string, CovDebugInfo>;
    debugFiles: string[];
}
export type CovTrace = [FunctionIndex, CodeSnippetIndex];
export type TestCaseName = string;
export type ExpectInfoIndex = string;
export type AssertExpectValue = string;
export type AssertActualValue = string;
export type AssertMessage = [ExpectInfoIndex, AssertActualValue, AssertExpectValue];
export type AssertFailMessage = Record<TestCaseName, AssertMessage[]>;
export type CrashInfo = Set<TestCaseName>;
export type FailedLogMessages = Record<TestCaseName, string[]>;
export type FailedInfo = {
    hasCrash: boolean;
    assertMessages: string[];
    logMessages: string[];
};
export type FailedInfoMap = Map<TestCaseName, FailedInfo>;
export type ExpectInfoDebugLocation = string;
export type ExpectInfo = Record<ExpectInfoIndex, ExpectInfoDebugLocation>;
export interface IExecutionResult {
    fail: number;
    total: number;
    crashInfo: CrashInfo;
    failedInfo: AssertFailMessage;
    failedLogMessages: FailedLogMessages;
}
export interface ImportFunctionInfo {
    module: string;
    name: string;
    args: Type[];
    return: Type | undefined;
}
export declare class Rate {
    used: number;
    total: number;
    getRate(): number;
    toString(): string;
    static summarize(rates: Rate[]): Rate;
}
export declare class FileCoverageResult {
    filename: string;
    constructor(filename: string);
    statementCoverageRate: Rate;
    branchCoverageRate: Rate;
    functionCoverageRate: Rate;
    lineCoverageRate: Rate;
    sourceUsedCount: CodeCoverage[];
    uncoveredlines: Set<number>;
}
export declare class FunctionCoverageResult {
    functionName: string;
    constructor(functionName: string);
    branchCoverageRate: Rate;
    uncoveredlines: UncoveredLines;
    lineRange: [number, number];
    /**
     * first means lineIndex;
     * second means usedCount;
     */
    sourceUsedCount: Map<number, number>;
    /**
     * Now assemblyscrpt will compile foo<T>() to different function like foo<f64>() , foo<u32>() etc;
     * We need merge the generic function to foo() for coverage statistics
     */
    static mergeFromGeneric(nameWithoutGeneric: string, infos: FunctionCoverageResult[]): FunctionCoverageResult;
}
export declare class CodeCoverage {
    static readonly default = -1;
    source: string;
    /**
     * Default means not a effect line;
     * 0 means not used but effect;
     * more than 0 means a used line;
     */
    usedCount: number;
    constructor(src: string);
}
export interface TestNameInfo {
    testName: string;
    testFilePath: string;
}
export declare class ImportsArgument {
    framework: UnitTestFramework;
    module: WebAssembly.Module | null;
    instance: WebAssembly.Instance | null;
    exports: (ASUtil & Record<string, unknown>) | null;
    constructor(framework: UnitTestFramework);
}
export type Imports = ((arg: ImportsArgument) => Record<string, unknown>) | null;
export interface TestOption {
    includes: string[];
    excludes: string[];
    entryFiles: string[] | null;
    testFiles: string[] | null;
    testNamePattern: string | null;
    collectCoverage: boolean;
    onlyFailures: boolean;
    flags: string;
    imports?: Imports;
    tempFolder: string;
    outputFolder: string;
    mode: OutputMode | OutputMode[];
    warnLimit?: number;
    errorLimit?: number;
    isolated: boolean;
    warpo: boolean;
}
export type OutputMode = "html" | "json" | "table";
export declare abstract class UnitTestFramework {
    /**
     * function to redirect log message to unittest framework
     * @param msg: message to log
     */
    abstract log(msg: string): void;
}
export declare const OrganizationName = "wasm-ecosystem";
export declare const Repository = "https://github.com/wasm-ecosystem/assemblyscript-unittest-framework";
//# sourceMappingURL=interface.d.ts.map