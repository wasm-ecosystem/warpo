/**
 * This file define the interface of coverage information
 */
// input

import { Type } from "wasmparser";
import { ASUtil } from "@assemblyscript/loader";
import { relative } from "node:path";

// instrumented file information
export class InstrumentResult {
  baseName: string;
  constructor(baseName: string) {
    this.baseName = relative(process.cwd(), baseName).replaceAll(/\\/g, "/");
  }
  get sourceWasm() {
    return this.baseName.concat(".wasm");
  }
  get instrumentedWasm(): string {
    return this.baseName.concat(".instrumented.wasm");
  }
  get sourceMap(): string {
    return this.baseName.concat(".wasm.map");
  }
  get debugInfo(): string {
    return this.baseName.concat(".debugInfo.json");
  }
  get expectInfo(): string {
    return this.baseName.concat(".expectInfo.json");
  }
  get traceFile(): string {
    return this.baseName.concat(".trace");
  }
}

export type CodeSnippetIndex = number;
export type FunctionIndex = number;
export type LineIndex = number;
export type ColumnIndex = number;
export type FileIndex = number;
export type UncoveredBasicBlocks = Set<CodeSnippetIndex>;
export type UncoveredLines = Set<LineIndex>;

// input cov
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

export type FailedInfo = { hasCrash: boolean; assertMessages: string[]; logMessages: string[] };
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

// output
export class Rate {
  used = 0;
  total = 0;
  getRate(): number {
    return this.total === 0 ? 100 : Math.round((this.used / this.total) * 10000) / 100;
  }
  toString(): string {
    return `${this.used}/${this.total}`;
  }
  static summarize(rates: Rate[]): Rate {
    return rates.reduce((prev, curr) => {
      prev.used += curr.used;
      prev.total += curr.total;
      return prev;
    }, new Rate());
  }
}
export class FileCoverageResult {
  constructor(public filename: string) {}
  statementCoverageRate: Rate = new Rate();
  branchCoverageRate: Rate = new Rate();
  functionCoverageRate: Rate = new Rate();
  lineCoverageRate: Rate = new Rate();
  sourceUsedCount: CodeCoverage[] = [];
  uncoveredlines: Set<number> = new Set();
}

export class FunctionCoverageResult {
  constructor(public functionName: string) {}
  branchCoverageRate: Rate = new Rate();
  uncoveredlines: UncoveredLines = new Set();
  lineRange: [number, number] = [Number.MAX_SAFE_INTEGER, Number.MIN_SAFE_INTEGER];
  /**
   * first means lineIndex;
   * second means usedCount;
   */
  sourceUsedCount = new Map<number, number>();

  /**
   * Now assemblyscrpt will compile foo<T>() to different function like foo<f64>() , foo<u32>() etc;
   * We need merge the generic function to foo() for coverage statistics
   */
  static mergeFromGeneric(nameWithoutGeneric: string, infos: FunctionCoverageResult[]): FunctionCoverageResult {
    const result = new FunctionCoverageResult(nameWithoutGeneric);
    result.lineRange = [
      Math.min(...infos.map((info) => info.lineRange[0])),
      Math.max(...infos.map((info) => info.lineRange[1])),
    ];
    result.branchCoverageRate = Rate.summarize(infos.map((info) => info.branchCoverageRate));
    for (const info of infos) {
      for (const line of info.uncoveredlines) result.uncoveredlines.add(line);
      for (const [lineIndex, count] of info.sourceUsedCount.entries()) {
        const srcLineUsedCount = result.sourceUsedCount.get(lineIndex);
        result.sourceUsedCount.set(lineIndex, srcLineUsedCount === undefined ? count : srcLineUsedCount + count);
      }
    }
    return result;
  }
}

export class CodeCoverage {
  static readonly default = -1;
  source: string;
  /**
   * Default means not a effect line;
   * 0 means not used but effect;
   * more than 0 means a used line;
   */
  usedCount: number = CodeCoverage.default;
  constructor(src: string) {
    this.source = src;
  }
}

export interface TestNameInfo {
  testName: string;
  testFilePath: string;
}

export class ImportsArgument {
  module: WebAssembly.Module | null = null;
  instance: WebAssembly.Instance | null = null;
  exports: (ASUtil & Record<string, unknown>) | null = null;
  constructor(public framework: UnitTestFramework) {}
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

export abstract class UnitTestFramework {
  /**
   * function to redirect log message to unittest framework
   * @param msg: message to log
   */
  abstract log(msg: string): void;
}

export const OrganizationName = "wasm-ecosystem";
export const Repository = "https://github.com/wasm-ecosystem/assemblyscript-unittest-framework";
