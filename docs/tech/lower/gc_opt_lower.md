[[toc]]

# Opt Lowering

`gc::OptLower` (`passes/GC/OptLower.cpp`) is a more complex GC lowering pipeline. It builds an SSA model for GC objects, runs liveness analysis on the CFG, assigns shadow-stack slots based on live ranges, and can also do shrink wrap. Shrink wrap tries to move the prologue/epilogue close to the region where the shadow stack is really needed.

Compared with `gc::FastLower`, the optimized pipeline costs more time, but it usually achieves:

- A smaller shadow-stack frame.
- Fewer `tostack` stores (many sites can be proven “no need to tostack” and then removed).

The sections below follow the pass order in `OptLower::run()`.

## Preprocess: `vacuum` / `merge-blocks` (Binaryen)

#### Rationale

Most analyses in optimized lowering depend on the CFG, the dominator tree, and the number of basic blocks. This step reduces IR “noise” and merges blocks, which lowers later analysis cost and avoids too many fixed address computations.

#### Method

`OptLower::preprocess()` adds two Binaryen passes into `wasm::PassRunner`:

- `vacuum`: removes useless IR.
- `merge-blocks`: merges basic blocks and reduces block count.

#### Example

This is a Binaryen cleanup step, so the exact output depends on surrounding IR. Conceptually, it removes empty/dead constructs and merges trivial blocks:

Before (illustrative):

```wasm
(func $f
  block ;;none
    block ;;none
      ;; empty / dead block
    end
    ;; other IR
  end
)
```

After `vacuum` + `merge-blocks` (illustrative):

```wasm
(func $f
  block ;;none
    ;; other IR
  end
)
```

## `ImmutableGlobalToStackRemover`

#### Rationale

The pattern `__tmptostack(global.get <immutable global>)` is usually not needed. An immutable global is not lost because of GC and is not modified. Writing it to the shadow stack only adds extra stores and increases frame cost.

#### Method

Scan the function for temporary-root markers that simply forward an immutable global value.

- Use `VariableInfo` (or equivalent metadata) to decide whether the referenced global is immutable.
- If it is immutable, drop the marker and keep the underlying value expression, avoiding an unnecessary shadow-stack store.

#### Example

Immutable global: the marker is removed, so there is no shadow-stack prologue/store around it.

```wasm
(func $.../_start
  global.get $.../a
  global.get $.../a
  call $.../bar
)
```

Mutable global: the store is preserved, and the function opens/closes the shadow stack.

```wasm
(func $.../_start
  block ;;none
      i32.const 8
    call $~lib/rt/__decrease_sp
      block ;;i32
          global.get $~lib/memory/__stack_pointer
          global.get $.../a
        i32.store $0 align=1
        global.get $.../a
      end
    call $.../bar
      i32.const 8
    call $~lib/rt/__increase_sp
  end
)
```

## `CallGraphBuilder`

#### Rationale

“May this call trigger GC?” is a key condition for many optimizations. If a call and everything it can reach will never trigger `__new/__collect`, then keeping shadow-stack roots around it is less important.

#### Method

Collect a module-level call graph (who may call whom) and pass it to later analyses that need to reason about reachability of GC trigger points.

#### Example

`CallGraphBuilder` is analysis-only, so it does not directly change WAT by itself. Its impact is visible in later filtering passes that treat calls differently based on whether they can reach GC triggers.

For a concrete “visible effect”, see the `LeafFunctionCollector` / `LeafFunctionFilter` examples below.

## `LeafFunctionCollector` (`GCLeafFunction`)

#### Rationale

GC trigger points (`~lib/rt/*/__new`, `~lib/rt/*/__collect`) decide which functions can trigger GC (directly or indirectly). If we can find functions that will not trigger GC, later filtering can be stronger: keep roots only around calls that may trigger GC.

#### Method

Do a reverse reachability marking on the call graph:

- Start from known runtime GC trigger entrypoints (allocation / collection).
- Mark all functions that can reach those entrypoints (transitively) as **non-leaf**.
- The remaining functions are treated as **leaf** (cannot trigger GC through any call chain).

#### Example

When a call site is known to be able to reach a GC trigger (e.g. an explicit collect), the lowering must keep required roots alive across that call:

```wasm
... ;; allocate/build an object
global.get $~lib/memory/__stack_pointer
local.get $obj
i32.store $0 align=1   ;; root materialized
call $~lib/rt/itcms/__collect
... ;; object is still used after the call
```

In contrast, if all relevant calls on a path are leaf (cannot reach `__new/__collect`), later filtering may remove rooting and even remove the prologue/epilogue entirely.

## `ObjLivenessAnalyzer`

#### Rationale

