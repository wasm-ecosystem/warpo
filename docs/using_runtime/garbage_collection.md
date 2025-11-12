WARPO uses [shadow stack GC algorithm](https://llvm.org/docs/GarbageCollection.html#the-shadow-stack-gc).

In frontend, WARPO will introduce 2 functions to identify shadow stack mapping.

```wasm
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
```

In optimization lowering passes, WARPO will convert these 2 functions to the store operation in shadow stack.

The shadow stack area is static allocated in linear memory which is from `__stack_pointer` to `__heap_base`.
In the prologue of each GC related function, `__stack_pointer` will decrease to allocate some space of shadow stack.
In the epilogue, `__stack_pointer` will increase back. Then the items stored in new allocated area won't be tracked any more, in another word, these objects will be freed in next time GC.

```wasm
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const ...))
 (global $~lib/memory/__heap_base i32 (i32.const ...))
```
