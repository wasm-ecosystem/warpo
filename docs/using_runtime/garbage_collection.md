# Garbage Collection (GC)

warpo provide 2 kinds of runtime. They can be selected by command line options during compilation.

- incremental: selected by `--runtime incremental`. Default runtime
- radical: selected by `--runtime radical`.

## interfaces

<p style="display: flex; gap: 10px;">
  <img src="/version/2.3.0.svg" />
  <img src="/stability/stable.svg"  />
</p>

```ts
// allocate new object with size and rtid
declare function __new(size: usize, id: u32): usize;
// re-allocate a object
declare function __renew(ptr: usize, size: usize): usize;
// insert write barrier (only useful for incremental runtime)
declare function __link(parentPtr: usize, childPtr: usize, expectMultiple: bool): void;
// trigger full GC manually
declare function __collect(): void;
// pin an object to prevent being garbage collected
declare function __pin(ptr: usize): usize;
// cancel the pin operation
declare function __unpin(ptr: usize): void;
```

These interfaces are public interfaces exposed by runtime.

For host side (out of AssemblyScript):<br>
when `--exportRuntime` is enabled, these interfaces will be WebAssembly exported functions.

For AssemblyScript user code:<br/>
`import { __new, __collect, /* ... */ } from "rt/index";`
