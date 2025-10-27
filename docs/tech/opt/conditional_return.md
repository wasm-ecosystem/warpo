The pass aims at convert conditional return from `if` to `br_if` to reduce the control flow stack depths.

```wasm
(func (param i32)
    (if (local.get 0) (then (return)))
)
```

is equivalent to

```wasm
(func (param i32)
    (br_if 0 (local.get 0)) ;; jump to the end of the function
)
```

::: info
This optimization does not result in any performance improvement on the V8 backend.
:::
