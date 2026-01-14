// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { join, relative } from "node:path";
import { readdirSync } from "node:fs";

export const project_root = join("..", "..");

function readAllFilesImpl(dir, root, output) {
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    const fullPath = join(dir, entry.name);
    if (entry.isDirectory()) {
      readAllFilesImpl(fullPath, root, output);
    } else if (entry.isFile()) {
      output.push(relative(root, fullPath));
    }
  }
}

/**
 *
 * @param {string} dir
 * @returns {string[]}
 */
export function readAllFiles(dir) {
  const output = [];
  readAllFilesImpl(dir, dir, output);
  return output;
}

export function stringToHexCArray(str) {
  // Convert a string to a C-style hex array
  // Each character is converted to its hex representation
  // and padded to two digits, separated by commas.
  // Example: "abc" -> "0x61, 0x62, 0x63"
  let hexArray = [];
  str = Buffer.from(str, "utf-8");
  for (let i = 0, k = str.length; i < k; i++) hexArray.push(str[i].toString());
  return hexArray.join(",");
}
