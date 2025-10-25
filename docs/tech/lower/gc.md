[[toc]]

## GC Conventions

caller site should ensure the lifetime of GC typed arguments during `call` and `call_indirect`.

## Fast Lower

Fast lowering passes focus on speed.

- For each locals it will be statically assigned to shadow stack slot according to local index.
- For temporary value in operand stack, which can only happened for `call` or `call_indirect`, it will be assigned according to stack-based counter.

::: warning

It is possible to have nested call. We should make sure the slot of first argument is different with the second and the third.

```wasm
(call $foo
  (call $tostack (local.get $arg0))
  (call $bar
    (call $tostack (local.get $arg1))
    (call $tostack (local.get $arg2))
  )
)
```

:::

## Opt Lower

Optimized lowering passes will analysis the object liveness and dom tree, which cost more time then fast lower but produce better output.

### Analyze Object Liveness

It will convert each object to SSA. analyze liveness of each SSA object.

The liveness information is important for later passes.

### Filter Leaf Function

GC will be triggered only when `__new` and `__collect` is called. If there is no such call in the life cycle of an ssa object, then we do not need to store it on the stack.

### Assign Shadow Stack Position

TODO

### Shrink Wrap

Shrink wrapping is an optimization technique that moves stack frame setup and teardown operations closer to where they are actually needed, rather than placing them at function entry and exit points.

#### Benefits

- Reduces overhead for early function returns that don't use stack
- Improves performance for functions with multiple exit paths

#### Algorithm

WARPO will calculate prologue and epilogue following those rules

- prologue dominate all shadow stack usages.
- epilogue post-dominate all shadow stack usages.
- prologue and epilogue are not inside loop. (avoid cpu cost in high frequency loop)
- prologue dominate epilogue (before execute to epilogue, prologue must be executed).
- epilogue post-dominate prologue (after executed prologue, epilogue must be executed).
- prologue are not entry basic block. (make no sense)
- epilogue are not exit basic block. (make no sense)

### ToStackReplacer

accept each call mapped stack offset as inputs.

replace

```wasm
(call $__tmptostack (...))
```

with

```wasm
(i32.store offset=... (global.get $sp) (local.tee $tmp (...)))
(local.get $tmp)
```

### PrologEpilogInserter

insert prologue and epilogue

wrapper original function body

```wasm
(global.set $sp (i32.sub (global.get $sp) (i32.const <MAX_OFFSET>)))

(local.set $tmp (<RESULT>))
(global.set $sp (i32.add (global.get $sp) (i32.const <MAX_OFFSET>)))
(return (local.get $tmp))
```

### PostLower

implement

1. `~lib/rt/__decrease_sp`.
2. `~lib/rt/__increase_sp`.

---

# Make Decision

## Why we create function for each offset?

In [PR#60](https://github.com/wasm-ecosystem/warpo/commit/96d32efaf4a30c20bad822895a0d4c6a0199c676), we change the implement of tostack.

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

It cannot be optimized well even subsequent passes will inline `$~lib/rt/__tostack` and do constant propagation for `$offset`.

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

## Why we inline tostack?

Even though `~lib/rt/__tostack<OFFSET>` is better then `~lib/rt/__tostack`. However, in the subsequent optimization process, if tostack cannot be inlined, it will interfere with the subsequent constant propagation optimization.

for example, binaryen opt passes cannot propagate constant for below bytecode. Because most of opt passes is intra-procedural. It does not know the result of tostack is always same as the first parameter.

```wasm
(local.set $0 (call $tostack<0> (i32.const 10)))
(local.set $1 (i32.add (local.get $0) (i32.const 10))) ;; cannot be optimized to (local.set (i32.const 20))
```
