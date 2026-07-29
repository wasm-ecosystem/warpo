// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { DebugClient } from "@vscode/debugadapter-testsupport";
import type { DebugProtocol } from "@vscode/debugprotocol";
import * as assert from "node:assert/strict";
import * as path from "node:path";
import { describe, it, before, beforeEach, afterEach } from "node:test";
import { fileURLToPath } from "node:url";
import { launchDapServer, type DapServerHandle } from "./launcher.js";
import { build } from "../../scripts/lib.js";
import { normalizeDebugPath } from "../debugPath.js";

const DIRNAME = path.dirname(fileURLToPath(import.meta.url));
const DAP_SERVER = path.resolve(DIRNAME, "..", "..", "..", "dist", "debug_server", "dapServer.js");
const TEST_MODULE_DIR = path.resolve(DIRNAME, "testModule");
const TEST_MODULE_SOURCE = path.join(TEST_MODULE_DIR, "debugger_basic.ts");
const TEST_MODULE_CALLEE_SOURCE = path.join(TEST_MODULE_DIR, "debugger_callee.ts");
const TEST_MODULE_OUTPUT = path.join(TEST_MODULE_DIR, "build/debugger_basic.wasm");
const IMPORT_FAILURE_SOURCE = path.join(TEST_MODULE_DIR, "import_failure.ts");
const IMPORT_FAILURE_OUTPUT = path.join(TEST_MODULE_DIR, "build/import_failure.wasm");
const TEST_MODULE_BREAKPOINT_LINE = 41;
const TEST_MODULE_SECOND_BREAKPOINT_LINE = 43;
const TEST_MODULE_STRING_BREAKPOINT_LINE = 57;
const TEST_MODULE_ARRAY_BREAKPOINT_LINE = 62;
const TEST_MODULE_CLASS_ARRAY_BREAKPOINT_LINE = 67;
const TEST_MODULE_TUPLE_BREAKPOINT_LINE = 72;
const TEST_MODULE_STATIC_ARRAY_BREAKPOINT_LINE = 83;
const TEST_MODULE_SET_BREAKPOINT_LINE = 96;
const TEST_MODULE_MAP_BREAKPOINT_LINE = 105;
const TEST_MODULE_NUMERIC_MAP_BREAKPOINT_LINE = 112;
const TEST_MODULE_IF_BRANCH_BREAKPOINT_LINE = 58;

