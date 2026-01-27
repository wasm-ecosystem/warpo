import { OutputMode, FileCoverageResult } from "../interface.js";
declare class GeneratorConfig {
    warningLimit: number;
    errorLimit: number;
}
export declare const reportConfig: GeneratorConfig;
export declare function generateReport(modes: OutputMode | OutputMode[], outputFolder: string, fileCoverageResult: FileCoverageResult[]): void;
export {};
//# sourceMappingURL=index.d.ts.map