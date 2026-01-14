// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { readFileSync, writeFileSync } from "node:fs";
import { sep, join } from "node:path";
import { project_root, readAllFiles, stringToHexCArray } from "./helper.mjs";

const libs_path = join(project_root, "assemblyscript", "std", "assembly");
const ext_libs_path = join(project_root, "assemblyscript_extension", "std");

/**
 * @param {string} target_folder
 */
export function createLibrarySources(target_folder) {
  const libraryFiles = readAllFiles(libs_path)
    .filter((f) => f.endsWith(".ts") && !f.endsWith(".d.ts"))
    .map((p) => [p.slice(0, -3).replaceAll(sep, "/"), readFileSync(join(libs_path, p), "utf8")]);
  const librarySourceMapInc = [];
  const librarySourceInc = [];
  let cnt = 0;
  for (const [fileName, content] of libraryFiles) {
    cnt++;
    const name = `library_source_${cnt}`;
    librarySourceInc.push(`uint8_t const ${name}[] = {${stringToHexCArray(content)}};\n`);
    librarySourceMapInc.push(
      `{"${fileName}", std::string_view{reinterpret_cast<const char*>(${name}), sizeof(${name})}},\n`
    );
  }

  writeFileSync(join(target_folder, "library_sources.inc"), librarySourceInc.join(""));
  writeFileSync(join(target_folder, "library_sources_map.inc"), librarySourceMapInc.join(""));
}

/**
 * @param {string} target_folder
 */
export function createExtensionLibrarySources(target_folder) {
  const extLibraryFiles = readAllFiles(ext_libs_path)
    .filter((f) => f.endsWith(".ts"))
    .map((p) => [p.slice(0, -3).replaceAll(sep, "/"), readFileSync(join(ext_libs_path, p), "utf8")]);
  writeFileSync(
    join(target_folder, "extension_library_sources.inc"),
    extLibraryFiles.map(([fileName, content]) => `{\n  "${fileName}", R"##(${content})##",\n},\n`).join("")
  );
}
