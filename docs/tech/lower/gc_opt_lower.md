[[toc]]

Quick references:

- Shadow stack: [/en/using_runtime/shadow_stack](/en/using_runtime/shadow_stack)

# Opt Lowering

`gc::OptLower` (`passes/GC/OptLower.cpp`) is a more complex GC lowering pipeline. It builds an SSA model for GC objects, runs liveness analysis on the CFG, assigns shadow-stack slots based on alive ranges, and can also do shrink wrap. Shrink wrap tries to move the prologue/epilogue close to the region where the shadow stack is really needed.

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

Before (immutable global routed through marker):

```wasm
(func $.../_start
  call $~lib/rt/__tmptostack
    global.get $.../a ;; immutable
  global.get $.../a
  call $.../bar
)
```

After (marker removed):

```wasm
(func $.../_start
  global.get $.../a
  global.get $.../a
  call $.../bar
)
```

Mutable global: the store is preserved, and the function opens/closes the shadow stack.

Before (mutable global must be rooted across call):

```wasm
(func $.../_start
  call $~lib/rt/__tmptostack
    global.get $.../a ;; mutable
  call $.../bar
)
```

After (marker lowered to prologue/store/epilogue):

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

“May this call trigger GC?” is a key condition for many optimizations. If a call and everything it can reach will never trigger `__new/__collect`, then keeping shadow-stack roots around it is useless.

#### Method

Collect a module-level call graph (who may call whom) and pass it to later analyses that need to reason about reachability of GC trigger points.

#### Example

`CallGraphBuilder` is analysis-only, so it does not directly change WAT by itself. Its impact is visible in later filtering passes that treat calls differently based on whether they can reach GC triggers.

For a concrete “visible effect”, see the `LeafFunctionCollector` / `LeafFunctionFilter` examples below.

## `LeafFunctionCollector` (`GCLeafFunction`)

`GCLeafFunction` is an analysis pass (not a transform pass). It computes a per-function classification:

- **non-leaf**: this function may trigger GC through its transitive callees.
- **leaf**: this function cannot reach GC trigger points through any call chain.

The result is metadata used by later passes (mainly `LeafFunctionFilter`), so this pass does not directly rewrite WAT by itself.

#### Rationale

GC trigger points (`~lib/rt/*/__new`, `~lib/rt/*/__collect`) decide which functions can trigger GC (directly or indirectly). If we can find functions that will not trigger GC, later filtering can be stronger: keep roots only around calls that may trigger GC.

#### Method

Do a reverse reachability marking on the call graph:

- Start from known runtime GC trigger entrypoints (allocation / collection).
- Mark all functions that can reach those entrypoints (transitively) as **non-leaf**.
- The remaining functions are treated as **leaf** (cannot trigger GC through any call chain).
- Emit this classification for later filtering passes to decide which call sites must be treated as potential GC points.

## `ObjLivenessAnalyzer`

#### Rationale

The core idea is: “a root is needed only if the object is still alive at a possible GC point”. To do this, we need the object liveness range (before/after) of each GC-object SSA value on the CFG.

A simple way to understand **object liveness range**:

```wasm
  call $__new_obj ;; definition of object value
local.set $obj    ;; create a reference point to this object
call $foo         ;; possible GC point
  local.get $obj
call $bar         ;; last use
```

For this value, the object liveness range starts after `call __new_obj` and ends at `call $bar`. Because `call $foo` is inside that interval, `$obj` is alive at the call, so it may need a root there.

#### Method

Build an SSA-like model for “GC-object values that may need rooting”, then compute where each such value is alive on the CFG.

1. **Define the SSA index space**
   - Identify the IR constructs that represent “values that participate in rooting”, and assign each one a stable SSA index (a unique numeric ID in the liveness bitset/index space).

   - In the current implementation (`passes/GC/SSAObj.cpp` / `passes/GC/SSAObj.hpp`), there are exactly three SSA value kinds:
     - `Arg` (function parameter index):
       `i32` parameters are inserted as SSA values at function entry.
       Reason: parameters can be caller-managed object references into the callee; they must stay alive according to GC calling convention. Identify them may be helpful for further optimization.

     - `Local` (`local.set` whose value is `call ~lib/rt/__localtostack`):
       only this shape is inserted as a local SSA definition.
       Reason: this is the explicit IR marker saying “this local-backed object value participates in rooting”, so it should own a liveness index.

     - `Tmp` (`call ~lib/rt/__tmptostack`):
       the call expression itself is inserted as a temporary SSA definition.
       Reason: some rooted object values are expression-temporaries (not bound to a local); they still need a trackable SSA index for liveness.

