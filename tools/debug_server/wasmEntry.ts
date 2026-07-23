// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0
/* eslint-disable n/no-process-exit, unicorn/no-process-exit */

import * as fs from "node:fs";
import * as inspector from "node:inspector";
import * as path from "node:path";

const [wasmFilePath, entryFunctionName, ...rawArgs] = process.argv.slice(2);

if (!wasmFilePath || !entryFunctionName) {
  console.error("Usage: wasmEntry.js <wasmFilePath> <entryFunctionName> [args...]");
  process.exit(1);
}

const resolvedPath = path.resolve(wasmFilePath);
if (!fs.existsSync(resolvedPath)) {
  console.error(`Wasm file not found: ${resolvedPath}`);
  process.exit(1);
}

const args = rawArgs.map(Number);

function formatError(error: unknown): string {
  if (error instanceof Error) {
    return error.message;
  }

  if (typeof error === "string") {
    return error;
  }

  if (typeof error === "number" || typeof error === "boolean" || typeof error === "bigint") {
    return error.toString();
  }

  return "unknown error";
}

async function instantiateWasm(filePath: string): Promise<WebAssembly.Instance> {
  try {
    const buffer = fs.readFileSync(filePath);
    const module = await WebAssembly.compile(buffer);
    return await WebAssembly.instantiate(module, {});
  } catch (error) {
    console.error(`Failed to load wasm module "${filePath}": ${formatError(error)}`);
    process.exit(1);
  }
}

async function main() {
  inspector.waitForDebugger();

  const instance = await instantiateWasm(resolvedPath);

  inspector.waitForDebugger();

  const fn = instance.exports[entryFunctionName];
  if (typeof fn !== "function") {
    const keys = Object.keys(instance.exports).join(", ");
    console.error(`Export "${entryFunctionName}" is not a function. Available exports: ${keys}`);
    process.exit(1);
  }

  console.log(`Calling ${entryFunctionName}(${args.join(", ")})...`);
  const result = (fn as (...a: number[]) => unknown)(...args);
  // eslint-disable-next-line @typescript-eslint/no-base-to-string, @typescript-eslint/restrict-template-expressions
  console.log(`Result: ${result}`);
}

await main();
