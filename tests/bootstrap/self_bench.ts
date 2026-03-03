/**
 * Bench old and new warpo_asc binaries
 *
 * node --import=tsx tests/bootstrap/self_bench.ts
 *
 * The origin built warpo_asc binary must be in build_release_dev/warpo/warpo_asc.
 * The current built warpo_asc binary must be in build_release/warpo/warpo_asc.
 *
 * ```bash
 * git checkout main
 * cmake -S . -B build_release -DWARPO_RELEASE=ON
 * cmake --build build_release --target warpo_asc --parallel
 * cp ./build_release/warpo/warpo_asc ./build_release/warpo/warpo_asc_old
 * ```
 *
 * This script will:
 * 1) Build the current project with the old binary (target: release) and write a .wat output.
 * 2) Build the current project with the new binary (target: release) and write a .wat output.
 * 3) Use the new binary with --asc-wasm pointing at the old/new outputs and benchmark (target: fast).
 *
 * So that the warpo_asc binary must be built from the current project.
 */

import { spawn } from "child_process";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const repoRoot = path.resolve(__dirname, "..", "..");
const outputDir = path.join(repoRoot, "tests", "bootstrap", "tmp", "self_bench");

const WARMUP = 2;

const oldBinary = path.join(repoRoot, "build_release_main", "warpo", "warpo_asc");
const newBinary = path.join(repoRoot, "build_release", "warpo", "warpo_asc");

function median(values: number[]): number {
  if (!values.length) return NaN;
  const sorted = values.slice().sort((a, b) => a - b);
  const mid = Math.floor(sorted.length / 2);
  if (sorted.length % 2 === 0) {
    return (sorted[mid - 1] + sorted[mid]) / 2;
  }
  return sorted[mid];
}

function toMs(value: number, unit: "s" | "ms" | "us" | "ns"): number {
  if (unit === "ms") return value;
  if (unit === "s") return value * 1000;
  if (unit === "us") return value / 1000;
  if (unit === "ns") return value / 1e6;
  return value;
}

function parseCompilationTime(output: string): number {
  const lines = output.split(/\r?\n/);
  let match = null;
  for (const line of lines) {
    if (line.includes("CompilationHIR_Compilation")) {
      match = line;
    }
  }
  if (!match) {
    throw new Error("Failed to find CompilationHIR_Compilation in output");
  }
  const regex = /CompilationHIR_Compilation.*total\s+([0-9.]+)\s*(s|ms|us|ns)/i;
  const result = regex.exec(match);
  if (!result) {
    throw new Error(`Failed to parse CompilationHIR_Compilation line: ${match}`);
  }
  const value = Number(result[1]);
  const unit = result[2].toLowerCase() as "s" | "ms" | "us" | "ns";
  if (!Number.isFinite(value)) {
    throw new Error(`Invalid number in CompilationHIR_Compilation line: ${match}`);
  }
  return toMs(value, unit);
}

function runCommand(executable: string, args: string[]): Promise<string> {
  return new Promise((resolve, reject) => {
    const child = spawn(executable, args, { cwd: repoRoot });
    let stdout = "";
    let stderr = "";

    child.stdout.on("data", (chunk) => {
      stdout += chunk.toString();
    });
    child.stderr.on("data", (chunk) => {
      stderr += chunk.toString();
    });
    child.on("error", reject);
    child.on("close", (code) => {
      if (code !== 0) {
        reject(new Error(`Command failed with code ${code}: ${stderr || stdout}`));
        return;
      }
      resolve(stdout + stderr);
    });
  });
}

function replaceExtension(filePath: string, newExt: string): string {
  const parsed = path.parse(filePath);
  return path.join(parsed.dir, `${parsed.name}${newExt}`);
}

async function buildRelease(executable: string, outputWatPath: string): Promise<void> {
  const args = ["--config", "asconfig.json", "--target", "release", "-o", outputWatPath];
  await runCommand(executable, args);
}

async function runOnce(executable: string, ascWasmPath: string, outputPath: string): Promise<number> {
  const args = [
    "--config",
    "asconfig.json",
    "--target",
    "fast",
    "--stats",
    "--asc-wasm",
    ascWasmPath,
    "-o",
    outputPath,
  ];
  const output = await runCommand(executable, args);
  const timeMs = parseCompilationTime(output);
  return timeMs;
}

function formatMs(value: number): string {
  if (!Number.isFinite(value)) return "n/a";
  return `${value.toFixed(3)} ms`;
}

(async () => {
  fs.mkdirSync(outputDir, { recursive: true });

  const outputOldWat = path.join(outputDir, "assemblyscript.warpo-test.old.wat");
  const outputNewWat = path.join(outputDir, "assemblyscript.warpo-test.new.wat");
  const outputOldWasm = replaceExtension(outputOldWat, ".wasm");
  const outputNewWasm = replaceExtension(outputNewWat, ".wasm");

  await buildRelease(oldBinary, outputOldWat);
  await buildRelease(newBinary, outputNewWat);

  const outputBenchOld = path.join(outputDir, "assemblyscript.warpo-test.recompile.old.wasm");
  const outputBenchNew = path.join(outputDir, "assemblyscript.warpo-test.recompile.new.wasm");

  const samplesOld: number[] = [];
  const samplesNew: number[] = [];

  for (let i = 0; i < WARMUP; ++i) {
    await runOnce(newBinary, outputOldWasm, outputBenchOld);
    await runOnce(newBinary, outputNewWasm, outputBenchNew);
  }

  let round = 0;
  while (true) {
    ++round;
    if (round % 2 === 0) {
      samplesOld.push(await runOnce(newBinary, outputOldWasm, outputBenchOld));
      samplesNew.push(await runOnce(newBinary, outputNewWasm, outputBenchNew));
    } else {
      samplesNew.push(await runOnce(newBinary, outputNewWasm, outputBenchNew));
      samplesOld.push(await runOnce(newBinary, outputOldWasm, outputBenchOld));
    }
    const p50Old = median(samplesOld);
    const p50New = median(samplesNew);
    const delta = p50New - p50Old;
    const ratio = Number.isFinite(p50Old) && p50Old !== 0 ? p50New / p50Old : NaN;
    const pct = Number.isFinite(ratio) ? (ratio - 1) * 100 : NaN;

    if (round % 3 === 0) {
      const summary = [
        `round ${round}`,
        `p50 old=${formatMs(p50Old)}`,
        `p50 new=${formatMs(p50New)}`,
        `delta=${formatMs(delta)}`,
        Number.isFinite(pct) ? `change=${pct.toFixed(2)}%` : "change=n/a",
      ].join(" | ");
      console.log(summary);
    }
  }
})().catch((err) => {
  console.error(err && err.message ? err.message : err);
  process.exit(1);
});
