// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { createServer } from "node:net";
import { WarpoDebugSession } from "./debugSession.js";

const port = Number(process.argv[2]) || 0;

const server = createServer((socket) => {
  const session = new WarpoDebugSession();
  session.setRunAsServer(true);
  session.start(socket, socket);
  socket.on("close", () => {
    session.dispose();
  });
});

server.listen(port, "127.0.0.1", () => {
  const addr = server.address();
  if (addr && typeof addr !== "string") {
    process.stderr.write(`DAP server listening on port ${addr.port}\n`);
  }
});
