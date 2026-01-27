import type { Imports } from "./dist/interface.d.ts";

export type OutputMode = "html" | "json" | "table";

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

  /** template folder path, default "./coverage" */
  temp?: string;

  /** report folder path, default "./coverage" */
  output?: string;

  /** output report mode, default is "table" */
  mode?: OutputMode | OutputMode[];

  /** whether to build with warpo */
  warpo?: boolean;
}
