// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { execSync } from "node:child_process";
import { readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import assert from "node:assert";
import { project_root } from "./helper.mjs";
import { createExtensionLibrarySources, createLibrarySources } from "./std.mjs";
import { generateDiagnostics } from "./diag.mjs";

const target_folder = process.argv[2];
const build_target = process.argv[3];
assert(build_target === "debug" || build_target === "release", "invalid build target");

generateDiagnostics();
createLibrarySources(target_folder);
createExtensionLibrarySources(target_folder);

execSync(
  `npx asc --config asconfig.json --target ${build_target} -o ${target_folder}/assemblyscript.${build_target}.wasm -t ${target_folder}/assemblyscript.${build_target}.wast`,
  { cwd: project_root }
);

const wasmBuf = readFileSync(join(target_folder, `assemblyscript.${build_target}.wasm`));
const wasmBytes = Array.from(wasmBuf)
  .map((byte) => "0x" + byte.toString(16).padStart(2, "0"))
  .join(", ");
writeFileSync(
  join(target_folder, "assemblyscript.inc"),
  `
unsigned char asc_wasm[] = {${wasmBytes}};
  `
);

console.log(`AS wasm size: ${wasmBuf.length} bytes`);
