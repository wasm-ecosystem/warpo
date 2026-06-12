// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { readFileSync } from "node:fs";
import { argv as processArgv, exit as processExit } from "node:process";
import { fileURLToPath } from "node:url";
import { Command } from "commander";
import { analyzeDump, compareDumps } from "./src/index.js";

const CONSTRUCTOR_SORTS = new Set(["retained", "shallow", "count"]);
const COMPARISON_SORTS = new Set(["delta", "alloc", "freed", "count"]);
type HeapAnalyzerCommandOptions = { wasm: string; sort?: string; top?: number };

function readVersion(): string {
  const packageJson = readFileSync(new URL("../../package.json", import.meta.url), "utf8");
  const parsed = JSON.parse(packageJson) as { version?: unknown };
  const version = parsed.version;
  if (typeof version !== "string") {
    throw new TypeError("Invalid package.json: missing string version");
  }

  return version;
}

function parsePositiveInteger(value: string, optionName: string): number {
  const parsed = Number.parseInt(value, 10);
  if (!Number.isInteger(parsed) || parsed < 1) {
    throw new Error(`${optionName} must be a positive integer`);
  }

  return parsed;
}

function parseSortField(value: string): string {
  return value;
}

function formatErrorMessage(error: unknown): string {
  if (error instanceof Error) {
    return error.message;
  }
  if (typeof error === "string") {
    return error;
  }

  return JSON.stringify(error);
}

function readArrayBuffer(filePath: string, label: string): ArrayBuffer {
  try {
    const buffer = readFileSync(filePath);
    return buffer.buffer.slice(buffer.byteOffset, buffer.byteOffset + buffer.byteLength);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`Error reading ${label}: ${message}`);
  }
}

function readUint8Array(filePath: string, label: string): Uint8Array {
  try {
    return new Uint8Array(readFileSync(filePath));
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`Error reading ${label}: ${message}`);
  }
}

function sortConstructors(constructors: ReturnType<typeof analyzeDump>["constructors"], sortField: string) {
  if (!CONSTRUCTOR_SORTS.has(sortField)) {
    throw new Error(`Invalid constructor sort field: ${sortField}. Must be retained, shallow, or count.`);
  }

  switch (sortField) {
    case "retained": {
      return constructors;
    }
    case "shallow": {
      return constructors.toSorted((lhs, rhs) => rhs.totalShallowSize - lhs.totalShallowSize);
    }
    case "count": {
      return constructors.toSorted((lhs, rhs) => rhs.count - lhs.count);
    }
    default: {
      throw new Error(`Invalid constructor sort field: ${sortField}. Must be retained, shallow, or count.`);
    }
  }
}

function sortConstructorComparisons(constructors: ReturnType<typeof compareDumps>["constructors"], sortField: string) {
  if (!COMPARISON_SORTS.has(sortField)) {
    throw new Error(`Invalid comparison sort field: ${sortField}. Must be delta, alloc, freed, or count.`);
  }

  switch (sortField) {
    case "delta": {
      return constructors;
    }
    case "alloc": {
      return constructors.toSorted(
        (lhs, rhs) =>
          rhs.allocatedSize - lhs.allocatedSize ||
          rhs.sizeDelta - lhs.sizeDelta ||
          rhs.countDelta - lhs.countDelta ||
          lhs.className.localeCompare(rhs.className)
      );
    }
    case "freed": {
      return constructors.toSorted(
        (lhs, rhs) =>
          rhs.freedSize - lhs.freedSize || lhs.sizeDelta - rhs.sizeDelta || lhs.className.localeCompare(rhs.className)
      );
    }
    case "count": {
      return constructors.toSorted(
        (lhs, rhs) =>
          rhs.countDelta - lhs.countDelta || rhs.sizeDelta - lhs.sizeDelta || lhs.className.localeCompare(rhs.className)
      );
    }
    default: {
      throw new Error(`Invalid comparison sort field: ${sortField}. Must be delta, alloc, freed, or count.`);
    }
  }
}

