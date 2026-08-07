#!/usr/bin/env node

// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { realpathSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { argv as processArgv, exit as processExit } from "node:process";
import { main as runCli } from "./warpo_internal.js";
import {
  build as runCompiler,
  cleanDownloaded,
  downloadAll as downloadAllAssets,
  downloadForCurrentMachine,
  type Option as BuildOption,
} from "./scripts/lib.js";
import { runFromCliArgs as runUnitTestsFromCliArgs } from "./test_runner/cli.js";

export { main as runCli } from "./warpo_internal.js";
export type { CliOption } from "./warpo_internal.js";
export type { Option as BuildOption } from "./scripts/lib.js";

export interface DownloadOption {
  all?: boolean;
  clean?: boolean;
  proxy?: string;
}

export async function build(options: BuildOption): Promise<number> {
  return await runCompiler(options);
}

export async function test(argv: string[] = []): Promise<number> {
  return await runUnitTestsFromCliArgs(argv);
}

export async function download(options: DownloadOption = {}): Promise<string | string[]> {
  if (options.clean) {
    return await cleanDownloaded();
  }
  if (options.all) {
    return await downloadAllAssets(options.proxy);
  }
  return await downloadForCurrentMachine(options.proxy);
}

if (processArgv[1] !== undefined && realpathSync(fileURLToPath(import.meta.url)) === realpathSync(processArgv[1])) {
  runCli({ argv: processArgv.slice(2) })
    .then((code) => {
      return processExit(code);
    })
    // eslint-disable-next-line unicorn/prefer-top-level-await
    .catch((error: unknown) => {
      console.error(error);
      return processExit(255);
    });
}
