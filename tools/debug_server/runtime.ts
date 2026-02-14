// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

export interface WasmLaunchConfig {
  wasmFilePath: string;
  entryFunctionName: string;
  args: number[];
}

export interface WasmModuleInfo {
  scriptId: string;
  url: string;
}

export interface Runtime {
  readonly name: string;

  launch(config: WasmLaunchConfig): Promise<void>;
  dispose(): void;

  onModuleLoad: ((info: WasmModuleInfo) => void) | undefined;
}