function analyzeDumpWithCli(dumpFile: string, options: HeapAnalyzerCommandOptions): void {
  const dumpBuffer = readArrayBuffer(dumpFile, "dump file");
  const wasmBytes = readUint8Array(options.wasm, "wasm file");
  const snapshot = analyzeDump(dumpBuffer, wasmBytes);
  const sortField = options.sort ?? "retained";
  let constructors = sortConstructors(snapshot.constructors, sortField);
  if (options.top !== undefined) {
    constructors = constructors.slice(0, options.top);
  }

  console.log(
    JSON.stringify(
      {
        totalHeapSize: snapshot.totalHeapSize,
        totalLiveSize: snapshot.totalLiveSize,
        constructors,
      },
      null,
      2
    )
  );
}

function diffDumpsWithCli(beforeDumpFile: string, afterDumpFile: string, options: HeapAnalyzerCommandOptions): void {
  const beforeDumpBuffer = readArrayBuffer(beforeDumpFile, "baseline dump file");
  const afterDumpBuffer = readArrayBuffer(afterDumpFile, "current dump file");
  const wasmBytes = readUint8Array(options.wasm, "wasm file");
  const comparison = compareDumps(beforeDumpBuffer, afterDumpBuffer, wasmBytes);
  const sortField = options.sort ?? "delta";
  let constructors = sortConstructorComparisons(comparison.constructors, sortField);
  if (options.top !== undefined) {
    constructors = constructors.slice(0, options.top);
  }

  console.log(
    JSON.stringify(
      {
        beforeTotalHeapSize: comparison.beforeTotalHeapSize,
        afterTotalHeapSize: comparison.afterTotalHeapSize,
        totalHeapSizeDelta: comparison.totalHeapSizeDelta,
        beforeTotalLiveSize: comparison.beforeTotalLiveSize,
        afterTotalLiveSize: comparison.afterTotalLiveSize,
        totalLiveSizeDelta: comparison.totalLiveSizeDelta,
        constructors,
      },
      null,
      2
    )
  );
}

export async function main(args: string[] = processArgv.slice(2)): Promise<void> {
  const program = new Command();

  program
    .name("as-heap-analyzer")
    .description("Analyze or diff AssemblyScript heap dumps and output heap analysis as JSON.")
    .version(readVersion(), "-v, --version")
    .showHelpAfterError();

  program
    .command("analyze <dump-file>")
    .description("Show the constructor view for a single heap dump")
    .requiredOption("--wasm <file>", "Path to the wasm binary with DWARF custom sections")
    .option("--sort <field>", "Sort constructors by retained|shallow|count", parseSortField)
    .option("--top <n>", "Show top N classes in constructor view", (value) => parsePositiveInteger(value, "--top"))
    .action((dumpFile: string, options: HeapAnalyzerCommandOptions) => {
      analyzeDumpWithCli(dumpFile, options);
    });

  program
    .command("diff <before-dump-file> <after-dump-file>")
    .description("Show the comparison view between two heap dumps")
    .requiredOption("--wasm <file>", "Path to the wasm binary with DWARF custom sections")
    .option("--sort <field>", "Sort comparison rows by delta|alloc|freed|count", parseSortField)
    .option("--top <n>", "Show top N classes in comparison view", (value) => parsePositiveInteger(value, "--top"))
    .action((beforeDumpFile: string, afterDumpFile: string, options: HeapAnalyzerCommandOptions) => {
      diffDumpsWithCli(beforeDumpFile, afterDumpFile, options);
    });

  await program.parseAsync(args, { from: "user" });
}

if (processArgv[1] !== undefined && fileURLToPath(import.meta.url) === processArgv[1]) {
  try {
    await main();
  } catch (error: unknown) {
    console.error(formatErrorMessage(error));
    processExit(1);
  }
}
