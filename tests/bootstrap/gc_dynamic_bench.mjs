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
import binaryen from "binaryen";
import { instrument, metricNames, selfTest } from "./gc_profile.mjs";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../..");
const binary = path.join(root, "build/warpo/warpo_asc");
const output = path.resolve(process.argv[2] ?? "tests/bootstrap/tmp/gc-dynamic-results.json");
const work = process.env.WORK ?? fs.mkdtempSync(path.join(os.tmpdir(), "warpo-gc-dynamic-"));
const rounds = Number(process.env.ROUNDS ?? 40);
const warmups = Number(process.env.WARMUPS ?? 6);
assert.ok(Number.isInteger(rounds) && rounds >= 20 && rounds % 2 === 0);
assert.ok(Number.isInteger(warmups) && warmups >= 2 && warmups % 2 === 0);
assert.ok(path.basename(work).startsWith("warpo-gc-dynamic-"), "Unexpected resume directory");
const variants = [
  { name: "legacy", flags: ["--gc-legacy-coloring"] },
  { name: "best", flags: [] },
];
const common = ["--config", "asconfig.json"];
const sha = (file) => createHash("sha256").update(fs.readFileSync(file)).digest("hex");
const stageFile = path.join(work, "progress.json");
let data;

function command(executable, args, env = {}, allowFailure = false) {
  const start = performance.now();
  const child = spawnSync(executable, args, {
    cwd: root,
    env: { ...process.env, WARPO_DEBUG: "0", WARPO_DEBUG_PASSES: "", WARPO_DEBUG_FUNCTIONS: "", ...env },
    encoding: "utf8",
    maxBuffer: 64 * 1024 * 1024,
    timeout: 180_000,
  });
  if (child.error) throw child.error;
  const text = child.stdout + child.stderr;
  assert.ok(!text.includes("unknown argument ignored"), text);
  if (!allowFailure) assert.equal(child.status, 0, text);
  return { wallMs: performance.now() - start, status: child.status, text };
}

function compile(args, debug = false, allowFailure = false) {
  return command(binary, [...args, ...(debug ? ["--frontend-gc-metrics"] : [])], {}, allowFailure);
}

function save() {
  fs.writeFileSync(stageFile, JSON.stringify(data, null, 2) + "\n");
}

function build(v, name, extra = []) {
  const file = path.join(work, name + ".wasm");
  compile([...common, "--target", "release", ...v.flags, ...extra, "-o", file]);
  return file;
}

function profile(file, name) {
  const named = path.join(work, name + "-named.wasm");
  command("wat2wasm", ["--debug-names", file.replace(/\.wasm$/, ".wat"), "-o", named]);
  const m = binaryen.readBinary(fs.readFileSync(named));
  const metadata = instrument(m);
  const profiled = path.join(work, name + "-profile.wasm");
  fs.writeFileSync(profiled, m.emitBinary());
  m.dispose();
  assert.ok(metadata.sites.stackSets > 0);
  return { profiled, metadata };
}

function execute(frontend, workload, debug = false, allowFailure = false) {
  return compile(
    [...workload.args, "--stats", "--asc-wasm", frontend, "-o", path.join(work, "compiled.wasm")],
    debug,
    allowFailure
  );
}

function readMetrics(run, metadata) {
  const lines = [...run.text.matchAll(/^GCDynamic (.+)$/gm)];
  assert.equal(lines.length, 1, run.text);
  const values = Object.fromEntries([...lines[0][1].matchAll(/(\w+)=(\d+)/g)].map((m) => [m[1], Number(m[2])]));
  assert.deepEqual(Object.keys(values), metricNames);
  assert.equal(values.finalBytes, 0, "Root stack was not restored");
  return {
    ...values,
    zeroWriteBytes: values.zeroFillBytes + values.zeroStoreBytes,
    lastOtherReaderName: values.otherRootReadBytes ? metadata.owners[values.lastOtherReader] : null,
  };
}