The core idea is: “a root is needed only if the object is still live at a possible GC point”. To do this, we need the live range (before/after) of each GC-object SSA value on the CFG.

#### Method

Build an SSA-like model for “GC-object values that may need rooting”, then compute where each such value is live on the CFG.

1. **Define the SSA index space**
   - Identify the IR constructs that represent “values that participate in rooting” (for example, caller-managed object values and the internal root markers).
   - Assign each such value a stable SSA dimension so later passes can refer to it cheaply.

2. **Compute liveness on the CFG**
   - Use dataflow analysis to determine which SSA dimensions are live before/after key program points.
   - Record a compact `before`/`after` representation (`LivenessMap`) for later filtering and slot assignment.

#### Example

Liveness decides whether a root must be materialized at a potential GC point. A typical pattern is:

```wasm
... ;; produce object value
global.get $~lib/memory/__stack_pointer
local.get $obj
i32.store $0 align=1   ;; root because $obj is live across a GC-capable call
call $~lib/rt/itcms/__collect
... ;; $obj is used afterwards
```

If an object is proven dead before any GC trigger point, the corresponding stores/slots can be removed by later stages.

See:

## `MergeSSA`

#### Rationale

Many tmp SSA values are just a “move/reference” of an existing local value (for example, `__tmptostack(local.get ...)`). If we merge such tmp SSA into the local SSA, we reduce the SSA size and can further reduce the needed slot count.

#### Method

Coalesce “pure forwarding” temporary SSA dimensions into the underlying source dimension.

- Use `LivenessMap` to resolve which source SSA dimension is live at the forwarding site.
- Merge the temporary live range into the source live range.
- Mark the temporary dimension as invalid so it does not consume a stack slot later.

Note: in `OptLower`, this step must happen before `LeafFunctionFilter`, because that pass may mark some SSA values as invalid, which would break `MergeSSA`.

#### Example

When a temporary SSA is just forwarding an existing live value, merging SSA can reduce frame size and remove redundant stores.

In this snapshot, the frame size is reduced and a redundant store is eliminated:

```wasm
;; frame size reduced: 12 -> 8
i32.const 8
call $~lib/rt/__decrease_sp

... ;; one store remains
global.get $~lib/memory/__stack_pointer
local.get $...
i32.store $0 offset=4 align=1

... ;; a later forwarding-store is removed
```

## `LeafFunctionFilter`

#### Rationale

If an SSA object is live only around leaf calls, then even if it is live, it will not meet a real GC trigger point. Such a root can be removed, which reduces shadow-stack pressure.

#### Method

Filter the liveness model to keep only roots that matter at potential GC trigger points.

- Treat **non-leaf direct calls** and **all indirect calls** as potential GC trigger points.
- Collect the set of SSA dimensions that are live at those points.
- Invalidate all other SSA dimensions so they do not affect slot assignment or shrink-wrapping decisions.

Note: caller-managed parameters are handled specially by later stages (they should not force opening the shadow stack in the callee).

#### Example

If an object is live only around leaf calls (no reachable GC trigger), leaf filtering can remove the shadow-stack management entirely:

```wasm
(func $.../_start (result i32)
  ...
  call $~lib/rt/itcms/__new
  call $.../constructor
  ;; no __decrease_sp / no i32.store rooting / no __increase_sp
  return
)
```

## `StackAssigner`

#### Rationale

After we know “which SSA values become live at which points”, we need to map these “become-live `tostack` sites” to concrete shadow-stack offsets (slot/offset). A better assignment lets non-conflicting objects (no overlap in lifetime) reuse the same slot, which reduces the frame size.

#### Method

Assign concrete shadow-stack slots (offsets) to the remaining SSA dimensions based on their live ranges.

- Detect the program points where an SSA dimension first becomes live.
- Associate those “become-live” sites with the corresponding rooting marker.
- Choose an offset for each marker and record it as the stack position.

There are two strategies:

- **Vanilla**: when an SSA value is first seen, assign a new slot (simple but can be large).
- **GreedyConflictGraph**: build a conflict graph from `LivenessMap` and then do greedy graph coloring (more compact).

  High level idea:
  - Two SSA dimensions conflict if they are simultaneously live at any tracked program point.
  - Build a conflict graph and greedily color it so conflicting dimensions do not share a color.
  - Map colors to slots (each color corresponds to one shadow-stack slot).

  Notes / tradeoffs:
  - This is a heuristic (graph coloring is NP-hard), but typically much more compact than **Vanilla**.
  - Building the conflict graph is roughly quadratic in the number of SSA values (the current implementation uses an adjacency matrix), so earlier passes try hard to keep the SSA space small.

#### Example

Slot reuse shows up as a much smaller frame size and many stores targeting the same slot (offset 0):

