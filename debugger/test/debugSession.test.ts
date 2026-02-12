// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { DebugClient } from "@vscode/debugadapter-testsupport";
import { expect } from "chai";
import * as path from "node:path";
import { type ChildProcess } from "node:child_process";
import { launchDapServer } from "../src/launcher";

const DAP_SERVER = path.resolve(__dirname, "..", "..", "dist", "debug_server", "dapServer.js");

describe("WarpoDebugSession", () => {
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

  it("should accept breakpoints and return them verified", async () => {
    await dc.initializeRequest();

    const response = await dc.setBreakpointsRequest({
      source: { path: "test.ts" },
      breakpoints: [{ line: 5 }, { line: 10 }],
    });

    expect(response.body.breakpoints).to.have.lengthOf(2);
    expect(response.body.breakpoints[0].verified).to.equal(true);
    expect(response.body.breakpoints[0].line).to.equal(5);
    expect(response.body.breakpoints[1].verified).to.equal(true);
    expect(response.body.breakpoints[1].line).to.equal(10);
  });
});