async function waitForLoadedWasmSource(dc: DebugClient): Promise<DebugProtocol.LoadedSourceEvent> {
  while (true) {
    const event = await dc.waitForEvent("loadedSource");
    const body = event.body as { source?: DebugProtocol.Source; reason?: string } | undefined;
    if (body?.source?.path === path.resolve(TEST_MODULE_OUTPUT)) {
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

before(async () => {
  let buildOutput = "";
  let exitCode = await build({
    argv: [TEST_MODULE_SOURCE, "-o", TEST_MODULE_OUTPUT, "--debug", "--use", "abort="],
    cwd: TEST_MODULE_DIR,
    onStdout: (chunk: string) => {
      buildOutput += chunk;
    },
  });
  if (exitCode !== 0) {
    throw new Error(`failed to build debugger test module: ${buildOutput}`);
  }

  buildOutput = "";
  exitCode = await build({
    argv: [IMPORT_FAILURE_SOURCE, "-o", IMPORT_FAILURE_OUTPUT, "--debug", "--use", "abort="],
    cwd: TEST_MODULE_DIR,
    onStdout: (chunk: string) => {
      buildOutput += chunk;
    },
  });
  if (exitCode !== 0) {
    throw new Error(`failed to build import failure test module: ${buildOutput}`);
  }
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

  void it("should report the built wasm as a loaded source on launch", { timeout: 5000 }, async () => {
    await dc.initializeRequest();

    const breakpointResponse = await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_BREAKPOINT_LINE }],
    });
    assert.equal(breakpointResponse.body.breakpoints.length, 1);
    assert.equal(breakpointResponse.body.breakpoints[0].verified, true);
    assert.equal(breakpointResponse.body.breakpoints[0].line, TEST_MODULE_BREAKPOINT_LINE);

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const loadedSourcePromise = waitForLoadedWasmSource(dc);
    const stoppedPromise = waitForBreakpointStop(dc);

    await dc.launchRequest(launchArgs);

    const loadedSourceEvent = await loadedSourcePromise;
    const loadedSourceBody = loadedSourceEvent.body as { source?: DebugProtocol.Source; reason?: string } | undefined;
    await stoppedPromise;

    assert.equal(loadedSourceBody?.reason, "new");
    assert.equal(loadedSourceBody?.source?.path, path.resolve(TEST_MODULE_OUTPUT));
    assert.equal(loadedSourceBody?.source?.name, path.basename(TEST_MODULE_OUTPUT));
  });

  void it("should terminate when the runtime exits after wasm instantiation fails", { timeout: 5000 }, async () => {
    await dc.initializeRequest();

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: IMPORT_FAILURE_OUTPUT,
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
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
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
    assert.equal(frame.source?.path, normalizeDebugPath(TEST_MODULE_CALLEE_SOURCE));
    assert.equal(frame.line, TEST_MODULE_BREAKPOINT_LINE);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));

    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });
    const variable = assertDefined(variablesResponse.body.variables.find((candidate) => candidate.name === "a"));
    assert.equal(variable.type, "i32");
    assert.equal(variable.value, "1");
  });

  void it("should expose wasm call stack frames after hitting a breakpoint", { timeout: 5000 }, async () => {
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 20 });
    assert.ok(stackTraceResponse.body.stackFrames.length >= 2);

    const topFrame = stackTraceResponse.body.stackFrames[0];
    const callerFrame = stackTraceResponse.body.stackFrames[1];
    assert.match(topFrame.name, /calculate/);
    assert.equal(topFrame.source?.path, normalizeDebugPath(TEST_MODULE_CALLEE_SOURCE));
    assert.equal(topFrame.line, TEST_MODULE_BREAKPOINT_LINE);
    assert.match(callerFrame.name, /_start/);
    assert.equal(callerFrame.source?.path, normalizeDebugPath(TEST_MODULE_SOURCE));

    const scopesResponse = await dc.scopesRequest({ frameId: topFrame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });
    assertDefined(variablesResponse.body.variables.find((candidate) => candidate.name === "a"));

    const callerScopesResponse = await dc.scopesRequest({ frameId: callerFrame.id });
    const callerLocalsScope = assertDefined(callerScopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
    const callerVariablesResponse = await dc.variablesRequest({
      variablesReference: callerLocalsScope.variablesReference,
    });
    const callerSeed = assertDefined(
      callerVariablesResponse.body.variables.find((candidate) => candidate.name === "callerSeed")
    );
    assert.equal(callerSeed.type, "i32");
    assert.equal(callerSeed.value, "23");
  });

  void it("should only expose locals from the active if branch scope", { timeout: 5000 }, async () => {
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_IF_BRANCH_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "branchEntry",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 20 });
    assert.ok(stackTraceResponse.body.stackFrames.length >= 2);

    const branchFrame = stackTraceResponse.body.stackFrames[0];
    assert.match(branchFrame.name, /branchLocals/);
    assert.equal(branchFrame.source?.path, normalizeDebugPath(TEST_MODULE_SOURCE));
    assert.equal(branchFrame.line, TEST_MODULE_IF_BRANCH_BREAKPOINT_LINE);

    const scopesResponse = await dc.scopesRequest({ frameId: branchFrame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });
    const variableNames = new Set(variablesResponse.body.variables.map((variable) => variable.name));

    assert.ok(variableNames.has("ifOnly"));
    assert.ok(!variableNames.has("elseOnly"));
  });

  void it("should terminate when the entry function returns", { timeout: 5000 }, async () => {
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
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
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });
    const holder = assertDefined(findVariable(variablesResponse.body.variables, "holder"));
    await dc.variablesRequest({ variablesReference: holder.variablesReference });

    const terminatedPromise = dc.waitForEvent("terminated");
    await dc.continueRequest({ threadId: 1 });
    await terminatedPromise;
  });

  void it("should expand class local variables using DWARF layout", { timeout: 5000 }, async () => {
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
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
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));

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
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_STRING_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "stringEntry",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
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
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_ARRAY_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "arrayEntry",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
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
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_CLASS_ARRAY_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "classArrayEntry",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
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
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_TUPLE_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "tupleEntry",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
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
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_STATIC_ARRAY_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "staticArrayEntry",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
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
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_SET_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "setEntry",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
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
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_MAP_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "mapEntry",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
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
      ["key", "value"]
    );
    const firstKey = assertDefined(
      firstEntryFieldsResponse.body.variables.find((candidate) => candidate.name === "key")
    );
    assert.equal(firstKey.type, "i32");
    assert.equal(firstKey.value, "5");
    assert.equal(firstKey.variablesReference, 0);

    const firstValue = assertDefined(findVariable(firstEntryFieldsResponse.body.variables, "value"));
    assert.ok(firstValue.type?.endsWith("Child"));
    assert.ok(firstValue.variablesReference > 0);
    assert.equal(firstValue.value, "");

    const secondEntryFieldsResponse = await dc.variablesRequest({ variablesReference: secondEntry.variablesReference });
    assert.deepEqual(
      secondEntryFieldsResponse.body.variables.map((variable) => variable.name),
      ["key", "value"]
    );
    const secondKey = assertDefined(
      secondEntryFieldsResponse.body.variables.find((candidate) => candidate.name === "key")
    );
    assert.equal(secondKey.type, "i32");
    assert.equal(secondKey.value, "8");
    assert.equal(secondKey.variablesReference, 0);

    const secondValue = assertDefined(findVariable(secondEntryFieldsResponse.body.variables, "value"));
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
  });

  void it("should expand numeric map entries by index", { timeout: 5000 }, async () => {
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_NUMERIC_MAP_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "numericMapEntry",
    };

    const stoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = assertDefined(scopesResponse.body.scopes.find((scope) => scope.name === "Locals"));
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

    const entryFields = await Promise.all(
      entriesResponse.body.variables.map((entry) =>
        dc.variablesRequest({ variablesReference: entry.variablesReference })
      )
    );
    assert.deepEqual(
      entryFields.map((response) =>
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

  void it("should refresh variable references across multiple pauses", { timeout: 5000 }, async () => {
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_CALLEE_SOURCE },
      breakpoints: [{ line: TEST_MODULE_BREAKPOINT_LINE }, { line: TEST_MODULE_SECOND_BREAKPOINT_LINE }],
    });

    const launchArgs: DebugProtocol.LaunchRequestArguments & {
      program: string;
      launchType: string;
      runtime: string;
      entryFunctionName: string;
    } = {
      program: TEST_MODULE_OUTPUT,
      launchType: "wasm file",
      runtime: "node",
      entryFunctionName: "_start",
    };

    const firstStoppedPromise = waitForBreakpointStop(dc);
    await dc.launchRequest(launchArgs);
    await firstStoppedPromise;

    const firstStackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const firstScopesResponse = await dc.scopesRequest({ frameId: firstStackTraceResponse.body.stackFrames[0].id });
    const firstLocalsScope = assertDefined(firstScopesResponse.body.scopes.find((scope) => scope.name === "Locals"));

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
    const secondLocalsScope = assertDefined(secondScopesResponse.body.scopes.find((scope) => scope.name === "Locals"));

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
});