```wasm
;; frame size reduced: 24 -> 4
i32.const 4
call $~lib/rt/__decrease_sp

... ;; multiple roots reusing the same slot
global.get $~lib/memory/__stack_pointer
local.get $...
i32.store $0 align=1

... ;; later root also uses offset 0
global.get $~lib/memory/__stack_pointer
local.get $...
i32.store $0 align=1

i32.const 4
call $~lib/rt/__increase_sp
```

## `ShrinkWrapAnalysis`

#### Rationale

Putting the prologue/epilogue at function entry/exit is the simplest choice, but many functions need the shadow stack only on some paths. Shrink wrapping moves the “open stack / close stack” to the region that really needs it, which reduces useless `__decrease_sp/__increase_sp` calls.

#### Method

For each function, decide the minimal region where the shadow stack must be active.

- Use the computed liveness to decide which basic blocks contain at least one point that needs rooting.
- Exclude caller-managed parameters from this decision.

Then pick insertion points using control-flow structure:

- A prologue must dominate all blocks that need an active shadow stack.
- An epilogue must post-dominate all such blocks (or be placed on the exit path).
- Avoid placing prologue/epilogue inside loops to prevent repeated stack-pointer updates.

The output is an `InsertPositionHint { prologueExpr, epilogueExpr }` for each function.

#### Example

Shrink wrapping can move the prologue into the region that actually needs roots. In this snapshot, `__decrease_sp` is inserted only on the path that allocates/roots, while an early return path avoids touching the shadow stack:

```wasm
(func $.../_start (param i32) (result i32)
  ...
  if
    ...
    return        ;; early return, no __decrease_sp
  end

  block ;;i32
        i32.const 8
      call $~lib/rt/__decrease_sp
    ... ;; allocation + stores
  end
  ...
)
```

## `PrologEpilogInserter`

#### Rationale

In the end we must guarantee: if a function has any shadow-stack store, it must execute `__decrease_sp(frameSize)` on all paths before the stores, and execute `__increase_sp(frameSize)` on all return paths. Otherwise the shadow stack will be wrong.

#### Method

Compute the required frame size from the assigned stack positions, then ensure stack-pointer adjustments are correct on all paths.

- If shrink-wrap hints are available and insertion is legal, insert “open shadow stack” near the first needed point and “close shadow stack” near the last needed point.
- Otherwise, fall back to a conservative scheme that opens at function entry and closes on all return paths.

#### Example

On early returns, the inserter ensures the epilogue runs before returning:

```wasm
... ;; rooted region
local.set $ret
i32.const 4
call $~lib/rt/__increase_sp
local.get $ret
return
```

## `ToStackReplacer`

#### Rationale

The earlier steps decide (in analysis/assignment) which `tostack` markers to keep and what offsets they use. Finally, we must turn IR markers (`__localtostack/__tmptostack`) into real `i32.store`, and delete markers that are not needed, so later wasm optimizations can work.

#### Method

Lower rooting markers into concrete memory stores and remove markers that were proven unnecessary.

- If a marker has no assigned stack slot, replace it with its underlying value expression.
- If a marker has an assigned slot, emit a store to the shadow stack at that offset while preserving the original value as the expression result.
- Ensure the rooted value is evaluated exactly once (introducing a temporary only when required by expression complexity).

#### Example

After replacement, a marker typically becomes a store to `__stack_pointer` plus the original value flow (excerpt):

```wasm
global.get $~lib/memory/__stack_pointer
local.get $obj
i32.store $0 offset=4 align=1
local.get $obj
```

## Post-lowering (cleanup + helper functions)

#### Rationale

After lowering, `__localtostack/__tmptostack` should not stay as imports/markers. We also need shared SP helpers, so the allocated shadow-stack region is cleared and has an overflow check.

#### Method

`OptLower` does module-level cleanup after `runner.run()`:

- `removeFunction("~lib/rt/__localtostack")`
- `removeFunction("~lib/rt/__tmptostack")`
- `addStackStackOperationFunction(m)` injects:
  - `~lib/rt/__decrease_sp(bytes)`
    - `__stack_pointer -= bytes`
    - `memory.fill(__stack_pointer, 0, bytes)`
    - `unreachable` when `__stack_pointer < __data_end`.
  - `~lib/rt/__increase_sp(bytes)`:
    - `__stack_pointer += bytes`.

#### Example

After module-level cleanup, marker functions are removed and shared SP helpers are present in the module. The helper function bodies look like (excerpt):

```wasm
(func $~lib/rt/__decrease_sp (param i32)
  ...
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.sub
  global.set $~lib/memory/__stack_pointer
  ...
  memory.fill
  ...
)

(func $~lib/rt/__increase_sp (param i32)
  ...
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.add
  global.set $~lib/memory/__stack_pointer
)
```
