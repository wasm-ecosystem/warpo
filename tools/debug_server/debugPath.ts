// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import * as path from "node:path";

export function normalizeDebugPath(filePath: string): string {
  if (filePath === "") {
    return "";
  }

  return path.resolve(filePath).replaceAll("\\", "/");
}
