import * as os from "node:os";
import { spawn } from "node:child_process";
import { existsSync, readFileSync } from "node:fs";
import { access, mkdir, readdir, rm, writeFile } from "node:fs/promises";
import { basename, join } from "node:path";
import { fileURLToPath } from "node:url";
import * as tar from "tar";
import { fetch, ProxyAgent } from "undici";

export interface Option {
  argv: string[];
  env?: NodeJS.Dict<string>;
  cwd?: string;
  onStdout?: (chunk: string) => void;
  proxy?: string;
}

const dirname = fileURLToPath(new URL(".", import.meta.url));
const warpoRoot = join(dirname, "..", "..");

interface ReleaseAsset {
  name: string;
  browser_download_url: string;
}

interface PackageJson {
  version: string;
}

function isTarGzAsset(asset: ReleaseAsset): boolean {
  return asset.name.endsWith(".tar.gz");
}

function getProxyUrl(proxy?: string): string | undefined {
  /* eslint-disable dot-notation -- process.env is index-signature typed under strict test_runner checks. */
  return (
    proxy ??
    process.env["HTTPS_PROXY"] ??
    process.env["https_proxy"] ??
    process.env["HTTP_PROXY"] ??
    process.env["http_proxy"]
  );
  /* eslint-enable dot-notation */
}

function getFetchOptions(proxy?: string): { dispatcher?: ProxyAgent; headers: { "user-agent": string } } {
  const proxyUrl = getProxyUrl(proxy);
  const options: { dispatcher?: ProxyAgent; headers: { "user-agent": string } } = {
    headers: { "user-agent": "warpo-release-downloader" },
  };
  if (proxyUrl) {
    options.dispatcher = new ProxyAgent(proxyUrl);
  }
  return options;
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
  await writeFile(outputPath, Buffer.from(await response.arrayBuffer()));
}

function getAssetUrl(asset: ReleaseAsset, version: string): string {
  // eslint-disable-next-line dot-notation -- process.env is index-signature typed under strict test_runner checks.
  const downloadBaseUrl = process.env["WARPO_DOWNLOAD_BASE_URL"];
  const base_url = downloadBaseUrl ?? `https://github.com/wasm-ecosystem/warpo/releases/download`;
  return downloadBaseUrl ? `${base_url}/${version}/${asset.name}` : asset.browser_download_url;
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

function getTraceVisualizerBinaryName(): string {
  return os.platform() === "win32" ? "warpo_trace_visualizer.exe" : "warpo_trace_visualizer";
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
    // Release archives are produced by Warpo CI and extracted into a fresh cache directory.
    // eslint-disable-next-line sonarjs/no-unsafe-unzip
    await tar.x({ file: archivePath, cwd: outputPath });
    return outputPath;
  }
  throw new Error(`unsupported archive format: ${archivePath}`);
}

function getVersion(): string {
  const packageJson = JSON.parse(readFileSync(join(warpoRoot, "package.json"), "utf8")) as PackageJson;
  // eslint-disable-next-line dot-notation -- process.env is index-signature typed under strict test_runner checks.
  return process.env["WARPO_DOWNLOAD_VERSION"] || packageJson.version;
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

function applyDefaultBuildOptions(args: string[], cwd: string): string[] {
  const handleConfigOption = (args: string[]) => {
    const configPath = join(cwd, "asconfig.json");
    const hasConfig = args.includes("--config") || args.includes("-c");
    return !hasConfig && existsSync(configPath) ? [...args, "--config", configPath] : args;
  };
  const handleProjectOption = (args: string[]) => {
    const hasProject = args.includes("--project") || args.includes("-p");
    return !hasProject && existsSync(join(cwd, "create.ts")) ? [...args, "--project", cwd] : args;
  };
  return [handleConfigOption, handleProjectOption].reduce((nextArgs, handler) => handler(nextArgs), args);
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
  /* eslint-disable dot-notation -- process.env is index-signature typed under strict test_runner checks. */
  if (process.env["WARPO_BINARY_PATH"]) {
    return process.env["WARPO_BINARY_PATH"];
  }
  if (process.env["WARPO_FORCE_DOWNLOAD"] !== "1" && existsSync(join(dirname, "warpo"))) {
    return join(dirname, "warpo", getBinaryName());
  }
  /* eslint-enable dot-notation */

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

async function downloadForCurrentMachineTraceVisualizer(proxy?: string): Promise<string | null> {
  /* eslint-disable dot-notation -- process.env is index-signature typed under strict test_runner checks. */
  if (process.env["WARPO_TRACE_VISUALIZER_BINARY_PATH"]) {
    return process.env["WARPO_TRACE_VISUALIZER_BINARY_PATH"];
  }
  const cachedBinary = join(dirname, "warpo", getTraceVisualizerBinaryName());
  if (process.env["WARPO_FORCE_DOWNLOAD"] !== "1" && existsSync(cachedBinary)) {
    return cachedBinary;
  }
  /* eslint-enable dot-notation */

  const version = getVersion();

  if (version === "0.0.0") {
    // for development purpose, use local build
    return join(warpoRoot, "build", "warpo", getTraceVisualizerBinaryName());
  }

  const asset = createCurrentMachineAsset(version);
  const outputPath = getExtractedPathForAsset(asset);
  await downloadAndExtractAsset(asset, version, proxy);
  return join(outputPath, "warpo", getTraceVisualizerBinaryName());
}

function runBinary(binary: string, options: Option): Promise<number> {
  const cwd = options.cwd ?? process.cwd();
  const argv = options.argv;
  const onStdout = options.onStdout;
  const ps =
    onStdout === undefined
      ? spawn(binary, argv, {
          stdio: "inherit",
          env: options.env ?? process.env,
          cwd,
        })
      : spawn(binary, argv, {
          stdio: ["inherit", "pipe", "inherit"],
          env: options.env ?? process.env,
          cwd,
        });
  if (onStdout !== undefined) {
    const stdout = ps.stdout;
    if (!stdout) {
      throw new Error("WARPO process stdout is unavailable");
    }
    stdout.on("data", (chunk: Buffer) => {
      onStdout(chunk.toString("utf8"));
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

export async function build(options: Option): Promise<number> {
  const cwd = options.cwd ?? process.cwd();
  const argv = applyDefaultBuildOptions(options.argv, cwd);
  const binary = await downloadForCurrentMachineBinary(options.proxy);
  if (binary === null) {
    throw new Error("Failed to resolve warpo binary path");
  }
  return await runBinary(binary, { ...options, argv });
}

export async function traceVisualizer(options: Option): Promise<number> {
  const binary = await downloadForCurrentMachineTraceVisualizer(options.proxy);
  if (binary === null) {
    throw new Error("Failed to resolve warpo trace visualizer binary path");
  }
  return await runBinary(binary, options);
}
