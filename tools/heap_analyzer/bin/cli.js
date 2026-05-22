#!/usr/bin/env node
// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { readFileSync } from "node:fs";
import { Command } from "commander";
import { analyzeDump } from "../../../dist/heap_analyzer/src/index.js";

const VALID_SORTS = ["retained", "shallow", "count"];

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
  if (!VALID_SORTS.includes(value))
    throw new Error(`Invalid sort field: ${value}. Must be retained, shallow, or count.`);

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

function sortSummary(summary, sortField) {
  switch (sortField) {
    case "retained": {
      return summary;
    }
    case "shallow": {
      return summary.toSorted((lhs, rhs) => rhs.totalShallowSize - lhs.totalShallowSize);
    }
    case "count": {
      return summary.toSorted((lhs, rhs) => rhs.count - lhs.count);
    }
    default: {
      throw new Error(`Invalid sort field: ${sortField}. Must be retained, shallow, or count.`);
    }
  }
}
function analyzeDumpWithCli(dumpFile, options) {
  const dumpBuffer = readArrayBuffer(dumpFile, "dump file");
  const wasmBytes = readUint8Array(options.wasm, "wasm file");
  const snapshot = analyzeDump(dumpBuffer, wasmBytes);

  let summary = sortSummary(snapshot.summary, options.sort);
  if (options.top !== undefined) summary = summary.slice(0, options.top);

  const output = {
    summary,
    totalHeapSize: snapshot.totalHeapSize,
    totalLiveSize: snapshot.totalLiveSize,
    totalFreeSize: snapshot.totalFreeSize,
    objectCount: snapshot.objectCount,
    roots: snapshot.roots,
  };

  if (options.objects) output.objects = snapshot.objects;

  const indent = options.pretty ? 2 : undefined;
  console.log(JSON.stringify(output, null, indent));
}

const program = new Command();

program
  .name("as-heap-analyzer")
  .description("Analyze an AssemblyScript heap dump and output heap analysis as JSON.")
  .version(readVersion(), "-v, --version")
  .showHelpAfterError()
  .argument("<dump-file>", "Path to the heap dump file")
  .requiredOption("--wasm <file>", "Path to the wasm binary with DWARF custom sections")
  .option("--sort <field>", "Sort summary by: retained | shallow | count", parseSortField, "retained")
  .option("--top <n>", "Show top N classes in summary", (value) => parsePositiveInteger(value, "--top"))
  .option("--objects", "Include individual object details in output")
  .option("--pretty", "Pretty-print JSON output")
  .action((dumpFile, options) => {
    analyzeDumpWithCli(dumpFile, options);
  });

program.parseAsync(process.argv).catch((error) => {
  const message = error instanceof Error ? error.message : String(error);
  console.error(message);
  process.exitCode = 1;
});
