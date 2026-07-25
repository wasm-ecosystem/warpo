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
  wasmBytecodeOffset?: number;
}

export interface DebugRuntimeVariable {
  name: string;
  value: string;
  type?: string;
  localIndex: number;
}

export interface DebugPausedWasmFrame {
  functionName: string;
  variables: DebugRuntimeVariable[];
}

export interface Debugger {
  readonly name: string;

  launch(config: WasmLaunchConfig): Promise<void>;
  dispose(): void;
  isPaused(): boolean;
  pause(): void;
  resume(): Promise<void>;
  finishModuleLoad(): void;
  maybeGetPausedWasmFrame(): Promise<DebugPausedWasmFrame | undefined>;
  readWasmMemory(address: number, byteLength: number): Promise<Uint8Array | undefined>;
  setWasmBreakpoint(module: DebuggerWasmModule, wasmBytecodeOffset: number, callbacks?: DebuggerCommandCallbacks): void;

  onModuleLoad: ((module: DebuggerWasmModule) => void | Promise<void>) | undefined;
  onPause: ((info: DebugPauseInfo) => void | Promise<void>) | undefined;
  onRuntimeError: ((message: string) => void) | undefined;
  onRuntimeExit: (() => void) | undefined;
  onLog: ((message: string) => void) | undefined;
}
