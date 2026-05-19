// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

/** Path delimiter inserted between file system levels. */
export const PATH_DELIMITER = "/";

/** Library directory prefix. */
export const LIBRARY_PREFIX = "~lib" + PATH_DELIMITER;

/** Mangles an external to an internal path. */
export function mangleInternalPath(path: string): string {
  if (path.endsWith("/")) {
    path += "index";
  } else if (path.endsWith(".ts")) {
    path = path.substring(0, path.length - 3);
  }
  return path;
}