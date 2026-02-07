import { Imports, OutputMode } from "./interface.js";

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

  outputFolder: string;
  mode: OutputMode | OutputMode[];
  warnLimit?: number;
  errorLimit?: number;
}
