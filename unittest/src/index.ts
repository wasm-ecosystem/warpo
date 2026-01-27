import chalk from "chalk";
import pkg from "fs-extra";
import { Parser } from "./parser/index.js";
import { compile } from "./core/compile.js";
import { analyze } from "./core/analyze.js";
import { instrument } from "./core/instrument.js";
import { execWasmBinaries } from "./core/execute.js";
import { generateReport, reportConfig } from "./generator/index.js";
import { TestOption } from "./interface.js";
import { join } from "node:path";
import { CompilationError } from "./core/compiler.js";

const { readFileSync, emptydirSync } = pkg;

export function validateArgument(includes: unknown, excludes: unknown) {
  if (!Array.isArray(includes)) {
    throw new TypeError("include section illegal");
  }
  if (!Array.isArray(excludes)) {
    throw new TypeError("exclude section illegal");
  }
  for (const includePath of includes) {
    if (typeof includePath !== "string") {
      throw new TypeError("include section illegal");
    }
  }
  for (const excludePath of excludes) {
    if (typeof excludePath !== "string") {
      throw new TypeError("exclude section illegal");
    }
  }
}

async function startUniTestImpl(options: TestOption): Promise<number> {
  const failurePath = join(options.outputFolder, "failures.json");
  let failedTestCases: string[] = [];
  if (options.onlyFailures) {
    failedTestCases = JSON.parse(readFileSync(failurePath, "utf8")) as string[];
    if (failedTestCases.length === 0) {
      options.collectCoverage = true;
      console.log(
        chalk.yellowBright(
          'Warning: no failed test cases found while enabled "onlyFailures", execute all test cases by default'
        )
      );
    }
  }

  emptydirSync(options.outputFolder);
  emptydirSync(options.tempFolder);
  const { sourceCodePaths, testCodePaths, entryFiles, filterByName } = analyze(options, failedTestCases);
  console.log(chalk.blueBright("code analysis: ") + chalk.bold.greenBright("OK"));

  const wasmPaths = await compile(testCodePaths, entryFiles, options);
  console.log(chalk.blueBright("compile test files: ") + chalk.bold.greenBright("OK"));

  const instrumentResult = await instrument(wasmPaths, options.collectCoverage);
  console.log(chalk.blueBright("instrument: ") + chalk.bold.greenBright("OK"));

  const executedResult = await execWasmBinaries(options.tempFolder, instrumentResult, filterByName, options.imports);
  console.log(chalk.blueBright("execute test files: ") + chalk.bold.greenBright("OK"));

  await executedResult.writeFailures(failurePath);
  executedResult.print(console.log);
  if (options.collectCoverage) {
    const parser = new Parser();
    const fileCoverageInfo = await parser.parse(instrumentResult, sourceCodePaths);
    reportConfig.warningLimit = options.warnLimit || reportConfig.warningLimit;
    reportConfig.errorLimit = options.errorLimit || reportConfig.errorLimit;
    generateReport(options.mode, options.outputFolder, fileCoverageInfo);
  }
  return executedResult.fail === 0 ? 0 : 1;
}

export async function start_unit_test(options: TestOption): Promise<number> {
  try {
    return await startUniTestImpl(options);
  } catch (error) {
    if (error instanceof CompilationError) {
      console.log(error.message);
      return 2;
    }
    // unknown exception.
    throw error;
  }
}
