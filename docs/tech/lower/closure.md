[[toc]]

# Closure Lowering

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

Closure lowering in warpo replaces the high-level closure environment runtime calls
(`getClosureEnv`, `setClosureEnv`, `getClosureEnvByLevel`) with concrete Wasm operations:
global accesses and chained memory loads.

This page covers the assumptions, the two lowering paths (fast and optimized), and the
optimization algorithm used in the optimized path.

The implementation lives in `passes/Closure.cpp` and `passes/Closure.hpp`.

## Background: Closure Environment Chain

When a function captures variables from outer scopes, the compiler allocates a **closure
environment** — a heap object that holds the captured values. For nested closures, environments
form a linked list: each environment stores a pointer to its parent.

```
level 0          level 1          level 2
┌──────────┐     ┌──────────┐     ┌──────────┐
│ env (cur) │ ──► │ env (par) │ ──► │ env (gp)  │
│ captured  │     │ captured  │     │ captured  │
└──────────┘     └──────────┘     └──────────┘
```

Accessing a variable captured at nesting level N requires N pointer dereferences (chained
`i32.load`). The **level** concept is central:

- **Level 0**: the current environment, stored in the `heapIdx` local (no load needed).
- **Level N** (N > 0): parent environment N hops away; requires N `i32.load` operations
  starting from level 0.

## Assumptions

### Frontend-emitted IR markers

The frontend (AssemblyScript compiler) imports three closure builtins:

| Import name                            | Signature      | Purpose                                 |
| -------------------------------------- | -------------- | --------------------------------------- |
| `~lib/rt/closure/getClosureEnv`        | `() → i32`     | Get current closure environment pointer |
| `~lib/rt/closure/setClosureEnv`        | `(i32) → void` | Set current closure environment pointer |
| `~lib/rt/closure/getClosureEnvByLevel` | `(i32) → i32`  | Get environment at nesting level N      |

There is also an FFI variant:

| Import name                             | Signature      | Purpose                           |
| --------------------------------------- | -------------- | --------------------------------- |
| `~lib/builtins/ffi.set_ffi_closure_env` | `(i32) → void` | Set environment for FFI callbacks |

### Global variable

Lowering materializes a mutable global `~lib/rt/closure/env` (i32) to hold the current
closure environment pointer. `getClosureEnv` / `setClosureEnv` are replaced with
`global.get` / `global.set` on this variable.

### `heapIdx` local

Each function that uses closures has a `heapIdx` local (provided by `VariableInfo`) that holds
the function's own closure environment pointer — this is level 0.

## Workflow Overview

Closure lowering runs during the lowering phase (see `passes/Runner.cpp`), before GC lowering
and after inline-decorator lowering. The path depends on optimization level:

```
lowering()
├─ InlinedDecoratorLower
├─ if optimizeLevel > 0 || shrinkLevel > 0:
│    closure::OptLower          ◄── optimized path
│    gc::OptLower
└─ else:
     closure::FastLower         ◄── fast path
     gc::FastLower
```

Both paths share common steps:

1. **Scan** — `ClosureCallScanner` checks if closure calls exist in the module.
2. **Common lowering** — `ClosureEnvCommonLower` replaces `getClosureEnv` / `setClosureEnv`
   with `global.get` / `global.set` on `~lib/rt/closure/env`.
3. **By-level lowering** — Replace each `getClosureEnvByLevel(N)` with chained loads.
4. **Cleanup** — `removeClosureImports` removes the imported function declarations.

Special case: if the module has `setClosureEnv` but no `getClosureEnv`, the set calls are
dead code and are removed by `SetClosureEnvRemover`.

## Fast Lowering (`closure::FastLower`)

Fast lowering performs no cross-block analysis. Each `getClosureEnvByLevel(N)` call is
replaced inline with N chained `i32.load` operations starting from the `heapIdx` local:

```wasm
;; getClosureEnvByLevel(3)
;; Before:
(call $~lib/rt/closure/getClosureEnvByLevel
  (i32.const 3))

;; After (fast):
(i32.load          ;; load 3
  (i32.load        ;; load 2
    (i32.load      ;; load 1
      (local.get $heapIdx))))
```

This is simple and correct but may generate redundant loads when the same or intermediate
levels are accessed multiple times.

## Optimized Lowering (`closure::OptLower`)

The optimized path caches intermediate level results in locals to avoid redundant
pointer-chasing. It runs three sub-passes:

```
OptLower::run(m)
├─ Pass 1: ClosureEnvCommonLower
│   Replace get/set with global.get/global.set
├─ Pass 2: OptClosureEnvAnalyzer (per-function, parallel)
│   Build CFG + dominator tree
│   Three-phase analysis → ActionPlan per call site
├─ Pass 3: OptGetClosureEnvByLevelLower
│   Apply ActionPlans: insert cache stores + rewrite calls
└─ removeClosureImports
```

### Key data structures

#### `ClosureEnvDefMap`

Per-function map tracking which basic blocks have cached level definitions.

- **`BlockClosureInfo`** — per-block state:
  - `definedLevels`: sorted list of `(level, localIndex)` pairs — levels cached in this block.
  - `levelCounts`: per-level usage count vector.