function capMemory(bytes, pages) {
  const read = (offset) => {
    let value = 0,
      shift = 0,
      next;
    do {
      next = bytes[offset++];
      value += (next & 127) * 2 ** shift;
      shift += 7;
    } while (next & 128);
    return [value, offset];
  };
  const leb = (value) => {
    const result = [];
    do {
      const next = value % 128;
      value = Math.floor(value / 128);
      result.push(next | (value ? 128 : 0));
    } while (value);
    return result;
  };
  let offset = 8;
  while (offset < bytes.length) {
    const start = offset,
      id = bytes[offset++];
    const [size, body] = read(offset);
    if (id === 5) {
      const [count, limits] = read(body);
      assert.equal(count, 1, "Expected a single defined memory");
      assert.ok(bytes[limits] === 0 || bytes[limits] === 1, "Expected unshared wasm32 memory");
      const payload = [1, 1, ...leb(pages), ...leb(pages)];
      return Buffer.concat([
        bytes.subarray(0, start),
        Buffer.from([5, ...leb(payload.length), ...payload]),
        bytes.subarray(body + size),
      ]);
    }
    offset = body + size;
  }
  throw Error("No defined memory section");
}

function fixedMemoryBoundary(file, workload, metadata, observedPages) {
  const top = metadata.stackTop;
  const bytes = fs.readFileSync(file);
  const trials = [];
  const capped = path.join(work, "capped.wasm");
  const m = binaryen.readBinary(bytes);
  const initialPages = m.getMemoryInfo().initial;
  m.dispose();
  function trial(pages) {
    const cached = trials.find((t) => t.pages === pages);
    if (cached) return cached.ok;
    fs.writeFileSync(capped, capMemory(bytes, pages));
    const run = execute(capped, workload, false, true);
    const ok = run.status === 0;
    if (ok) assert.equal(sha(path.join(work, "compiled.wasm")), workload.sha256);
    else assert.match(run.text, /unreachable|out of memory|allocation|memory limit/i, run.text);
    const firstFrame = run.text.match(/wasm-function\[(\d+)\]/);
    trials.push({
      pages,
      ok,
      failureTopFunction: !ok && firstFrame ? metadata.owners[+firstFrame[1]] : undefined,
      failure: ok ? undefined : run.text.slice(-3000),
    });
    console.log(`  fixed-memory ${path.basename(file)} ${pages} pages: ${ok ? "pass" : "fail"}`);
    return ok;
  }
  let low = Math.ceil(top / 65536) - 1;
  let high = Math.max(initialPages, observedPages);
  assert.ok(trial(high), "Baseline fixed memory must suffice");
  while (high - low > 1) {
    const mid = Math.floor((high + low) / 2);
    if (trial(mid)) high = mid;
    else low = mid;
  }
  for (const pages of [high - 2, high - 4, high - 8]) {
    if (pages >= Math.ceil(top / 65536)) assert.equal(trial(pages), false, "Nonmonotone memory boundary");
  }
  return {
    passingPages: high,
    passingBytes: high * 65536,
    failingAdjacentPages: low,
    trials,
    method:
      "Binary search assuming monotone success; adjacent boundary and up to three lower points checked. Not an exhaustive proof over all page counts.",
  };
}

function stackBudgetWitness(workload, bytes) {
  execute(path.join(work, "best-small-stack.wasm"), workload);
  assert.equal(sha(path.join(work, "compiled.wasm")), workload.sha256);
  const file = build(variants[0], "legacy-at-best-budget", ["--stackSize", String(bytes)]);
  const failure = execute(file, workload, false, true);
  assert.notEqual(failure.status, 0, "Legacy unexpectedly passed the smaller root-stack budget");
  const named = path.join(work, "budget-witness-named.wasm");
  command("wat2wasm", ["--debug-names", file.replace(/\.wasm$/, ".wat"), "-o", named]);
  const m = binaryen.readBinary(fs.readFileSync(named));
  const failureFrames = [...failure.text.matchAll(/wasm-function\[(\d+)\]/g)].map((match) => ({
    index: +match[1],
    name: binaryen.getFunctionInfo(m.getFunctionByIndex(+match[1])).name,
  }));
  m.dispose();
  assert.ok(
    failureFrames.some((f) => f.name.includes("__decrease_sp")),
    "Expected root-stack guard failure"
  );
  return {
    oldRootStackBytes: bytes,
    workload: workload.name,
    oldFailed: true,
    newPassedSameWorkloadAndBudget: true,
    newOutputEqualsOldLargerBudget: true,
    sha256: workload.sha256,
    failureFrames,
    failureText: failure.text.slice(0, 3500),
  };
}

function median(values) {
  const sorted = [...values].sort((a, b) => a - b);
  const middle = Math.floor(sorted.length / 2);
  return sorted.length % 2 ? sorted[middle] : (sorted[middle - 1] + sorted[middle]) / 2;
}

