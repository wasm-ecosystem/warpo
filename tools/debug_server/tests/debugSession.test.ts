// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { DebugClient } from "@vscode/debugadapter-testsupport";
import type { DebugProtocol } from "@vscode/debugprotocol";
import * as assert from "node:assert/strict";
import * as path from "node:path";
import { describe, it, beforeEach, afterEach } from "node:test";
import { fileURLToPath } from "node:url";
import { launchDapServer, type DapServerHandle } from "./launcher.js";
import { build } from "../../scripts/lib.js";
import { normalizeDebugPath } from "../debugPath.js";

const DIRNAME = path.dirname(fileURLToPath(import.meta.url));
const DAP_SERVER = path.resolve(DIRNAME, "..", "..", "..", "dist", "debug_server", "dapServer.js");
const WARPO_CLI = path.resolve(DIRNAME, "..", "..", "..", "dist", "warpo.js");
const TEST_MODULE_DIR = path.resolve(DIRNAME, "testModule");

function sourcePath(name: string): string {
  return path.join(TEST_MODULE_DIR, name);
}

function outputPath(source: string): string {
  return path.join(TEST_MODULE_DIR, "build", `${path.basename(source, ".ts")}.wasm`);
}

async function buildModule(source: string, extraSources: string[] = []): Promise<string> {
  const output = outputPath(source);
  const name = path.basename(source, ".ts");
  let buildOutput = "";
  const exitCode = await build({
    argv: [source, ...extraSources, "-o", output, "--debug", "--use", "abort="],
    cwd: TEST_MODULE_DIR,
    onStdout: (chunk: string) => {
      buildOutput += chunk;
    },
  });
  if (exitCode !== 0) {
    throw new Error(`failed to build ${name} test module: ${buildOutput}`);
  }
  return output;
}

async function waitForLoadedWasmSource(dc: DebugClient, outputPath: string): Promise<DebugProtocol.LoadedSourceEvent> {
  while (true) {
    const event = await dc.waitForEvent("loadedSource");
    const body = event.body as { source?: DebugProtocol.Source; reason?: string } | undefined;
    if (body?.source?.path === path.resolve(outputPath)) {
      return event as DebugProtocol.LoadedSourceEvent;
    }
  }
}

async function waitForBreakpointStop(dc: DebugClient): Promise<DebugProtocol.StoppedEvent> {
  while (true) {
    const event = await dc.waitForEvent("stopped");
    const body = event.body as { reason?: string } | undefined;
    if (body?.reason === "breakpoint") {
      return event as DebugProtocol.StoppedEvent;
    }
  }
}

async function waitForStderrOutput(dc: DebugClient): Promise<DebugProtocol.OutputEvent> {
  while (true) {
    const event = await dc.waitForEvent("output");
    const body = event.body as { category?: string } | undefined;
    if (body?.category === "stderr") {
      return event as DebugProtocol.OutputEvent;
    }
  }
}

function assertDefined<T>(value: T | undefined, message?: string): T {
  if (value === undefined) {
    assert.fail(message ?? "Expected value to be defined");
  }
  return value;
}

function findVariable(variables: DebugProtocol.Variable[], name: string): DebugProtocol.Variable | undefined {
  return variables.find((candidate) => candidate.name === name || candidate.name.startsWith(`${name}: `));
}

async function launchAndWaitForBreakpoint(
  dc: DebugClient,
  launchArgs: DebugProtocol.LaunchRequestArguments
): Promise<void> {
  const stoppedPromise = waitForBreakpointStop(dc);
  await dc.launchRequest(launchArgs);
  await stoppedPromise;
}

async function readFrameLocals(
  dc: DebugClient,
  frame: DebugProtocol.StackFrame
): Promise<DebugProtocol.VariablesResponse> {
  const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
  const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:")));
  return dc.variablesRequest({ variablesReference: localsScope.variablesReference });
}

async function readFrameScopeByName(
  dc: DebugClient,
  frame: DebugProtocol.StackFrame,
  name: string
): Promise<DebugProtocol.VariablesResponse | undefined> {
  const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
  const scope = scopesResponse.body.scopes.find((candidate) => candidate.name === name);
  if (!scope) {
    return undefined;
  }
  return dc.variablesRequest({ variablesReference: scope.variablesReference });
}

async function launchAndReadTopFrameLocals(
  dc: DebugClient,
  launchArgs: DebugProtocol.LaunchRequestArguments
): Promise<{ frame: DebugProtocol.StackFrame; variablesResponse: DebugProtocol.VariablesResponse }> {
  await launchAndWaitForBreakpoint(dc, launchArgs);
  const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
  const frame = assertDefined(stackTraceResponse.body.stackFrames[0]);
  const variablesResponse = await readFrameLocals(dc, frame);
  return { frame, variablesResponse };
}

const waitForExit = (child: DapServerHandle["child"], timeoutMs: number): Promise<boolean> =>
  new Promise((resolve) => {
    if (child.exitCode !== null) {
      resolve(true);
      return;
    }

    const timer = setTimeout(() => {
      child.removeListener("exit", onExit);
      resolve(false);
    }, timeoutMs);

    const onExit = () => {
      clearTimeout(timer);
      resolve(true);
    };

    child.once("exit", onExit);
  });

