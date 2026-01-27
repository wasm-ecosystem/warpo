import { createMemoryStream, main } from "assemblyscript/asc";

export class CompilationError extends Error {
  constructor(errorMessage: string | undefined) {
    super(errorMessage);
    this.name = "CompilationError";
  }
}

export const asc = {
  compile: main,
};

async function buildWithASC({ sources, outputWASM, userDefinedFlags }: CompilationOption): Promise<void> {
  const stderr = createMemoryStream();
  let ascArgv = [
    ...sources,
    "--outFile",
    outputWASM,
    "--textFile",
    outputWASM.slice(0, -5) + ".wat",
    "--exportStart",
    // avoid name conflict with user-defined start functions
    "__unit_test_start",
    "--sourceMap",
    "--debug",
    "-O0",
    "--noColors",
  ];
  if (userDefinedFlags.length > 0) {
    const argv = userDefinedFlags.split(" ");
    ascArgv = ascArgv.concat(argv);
  }
  const { error } = await asc.compile(ascArgv, { stderr });
  if (error) {
    throw new CompilationError(stderr.toString());
  }
}

async function buildWithWARPO({ sources, outputWASM, userDefinedFlags }: CompilationOption): Promise<void> {
  let warpoArgv = [
    ...sources,
    "-o",
    outputWASM,
    "--exportStart",
    // avoid name conflict with user-defined start functions
    "__unit_test_start",
    "--debug",
  ];
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
  const warpo = await import("../../../dist/lib.js");
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
  outputWASM: string;
  userDefinedFlags: string;
}

export async function compileImpl(option: CompilationOption, useWarpo: boolean): Promise<void> {
  await (useWarpo ? buildWithWARPO : buildWithASC)(option);
}
