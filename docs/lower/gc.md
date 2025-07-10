[[toc]]

## Analyze Object Liveness

TODO

## Filter Leaf Function

TODO

## Assign Shadow Stack Position

TODO

## Lowering

It is where WARPO actually do the optimization.

There are 2 passes to finish final lowering. One is the function level pass to replace tostack call with real function and insert prologue and epilogue. The other is module level pass to insert needed functions.

The subsequent passes will determine whether to inline these functions.

One for replacing `__tmptostack` and `__localtostack` with function call `~lib/rt/__tostack<{offset}>`.

### ToStackCallLowering

accept each call mapped stack offset as inputs.

#### replace tostack call

replace

```wasm
call __tmptostack
```

with

```wasm
call __tostack<{offset}>
```

#### insert prologue and epilogue

wrapper original function body

```wasm
(global.set $sp (i32.sub (global.get $sp) (i32.const <MAX_OFFSET>)))

(local.set $tmp (<RESULT>))
(global.set $sp (i32.add (global.get $sp) (i32.const <MAX_OFFSET>)))
(return (local.get $tmp))
```

### PostLowering

implement

1. `~lib/rt/__decrease_sp`.
2. `~lib/rt/__increase_sp`.
3. `~lib/rt/__tostack<{offset}>`.

## Interesting Decision

### Why we create function for each offset?

In [PR#60](https://atc-github.azure.cloud.bmw/CDCFW/warpo/pull/60), we change the implement of tostack.

The previous emitted code is

```wasm
  call $xxx#constructor
  i32.const <OFFSET>
call $~lib/rt/__tostack
```

with function

```wasm
(func $~lib/rt/__tostack (param $value i32) (param $offset i32) (result i32)
      global.get $~lib/memory/__stack_pointer
      local.get $offset
    i32.add
    local.get $value
  i32.store $0 align=1
  local.get $value
)
```

It cannot be optimized well even subsequent passes will inline `$~lib/rt/__tostack` adn do constant propagation for `$offset`.

After PR, the code will change to

```wasm
  call $xxx#constructor
call $~lib/rt/__tostack<OFFSET>
```

with function

```wasm
(func $~lib/rt/__tostack<OFFSET> (param $value i32) (result i32)
    global.get $~lib/memory/__stack_pointer
    local.get $value
  i32.store $0 align=1 offset=<OFFSET>
  local.get $value
)
```

Then it is better than previous one since we can merge the add and store instruction.

In wasm's world, `offset=` is not equal to `i32.add`. since when operate ptr with `i32.add`, we need to consider integer overflow but with `offset=` not.
