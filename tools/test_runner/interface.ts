import { ASUtil } from "@assemblyscript/loader";

export abstract class UnitTestFramework {
  /**
   * function to redirect log message to unittest framework
   * @param msg: message to log
   */
  abstract log(msg: string): void;
}

export class ImportsArgument {
  module: WebAssembly.Module | null = null;
  instance: WebAssembly.Instance | null = null;
  exports: (ASUtil & Record<string, unknown>) | null = null;
  constructor(public framework: UnitTestFramework) {}
}

export type OutputMode = "html" | "json" | "table";

export type Imports = ((arg: ImportsArgument) => Record<string, unknown>) | null;

export declare class Config {
  /** Files to include in testing and coverage statistics */
  include: string[];
  /** Files to exclude from testing and coverage statistics, has higher priority than include */
  exclude?: string[];
  /** entry files for the whole projects, used to collect all source code information. default value is `${include}/index.ts` */
  entryFiles?: string[];

  /** whether to collect coverage information, default is true */
  collectCoverage?: boolean;

  /** create an wasm instance for each test files. default is false (will be true in next major version) */
  isolated?: boolean;

  /** assemblyscript compile flag, default is --exportStart __unit_test_start --sourceMap --debug -O0 */
  flags?: string;
  imports?: Imports;

  /** report folder path, default "./coverage" */
  output?: string;

  /** output report mode, default is "table" */
  mode?: OutputMode | OutputMode[];
}