2. **Compute liveness on the CFG**

- Use dataflow analysis to determine which SSA indices are alive before/after key program points.
- Here, **key program points** means expression sites explicitly tracked in `LivenessMap` by `ObjLivenessAnalyzer` (`passes/GC/ObjLivenessAnalyzer.cpp`):
  - `local.set` and `local.get` (where object references are defined/read through locals)
  - `call` and `call_indirect` (potential GC-relevant boundaries)
  - extra parent use sites of `__tmptostack(...)` values (including function-return use), so temporary rooted values also have observable liveness boundaries
- `LivenessMap` is the per-function table that stores liveness snapshots for those expression sites (`passes/GC/Liveness.hpp`).
  - Logical key: `(expr, pos, ssaIndex)` where `pos` is `Before` or `After`.
  - Logical value: `isLive` (`bool`).
- Record this compact `before`/`after` representation (`LivenessMap`) for later filtering and slot assignment.

#### Example

The following is a real, runnable example captured from Warpo debug output.

Dummy module (`/tmp/gc_liveness_demo.ts`):

```ts
class Box {
  value: i32;
  constructor(v: i32) {
    this.value = v;
  }
}

function consume(x: Box): i32 {
  return x.value;
}

export function demo(flag: i32): i32 {
  let a = new Box(10);
  let b = new Box(20);
  let x = consume(a);
  if (flag > 0) {
    return x + consume(b);
  }
  return x + a.value;
}
```

Run Warpo with liveness debug enabled for one function:

```bash
WARPO_DEBUG_PASSES='ObjLivenessAnalyzer' \
WARPO_DEBUG_FUNCTIONS='gc_liveness_demo/demo' \
node dist/warpo.js gc_liveness_demo.ts \
  -o /tmp/gc_liveness_demo_filtered.wat \
  --optimizeLevel 1 --shrinkLevel 1 \
  > gc_liveness_debug_demo_only.log 2>&1
```

Note: function paths below use simplified names for readability.

Real `ObjLivenessAnalyzer` output excerpt:

```wasm
================== gc_liveness_demo/demo liveness analysis ===============
;; preds: [], succs: [BB1, BB2]
BB0: ;;entry
  0: i32.const 4
  1: i32.const 4
  2: call $~lib/rt/itcms/__new ;; [liveness: 10000000]
  3: call $~lib/rt/__tmptostack ;; [liveness: 10000000 -> 11000000]
  4: i32.const 10
  5: call $gc_liveness_demo/Box#constructor ;; [liveness: 11000000 -> 10000000]
  6: call $~lib/rt/__localtostack ;; [liveness: 10000000]
  7: local.set $1 ;; [liveness: 10000000 -> 10100000]
  8: i32.const 4
  9: i32.const 4
  10: call $~lib/rt/itcms/__new ;; [liveness: 10100000]
  11: call $~lib/rt/__tmptostack ;; [liveness: 10100000 -> 10110000]
  12: i32.const 20
  13: call $gc_liveness_demo/Box#constructor ;; [liveness: 10110000 -> 10100000]
  14: call $~lib/rt/__localtostack ;; [liveness: 10100000]
  15: local.set $2 ;; [liveness: 10100000 -> 10101000]
  16: local.get $1 ;; [liveness: 10101000]
  17: call $~lib/rt/__tmptostack ;; [liveness: 10101000 -> 10101100]
  18: call $gc_liveness_demo/consume ;; [liveness: 10101100 -> 10101000]
  19: local.set $3 ;; [liveness: 10101000]
  20: local.get $0 ;; [liveness: 10101000 -> 00101000]
  21: i32.const 0
  22: i32.gt_s

;; preds: [BB0], succs: [BB3]
BB1: ;;
  23: local.get $3 ;; [liveness: 00001000]
  24: local.get $2 ;; [liveness: 00001000 -> 00000000]
  25: call $~lib/rt/__tmptostack ;; [liveness: 00000000 -> 00000010]
  26: call $gc_liveness_demo/consume ;; [liveness: 00000010 -> 00000000]
  27: i32.add
  28: return

;; preds: [BB0], succs: [BB3]
BB2: ;;
  29: local.get $3 ;; [liveness: 00100000]
  30: local.get $1 ;; [liveness: 00100000 -> 00000000]
  31: call $~lib/rt/__tmptostack ;; [liveness: 00000000 -> 00000001]
  32: call $gc_liveness_demo/Box#get:value ;; [liveness: 00000001 -> 00000000]
  33: i32.add
  34: return
```

