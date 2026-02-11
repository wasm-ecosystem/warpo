// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { DebugClient } from "@vscode/debugadapter-testsupport";
import { createServer, Server } from "net";
import { WarpoDebugSession } from "../debugSession";
import { expect } from "chai";

const PORT = 14711;

function activeDebugServer(port: number): Server {
  return createServer((socket) => {
    const session = new WarpoDebugSession();
    session.setRunAsServer(true);
    session.start(socket, socket);
  }).listen(port);
}

const server = activeDebugServer(PORT);

describe("WarpoDebugSession", () => {
  let dc: DebugClient;

  beforeEach(async () => {
    dc = new DebugClient("", "", "warpo");
    await dc.start(PORT);
  });

  afterEach(async () => {
    await dc.stop();
  });

  after(() => {
    server.close();
  });

  it("should accept breakpoints and return them verified", async () => {
    await dc.initializeRequest();

    const response = await dc.setBreakpointsRequest({
      source: { path: "/tmp/test.ts" },
      breakpoints: [{ line: 5 }, { line: 10 }],
    });

    expect(response.body.breakpoints).to.have.lengthOf(2);
    expect(response.body.breakpoints[0].verified).to.be.true;
    expect(response.body.breakpoints[0].line).to.equal(5);
    expect(response.body.breakpoints[1].verified).to.be.true;
    expect(response.body.breakpoints[1].line).to.equal(10);
  });
});
