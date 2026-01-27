// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { readFileSync, writeFileSync } from "node:fs";
import { sep, join } from "node:path";
import { project_root, readAllFiles, stringToHexCArray } from "./helper.mjs";

const libs_path = join(project_root, "assemblyscript", "std", "assembly");
const ext_libs_path = join(project_root, "warpo_extension", "std");

function emitSources({ files, targetFolder, incName, mapIncName, symbolPrefix }) {
  const sourceMapInc = [];
  const sourceInc = [];
  let cnt = 0;
  for (const [fileName, content] of files) {
    cnt++;
    const name = `${symbolPrefix}_${cnt}`;
    sourceInc.push(`uint8_t const ${name}[] = {${stringToHexCArray(content)}};\n`);
    sourceMapInc.push(`{"${fileName}", std::string_view{reinterpret_cast<const char*>(${name}), sizeof(${name})}},\n`);
  }

  writeFileSync(join(targetFolder, incName), sourceInc.join(""));
  writeFileSync(join(targetFolder, mapIncName), sourceMapInc.join(""));
}

/**
 * @param {string} target_folder
 */
export function createLibrarySources(target_folder) {
  const libraryFiles = readAllFiles(libs_path)
    .filter((f) => f.endsWith(".ts") && !f.endsWith(".d.ts"))
    .map((p) => [p.slice(0, -3).replaceAll(sep, "/"), readFileSync(join(libs_path, p), "utf8")]);
  emitSources({
    files: libraryFiles,
    targetFolder: target_folder,
    incName: "library_sources.inc",
    mapIncName: "library_sources_map.inc",
    symbolPrefix: "library_source",
  });
}

/**
 * @param {string} target_folder
 */
export function createExtensionLibrarySources(target_folder) {
  const extLibraryFiles = readAllFiles(ext_libs_path)
    .filter((f) => f.endsWith(".ts") && !f.endsWith(".d.ts"))
    .map((p) => [p.slice(0, -3).replaceAll(sep, "/"), readFileSync(join(ext_libs_path, p), "utf8")]);
  emitSources({
    files: extLibraryFiles,
    targetFolder: target_folder,
    incName: "extension_library_sources.inc",
    mapIncName: "extension_library_sources_map.inc",
    symbolPrefix: "extension_library_source",
  });
}
