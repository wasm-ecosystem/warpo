# Radical GC runtime

<p style="display: flex; gap: 10px;">
	<img src="/version/2.3.0.svg" alt="2.3.0" />
	<img src="/stability/experimental.svg" alt="experimental" />
</p>

Radical Runtime 是一个轻量级的垃圾回收（GC）运行时，具备如下特性：

- Stop-The-World（STW）机制：GC 期间暂停执行以确保一致性。
- Two-Color Mark & Sweep（TCMS）算法：将对象分为 active（可达）与 inactive（不可达），以便高效回收内存。
- Shadow Stack 集成：通过“[shadow stack](/zh-CN/using_runtime/shadow_stack)”在栈上动态跟踪 GC roots，避免复杂的 stack maps。

该设计确保了 GC 过程的确定性与简洁性。

它适用于对暂停时间不敏感的场景，例如嵌入式系统或轻量服务：更关注较低的运行时开销，而非低延迟的 GC 暂停。

## 性能

Radical runtime 的吞吐量高于 incremental runtime。它采用 TCMS 算法与 STW 机制，因此在更新类字段时不需要插入写屏障（write barrier）。

## 可调参数

`ASC_GC_GRANULARITY`<br/>
当累计已分配对象的总大小达到 `ASC_GC_GRANULARITY` 字节时，将触发一次完整 GC。<br/>
增大该参数会消耗更多内存（RAM），但能节省 CPU 时间。<br/>
默认值为 16 KiB（WebAssembly 页大小的四分之一）。
