## Why

AssemblyScript will emit code directly via binaryen. Lots of high level information is lost.
It limits the potential optimization changes.

::: info
The original concept in AS is depends on new features introduced in WASM spec. But unfortunately there are no enough capacity to support them. And new features did not develop as the original AS creator wished.
:::
