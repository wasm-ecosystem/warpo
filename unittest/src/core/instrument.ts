import initInstrumenter from "../../../build_wasm/bin/wasm-instrumentation.js";
import { InstrumentResult } from "../interface.js";

export async function instrument(sourceWasms: string[], collectCoverage: boolean): Promise<InstrumentResult[]> {
  const res: InstrumentResult[] = [];
  const instrumenter = await initInstrumenter();
  for (const sourceFile of sourceWasms) {
    const baseName = sourceFile.slice(0, -5);
    const result = new InstrumentResult(baseName);

    const reportFunction = "__unittest_framework_env/traceExpression";

    const source = instrumenter.allocateUTF8(sourceFile);
    const output = instrumenter.allocateUTF8(result.instrumentedWasm);
    const report = instrumenter.allocateUTF8(reportFunction);
    const sourceMap = instrumenter.allocateUTF8(result.sourceMap);
    const debugInfo = instrumenter.allocateUTF8(result.debugInfo);
    const expectInfo = instrumenter.allocateUTF8(result.expectInfo);

    instrumenter._wasm_instrument(source, output, report, sourceMap, expectInfo, debugInfo, 0, true, collectCoverage);
    for (const ptr of [source, output, report, sourceMap, debugInfo, expectInfo]) {
      instrumenter._free(ptr);
    }
    res.push(result);
  }

  return res;
}