void describe("WarpoDebugSession", () => {
  let dc: DebugClient;
  let serverChild: DapServerHandle["child"];

  beforeEach(async () => {
    const { port, child } = await launchDapServer(DAP_SERVER);
    serverChild = child;
    dc = new DebugClient("", "", "warpo");
    await dc.start(port);
  });

  afterEach(async () => {
    try {
      await dc.stop();
    } catch {
      // Ignore shutdown errors from the client.
    }

    const exited = await waitForExit(serverChild, 1000);
    if (!exited) {
      serverChild.kill();
      await waitForExit(serverChild, 1000);
    }
  });

  void it("should accept breakpoints and return them verified", async () => {
    await dc.initializeRequest();

    const response = await dc.setBreakpointsRequest({
      source: { path: "test.ts" },
      breakpoints: [{ line: 5 }, { line: 10 }],
    });

    assert.equal(response.body.breakpoints.length, 2);
    assert.equal(response.body.breakpoints[0].verified, true);
    assert.equal(response.body.breakpoints[0].line, 5);
    assert.equal(response.body.breakpoints[1].verified, true);
    assert.equal(response.body.breakpoints[1].line, 10);
  });

  void it("should stop in a unit test after returning from main", { timeout: 15000 }, async () => {
    const testSource = sourcePath("unittest_debug.case.ts");
    const implementationSource = sourcePath("unittest_debug.ts");

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: testSource },
      breakpoints: [{ line: 8 }],
    });
    await dc.setBreakpointsRequest({
      source: { path: implementationSource },
      breakpoints: [{ line: 5 }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      launchType: string;
      runtime: string;
      cwd: string;
      warpoPath: string;
    } = {
      launchType: "unittest",
      runtime: "node",
      cwd: TEST_MODULE_DIR,
      warpoPath: WARPO_CLI,
    };

    await launchAndWaitForBreakpoint(dc, launchArgs);
    let stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    assert.equal(
      assertDefined(stackTraceResponse.body.stackFrames[0]).source?.path,
      normalizeDebugPath(implementationSource)
    );
    assert.equal(stackTraceResponse.body.stackFrames[0].line, 5);

    const nextStop = waitForBreakpointStop(dc);
    await dc.continueRequest({ threadId: 1 });
    await nextStop;

    stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    assert.equal(assertDefined(stackTraceResponse.body.stackFrames[0]).source?.path, normalizeDebugPath(testSource));
    assert.equal(stackTraceResponse.body.stackFrames[0].line, 8);
  });

  void it("should report the built wasm as a loaded source on launch", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_basic.ts");
    const output = await buildModule(source);
    const breakpointLine = 13;

    await dc.initializeRequest();

    const breakpointResponse = await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });
    assert.equal(breakpointResponse.body.breakpoints.length, 1);
    assert.equal(breakpointResponse.body.breakpoints[0].verified, true);
    assert.equal(breakpointResponse.body.breakpoints[0].line, breakpointLine);

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const loadedSourcePromise = waitForLoadedWasmSource(dc, output);
    const stoppedPromise = waitForBreakpointStop(dc);

    await dc.launchRequest(launchArgs);

    const loadedSourceEvent = await loadedSourcePromise;
    const loadedSourceBody = loadedSourceEvent.body as { source?: DebugProtocol.Source; reason?: string } | undefined;
    await stoppedPromise;

    assert.equal(loadedSourceBody?.reason, "new");
    assert.equal(loadedSourceBody?.source?.path, path.resolve(output));
    assert.equal(loadedSourceBody?.source?.name, path.basename(output));
  });

  void it("should terminate when the runtime exits after wasm instantiation fails", { timeout: 5000 }, async () => {
    const source = sourcePath("import_failure.ts");
    const output = await buildModule(source);

    await dc.initializeRequest();

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stderrPromise = waitForStderrOutput(dc);
    const terminatedPromise = dc.waitForEvent("terminated");

    await dc.launchRequest(launchArgs);

    const stderrEvent = await stderrPromise;
    const stderrBody = stderrEvent.body as { output?: string } | undefined;
    assert.match(stderrBody?.output ?? "", /Failed to load wasm module/);
    await terminatedPromise;
  });

  void it("should expose local variables after hitting a breakpoint", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_basic.ts");
    const output = await buildModule(source);
    const breakpointLine = 13;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const { frame, variablesResponse } = await launchAndReadTopFrameLocals(dc, launchArgs);
    assert.equal(frame.source?.path, normalizeDebugPath(source));
    assert.equal(frame.line, breakpointLine);

    const a = assertDefined(variablesResponse.body.variables.find((candidate) => candidate.name === "a"));
    assert.equal(a.type, "i32");
    assert.equal(a.value, "1");

    const b = assertDefined(variablesResponse.body.variables.find((candidate) => candidate.name === "b"));
    assert.equal(b.type, "f32");

    const c = assertDefined(variablesResponse.body.variables.find((candidate) => candidate.name === "c"));
    assert.equal(c.type, "i64");

    const d = assertDefined(variablesResponse.body.variables.find((candidate) => candidate.name === "d"));
    assert.equal(d.type, "f64");
  });

  void it("should expose wasm call stack frames after hitting a breakpoint", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_basic.ts");
    const output = await buildModule(source);
    const breakpointLine = 13;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    await launchAndWaitForBreakpoint(dc, launchArgs);

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 20 });
    assert.ok(stackTraceResponse.body.stackFrames.length >= 2);

    const topFrame = stackTraceResponse.body.stackFrames[0];
    const callerFrame = stackTraceResponse.body.stackFrames[1];
    assert.match(topFrame.name, /calculate/);
    assert.equal(topFrame.source?.path, normalizeDebugPath(source));
    assert.equal(topFrame.line, breakpointLine);
    assert.match(callerFrame.name, /_start/);
    assert.equal(callerFrame.source?.path, normalizeDebugPath(source));

    const variablesResponse = await readFrameLocals(dc, topFrame);
    assertDefined(variablesResponse.body.variables.find((candidate) => candidate.name === "a"));

    const callerVariablesResponse = await readFrameLocals(dc, callerFrame);
    const callerSeed = assertDefined(
      callerVariablesResponse.body.variables.find((candidate) => candidate.name === "callerSeed")
    );
    assert.equal(callerSeed.type, "i32");
    assert.equal(callerSeed.value, "23");
  });

  void it("should expose local variables in separate scopes when shadowed", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_scopes.ts");
    const output = await buildModule(source);
    const breakpointLine = 12;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    await launchAndWaitForBreakpoint(dc, launchArgs);
    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = assertDefined(stackTraceResponse.body.stackFrames[0]);

    const localScope = assertDefined(await readFrameScopeByName(dc, frame, "Local: nestedScopes"));
    const localA = assertDefined(findVariable(localScope.body.variables, "a"));
    assert.equal(localA.value, "1");
    const localB = assertDefined(findVariable(localScope.body.variables, "b"));
    assert.equal(localB.value, "2");

    const blockScope = assertDefined(await readFrameScopeByName(dc, frame, "Block: nestedScopes"));
    const blockA = assertDefined(findVariable(blockScope.body.variables, "a"));
    assert.equal(blockA.value, "10");
    assert.equal(blockScope.body.variables.length, 1);
  });

  void it("should resolve call stack frames across multiple source files", { timeout: 5000 }, async () => {
    const entrySource = sourcePath("debugger_caller.ts");
    const calleeSource = sourcePath("debugger_callee.ts");
    const output = await buildModule(entrySource, [calleeSource]);
    const breakpointLine = 41;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: calleeSource },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    await launchAndWaitForBreakpoint(dc, launchArgs);

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 20 });
    assert.ok(stackTraceResponse.body.stackFrames.length >= 2);

    const topFrame = stackTraceResponse.body.stackFrames[0];
    const callerFrame = stackTraceResponse.body.stackFrames[1];
    assert.match(topFrame.name, /calculate/);
    assert.equal(topFrame.source?.path, normalizeDebugPath(calleeSource));
    assert.equal(topFrame.line, breakpointLine);
    assert.match(callerFrame.name, /_start/);
    assert.equal(callerFrame.source?.path, normalizeDebugPath(entrySource));

    const variablesResponse = await readFrameLocals(dc, topFrame);
    assertDefined(variablesResponse.body.variables.find((candidate) => candidate.name === "a"));

    const callerVariablesResponse = await readFrameLocals(dc, callerFrame);
    const callerSeed = assertDefined(
      callerVariablesResponse.body.variables.find((candidate) => candidate.name === "callerSeed")
    );
    assert.equal(callerSeed.type, "i32");
    assert.equal(callerSeed.value, "23");
  });

  void it("should terminate when the entry function returns", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_class.ts");
    const output = await buildModule(source);
    const breakpointLine = 45;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const { variablesResponse } = await launchAndReadTopFrameLocals(dc, launchArgs);
    const holder = assertDefined(findVariable(variablesResponse.body.variables, "holder"));
    await dc.variablesRequest({ variablesReference: holder.variablesReference });

    const terminatedPromise = dc.waitForEvent("terminated");
    await dc.continueRequest({ threadId: 1 });
    await terminatedPromise;
  });

  void it("should expand class local variables using DWARF layout", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_class.ts");
    const output = await buildModule(source);
    const breakpointLine = 45;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:")));

    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });
    const holder = assertDefined(findVariable(variablesResponse.body.variables, "holder"));
    assert.ok(holder.variablesReference > 0);
    assert.match(holder.name, /^holder: .+Holder$/);
    assert.ok(holder.type?.endsWith("Holder"));
    assert.equal(holder.value, "");

    const holderFieldsResponse = await dc.variablesRequest({ variablesReference: holder.variablesReference });
    const count = assertDefined(holderFieldsResponse.body.variables.find((candidate) => candidate.name === "count"));
    assert.equal(count.type, "i32");
    assert.equal(count.value, "7");

    const child = assertDefined(findVariable(holderFieldsResponse.body.variables, "child"));
    assert.ok(child.type?.endsWith("Child"));
    assert.ok(child.variablesReference > 0);
    assert.equal(child.value, "");

    const childFieldsResponse = await dc.variablesRequest({ variablesReference: child.variablesReference });
    const value = assertDefined(childFieldsResponse.body.variables.find((candidate) => candidate.name === "value"));
    assert.equal(value.type, "i32");
    assert.equal(value.value, "11");

    const box = assertDefined(findVariable(variablesResponse.body.variables, "box"));
    assert.ok(box.type?.endsWith("BaseBox"));
    assert.ok(box.variablesReference > 0);
    assert.equal(box.value, "");

    const boxFieldsResponse = await dc.variablesRequest({ variablesReference: box.variablesReference });
    const base = assertDefined(boxFieldsResponse.body.variables.find((candidate) => candidate.name === "base"));
    assert.equal(base.type, "i32");
    assert.equal(base.value, "3");
    const extra = assertDefined(boxFieldsResponse.body.variables.find((candidate) => candidate.name === "extra"));
    assert.equal(extra.type, "i32");
    assert.equal(extra.value, "17");
  });

  void it("should display string objects without expanding them", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_string.ts");
    const output = await buildModule(source);
    const breakpointLine = 18;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:")));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });

    const message = assertDefined(variablesResponse.body.variables.find((candidate) => candidate.name === "message"));
    assert.equal(message.type, "~lib/string/String");
    assert.equal(message.value, '"hello debugger"');
    assert.equal(message.variablesReference, 0);

    const holder = assertDefined(findVariable(variablesResponse.body.variables, "holder"));
    assert.ok(holder.type?.endsWith("StringHolder"));
    assert.ok(holder.variablesReference > 0);
    assert.equal(holder.value, "");

    const holderFieldsResponse = await dc.variablesRequest({ variablesReference: holder.variablesReference });
    const label = assertDefined(holderFieldsResponse.body.variables.find((candidate) => candidate.name === "label"));
    assert.equal(label.type, "~lib/string/String");
    assert.equal(label.value, '"first holder"');
    assert.equal(label.variablesReference, 0);
  });

  void it("should expand array elements by index", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_array.ts");
    const output = await buildModule(source);
    const breakpointLine = 9;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:")));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });

    const values = assertDefined(findVariable(variablesResponse.body.variables, "values"));
    assert.ok(values.type?.startsWith("~lib/array/Array<"));
    assert.ok(values.variablesReference > 0);
    assert.equal(values.value, "");

    const elementsResponse = await dc.variablesRequest({ variablesReference: values.variablesReference });
    assert.deepEqual(
      elementsResponse.body.variables.map((variable) => ({
        name: variable.name,
        type: variable.type,
        value: variable.value,
        variablesReference: variable.variablesReference,
      })),
      [
        { name: "0", type: "i32", value: "3", variablesReference: 0 },
        { name: "1", type: "i32", value: "5", variablesReference: 0 },
        { name: "2", type: "i32", value: "8", variablesReference: 0 },
      ]
    );
  });

  void it("should expand class array elements as objects", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_class_array.ts");
    const output = await buildModule(source);
    const breakpointLine = 17;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:")));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });

    const children = assertDefined(findVariable(variablesResponse.body.variables, "children"));
    assert.ok(children.type?.startsWith("~lib/array/Array<"));
    assert.ok(children.variablesReference > 0);
    assert.equal(children.value, "");

    const elementsResponse = await dc.variablesRequest({ variablesReference: children.variablesReference });
    const firstChild = assertDefined(findVariable(elementsResponse.body.variables, "0"));
    assert.ok(firstChild.type?.endsWith("Child"));
    assert.ok(firstChild.variablesReference > 0);
    assert.equal(firstChild.value, "");

    const secondChild = assertDefined(findVariable(elementsResponse.body.variables, "1"));
    assert.ok(secondChild.type?.endsWith("Child"));
    assert.ok(secondChild.variablesReference > 0);
    assert.equal(secondChild.value, "");

    const firstChildFieldsResponse = await dc.variablesRequest({ variablesReference: firstChild.variablesReference });
    const firstValue = assertDefined(
      firstChildFieldsResponse.body.variables.find((candidate) => candidate.name === "value")
    );
    assert.equal(firstValue.type, "i32");
    assert.equal(firstValue.value, "21");

    const secondChildFieldsResponse = await dc.variablesRequest({ variablesReference: secondChild.variablesReference });
    const secondValue = assertDefined(
      secondChildFieldsResponse.body.variables.find((candidate) => candidate.name === "value")
    );
    assert.equal(secondValue.type, "i32");
    assert.equal(secondValue.value, "34");
  });

  void it("should expand tuple elements by index", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_tuple.ts");
    const output = await buildModule(source);
    const breakpointLine = 17;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:")));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });

    const values = assertDefined(findVariable(variablesResponse.body.variables, "values"));
    assert.equal(values.type, "~lib/tuple/SmallTuple");
    assert.ok(values.variablesReference > 0);
    assert.equal(values.value, "");

    const elementsResponse = await dc.variablesRequest({ variablesReference: values.variablesReference });
    const first = assertDefined(elementsResponse.body.variables.find((candidate) => candidate.name === "0"));
    assert.equal(first.type, "usize");
    assert.equal(first.value, "89");
    assert.equal(first.variablesReference, 0);

    const second = assertDefined(elementsResponse.body.variables.find((candidate) => candidate.name === "1"));
    assert.equal(second.type, "~lib/string/String");
    assert.equal(second.value, '"tuple value"');
    assert.equal(second.variablesReference, 0);

    const third = assertDefined(findVariable(elementsResponse.body.variables, "2"));
    assert.ok(third.type?.endsWith("Child"));
    assert.ok(third.variablesReference > 0);
    assert.equal(third.value, "");

    const childFieldsResponse = await dc.variablesRequest({ variablesReference: third.variablesReference });
    const value = assertDefined(childFieldsResponse.body.variables.find((candidate) => candidate.name === "value"));
    assert.equal(value.type, "i32");
    assert.equal(value.value, "55");
  });

  void it("should expand static array elements by index", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_static_array.ts");
    const output = await buildModule(source);
    const breakpointLine = 23;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:")));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });

    const values = assertDefined(findVariable(variablesResponse.body.variables, "values"));
    assert.ok(values.type?.startsWith("~lib/staticarray/StaticArray<"));
    assert.ok(values.variablesReference > 0);
    assert.equal(values.value, "");

    const valueElementsResponse = await dc.variablesRequest({ variablesReference: values.variablesReference });
    assert.deepEqual(
      valueElementsResponse.body.variables.map((variable) => variable.name),
      ["0", "1", "2"]
    );
    assert.deepEqual(
      valueElementsResponse.body.variables.map((variable) => ({
        name: variable.name,
        type: variable.type,
        value: variable.value,
        variablesReference: variable.variablesReference,
      })),
      [
        { name: "0", type: "i32", value: "13", variablesReference: 0 },
        { name: "1", type: "i32", value: "21", variablesReference: 0 },
        { name: "2", type: "i32", value: "34", variablesReference: 0 },
      ]
    );

    const children = assertDefined(findVariable(variablesResponse.body.variables, "children"));
    assert.ok(children.type?.startsWith("~lib/staticarray/StaticArray<"));
    assert.ok(children.variablesReference > 0);
    assert.equal(children.value, "");

    const childElementsResponse = await dc.variablesRequest({ variablesReference: children.variablesReference });
    const firstChild = assertDefined(findVariable(childElementsResponse.body.variables, "0"));
    assert.ok(firstChild.type?.endsWith("Child"));
    assert.ok(firstChild.variablesReference > 0);
    assert.equal(firstChild.value, "");

    const secondChild = assertDefined(findVariable(childElementsResponse.body.variables, "1"));
    assert.ok(secondChild.type?.endsWith("Child"));
    assert.ok(secondChild.variablesReference > 0);
    assert.equal(secondChild.value, "");

    const firstChildFieldsResponse = await dc.variablesRequest({ variablesReference: firstChild.variablesReference });
    const firstValue = assertDefined(
      firstChildFieldsResponse.body.variables.find((candidate) => candidate.name === "value")
    );
    assert.equal(firstValue.type, "i32");
    assert.equal(firstValue.value, "44");

    const secondChildFieldsResponse = await dc.variablesRequest({ variablesReference: secondChild.variablesReference });
    const secondValue = assertDefined(
      secondChildFieldsResponse.body.variables.find((candidate) => candidate.name === "value")
    );
    assert.equal(secondValue.type, "i32");
    assert.equal(secondValue.value, "55");
  });

  void it("should expand set elements by index", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_set.ts");
    const output = await buildModule(source);
    const breakpointLine = 25;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:")));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });

    const values = assertDefined(findVariable(variablesResponse.body.variables, "values"));
    assert.ok(values.type?.startsWith("~lib/set/Set<"));
    assert.ok(values.variablesReference > 0);
    assert.equal(values.value, "");

    const valueElementsResponse = await dc.variablesRequest({ variablesReference: values.variablesReference });
    assert.deepEqual(
      valueElementsResponse.body.variables.map((variable) => ({
        name: variable.name,
        type: variable.type,
        value: variable.value,
        variablesReference: variable.variablesReference,
      })),
      [
        { name: "0", type: "i32", value: "5", variablesReference: 0 },
        { name: "1", type: "i32", value: "8", variablesReference: 0 },
        { name: "2", type: "i32", value: "13", variablesReference: 0 },
      ]
    );

    const children = assertDefined(findVariable(variablesResponse.body.variables, "children"));
    assert.ok(children.type?.startsWith("~lib/set/Set<"));
    assert.ok(children.variablesReference > 0);
    assert.equal(children.value, "");

    const childElementsResponse = await dc.variablesRequest({ variablesReference: children.variablesReference });
    const firstChild = assertDefined(findVariable(childElementsResponse.body.variables, "0"));
    assert.ok(firstChild.type?.endsWith("Child"));
    assert.ok(firstChild.variablesReference > 0);
    assert.equal(firstChild.value, "");

    const secondChild = assertDefined(findVariable(childElementsResponse.body.variables, "1"));
    assert.ok(secondChild.type?.endsWith("Child"));
    assert.ok(secondChild.variablesReference > 0);
    assert.equal(secondChild.value, "");

    const firstChildFieldsResponse = await dc.variablesRequest({ variablesReference: firstChild.variablesReference });
    const firstValue = assertDefined(
      firstChildFieldsResponse.body.variables.find((candidate) => candidate.name === "value")
    );
    assert.equal(firstValue.type, "i32");
    assert.equal(firstValue.value, "61");

    const secondChildFieldsResponse = await dc.variablesRequest({ variablesReference: secondChild.variablesReference });
    const secondValue = assertDefined(
      secondChildFieldsResponse.body.variables.find((candidate) => candidate.name === "value")
    );
    assert.equal(secondValue.type, "i32");
    assert.equal(secondValue.value, "89");
  });

  void it("should expand map entries by index", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_map.ts");
    const output = await buildModule(source);
    const breakpointLine = 26;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:")));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });

    const values = assertDefined(findVariable(variablesResponse.body.variables, "values"));
    assert.ok(values.type?.startsWith("~lib/map/Map<"));
    assert.ok(values.variablesReference > 0);
    assert.equal(values.value, "");

    const entriesResponse = await dc.variablesRequest({ variablesReference: values.variablesReference });
    assert.deepEqual(
      entriesResponse.body.variables.map((variable) => variable.name),
      ["0", "1"]
    );
    const firstEntry = assertDefined(entriesResponse.body.variables.find((candidate) => candidate.name === "0"));
    assert.equal(firstEntry.value, "");
    assert.ok(firstEntry.variablesReference > 0);

    const secondEntry = assertDefined(entriesResponse.body.variables.find((candidate) => candidate.name === "1"));
    assert.equal(secondEntry.value, "");
    assert.ok(secondEntry.variablesReference > 0);

    const firstEntryFieldsResponse = await dc.variablesRequest({ variablesReference: firstEntry.variablesReference });
    assert.deepEqual(
      firstEntryFieldsResponse.body.variables.map((variable) => variable.name),
      ["key", "value: debugger_map/Child"]
    );
    const firstKey = assertDefined(
      firstEntryFieldsResponse.body.variables.find((candidate) => candidate.name === "key")
    );
    assert.equal(firstKey.type, "i32");
    assert.equal(firstKey.value, "5");
    assert.equal(firstKey.variablesReference, 0);

    const firstValue = assertDefined(findVariable(firstEntryFieldsResponse.body.variables, "value"));
    assert.match(firstValue.name, /^value: .+Child$/);
    assert.ok(firstValue.type?.endsWith("Child"));
    assert.ok(firstValue.variablesReference > 0);
    assert.equal(firstValue.value, "");

    const secondEntryFieldsResponse = await dc.variablesRequest({ variablesReference: secondEntry.variablesReference });
    assert.deepEqual(
      secondEntryFieldsResponse.body.variables.map((variable) => variable.name),
      ["key", "value: debugger_map/Child"]
    );
    const secondKey = assertDefined(
      secondEntryFieldsResponse.body.variables.find((candidate) => candidate.name === "key")
    );
    assert.equal(secondKey.type, "i32");
    assert.equal(secondKey.value, "8");
    assert.equal(secondKey.variablesReference, 0);

    const secondValue = assertDefined(findVariable(secondEntryFieldsResponse.body.variables, "value"));
    assert.match(secondValue.name, /^value: .+Child$/);
    assert.ok(secondValue.type?.endsWith("Child"));
    assert.ok(secondValue.variablesReference > 0);
    assert.equal(secondValue.value, "");

    const firstValueFieldsResponse = await dc.variablesRequest({ variablesReference: firstValue.variablesReference });
    const firstChildValue = assertDefined(
      firstValueFieldsResponse.body.variables.find((candidate) => candidate.name === "value")
    );
    assert.equal(firstChildValue.type, "i32");
    assert.equal(firstChildValue.value, "144");

    const secondValueFieldsResponse = await dc.variablesRequest({ variablesReference: secondValue.variablesReference });
    const secondChildValue = assertDefined(
      secondValueFieldsResponse.body.variables.find((candidate) => candidate.name === "value")
    );
    assert.equal(secondChildValue.type, "i32");
    assert.equal(secondChildValue.value, "233");

    const numericValues = assertDefined(findVariable(variablesResponse.body.variables, "numericValues"));
    assert.ok(numericValues.type?.startsWith("~lib/map/Map<"));
    assert.ok(numericValues.variablesReference > 0);
    assert.equal(numericValues.value, "");

    const numericEntriesResponse = await dc.variablesRequest({ variablesReference: numericValues.variablesReference });
    assert.deepEqual(
      numericEntriesResponse.body.variables.map((variable) => variable.name),
      ["0", "1"]
    );

    const numericEntryFields = await Promise.all(
      numericEntriesResponse.body.variables.map((entry) =>
        dc.variablesRequest({ variablesReference: entry.variablesReference })
      )
    );
    assert.deepEqual(
      numericEntryFields.map((response) =>
        response.body.variables.map((variable) => ({ name: variable.name, type: variable.type, value: variable.value }))
      ),
      [
        [
          { name: "key", type: "f64", value: "1" },
          { name: "value", type: "f64", value: "100" },
        ],
        [
          { name: "key", type: "f64", value: "2" },
          { name: "value", type: "f64", value: "200" },
        ],
      ]
    );
  });

  void it("should expose closure locals by source name", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_closure.ts");
    const output = await buildModule(source);
    const breakpointLine = 36;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const scopes = scopesResponse.body.scopes;
    const scopeNames = scopes.map((scope) => scope.name);
    assert.deepEqual(scopeNames, [
      "Local: run~middle~inner~anonymous|0",
      "Scope",
      "Scope",
      "Closure(inner)",
      "Closure(middle)",
      "Closure(run)",
      "Global",
    ]);

    const localScope = assertDefined(scopes.find((scope) => scope.name === "Local: run~middle~inner~anonymous|0"));
    const lexicalScopes = scopes.filter((scope) => scope.name === "Scope");
    assert.equal(lexicalScopes.length, 2);
    const innerScope = assertDefined(scopes.find((scope) => scope.name === "Closure(inner)"));
    const middleScope = assertDefined(scopes.find((scope) => scope.name === "Closure(middle)"));
    const runScope = assertDefined(scopes.find((scope) => scope.name === "Closure(run)"));
    const [
      localVariablesResponse,
      ifScopeResponse,
      loopScopeResponse,
      innerVariablesResponse,
      middleVariablesResponse,
      runVariablesResponse,
    ] = await Promise.all([
      dc.variablesRequest({ variablesReference: localScope.variablesReference }),
      dc.variablesRequest({ variablesReference: lexicalScopes[0].variablesReference }),
      dc.variablesRequest({ variablesReference: lexicalScopes[1].variablesReference }),
      dc.variablesRequest({ variablesReference: innerScope.variablesReference }),
      dc.variablesRequest({ variablesReference: middleScope.variablesReference }),
      dc.variablesRequest({ variablesReference: runScope.variablesReference }),
    ]);

    const delta = assertDefined(findVariable(localVariablesResponse.body.variables, "delta"));
    assert.equal(delta.type, "i32");
    assert.equal(delta.value, "5");
    const inside = assertDefined(findVariable(localVariablesResponse.body.variables, "inside"));
    assert.equal(inside.type, "i32");
    assert.equal(inside.value, "11193");

    const ifA = assertDefined(findVariable(ifScopeResponse.body.variables, "ifA"));
    assert.equal(ifA.type, "i32");
    assert.equal(ifA.value, "10000");
    const loopA = assertDefined(findVariable(loopScopeResponse.body.variables, "loopA"));
    assert.equal(loopA.type, "i32");
    assert.equal(loopA.value, "1000");

    const innerA = assertDefined(findVariable(innerVariablesResponse.body.variables, "innerA"));
    assert.equal(innerA.type, "i32");
    assert.equal(innerA.value, "100");

    const middleA = assertDefined(findVariable(middleVariablesResponse.body.variables, "middleA"));
    assert.equal(middleA.type, "i32");
    assert.equal(middleA.value, "10");
    assert.equal(findVariable(middleVariablesResponse.body.variables, "middleNotCaptured"), undefined);

    const outerA = assertDefined(findVariable(runVariablesResponse.body.variables, "outerA"));
    assert.equal(outerA.type, "i32");
    assert.equal(outerA.value, "1");
    assert.equal(findVariable(runVariablesResponse.body.variables, "runNotCaptured"), undefined);
    const child = assertDefined(findVariable(runVariablesResponse.body.variables, "child"));
    assert.ok(child.type?.endsWith("Child"));
    assert.ok(child.variablesReference > 0);
    const childFieldsResponse = await dc.variablesRequest({ variablesReference: child.variablesReference });
    const childValue = assertDefined(findVariable(childFieldsResponse.body.variables, "value"));
    assert.equal(childValue.type, "i32");
    assert.equal(childValue.value, "77");
  });

  void it("should expose and decode global variables", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_global.ts");
    const output = await buildModule(source);

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: 11 }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };
    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = assertDefined(stackTraceResponse.body.stackFrames[0]);
    const globalScope = assertDefined(await readFrameScopeByName(dc, frame, "Global"));

    const globalCounter = assertDefined(
      globalScope.body.variables.find((variable) => variable.name.endsWith("/globalCounter"))
    );
    assert.equal(globalCounter.type, "i32");
    assert.equal(globalCounter.value, "24");

    const message = assertDefined(
      globalScope.body.variables.find((variable) => variable.name.endsWith("/globalMessage"))
    );
    assert.equal(message.type, "~lib/string/String");
    assert.equal(message.value, '"global debugger"');
    assert.equal(message.variablesReference, 0);

    const values = assertDefined(findVariable(globalScope.body.variables, "debugger_global/globalValues"));
    assert.ok(values.type?.startsWith("~lib/array/Array<"));
    const valueElements = await dc.variablesRequest({ variablesReference: values.variablesReference });
    assert.deepEqual(
      valueElements.body.variables.map((variable) => variable.value),
      ["13", "21"]
    );

    const entries = assertDefined(findVariable(globalScope.body.variables, "debugger_global/globalEntries"));
    assert.ok(entries.type?.startsWith("~lib/map/Map<"));
    const mapEntries = await dc.variablesRequest({ variablesReference: entries.variablesReference });
    assert.equal(mapEntries.body.variables.length, 1);
    const entryFields = await dc.variablesRequest({
      variablesReference: mapEntries.body.variables[0].variablesReference,
    });
    assert.deepEqual(
      entryFields.body.variables.map((variable) => ({ name: variable.name, value: variable.value })),
      [
        { name: "key", value: "5" },
        { name: "value", value: "34" },
      ]
    );
  });

  void it("should refresh variable references across multiple pauses", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_class.ts");
    const output = await buildModule(source);
    const firstBreakpointLine = 45;
    const secondBreakpointLine = 47;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: firstBreakpointLine }, { line: secondBreakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const firstStoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await firstStoppedPromise;

    const firstStackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const firstScopesResponse = await dc.scopesRequest({ frameId: firstStackTraceResponse.body.stackFrames[0].id });
    const firstLocalsScope = assertDefined(
      firstScopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:"))
    );

    const firstVariablesResponse = await dc.variablesRequest({
      variablesReference: firstLocalsScope.variablesReference,
    });
    const firstHolder = assertDefined(findVariable(firstVariablesResponse.body.variables, "holder"));
    assert.ok(firstHolder.variablesReference > 0);
    assert.ok(firstHolder.type?.endsWith("Holder"));
    assert.equal(firstHolder.value, "");

    const firstHolderFieldsResponse = await dc.variablesRequest({ variablesReference: firstHolder.variablesReference });
    const firstCount = assertDefined(
      firstHolderFieldsResponse.body.variables.find((candidate) => candidate.name === "count")
    );
    assert.equal(firstCount.value, "7");

    const secondStoppedPromise = waitForBreakpointStop(dc);
    await dc.continueRequest({ threadId: 1 });
    await secondStoppedPromise;

    const staleHolderFieldsResponse = await dc.variablesRequest({ variablesReference: firstHolder.variablesReference });
    assert.deepEqual(staleHolderFieldsResponse.body.variables, []);

    const secondStackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const secondScopesResponse = await dc.scopesRequest({ frameId: secondStackTraceResponse.body.stackFrames[0].id });
    const secondLocalsScope = assertDefined(
      secondScopesResponse.body.scopes.find((scope) => scope.name.startsWith("Local:"))
    );

    const secondVariablesResponse = await dc.variablesRequest({
      variablesReference: secondLocalsScope.variablesReference,
    });
    const secondHolder = assertDefined(findVariable(secondVariablesResponse.body.variables, "holder"));
    assert.ok(secondHolder.variablesReference > 0);
    assert.notEqual(secondHolder.variablesReference, firstHolder.variablesReference);
    assert.ok(secondHolder.type?.endsWith("Holder"));
    assert.equal(secondHolder.value, "");

    const secondHolderFieldsResponse = await dc.variablesRequest({
      variablesReference: secondHolder.variablesReference,
    });
    const secondCount = assertDefined(
      secondHolderFieldsResponse.body.variables.find((candidate) => candidate.name === "count")
    );
    assert.equal(secondCount.value, "9");
  });

  void it("should expose closure locals captured in an if scope", { timeout: 5000 }, async () => {
    const source = sourcePath("debugger_closure_if.ts");
    const output = await buildModule(source);
    const breakpointLine = 14;

    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: source },
      breakpoints: [{ line: breakpointLine }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: output,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    await launchAndWaitForBreakpoint(dc, launchArgs);
    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = assertDefined(stackTraceResponse.body.stackFrames[0]);

    const localScope = assertDefined(await readFrameScopeByName(dc, frame, "Local: foo"));
    const a = assertDefined(findVariable(localScope.body.variables, "a"));
    assert.equal(a.type, "i32");
    assert.equal(a.value, "1");

    const blockScope = assertDefined(await readFrameScopeByName(dc, frame, "Block: foo"));
    const b = assertDefined(findVariable(blockScope.body.variables, "b"));
    assert.equal(b.type, "i32");
    assert.equal(b.value, "2");
  });
});
