// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { DebugClient } from "@vscode/debugadapter-testsupport";
import * as assert from "node:assert/strict";
import * as path from "node:path";
import { describe, it, beforeEach, afterEach } from "node:test";
import { fileURLToPath } from "node:url";
import { launchDapServer, type DapServerHandle } from "./launcher.js";

const DIRNAME = path.dirname(fileURLToPath(import.meta.url));
const DAP_SERVER = path.resolve(DIRNAME, "..", "..", "..", "dist", "debug_server", "dapServer.js");

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
});
