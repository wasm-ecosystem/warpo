/**
 * Will transform all source file to get all relative functions
 */
import { TestOption } from "../interface.js";
type AnalyzeOption = Pick<TestOption, "includes" | "excludes" | "testFiles" | "testNamePattern" | "entryFiles">;
interface UnittestPackage {
    readonly testCodePaths: string[];
    readonly sourceCodePaths: string[];
    readonly entryFiles: string[];
    readonly filterByName: (fullTestName: string) => boolean;
}
export declare function analyze({ includes, excludes, testNamePattern, testFiles, entryFiles }: AnalyzeOption, failedTestNames: string[]): UnittestPackage;
export {};
//# sourceMappingURL=analyze.d.ts.map