#!/usr/bin/env node

import * as os from "node:os";
import { execSync, spawn } from "node:child_process";
import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";

const dirname = import.meta.dirname;

function download_url(version: string, arch: string, platform: string): string {
  if ((platform === "linux" && arch === "x86_64") || (platform === "macos" && arch === "arm64")) {
    return `https://github.com/wasm-ecosystem/warpo/releases/download/${version}/warpo-${version}-${platform}-${arch}.tar.gz`;
  }
  console.log(`there is no precompiled binary for ${version} + ${platform} + ${arch}, please compile from source.`);
  process.exit(1);
}

function get_binary(): string | null {
  if (process.env["WARPO_BINARY_PATH"]) {
    return process.env["WARPO_BINARY_PATH"];
  }
  if (process.env["WARPO_FORCE_DOWNLOAD"] !== "1" && existsSync(join(dirname, "warpo"))) {
    return join(dirname, "warpo", "warpo_asc");
  }

  const version =
    process.env["WARPO_DOWNLOAD_VERSION"] ||
    JSON.parse(readFileSync(join(dirname, "..", "package.json"), "utf8")).version;

  let platform: string = os.platform();
  if (platform === "darwin") platform = "macos";

  const url = download_url(version, os.arch(), platform);
  console.log(`downloading warpo from ${url}`);
  execSync(`curl -L ${url} | tar xz -C ${dirname}`, { stdio: "inherit" });
  return join(dirname, "warpo", "warpo_asc");
}

const binary = get_binary();

const ps = spawn(binary, process.argv.slice(2), { stdio: "inherit" });

function shutdown() {
  ps.kill("SIGTERM");
  process.exit();
}

process.on("SIGINT", shutdown);
process.on("SIGTERM", shutdown);

ps.on("close", (e) => process.exit(e));
