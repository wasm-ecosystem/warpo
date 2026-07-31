// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { ChildProcess, spawn } from "node:child_process";

export interface DapServerHandle {
  port: number;
  child: ChildProcess;
}

export function launchDapServer(script: string): Promise<DapServerHandle> {
  return new Promise((resolve, reject) => {
    const child = spawn(process.execPath, [script, "0"], { stdio: ["pipe", "pipe", "pipe"] });

    child.on("error", (err) => reject(err));
    child.on("exit", (code) => reject(new Error(`DAP server exited with code ${code}`)));

    let buffer = "";
    child.stderr.on("data", (chunk: Buffer) => {
      process.stderr.write(chunk);
      buffer += chunk.toString();
      const match = /DAP server listening on port (\d+)/.exec(buffer);
      if (match) {
        resolve({ port: Number(match[1]), child });
      }
    });
  });
}

const launcher = { launchDapServer };
export default launcher;
