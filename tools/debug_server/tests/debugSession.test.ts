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

const DIRNAME = path.dirname(fileURLToPath(import.meta.url));
const DAP_SERVER = path.resolve(DIRNAME, "..", "..", "..", "dist", "debug_server", "dapServer.js");
const TEST_MODULE_DIR = path.resolve(DIRNAME, "testModule");
const TEST_MODULE_SOURCE = path.join(TEST_MODULE_DIR, "debugger_basic.ts");
const TEST_MODULE_OUTPUT = path.join(TEST_MODULE_DIR, "build/debugger_basic.wasm");

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
  const exitCode = await build({
    argv: [TEST_MODULE_SOURCE, "-o", TEST_MODULE_OUTPUT, "--debug"],
    cwd: TEST_MODULE_DIR,
    onStdout: (chunk: string) => {
      buildOutput += chunk;
    },
  });
  if (exitCode !== 0) {
    throw new Error(`failed to build debugger test module: ${buildOutput}`);
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
      source: { path: TEST_MODULE_SOURCE },
      breakpoints: [{ line: 3 }],
    });
    assert.equal(breakpointResponse.body.breakpoints.length, 1);
    assert.equal(breakpointResponse.body.breakpoints[0].verified, true);
    assert.equal(breakpointResponse.body.breakpoints[0].line, 3);

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

    const loadedSourcePromise = dc.waitForEvent("loadedSource");
    const stoppedPromise = dc.waitForEvent("stopped");

    await dc.launchRequest(launchArgs);

    const loadedSourceEvent = await loadedSourcePromise;
    const loadedSourceBody = loadedSourceEvent.body as { source?: DebugProtocol.Source; reason?: string } | undefined;
    const stoppedEvent = await stoppedPromise;
    const stoppedBody = stoppedEvent.body as { reason?: string } | undefined;

    assert.equal(loadedSourceBody?.reason, "new");
    assert.equal(loadedSourceBody?.source?.path, path.resolve(TEST_MODULE_OUTPUT));
    assert.equal(loadedSourceBody?.source?.name, path.basename(TEST_MODULE_OUTPUT));
    assert.equal(stoppedBody?.reason, "breakpoint");
  });

  void it("should expose local variables after hitting a breakpoint", { timeout: 5000 }, async () => {
    await dc.initializeRequest();

    await dc.setBreakpointsRequest({
      source: { path: TEST_MODULE_SOURCE },
      breakpoints: [{ line: 4 }],
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

    const stoppedPromise = dc.waitForEvent("stopped");
    await dc.launchRequest(launchArgs);
    await stoppedPromise;

    const stackTraceResponse = await dc.stackTraceRequest({ threadId: 1, startFrame: 0, levels: 1 });
    const frame = stackTraceResponse.body.stackFrames[0];
    assert.notStrictEqual(frame, undefined);

    const scopesResponse = await dc.scopesRequest({ frameId: frame.id });
    const localsScope = scopesResponse.body.scopes.find((scope) => scope.name === "Locals");
    assert.notStrictEqual(localsScope, undefined);

    const variablesResponse = await dc.variablesRequest({ variablesReference: localsScope.variablesReference });
    const variable = variablesResponse.body.variables.find((candidate) => candidate.name === "a");
    assert.notStrictEqual(variable, undefined);
    assert.equal(variable.type, "i32");
    assert.equal(variable.value, "1");
  });
});
