# Unsafe Behavior

## changetype

<!-- https://www.assemblyscript.org/runtime.html#memory-layout -->

Treat `changetype<usize>(obj)` with the same caution as a C/C++ raw pointer. If the object's lifetime isn't strictly managed, it must remain rooted or reachable within the GC to prevent premature collection. Failure to do so results in a dangling pointer once the GC executes

The use of `changetype<Obj>(raw_ptr)` carries significant risk because it bypasses all runtime type validation. It is the developer's responsibility to guarantee that raw_ptr is a valid pointer derived from a `changetype<usize>` call and that the source object is type-compatible with `Obj`.