Bit meaning in this run (`8` bits total, left to right = SSA index `0..7`):

- `ssa0`: parameter `flag` (`Arg`)
- `ssa1`: first `__tmptostack` (tmp around first `__new`)
- `ssa2`: `local.set $1` (`a`) via `__localtostack`
- `ssa3`: second `__tmptostack` (tmp around second `__new`)
- `ssa4`: `local.set $2` (`b`) via `__localtostack`
- `ssa5`: `__tmptostack(local.get $1)` before `consume(a)`
- `ssa6`: `__tmptostack(local.get $2)` before `consume(b)`
- `ssa7`: `__tmptostack(local.get $1)` before `Box#get:value`

Line-by-line interpretation:

- `0,1,4,8,9,12,21,22,27,28,33,34`: no tracked liveness mutation at these instructions.
- `2 (__new)`: `10000000`. Only `ssa0` (parameter) is currently live.
- `3 (__tmptostack)`: `10000000 -> 11000000`. Defines tmp `ssa1`.
- `5 (Box#constructor)`: `11000000 -> 10000000`. Consumes/kills `ssa1`.
- `6 (__localtostack)`: `10000000`. Marker call itself keeps the same live set.
- `7 (local.set $1)`: `10000000 -> 10100000`. Defines local-root SSA `ssa2` (`a`).
- `10 (__new)`: `10100000`. Allocation does not by itself add a new tracked SSA.
- `11 (__tmptostack)`: `10100000 -> 10110000`. Defines tmp `ssa3`.
- `13 (Box#constructor)`: `10110000 -> 10100000`. Consumes/kills `ssa3`.
- `14 (__localtostack)`: `10100000`. Marker call keeps set unchanged.
- `15 (local.set $2)`: `10100000 -> 10101000`. Defines local-root SSA `ssa4` (`b`).
- `16 (local.get $1)`: `10101000`. Read site; liveness unchanged at this point.
- `17 (__tmptostack local.get $1)`: `10101000 -> 10101100`. Defines tmp `ssa5` for `consume(a)`.
- `18 (consume)`: `10101100 -> 10101000`. Call consumes tmp `ssa5`.
- `19 (local.set $3)`: `10101000`. Non-root local assignment, no root-set change.
- `20 (local.get $0)`: `10101000 -> 00101000`. Parameter `ssa0` is consumed on this use.
- `23 (then: local.get $3)`: `00001000`. At BB1 entry only `ssa4` (`b`) is live.
- `24 (then: local.get $2)`: `00001000 -> 00000000`. Reads `b`, killing local SSA `ssa4`.
- `25 (then: __tmptostack local.get $2)`: `00000000 -> 00000010`. Defines tmp `ssa6`.
- `26 (then: consume)`: `00000010 -> 00000000`. Consumes tmp `ssa6`.
- `29 (else: local.get $3)`: `00100000`. At BB2 entry only `ssa2` (`a`) is live.
- `30 (else: local.get $1)`: `00100000 -> 00000000`. Reads `a`, killing local SSA `ssa2`.
- `31 (else: __tmptostack local.get $1)`: `00000000 -> 00000001`. Defines tmp `ssa7`.
- `32 (else: Box#get:value)`: `00000001 -> 00000000`. Consumes tmp `ssa7`.

This function in generated WAT (same run, after lowering) is:

```wasm
(func $gc_liveness_demo/demo (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  i32.store align=1
  ...
  call $~lib/rt/itcms/__new
  local.tee $1
  i32.const 10
  i32.store
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  ...
)
```

The important connection is: liveness decides where a value must be rooted; later passes (`StackAssigner` + `ToStackReplacer`) turn those live ranges into concrete `i32.store` writes to the shadow stack.

## `MergeSSA`

#### Rationale

Many tmp SSA values are just a “move/reference” of an existing local value (for example, `__tmptostack(local.get ...)`). If we merge such tmp SSA into the local SSA, we reduce the SSA size and can further reduce the needed slot count.

#### Method

Coalesce “pure forwarding” temporary SSA dimensions into the underlying source dimension.

