import * as os from "node:os";
import { spawn } from "node:child_process";
import { createWriteStream, existsSync, readFileSync } from "node:fs";
import { access, mkdir, readdir, rm } from "node:fs/promises";
import { basename, join } from "node:path";
import { Readable } from "node:stream";
import { pipeline } from "node:stream/promises";
import * as tar from "tar";
import { fetch, ProxyAgent } from "undici";

export interface Option {
  env: NodeJS.Dict<string>;
  argv: string[];
  cwd?: string;
  onStdout?: (chunk: string) => void;
  proxy?: string;
}

const dirname = import.meta.dirname;
const warpoRoot = join(dirname, "..", "..");

interface ReleaseAsset {
  name: string;
  browser_download_url: string;
}

function isTarGzAsset(asset: ReleaseAsset): boolean {
  return asset.name.endsWith(".tar.gz");
}

function getProxyUrl(proxy?: string): string | undefined {
  return (
    proxy ?? process.env.HTTPS_PROXY ?? process.env.https_proxy ?? process.env.HTTP_PROXY ?? process.env.http_proxy
  );
}

function getFetchOptions(proxy?: string): { dispatcher: ProxyAgent | undefined; headers: { "user-agent": string } } {
  const proxyUrl = getProxyUrl(proxy);
  return {
    dispatcher: proxyUrl ? new ProxyAgent(proxyUrl) : undefined,
    headers: { "user-agent": "warpo-release-downloader" },
  };
}

async function getReleaseAssets(version: string, proxy?: string): Promise<ReleaseAsset[]> {
  const response = await fetch(
    `https://api.github.com/repos/wasm-ecosystem/warpo/releases/tags/${version}`,
    getFetchOptions(proxy)
  );
  if (!response.ok) {
    throw new Error(`failed to query release ${version}: ${response.status}`);
  }
  const release = (await response.json()) as { assets?: ReleaseAsset[] };
  return release.assets ?? [];
}

async function downloadFile(url: string, outputPath: string, proxy?: string): Promise<void> {
  const response = await fetch(url, getFetchOptions(proxy));
  if (!response.ok) {
    throw new Error(`failed to download ${url}: ${response.status}`);
  }
  if (!response.body) {
    throw new Error(`failed to download ${url}: empty response body`);
  }
  await pipeline(Readable.fromWeb(response.body), createWriteStream(outputPath));
}

function getAssetUrl(asset: ReleaseAsset, version: string): string {
  const base_url =
    process.env["WARPO_DOWNLOAD_BASE_URL"] ?? `https://github.com/wasm-ecosystem/warpo/releases/download`;
  return process.env["WARPO_DOWNLOAD_BASE_URL"] ? `${base_url}/${version}/${asset.name}` : asset.browser_download_url;
}

function getCurrentMachineAssetName(version: string): string {
  return `warpo-${version}-${os.platform()}-${os.arch()}.tar.gz`;
}

function createCurrentMachineAsset(version: string): ReleaseAsset {
  const name = getCurrentMachineAssetName(version);
  return {
    name,
    browser_download_url: `https://github.com/wasm-ecosystem/warpo/releases/download/${version}/${name}`,
  };
}

function getBinaryName(): string {
  return os.platform() === "win32" ? "warpo_asc.exe" : "warpo_asc";
}

function getExtractedPath(archivePath: string): string {
  if (archivePath.endsWith(".tar.gz")) {
    return join(dirname, basename(archivePath, ".tar.gz"));
  }
  throw new Error(`unsupported archive format: ${archivePath}`);
}

async function extract_archive(archivePath: string): Promise<string> {
  const outputPath = getExtractedPath(archivePath);
  await rm(outputPath, { recursive: true, force: true });
  await mkdir(outputPath, { recursive: true });
  if (archivePath.endsWith(".tar.gz")) {
    await tar.x({ file: archivePath, cwd: outputPath });
    return outputPath;
  }
  throw new Error(`unsupported archive format: ${archivePath}`);
}

function getVersion(): string {
  return (
    process.env["WARPO_DOWNLOAD_VERSION"] || JSON.parse(readFileSync(join(warpoRoot, "package.json"), "utf8")).version
  );
}

