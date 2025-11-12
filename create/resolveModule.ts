// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import * as api from "./__warpo_create";

export class ModuleResolve {
  packageName!: string;
  private packagePath: string | null = null;
  setPackagePath(packagePath: string): void {
    this.packagePath = packagePath;
  }
}

export type Fn = (task: ModuleResolve) => void;
export function onModuleResolve(fn: Fn): void {
  api.onModuleResolve(fn.index, idof<ModuleResolve>());
}
