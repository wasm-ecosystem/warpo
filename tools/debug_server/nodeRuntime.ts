// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { spawn, type ChildProcess } from "node:child_process";
import * as path from "node:path";
import * as net from "node:net";
import { fileURLToPath } from "node:url";
import type { Runtime, WasmLaunchConfig, WasmModuleInfo } from "./runtime.js";

const DIRNAME = path.dirname(fileURLToPath(import.meta.url));

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

interface CDPResponse {
  id?: number;
  method?: string;
  params?: Record<string, unknown>;
  result?: Record<string, unknown>;
}

export class NodeRuntime implements Runtime {
  readonly name = "node";
  onModuleLoad: ((info: WasmModuleInfo) => void) | undefined;

  private child: ChildProcess | undefined;
  private ws: WebSocket | undefined;
  private cdpId = 0;

  async launch(config: WasmLaunchConfig): Promise<void> {
    const port = await findFreePort();
    const entryScript = path.join(DIRNAME, "wasmEntry.js");

    this.child = spawn(
      process.execPath,
      [
        `--inspect-brk=${port}`,
        entryScript,
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
    this.ws?.close();
    this.child?.kill();
  }

  private async fetchWsUrl(port: number): Promise<string> {
    const resp = await fetch(`http://127.0.0.1:${port}/json`);
    const [info] = (await resp.json()) as { webSocketDebuggerUrl: string }[];
    return info.webSocketDebuggerUrl;
  }

  private connectCDP(wsUrl: string): Promise<void> {
    return new Promise((resolve, reject) => {
      const ws = new WebSocket(wsUrl);
      this.ws = ws;

      ws.addEventListener("open", () => {
        this.cdpSend("Debugger.enable");
        this.cdpSend("Runtime.runIfWaitingForDebugger");
        resolve();
      });

      ws.addEventListener("error", (e) => reject(e));

      ws.addEventListener("message", (ev) => {
        const msg: CDPResponse = JSON.parse(String(ev.data));
        if (msg.method === "Debugger.scriptParsed") {
          const lang = msg.params?.scriptLanguage as string | undefined;
          if (lang === "WebAssembly") {
            this.onModuleLoad?.({
              scriptId: msg.params!.scriptId as string,
              url: msg.params!.url as string,
            });
          }
        }
      };
    });
  }

  private cdpSend(method: string, params?: Record<string, unknown>): void {
    this.ws?.send(JSON.stringify({ id: ++this.cdpId, method, params }));
  }
}
