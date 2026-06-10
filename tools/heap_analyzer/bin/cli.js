#!/usr/bin/env node
// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { readFileSync } from "node:fs";
import { Command } from "commander";
import { analyzeDump, compareDumps } from "../../../dist/heap_analyzer/src/index.js";

const CONSTRUCTOR_SORTS = ["retained", "shallow", "count"];
const COMPARISON_SORTS = ["delta", "alloc", "freed", "count"];

function readVersion() {
  const packageJson = readFileSync(new URL("../package.json", import.meta.url), "utf8");
  return JSON.parse(packageJson).version;
}

function parsePositiveInteger(value, optionName) {
  const parsed = Number.parseInt(value, 10);
  if (!Number.isInteger(parsed) || parsed < 1) throw new Error(`${optionName} must be a positive integer`);

  return parsed;
}

function parseSortField(value) {
  return value;
}

function readArrayBuffer(filePath, label) {
  try {
    const buffer = readFileSync(filePath);
    return buffer.buffer.slice(buffer.byteOffset, buffer.byteOffset + buffer.byteLength);
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`Error reading ${label}: ${message}`);
  }
}

function readUint8Array(filePath, label) {
  try {
    return new Uint8Array(readFileSync(filePath));
  } catch (error) {
    const message = error instanceof Error ? error.message : String(error);
    throw new Error(`Error reading ${label}: ${message}`);
  }
}

function sortConstructors(constructors, sortField) {
  if (!CONSTRUCTOR_SORTS.includes(sortField)) {
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

function sortConstructorComparisons(constructors, sortField) {
  if (!COMPARISON_SORTS.includes(sortField)) {
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
          rhs.freedSize - lhs.freedSize ||
          lhs.sizeDelta - rhs.sizeDelta ||
          lhs.className.localeCompare(rhs.className)
      );
    }
    case "count": {
      return constructors.toSorted(
        (lhs, rhs) =>
          rhs.countDelta - lhs.countDelta ||
          rhs.sizeDelta - lhs.sizeDelta ||
          lhs.className.localeCompare(rhs.className)
      );
    }
    default: {
      throw new Error(`Invalid comparison sort field: ${sortField}. Must be delta, alloc, freed, or count.`);
    }
  }
}

function analyzeDumpWithCli(dumpFile, options) {
  const dumpBuffer = readArrayBuffer(dumpFile, "dump file");
  const wasmBytes = readUint8Array(options.wasm, "wasm file");

  const snapshot = analyzeDump(dumpBuffer, wasmBytes);
  const sortField = options.sort ?? "retained";
  let constructors = sortConstructors(snapshot.constructors, sortField);
  if (options.top !== undefined) constructors = constructors.slice(0, options.top);

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

function diffDumpsWithCli(beforeDumpFile, afterDumpFile, options) {
  const beforeDumpBuffer = readArrayBuffer(beforeDumpFile, "baseline dump file");
  const afterDumpBuffer = readArrayBuffer(afterDumpFile, "current dump file");
  const wasmBytes = readUint8Array(options.wasm, "wasm file");
  const comparison = compareDumps(beforeDumpBuffer, afterDumpBuffer, wasmBytes);
  const sortField = options.sort ?? "delta";
  let constructors = sortConstructorComparisons(comparison.constructors, sortField);
  if (options.top !== undefined) constructors = constructors.slice(0, options.top);

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
  .action((dumpFile, options) => {
    analyzeDumpWithCli(dumpFile, options);
  });

program
  .command("diff <before-dump-file> <after-dump-file>")
  .description("Show the comparison view between two heap dumps")
  .requiredOption("--wasm <file>", "Path to the wasm binary with DWARF custom sections")
  .option("--sort <field>", "Sort comparison rows by delta|alloc|freed|count", parseSortField)
  .option("--top <n>", "Show top N classes in comparison view", (value) => parsePositiveInteger(value, "--top"))
  .action((beforeDumpFile, afterDumpFile, options) => {
    diffDumpsWithCli(beforeDumpFile, afterDumpFile, options);
  });

program.parseAsync(process.argv).catch((error) => {
  const message = error instanceof Error ? error.message : String(error);
  console.error(message);
  process.exitCode = 1;
});
