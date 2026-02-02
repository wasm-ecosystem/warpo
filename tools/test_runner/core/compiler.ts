import * as warpo from "../../scripts/lib.js";
import { InstrumentResult } from "../interface.js";

export class CompilationError extends Error {
  constructor(errorMessage: string | undefined) {
    super(errorMessage);
    this.name = "CompilationError";
  }
}

async function buildWithWARPO({
  sources,
  output,
  userDefinedFlags,
  collectCoverage,
}: CompilationOption): Promise<void> {
  let warpoArgv = [
    ...sources,
    "-o",
    output.wasm,
    // avoid name conflict with user-defined start functions
    "--exportStart",
    "__unit_test_start",
    "--debug",
    // instrumentation flags
    "--instrument",
    "--instrument-report-function",
    "__unittest_framework_env/traceExpression",
    "--instrument-debug-info-output",
    output.debugInfo,
    "--instrument-expect-info-output",
    output.expectInfo,
  ];
  if (!collectCoverage) {
    warpoArgv.push("--instrument-no-coverage");
  }
  if (userDefinedFlags.length > 0) {
    // command line options compatible with ASC
    // --disable => --disable-feature
    // --runtime incremental => remove (only support incremental runtime in warpo)
    // --memoryBase 16 => remove (not supported yet)
    const argv = userDefinedFlags
      .replace("--disable", "--disable-feature")
      .replace("--runtime incremental", "")
      .replace("--memoryBase 16", "")
      .split(" ");
    warpoArgv = warpoArgv.concat(argv);
  }
  const returnCode = await warpo.main({
    argv: warpoArgv,
    env: process.env,
  });
  if (returnCode !== 0) {
    throw new CompilationError(undefined);
  }
}

export interface CompilationOption {
  sources: string[];
  output: InstrumentResult;
  userDefinedFlags: string;
  collectCoverage: boolean;
}

export async function compileImpl(option: CompilationOption): Promise<void> {
  await buildWithWARPO(option);
}