- **`CFG`** + **`DomTree`** — control flow graph and dominator tree for the function.

#### `ActionPlan`

Describes what to do at a specific IR expression:

- `saveTempLevelAction`: list of cache assignments (load from source level local, store to
  target level local).
- `lowerCallAction`: which cached local to start from when lowering a `getClosureEnvByLevel`
  call.

### Three-phase analysis (`doWalkFunction`)

#### Phase 1: Record level usage

```
forEachGetClosureEnvByLevel → insertUsedLevel(block, level)
```

Walks all `getClosureEnvByLevel` calls and records which levels are used in each basic block,
along with their usage counts.

#### Phase 2: Loop hoisting

```
for each block inside a loop:
  if block has at least one successor inside the loop:
    hoist all used levels via addDef(&bb, level, &insideLoop)
```

Blocks inside loops benefit from caching: the chained loads are hoisted out of the loop.
The `insideLoop` parameter tells `addDef` to walk the dominator tree up until it escapes
the loop.

Blocks that are loop exits (all successors leave the loop, e.g. `return` or `br` out) are
**skipped** — there is no benefit to hoisting since the code runs at most once.

Blocks handled by loop hoisting are recorded in `loopHandled` and skipped in Phase 3.

#### Phase 3: Branch hoisting

```
for each block NOT handled by loop hoisting:
  for each level with count > 0:
    if level < maxLevel OR count > 1:
      addDef(&bb, level)
```

Caching decision:

- **Multiple uses** (`count > 1`): cache to avoid redundant load chains.
- **Intermediate level** (`level < maxLevel`): cache because a deeper level will
  reuse this intermediate result.
- **Single use of max level**: not cached — inline the loads directly.

### The `addDef` algorithm

`addDef` decides where to place the cache assignment by walking the dominator tree:

1. **Find highest reusable ancestor**: walk dominator chain upward from the original block.
   A block is "reusable" if it already has closure-related activity (levels with non-zero
   usage counts, or existing cached definitions) at a level ≥ the current level.

2. **Escape loop** (when `insideLoop` is provided): continue walking dominators upward until
   reaching a block outside the loop. This ensures the cache store is placed before the loop.

3. **Allocate local**: create a new i32 local and record `(level, localIndex)` in the target
   block's `definedLevels`. If the level already has a definition in that block, return
   `nullopt` (no duplicate).

### Generating cache stores (`getInsertions`)

After analysis, `getInsertions` determines where to insert cache stores:

For each block with cached definitions:

1. Find an **anchor** expression:
   - The first `getClosureEnvByLevel` call in the block, or
   - The last expression in the block (fallback for blocks with no such call, e.g. loop
     preheader after hoisting).
2. For each defined level, build a `CacheLevelInLocalAction`:
   - Source: closest cached level ≤ `(targetLevel - 1)`, or level 0 (`heapIdx`).
   - Target: the new local for this level.

### Applying the plans

`OptGetClosureEnvByLevelLower` walks the module and applies each `ActionPlan`:

- **Both save + lower at same anchor**: combine into a single block —
  cache stores followed by the lowered call.
- **Save only**: insert cache stores at end of basic block (via `ExprInserter::insertAtEndOfBB`).
- **Lower only**: replace `getClosureEnvByLevel(N)` with loads starting from the closest
  cached local.

### Example

Source:

```ts
function outer(): i32 {
  let x: i32 = 10;
  function middle(): i32 {
    let y: i32 = 20;
    function inner(): i32 {
      return x + y; // x is level 2, y is level 1
    }
    return inner();
  }
  return middle();
}
```

In `inner`, both `x` (level 2) and `y` (level 1) are accessed. The optimized lowering:

1. Caches level 1 in a local: `local.set $cached1 (i32.load (local.get $heapIdx))`
2. Rewrites `getClosureEnvByLevel(1)` → `local.get $cached1`
3. Rewrites `getClosureEnvByLevel(2)` → `i32.load (local.get $cached1)` (one load from cached level 1, instead of two from level 0)

```wasm
;; Optimized inner function (simplified):
(func $inner
  ;; Cache level 1 into $cached1
  (local.set $cached1
    (i32.load (local.get $heapIdx)))
  ;; Access y (level 1): use cached local
  (i32.load offset=4
    (local.get $cached1))
  ;; Access x (level 2): one load from cached level 1
  (i32.load offset=4
    (i32.load (local.get $cached1)))
  (i32.add))
```

### Loop hoisting example

When closure environment access happens inside a loop, the optimized path hoists the cache
store to a block before the loop:

```ts
function outer(): i32 {
  let sum: i32 = 0;
  function inner(n: i32): i32 {
    for (let i = 0; i < n; i++) {
      sum += i; // sum is level 1, accessed every iteration
    }
    return sum;
  }
  return inner(100);
}
```

Without loop hoisting, `i32.load (local.get $heapIdx)` runs every iteration. With loop
hoisting, the cache store is placed before the loop:

```wasm
;; Before loop:
(local.set $cached1
  (i32.load (local.get $heapIdx)))
;; Inside loop: uses $cached1 directly
(i32.load offset=4
  (local.get $cached1))
```
