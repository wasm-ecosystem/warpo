// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { appendFileSync, mkdirSync } from "node:fs";
import * as path from "node:path";

const DEBUG_SERVER_TRACE_ENABLED = process.env.WARPO_DEBUG_SERVER_TRACE === "1";
const DEBUG_SERVER_TRACE_FILE =
  process.env.WARPO_DEBUG_SERVER_TRACE_FILE ?? path.join(process.cwd(), ".warpo-debug-server-trace.log");

if (DEBUG_SERVER_TRACE_ENABLED) {
  try {
    mkdirSync(path.dirname(DEBUG_SERVER_TRACE_FILE), { recursive: true });
    appendFileSync(DEBUG_SERVER_TRACE_FILE, "");
  } catch {
    // Tracing should never block launching the runtime.
  }
}

export function trace(component: string, message: string): void {
  if (!DEBUG_SERVER_TRACE_ENABLED) {
    return;
  }

  try {
    appendFileSync(DEBUG_SERVER_TRACE_FILE, `[${component}] ${message}\n`);
  } catch {
    // Tracing should never block launching the runtime.
  }
}
