// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { LoggingDebugSession, InitializedEvent, Thread, Breakpoint, logger } from "@vscode/debugadapter";
import type { DebugProtocol } from "@vscode/debugprotocol";
import * as path from "node:path";
import type { Runtime } from "./runtime.js";
import { NodeRuntime } from "./nodeRuntime.js";

interface WarpoLaunchRequestArguments extends DebugProtocol.LaunchRequestArguments {
  program: string;
  launchType?: string;
  runtime?: string;
  entryFunctionName?: string;
  args?: number[];
}

interface BreakpointInfo {
  id: number;
  line: number;
  verified: boolean;
  source: string;
}

export class WarpoDebugSession extends LoggingDebugSession {
  private static threadId = 1;
  private breakpointId = 0;
  private breakpoints = new Map<string, BreakpointInfo[]>();
  private runtime: Runtime | undefined;

  private log(msg: string): void {
    logger.log(msg);
  }

  protected initializeRequest(
    response: DebugProtocol.InitializeResponse,
    _args: DebugProtocol.InitializeRequestArguments
  ): void {
    response.body = response.body || {};
    response.body.supportsConfigurationDoneRequest = true;
    response.body.supportsSetVariable = false;
    response.body.supportsBreakpointLocationsRequest = false;

    this.sendResponse(response);
    this.sendEvent(new InitializedEvent());
  }

  protected setBreakPointsRequest(
    response: DebugProtocol.SetBreakpointsResponse,
    args: DebugProtocol.SetBreakpointsArguments
  ): void {
    const sourcePath = args.source.path || "";
    const clientLines = args.breakpoints || [];

    const bps: BreakpointInfo[] = clientLines.map((bp) => {
      const id = ++this.breakpointId;
      const info: BreakpointInfo = {
        id,
        line: bp.line,
        verified: true,
        source: sourcePath,
      };
      this.log(`Breakpoint set: ${path.basename(sourcePath)}:${bp.line}`);
      return info;
    });

    this.breakpoints.set(sourcePath, bps);

    const breakpoints: DebugProtocol.Breakpoint[] = bps.map((bp) => {
      const dbp = new Breakpoint(bp.verified, bp.line) as DebugProtocol.Breakpoint;
      dbp.id = bp.id;
      return dbp;
    });

    response.body = { breakpoints };
    this.sendResponse(response);
  }

  protected configurationDoneRequest(
    response: DebugProtocol.ConfigurationDoneResponse,
    _args: DebugProtocol.ConfigurationDoneArguments
  ): void {
    super.configurationDoneRequest(response, _args);
    this.logAllBreakpoints();
  }

  protected async launchRequest(response: DebugProtocol.LaunchResponse, args: WarpoLaunchRequestArguments): Promise<void> {
    this.log(`Launch requested for: ${args.program}`);

    const launchType = args.launchType ?? "wasm file";
    if (launchType === "wasm file") {
      const runtimeName = args.runtime ?? "node";
      let runtime: Runtime;
      switch (runtimeName) {
        case "node":
          runtime = new NodeRuntime();
          break;
        default:
          this.sendErrorResponse(response, 1, `Unknown runtime "${runtimeName}"`);
          return;
      }

      runtime.onModuleLoad = (info) => {
        this.log(`Wasm module loaded: ${info.url} (scriptId: ${info.scriptId})`);
      };

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
  }

  protected threadsRequest(response: DebugProtocol.ThreadsResponse): void {
    response.body = {
      threads: [new Thread(WarpoDebugSession.threadId, "main")],
    };
    this.sendResponse(response);
  }

  protected disconnectRequest(
    response: DebugProtocol.DisconnectResponse,
    _args: DebugProtocol.DisconnectArguments
  ): void {
    this.runtime?.dispose();
    this.runtime = undefined;
    this.log("Debug session ended.");
    this.sendResponse(response);
  }

  private logAllBreakpoints(): void {
    this.log("=== Registered Breakpoints ===");
    for (const [source, bps] of this.breakpoints) {
      for (const bp of bps) {
        this.log(`  ${path.basename(source)}:${bp.line} (id=${bp.id}, verified=${bp.verified})`);
      }
    }
    this.log("==============================");
  }
}
