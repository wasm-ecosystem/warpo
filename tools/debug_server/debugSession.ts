// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import {
  LoggingDebugSession,
  InitializedEvent,
  Thread,
  Breakpoint,
  LoadedSourceEvent,
  StoppedEvent,
  ContinuedEvent,
  logger,
} from "@vscode/debugadapter";
import type { DebugProtocol } from "@vscode/debugprotocol";
import * as path from "node:path";
import type { DebuggerBreakpointInfo, DebuggerWasmModule } from "./debuggerWasmModule.js";
import type { DebugPauseInfo, Debugger } from "./debugger.js";
import { NodeDebugger } from "./nodeDebugger.js";

interface WarpoLaunchRequestArguments extends DebugProtocol.LaunchRequestArguments {
  program: string;
  launchType?: string;
  runtime?: string;
  entryFunctionName?: string;
  args?: number[];
}

export class WarpoDebugSession extends LoggingDebugSession {
  private static threadId = 1;
  private breakpointId = 0;
  private requestedBreakpointsBySource = new Map<string, DebuggerBreakpointInfo[]>();
  private pendingBreakpointUpdatesBySource = new Map<string, DebuggerBreakpointInfo[]>();
  private loadedModule: DebuggerWasmModule | undefined;
  private runtime: Debugger | undefined;

  private log(msg: string): void {
    logger.log(msg);
  }

  private normalizeSourcePath(filePath: string): string {
    if (filePath === "") {
      return "";
    }

    return path.resolve(filePath).replaceAll("\\", "/");
  }

  private sendStoppedEvent(runtime: Debugger, info: DebugPauseInfo): void {
    this.log(`[${runtime.name}] Paused: ${info.reason}`);
    const reason = info.reason === "breakpoint" ? "breakpoint" : "pause";
    this.sendEvent(new StoppedEvent(reason, WarpoDebugSession.threadId, info.reason));
  }

  private handleRuntimePause(runtime: Debugger, info: DebugPauseInfo): void {
    this.applyPendingBreakpointUpdates(runtime, () => {
      if (info.reason === "other") {
        void runtime.resume().catch((error: unknown) => {
          const message = error instanceof Error ? error.message : "unknown error";
          this.log(`Failed to resume after breakpoint update: ${message}`);
        });
        return;
      }

      this.sendStoppedEvent(runtime, info);
    });
  }

  protected initializeRequest(
    response: DebugProtocol.InitializeResponse,
    _args: DebugProtocol.InitializeRequestArguments
  ): void {
    response.body = response.body || {};
    response.body.supportsConfigurationDoneRequest = true;
    response.body.supportsSetVariable = false;
    response.body.supportsBreakpointLocationsRequest = false;
    response.body.supportsLoadedSourcesRequest = true;

    this.sendResponse(response);
    this.sendEvent(new InitializedEvent());
  }

  protected setBreakPointsRequest(
    response: DebugProtocol.SetBreakpointsResponse,
    args: DebugProtocol.SetBreakpointsArguments
  ): void {
    const sourcePath = this.normalizeSourcePath(args.source.path || "");
    const clientLines = args.breakpoints || [];

    const bps: DebuggerBreakpointInfo[] = clientLines.map((bp) => {
      const id = ++this.breakpointId;
      const info: DebuggerBreakpointInfo = {
        id,
        line: bp.line,
        verified: true,
        source: sourcePath,
      };
      this.log(`Breakpoint set: ${path.basename(sourcePath)}:${bp.line}`);
      return info;
    });

    this.requestedBreakpointsBySource.set(sourcePath, bps);
    this.pendingBreakpointUpdatesBySource.set(sourcePath, [...bps]);

    const breakpoints: DebugProtocol.Breakpoint[] = bps.map((bp) => {
      const dbp = new Breakpoint(bp.verified, bp.line) as DebugProtocol.Breakpoint;
      dbp.id = bp.id;
      return dbp;
    });

    response.body = { breakpoints };
    this.sendResponse(response);

    this.requestBreakpointUpdate();
  }

  protected configurationDoneRequest(
    response: DebugProtocol.ConfigurationDoneResponse,
    _args: DebugProtocol.ConfigurationDoneArguments
  ): void {
    super.configurationDoneRequest(response, _args);
    this.logAllBreakpoints();
  }

  protected launchRequest(response: DebugProtocol.LaunchResponse, args: WarpoLaunchRequestArguments): void {
    void this.doLaunchRequest(response, args);
  }

