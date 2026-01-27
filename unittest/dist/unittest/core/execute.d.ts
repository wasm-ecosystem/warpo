import { ExecutionResultSummary } from "../executionResult.js";
import { Imports, InstrumentResult } from "../interface.js";
export declare function execWasmBinaries(outFolder: string, instrumentResults: InstrumentResult[], filterByName: (fullTestName: string) => boolean, imports?: Imports): Promise<ExecutionResultSummary>;
//# sourceMappingURL=execute.d.ts.map