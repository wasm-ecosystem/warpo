// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import {
  LoggingDebugSession,
  InitializedEvent,
  Thread,
  Breakpoint,
  Source,
  Scope,
  StackFrame,
  LoadedSourceEvent,
  OutputEvent,
  StoppedEvent,
  ContinuedEvent,
  TerminatedEvent,
  logger,
} from "@vscode/debugadapter";
import type { DebugProtocol } from "@vscode/debugprotocol";
import assert from "node:assert/strict";
import * as path from "node:path";
import type { ClassField, ClassLayout } from "../dwarf/classDebugInfo.js";
import { OBJECT_RTID_OFFSET, OBJECT_RTID_SIZE } from "../runtime/objectLayout.js";
import { normalizeDebugPath } from "./debugPath.js";
import type { DebuggerBreakpointInfo, DebuggerWasmModule } from "./debuggerWasmModule.js";
import type { DebugPauseInfo, Debugger, DebugRuntimeVariable } from "./debugger.js";
import { NodeDebugger } from "./nodeDebugger.js";

interface WarpoLaunchRequestArguments extends DebugProtocol.LaunchRequestArguments {
  program: string;
  launchType?: string;
  runtime?: string;
  entryFunctionName?: string;
  debugSessionLogging?: boolean;
  args?: number[];
}

interface BasicVariable {
  kind: "basic";
  name: string;
  value: string;
  typeName: string | undefined;
}

interface ClassVariable {
  kind: "class";
  name: string;
  typeName: string;
  address: number;
}

type DebugSessionVariable = BasicVariable | ClassVariable;

type VariableContainer = { kind: "locals" } | { kind: "object"; address: number };

function formatUnknownError(error: unknown): string {
  if (error instanceof Error) {
    return error.message;
  }

  if (typeof error === "string") {
    return error;
  }

  return "unknown error";
}

export class WarpoDebugSession extends LoggingDebugSession {
  private static threadId = 1;
  private breakpointId = 0;
  private requestedBreakpointsBySource = new Map<string, DebuggerBreakpointInfo[]>();
  private pendingBreakpointUpdatesBySource = new Map<string, DebuggerBreakpointInfo[]>();
  private variableContainers = new Map<number, VariableContainer>();
  private nextVariablesReference = 1;
  private loadedModule: DebuggerWasmModule | undefined;
  private runtime: Debugger | undefined;
  private stoppedWasmBytecodeOffset: number | undefined;
  private debugSessionLogging = false;

  private log(msg: string): void {
    logger.log(msg);
    if (this.debugSessionLogging) {
      this.sendEvent(new OutputEvent(`${msg}\n`, "stdout"));
    }
  }

  private sendStoppedEvent(runtime: Debugger, info: DebugPauseInfo): void {
    this.log(`[${runtime.name}] Paused: ${info.reason}`);
    this.clearVariableContainers();
    const reason = info.reason === "breakpoint" ? "breakpoint" : "pause";
    this.sendEvent(new StoppedEvent(reason, WarpoDebugSession.threadId, info.reason));
  }

  private handleRuntimePause(runtime: Debugger, info: DebugPauseInfo): void {
    this.stoppedWasmBytecodeOffset = info.wasmBytecodeOffset;
    if (info.reason === "other" && !this.loadedModule) {
      return;
    }

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
    response.body.supportsEvaluateForHovers = false;

    this.sendResponse(response);
    this.sendEvent(new InitializedEvent());
  }

