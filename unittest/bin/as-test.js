#!/usr/bin/env node

import chalk from "chalk";
import { spawn } from "cross-spawn";
import { join } from "path";
import { exit, version } from "process";
import { lt } from "semver";
import { fileURLToPath, URL } from "url";

const __dirname = fileURLToPath(new URL(".", import.meta.url));

if (lt(version, "12.16.0")) {
  console.error(chalk.redBright("unsupported node version, minimum version is v12.16.0"));
  exit(-1);
}
const argv = [];
argv.push("--no-warnings");
if (lt(version, "15.0.0")) {
  argv.push("--experimental-wasm-bigint");
}
argv.push(join(__dirname, "cli.js"));
argv.push(...process.argv.slice(2));

const testapp = spawn("node", argv, { stdio: "inherit" });

testapp.on("close", function (code) {
  exit(code);
});

testapp.on("exit", (_code, signal) => {
  if (signal === "SIGABRT") {
    // node heap out of memory
    exit(-1);
  }
});
