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

function stringToHexCArray(str) {
  // Convert a string to a C-style hex array
  // Each character is converted to its hex representation
  // and padded to two digits, separated by commas.
  // Example: "abc" -> "0x61, 0x62, 0x63"
  let hexArray = [];
  str = Buffer.from(str, "utf-8");
  for (let i = 0, k = str.length; i < k; i++) hexArray.push(str[i].toString());
  return hexArray.join(",");
}

async function createLibrarySources() {
  const { libraryFiles } = await import("../../assemblyscript/cli/index.generated.js");
  const librarySourceMapInc = [];
  const librarySourceInc = [];
  let cnt = 0;
  for (const fileName of Object.keys(libraryFiles)) {
    cnt++;
    const name = `library_source_${cnt}`;
    librarySourceInc.push(`uint8_t const ${name}[] = {${stringToHexCArray(libraryFiles[fileName])}};\n`);
    librarySourceMapInc.push(
      `{"${fileName}", std::string_view{reinterpret_cast<const char*>(${name}), sizeof(${name})}},\n`
    );
  }
  writeFileSync(join(target_folder, "library_sources.inc"), librarySourceInc.join(""));
  writeFileSync(join(target_folder, "library_sources_map.inc"), librarySourceMapInc.join(""));
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
  `
);

console.log(`AS wasm size: ${wasmBuf.length} bytes`);
