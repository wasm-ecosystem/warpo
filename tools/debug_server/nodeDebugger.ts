// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { spawn, type ChildProcess } from "node:child_process";
import { appendFileSync, writeFileSync } from "node:fs";
import * as path from "node:path";
import * as net from "node:net";
import { fileURLToPath } from "node:url";
import type {
  DebugPauseInfo,
  Debugger,
  DebuggerCommandCallbacks,
  DebugPausedWasmFrame,
  DebugRuntimeVariable,
  WasmLaunchConfig,
} from "./debugger.js";
import { DebuggerWasmModule } from "./debuggerWasmModule.js";

const DIRNAME = path.dirname(fileURLToPath(import.meta.url));
const DEBUG_SERVER_TRACE_ENABLED = process.env.WARPO_DEBUG_SERVER_TRACE === "1";
const DEBUG_SERVER_TRACE_FILE = path.join(process.cwd(), ".warpo-debug-server-trace.log");
const LINEAR_MEMORY_OBJECT_GROUP = "warpo-linear-memory";

if (DEBUG_SERVER_TRACE_ENABLED) {
  try {
    writeFileSync(DEBUG_SERVER_TRACE_FILE, "");
  } catch {
    // Tracing should never block launching the runtime.
  }
}

function trace(message: string): void {
  if (DEBUG_SERVER_TRACE_ENABLED) {
    try {
      appendFileSync(DEBUG_SERVER_TRACE_FILE, `[node-debugger] ${message}\n`);
    } catch {
      // Tracing should never block launching the runtime.
    }
  }
}

const READ_WASM_MEMORY_FUNCTION = function (this: WebAssembly.Memory, address: number, byteLength: number) {
  if (
    !(this instanceof ArrayBuffer) &&
    !(typeof SharedArrayBuffer !== "undefined" && this instanceof SharedArrayBuffer)
  ) {
    return;
  }
  if (address < 0 || byteLength < 0 || address + byteLength > this.byteLength) {
    return;
  }
  return Array.from(new Uint8Array(this, address, byteLength));
}.toString();

const GET_WASM_MEMORY_BUFFER_FUNCTION = function (this: WebAssembly.Memory | ArrayBuffer | SharedArrayBuffer) {
  if (this instanceof ArrayBuffer || (typeof SharedArrayBuffer !== "undefined" && this instanceof SharedArrayBuffer)) {
    return this;
  }

  return (this as WebAssembly.Memory).buffer;
}.toString();

function findFreePort(): Promise<number> {
  return new Promise((resolve, reject) => {
    const srv = net.createServer();
    srv.listen(0, "127.0.0.1", () => {
      const addr = srv.address();
      if (addr && typeof addr === "object") {
        srv.close(() => resolve(addr.port));
      } else {
        srv.close(() => reject(new Error("Failed to obtain a free port")));
      }
    });
    srv.on("error", reject);
  });
}

