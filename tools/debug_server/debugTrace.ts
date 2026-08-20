// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { appendFileSync, mkdirSync } from "node:fs";
import * as path from "node:path";

let debugServerTraceFile: string | undefined;

function initializeTraceFile(filePath: string): void {
  mkdirSync(path.dirname(filePath), { recursive: true });
  appendFileSync(filePath, "");
}

export function configureTrace(filePath: string | undefined, cwd = process.cwd()): void {
  const configuredFile = filePath?.trim() || process.env.WARPO_DEBUG_SERVER_TRACE_FILE?.trim();
  if (!configuredFile) {
    debugServerTraceFile = undefined;
    return;
  }

  const resolvedFile = path.isAbsolute(configuredFile) ? configuredFile : path.resolve(cwd, configuredFile);
  try {
    initializeTraceFile(resolvedFile);
  } catch (error: unknown) {
    debugServerTraceFile = undefined;
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`Unable to create debug trace file "${resolvedFile}": ${message}`);
  }
  debugServerTraceFile = resolvedFile;
}

export function trace(component: string, message: string): void {
  if (!debugServerTraceFile) {
    return;
  }

  try {
    appendFileSync(debugServerTraceFile, `[${component}] ${message}\n`);
  } catch {
    // Tracing should never block launching the runtime.
  }
}
