// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { createHash } from "node:crypto";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { performance } from "node:perf_hooks";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../..");
const binary = path.join(root, "build/warpo/warpo_asc");
const output = path.resolve(process.argv[2] ?? path.join(root, "tests/bootstrap/tmp/gc-coloring/results.json"));
const rounds = Number(process.env.ROUNDS ?? 9);
const warmups = Number(process.env.WARMUPS ?? 2);
assert.ok(Number.isInteger(rounds) && rounds >= 3, "ROUNDS must be an integer >= 3");
assert.ok(Number.isInteger(warmups) && warmups >= 1, "WARMUPS must be an integer >= 1");
const work = fs.mkdtempSync(path.join(os.tmpdir(), "warpo-gc-coloring-"));
const variants = [
  { name: "legacy", flags: ["--gc-legacy-coloring"] },
  { name: "best", flags: [] },
];
const common = ["--config", "asconfig.json"];

function run(args, debug = false) {
  const start = performance.now();
  const child = spawnSync(binary, args, {
    cwd: root,
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
    env: { ...process.env, WARPO_DEBUG: "0", WARPO_DEBUG_PASSES: debug ? "GCColoring" : "", WARPO_DEBUG_FUNCTIONS: "" },
  });
  if (child.error) throw child.error;
  assert.equal(child.status, 0, `Compiler failed: ${child.stderr}\n${child.stdout}`);
  const text = child.stdout + child.stderr;
  assert.ok(!text.includes("unknown argument ignored"), `Unrecognized benchmark option: ${text}`);
  const times = {};
  for (const match of text.matchAll(/^\s*- ([A-Za-z_]+): \d+ times, total ([\d.]+)(s|ms|µs|us|ns)\s*$/gm)) {
    times[match[1]] = Number(match[2]) * { s: 1000, ms: 1, µs: 0.001, us: 0.001, ns: 0.000001 }[match[3]];
  }
  for (const key of ["Lowering", "CompilationHIR_Compilation"]) {
    assert.ok(Number.isFinite(times[key]), `Missing timing ${key}`);
  }
  return { wallMs: performance.now() - start, ...times, text };
}

function median(values) {
  const sorted = [...values].sort((a, b) => a - b);
  const middle = Math.floor(sorted.length / 2);
  return sorted.length % 2 ? sorted[middle] : (sorted[middle - 1] + sorted[middle]) / 2;
}

function summarize(samples) {
  const result = {};
  for (const key of ["wallMs", "Lowering", "CompilationHIR_Compilation", "CompilationHIR_Parsing", "CompilationHIR"]) {
    const values = samples.map((s) => s[key]);
    result[key] = { median: median(values), min: Math.min(...values), max: Math.max(...values) };
  }
  return result;
}

function hash(file) {
  return createHash("sha256").update(fs.readFileSync(file)).digest("hex");
}

function benchmark(makeArgs) {
  const samples = { legacy: [], best: [] };
  for (let i = -warmups; i < rounds; ++i) {
    const order = Math.abs(i) % 2 ? [...variants].reverse() : variants;
    for (const variant of order) {
      const { text, ...sample } = run(makeArgs(variant));
      if (i >= 0) samples[variant.name].push(sample);
    }
  }
  const summaries = Object.fromEntries(variants.map((v) => [v.name, summarize(samples[v.name])]));
  const reductionPercent = {};
  for (const key of Object.keys(summaries.legacy)) {
    reductionPercent[key] = (1 - summaries.best[key].median / summaries.legacy[key].median) * 100;
  }
  return { samples, summaries, reductionPercent };
}

