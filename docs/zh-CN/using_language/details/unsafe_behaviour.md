# Unsafe Behavior

## changetype

<!-- https://www.assemblyscript.org/runtime.html#memory-layout -->

请把 `changetype<usize>(obj)` 当作 C/C++ 的原始指针一样谨慎对待。如果对象生命周期没有被严格管理，那么为了避免被 GC 提前回收，它必须始终保持 rooted 或在 GC 可达集合中。否则，一旦 GC 执行，你就会得到悬空指针（dangling pointer）。

使用 `changetype<Obj>(raw_ptr)` 同样具有显著风险：它绕过了所有运行时类型校验。开发者有责任确保 raw_ptr 是一个由 `changetype<usize>` 导出的有效指针，并且源对象在类型上与 `Obj` 兼容。
