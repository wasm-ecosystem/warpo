// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, rmSync } from "node:fs";
import { platform } from "node:os";
import { dirname, resolve } from "node:path";
import { after, before, describe, it } from "node:test";
import { fileURLToPath } from "node:url";
import {
  DwarfFunctionInfoResolver,
  getScopeChainInFunctionAtBytecodeOffset,
  getVariablesInFunctionAtBytecodeOffset,
} from "../functionDebugInfo.js";
import { DebuggerWasmModule } from "../../debug_server/debuggerWasmModule.js";

const TEST_DIR = dirname(fileURLToPath(import.meta.url));
const PROJECT_ROOT = resolve(TEST_DIR, "../../..");
const WARPO_ASC_NAME = platform() === "win32" ? "warpo_asc.exe" : "warpo_asc";
const WARPO_ASC = resolve(PROJECT_ROOT, "build/warpo", WARPO_ASC_NAME);
const FIXTURE_SOURCE = resolve(TEST_DIR, "fixtures/functionDebugInfo.ts");
const BUILD_DIR = resolve(TEST_DIR, "fixtures/build-functionDebugInfo");
const WASM_PATH = resolve(BUILD_DIR, "functionDebugInfo.wasm");

const COMPUTE_FUNCTION_NAME = "tools/dwarf/tests/fixtures/functionDebugInfo/compute";
const COMPUTE_LINE = 6;
const INNER_LINE = 8;

describe("functionDebugInfo", () => {
  let resolver: DwarfFunctionInfoResolver;
  let debuggerWasmModule: DebuggerWasmModule;

  before(async () => {
    if (!existsSync(WARPO_ASC)) {
      throw new Error(
        `functionDebugInfo tests require warpo_asc at ${WARPO_ASC}. Please build with: npm run build:cpp`
      );
    }

    mkdirSync(BUILD_DIR, { recursive: true });
    execFileSync(WARPO_ASC, [FIXTURE_SOURCE, "-o", WASM_PATH, "--debug", "--sourceMap", "--exportRuntime"], {
      cwd: PROJECT_ROOT,
      stdio: "pipe",
    });
    resolver = DwarfFunctionInfoResolver.fromWasm(readFileSync(WASM_PATH));
    debuggerWasmModule = await DebuggerWasmModule.load(WASM_PATH);
  });

  after(() => {
    debuggerWasmModule.dispose();
    rmSync(BUILD_DIR, { recursive: true, force: true });
  });

  function findBytecodeOffsetFromSourceLine(line: number): number {
    const bytecodeOffset = debuggerWasmModule.findBytecodeOffset(FIXTURE_SOURCE, line);
    if (bytecodeOffset === undefined) {
      throw new Error(`missing bytecode offset for ${FIXTURE_SOURCE}:${line}`);
    }
    return bytecodeOffset;
  }

  it("finds the function that owns a bytecode offset", () => {
    const bytecodeOffset = findBytecodeOffsetFromSourceLine(COMPUTE_LINE);

    const functionInfo = resolver.findFunctionByBytecodeOffset(bytecodeOffset);
    assert.equal(functionInfo?.name, COMPUTE_FUNCTION_NAME);
  });

  it("returns variables active on the bytecode scope parent chain", () => {
    const bytecodeOffset = findBytecodeOffsetFromSourceLine(INNER_LINE);
    const functionInfo = resolver.findFunctionByBytecodeOffset(bytecodeOffset);
    if (!functionInfo) {
      throw new Error(`missing function at bytecode offset ${bytecodeOffset}`);
    }

    const variables = getVariablesInFunctionAtBytecodeOffset(functionInfo, bytecodeOffset);
    assert.deepEqual(
      variables.map((variable) => [variable.name, variable.typeName]),
      [
        ["input", "i32"],
        ["outer", "i32"],
        ["inner", "i32"],
      ]
    );
  });

  it("returns the active scope chain for a bytecode offset", () => {
    const bytecodeOffset = findBytecodeOffsetFromSourceLine(INNER_LINE);
    const functionInfo = resolver.findFunctionByBytecodeOffset(bytecodeOffset);
    if (!functionInfo) {
      throw new Error(`missing function at bytecode offset ${bytecodeOffset}`);
    }

    const scopeChain = getScopeChainInFunctionAtBytecodeOffset(functionInfo, bytecodeOffset);

    assert.deepEqual(
      scopeChain.map((scope) => scope.variables.map((variable) => variable.name)),
      [["inner"]]
    );
  });
});
