// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { spawn, type ChildProcess } from "node:child_process";
import { appendFileSync, writeFileSync } from "node:fs";
import * as path from "node:path";
import * as net from "node:net";
import { fileURLToPath } from "node:url";
import type { DebugPauseInfo, Debugger, DebuggerCommandCallbacks, WasmLaunchConfig } from "./debugger.js";
import { DebuggerWasmModule } from "./debuggerWasmModule.js";

const DIRNAME = path.dirname(fileURLToPath(import.meta.url));
const DEBUG_SERVER_TRACE_ENABLED = process.env.WARPO_DEBUG_SERVER_TRACE === "1";
const DEBUG_SERVER_TRACE_FILE = path.join(process.cwd(), ".warpo-debug-server-trace.log");

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

export class NodeDebugger implements Debugger {
  readonly name = "node";
  onModuleLoad: ((module: DebuggerWasmModule) => void | Promise<void>) | undefined;
  onPause: ((info: DebugPauseInfo) => void | Promise<void>) | undefined;

  private child: ChildProcess | undefined;
  private ws: WebSocket | undefined;
  private cdpId = 0;
  private readonly pendingCommandCallbacks = new Map<number, DebuggerCommandCallbacks>();
  private paused = false;
  private wasmFilePath: string | undefined;

  async launch(config: WasmLaunchConfig): Promise<void> {
    this.wasmFilePath = config.wasmFilePath;

    const port = await findFreePort();

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

    const wsUrl = await this.fetchWsUrl(port);
    await this.connectCDP(wsUrl);
  }

  dispose(): void {
    this.paused = false;
    this.wasmFilePath = undefined;
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
  }

  finishModuleLoad(): void {
    this.sendCommand("Runtime.runIfWaitingForDebugger");
  }

  setWasmBreakpoint(module: DebuggerWasmModule, bytecodeOffset: number, callbacks?: DebuggerCommandCallbacks): void {
    this.sendCommand(
      "Debugger.setBreakpointByUrl",
      {
        url: module.url,
        lineNumber: 0,
        columnNumber: bytecodeOffset,
      },
      {
        onSuccess: () => {
          trace(`setWasmBreakpoint success offset=${bytecodeOffset}`);
          callbacks?.onSuccess?.();
        },
        onError: (error) => {
          trace(`setWasmBreakpoint error offset=${bytecodeOffset} message=${error.message}`);
          callbacks?.onError?.(error);
        },
      }
    );
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
  private sendCommand(method: string, params?: Record<string, unknown>, callbacks?: DebuggerCommandCallbacks): void {
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

  private connectCDP(wsUrl: string): Promise<void> {
    return new Promise((resolve, reject) => {
      const ws = new WebSocket(wsUrl);
      this.ws = ws;

      ws.addEventListener("open", () => {
        void (async () => {
          try {
            trace("ws open -> Debugger.enable");
            await this.waitForCommand("Debugger.enable");
            trace("Debugger.enable -> Runtime.runIfWaitingForDebugger");
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
          trace(`Debugger.paused reason=${reason}`);
          void Promise.resolve(this.onPause?.({ reason })).catch((error: unknown) => {
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
            trace(`wasm module detected scriptId=${params.scriptId}`);
            void this.handleModuleLoad({
              scriptId: params.scriptId,
              url,
            }).catch((error: unknown) => {
              const message = error instanceof Error ? error.message : "unknown error";
              trace(`module load handler failed: ${message}`);
              process.stderr.write(`[node-debugger] module load handler failed: ${message}\n`);
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

    callbacks.onSuccess?.();
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

  private async handleModuleLoad(runtimeInfo: { scriptId: string; url: string }): Promise<void> {
    if (!this.wasmFilePath) {
      throw new Error("wasm file path is not available");
    }

    const module = await DebuggerWasmModule.load(this.wasmFilePath, runtimeInfo);
    void this.onModuleLoad?.(module);
  }
}