function timings(run) {
  const values = { wallMs: run.wallMs };
  for (const match of run.text.matchAll(/^\s*- ([A-Za-z_]+): \d+ times, total ([\d.]+)(s|ms|µs|us|ns)\s*$/gm)) {
    values[match[1]] = +match[2] * { s: 1000, ms: 1, µs: 0.001, us: 0.001, ns: 0.000001 }[match[3]];
  }
  for (const key of ["CompilationHIR_Compilation", "CompilationHIR_Parsing", "CompilationHIR"])
    assert.ok(Number.isFinite(values[key]));
  return values;
}

function timingExperiment(files, workload) {
  const samples = { legacy: [], best: [] };
  for (let i = -warmups; i < rounds; ++i) {
    const order = Math.abs(i) % 2 ? [...variants].reverse() : variants;
    for (const v of order) {
      const run = execute(files[v.name], workload);
      assert.equal(sha(path.join(work, "compiled.wasm")), workload.sha256);
      if (i >= 0) samples[v.name].push(timings(run));
    }
  }
  let state = 0x417c9a31;
  const random = () => {
    state ^= state << 13;
    state ^= state >>> 17;
    state ^= state << 5;
    return (state >>> 0) / 2 ** 32;
  };
  const summary = {};
  for (const key of ["wallMs", "CompilationHIR_Compilation", "CompilationHIR_Parsing", "CompilationHIR"]) {
    const old = samples.legacy.map((s) => s[key]),
      next = samples.best.map((s) => s[key]);
    // Resample balanced AB/BA blocks, retaining each pair's temporal relationship.
    const blocks = Array.from(
      { length: rounds / 2 },
      (_, i) => [0, 1].map((j) => Math.log(next[2 * i + j] / old[2 * i + j])).reduce((a, b) => a + b) / 2
    );
    const reductions = [];
    for (let n = 0; n < 20_000; ++n) {
      let total = 0;
      for (let i = 0; i < blocks.length; ++i) total += blocks[Math.floor(random() * blocks.length)];
      reductions.push(100 * (1 - Math.exp(total / blocks.length)));
    }
    reductions.sort((a, b) => a - b);
    summary[key] = {
      legacy: { median: median(old), min: Math.min(...old), max: Math.max(...old) },
      best: { median: median(next), min: Math.min(...next), max: Math.max(...next) },
      medianReductionPercent: 100 * (1 - median(next) / median(old)),
      pairedGeometricReductionPercent: 100 * (1 - Math.exp(blocks.reduce((a, b) => a + b) / blocks.length)),
      pairedBlockBootstrap95Percent: [reductions[500], reductions[19499]],
    };
  }
  return { rounds, warmups, bootstrapReplicates: 20_000, seed: "0x417c9a31", samples, summary };
}

