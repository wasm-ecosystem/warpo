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
const NODE_WAITING_FOR_DEBUGGER_DISCONNECT = "Waiting for the debugger to disconnect...";

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

const READ_WASM_MEMORY_FUNCTION = function (
  this: WebAssembly.Memory | ArrayBuffer | SharedArrayBuffer,
  address: number,
  byteLength: number
) {
  const buffer =
    this instanceof ArrayBuffer || (typeof SharedArrayBuffer !== "undefined" && this instanceof SharedArrayBuffer)
      ? this
      : (this as WebAssembly.Memory).buffer;
  if (
    !(buffer instanceof ArrayBuffer) &&
    !(typeof SharedArrayBuffer !== "undefined" && buffer instanceof SharedArrayBuffer)
  ) {
    return;
  }
  if (address < 0 || byteLength < 0 || address + byteLength > buffer.byteLength) {
    return;
  }
  return Array.from(new Uint8Array(buffer, address, byteLength));
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
  onRuntimeExit: (() => void) | undefined;
  onLog: ((message: string) => void) | undefined;

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
  private disposed = false;
  private runtimeExitPromise: Promise<void> | undefined;

  private log(message: string): void {
    trace(message);
    this.onLog?.(`[${this.name}] ${message}`);
  }

  async launch(config: WasmLaunchConfig): Promise<void> {
    this.disposed = false;
    this.wasmFilePath = config.wasmFilePath;

    const port = await findFreePort();
    this.log(
      `launch wasmFilePath=${config.wasmFilePath} entryFunctionName=${config.entryFunctionName} inspectPort=${port}`
    );

    this.child = spawn(
      process.execPath,
      [
        `--inspect-brk=${port}`,
        path.join(DIRNAME, "wasmEntry.js"),
        config.wasmFilePath,
        config.entryFunctionName,
        ...config.args.map(String),
      ],
      { env: getRuntimeEnv(), stdio: ["pipe", "pipe", "pipe"] }
    );
    this.log(`runtime child spawned pid=${this.child.pid ?? "unknown"}`);
    this.runtimeExitPromise = new Promise((resolve) => {
      this.child?.once("exit", () => resolve());
      this.child?.once("error", () => resolve());
    });
    this.child.stdout?.on("data", (chunk: Buffer) => {
      const text = chunk.toString().trim();
      if (text) {
        this.log(`runtime stdout: ${text}`);
      }
    });
    this.child.stderr?.on("data", (chunk: Buffer) => {
      const stderr = parseRuntimeStderr(chunk.toString());
      this.stderrOutput += stderr.output;
      const text = stderr.output.trim();
      if (text) {
        this.log(`runtime stderr: ${text}`);
      }
      if (stderr.waitingForDebuggerDisconnect) {
        this.log("runtime waiting for debugger disconnect -> close websocket");
        this.ws?.close();
      }
    });
    this.child.on("error", (error) => {
      this.log(`runtime child error: ${error.message}`);
      this.onRuntimeError?.(error.message);
      this.onRuntimeExit?.();
    });
    this.child.on("exit", (code, signal) => {
      this.log(`runtime exit code=${code ?? "null"} signal=${signal ?? "null"}`);
      if (this.disposed) {
        return;
      }
      if (code && code !== 0) {
        this.onRuntimeError?.(this.stderrOutput.trim() || `Debug runtime exited with code ${code}`);
      }
      this.onRuntimeExit?.();
    });

    const wsUrl = await this.fetchWsUrl(port);
    this.log(`inspector websocket discovered: ${wsUrl}`);
    await Promise.race([this.connectCDP(wsUrl), this.runtimeExitPromise]);
  }

  dispose(): void {
    this.disposed = true;
    this.paused = false;
    this.wasmFilePath = undefined;
    this.wasmScriptId = undefined;
    this.pausedCallFrame = undefined;
    this.wasmMemoryBufferObjectId = undefined;
    this.stderrOutput = "";
    this.runtimeExitPromise = undefined;
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
    this.log("finishModuleLoad -> Runtime.runIfWaitingForDebugger");
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
        this.log(`setWasmBreakpoint offset=${wasmBytecodeOffset} url=${module.url}`);
        await this.waitForCommandResult("Debugger.setBreakpointByUrl", {
          lineNumber: location.lineNumber,
          url: module.url,
          columnNumber: location.columnNumber,
          condition: "",
        });
        this.log(`setWasmBreakpoint success offset=${wasmBytecodeOffset}`);
        callbacks?.onSuccess?.();
      } catch (error) {
        const commandError = error instanceof Error ? error : new Error(String(error));
        this.log(`setWasmBreakpoint error offset=${wasmBytecodeOffset} message=${commandError.message}`);
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
    this.log(`readWasmMemory address=${address} byteLength=${byteLength}`);
    const memoryBufferObjectId = await this.getWasmMemoryBufferObjectId();
    if (!memoryBufferObjectId) {
      this.log("readWasmMemory skipped: memory buffer unavailable");
      return undefined;
    }

    this.log("readWasmMemory -> Runtime.callFunctionOn");
    const result = await this.waitForCommandResult("Runtime.callFunctionOn", {
      objectId: memoryBufferObjectId,
      functionDeclaration: READ_WASM_MEMORY_FUNCTION,
      arguments: [{ value: address }, { value: byteLength }],
      silent: true,
      returnByValue: true,
    });
    const remoteObject = getRuntimeEvaluateRemoteObject(result);
    if (!Array.isArray(remoteObject?.value) || !remoteObject.value.every((value) => typeof value === "number")) {
      this.log("readWasmMemory failed: runtime returned non-byte-array value");
      return undefined;
    }

    this.log(`readWasmMemory success bytes=${remoteObject.value.length}`);
    return Uint8Array.from(remoteObject.value);
  }

  private async fetchWsUrl(port: number): Promise<string> {
    const deadline = Date.now() + 5000;
    this.log(`waiting for inspector endpoint on port ${port}`);
    while (Date.now() < deadline) {
      try {
        const resp = await fetch(`http://127.0.0.1:${port}/json`);
        if (!resp.ok) {
          throw new Error(`inspector endpoint returned ${resp.status}`);
        }
        const [info] = (await resp.json()) as { webSocketDebuggerUrl: string }[];
        if (info?.webSocketDebuggerUrl) {
          this.log(`inspector endpoint ready on port ${port}`);
          return info.webSocketDebuggerUrl;
        }
      } catch (error) {
        trace(`inspector endpoint not ready: ${error instanceof Error ? error.message : "unknown error"}`);
        // The inspector endpoint is not always ready immediately after spawn.
      }
      await wait(50);
    }

    throw new Error(`timed out waiting for inspector endpoint on port ${port}`);
  }
  private sendCommand(method: string, params?: Record<string, unknown>, callbacks?: CDPCommandCallbacks): number {
    if (!this.ws) {
      throw new Error("debugger is not connected");
    }

    const id = ++this.cdpId;
    if (callbacks) {
      this.pendingCommandCallbacks.set(id, callbacks);
    }
    this.log(`CDP -> ${method} id=${id}`);
    this.ws.send(JSON.stringify({ id, method, params }));
    return id;
  }

  private waitForCommand(method: string, params?: Record<string, unknown>): Promise<void> {
    return new Promise((resolve, reject) => {
      const id = this.sendCommand(method, params, {
        onSuccess: () => {
          this.log(`CDP command completed ${method} id=${id}`);
          resolve();
        },
        onError: (error) => {
          this.log(`CDP command failed ${method} id=${id}: ${error.message}`);
          reject(error);
        },
      });
    });
  }

  private waitForCommandResult(method: string, params?: Record<string, unknown>): Promise<Record<string, unknown>> {
    return new Promise((resolve, reject) => {
      const id = this.sendCommand(method, params, {
        onSuccess: (result) => {
          this.log(`CDP command completed ${method} id=${id}`);
          resolve(result ?? {});
        },
        onError: (error) => {
          this.log(`CDP command failed ${method} id=${id}: ${error.message}`);
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
            this.log("websocket open -> Runtime.enable");
            await this.waitForCommand("Runtime.enable");
            this.log("Runtime.enable complete -> Debugger.enable");
            await this.waitForCommand("Debugger.enable");
            this.log("Debugger.enable complete -> Runtime.runIfWaitingForDebugger");
            await this.waitForCommand("Runtime.runIfWaitingForDebugger");
            this.log("Runtime.runIfWaitingForDebugger complete -> Debugger.setBreakpointsActive");
            await this.waitForCommand("Debugger.setBreakpointsActive", { active: true });
            this.log("Debugger.setBreakpointsActive complete -> launch ready");
            resolve();
          } catch (error) {
            this.log(`CDP setup failed: ${error instanceof Error ? error.message : "unknown error"}`);
            reject(error instanceof Error ? error : new Error(String(error)));
          }
        })();
      });

      ws.addEventListener("error", (e) => {
        const message = e instanceof Error ? e.message : "WebSocket connection failed";
        this.log(`websocket error: ${message}`);
        reject(new Error(message));
      });

      ws.addEventListener("close", (event) => {
        this.log(`websocket close code=${event.code} reason=${event.reason || ""}`);
      });

      ws.addEventListener("message", (ev) => {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
        const msg: CDPResponse = JSON.parse(String(ev.data));
        this.handleCdpMessage(msg);
      });
    });
  }

  private handleCdpMessage(msg: CDPResponse): void {
    if (typeof msg.id === "number") {
      this.handleCommandResponse(msg.id, msg);
      return;
    }

    if (msg.method === "Debugger.paused") {
      this.handleDebuggerPaused(msg.params);
      return;
    }

    if (msg.method === "Debugger.scriptParsed") {
      this.handleScriptParsed(msg.params);
    }
  }

  private handleDebuggerPaused(params?: Record<string, unknown>): void {
    const reason = this.getPauseReason(params);
    if (reason === "Break on start" && !this.wasmScriptId) {
      this.log("Debugger.paused reason=Break on start location=inspect-brk startup");
      void this.resumeInternalStartupPause();
      return;
    }

    if (reason === "other" && this.wasmScriptId) {
      this.log("Debugger.paused reason=other location=wasm pre-entry gate");
      return;
    }

    this.paused = true;
    this.pausedCallFrame = this.getPausedWasmCallFrame(params);
    this.wasmMemoryBufferObjectId = undefined;
    this.log(`Debugger.paused reason=${reason}`);
    void this.notifyPause(reason);
  }

  private async notifyPause(reason: string): Promise<void> {
    try {
      const wasmBytecodeOffset = this.pausedCallFrame
        ? this.resolveWasmLocationBytecodeOffset(this.pausedCallFrame.location)
        : undefined;
      await this.onPause?.({ reason, wasmBytecodeOffset });
    } catch (error) {
      this.log(`pause handler failed: ${error instanceof Error ? error.message : "unknown error"}`);
    }
  }

  private handleScriptParsed(params?: Record<string, unknown>): void {
    const lang = typeof params?.scriptLanguage === "string" ? params.scriptLanguage : "unknown";
    const url = typeof params?.url === "string" ? params.url : "";
    this.log(`Debugger.scriptParsed language=${lang} url=${url}`);
    if (!params || lang !== "WebAssembly" || typeof params.scriptId !== "string") {
      return;
    }

    this.wasmScriptId = params.scriptId;
    this.log(`wasm module detected scriptId=${params.scriptId}`);
    void this.handleModuleLoad({
      scriptId: params.scriptId,
      url,
    }).catch((error: unknown) => {
      const message = error instanceof Error ? error.message : "unknown error";
      this.log(`module load handler failed: ${message}`);
      process.stderr.write(`Module load handler failed: ${message}\n`);
    });
  }

  private async resumeInternalStartupPause(): Promise<void> {
    try {
      await this.waitForCommand("Debugger.resume");
      this.paused = false;
      this.pausedCallFrame = undefined;
      this.wasmMemoryBufferObjectId = undefined;
      this.log("inspect-brk startup pause resumed");
    } catch (error) {
      this.log(
        `failed to resume inspect-brk startup pause: ${error instanceof Error ? error.message : "unknown error"}`
      );
    }
  }

  private handleCommandResponse(id: number, msg: CDPResponse): void {
    const callbacks = this.pendingCommandCallbacks.get(id);
    if (!callbacks) {
      return;
    }

    this.pendingCommandCallbacks.delete(id);
    if (msg.error) {
      this.log(`CDP <- error id=${id} message=${msg.error.message ?? "CDP command failed"}`);
      callbacks.onError?.(new Error(msg.error.message ?? "CDP command failed"));
      return;
    }

    this.log(`CDP <- success id=${id}`);
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

    this.log("getWasmMemoryBufferObjectId -> getWasmMemoryObjectId");
    const memoryObjectId = await this.getWasmMemoryObjectId();
    if (!memoryObjectId) {
      this.log("getWasmMemoryBufferObjectId failed: memory object unavailable");
      return undefined;
    }

    this.log("getWasmMemoryBufferObjectId -> Runtime.callFunctionOn buffer");
    const bufferResult = await this.waitForCommandResult("Runtime.callFunctionOn", {
      objectId: memoryObjectId,
      functionDeclaration: GET_WASM_MEMORY_BUFFER_FUNCTION,
      silent: true,
      objectGroup: LINEAR_MEMORY_OBJECT_GROUP,
    });
    const bufferObject = getRuntimeEvaluateRemoteObject(bufferResult);
    this.wasmMemoryBufferObjectId = bufferObject?.objectId;
    this.log(`getWasmMemoryBufferObjectId result=${this.wasmMemoryBufferObjectId ?? "undefined"}`);
    return this.wasmMemoryBufferObjectId;
  }

  private async getWasmMemoryObjectId(): Promise<string | undefined> {
    const moduleScope = this.pausedCallFrame?.scopeChain.find((scope) => scope.type === "module");
    const objectId = moduleScope?.object.objectId;
    if (!objectId) {
      return undefined;
    }

    this.log("getWasmMemoryObjectId -> Runtime.getProperties module scope");
    const result = await this.waitForCommandResult("Runtime.getProperties", {
      objectId,
      ownProperties: false,
    });
    const properties = Array.isArray(result.result) ? result.result.filter(isCDPPropertyDescriptor) : [];
    const memoriesProperty = properties.find((property) => property.name === "memories" && property.value?.objectId);
    if (!memoriesProperty?.value?.objectId) {
      return undefined;
    }

    this.log("getWasmMemoryObjectId -> Runtime.getProperties memories");
    const memoriesResult = await this.waitForCommandResult("Runtime.getProperties", {
      objectId: memoriesProperty.value.objectId,
      ownProperties: false,
    });
    const memories = Array.isArray(memoriesResult.result) ? memoriesResult.result.filter(isCDPPropertyDescriptor) : [];
    const nestedMemory = memories.find((property) => property.value && isWasmMemoryObject(property.value));
    this.log(`getWasmMemoryObjectId result=${nestedMemory?.value?.objectId ?? "undefined"}`);
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
    if (this.hasRuntimeExited()) {
      this.log("skip wasm module load because runtime already exited");
      return;
    }

    if (!this.wasmFilePath) {
      throw new Error("wasm file path is not available");
    }

    this.log(`loading wasm debug metadata from ${this.wasmFilePath}`);
    const module = await DebuggerWasmModule.load(this.wasmFilePath, runtimeInfo);
    this.log(`wasm debug metadata loaded from ${module.sourceMapFilePath}`);
    void this.onModuleLoad?.(module);
  }

  private hasRuntimeExited(): boolean {
    return this.child !== undefined && (this.child.exitCode !== null || this.child.signalCode !== null);
  }
}

