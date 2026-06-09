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

function sortConstructors(constructors, sortField) {
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
      throw new Error(`Invalid sort field: ${sortField}. Must be retained, shallow, or count.`);
    }
  }
}

function analyzeDumpWithCli(dumpFile, options) {
  const dumpBuffer = readArrayBuffer(dumpFile, "dump file");
  const wasmBytes = readUint8Array(options.wasm, "wasm file");
  const snapshot = analyzeDump(dumpBuffer, wasmBytes);

  let constructors = sortConstructors(snapshot.constructors, options.sort);
  if (options.top !== undefined) constructors = constructors.slice(0, options.top);

  const output = {
    totalHeapSize: snapshot.totalHeapSize,
    totalLiveSize: snapshot.totalLiveSize,
    constructors,
  };

  console.log(JSON.stringify(output, null, 2));
}

const program = new Command();

program
  .name("as-heap-analyzer")
  .description("Analyze an AssemblyScript heap dump and output heap analysis as JSON.")
  .version(readVersion(), "-v, --version")
  .showHelpAfterError()
  .argument("<dump-file>", "Path to the heap dump file")
  .requiredOption("--wasm <file>", "Path to the wasm binary with DWARF custom sections")
  .option("--sort <field>", "Sort constructors by: retained | shallow | count", parseSortField, "retained")
  .option("--top <n>", "Show top N classes in constructor view", (value) => parsePositiveInteger(value, "--top"))
  .action((dumpFile, options) => {
    analyzeDumpWithCli(dumpFile, options);
  });

program.parseAsync(process.argv).catch((error) => {
  const message = error instanceof Error ? error.message : String(error);
  console.error(message);
  process.exitCode = 1;
});