async function pathExists(path: string): Promise<boolean> {
  try {
    await access(path);
    return true;
  } catch {
    return false;
  }
}

function getExtractedPathForAsset(asset: ReleaseAsset): string {
  return getExtractedPath(join(dirname, asset.name));
}

async function downloadAndExtractAsset(asset: ReleaseAsset, version: string, proxy?: string): Promise<void> {
  const archivePath = join(dirname, asset.name);
  const outputPath = getExtractedPathForAsset(asset);
  if (await pathExists(outputPath)) {
    return;
  }
  const url = getAssetUrl(asset, version);
  console.log(`downloading warpo from ${url}`);
  await downloadFile(url, archivePath, proxy);
  await extract_archive(archivePath);
  await rm(archivePath, { force: true });
}

export async function downloadForCurrentMachine(proxy?: string): Promise<string> {
  const version = getVersion();
  if (version === "0.0.0") {
    throw new Error("download command is unavailable for development version 0.0.0");
  }
  const asset = createCurrentMachineAsset(version);
  const outputPath = getExtractedPathForAsset(asset);
  await downloadAndExtractAsset(asset, version, proxy);
  return outputPath;
}

export async function downloadAll(proxy?: string): Promise<string[]> {
  const version = getVersion();
  if (version === "0.0.0") {
    throw new Error("download command is unavailable for development version 0.0.0");
  }
  const assets = await getReleaseAssets(version, proxy);
  const tarGzAssets = assets.filter(isTarGzAsset);
  return await Promise.all(
    tarGzAssets.map(async (asset) => {
      const outputPath = getExtractedPathForAsset(asset);
      await downloadAndExtractAsset(asset, version, proxy);
      return outputPath;
    })
  );
}

export async function cleanDownloaded(): Promise<string[]> {
  const version = getVersion();
  const cachedDirs = [join(dirname, "warpo")];
  const entries = await readdir(dirname, { withFileTypes: true });
  for (const entry of entries) {
    if (!entry.isDirectory()) {
      continue;
    }
    if (!entry.name.startsWith(`warpo-${version}-`)) {
      continue;
    }
    cachedDirs.push(join(dirname, entry.name));
  }
  const removedDirs: string[] = [];
  await Promise.all(
    cachedDirs.map(async (dirPath) => {
      if (!(await pathExists(dirPath))) {
        return;
      }
      await rm(dirPath, { recursive: true, force: true });
      removedDirs.push(dirPath);
    })
  );
  return removedDirs;
}

async function downloadForCurrentMachineBinary(proxy?: string): Promise<string | null> {
  if (process.env["WARPO_BINARY_PATH"]) {
    return process.env["WARPO_BINARY_PATH"];
  }
  if (process.env["WARPO_FORCE_DOWNLOAD"] !== "1" && existsSync(join(dirname, "warpo"))) {
    return join(dirname, "warpo", getBinaryName());
  }

  const version = getVersion();

  if (version === "0.0.0") {
    // for development purpose, use local build
    return join(warpoRoot, "build", "warpo", getBinaryName());
  }

  const asset = createCurrentMachineAsset(version);
  const outputPath = getExtractedPathForAsset(asset);
  await downloadAndExtractAsset(asset, version, proxy);
  return join(outputPath, "warpo", getBinaryName());
}

export async function build(options: Option): Promise<number> {
  const binary = await downloadForCurrentMachineBinary(options.proxy);
  const ps = spawn(binary, options.argv, {
    stdio: options.onStdout === undefined ? "inherit" : ["inherit", "pipe", "inherit"],
    env: options.env,
    cwd: options.cwd,
  });
  if (options.onStdout !== undefined) {
    ps.stdout.on("data", (chunk: Buffer) => {
      options.onStdout(chunk.toString("utf8"));
    });
  }
  return new Promise<number>((resolve, reject) => {
    function shutdown() {
      ps.kill("SIGTERM");
      reject(new Error("WARPO process terminated by signal"));
    }
    process.on("SIGINT", shutdown);
    process.on("SIGTERM", shutdown);
    ps.on("close", (code: number | null) => {
      process.removeListener("SIGINT", shutdown);
      process.removeListener("SIGTERM", shutdown);
      resolve(code ?? 0);
    });
  });
}
