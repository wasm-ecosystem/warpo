// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import type { DebuggerWasmModule } from "./debuggerWasmModule.js";

export interface DebuggerCommandCallbacks {
  onSuccess?: () => void;
  onError?: (error: Error) => void;
}

export interface WasmLaunchConfig {
  wasmFilePath: string;
  entryFunctionName: string;
  args: number[];
}

export interface DebugPauseInfo {
  reason: string;
}

export interface Debugger {
  readonly name: string;

  launch(config: WasmLaunchConfig): Promise<void>;
  dispose(): void;
  isPaused(): boolean;
  pause(): void;
  resume(): Promise<void>;
  finishModuleLoad(): void;
  setWasmBreakpoint(module: DebuggerWasmModule, bytecodeOffset: number, callbacks?: DebuggerCommandCallbacks): void;

  onModuleLoad: ((module: DebuggerWasmModule) => void | Promise<void>) | undefined;
  onPause: ((info: DebugPauseInfo) => void | Promise<void>) | undefined;
}
