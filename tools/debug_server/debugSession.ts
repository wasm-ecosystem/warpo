// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import {
  LoggingDebugSession,
  InitializedEvent,
  Thread,
  Breakpoint,
  BreakpointEvent,
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
import { existsSync } from "node:fs";
import * as path from "node:path";
import {
  BuiltinContainerKind,
  resolveArrayElementSize,
  type ClassField,
  type ClassLayout,
} from "../dwarf/classDebugInfo.js";
import {
  ARRAY_DATA_START_OFFSET,
  ARRAY_LENGTH_OFFSET,
  AS_STRING_CLASS_NAME,
  OBJECT_RTID_OFFSET,
  OBJECT_RTID_SIZE,
  OBJECT_RTSIZE_OFFSET,
  OBJECT_RTSIZE_SIZE,
  SMALL_TUPLE_BITMAP_SIZE,
  SMALL_TUPLE_SLOT_SIZE,
} from "../runtime/objectLayout.js";
import { normalizeDebugPath } from "./debugPath.js";
import type {
  DebuggerBreakpointInfo,
  DebuggerSourceLocation,
  DebuggerSourceVariableInfo,
  DebuggerVariableScope,
  DebuggerWasmModule,
} from "./debuggerWasmModule.js";
import type { DebugPauseInfo, Debugger, DebugRuntimeVariable } from "./debugger.js";
import { NodeDebugger } from "./nodeDebugger.js";
import { loadConfig } from "../test_runner/config.js";
import { configureTrace, trace } from "./debugTrace.js";

interface WarpoLaunchRequestArguments extends DebugProtocol.LaunchRequestArguments {
  program?: string;
  launchType?: string;
  runtime?: string;
  entryFunctionName?: string;
  cwd?: string;
  warpoPath?: string;
  debugSessionLogging?: boolean;
  debugSessionLogFile?: string;
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
  displayValue?: string;
}

interface MapEntryVariable {
  kind: "map-entry";
  name: string;
  key: DebugSessionVariable;
  value: DebugSessionVariable;
}

type DebugSessionVariable = BasicVariable | ClassVariable | MapEntryVariable | SyntheticVariable;

interface RawLocalValue {
  name: string;
  value: string;
  typeName: string | undefined;
}

interface RawTupleElementValue {
  value: string;
  isReference: boolean;
}

interface SyntheticVariable {
  kind: "synthetic";
  name: string;
  value: string;
  typeName?: string;
  container?: VariableContainer;
}

type VariableContainer =
  | { kind: "locals"; frameId: number; scopeIndex: number }
  | { kind: "object"; address: number }
  | {
      kind: "closure-scopes";
      functionName: string;
      envAddress: number;
      scopeLevels: DebuggerVariableScope[] | undefined;
    }
  | { kind: "variables"; variables: DebugProtocol.Variable[] }
  | { kind: "map-entry"; key: DebugSessionVariable; value: DebugSessionVariable };

interface PausedStackFrame {
  frameIndex: number;
  functionName: string;
  wasmBytecodeOffset?: number;
}

interface StackFrameRuntime extends Debugger {
  getPausedWasmFrames(): Omit<PausedStackFrame, "frameIndex">[];
  getPausedWasmFrameVariables(frameIndex: number): Promise<DebugRuntimeVariable[]>;
}

enum StepMode {
  None,
  Into,
  Over,
  Out,
}

function formatUnknownError(error: unknown): string {
  if (error instanceof Error) {
    return error.message;
  }

  if (typeof error === "string") {
    return error;
  }

  return "unknown error";
}

const UTF8_CONST_STR_CLASS_NAME = "~lib/warpo/utf8/const_str/ConstStr";

function isDisplayableStringClass(typeName: string): boolean {
  return typeName === AS_STRING_CLASS_NAME || typeName === UTF8_CONST_STR_CLASS_NAME;
}
const TYPED_ARRAY_ELEMENT_TYPES = new Map<string, string>([
  ["~lib/typedarray/Int8Array", "i8"],
  ["~lib/typedarray/Uint8Array", "u8"],
  ["~lib/typedarray/Uint8ClampedArray", "u8"],
  ["~lib/typedarray/Int16Array", "i16"],
  ["~lib/typedarray/Uint16Array", "u16"],
  ["~lib/typedarray/Int32Array", "i32"],
  ["~lib/typedarray/Uint32Array", "u32"],
  ["~lib/typedarray/Int64Array", "i64"],
  ["~lib/typedarray/Uint64Array", "u64"],
  ["~lib/typedarray/Float32Array", "f32"],
  ["~lib/typedarray/Float64Array", "f64"],
]);

async function resolveUnitTestWasmPath(cwd: string): Promise<string> {
  const configPath = path.join(cwd, "as-test.config.js");
  let outputFolder = "coverage";
  if (existsSync(configPath)) {
    const config = await loadConfig(configPath);
    if (typeof config.output === "string") {
      outputFolder = config.output;
    }
  }

  return path.resolve(cwd, outputFolder, "test.instrumented.wasm");
}

export class WarpoDebugSession extends LoggingDebugSession {
  private static threadId = 1;
  private breakpointId = 0;
  private requestedBreakpointsBySource = new Map<string, DebuggerBreakpointInfo[]>();
  private pendingBreakpointSources = new Set<string>();
  private variableContainers = new Map<number, VariableContainer>();
  private pausedStackFramesById = new Map<number, PausedStackFrame>();
  private nextVariablesReference = 1;
  private loadedModule: DebuggerWasmModule | undefined;
  private runtime: Debugger | undefined;
  private configurationDone = false;
  private stoppedWasmBytecodeOffset: number | undefined;
  private stoppedForTrap = false;
  private stepMode = StepMode.None;
  private stepStartSourceLocation: DebuggerSourceLocation | undefined;
  private debugSessionLogging = false;

  private log(msg: string): void {
    logger.log(msg);
    trace("debug-session", msg);
    if (this.debugSessionLogging) {
      this.sendEvent(new OutputEvent(`${msg}\n`, "stdout"));
    }
  }

  private sendStoppedEvent(runtime: Debugger, info: DebugPauseInfo): void {
    this.log(`[${runtime.name}] Paused: ${info.reason}`);
    this.clearVariableContainers();
    let reason: string;
    if (info.reason === "breakpoint") {
      reason = "breakpoint";
    } else if (info.reason === "exception") {
      reason = "exception";
    } else {
      reason = "pause";
    }
    this.log(`Sending stopped event: reason=${reason}, threadId=${WarpoDebugSession.threadId}`);
    this.sendEvent(new StoppedEvent(reason, WarpoDebugSession.threadId, info.reason));
  }

