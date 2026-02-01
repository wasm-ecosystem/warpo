# Shadow Stack

<p style="display: flex; gap: 10px;">
	<img src="/version/2.2.3.svg" alt="2.2.3" />
	<img src="/stability/stable.svg" alt="stable" />
</p>

WARPO 使用 [shadow stack GC algorithm](https://llvm.org/docs/GarbageCollection.html#the-shadow-stack-gc)。

在前端（frontend）中，WARPO 会引入两个函数来标识 shadow stack 映射关系。

```wasm
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
```

在优化 lowering passes 中，WARPO 会将这两个函数转换为对 shadow stack 的 store 操作。

shadow stack 区域在 linear memory 中静态分配，范围为 `__stack_pointer` 到 `__heap_base`。
在每个与 GC 相关的函数序言（prologue）里，`__stack_pointer` 会递减以分配一段 shadow stack 空间。
在尾声（epilogue）里，`__stack_pointer` 会递增回去。此后，刚分配区域中存放的条目将不再被追踪；换句话说，这些对象会在下一次 GC 时被释放。

```wasm
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const ...))
 (global $~lib/memory/__heap_base i32 (i32.const ...))
```
