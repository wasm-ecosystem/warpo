// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import chalk from "chalk";
import fs from "fs-extra";
import { resolve } from "node:path";
import { Command } from "commander";
import { validateArgument, start } from "./index.js";
import { loadConfig } from "./config.js";
import { TestOption } from "./testOption.js";
import { Repository } from "./utils/name.js";

interface CliOptions {
  config: string;
  output?: string;
  mode?: TestOption["mode"];
  coverageLimit?: string[];
  collectCoverage?: string;
  testFiles?: string[];
  testNamePattern?: string;
  onlyFailures?: boolean;
}

function parseCollectCoverage(
  optionValue: string | undefined,
  fallback: boolean | undefined,
  enabledByDefault: boolean
): boolean {
  if (optionValue === "false") {
    return false;
  }
  if (optionValue === "true") {
    return true;
  }
  return fallback ?? enabledByDefault;
}

function formatUnknownError(error: unknown): string {
  if (error instanceof Error) {
    return error.stack ?? error.message;
  }
  if (typeof error === "string") {
    return error;
  }
  return "unknown error";
}

function createProgram(): Command {
  const program = new Command();
  program
    .option("--config <config file>", "path of config file", "as-test.config.js")

    .option("--output <path>", "coverage report output folder")
    .option("--mode <output mode>", "coverage report output format")

    .option("--coverageLimit [error warning...]", "set warn(yellow) and error(red) upper limit in coverage report")
    .option("--collectCoverage <boolean>", "whether to collect coverage information and report")

    .option("--testFiles <testFiles...>", "run only specified test files")
    .option("--testNamePattern <test name pattern>", "run only tests with a name that matches the regex pattern")
    .option("--onlyFailures", "Run tests that failed in the previous")
    .addHelpText("beforeAll", `submit feature requests or issues: ${Repository}/issues`);
  return program;
}

export async function runFromCliArgs(args: string[]): Promise<number> {
  const program = createProgram();
  program.parse(args, { from: "user" });

  const options = program.opts<CliOptions>();

  const configPath = resolve(".", options.config);
  if (!fs.pathExistsSync(configPath)) {
    console.error(chalk.redBright("Miss config file") + "\n");
    console.error(program.helpInformation());
    return 3;
  }
  const config = await loadConfig(configPath);

  const includes = config.include;
  if (includes === undefined) {
    console.error(chalk.redBright("Miss include in config file") + "\n");
    return 3;
  }
  const excludes = config.exclude ?? [];
  validateArgument(includes, excludes);

  const testFiles = options.testFiles ?? null;
  const onlyFailures = options.onlyFailures || false;
  const testNamePattern = options.testNamePattern ?? null;

  if (onlyFailures && testNamePattern !== null) {
    console.error(chalk.redBright("Cannot use --onlyFailures and --testNamePattern together") + "\n");
    return 3;
  }

  // if enabled testcase or testNamePattern or onlyFailures, disable collectCoverage by default
  const collectCoverage = parseCollectCoverage(
    options.collectCoverage,
    config.collectCoverage,
    testFiles === null && options.testNamePattern === undefined && !onlyFailures
  );

  const entryFiles = config.entryFiles ?? null;

  const warnLimitValue = options.coverageLimit?.at(1);
  const errorLimitValue = options.coverageLimit?.at(0);

  const testOption: TestOption = {
    includes,
    excludes,
    testFiles,
    entryFiles,

    testNamePattern,
    collectCoverage,
    onlyFailures,

    flags: config.flags ?? "",

    outputFolder: options.output ?? config.output ?? "coverage",
    mode: options.mode ?? config.mode ?? "table",
  };

  if (config.imports !== undefined) {
    testOption.imports = config.imports;
  }

  if (warnLimitValue !== undefined) {
    testOption.warnLimit = Number(warnLimitValue);
  }
  if (errorLimitValue !== undefined) {
    testOption.errorLimit = Number(errorLimitValue);
  }

  try {
    return await start(testOption);
  } catch (error: unknown) {
    const message = formatUnknownError(error);
    console.error(chalk.redBright("framework crash, error message: ") + chalk.yellowBright(message) + "\n");
    console.error(`please submit an issue at ${Repository}/issues`);
    return 255;
  }
}
