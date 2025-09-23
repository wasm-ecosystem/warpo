// Copyright (C) 2024 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { execSync } from "node:child_process";
import { readFileSync, writeFileSync } from "node:fs";
import { basename, join } from "node:path";
import assert from "node:assert";
import { readdirSync } from "node:fs";

const target_folder = process.argv[2];
const build_target = process.argv[3];
assert(build_target === "debug" || build_target === "release", "invalid build target");

const project_root = join("..", "..");

const ext_libs_path = join(project_root, "assemblyscript_extension", "std");

execSync("node scripts/build.js", { cwd: join(project_root, "assemblyscript") });

async function createLibrarySources() {
  const { libraryFiles } = await import("../../assemblyscript/cli/index.generated.js");
  writeFileSync(
    join(target_folder, "library_sources.inc"),
    Object.keys(libraryFiles)
      .map((fileName) => `{\n  "${fileName}", R"##(${libraryFiles[fileName]})##",\n},\n`)
      .join("")
  );
}
createLibrarySources();

async function createExtensionLibrarySources() {
  const extLibraryFiles = readdirSync(ext_libs_path)
    .filter((f) => f.endsWith(".ts"))
    .map((f) => join(ext_libs_path, f))
    .map((p) => [basename(p, ".ts"), readFileSync(p, "utf8")]);
  writeFileSync(
    join(target_folder, "extension_library_sources.inc"),
    extLibraryFiles.map(([fileName, content]) => `{\n  "${fileName}", R"##(${content})##",\n},\n`).join("")
  );
}
createExtensionLibrarySources();

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
unsigned int asc_wasm_len = {${wasmBuf.length}};
  `
);

console.log(`AS wasm size: ${wasmBuf.length} bytes`);
