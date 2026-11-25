# GC root-slot coloring

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

The optimized GC lowering path tries two colorings of the **same** interference
graph:

1. The existing degree-ordered greedy coloring.
2. Maximum-cardinality-search (MCS) ordered greedy coloring. Each step selects the
   uncolored node with the most already selected neighbors, breaking ties by
   descending SSA index.

Both assign the smallest available color. MCS uses a dense, quadratic-time
implementation, matching the existing adjacency-matrix representation. This is
inspired by Julia's late GC lowering; it does not assume that every Warpo
interference graph is chordal or that MCS always gives an optimal coloring.

## Selection uses emitted slots

Each candidate goes through the same marker-to-offset assignment. Select MCS only
when its **actual emitted frame** is strictly smaller:

```text
frameBytes = markerOffsets.empty()
    ? 0
    : max(markerOffsets) + ShadowStackElementSize
```

Otherwise retain the old result, including on ties. Empty and one-slot frames
skip MCS because they cannot become smaller while retaining the same stores.
`StackPosition::getFrameSize`
is shared with prologue/epilogue generation so selection and allocation use the
same size calculation.

Counting graph colors alone is insufficient: caller-managed parameters and other
analysis nodes do not necessarily emit stores in this function. A coloring with
fewer total colors can place the emitted nodes at larger offsets.

The vanilla, non-coloring path is unchanged. The optimization does **not** change
liveness, interference edges, root-store positions, or frame activation regions.
In particular, it does not enable safepoint-only interference without the
corresponding root-store scheduling.

## Comparison and diagnostics

The native compiler accepts the hidden comparison option
`--gc-legacy-coloring`, which disables the MCS candidate without disabling other
GC optimizations:

```sh
./build/warpo/warpo_asc --config asconfig.json --target release \
  --gc-legacy-coloring -o /tmp/frontend-legacy.wasm

./build/warpo/warpo_asc --config asconfig.json --target release \
  -o /tmp/frontend-best.wasm
```

`WARPO_DEBUG_PASSES=GCColoring` prints one line per function containing legacy,
MCS-candidate and selected frame bytes. When MCS is disabled or at most one slot is
emitted, its reported size equals the legacy size because no candidate is run.
This diagnostic does not dump the full interference graph.

The existing `GCStackAssigner` diagnostic still prints the graph and selected
colors.

## Reproducible benchmark

After `npm run build`, run:

```sh
ROUNDS=9 WARMUPS=2 node tests/bootstrap/gc_coloring_bench.mjs
```

An optional first argument specifies the output JSON path. By default it is
`tests/bootstrap/tmp/gc-coloring/results.json`.

The benchmark:

- Verifies that the native CLI actually honors the legacy switch.
- Compiles the complete compiler frontend with both colorings.
- Profiles emitted frame bytes separately from timings.
- Disables debug output for timed runs, warms each variant, and alternates order.
- Measures native compilation overhead and executes both generated frontends
  using the bundled Wasm backend to compile the same input again.
- Requires byte-identical fast-target self-compilation outputs.
- Repeats self compilation with `ASC_GC_TESTING=1` and aggressive collection,
  checking the same output hash.
- Records individual samples, medians, ranges, build commands and environment.

The sum of per-function frame sizes is a static metric, **not** peak dynamic
shadow-stack usage. A percentage reduction in this sum is not an execution-time
speedup. Results from a development host are not vehicle-target measurements.

## Dynamic resource measurements

To measure actual root-stack use rather than summing static frames, run:

```sh
ROUNDS=40 WARMUPS=6 node tests/bootstrap/gc_dynamic_bench.mjs
```

This requires the existing Binaryen JS package and `wat2wasm`. An optional first
argument specifies the output JSON path. The default is
`tests/bootstrap/tmp/gc-dynamic-results.json`.

The harness instruments the final optimized module, without running further
optimization passes, and counts:

- Peak active shadow-stack bytes.
- Zero-fill and zero-valued scalar-store bytes within the active root region.
- GC loads from that region, separate from other root-region reads.
- Final linear-memory pages and restored stack position.

The profiler has a known-answer calibration, including truncated integer stores,
floating-point bit patterns and single evaluation of side-effecting operands.
Instrumented and original frontends must generate identical output.

The hidden native option `--frontend-gc-metrics` reads the instrumented frontend's
`__gc_metric` export after compilation. It is not for uninstrumented frontends.
General debug logging does not enable it.

The harness also rebuilds smaller root-stack configurations, verifies a legacy
overflow at the selected smaller budget, and searches a fixed linear-memory
boundary with adjacent and lower-point checks. That search assumes monotone
success; it is not an exhaustive minimum-memory proof.

Timings use the original **uninstrumented** frontends, alternating AB/BA order.
The JSON includes samples and paired block-bootstrap intervals. Reduced root
maintenance traffic does not by itself establish faster execution, fewer memory
pages, lower process RSS, or a safe production stack-size limit.