function parseRuntimeStderr(text: string): { output: string; waitingForDebuggerDisconnect: boolean } {
  let waitingForDebuggerDisconnect = false;
  const output = text
    .split(/(?<=\n)/)
    .filter((line) => {
      const trimmed = line.trim();
      if (trimmed === NODE_WAITING_FOR_DEBUGGER_DISCONNECT) {
        waitingForDebuggerDisconnect = true;
        return false;
      }

      return (
        trimmed !== "" &&
        !trimmed.startsWith("Debugger listening on") &&
        !trimmed.startsWith("For help, see:") &&
        trimmed !== "Debugger attached."
      );
    })
    .join("");
  return { output, waitingForDebuggerDisconnect };
}

function getRuntimeEnv(): NodeJS.ProcessEnv {
  const env = { ...process.env };
  delete env.VSCODE_INSPECTOR_OPTIONS;

  const nodeOptions = filterAutoAttachNodeOptions(env.NODE_OPTIONS);
  if (nodeOptions) {
    env.NODE_OPTIONS = nodeOptions;
  } else {
    delete env.NODE_OPTIONS;
  }

  return env;
}

function filterAutoAttachNodeOptions(nodeOptions: string | undefined): string {
  if (!nodeOptions) {
    return "";
  }

  const parts = nodeOptions.split(/\s+/).filter(Boolean);
  const filtered: string[] = [];
  for (let i = 0; i < parts.length; i++) {
    const part = parts[i];
    const next = parts[i + 1];
    if ((part === "--require" || part === "-r") && next && isVsCodeJsDebugBootloader(next)) {
      i++;
      continue;
    }
    if ((part.startsWith("--require=") || part.startsWith("-r=")) && isVsCodeJsDebugBootloader(part)) {
      continue;
    }
    filtered.push(part);
  }

  return filtered.join(" ");
}

function isVsCodeJsDebugBootloader(value: string): boolean {
  return value.includes("js-debug") || value.includes("vscode-js-debug");
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