function wait(ms: number): Promise<void> {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

interface CDPResponse {
  id?: number;
  method?: string;
  params?: Record<string, unknown>;
  result?: Record<string, unknown>;
  error?: { message?: string };
}

interface CDPCommandCallbacks {
  onSuccess?: (result?: Record<string, unknown>) => void;
  onError?: (error: Error) => void;
}

interface CDPLocation {
  scriptId: string;
  lineNumber: number;
  columnNumber: number;
}

interface CDPRemoteObject {
  type?: string;
  subtype?: string;
  className?: string;
  value?: unknown;
  unserializableValue?: string;
  description?: string;
  objectId?: string;
}

interface CDPScope {
  type: string;
  object: CDPRemoteObject;
}

interface CDPCallFrame {
  callFrameId: string;
  functionName: string;
  location: CDPLocation;
  scopeChain: CDPScope[];
}

interface CDPPropertyDescriptor {
  name: string;
  value?: CDPRemoteObject;
}

export class NodeDebugger implements Debugger {
  readonly name = "node";
  onModuleLoad: ((module: DebuggerWasmModule) => void | Promise<void>) | undefined;
  onPause: ((info: DebugPauseInfo) => void | Promise<void>) | undefined;
  onRuntimeError: ((message: string) => void) | undefined;

  private child: ChildProcess | undefined;
  private ws: WebSocket | undefined;
  private cdpId = 0;
  private readonly pendingCommandCallbacks = new Map<number, CDPCommandCallbacks>();
  private paused = false;
  private wasmFilePath: string | undefined;
  private wasmScriptId: string | undefined;
  private pausedCallFrame: CDPCallFrame | undefined;
  private wasmMemoryBufferObjectId: string | undefined;
  private stderrOutput = "";

  async launch(config: WasmLaunchConfig): Promise<void> {
    this.wasmFilePath = config.wasmFilePath;

    const port = await findFreePort();
    trace(
      `launch wasmFilePath=${config.wasmFilePath} entryFunctionName=${config.entryFunctionName} inspectPort=${port}`
    );

    this.child = spawn(
      process.execPath,
      [
        `--inspect=${port}`,
        path.join(DIRNAME, "wasmEntry.js"),
        config.wasmFilePath,
        config.entryFunctionName,
        ...config.args.map(String),
      ],
      { stdio: ["pipe", "pipe", "pipe"] }
    );
    this.child.stderr?.on("data", (chunk: Buffer) => {
      this.stderrOutput += filterRuntimeStderr(chunk.toString());
    });
    this.child.on("exit", (code) => {
      trace(`runtime exit code=${code ?? "null"}`);
      if (code && code !== 0) {
        this.onRuntimeError?.(this.stderrOutput.trim() || `Debug runtime exited with code ${code}`);
      }
    });

    const wsUrl = await this.fetchWsUrl(port);
    await this.connectCDP(wsUrl);
  }

  dispose(): void {
    this.paused = false;
    this.wasmFilePath = undefined;
    this.wasmScriptId = undefined;
    this.pausedCallFrame = undefined;
    this.wasmMemoryBufferObjectId = undefined;
    this.stderrOutput = "";
    this.ws?.close();
    this.child?.kill();
  }

  isPaused(): boolean {
    return this.paused;
  }

  pause(): void {
    this.sendCommand("Debugger.pause");
  }

  async resume(): Promise<void> {
    await this.waitForCommand("Debugger.resume");
    this.paused = false;
    this.pausedCallFrame = undefined;
    this.wasmMemoryBufferObjectId = undefined;
  }

  finishModuleLoad(): void {
    this.sendCommand("Runtime.runIfWaitingForDebugger");
  }

  setWasmBreakpoint(
    module: DebuggerWasmModule,
    wasmBytecodeOffset: number,
    callbacks?: DebuggerCommandCallbacks
  ): void {
    void (async () => {
      try {
        const location = this.resolveWasmBytecodeOffsetLocation(module, wasmBytecodeOffset);
        trace(`setWasmBreakpoint offset=${wasmBytecodeOffset} url=${module.url}`);
        await this.waitForCommandResult("Debugger.setBreakpointByUrl", {
          lineNumber: location.lineNumber,
          url: module.url,
          columnNumber: location.columnNumber,
          condition: "",
        });
        trace(`setWasmBreakpoint success offset=${wasmBytecodeOffset}`);
        callbacks?.onSuccess?.();
      } catch (error) {
        const commandError = error instanceof Error ? error : new Error(String(error));
        trace(`setWasmBreakpoint error offset=${wasmBytecodeOffset} message=${commandError.message}`);
        callbacks?.onError?.(commandError);
      }
    })();
  }

  private resolveWasmBytecodeOffsetLocation(module: DebuggerWasmModule, wasmBytecodeOffset: number): CDPLocation {
    if (!module.url) {
      throw new Error("Wasm script URL is not available");
    }

    return { scriptId: module.scriptId, lineNumber: 0, columnNumber: wasmBytecodeOffset };
  }

  private resolveWasmLocationBytecodeOffset(location: CDPLocation): number | undefined {
    if (location.lineNumber !== 0) {
      return undefined;
    }

    return location.columnNumber;
  }

  async maybeGetPausedWasmFrame(): Promise<DebugPausedWasmFrame | undefined> {
    const callFrame = this.pausedCallFrame;
    if (!callFrame) {
      return undefined;
    }

    const variables = await this.getLocalScopeVariables(callFrame);
    return {
      functionName: callFrame.functionName,
      variables,
    };
  }

  async readWasmMemory(address: number, byteLength: number): Promise<Uint8Array | undefined> {
    const memoryBufferObjectId = await this.getWasmMemoryBufferObjectId();
    if (!memoryBufferObjectId) {
      return undefined;
    }

    const result = await this.waitForCommandResult("Runtime.callFunctionOn", {
      objectId: memoryBufferObjectId,
      functionDeclaration: READ_WASM_MEMORY_FUNCTION,
      arguments: [{ value: address }, { value: byteLength }],
      silent: true,
      returnByValue: true,
    });
    const remoteObject = getRuntimeEvaluateRemoteObject(result);
    if (!Array.isArray(remoteObject?.value) || !remoteObject.value.every((value) => typeof value === "number")) {
      return undefined;
    }

    return Uint8Array.from(remoteObject.value);
  }

  private async fetchWsUrl(port: number): Promise<string> {
    const deadline = Date.now() + 5000;
    while (Date.now() < deadline) {
      try {
        const resp = await fetch(`http://127.0.0.1:${port}/json`);
        if (!resp.ok) {
          throw new Error(`inspector endpoint returned ${resp.status}`);
        }
        const [info] = (await resp.json()) as { webSocketDebuggerUrl: string }[];
        if (info?.webSocketDebuggerUrl) {
          return info.webSocketDebuggerUrl;
        }
      } catch {
        // The inspector endpoint is not always ready immediately after spawn.
      }
      await wait(50);
    }

    throw new Error(`timed out waiting for inspector endpoint on port ${port}`);
  }
  private sendCommand(method: string, params?: Record<string, unknown>, callbacks?: CDPCommandCallbacks): void {
    if (!this.ws) {
      throw new Error("debugger is not connected");
    }

    const id = ++this.cdpId;
    if (callbacks) {
      this.pendingCommandCallbacks.set(id, callbacks);
    }
    this.ws.send(JSON.stringify({ id, method, params }));
  }

  private waitForCommand(method: string, params?: Record<string, unknown>): Promise<void> {
    return new Promise((resolve, reject) => {
      this.sendCommand(method, params, {
        onSuccess: () => {
          resolve();
        },
        onError: (error) => {
          reject(error);
        },
      });
    });
  }

  private waitForCommandResult(method: string, params?: Record<string, unknown>): Promise<Record<string, unknown>> {
    return new Promise((resolve, reject) => {
      this.sendCommand(method, params, {
        onSuccess: (result) => {
          resolve(result ?? {});
        },
        onError: (error) => {
          reject(error);
        },
      });
    });
  }

  private connectCDP(wsUrl: string): Promise<void> {
    return new Promise((resolve, reject) => {
      const ws = new WebSocket(wsUrl);
      this.ws = ws;

      ws.addEventListener("open", () => {
        void (async () => {
          try {
            trace("ws open -> Debugger.enable");
            await this.waitForCommand("Debugger.enable");
            trace("Debugger.enable -> Debugger.setBreakpointsActive");
            await this.waitForCommand("Debugger.setBreakpointsActive", { active: true });
            trace("Debugger.setBreakpointsActive -> Runtime.runIfWaitingForDebugger");
            await this.waitForCommand("Runtime.runIfWaitingForDebugger");
            trace("Runtime.runIfWaitingForDebugger -> launch ready");
            resolve();
          } catch (error) {
            reject(error instanceof Error ? error : new Error(String(error)));
          }
        })();
      });

      ws.addEventListener("error", (e) => {
        const message = e instanceof Error ? e.message : "WebSocket connection failed";
        reject(new Error(message));
      });

      ws.addEventListener("message", (ev) => {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
        const msg: CDPResponse = JSON.parse(String(ev.data));
        if (typeof msg.id === "number") {
          this.handleCommandResponse(msg.id, msg);
          return;
        }

        if (msg.method === "Debugger.paused") {
          const reason = this.getPauseReason(msg.params);
          this.paused = true;
          this.pausedCallFrame = this.getPausedWasmCallFrame(msg.params);
          this.wasmMemoryBufferObjectId = undefined;
          trace(`Debugger.paused reason=${reason}`);
          void (async () => {
            const wasmBytecodeOffset = this.pausedCallFrame
              ? this.resolveWasmLocationBytecodeOffset(this.pausedCallFrame.location)
              : undefined;
            await this.onPause?.({ reason, wasmBytecodeOffset });
          })().catch((error: unknown) => {
            trace(`pause handler failed: ${error instanceof Error ? error.message : "unknown error"}`);
          });
          return;
        }
        if (msg.method === "Debugger.scriptParsed") {
          const params = msg.params;
          const lang = typeof params?.scriptLanguage === "string" ? params.scriptLanguage : "unknown";
          const url = typeof params?.url === "string" ? params.url : "";
          trace(`Debugger.scriptParsed language=${lang} url=${url}`);
          if (params && lang === "WebAssembly" && typeof params.scriptId === "string") {
            this.wasmScriptId = params.scriptId;
            trace(`wasm module detected scriptId=${params.scriptId}`);
            void this.handleModuleLoad({
              scriptId: params.scriptId,
              url,
            }).catch((error: unknown) => {
              const message = error instanceof Error ? error.message : "unknown error";
              trace(`module load handler failed: ${message}`);
              process.stderr.write(`Module load handler failed: ${message}\n`);
            });
          }
        }
      });
    });
  }

  private handleCommandResponse(id: number, msg: CDPResponse): void {
    const callbacks = this.pendingCommandCallbacks.get(id);
    if (!callbacks) {
      return;
    }

    this.pendingCommandCallbacks.delete(id);
    if (msg.error) {
      callbacks.onError?.(new Error(msg.error.message ?? "CDP command failed"));
      return;
    }

    callbacks.onSuccess?.(msg.result);
  }

  private getPauseReason(params?: Record<string, unknown>): string {
    if (Array.isArray(params?.hitBreakpoints) && params.hitBreakpoints.length > 0) {
      return "breakpoint";
    }

    if (typeof params?.reason === "string") {
      return params.reason;
    }

    return "unknown";
  }

  private getPausedWasmCallFrame(params?: Record<string, unknown>): CDPCallFrame | undefined {
    if (!Array.isArray(params?.callFrames)) {
      return undefined;
    }

    return params.callFrames[0] as CDPCallFrame | undefined;
  }

  private async getLocalScopeVariables(callFrame: CDPCallFrame): Promise<DebugRuntimeVariable[]> {
    const localScope = callFrame.scopeChain.find((scope) => scope.type === "local") ?? callFrame.scopeChain[0];
    const objectId = localScope?.object.objectId;
    if (!objectId) {
      return [];
    }

    const result = await this.waitForCommandResult("Runtime.getProperties", {
      objectId,
      ownProperties: true,
    });
    const properties = Array.isArray(result.result) ? result.result.filter(isCDPPropertyDescriptor) : [];
    const variables: DebugRuntimeVariable[] = [];
    for (const property of properties) {
      if (!property.value) {
        continue;
      }

      const localIndex = variables.length;

      variables.push({
        name: `local${localIndex}`,
        value: await this.readRemoteObjectValue(property.value),
        type: property.value.description ?? property.value.type,
        localIndex,
      });
    }
    return variables;
  }

  private async getWasmMemoryBufferObjectId(): Promise<string | undefined> {
    if (this.wasmMemoryBufferObjectId) {
      return this.wasmMemoryBufferObjectId;
    }

    const memoryObjectId = await this.getWasmMemoryObjectId();
    if (!memoryObjectId) {
      return undefined;
    }

    const bufferResult = await this.waitForCommandResult("Runtime.callFunctionOn", {
      objectId: memoryObjectId,
      functionDeclaration: GET_WASM_MEMORY_BUFFER_FUNCTION,
      silent: true,
      objectGroup: LINEAR_MEMORY_OBJECT_GROUP,
    });
    const bufferObject = getRuntimeEvaluateRemoteObject(bufferResult);
    this.wasmMemoryBufferObjectId = bufferObject?.objectId;
    return this.wasmMemoryBufferObjectId;
  }

  private async getWasmMemoryObjectId(): Promise<string | undefined> {
    const moduleScope = this.pausedCallFrame?.scopeChain.find((scope) => scope.type === "module");
    const objectId = moduleScope?.object.objectId;
    if (!objectId) {
      return undefined;
    }

    const result = await this.waitForCommandResult("Runtime.getProperties", {
      objectId,
      ownProperties: false,
    });
    const properties = Array.isArray(result.result) ? result.result.filter(isCDPPropertyDescriptor) : [];
    const memoriesProperty = properties.find((property) => property.name === "memories" && property.value?.objectId);
    if (!memoriesProperty?.value?.objectId) {
      return undefined;
    }

    const memoriesResult = await this.waitForCommandResult("Runtime.getProperties", {
      objectId: memoriesProperty.value.objectId,
      ownProperties: false,
    });
    const memories = Array.isArray(memoriesResult.result) ? memoriesResult.result.filter(isCDPPropertyDescriptor) : [];
    const nestedMemory = memories.find((property) => property.value && isWasmMemoryObject(property.value));
    return nestedMemory?.value?.objectId;
  }

  private async readRemoteObjectValue(value: CDPRemoteObject): Promise<string> {
    if (value.subtype !== "wasmvalue" || !value.objectId) {
      return formatRemoteObject(value);
    }

    const result = await this.waitForCommandResult("Runtime.getProperties", {
      objectId: value.objectId,
      ownProperties: true,
    });
    const innerProperties = Array.isArray(result.result) ? result.result.filter(isCDPPropertyDescriptor) : [];
    const valueProperty = innerProperties.find((property) => property.name === "value" || property.name === "0");
    return valueProperty?.value ? formatRemoteObject(valueProperty.value) : formatRemoteObject(value);
  }

  private async handleModuleLoad(runtimeInfo: { scriptId: string; url: string }): Promise<void> {
    if (!this.wasmFilePath) {
      throw new Error("wasm file path is not available");
    }

    const module = await DebuggerWasmModule.load(this.wasmFilePath, runtimeInfo);
    void this.onModuleLoad?.(module);
  }
}

function filterRuntimeStderr(text: string): string {
  return text
    .split(/(?<=\n)/)
    .filter((line) => {
      const trimmed = line.trim();
      return (
        trimmed !== "" &&
        !trimmed.startsWith("Debugger listening on") &&
        !trimmed.startsWith("For help, see:") &&
        trimmed !== "Debugger attached." &&
        trimmed !== "Waiting for the debugger to disconnect..."
      );
    })
    .join("");
}

function isCDPPropertyDescriptor(value: unknown): value is CDPPropertyDescriptor {
  if (!value || typeof value !== "object") {
    return false;
  }

  return typeof (value as Partial<CDPPropertyDescriptor>).name === "string";
}

function isWasmMemoryObject(value: CDPRemoteObject): boolean {
  return value.objectId !== undefined && value.subtype === "webassemblymemory";
}

function getRuntimeEvaluateRemoteObject(result: Record<string, unknown>): CDPRemoteObject | undefined {
  const remoteObject = result.result;
  if (!remoteObject || typeof remoteObject !== "object") {
    return undefined;
  }

  return remoteObject as CDPRemoteObject;
}

function formatRemoteObject(value: CDPRemoteObject): string {
  if (value.unserializableValue !== undefined) {
    return value.unserializableValue;
  }

  const rawValue = value.value;
  if (rawValue !== undefined) {
    if (rawValue === null) {
      return "null";
    }

    if (typeof rawValue === "object") {
      return value.description ?? value.type ?? "<unavailable>";
    }

    if (typeof rawValue === "string") {
      return rawValue;
    }

    if (typeof rawValue === "number" || typeof rawValue === "boolean" || typeof rawValue === "bigint") {
      return rawValue.toString();
    }

    return value.description ?? value.type ?? "<unavailable>";
  }

  return value.description ?? value.type ?? "<unavailable>";
}
