// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { pathToFileURL } from "node:url";
import type { Config } from "./interface.js";

export type LoadedConfig = Partial<Config>;

export async function loadConfig(configPath: string): Promise<LoadedConfig> {
  const configModule = (await import(pathToFileURL(configPath).href)) as { default: LoadedConfig };
  return configModule.default;
}
