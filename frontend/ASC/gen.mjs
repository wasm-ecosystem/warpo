// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { execSync } from "node:child_process";
import { mkdirSync, readFileSync } from "node:fs";
import { join } from "node:path";
import assert from "node:assert";
import { project_root } from "./helper.mjs";
import { generateDiagnostics } from "./diag.mjs";

const target_folder = process.argv[2];
const build_target = process.argv[3];
const wasm_path = process.argv[4] ?? join(target_folder, `assemblyscript.${build_target}.wasm`);
assert(build_target === "debug" || build_target === "release", "invalid build target");

mkdirSync(target_folder, { recursive: true });
generateDiagnostics();

execSync(
  `npx asc --config asconfig.json --target ${build_target} -o ${wasm_path} -t ${target_folder}/assemblyscript.${build_target}.wast`,
  { cwd: project_root }
);

const wasmBuf = readFileSync(wasm_path);

console.log(`AS wasm size: ${wasmBuf.length} bytes`);
