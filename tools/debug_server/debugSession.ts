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
import type { DebuggerBreakpointInfo, DebuggerSourceVariableInfo, DebuggerWasmModule } from "./debuggerWasmModule.js";
import type { DebugPauseInfo, Debugger, DebugRuntimeVariable } from "./debugger.js";
import { NodeDebugger } from "./nodeDebugger.js";

interface WarpoLaunchRequestArguments extends DebugProtocol.LaunchRequestArguments {
  program?: string;
  launchType?: string;
  runtime?: string;
  entryFunctionName?: string;
  cwd?: string;
  warpoPath?: string;
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
  displayValue?: string;
}

interface MapEntryVariable {
  kind: "map-entry";
  name: string;
  key: DebugSessionVariable;
  value: DebugSessionVariable;
}

type DebugSessionVariable = BasicVariable | ClassVariable | MapEntryVariable;

interface RawLocalValue {
  name: string;
  value: string;
  typeName: string | undefined;
}

interface RawTupleElementValue {
  value: string;
  isReference: boolean;
}

type VariableContainer =
  | { kind: "locals"; frameId: number; scopeIndex: number }
  | { kind: "object"; address: number }
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
  private pausedStackFramesById = new Map<number, PausedStackFrame>();
  private nextVariablesReference = 1;
  private loadedModule: DebuggerWasmModule | undefined;
  private runtime: Debugger | undefined;
  private stoppedWasmBytecodeOffset: number | undefined;
  private stoppedForTrap = false;
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
      const launchType = args.launchType ?? "wasm file";
      const program =
        launchType === "unittest"
          ? path.join(args.cwd ?? process.cwd(), "build_coverage", "test.instrumented.wasm")
          : args.program;
      if (!program) {
        this.sendErrorResponse(response, 1, "No program specified for launch");
        return;
      }
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
        await runtime.launch(
          launchType === "unittest"
            ? {
                wasmFilePath: path.resolve(program),
                cwd: args.cwd ?? process.cwd(),
                warpoPath: args.warpoPath,
              }
            : {
                wasmFilePath: path.resolve(program),
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

  protected disconnectRequest(
    response: DebugProtocol.DisconnectResponse,
    _args: DebugProtocol.DisconnectArguments
  ): void {
    this.runtime?.dispose();
    this.runtime = undefined;
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
    const closureTupleValuesByLevel = await this.readClosureTupleChain(
      sourceVariableScope.rootClosureEnvLocalIndex,
      runtimeVariablesByIndex
    );

    const scopeTupleLevel = sourceVariableScope.tupleLevel ?? 0;
    const rawLocalValues = sourceVariables.map((variable): RawLocalValue => {
      if (variable.kind === "closure") {
        const elementIndex = variable.fieldOffset / SMALL_TUPLE_SLOT_SIZE;
        const levelValues = closureTupleValuesByLevel.get(scopeTupleLevel);
        const tupleRawValue = levelValues?.get(elementIndex);
        if (tupleRawValue === undefined) {
          return { name: variable.name, value: "<unavailable>", typeName: variable.typeName };
        }

        return { name: variable.name, value: tupleRawValue, typeName: variable.typeName };
      }

      const wasmRawValue = rawWasmValues.get(variable);
      assert(wasmRawValue !== undefined);
      return { name: variable.name, value: wasmRawValue, typeName: variable.typeName };
    });

    const variables = await Promise.all(
      rawLocalValues.map((variable) =>
        this.toDebugSessionVariableValue(variable.name, variable.typeName, variable.value)
      )
    );
    return variables.map((variable) => this.toDebugProtocolVariable(variable));
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

  private async readClosureTupleChain(
    closureEnvLocalIndex: number | undefined,
    runtimeVariablesByIndex: Map<number, DebugRuntimeVariable>
  ): Promise<Map<number, Map<number, string>>> {
    const closureTupleValuesByLevel = new Map<number, Map<number, string>>();
    if (closureEnvLocalIndex === undefined) {
      return closureTupleValuesByLevel;
    }

    const closureEnvVariable = runtimeVariablesByIndex.get(closureEnvLocalIndex);
    if (closureEnvVariable === undefined) {
      return closureTupleValuesByLevel;
    }

    let address = Number(closureEnvVariable.value);
    if (!Number.isInteger(address) || address <= 0) {
      return closureTupleValuesByLevel;
    }

    let level = 0;
    while (true) {
      const tupleValues = await this.readTupleElementValues(address);
      const levelValues = new Map<number, string>();
      for (const [index, value] of tupleValues.entries()) {
        levelValues.set(index, value.value);
      }
      closureTupleValuesByLevel.set(level, levelValues);

      const parentAddress = levelValues.get(0);
      if (parentAddress === undefined) {
        break;
      }
      const parentAddressNumber = Number(parentAddress);
      if (!Number.isInteger(parentAddressNumber) || parentAddressNumber <= 0) {
        break;
      }

      address = parentAddressNumber;
      level++;
    }

    return closureTupleValuesByLevel;
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
        if (typeName === AS_STRING_CLASS_NAME) {
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
    }
  }

  private getVariableReference(variable: DebugSessionVariable, isExpandableClass: boolean): number {
    if (isExpandableClass && variable.kind === "class") {
      return this.toObjectVariablesReference(variable.address);
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

  private async resolveRuntimeObjectPayloadSize(
    address: number,
    classLayout: ClassLayout
  ): Promise<number | undefined> {
    if (
      classLayout.builtinKind !== BuiltinContainerKind.SmallTuple &&
      classLayout.builtinKind !== BuiltinContainerKind.StaticArray
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

    if (classLayout.name === AS_STRING_CLASS_NAME) {
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
      if (field.typeName === AS_STRING_CLASS_NAME) {
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
    assert.equal(typeName, AS_STRING_CLASS_NAME);

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

    return JSON.stringify(Buffer.from(stringMemory).toString("utf16le"));
  }

  private doContinueRequest(response: DebugProtocol.ContinueResponse): void {
    const runtime = this.runtime;
    if (!runtime) {
      this.sendErrorResponse(response, 1, "No active runtime");
      return;
    }

    response.body = { allThreadsContinued: true };
    this.sendResponse(response);

    if (this.stoppedForTrap) {
      this.log("Continue requested from wasm trap; terminating debug session");
      this.disposeRuntimeAndTerminate(runtime);
      return;
    }

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

    this.disposeRuntimeAndTerminate(runtime);
  }

  private disposeRuntimeAndTerminate(runtime: Debugger): void {
    runtime.dispose();
    if (this.runtime === runtime) {
      this.runtime = undefined;
    }
    this.resetRuntimeState();
    this.sendEvent(new TerminatedEvent());
  }

  private resetRuntimeState(): void {
    this.disposeLoadedModule();
    this.pendingBreakpointUpdatesBySource.clear();
    this.stoppedWasmBytecodeOffset = undefined;
    this.stoppedForTrap = false;
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
