import * as os from "node:os";
import { execSync, spawn } from "node:child_process";
import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";

export interface Option {
  env: NodeJS.Dict<string>;
  argv: string[];
}

const dirname = import.meta.dirname;

function download_url(version: string): string {
  const arch = os.arch();
  const platform = os.platform();
  if ((platform === "linux" && arch === "x64") || (platform === "darwin" && arch === "arm64")) {
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

  const url = download_url(version);
  console.log(`downloading warpo from ${url}`);
  execSync(`curl -L ${url} | tar xz -C ${dirname}`, { stdio: "inherit" });
  return join(dirname, "warpo", "warpo_asc");
}

export async function main(options: Option) {
  const binary = get_binary();
  const ps = spawn(binary, options.argv, { stdio: "inherit", env: options.env });
  return new Promise<number>((resolve, reject) => {
    function shutdown() {
      ps.kill("SIGTERM");
      reject();
    }
    process.on("SIGINT", shutdown);
    process.on("SIGTERM", shutdown);
    ps.on("close", (e) => {
      process.removeListener("SIGINT", shutdown);
      process.removeListener("SIGTERM", shutdown);
      resolve(e);
    });
  });
}