- Use `LivenessMap` to resolve which source SSA dimension is alive at the forwarding site.
- Merge the temporary alive range into the source alive range.
- Mark the temporary dimension as invalid so it does not consume a stack slot later.

Note: in `OptLower`, this step must happen before `LeafFunctionFilter`, because that pass may mark some SSA values as invalid, which would break `MergeSSA`.

#### Example

When a temporary SSA is just forwarding an existing alive value, merging SSA can reduce frame size and remove redundant stores.

Before (temporary forwarding SSA keeps extra slot pressure):

```wasm
;; frame size: 12
i32.const 12
call $~lib/rt/__decrease_sp

global.get $~lib/memory/__stack_pointer
local.get $x
i32.store $0 offset=4 align=1

global.get $~lib/memory/__stack_pointer
local.get $x ;; forwarded temp uses another slot
i32.store $0 offset=8 align=1
```

After (forwarding SSA merged; redundant store dropped):

```wasm
;; frame size: 8
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

If an SSA object is alive only around leaf calls, then even if it is alive, it will not meet a real GC trigger point. Such a root can be removed, which reduces shadow-stack pressure.

#### Method

Filter the liveness model to keep only roots that matter at potential GC trigger points.

- Treat **non-leaf direct calls** and **all indirect calls** as potential GC trigger points.
- Collect the set of SSA dimensions that are alive at those points.
- Invalidate all other SSA dimensions so they do not affect slot assignment or shrink-wrapping decisions.

Note: caller-managed parameters are handled specially by later stages (they should not force opening the shadow stack in the callee).

#### Example

If an object is alive only around leaf calls (no reachable GC trigger), leaf filtering can remove the shadow-stack management entirely:

Before (conservative rooting around call):

```wasm
(func $.../_start (result i32)
  ...
  i32.const 4
  call $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  local.get $obj
  i32.store $0 align=1
  call $.../constructor ;; leaf-only path
  i32.const 4
  call $~lib/rt/__increase_sp
  return
)
```

After (shadow-stack ops removed):

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

After we know “which SSA values become alive at which points”, we need to map these “become-alive `tostack` sites” to concrete shadow-stack offsets (slot/offset). A better assignment lets non-conflicting objects (no overlap in lifetime) reuse the same slot, which reduces the frame size.

#### Method

Assign concrete shadow-stack slots (offsets) to the remaining SSA dimensions based on their alive ranges.

- Detect the program points where an SSA dimension first becomes alive.
- Associate those “become-live” sites with the corresponding rooting marker.
- Choose an offset for each marker and record it as the stack position.

There are two strategies:

- **Vanilla**: when an SSA value is first seen, assign a new slot (simple but can be large).
- **GreedyConflictGraph**: build a conflict graph from `LivenessMap` and then do greedy graph coloring (more compact).

  High level idea:
  - Two SSA dimensions conflict if they are simultaneously alive at any tracked program point.
  - Build a conflict graph and greedily color it so conflicting dimensions do not share a color.
  - Map colors to slots (each color corresponds to one shadow-stack slot).

  Notes / tradeoffs:
  - This is a heuristic (graph coloring is NP-hard), but typically much more compact than **Vanilla**.
  - Building the conflict graph is roughly quadratic in the number of SSA values (the current implementation uses an adjacency matrix), so earlier passes try hard to keep the SSA space small.

#### Example

Slot reuse shows up as a much smaller frame size and many stores targeting the same slot (offset 0):

Before (distinct slots, larger frame):

```wasm
;; frame size: 24
i32.const 24
call $~lib/rt/__decrease_sp

global.get $~lib/memory/__stack_pointer
local.get $a
i32.store $0 offset=0 align=1

global.get $~lib/memory/__stack_pointer
local.get $b
i32.store $0 offset=8 align=1

global.get $~lib/memory/__stack_pointer
local.get $c
i32.store $0 offset=16 align=1
```

After (slot reuse, compact frame):

```wasm
;; frame size: 4
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

Before (prologue at entry, even early-return path pays cost):

```wasm
(func $.../_start (param i32) (result i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  ...
  if
    ...
    i32.const 8
    call $~lib/rt/__increase_sp
    return
  end
  ...
)
```

After (prologue only on path that needs roots):

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

Before (missing epilogue on return path):

```wasm
... ;; rooted region
local.set $ret
local.get $ret
return
```

After (epilogue guaranteed before return):

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

Before (marker form):

```wasm
call $~lib/rt/__tmptostack
  local.get $obj
```

After (concrete store + value flow):

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
