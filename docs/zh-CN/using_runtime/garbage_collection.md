# 垃圾回收（GC）

warpo 提供两种运行时（runtime），可在编译时通过命令行选项选择。

- incremental：使用 `--runtime incremental` 选择。默认运行时。
- radical：使用 `--runtime radical` 选择。

## 接口

<p style="display: flex; gap: 10px;">
	<img src="/version/2.3.0.svg" alt="2.3.0" />
	<img src="/stability/stable.svg" alt="stable" />
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

这些接口是运行时对外暴露的公共接口。

对于 host 侧（AssemblyScript 之外）：<br>
当启用 `--exportRuntime` 时，这些接口会作为 WebAssembly 导出函数。

对于 AssemblyScript 用户代码：<br/>
`import { __new, __collect, /* ... */ } from "rt/index";`