  protected setBreakPointsRequest(
    response: DebugProtocol.SetBreakpointsResponse,
    args: DebugProtocol.SetBreakpointsArguments
  ): void {
    const sourcePath = normalizeDebugPath(args.source.path || "");
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
      this.debugSessionLogging = args.debugSessionLogging ?? false;
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

        runtime.onModuleLoad = (wasmModule) => {
          this.loadedModule = wasmModule;
          this.log(
            `Wasm module loaded: ${wasmModule.wasmFilePath} (reported as ${wasmModule.url}, scriptId: ${wasmModule.scriptId})`
          );
          this.sendEvent(
            new LoadedSourceEvent("new", {
              name: path.basename(wasmModule.wasmFilePath),
              path: wasmModule.wasmFilePath,
            })
          );
          this.sendEvent(
            new LoadedSourceEvent("new", {
              name: path.basename(wasmModule.sourceMapFilePath),
              path: wasmModule.sourceMapFilePath,
            })
          );

          this.applyPendingBreakpointUpdates(runtime, () => {
            if (runtime.isPaused()) {
              void runtime.resume().catch((error: unknown) => {
                const message = error instanceof Error ? error.message : "unknown error";
                this.log(`Failed to resume after module load: ${message}`);
              });
              return;
            }

            runtime.finishModuleLoad();
          });
        };
        runtime.onPause = (info) => {
          this.handleRuntimePause(runtime, info);
        };
        runtime.onRuntimeError = (message) => {
          this.sendEvent(new OutputEvent(`${message}\n`, "stderr"));
        };
        runtime.onRuntimeExit = () => {
          this.handleRuntimeExit(runtime);
        };
        runtime.onLog = (message) => {
          this.log(message);
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

  protected stackTraceRequest(
    response: DebugProtocol.StackTraceResponse,
    _args: DebugProtocol.StackTraceArguments
  ): void {
    void this.doStackTraceRequest(response);
  }

  protected scopesRequest(response: DebugProtocol.ScopesResponse, _args: DebugProtocol.ScopesArguments): void {
    this.doScopesRequest(response);
  }

  protected variablesRequest(response: DebugProtocol.VariablesResponse, args: DebugProtocol.VariablesArguments): void {
    void this.doVariablesRequest(response, args).catch((error: unknown) => {
      const message = formatUnknownError(error);
      this.log(`Variables request failed: ${message}`);
      this.sendErrorResponse(response, 1, `Variables request failed: ${message}`);
    });
  }

  protected continueRequest(response: DebugProtocol.ContinueResponse, _args: DebugProtocol.ContinueArguments): void {
    this.doContinueRequest(response);
  }

  protected disconnectRequest(
    response: DebugProtocol.DisconnectResponse,
    _args: DebugProtocol.DisconnectArguments
  ): void {
    this.disposeLoadedModule();
    this.pendingBreakpointUpdatesBySource.clear();
    this.stoppedWasmBytecodeOffset = undefined;
    this.runtime?.dispose();
    this.runtime = undefined;
    this.debugSessionLogging = false;
    this.log("Debug session ended.");
    this.sendResponse(response);
  }

  private async doStackTraceRequest(response: DebugProtocol.StackTraceResponse): Promise<void> {
    const frame = await this.runtime?.maybeGetPausedWasmFrame();
    const frameName = frame?.functionName || "wasm";
    const sourceLocation = this.resolveStoppedSourceLocation();
    const source = sourceLocation
      ? new Source(path.basename(sourceLocation.sourcePath), sourceLocation.sourcePath)
      : undefined;
    response.body = {
      stackFrames: [new StackFrame(1, frameName, source, sourceLocation?.sourceLine ?? 0, 1)],
      totalFrames: 1,
    };
    this.sendResponse(response);
  }

  private resolveStoppedSourceLocation(): { sourcePath: string; sourceLine: number } | undefined {
    const wasmModule = this.loadedModule;
    const wasmBytecodeOffset = this.stoppedWasmBytecodeOffset;
    if (!wasmModule || wasmBytecodeOffset === undefined) {
      return undefined;
    }

    return wasmModule.resolveSourceLocation(wasmBytecodeOffset);
  }

  private doScopesRequest(response: DebugProtocol.ScopesResponse): void {
    response.body = {
      scopes: [new Scope("Locals", this.createVariableContainer({ kind: "locals" }), false)],
    };
    this.sendResponse(response);
  }

  private async doVariablesRequest(
    response: DebugProtocol.VariablesResponse,
    args: DebugProtocol.VariablesArguments
  ): Promise<void> {
    const variableContainer = this.variableContainers.get(args.variablesReference);

    switch (variableContainer?.kind) {
      case "locals": {
        response.body = { variables: await this.listLocalVariables() };
        break;
      }
      case "object": {
        response.body = { variables: await this.decodeObjectAtAddress(variableContainer.address) };
        break;
      }
      default: {
        this.log(`Warning: unknown variables reference ${args.variablesReference}`);
        response.body = { variables: [] };
        break;
      }
    }

    this.sendResponse(response);
  }

  private async listLocalVariables(): Promise<DebugProtocol.Variable[]> {
    const variables = await this.resolveLocalVariables();
    return variables.map((variable) => this.toDebugProtocolVariable(variable));
  }

  private async decodeObjectAtAddress(address: number): Promise<DebugProtocol.Variable[]> {
    const fields = await this.resolveObjectFields(address);
    return fields.map((variable) => this.toDebugProtocolVariable(variable));
  }

  private async resolveLocalVariables(): Promise<DebugSessionVariable[]> {
    const runtimeFrame = await this.runtime?.maybeGetPausedWasmFrame();
    const wasmModule = this.loadedModule;
    if (!runtimeFrame || !wasmModule) {
      return [];
    }

    const wasmBytecodeOffset = this.stoppedWasmBytecodeOffset;
    if (wasmBytecodeOffset === undefined) {
      return runtimeFrame.variables.map((variable) => this.toDebugSessionVariable(variable));
    }

    const sourceVariables = wasmModule.getVariablesAtBytecodeOffset(wasmBytecodeOffset);
    if (!sourceVariables) {
      return runtimeFrame.variables.map((variable) => this.toDebugSessionVariable(variable));
    }

    const runtimeVariablesByIndex = new Map<number, DebugRuntimeVariable>();
    for (const variable of runtimeFrame.variables) {
      runtimeVariablesByIndex.set(variable.localIndex, variable);
    }

    return sourceVariables.map((variable) => {
      const runtimeVariable = runtimeVariablesByIndex.get(variable.localIndex);
      assert(runtimeVariable !== undefined);
      return this.toDebugSessionVariable(runtimeVariable, variable.name, variable.typeName);
    });
  }

  private toDebugSessionVariable(
    variable: DebugRuntimeVariable,
    name: string = variable.name,
    typeName: string | undefined = variable.type
  ): DebugSessionVariable {
    const objectAddress = typeName === undefined ? undefined : this.parseObjectAddress(typeName, variable.value);
    if (objectAddress) {
      return this.createClassVariable(name, typeName, objectAddress);
    }

    return {
      kind: "basic",
      name,
      value: variable.value,
      typeName,
    };
  }

  private toDebugProtocolVariable(variable: DebugSessionVariable): DebugProtocol.Variable {
    return {
      name: variable.name,
      value: variable.kind === "class" ? "" : variable.value,
      type: variable.typeName,
      variablesReference: variable.kind === "class" ? this.toObjectVariablesReference(variable.address) : 0,
    };
  }

  private createClassVariable(name: string, typeName: string, address: number): ClassVariable {
    return { kind: "class", name, typeName, address };
  }

  private parseObjectAddress(typeName: string, value: string): number | undefined {
    if (!this.loadedModule?.getClassLayout(typeName)) {
      return undefined;
    }

    const address = Number(value);
    return Number.isInteger(address) && address > 0 ? address : undefined;
  }

  private toObjectVariablesReference(address: number): number {
    return this.createVariableContainer({ kind: "object", address });
  }

  private createVariableContainer(variableContainer: VariableContainer): number {
    const variablesReference = this.nextVariablesReference++;
    this.variableContainers.set(variablesReference, variableContainer);
    return variablesReference;
  }

  private clearVariableContainers(): void {
    this.variableContainers.clear();
  }

  private async resolveObjectFields(address: number): Promise<DebugSessionVariable[]> {
    const wasmModule = this.loadedModule;
    if (!wasmModule) {
      this.log(`Warning: cannot expand object at ${address}: wasm module is not loaded`);
      return [];
    }

    if (!this.runtime) {
      this.log(`Warning: cannot expand object at ${address}: runtime is not active`);
      return [];
    }

    const classLayout = await this.resolveRuntimeClassLayout(address);
    if (!classLayout) {
      this.log(`Warning: cannot expand object at ${address}: runtime class layout is missing`);
      return [];
    }

    const memory = await this.runtime.readWasmMemory(address, classLayout.byteSize);
    if (!memory) {
      this.log(`Warning: cannot expand object at ${address}: object memory is unavailable`);
      return [];
    }

    const view = new DataView(memory.buffer, memory.byteOffset, memory.byteLength);
    return classLayout.fields.map((field) => this.decodeFieldVariable(view, field));
  }

  private async resolveRuntimeClassLayout(address: number): Promise<ClassLayout | undefined> {
    const header = await this.runtime?.readWasmMemory(address + OBJECT_RTID_OFFSET, OBJECT_RTID_SIZE);
    if (!header) {
      this.log(`Warning: cannot read object RTID at ${address + OBJECT_RTID_OFFSET}`);
      return undefined;
    }

    const headerView = new DataView(header.buffer, header.byteOffset, header.byteLength);
    const rtid = headerView.getUint32(0, true);
    const classLayout = this.loadedModule?.getClassLayoutByRtid(rtid);
    if (!classLayout) {
      this.log(`Warning: cannot resolve class layout for RTID ${rtid}`);
    }
    return classLayout;
  }

  private decodeFieldVariable(view: DataView, field: ClassField): DebugSessionVariable {
    const value = this.decodeFieldValue(view, field);
    const address = field.isReference ? this.parseObjectAddress(field.typeName, value) : undefined;
    if (address) {
      return this.createClassVariable(field.name, field.typeName, address);
    }

    return {
      kind: "basic",
      name: field.name,
      value,
      typeName: field.typeName,
    };
  }

  private decodeFieldValue(view: DataView, field: ClassField): string {
    if (field.offset + field.size > view.byteLength) {
      return "<unavailable>";
    }

    if (field.isReference) {
      const address = view.getUint32(field.offset, true);
      return address === 0 ? "null" : address.toString();
    }

    switch (field.typeName) {
      case "bool": {
        return String(view.getUint8(field.offset) !== 0);
      }
      case "i8": {
        return view.getInt8(field.offset).toString();
      }
      case "u8": {
        return view.getUint8(field.offset).toString();
      }
      case "i16": {
        return view.getInt16(field.offset, true).toString();
      }
      case "u16": {
        return view.getUint16(field.offset, true).toString();
      }
      case "i32":
      case "isize": {
        return view.getInt32(field.offset, true).toString();
      }
      case "u32":
      case "usize": {
        return view.getUint32(field.offset, true).toString();
      }
      case "i64": {
        return view.getBigInt64(field.offset, true).toString();
      }
      case "u64": {
        return view.getBigUint64(field.offset, true).toString();
      }
      case "f32": {
        return view.getFloat32(field.offset, true).toString();
      }
      case "f64": {
        return view.getFloat64(field.offset, true).toString();
      }
      default: {
        return this.decodeIntegerBySize(view, field);
      }
    }
  }

  private decodeIntegerBySize(view: DataView, field: ClassField): string {
    switch (field.size) {
      case 1: {
        return view.getUint8(field.offset).toString();
      }
      case 2: {
        return view.getUint16(field.offset, true).toString();
      }
      case 4: {
        return view.getUint32(field.offset, true).toString();
      }
      case 8: {
        return view.getBigUint64(field.offset, true).toString();
      }
      default: {
        return "<unavailable>";
      }
    }
  }

  private doContinueRequest(response: DebugProtocol.ContinueResponse): void {
    const runtime = this.runtime;
    if (!runtime) {
      this.sendErrorResponse(response, 1, "No active runtime");
      return;
    }

    response.body = { allThreadsContinued: true };
    this.sendResponse(response);

    void this.resumeRuntime(runtime);
  }

  private async resumeRuntime(runtime: Debugger): Promise<void> {
    try {
      await runtime.resume();
    } catch (error) {
      this.log(`Continue failed: ${formatUnknownError(error)}`);
      return;
    }

    if (this.runtime !== runtime) {
      return;
    }

    this.clearVariableContainers();
    this.stoppedWasmBytecodeOffset = undefined;
    this.sendEvent(new ContinuedEvent(WarpoDebugSession.threadId, true));
  }

  private handleRuntimeExit(runtime: Debugger): void {
    if (this.runtime !== runtime) {
      return;
    }

    this.clearVariableContainers();
    this.stoppedWasmBytecodeOffset = undefined;
    this.runtime = undefined;
    this.sendEvent(new TerminatedEvent());
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
    const wasmModule = this.loadedModule;
    if (!wasmModule) {
      onComplete?.();
      return;
    }

    for (const [sourcePath, breakpoints] of this.pendingBreakpointUpdatesBySource) {
      if (breakpoints.length === 0) {
        this.pendingBreakpointUpdatesBySource.delete(sourcePath);
        continue;
      }

      if (!wasmModule.hasSource(sourcePath)) {
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

      const breakpointLocation = wasmModule.resolveBreakpointLocation(breakpoint);
      if (!breakpointLocation) {
        this.log(`No source-map match for breakpoint ${path.basename(breakpoint.source)}:${breakpoint.line}`);
        this.applyPendingBreakpointUpdates(runtime, onComplete);
        return;
      }

      this.log(
        `Resolved breakpoint ${path.basename(breakpoint.source)}:${breakpoint.line} -> ${breakpointLocation.wasmBytecodeOffset}`
      );
      runtime.setWasmBreakpoint(wasmModule, breakpointLocation.wasmBytecodeOffset, {
        onSuccess: () => {
          this.log(`Breakpoint installed at ${breakpointLocation.wasmBytecodeOffset}`);
          this.applyPendingBreakpointUpdates(runtime, onComplete);
        },
        onError: (error: Error) => {
          this.log(
            `Failed to set breakpoint ${path.basename(breakpoint.source)}:${breakpoint.line} at ${breakpointLocation.wasmBytecodeOffset}: ${error.message}`
          );
          this.applyPendingBreakpointUpdates(runtime, onComplete);
        },
      });
      return;
    }

    onComplete?.();
  }

  private disposeLoadedModule(): void {
    this.clearVariableContainers();
    this.loadedModule?.dispose();
    this.loadedModule = undefined;
  }
}
