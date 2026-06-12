#!/usr/bin/env node
// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { argv as processArgv, exit as processExit } from "node:process";
import { fileURLToPath } from "node:url";
import { main as runCli } from "../../../dist/heap_analyzer/cli.js";

export { main as runCli } from "../../../dist/heap_analyzer/cli.js";

if (processArgv[1] !== undefined && fileURLToPath(import.meta.url) === processArgv[1]) {
  runCli(processArgv.slice(2)).catch((error) => {
    const message = error instanceof Error ? error.message : String(error);
    console.error(message);
    processExit(1);
  });
}
