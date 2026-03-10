[[toc]]

# ObjLivenessAnalyzer Example

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

- `ssa0`: parameter `flag` (`Arg SSA`)
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