  private handleRuntimePause(runtime: Debugger, info: DebugPauseInfo): void {
    this.stoppedWasmBytecodeOffset = info.wasmBytecodeOffset;
    this.stoppedForTrap = info.reason === "exception";
    if (info.reason === "other" && !this.loadedModule) {
      return;
    }

    this.applyPendingBreakpointUpdates(runtime, () => {
      if (info.reason === "other") {
        if (this.stepMode !== StepMode.None) {
          void this.handleStepPause(runtime, info);
          return;
        }

        void runtime.resume().catch((error: unknown) => {
          const message = error instanceof Error ? error.message : "unknown error";
          this.log(`Failed to resume after breakpoint update: ${message}`);
        });
        return;
      }

      if (info.reason === "breakpoint" || info.reason === "exception") {
        this.handleNonStepPause(runtime, info);
        return;
      }

      if (this.stepMode !== StepMode.None) {
        void this.handleStepPause(runtime, info);
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
    response.body.supportsTerminateRequest = true;
    response.body.supportsRestartRequest = true;

    this.sendResponse(response);
    this.sendEvent(new InitializedEvent());
  }

  protected setBreakPointsRequest(
    response: DebugProtocol.SetBreakpointsResponse,
    args: DebugProtocol.SetBreakpointsArguments
  ): void {
    const sourcePath = normalizeDebugPath(args.source.path || "");
    const clientLines = args.breakpoints || [];
    const wasmModule = this.loadedModule;
    this.log(
      `SetBreakpoints request: source=${sourcePath}, lines=${clientLines.map((breakpoint) => breakpoint.line).join(",") || "none"}`
    );

    const bps: DebuggerBreakpointInfo[] = [];
    for (const bp of clientLines) {
      const id = ++this.breakpointId;
      bps.push({
        id,
        line: bp.line,
        verified: false,
        source: sourcePath,
      });
      this.log(`Breakpoint set: ${path.basename(sourcePath)}:${bp.line}`);
    }

    if (wasmModule !== undefined) {
      for (const breakpoint of bps) {
        breakpoint.verified = wasmModule.resolveBreakpointLocations(breakpoint).length > 0;
      }
    }

    this.requestedBreakpointsBySource.set(sourcePath, bps);
    this.pendingBreakpointSources.clear();
    for (const pendingSourcePath of this.requestedBreakpointsBySource.keys()) {
      this.pendingBreakpointSources.add(pendingSourcePath);
    }

    const breakpoints: DebugProtocol.Breakpoint[] = bps.map((bp) => this.toDebugProtocolBreakpoint(bp));

    response.body = { breakpoints };
    if (this.runtime?.isPaused() && this.loadedModule) {
      this.requestBreakpointUpdate(() => this.sendResponse(response));
    } else {
      this.sendResponse(response);
      this.requestBreakpointUpdate();
    }
  }

  protected configurationDoneRequest(
    response: DebugProtocol.ConfigurationDoneResponse,
    _args: DebugProtocol.ConfigurationDoneArguments
  ): void {
    this.configurationDone = true;
    super.configurationDoneRequest(response, _args);
    this.logAllBreakpoints();
    this.maybeStartRuntime();
  }

  protected launchRequest(response: DebugProtocol.LaunchResponse, args: WarpoLaunchRequestArguments): void {
    void this.doLaunchRequest(response, args);
  }

  protected restartRequest(response: DebugProtocol.RestartResponse, _args: DebugProtocol.RestartArguments): void {
    const runtime = this.runtime;
    if (!runtime) {
      this.sendErrorResponse(response, 1, "No active runtime to restart");
      return;
    }

    this.log("Restart requested");
    this.resetRuntimeState();
    this.queueAllBreakpointUpdates();
    void this.doRestartRequest(response, runtime);
  }

  private async doRestartRequest(response: DebugProtocol.RestartResponse, runtime: Debugger): Promise<void> {
    try {
      await runtime.restart();
      this.sendResponse(response);
    } catch (error: unknown) {
      this.sendErrorResponse(response, 1, `Restart failed: ${formatUnknownError(error)}`);
    }
  }

  private async doLaunchRequest(
    response: DebugProtocol.LaunchResponse,
    args: WarpoLaunchRequestArguments
  ): Promise<void> {
    try {
      this.debugSessionLogging = args.debugSessionLogging ?? false;
      const launchType = args.launchType ?? "wasm file";
      const cwd = args.cwd ?? process.cwd();
      const program = launchType === "unittest" ? await resolveUnitTestWasmPath(cwd) : args.program;
      if (!program) {
        this.sendErrorResponse(response, 1, "No program specified for launch");
        return;
      }
      const wasmFilePath = path.resolve(program);
      configureTrace(args.debugSessionLogFile, cwd);
      this.log(`Launch requested for: ${program}`);
      if (launchType === "wasm file" || launchType === "unittest") {
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
          this.log(
            `Module load breakpoint state: requestedSources=${this.requestedBreakpointsBySource.size}, pendingSources=${this.pendingBreakpointSources.size}`
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

          this.applyPendingBreakpointUpdates(runtime, () => this.maybeStartRuntime());
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
        this.runtime = runtime;
        await runtime.launch(
          launchType === "unittest"
            ? {
                wasmFilePath,
                cwd,
                warpoPath: args.warpoPath,
              }
            : {
                wasmFilePath,
                entryFunctionName: args.entryFunctionName ?? "main",
                args: args.args ?? [],
              }
        );

        this.log(`[${runtime.name}] Runtime launched`);
      } else {
        this.sendErrorResponse(response, 1, `Unknown launch type "${launchType}"`);
        return;
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
    args: DebugProtocol.StackTraceArguments
  ): void {
    this.doStackTraceRequest(response, args);
  }

  protected scopesRequest(response: DebugProtocol.ScopesResponse, args: DebugProtocol.ScopesArguments): void {
    this.doScopesRequest(response, args);
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

  protected stepInRequest(response: DebugProtocol.StepInResponse, _args: DebugProtocol.StepInArguments): void {
    this.doStepRequest(response, StepMode.Into);
  }

  protected nextRequest(response: DebugProtocol.NextResponse, _args: DebugProtocol.NextArguments): void {
    this.doStepRequest(response, StepMode.Over);
  }

  protected pauseRequest(response: DebugProtocol.PauseResponse, _args: DebugProtocol.PauseArguments): void {
    const runtime = this.runtime;
    if (!runtime) {
      this.sendErrorResponse(response, 1, "No active runtime");
      return;
    }

    if (runtime.isPaused()) {
      this.sendResponse(response);
      return;
    }

    this.cancelStep();
    // StepMode.Into is used as a sentinel to reuse the step-pause handling path; no actual step-in is performed.
    this.stepMode = StepMode.Into;
    this.stepStartSourceLocation = undefined;
    this.clearVariableContainers();
    runtime.pause();
    this.sendResponse(response);
  }

  protected terminateRequest(response: DebugProtocol.TerminateResponse, _args: DebugProtocol.TerminateArguments): void {
    const runtime = this.runtime;
    if (runtime) {
      void this.disposeRuntimeAndTerminate(runtime);
    }
    this.sendResponse(response);
  }

  protected stepOutRequest(response: DebugProtocol.StepOutResponse, _args: DebugProtocol.StepOutArguments): void {
    this.doStepRequest(response, StepMode.Out);
  }

  protected disconnectRequest(
    response: DebugProtocol.DisconnectResponse,
    _args: DebugProtocol.DisconnectArguments
  ): void {
    void this.doDisconnectRequest(response);
  }

  private async doDisconnectRequest(response: DebugProtocol.DisconnectResponse): Promise<void> {
    const runtime = this.runtime;
    this.runtime = undefined;
    try {
      await runtime?.dispose();
    } catch (error) {
      this.log(`Failed to dispose runtime: ${formatUnknownError(error)}`);
    }
    this.resetRuntimeState();
    this.debugSessionLogging = false;
    this.dispose();
    this.log("Debug session ended.");
    this.sendResponse(response);
  }

  private doStackTraceRequest(
    response: DebugProtocol.StackTraceResponse,
    args: DebugProtocol.StackTraceArguments
  ): void {
    const runtime = this.runtime as StackFrameRuntime | undefined;
    const frames = runtime ? runtime.getPausedWasmFrames() : [];
    this.log(
      `StackTrace request: threadId=${args.threadId}, startFrame=${args.startFrame ?? 0}, levels=${args.levels ?? "all"}, runtimeFrames=${frames.length}`
    );
    this.pausedStackFramesById.clear();

    const stackFrames = frames.map((frame, index) => {
      const id = index + 1;
      this.pausedStackFramesById.set(id, { ...frame, frameIndex: index });

      const sourceLocation = this.resolveSourceLocation(frame.wasmBytecodeOffset);
      const sourceLabel = sourceLocation
        ? `${path.basename(sourceLocation.sourcePath)}:${sourceLocation.sourceLine}`
        : "unknown";
      this.log(
        `  frame ${id}: index=${index}, name=${frame.functionName || "wasm"}, offset=${frame.wasmBytecodeOffset ?? "unknown"}, source=${sourceLabel}`
      );
      const source = sourceLocation
        ? new Source(path.basename(sourceLocation.sourcePath), sourceLocation.sourcePath)
        : undefined;
      return new StackFrame(id, frame.functionName || "wasm", source, sourceLocation?.sourceLine ?? 0, 1);
    });

    const startFrame: number = args.startFrame ?? 0;
    const requestedStackFrames =
      args.levels === undefined
        ? stackFrames.slice(startFrame)
        : stackFrames.slice(startFrame, startFrame + args.levels);
    response.body = {
      stackFrames: requestedStackFrames,
      totalFrames: stackFrames.length,
    };
    this.log(`StackTrace response: returned=${requestedStackFrames.length}, total=${stackFrames.length}`);
    this.sendResponse(response);
  }

  private resolveSourceLocation(
    wasmBytecodeOffset: number | undefined
  ): { sourcePath: string; sourceLine: number } | undefined {
    const wasmModule = this.loadedModule;
    if (!wasmModule || wasmBytecodeOffset === undefined) {
      return undefined;
    }

    return wasmModule.resolveSourceLocation(wasmBytecodeOffset);
  }

  private doScopesRequest(response: DebugProtocol.ScopesResponse, args: DebugProtocol.ScopesArguments): void {
    this.log(`Scopes request: frameId=${args.frameId}`);
    const scopes = this.resolveLocalScopes(args.frameId);
    response.body = { scopes };
    this.sendResponse(response);
  }

  private async doVariablesRequest(
    response: DebugProtocol.VariablesResponse,
    args: DebugProtocol.VariablesArguments
  ): Promise<void> {
    const variableContainer = this.variableContainers.get(args.variablesReference);

    switch (variableContainer?.kind) {
      case "locals": {
        this.log(
          `Variables request: locals for frameId=${variableContainer.frameId}, scopeIndex=${variableContainer.scopeIndex}`
        );
        response.body = {
          variables: await this.resolveLocalScopeVariables(variableContainer.frameId, variableContainer.scopeIndex),
        };
        break;
      }
      case "object": {
        response.body = { variables: await this.decodeObjectAtAddress(variableContainer.address) };
        break;
      }
      case "variables": {
        response.body = { variables: variableContainer.variables };
        break;
      }
      case "closure-scopes": {
        response.body = {
          variables: await this.resolveClosureScopeVariables(
            variableContainer.functionName,
            variableContainer.envAddress,
            variableContainer.scopeLevels
          ),
        };
        break;
      }
      case "map-entry": {
        response.body = {
          variables: [variableContainer.key, variableContainer.value].map((variable) =>
            this.toDebugProtocolVariable(variable)
          ),
        };
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

  private resolveLocalScopes(frameId: number): Scope[] {
    const runtimeFrame = this.resolvePausedStackFrame(frameId);
    const wasmModule = this.loadedModule;
    if (!runtimeFrame || !wasmModule) {
      this.log(
        `Scopes unavailable: frameId=${frameId}, hasFrame=${runtimeFrame !== undefined}, hasModule=${wasmModule !== undefined}`
      );
      return [];
    }

    const wasmBytecodeOffset = runtimeFrame.wasmBytecodeOffset;
    if (wasmBytecodeOffset === undefined) {
      this.log(`Error: scopes unavailable: frame ${frameId} has no wasm bytecode offset`);
      return [];
    }

    const sourceVariableScopes = wasmModule.getVariableScopesAtBytecodeOffset(wasmBytecodeOffset);
    if (!sourceVariableScopes || sourceVariableScopes.length === 0) {
      this.log(`Scopes response: frameId=${frameId}, no scopes`);
      return [];
    }

    this.log(
      `Scopes response: frameId=${frameId}, scopes=${sourceVariableScopes.map((scope) => scope.name).join(", ")}`
    );
    return sourceVariableScopes.map(
      (scope, index) =>
        new Scope(scope.name, this.createVariableContainer({ kind: "locals", frameId, scopeIndex: index }), false)
    );
  }

  private async resolveLocalScopeVariables(frameId: number, scopeIndex: number): Promise<DebugProtocol.Variable[]> {
    const runtimeFrame = this.resolvePausedStackFrame(frameId);
    const wasmModule = this.loadedModule;
    const runtime = this.runtime as StackFrameRuntime | undefined;
    if (!runtimeFrame || !wasmModule || !runtime) {
      this.log(
        `Local variables unavailable: frameId=${frameId}, hasFrame=${runtimeFrame !== undefined}, hasModule=${wasmModule !== undefined}, hasRuntime=${runtime !== undefined}`
      );
      return [];
    }

    const wasmBytecodeOffset: number | undefined = runtimeFrame.wasmBytecodeOffset;
    if (wasmBytecodeOffset === undefined) {
      this.log(`Error: local variables unavailable: frame ${frameId} has no wasm bytecode offset`);
      return [];
    }

    const sourceVariableScopes = wasmModule.getVariableScopesAtBytecodeOffset(wasmBytecodeOffset);
    if (!sourceVariableScopes) {
      this.log(`Error: local variables unavailable: no source variables at wasm bytecode offset ${wasmBytecodeOffset}`);
      return [];
    }

    const sourceVariableScope = sourceVariableScopes[scopeIndex];
    if (!sourceVariableScope) {
      this.log(`Error: local variables unavailable: no scope at index ${scopeIndex}`);
      return [];
    }

    const runtimeVariables = await runtime.getPausedWasmFrameVariables(runtimeFrame.frameIndex);
    this.log(
      `Local variables resolved: frameId=${frameId}, frameIndex=${runtimeFrame.frameIndex}, offset=${wasmBytecodeOffset}, scopeIndex=${scopeIndex}, scope=${sourceVariableScope.name}, runtimeVariables=${runtimeVariables.length}`
    );

    const runtimeVariablesByIndex = new Map<number, DebugRuntimeVariable>();
    for (const variable of runtimeVariables) {
      runtimeVariablesByIndex.set(variable.localIndex, variable);
    }

    const sourceVariables = sourceVariableScope.variables;
    const rawWasmValues = await this.resolveRawWasmValues(sourceVariables, runtimeVariablesByIndex, runtime);
    const firstTupleAddress = this.resolveClosureTupleAddress(
      sourceVariableScope.rootClosureEnvLocalIndex,
      runtimeVariablesByIndex
    );
    const decodedScopes = await this.decodeScopeChainVariables([sourceVariableScope], firstTupleAddress, rawWasmValues);
    return decodedScopes[0] ?? [];
  }

  private async decodeScopeChainVariables(
    scopeLevels: DebuggerVariableScope[],
    firstTupleAddress: number | undefined,
    rawWasmValues: Map<DebuggerSourceVariableInfo, string>
  ): Promise<DebugProtocol.Variable[][]> {
    const closureTupleValuesByLevel = new Map<number, Map<number, string>>();
    const visitedAddresses = new Set<number>();
    if (firstTupleAddress !== undefined && Number.isInteger(firstTupleAddress) && firstTupleAddress > 0) {
      let currentAddress = firstTupleAddress;
      let tupleLevel = 0;
      while (!visitedAddresses.has(currentAddress)) {
        visitedAddresses.add(currentAddress);
        const tupleValues = await this.readTupleElementValues(currentAddress);
        const levelValues = new Map<number, string>();
        for (const [index, value] of tupleValues.entries()) {
          levelValues.set(index, value.value);
        }
        closureTupleValuesByLevel.set(tupleLevel, levelValues);

        const parentTuple = tupleValues[0];
        if (!parentTuple) {
          break;
        }

        const parentAddress = Number(parentTuple.value);
        if (!Number.isInteger(parentAddress) || parentAddress <= 0) {
          break;
        }

        currentAddress = parentAddress;
        tupleLevel++;
      }
    }

    return Promise.all(
      scopeLevels.map(async (scopeLevel) => {
        const rawLocalValues = scopeLevel.variables.map((variable): RawLocalValue => {
          if (variable.kind === "closure") {
            const elementIndex = variable.fieldOffset / SMALL_TUPLE_SLOT_SIZE;
            const levelValues = closureTupleValuesByLevel.get(scopeLevel.tupleLevel ?? 0);
            const tupleRawValue = levelValues?.get(elementIndex);
            if (tupleRawValue === undefined) {
              return { name: variable.name, value: "<unavailable>", typeName: variable.typeName };
            }

            return { name: variable.name, value: tupleRawValue, typeName: variable.typeName };
          }

          const wasmRawValue = rawWasmValues.get(variable);
          return {
            name: variable.name,
            value: wasmRawValue ?? "<unavailable>",
            typeName: variable.typeName,
          };
        });

        const variables = await Promise.all(
          rawLocalValues.map((variable) =>
            this.toDebugSessionVariableValue(variable.name, variable.typeName, variable.value)
          )
        );
        return variables.map((variable) => this.toDebugProtocolVariable(variable));
      })
    );
  }

  private async resolveClosureScopeVariables(
    functionName: string,
    envAddress: number,
    scopeLevels: DebuggerVariableScope[] | undefined
  ): Promise<DebugProtocol.Variable[]> {
    const wasmModule = this.loadedModule;
    if (!wasmModule) {
      this.log(`Warning: cannot expand closure scopes for ${functionName}: wasm module is not loaded`);
      return [];
    }

    if (!scopeLevels) {
      this.log(`Warning: cannot expand closure scopes for ${functionName}: DWARF function is unavailable`);
      return [];
    }

    const decodedScopeVariables = await this.decodeScopeChainVariables(scopeLevels, envAddress, new Map());
    return scopeLevels.map((scopeLevel, index) => {
      const variable: SyntheticVariable = {
        kind: "synthetic",
        name: index.toString(),
        value: scopeLevel.name,
        container: { kind: "variables", variables: decodedScopeVariables[index] ?? [] },
      };
      return this.toDebugProtocolVariable(variable);
    });
  }

  private async decodeObjectAtAddress(address: number): Promise<DebugProtocol.Variable[]> {
    const fields = await this.resolveObjectFields(address);
    return fields.map((variable) => this.toDebugProtocolVariable(variable));
  }

  private async resolveRawWasmValues(
    sourceVariables: DebuggerSourceVariableInfo[],
    runtimeVariablesByIndex: Map<number, DebugRuntimeVariable>,
    runtime: StackFrameRuntime
  ): Promise<Map<DebuggerSourceVariableInfo, string>> {
    const rawWasmValues = new Map<DebuggerSourceVariableInfo, string>();
    let runtimeGlobalsByIndex: Map<number, string> | undefined;

    for (const variable of sourceVariables) {
      if (variable.kind === "wasm-local") {
        const runtimeVariable = runtimeVariablesByIndex.get(variable.localIndex);
        assert(runtimeVariable !== undefined);
        rawWasmValues.set(variable, runtimeVariable.value);
      } else if (variable.kind === "wasm-global") {
        if (runtimeGlobalsByIndex === undefined) {
          const pausedWasmGlobalVariables = await runtime.getPausedWasmGlobalVariables();
          runtimeGlobalsByIndex = new Map(
            pausedWasmGlobalVariables.map((runtimeVariable) => [runtimeVariable.globalIndex, runtimeVariable.value])
          );
        }
        rawWasmValues.set(variable, runtimeGlobalsByIndex.get(variable.globalIndex) ?? "<unavailable>");
      }
    }
    return rawWasmValues;
  }

  private resolveClosureTupleAddress(
    closureEnvLocalIndex: number | undefined,
    runtimeVariablesByIndex: Map<number, DebugRuntimeVariable>
  ): number | undefined {
    if (closureEnvLocalIndex === undefined) {
      return undefined;
    }

    const closureEnvVariable = runtimeVariablesByIndex.get(closureEnvLocalIndex);
    if (closureEnvVariable === undefined) {
      return undefined;
    }

    const address = Number(closureEnvVariable.value);
    return Number.isInteger(address) && address > 0 ? address : undefined;
  }

  private resolvePausedStackFrame(frameId: number): PausedStackFrame | undefined {
    return this.pausedStackFramesById.get(frameId);
  }

  private async toDebugSessionVariable(
    variable: DebugRuntimeVariable,
    name: string = variable.name,
    typeName: string | undefined = variable.type
  ): Promise<DebugSessionVariable> {
    return this.toDebugSessionVariableValue(name, typeName, variable.value);
  }

  private async toDebugSessionVariableValue(
    name: string,
    typeName: string | undefined,
    value: string
  ): Promise<DebugSessionVariable> {
    if (typeName !== undefined) {
      const objectAddress = this.parseObjectAddress(typeName, value);
      if (objectAddress) {
        if (isDisplayableStringClass(typeName)) {
          const stringValue = await this.decodeStringAtAddress(typeName, objectAddress);
          return this.createClassVariable(name, typeName, objectAddress, stringValue);
        }

        return this.createClassVariable(name, typeName, objectAddress);
      }
    }

    return {
      kind: "basic",
      name,
      value,
      typeName,
    };
  }

  private toDebugProtocolVariable(
    variable: DebugSessionVariable,
    options: { showClassNameInName?: boolean } = {}
  ): DebugProtocol.Variable {
    const isExpandableClass = variable.kind === "class" && variable.displayValue === undefined;
    const showClassNameInName = options.showClassNameInName ?? true;

    return {
      name: isExpandableClass && showClassNameInName ? `${variable.name}: ${variable.typeName}` : variable.name,
      value: this.getVariableDisplayValue(variable),
      type: variable.kind === "map-entry" ? undefined : variable.typeName,
      variablesReference: this.getVariableReference(variable, isExpandableClass),
    };
  }

  private getVariableDisplayValue(variable: DebugSessionVariable): string {
    switch (variable.kind) {
      case "basic": {
        return variable.value;
      }
      case "class": {
        return variable.displayValue ?? "";
      }
      case "map-entry": {
        return "";
      }
      case "synthetic": {
        return variable.value;
      }
    }
  }

  private getVariableReference(variable: DebugSessionVariable, isExpandableClass: boolean): number {
    if (isExpandableClass && variable.kind === "class") {
      return this.toObjectVariablesReference(variable.address);
    }

    if (variable.kind === "synthetic") {
      return variable.container === undefined ? 0 : this.createVariableContainer(variable.container);
    }

    if (variable.kind === "map-entry") {
      return this.createVariableContainer({ kind: "map-entry", key: variable.key, value: variable.value });
    }

    return 0;
  }

  private createClassVariable(name: string, typeName: string, address: number, displayValue?: string): ClassVariable {
    return { kind: "class", name, typeName, address, displayValue };
  }

  private parseObjectAddress(typeName: string, value: string): number | undefined {
    if (typeName !== UTF8_CONST_STR_CLASS_NAME && !this.loadedModule?.getClassLayout(typeName)) {
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
    this.pausedStackFramesById.clear();
  }

  private async readTupleElementValues(address: number, classLayout?: ClassLayout): Promise<RawTupleElementValue[]> {
    if (!this.runtime) {
      this.log(`Warning: cannot expand tuple at ${address}: runtime is not active`);
      return [];
    }

    const tupleClassLayout = classLayout ?? (await this.resolveRuntimeClassLayout(address));
    if (!tupleClassLayout) {
      this.log(`Warning: cannot expand tuple at ${address}: runtime class layout is missing`);
      return [];
    }

    if (tupleClassLayout.builtinKind !== BuiltinContainerKind.SmallTuple) {
      this.log(`Warning: cannot expand tuple at ${address}: runtime class layout is not tuple`);
      return [];
    }

    const payloadSize = await this.resolveRuntimeObjectPayloadSize(address, tupleClassLayout);
    if (payloadSize === undefined) {
      return [];
    }

    const memory = await this.runtime.readWasmMemory(address, payloadSize);
    if (!memory) {
      this.log(`Warning: cannot expand tuple at ${address}: tuple memory is unavailable`);
      return [];
    }

    const view = new DataView(memory.buffer, memory.byteOffset, memory.byteLength);
    assert.equal(tupleClassLayout.builtinKind, BuiltinContainerKind.SmallTuple);

    if (view.byteLength <= SMALL_TUPLE_BITMAP_SIZE) {
      return [];
    }

    const elementAreaSize = view.byteLength - SMALL_TUPLE_BITMAP_SIZE;
    if (elementAreaSize % SMALL_TUPLE_SLOT_SIZE !== 0) {
      this.log(`Error: cannot expand tuple at ${address}: tuple element area is not slot aligned`);
      return [];
    }

    const bitmap = view.getBigUint64(elementAreaSize, true);
    const values: RawTupleElementValue[] = [];
    for (let index = 0; index < elementAreaSize / SMALL_TUPLE_SLOT_SIZE; index++) {
      const offset = index * SMALL_TUPLE_SLOT_SIZE;
      const isReference = (bitmap & (1n << BigInt(index))) !== 0n;
      const value = isReference
        ? this.decodeTupleReferenceValue(view, offset)
        : this.decodeTupleBasicValue(view, offset);
      values.push({ value, isReference });
    }

    return values;
  }

  private async decodeTupleElements(address: number, classLayout?: ClassLayout): Promise<DebugSessionVariable[]> {
    const values = await this.readTupleElementValues(address, classLayout);
    return Promise.all(
      values.map((value, index) =>
        value.isReference
          ? this.decodeTupleReferenceElement(index.toString(), value.value)
          : this.toDebugSessionVariableValue(index.toString(), "usize", value.value)
      )
    );
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

    if (classLayout.builtinKind === BuiltinContainerKind.SmallTuple) {
      return this.decodeTupleElements(address, classLayout);
    }

    const payloadSize = await this.resolveRuntimeObjectPayloadSize(address, classLayout);
    if (payloadSize === undefined) {
      return [];
    }

    const memory = await this.runtime.readWasmMemory(address, payloadSize);
    if (!memory) {
      this.log(`Warning: cannot expand object at ${address}: object memory is unavailable`);
      return [];
    }

    const view = new DataView(memory.buffer, memory.byteOffset, memory.byteLength);
    if (classLayout.builtinKind === BuiltinContainerKind.Function) {
      return this.decodeFunctionElements(view, classLayout);
    }
    if (classLayout.builtinKind === BuiltinContainerKind.ArrayBuffer) {
      return this.decodeArrayBufferElements(view);
    }
    const typedArrayElementType = TYPED_ARRAY_ELEMENT_TYPES.get(classLayout.name);
    if (typedArrayElementType !== undefined) {
      return this.decodeTypedArrayElements(address, view, classLayout, typedArrayElementType);
    }
    if (classLayout.builtinKind === BuiltinContainerKind.Array) {
      return this.decodeArrayElements(address, view, classLayout);
    }
    if (classLayout.builtinKind === BuiltinContainerKind.StaticArray) {
      return this.decodeStaticArrayElements(address, view, classLayout);
    }
    if (this.isSetClassLayout(classLayout)) {
      return this.decodeSetElements(address, view, classLayout);
    }
    if (this.isMapClassLayout(classLayout)) {
      return this.decodeMapElements(address, view, classLayout);
    }

    return Promise.all(classLayout.fields.map((field) => this.decodeFieldVariable(view, field)));
  }

  private decodeFunctionElements(view: DataView, classLayout: ClassLayout): DebugSessionVariable[] {
    const indexField = classLayout.fields.find((field) => field.name === "_index" || field.name === "index");
    let functionName: string | undefined;
    if (indexField) {
      const indexValue = this.decodeFieldValue(view, indexField);
      const functionIndex = Number(indexValue);
      if (Number.isInteger(functionIndex) && functionIndex >= 0) {
        functionName = this.loadedModule?.getFunctionNameByTableIndex(functionIndex);
      }
    } else {
      this.log(`Warning: cannot expand function: index field is unavailable`);
    }

    const envField = classLayout.fields.find((field) => field.name === "_env" || field.name === "env");
    let envAddress: number | undefined;
    if (envField) {
      const envValue = Number(this.decodeFieldValue(view, envField));
      if (Number.isInteger(envValue) && envValue > 0) {
        envAddress = envValue;
      }
    } else {
      this.log(`Warning: cannot expand function: env field is unavailable`);
    }

    const closureScopes =
      functionName === undefined ? undefined : this.loadedModule?.getClosureVariableScopesByFunctionName(functionName);
    return [
      { kind: "basic", name: "name", value: functionName ?? "<unavailable>", typeName: "string" },
      {
        kind: "synthetic",
        name: "[[scopes]]",
        value: `Scopes[${closureScopes?.length ?? 0}]`,
        typeName: "Scopes",
        container:
          functionName === undefined || envAddress === undefined
            ? undefined
            : { kind: "closure-scopes", functionName, envAddress, scopeLevels: closureScopes },
      },
    ];
  }

  private async resolveRuntimeObjectPayloadSize(
    address: number,
    classLayout: ClassLayout
  ): Promise<number | undefined> {
    if (
      classLayout.builtinKind !== BuiltinContainerKind.SmallTuple &&
      classLayout.builtinKind !== BuiltinContainerKind.StaticArray &&
      classLayout.builtinKind !== BuiltinContainerKind.ArrayBuffer &&
      !TYPED_ARRAY_ELEMENT_TYPES.has(classLayout.name)
    ) {
      return classLayout.byteSize;
    }

    const sizeMemory = await this.runtime?.readWasmMemory(address + OBJECT_RTSIZE_OFFSET, OBJECT_RTSIZE_SIZE);
    if (!sizeMemory) {
      this.log(`Warning: cannot read object size at ${address + OBJECT_RTSIZE_OFFSET}`);
      return undefined;
    }

    const sizeView = new DataView(sizeMemory.buffer, sizeMemory.byteOffset, sizeMemory.byteLength);
    return sizeView.getUint32(0, true);
  }

  private decodeTupleReferenceValue(view: DataView, offset: number): string {
    if (offset + SMALL_TUPLE_SLOT_SIZE > view.byteLength) {
      return "<unavailable>";
    }

    const elementAddress = view.getUint32(offset, true);
    return elementAddress === 0 ? "null" : elementAddress.toString();
  }

  private decodeTupleBasicValue(view: DataView, offset: number): string {
    return this.decodeFieldValue(view, {
      name: "",
      typeName: "usize",
      offset,
      size: SMALL_TUPLE_SLOT_SIZE,
      isReference: false,
    });
  }

  private async decodeTupleReferenceElement(name: string, value: string): Promise<DebugSessionVariable> {
    const elementAddress = Number(value);
    if (elementAddress === 0) {
      return { kind: "basic", name, value: "null", typeName: undefined };
    }

    if (!Number.isInteger(elementAddress) || elementAddress <= 0) {
      return { kind: "basic", name, value, typeName: undefined };
    }

    const classLayout = await this.resolveRuntimeClassLayout(elementAddress);
    if (!classLayout) {
      this.log(`Error: cannot expand tuple reference at ${elementAddress}: runtime class layout is missing`);
      return { kind: "basic", name, value: elementAddress.toString(), typeName: undefined };
    }

    if (isDisplayableStringClass(classLayout.name)) {
      const stringValue = await this.decodeStringAtAddress(classLayout.name, elementAddress);
      return this.createClassVariable(name, classLayout.name, elementAddress, stringValue);
    }

    return this.createClassVariable(name, classLayout.name, elementAddress);
  }

  private async decodeArrayElements(
    address: number,
    view: DataView,
    classLayout: ClassLayout
  ): Promise<DebugSessionVariable[]> {
    assert.equal(classLayout.builtinKind, BuiltinContainerKind.Array);

    const elementTypeName = classLayout.templateType;
    if (elementTypeName === undefined) {
      this.log(`Error: cannot expand array at ${address}: element type is unavailable`);
      return [];
    }

    if (ARRAY_LENGTH_OFFSET + 4 > view.byteLength) {
      this.log(`Error: cannot expand array at ${address}: array header is unavailable`);
      return [];
    }

    const dataStart = view.getUint32(ARRAY_DATA_START_OFFSET, true);
    const length = view.getUint32(ARRAY_LENGTH_OFFSET, true);
    const elementSize = resolveArrayElementSize(elementTypeName, classLayout.templateTypeIsReference === true);
    const elementsMemory = await this.runtime?.readWasmMemory(dataStart, length * elementSize);
    if (!elementsMemory) {
      this.log(`Error: cannot expand array at ${address}: array elements memory is unavailable`);
      return [];
    }

    const elementsView = new DataView(elementsMemory.buffer, elementsMemory.byteOffset, elementsMemory.byteLength);
    return this.decodeArrayElementVariables(
      elementsView,
      length,
      elementTypeName,
      elementSize,
      classLayout.templateTypeIsReference === true
    );
  }

  private decodeArrayBufferElements(view: DataView): DebugSessionVariable[] {
    const elements: DebugSessionVariable[] = [];
    for (let index = 0; index < view.byteLength; index++) {
      elements.push({
        kind: "basic",
        name: index.toString(),
        value: view.getUint8(index).toString(),
        typeName: "u8",
      });
    }
    return elements;
  }

  private async decodeTypedArrayElements(
    address: number,
    view: DataView,
    classLayout: ClassLayout,
    elementTypeName: string
  ): Promise<DebugSessionVariable[]> {
    const dataStartField = classLayout.fields.find((field) => field.name === "dataStart");
    const byteLengthField = classLayout.fields.find((field) => field.name === "byteLength");
    if (!dataStartField || !byteLengthField) {
      this.log(`Error: cannot expand typed array at ${address}: typed array header is unavailable`);
      return [];
    }

    const dataStart = Number(this.decodeFieldValue(view, dataStartField));
    const byteLength = Number(this.decodeFieldValue(view, byteLengthField));
    const elementSize = resolveArrayElementSize(elementTypeName, false);
    if (
      !Number.isInteger(dataStart) ||
      dataStart < 0 ||
      !Number.isInteger(byteLength) ||
      byteLength < 0 ||
      byteLength % elementSize !== 0
    ) {
      this.log(`Error: cannot expand typed array at ${address}: typed array data is invalid`);
      return [];
    }

    const elementsMemory = await this.runtime?.readWasmMemory(dataStart, byteLength);
    if (!elementsMemory) {
      this.log(`Error: cannot expand typed array at ${address}: typed array data is unavailable`);
      return [];
    }

    const elementsView = new DataView(elementsMemory.buffer, elementsMemory.byteOffset, elementsMemory.byteLength);
    return this.decodeArrayElementVariables(
      elementsView,
      byteLength / elementSize,
      elementTypeName,
      elementSize,
      false
    );
  }

  private async decodeStaticArrayElements(
    address: number,
    view: DataView,
    classLayout: ClassLayout
  ): Promise<DebugSessionVariable[]> {
    assert.equal(classLayout.builtinKind, BuiltinContainerKind.StaticArray);

    const elementTypeName = classLayout.templateType;
    if (elementTypeName === undefined) {
      this.log(`Error: cannot expand static array at ${address}: element type is unavailable`);
      return [];
    }

    const elementSize = resolveArrayElementSize(elementTypeName, classLayout.templateTypeIsReference === true);
    if (view.byteLength % elementSize !== 0) {
      this.log(`Error: cannot expand static array at ${address}: payload size is not element aligned`);
      return [];
    }

    return this.decodeArrayElementVariables(
      view,
      view.byteLength / elementSize,
      elementTypeName,
      elementSize,
      classLayout.templateTypeIsReference === true
    );
  }

  private async decodeArrayElementVariables(
    view: DataView,
    length: number,
    elementTypeName: string,
    elementSize: number,
    isReference: boolean
  ): Promise<DebugSessionVariable[]> {
    const elementVariables: Promise<DebugSessionVariable>[] = [];
    for (let index = 0; index < length; index++) {
      elementVariables.push(
        this.decodeFieldVariable(view, {
          name: index.toString(),
          typeName: elementTypeName,
          offset: index * elementSize,
          size: elementSize,
          isReference,
        })
      );
    }

    return Promise.all(elementVariables);
  }

  private async decodeSetElements(
    address: number,
    view: DataView,
    classLayout: ClassLayout
  ): Promise<DebugSessionVariable[]> {
    const elementTypeName = classLayout.templateType;
    if (elementTypeName === undefined) {
      this.log(`Error: cannot expand set at ${address}: element type is unavailable`);
      return [];
    }

    const entryLayout = classLayout.entryLayout;
    if (entryLayout === undefined) {
      this.log(`Error: cannot expand set at ${address}: entry layout is unavailable`);
      return [];
    }

    const entriesView = await this.readMapOrSetEntries(address, view, entryLayout.size, "set");
    if (!entriesView) {
      return [];
    }

    const entriesOffset = view.getInt32(16, true);
    if (entriesOffset <= 0) {
      return [];
    }

    const elementSize = resolveArrayElementSize(elementTypeName, classLayout.templateTypeIsReference === true);
    const elements: Promise<DebugSessionVariable>[] = [];
    for (let entryIndex = 0; entryIndex < entriesOffset; entryIndex++) {
      const entryBase = entryIndex * entryLayout.size;
      const taggedNextOffset = entryBase + entryLayout.size - 4;
      if (taggedNextOffset + 4 > entriesView.byteLength) {
        break;
      }

      const taggedNext = entriesView.getUint32(taggedNextOffset, true);
      if (taggedNext & 1) {
        continue;
      }

      elements.push(
        this.decodeFieldVariable(entriesView, {
          name: elements.length.toString(),
          typeName: elementTypeName,
          offset: entryBase,
          size: elementSize,
          isReference: classLayout.templateTypeIsReference === true,
        })
      );
    }

    return Promise.all(elements);
  }

  private async decodeMapElements(
    address: number,
    view: DataView,
    classLayout: ClassLayout
  ): Promise<DebugSessionVariable[]> {
    const entryLayout = classLayout.entryLayout;
    if (entryLayout === undefined) {
      this.log(`Error: cannot expand map at ${address}: entry layout is unavailable`);
      return [];
    }

    const entryClass = this.getMapOrSetEntryClassLayout(classLayout.name);
    const keyField = entryClass?.fields.find((field) => field.name === "key");
    const valueField = entryClass?.fields.find((field) => field.name === "value");
    if (!keyField || !valueField) {
      this.log(`Error: cannot expand map at ${address}: key/value entry fields are unavailable`);
      return [];
    }

    const entriesView = await this.readMapOrSetEntries(address, view, entryLayout.size, "map");
    if (!entriesView) {
      return [];
    }

    const entriesOffset = view.getInt32(16, true);
    const elements: Promise<DebugSessionVariable>[] = [];
    for (let entryIndex = 0; entryIndex < entriesOffset; entryIndex++) {
      const entryBase = entryIndex * entryLayout.size;
      const taggedNextOffset = entryBase + entryLayout.size - 4;
      if (taggedNextOffset + 4 > entriesView.byteLength) {
        break;
      }

      const taggedNext = entriesView.getUint32(taggedNextOffset, true);
      if (taggedNext & 1) {
        continue;
      }

      elements.push(this.decodeMapEntry(entriesView, elements.length.toString(), entryBase, keyField, valueField));
    }

    return Promise.all(elements);
  }

  private isSetClassLayout(classLayout: ClassLayout): boolean {
    return classLayout.name.startsWith("~lib/set/Set<");
  }

  private isMapClassLayout(classLayout: ClassLayout): boolean {
    return classLayout.name.startsWith("~lib/map/Map<");
  }

  private getMapOrSetEntryClassLayout(className: string): ClassLayout | undefined {
    if (className.startsWith("~lib/set/Set<")) {
      return this.loadedModule?.getInternalClassLayout(className.replace("~lib/set/Set<", "~lib/set/SetEntry<"));
    }

    if (className.startsWith("~lib/map/Map<")) {
      return this.loadedModule?.getInternalClassLayout(className.replace("~lib/map/Map<", "~lib/map/MapEntry<"));
    }

    return undefined;
  }

  private async decodeMapEntry(
    entriesView: DataView,
    name: string,
    entryBase: number,
    keyField: ClassField,
    valueField: ClassField
  ): Promise<DebugSessionVariable> {
    const [key, value] = await Promise.all([
      this.decodeFieldVariable(entriesView, { ...keyField, name: "key", offset: entryBase + keyField.offset }),
      this.decodeFieldVariable(entriesView, { ...valueField, name: "value", offset: entryBase + valueField.offset }),
    ]);

    return { kind: "map-entry", name, key, value };
  }

  private async readMapOrSetEntries(
    address: number,
    view: DataView,
    entrySize: number,
    containerKind: "map" | "set"
  ): Promise<DataView | undefined> {
    if (view.byteLength < 20) {
      this.log(`Error: cannot expand ${containerKind} at ${address}: ${containerKind} header is unavailable`);
      return undefined;
    }

    const entriesPtr = view.getUint32(8, true);
    const entriesOffset = view.getInt32(16, true);
    if (entriesPtr === 0 || entriesOffset <= 0) {
      return new DataView(new ArrayBuffer(0));
    }

    const entriesMemory = await this.runtime?.readWasmMemory(entriesPtr, entriesOffset * entrySize);
    if (!entriesMemory) {
      this.log(`Error: cannot expand ${containerKind} at ${address}: ${containerKind} entries memory is unavailable`);
      return undefined;
    }

    return new DataView(entriesMemory.buffer, entriesMemory.byteOffset, entriesMemory.byteLength);
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

  private async decodeFieldVariable(view: DataView, field: ClassField): Promise<DebugSessionVariable> {
    const value = this.decodeFieldValue(view, field);
    const address = field.isReference ? this.parseObjectAddress(field.typeName, value) : undefined;
    if (address) {
      if (isDisplayableStringClass(field.typeName)) {
        const stringValue = await this.decodeStringAtAddress(field.typeName, address);
        return this.createClassVariable(field.name, field.typeName, address, stringValue);
      }

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

  private async decodeStringAtAddress(typeName: string, address: number): Promise<string> {
    assert.ok(isDisplayableStringClass(typeName));

    if (!this.runtime) {
      this.log(`Error: cannot decode string at ${address}: runtime is not active`);
      return "<unavailable>";
    }

    const sizeMemory = await this.runtime.readWasmMemory(address + OBJECT_RTSIZE_OFFSET, OBJECT_RTSIZE_SIZE);
    if (!sizeMemory) {
      this.log(`Error: cannot decode string at ${address}: string size memory is unavailable`);
      return "<unavailable>";
    }

    const sizeView = new DataView(sizeMemory.buffer, sizeMemory.byteOffset, sizeMemory.byteLength);
    const byteLength = sizeView.getUint32(0, true);
    const stringMemory = await this.runtime.readWasmMemory(address, byteLength);
    if (!stringMemory) {
      this.log(`Error: cannot decode string at ${address}: string payload memory is unavailable`);
      return "<unavailable>";
    }

    const encoding = typeName === UTF8_CONST_STR_CLASS_NAME ? "utf8" : "utf16le";
    return JSON.stringify(Buffer.from(stringMemory).toString(encoding));
  }

  private doContinueRequest(response: DebugProtocol.ContinueResponse): void {
    const runtime = this.runtime;
    if (!runtime) {
      this.sendErrorResponse(response, 1, "No active runtime");
      return;
    }

    response.body = { allThreadsContinued: true };

    if (this.stoppedForTrap) {
      this.sendResponse(response);
      this.log("Continue requested from wasm trap; terminating debug session");
      void this.disposeRuntimeAndTerminate(runtime);
      return;
    }

    this.cancelStep();
    void this.resumeRuntime(runtime);
    this.sendResponse(response);
  }

  private doStepRequest(
    response: DebugProtocol.StepInResponse | DebugProtocol.NextResponse | DebugProtocol.StepOutResponse,
    mode: StepMode
  ): void {
    const runtime = this.runtime;
    if (!runtime) {
      this.sendErrorResponse(response, 1, "No active runtime");
      return;
    }

    if (!runtime.isPaused()) {
      this.sendErrorResponse(response, 1, "Runtime is not paused");
      return;
    }

    if (this.stoppedForTrap) {
      this.sendResponse(response);
      this.log("Step requested from wasm trap; terminating debug session");
      void this.disposeRuntimeAndTerminate(runtime);
      return;
    }

    this.stepMode = mode;
    this.stepStartSourceLocation = this.resolveSourceLocation(this.stoppedWasmBytecodeOffset);
    this.clearVariableContainers();
    this.sendResponse(response);
    this.sendEvent(new ContinuedEvent(WarpoDebugSession.threadId, true));
    void this.advanceStep(runtime).catch((error: unknown) => {
      this.handleStepFailure(error);
    });
  }

  private async handleStepPause(runtime: Debugger, info: DebugPauseInfo): Promise<void> {
    try {
      if (this.hasReachedNextSourceLine(info.wasmBytecodeOffset)) {
        this.completeStep(runtime, info);
        return;
      }

      await this.advanceStep(runtime);
    } catch (error) {
      this.handleStepFailure(error);
    }
  }

  private handleNonStepPause(runtime: Debugger, info: DebugPauseInfo): void {
    this.cancelStep();
    if (this.runtime !== runtime) {
      return;
    }

    this.sendStoppedEvent(runtime, info);
  }

  private hasReachedNextSourceLine(wasmBytecodeOffset: number | undefined): boolean {
    const sourceLocation = this.resolveSourceLocation(wasmBytecodeOffset);
    if (!sourceLocation) {
      return false;
    }

    const startSourceLocation = this.stepStartSourceLocation;
    return (
      startSourceLocation === undefined ||
      sourceLocation.sourcePath !== startSourceLocation.sourcePath ||
      sourceLocation.sourceLine !== startSourceLocation.sourceLine
    );
  }

  private async advanceStep(runtime: Debugger): Promise<void> {
    if (this.runtime !== runtime || this.stepMode === StepMode.None) {
      return;
    }

    const wasmModule = this.loadedModule;
    const wasmBytecodeOffset = this.stoppedWasmBytecodeOffset;
    if (this.stepMode === StepMode.Out) {
      this.stepMode = StepMode.Into;
      await runtime.stepOut();
    } else if (
      this.stepMode === StepMode.Over &&
      wasmModule &&
      wasmBytecodeOffset !== undefined &&
      wasmModule.getNextBytecodeOffsetAfterCall(wasmBytecodeOffset) !== undefined
    ) {
      await runtime.stepOver();
    } else {
      // Source-level stepping advances through runtime primitives until the source location changes. Calls use the
      // runtime's call-aware operation because their following bytecode may be a structural `end`, not an executable instruction.
      await runtime.stepInstruction();
    }
  }

  private completeStep(runtime: Debugger, info: DebugPauseInfo): void {
    this.cancelStep();
    if (this.runtime !== runtime) {
      return;
    }

    this.clearVariableContainers();
    this.sendStoppedEvent(runtime, info);
  }

  private handleStepFailure(error: unknown): void {
    this.log(`Step failed: ${formatUnknownError(error)}`);
    this.cancelStep();
  }

  private cancelStep(): void {
    this.stepMode = StepMode.None;
    this.stepStartSourceLocation = undefined;
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

    void this.disposeRuntimeAndTerminate(runtime);
  }

  private async disposeRuntimeAndTerminate(runtime: Debugger): Promise<void> {
    if (this.runtime === runtime) {
      this.runtime = undefined;
    }
    try {
      await runtime.dispose();
    } catch (error) {
      this.log(`Failed to dispose runtime: ${formatUnknownError(error)}`);
    }
    this.resetRuntimeState();
    this.sendEvent(new TerminatedEvent());
  }

  private resetRuntimeState(): void {
    this.disposeLoadedModule();
    this.pendingBreakpointSources.clear();
    this.stoppedWasmBytecodeOffset = undefined;
    this.stoppedForTrap = false;
    this.stepMode = StepMode.None;
    this.stepStartSourceLocation = undefined;
  }

  private queueAllBreakpointUpdates(): void {
    for (const sourcePath of this.requestedBreakpointsBySource.keys()) {
      this.pendingBreakpointSources.add(sourcePath);
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

  private toDebugProtocolBreakpoint(breakpoint: DebuggerBreakpointInfo): DebugProtocol.Breakpoint {
    const dbp = new Breakpoint(breakpoint.verified, breakpoint.line) as DebugProtocol.Breakpoint;
    dbp.id = breakpoint.id;
    return dbp;
  }

  private requestBreakpointUpdate(onComplete?: () => void): void {
    this.log(
      `Breakpoint update requested: hasRuntime=${this.runtime !== undefined}, hasModule=${this.loadedModule !== undefined}, pendingSources=${this.pendingBreakpointSources.size}, runtimePaused=${this.runtime?.isPaused() ?? false}`
    );
    if (!this.runtime || !this.loadedModule || this.pendingBreakpointSources.size === 0) {
      this.log("Breakpoint update skipped: runtime, module, or pending source is unavailable");
      onComplete?.();
      return;
    }

    if (this.runtime.isPaused()) {
      this.applyPendingBreakpointUpdates(this.runtime, onComplete);
      return;
    }

    this.runtime.pause();
  }

  private maybeStartRuntime(): void {
    const runtime = this.runtime;
    if (!this.configurationDone || !runtime || !this.loadedModule) {
      return;
    }

    if (runtime.isPaused()) {
      void runtime.resume().catch((error: unknown) => {
        const message = error instanceof Error ? error.message : "unknown error";
        this.log(`Failed to resume after configuration: ${message}`);
      });
      return;
    }

    runtime.finishModuleLoad();
  }

  private applyPendingBreakpointUpdates(runtime: Debugger, onComplete?: () => void): void {
    const wasmModule = this.loadedModule;
    if (!wasmModule) {
      this.log("Breakpoint update skipped: no loaded wasm module");
      onComplete?.();
      return;
    }

    if (this.pendingBreakpointSources.size === 0) {
      this.log("Breakpoint update skipped: no pending breakpoint sources");
      onComplete?.();
      return;
    }

    this.log(
      `Applying breakpoint updates: requestedSources=${this.requestedBreakpointsBySource.size}, pendingSources=${this.pendingBreakpointSources.size}`
    );
    this.pendingBreakpointSources.clear();
    const wasmBytecodeOffsets = this.collectBreakpointOffsets(wasmModule);

    runtime.setWasmBreakpoints(
      wasmModule,
      Array.from(wasmBytecodeOffsets).toSorted((left, right) => left - right),
      {
        onSuccess: () => {
          this.log(
            `Breakpoint set installed: ${wasmBytecodeOffsets.size} locations, offsets=${
              Array.from(wasmBytecodeOffsets)
                .toSorted((left, right) => left - right)
                .join(",") || "none"
            }`
          );
          onComplete?.();
        },
        onError: (error) => {
          this.log(`Failed to update breakpoints: ${error.message}`);
          onComplete?.();
        },
      }
    );
  }

  private collectBreakpointOffsets(wasmModule: DebuggerWasmModule): Set<number> {
    const wasmBytecodeOffsets = new Set<number>();
    for (const [sourcePath, breakpoints] of this.requestedBreakpointsBySource) {
      for (const breakpoint of breakpoints) {
        this.collectBreakpointLocations(wasmModule, sourcePath, breakpoint, wasmBytecodeOffsets);
      }
    }
    return wasmBytecodeOffsets;
  }

  private collectBreakpointLocations(
    wasmModule: DebuggerWasmModule,
    sourcePath: string,
    breakpoint: DebuggerBreakpointInfo,
    wasmBytecodeOffsets: Set<number>
  ): void {
    const sourceMapHasSource = wasmModule.hasSource(sourcePath);
    this.log(
      `Resolving breakpoint: source=${sourcePath}, line=${breakpoint.line}, sourceMapHasSource=${sourceMapHasSource}`
    );
    const breakpointLocations = wasmModule.resolveBreakpointLocations(breakpoint);
    if (breakpointLocations.length > 0 && !breakpoint.verified) {
      breakpoint.verified = true;
      this.sendEvent(new BreakpointEvent("changed", this.toDebugProtocolBreakpoint(breakpoint)));
    }
    if (breakpointLocations.length === 0) {
      this.log(
        `Source-map lookup failed for breakpoint ${path.basename(sourcePath)}:${breakpoint.line}: ${
          sourceMapHasSource ? "source present but line has no mapping" : "source is absent"
        }`
      );
    }
    this.log(
      `Breakpoint resolution result: source=${sourcePath}, line=${breakpoint.line}, locations=${breakpointLocations.length}, offsets=${breakpointLocations.map((location) => location.wasmBytecodeOffset).join(",") || "none"}`
    );
    for (const location of breakpointLocations) {
      wasmBytecodeOffsets.add(location.wasmBytecodeOffset);
      this.log(`Resolved breakpoint ${path.basename(sourcePath)}:${breakpoint.line} -> ${location.wasmBytecodeOffset}`);
    }
  }

  private disposeLoadedModule(): void {
    this.clearVariableContainers();
    this.loadedModule?.dispose();
    this.loadedModule = undefined;
  }
}