try {
  const profiles = {};
  for (const variant of variants) {
    const { text } = run(
      [...common, "--target", "release", "--stats", ...variant.flags, "-o", path.join(work, `${variant.name}.wasm`)],
      true
    );
    const functions = [...text.matchAll(/^GCColoring (.+) legacy=(\d+) mcs=(\d+) selected=(\d+) nodes=(\d+)$/gm)].map(
      (m) => ({ name: m[1], legacyBytes: +m[2], mcsBytes: +m[3], selectedBytes: +m[4], nodes: +m[5] })
    );
    assert.ok(functions.length > 1000, "Expected compiler-source profile");
    for (const f of functions) {
      assert.ok(f.selectedBytes <= f.legacyBytes, `Frame grew: ${f.name}`);
      if (variant.name === "legacy") assert.equal(f.selectedBytes, f.legacyBytes);
    }
    profiles[variant.name] = {
      wasmBytes: fs.statSync(path.join(work, `${variant.name}.wasm`)).size,
      sha256: hash(path.join(work, `${variant.name}.wasm`)),
      functions,
    };
  }
  const initialHashes = Object.fromEntries(variants.map((v) => [v.name, profiles[v.name].sha256]));
  const nativeCompilation = benchmark((v) => [
    ...common,
    "--target",
    "release",
    "--stats",
    ...v.flags,
    "-o",
    path.join(work, `${v.name}.wasm`),
  ]);
  for (const v of variants) assert.equal(hash(path.join(work, `${v.name}.wasm`)), initialHashes[v.name]);
  const selfHostedExecution = benchmark((v) => [
    ...common,
    "--target",
    "fast",
    "--stats",
    "--asc-wasm",
    path.join(work, `${v.name}.wasm`),
    "-o",
    path.join(work, `${v.name}-self.wasm`),
  ]);
  assert.equal(
    hash(path.join(work, "legacy-self.wasm")),
    hash(path.join(work, "best-self.wasm")),
    "Self-hosted frontends must generate identical fast-target output"
  );
  const stress = {};
  for (const v of variants) {
    const plugin = path.join(work, `${v.name}-stress.wasm`);
    run([
      ...common,
      "--target",
      "release",
      ...v.flags,
      "--stats",
      "--exportTable",
      "--use",
      "ASC_GC_TESTING=1",
      "ASC_GC_IDLEFACTOR=0",
      "ASC_GC_GRANULARITY=64",
      "ASC_GC_SWEEPFACTOR=1000",
      "-o",
      plugin,
    ]);
    run([
      ...common,
      "--target",
      "fast",
      "--stats",
      "--asc-wasm",
      plugin,
      "-o",
      path.join(work, `${v.name}-stress-self.wasm`),
    ]);
    stress[v.name] = hash(path.join(work, `${v.name}-stress-self.wasm`));
  }
  assert.equal(stress.legacy, stress.best, "GC-stress self compilation output mismatch");
  assert.equal(stress.best, hash(path.join(work, "best-self.wasm")), "Stress changed compilation result");
  const functions = profiles.best.functions;
  const legacyFrameBytes = functions.reduce((s, f) => s + f.legacyBytes, 0);
  const selectedFrameBytes = functions.reduce((s, f) => s + f.selectedBytes, 0);
  const result = {
    date: new Date().toISOString(),
    revision: spawnSync("git", ["rev-parse", "HEAD"], { cwd: root, encoding: "utf8" }).stdout.trim(),
    environment: {
      platform: os.platform(),
      arch: os.arch(),
      cpu: os.cpus()[0].model,
      memoryBytes: os.totalmem(),
      node: process.version,
    },
    rounds,
    warmups,
    commands: { binary, common, buildTarget: "release", selfHostedTarget: "fast", legacyFlags: variants[0].flags },
    frames: {
      functionCount: functions.length,
      rootedFunctions: functions.filter((f) => f.legacyBytes > 0).length,
      improvedFunctions: functions.filter((f) => f.selectedBytes < f.legacyBytes).length,
      legacyFrameBytes,
      selectedFrameBytes,
      reductionPercent: (1 - selectedFrameBytes / legacyFrameBytes) * 100,
      note: "Sum of per-function frame sizes, not dynamic peak stack usage",
    },
    profiles,
    nativeCompilation,
    selfHostedExecution,
    correctness: { identicalSelfHostedOutput: true, gcStressIdenticalOutput: true, stressSha256: stress.best },
  };
  fs.mkdirSync(path.dirname(output), { recursive: true });
  fs.writeFileSync(output, JSON.stringify(result, null, 2) + "\n");
  console.log(
    JSON.stringify(
      {
        output,
        frames: result.frames,
        nativeReductionPercent: nativeCompilation.reductionPercent,
        runtimeReductionPercent: selfHostedExecution.reductionPercent,
        correctness: result.correctness,
      },
      null,
      2
    )
  );
  for (const entry of fs.readdirSync(work)) fs.unlinkSync(path.join(work, entry));
  fs.rmdirSync(work);
} catch (error) {
  console.error(`Benchmark failed; intermediate files retained in ${work}`);
  console.error(error);
  process.exitCode = 1;
}
