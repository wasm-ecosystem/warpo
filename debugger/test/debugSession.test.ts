// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { DebugClient } from "@vscode/debugadapter-testsupport";
import * as assert from "node:assert/strict";
import * as path from "node:path";
import { type ChildProcess } from "node:child_process";
import { describe, it, beforeEach, afterEach } from "node:test";
import { launchDapServer } from "../src/launcher";

const DAP_SERVER = path.resolve(__dirname, "..", "..", "dist", "debug_server", "dapServer.js");

void describe("WarpoDebugSession", () => {
  let dc: DebugClient;
  let serverChild: ChildProcess;

  beforeEach(async () => {
    const { port, child } = await launchDapServer(DAP_SERVER);
    serverChild = child;
    dc = new DebugClient("", "", "warpo");
    await dc.start(port);
  });

  afterEach(async () => {
    await dc.stop();
    serverChild.kill();
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