  private async doLaunchRequest(
    response: DebugProtocol.LaunchResponse,
    args: WarpoLaunchRequestArguments
  ): Promise<void> {
    try {
      this.log(`Launch requested for: ${args.program}`);

      const launchType = args.launchType ?? "wasm file";
      if (launchType === "wasm file") {
        const runtimeName = args.runtime ?? "node";
        let runtime: Debugger;
        if (runtimeName === "node") {
          runtime = new NodeDebugger();
        } else {
          this.sendErrorResponse(response, 1, `Unknown runtime "${runtimeName}"`);
          return;
        }

        runtime.onModuleLoad = (module) => {
          this.loadedModule = module;
          this.log(
            `Wasm module loaded: ${module.wasmFilePath} (reported as ${module.url}, scriptId: ${module.scriptId})`
          );
          this.sendEvent(
            new LoadedSourceEvent("new", {
              name: path.basename(module.wasmFilePath),
              path: module.wasmFilePath,
            })
          );
          this.sendEvent(
            new LoadedSourceEvent("new", {
              name: path.basename(module.sourceMapFilePath),
              path: module.sourceMapFilePath,
            })
          );

          this.applyPendingBreakpointUpdates(runtime, () => {
            runtime.finishModuleLoad();
          });
        };
        runtime.onPause = (info) => {
          this.handleRuntimePause(runtime, info);
        };

        this.disposeLoadedModule();
        this.runtime?.dispose();
        this.runtime = runtime;
        await runtime.launch({
          wasmFilePath: path.resolve(args.program),
          entryFunctionName: args.entryFunctionName ?? "main",
          args: args.args ?? [],
        });

        this.log(`[${runtime.name}] Runtime launched`);
      }

      this.sendResponse(response);
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      this.sendErrorResponse(response, 1, `Launch failed: ${message}`);
    }
  }

  protected threadsRequest(response: DebugProtocol.ThreadsResponse): void {
    response.body = {
      threads: [new Thread(WarpoDebugSession.threadId, "main")],
    };
    this.sendResponse(response);
  }

  protected continueRequest(response: DebugProtocol.ContinueResponse, _args: DebugProtocol.ContinueArguments): void {
    void this.doContinueRequest(response);
  }

  protected disconnectRequest(
    response: DebugProtocol.DisconnectResponse,
    _args: DebugProtocol.DisconnectArguments
  ): void {
    this.disposeLoadedModule();
    this.runtime?.dispose();
    this.runtime = undefined;
    this.log("Debug session ended.");
    this.sendResponse(response);
  }

  private async doContinueRequest(response: DebugProtocol.ContinueResponse): Promise<void> {
    if (!this.runtime) {
      this.sendErrorResponse(response, 1, "No active runtime");
      return;
    }

    try {
      await this.runtime.resume();
      response.body = { allThreadsContinued: true };
      this.sendResponse(response);
      this.sendEvent(new ContinuedEvent(WarpoDebugSession.threadId, true));
    } catch (error) {
      const message = error instanceof Error ? error.message : String(error);
      this.sendErrorResponse(response, 1, `Continue failed: ${message}`);
    }
  }

  private logAllBreakpoints(): void {
    this.log("=== Registered Breakpoints ===");
    for (const [source, bps] of this.requestedBreakpointsBySource) {
      for (const bp of bps) {
        this.log(`  ${path.basename(source)}:${bp.line} (id=${bp.id}, verified=${bp.verified})`);
      }
    }
    this.log("==============================");
  }

  private requestBreakpointUpdate(): void {
    if (!this.runtime || !this.loadedModule || this.pendingBreakpointUpdatesBySource.size === 0) {
      return;
    }

    if (this.runtime.isPaused()) {
      this.applyPendingBreakpointUpdates(this.runtime);
      return;
    }

    for (const sourcePath of this.pendingBreakpointUpdatesBySource.keys()) {
      if (this.loadedModule.hasSource(sourcePath)) {
        this.runtime.pause();
        return;
      }
    }
  }

  private applyPendingBreakpointUpdates(runtime: Debugger, onComplete?: () => void): void {
    const module = this.loadedModule;
    if (!module) {
      onComplete?.();
      return;
    }

    for (const [sourcePath, breakpoints] of this.pendingBreakpointUpdatesBySource) {
      if (breakpoints.length === 0) {
        this.pendingBreakpointUpdatesBySource.delete(sourcePath);
        continue;
      }

      if (!module.hasSource(sourcePath)) {
        continue;
      }

      const breakpoint = breakpoints.shift();
      if (!breakpoint) {
        this.pendingBreakpointUpdatesBySource.delete(sourcePath);
        continue;
      }

      if (breakpoints.length === 0) {
        this.pendingBreakpointUpdatesBySource.delete(sourcePath);
      }

      const bytecodeOffset = module.findBytecodeOffset(breakpoint.source, breakpoint.line);
      if (bytecodeOffset === undefined) {
        this.log(`No source-map match for breakpoint ${path.basename(breakpoint.source)}:${breakpoint.line}`);
        this.applyPendingBreakpointUpdates(runtime, onComplete);
        return;
      }

      this.log(
        `Resolved breakpoint ${path.basename(breakpoint.source)}:${breakpoint.line} -> bytecode offset ${bytecodeOffset}`
      );
      runtime.setWasmBreakpoint(module, bytecodeOffset, {
        onSuccess: () => {
          this.applyPendingBreakpointUpdates(runtime, onComplete);
        },
        onError: (error: Error) => {
          this.log(`Failed to set breakpoint ${path.basename(breakpoint.source)}:${breakpoint.line}: ${error.message}`);
          this.applyPendingBreakpointUpdates(runtime, onComplete);
        },
      });
      return;
    }

    onComplete?.();
  }

  private disposeLoadedModule(): void {
    this.loadedModule?.dispose();
    this.loadedModule = undefined;
    this.pendingBreakpointUpdatesBySource.clear();
  }
}