try {
  console.log(`Work directory: ${work}`);
  const calibration = selfTest();
  const memoryTest = binaryen.parseText('(module (memory (export "memory") 1) (data (i32.const 16) "abc"))');
  const cappedTest = capMemory(memoryTest.emitBinary(), 2);
  assert.equal(new WebAssembly.Instance(new WebAssembly.Module(cappedTest)).exports.memory.buffer.byteLength, 131072);
  memoryTest.dispose();
  if (fs.existsSync(stageFile)) {
    data = JSON.parse(fs.readFileSync(stageFile, "utf8"));
    assert.equal(data.binarySha256, sha(binary), "Resume requires the same compiler binary");
    assert.equal(data.profilerSha256, sha(path.join(root, "tests/bootstrap/gc_profile.mjs")));
    console.log("Resuming recorded measurements");
  } else {
    data = {
      date: new Date().toISOString(),
      revision: command("git", ["rev-parse", "HEAD"]).text.trim(),
      binarySha256: sha(binary),
      profilerSha256: sha(path.join(root, "tests/bootstrap/gc_profile.mjs")),
      environment: {
        platform: os.platform(),
        arch: os.arch(),
        cpu: os.cpus()[0].model,
        memoryBytes: os.totalmem(),
        node: process.version,
      },
      calibration,
      variants: {},
      workloads: [{ name: "self", args: [...common, "--target", "fast"] }],
    };
    for (const depth of [16, 64, 128]) {
      const input = path.join(work, `nested-${depth}.ts`);
      const source =
        [
          "class Box<T> { value: T; constructor(value: T) { this.value = value; } }",
          "type L0 = i32;",
          ...Array.from({ length: depth }, (_, i) => `type L${i + 1} = Box<L${i}>;`),
          `export function keep(value: L${depth}): L${depth} { return value; }`,
        ].join("\n") + "\n";
      fs.writeFileSync(input, source);
      data.workloads.push({
        name: `nested${depth}`,
        depth,
        args: [input, "--runtime", "incremental", "--exportRuntime"],
      });
    }
    for (const v of variants) {
      console.log(`Build and instrument ${v.name}`);
      const file = build(v, v.name);
      const { profiled, metadata } = profile(file, v.name);
      data.variants[v.name] = {
        file,
        profiled,
        metadata,
        sha256: sha(file),
        bytes: fs.statSync(file).size,
        profiles: {},
      };
      for (const workload of data.workloads) {
        console.log(`  profile ${v.name}/${workload.name}`);
        const run = execute(profiled, workload, true);
        const hash = sha(path.join(work, "compiled.wasm"));
        if (workload.sha256) assert.equal(hash, workload.sha256);
        else workload.sha256 = hash;
        const plain = execute(file, workload);
        assert.equal(sha(path.join(work, "compiled.wasm")), hash, "Instrumentation changed compilation output");
        data.variants[v.name].profiles[workload.name] = readMetrics(run, metadata);
      }
    }
    save();
  }
  if (process.env.PHASE === "profile") {
    console.log(
      JSON.stringify(
        { work, profiles: Object.fromEntries(variants.map((v) => [v.name, data.variants[v.name].profiles])) },
        null,
        2
      )
    );
  } else {
    const self = data.workloads[0];
    if (!data.fixedMemory) {
      data.fixedMemory = {};
      for (const v of variants) {
        console.log(`Find fixed-memory boundary ${v.name}`);
        const info = data.variants[v.name];
        data.fixedMemory[v.name] = fixedMemoryBoundary(info.file, self, info.metadata, info.profiles.self.memoryPages);
      }
      save();
    }
    if (!data.stackConfiguration) {
      data.stackConfiguration = {};
      for (const v of variants) {
        const info = data.variants[v.name];
        const workload = data.workloads.reduce((a, b) =>
          info.profiles[a.name].peakBytes > info.profiles[b.name].peakBytes ? a : b
        );
        const budget = Math.ceil(info.profiles[workload.name].peakBytes / 16) * 16;
        console.log(
          `Validate smaller root-stack configuration ${v.name}: ${budget} bytes, peak workload ${workload.name}`
        );
        const configured = build(v, `${v.name}-small-stack`, ["--stackSize", String(budget)]);
        for (const input of data.workloads) {
          execute(configured, input);
          assert.equal(sha(path.join(work, "compiled.wasm")), input.sha256);
        }
        data.stackConfiguration[v.name] = { bytes: budget, basedOnWorkload: workload.name, allWorkloadsPassed: true };
      }
      save();
    }
    if (!data.stackConfiguration.counterfactual) {
      const configured = data.stackConfiguration.best;
      const workload = data.workloads.find((w) => w.name === configured.basedOnWorkload);
      data.stackConfiguration.counterfactual = stackBudgetWitness(workload, configured.bytes);
      save();
    }
    if (!data.timing) {
      console.log(`Uninstrumented timing: ${rounds} measured pairs after ${warmups} warmup pairs`);
      data.timing = timingExperiment(
        Object.fromEntries(variants.map((v) => [v.name, data.variants[v.name].file])),
        self
      );
      save();
    }
    const result = structuredClone(data);
    for (const v of variants) {
      delete result.variants[v.name].file;
      delete result.variants[v.name].profiled;
      delete result.variants[v.name].metadata.owners;
    }
    fs.mkdirSync(path.dirname(output), { recursive: true });
    fs.writeFileSync(output, JSON.stringify(result, null, 2) + "\n");
    console.log(
      JSON.stringify(
        {
          output,
          fixedMemory: result.fixedMemory,
          stackConfiguration: result.stackConfiguration,
          timing: result.timing.summary,
        },
        null,
        2
      )
    );
    for (const entry of fs.readdirSync(work)) fs.unlinkSync(path.join(work, entry));
    fs.rmdirSync(work);
  }
} catch (error) {
  console.error(`Dynamic benchmark failed; intermediates retained in ${work}`);
  console.error(error);
  process.exitCode = 1;
}
