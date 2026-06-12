# Heap Analyzer

WARPO heap-analyzer 是一个面向 AssemblyScript 增量运行时程序的堆快照分析工具。
它适用于这样一个阶段：你已经知道内存正在增长，或者有对象存活时间过长，但原始线性内存 dump 仍然过于底层，无法直接解释问题出在哪里。

## 1. 为什么需要 heap-analyzer？

在运行时，WebAssembly 堆本质上只是一段字节区域。
原始内存 dump 只能告诉你“内存存在”，却不能告诉你哪些对象仍然存活、哪些构造函数主导了当前 live heap，或者两个时刻之间究竟发生了什么变化。

内存调试里经常会遇到两个问题：

1. 现在到底是什么在占用空间？
2. 某个操作、场景切换、请求或者一帧执行之后，究竟发生了什么变化？

WARPO heap-analyzer 通过两种视图回答这两个问题，它们的设计思路参考了 Chrome DevTools 的 heap snapshot 工作流。

### Constructor View

Constructor view 解决的是“现在是什么在占用空间”的问题。

如果直接按对象逐个列出，通常噪音会非常大：

- 地址在不同运行之间并不稳定
- 同一个类的成百上千个对象会混在一起
- 以 root 为中心的数据虽然能解释可达性，但并不能直接说明内存集中在哪里

Constructor view 会先按 `className` 聚合 live object，然后再允许你向下展开到具体实例。
这能更快地发现下面这些模式：

- 某个构造函数意外地占据了很高的 retained size
- 某个容器类 shallow size 很小，但 retained size 很大
- 某一个体积特别大的实例保活了一整棵对象子图

### Comparison View

Comparison view 解决的是“两个快照之间发生了什么变化”的问题。

如果没有结构化 diff，你通常只能手动比较地址，或者把两个很大的 JSON 文件并排看。
这样既慢又容易误判，因为真正有价值的问题不是“哪些地址不同”，而是：

- 哪些构造函数新增了对象
- 哪些构造函数释放了对象
- 新分配了多少字节
- 释放了多少字节

WARPO comparison view 延续了 DevTools 的思路：

- 构造函数行展示 `New`、`Delete`、`Delta`、`Alloc.size`、`Freed size` 和 `Size Delta`
- 展开后的实例行只展示发生变化的实例
- 实例行保留每个对象自己的 `retainedSize` 以便继续钻取，而构造函数级别的 diff 行则有意使用基于 shallow size 的字段

这种区分是有必要的。
Retained size 很适合解释单个快照里的所有权关系，但它在不同对象之间会发生重叠，并不适合作为顶层 diff 列。
对于变化分析来说，基于 shallow size 的增减量更容易解释。

## 2. 如何使用 heap-analyzer？

### 前置条件

heap-analyzer 需要两类输入：

1. 从运行中的 WebAssembly 模块中抓取到的 dump 文件。
2. 与该 dump 对应、并带有 DWARF 调试信息的 wasm 二进制文件。

之所以需要调试信息，是因为 heap-analyzer 需要依赖 DWARF 来重建类布局、字段元数据以及 global root 元数据。
如果没有 `--debug`，分析器就无法可靠地把运行时对象映射回源码级构造函数，也无法准确识别引用字段。

编译 wasm 时需要打开调试信息：

```bash
./build/warpo/warpo_asc ./build_work/dwarfFixture.ts -o ./build_work/dwarfFixture.wasm --debug
```

如果你使用的是项目级配置而不是直接传命令行参数，本质要求是一样的：最终产物必须包含 DWARF 调试信息。

### 在运行时导出 Heap Snapshot

heap-analyzer 本身不会主动暂停正在运行的 wasm VM。
相反，你需要在程序里引入一个 host function，并在你关心的时间点把 dump 写出来。

在 wasm 侧，需要声明一个 host import，并用 UTF-8 编码后的输出路径去调用它：

```ts

@external("MemoryDump", "dumpMemoryRegion")
declare function dumpMemoryRegion(filePathOffset: i32, filePathSize: i32): void;

const dumpPath = "./build_work/example-before.dump";
const encodedPath = String.UTF8.encode(dumpPath);
dumpMemoryRegion(changetype<i32>(encodedPath), String.UTF8.byteLength(dumpPath));
```

这个 import 本身只是一个 hook。
宿主运行时需要实现 `MemoryDump.dumpMemoryRegion`，并把当前堆状态序列化到磁盘。
如果 host 是 wasm-compiler，那么它已经通过 `MemoryDump` 扩展支持了这个 import： [MemoryDumpAPI.cpp](https://github.com/wasm-ecosystem/wasm-compiler/blob/develop/extensions/MemoryDumpAPI.cpp)。

在真实的 Node host 里，`dumpMemoryRegion` 还需要先从 wasm 线性内存里解码出 UTF-8 路径，再把这个路径交给 dump writer：

```js
const imports = {
  MemoryDump: {
    dumpMemoryRegion(offset, size) {
      const guestPath = Buffer.from(exports.memory.buffer, offset, size).toString("utf8");
      writeDump(exports, resolve(projectRoot, guestPath));
    },
  },
};
```

一个最小可用的 JavaScript host-side dump writer 如下：

```js
import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";

const DUMP_MAGIC = new Uint8Array([0x41, 0x53, 0x48, 0x44]); // "A S H D"
const HEADER_SIZE = 24;
const DUMP_VERSION = 2;

function writeDump(exports, outputPath) {
  const raw = new Uint8Array(exports.memory.buffer);
  const dump = new Uint8Array(HEADER_SIZE + raw.byteLength);
  const view = new DataView(dump.buffer);

  dump.set(DUMP_MAGIC, 0);
  view.setUint32(4, DUMP_VERSION, true);
  view.setUint32(8, Number(exports.__data_end.value), true);
  view.setUint32(12, Number(exports.__heap_base.value), true);
  view.setUint32(16, Number(exports.__stack_pointer.value), true);
  view.setUint32(20, 0, true);
  dump.set(raw, HEADER_SIZE);

  mkdirSync(dirname(outputPath), { recursive: true });
  writeFileSync(resolve(outputPath), dump);
}
```

当前 dump 文件格式为：

- magic: 'A' 'S' 'H' 'D'
- version
- `__data_end`
- `__heap_base`
- `__stack_pointer`
- `numMutableI32GlobalValues`
- `mutableI32GlobalValues[]`
- 原始线性内存 payload

上面的最小 Node 示例会故意把 `numMutableI32GlobalValues` 写成 `0`。
这对简单 fixture 已经够用，但它并不是完整的 dump format。

这个字段是用来恢复 GC global root 的。
heap-analyzer 会把序列化出来的 mutable i32 global value 映射回 wasm global index，再据此恢复那些由全局变量保活的 managed object。

目前 Node 侧的示例还没有一种通用办法，可以从任意实例中枚举并序列化所有运行时 mutable i32 globals。
因此示例只覆盖了格式里比较稳定的一部分：运行时边界相关的 globals，加上线性内存镜像本身。

如果你的程序把 managed object 保存在 mutable wasm globals 里，省略 `mutableI32GlobalValues[]` 可能会让某些 live object 看起来像是不可达的。
如果你需要完整、准确地恢复 GC global root，host 侧的 dump writer 就必须在 raw memory payload 之前把这些 mutable i32 globals 一起序列化出来。

要使用 comparison view，需要在两个不同时间点各抓一份 dump，例如：

- 进入场景前和离开场景后
- 发起请求前和完整处理响应后
- 疑似泄漏的压力循环执行前和执行后

### 运行 Constructor View

如果项目里已经安装了 `warpo`，建议直接从包内容里调用 heap-analyzer：

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js
```

在仓库内部开发时，对应入口仍然是 `node ./tools/heap_analyzer/bin/cli.js`。

基本用法：

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js analyze ./build_work/example-before.dump --wasm ./build_work/dwarfFixture.wasm
```

常用选项：

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js analyze ./build_work/example-before.dump --wasm ./build_work/dwarfFixture.wasm --sort retained
node ./node_modules/warpo/dist/heap_analyzer/cli.js analyze ./build_work/example-before.dump --wasm ./build_work/dwarfFixture.wasm --sort shallow
node ./node_modules/warpo/dist/heap_analyzer/cli.js analyze ./build_work/example-before.dump --wasm ./build_work/dwarfFixture.wasm --sort count --top 20
```

输出 JSON 的顶层结构如下：

```json
{
  "totalHeapSize": 27476,
  "totalLiveSize": 5904,
  "constructors": [
    {
      "className": "build_work/dwarfFixture/TreeNode",
      "count": 31,
      "totalShallowSize": 992,
      "totalRetainedSize": 4128,
      "instances": [
        {
          "address": 41088,
          "shallowSize": 32,
          "retainedSize": 992
        }
      ]
    }
  ]
}
```

字段含义：

- `totalHeapSize`：当前线性内存里 TLSF 管理的整个 heap 区间大小。
  这是 allocator 视角下的空间，不只是 live object 的总和。
- `totalLiveSize`：所有可达对象的 shallow size 之和。
- `className`：从 DWARF 解析出来的源码级构造函数名。
- `count`：该构造函数当前 live 实例的数量。
- `totalShallowSize`：该构造函数所有实例的 shallow size 总和。
- `totalRetainedSize`：该构造函数所有实例的 retained size 总和。
- `instances`：用于继续向下钻取的实例级数据。

对于每个实例：

- `address`：该对象在 wasm 线性内存中的 payload pointer。
- `shallowSize`：对象自身的 allocator 成本。
  在 WARPO 里，这个值基于对象 block size 计算，因此会包含 allocator/header 开销，而不只是源码里能直接看到的字段字节数。
- `retainedSize`：当一个对象被删除之后，并且它所依赖保活的对象也随之变得不可达，此时能够被释放的内存大小，就叫 retained size。

需要注意的一点是：构造函数级别的 `totalRetainedSize` 很适合拿来排序，但它并不是 `totalLiveSize` 的一个严格划分。
不同对象的 retained region 会发生重叠，因此把所有构造函数的 retained size 加总后，完全可能超过 live heap 总量。

### 运行 Comparison View

Comparison view 需要一份 baseline dump 和一份 current dump：

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js diff ./build_work/example-before.dump ./build_work/example-after.dump --wasm ./build_work/dwarfFixture.wasm
```

常用选项：

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js diff ./build_work/example-before.dump ./build_work/example-after.dump --wasm ./build_work/dwarfFixture.wasm --sort delta
node ./node_modules/warpo/dist/heap_analyzer/cli.js diff ./build_work/example-before.dump ./build_work/example-after.dump --wasm ./build_work/dwarfFixture.wasm --sort alloc
node ./node_modules/warpo/dist/heap_analyzer/cli.js diff ./build_work/example-before.dump ./build_work/example-after.dump --wasm ./build_work/dwarfFixture.wasm --sort freed --top 20
```

顶层输出结构如下：

```json
{
  "beforeTotalHeapSize": 27476,
  "afterTotalHeapSize": 28000,
  "totalHeapSizeDelta": 524,
  "beforeTotalLiveSize": 5904,
  "afterTotalLiveSize": 6400,
  "totalLiveSizeDelta": 496,
  "constructors": [
    {
      "className": "build_work/dwarfFixture/TreeNode",
      "newCount": 2,
      "deletedCount": 0,
      "countDelta": 2,
      "allocatedSize": 64,
      "freedSize": 0,
      "sizeDelta": 64,
      "instances": [
        {
          "address": 50000,
          "shallowSize": 32,
          "retainedSize": 96,
          "changeKind": "new"
        }
      ]
    }
  ]
}
```

这些字段对应 DevTools 风格的 comparison model：

- `newCount`：只存在于 current dump 中的实例数量。
- `deletedCount`：只存在于 baseline dump 中的实例数量。
- `countDelta`：`newCount - deletedCount`。
- `allocatedSize`：所有 `new` 实例的 shallow size 总和。
- `freedSize`：所有 `delete` 实例的 shallow size 总和。
- `sizeDelta`：`allocatedSize - freedSize`。

展开后的实例行保留：

- `address`
- `shallowSize`
- `retainedSize`
- `changeKind: "new" | "delete"`

Comparison view 会按 `className + address` 匹配实例。
如果同一个 class/address 对在两个 dump 里都存在，它就会被视为 unchanged，并且不会出现在展开后的变更列表里。

## 3. 我们是怎么实现的？

从高层看，heap-analyzer 可以分成三层：

1. dump capture
2. 单快照分析
3. 快照之间的 comparison

### Dump Capture

运行时 dump 文件本质上是一个围绕原始内存快照的轻量容器。
当前格式里保存了：

- dump magic 和 version
- `__data_end`
- `__heap_base`
- `__stack_pointer`
- 序列化出来的 mutable i32 global 数量
- 序列化出来的 mutable i32 global 值
- 线性内存 payload 本身

分析入口会先解析这段 dump header，然后把后续数据暴露成一个针对 wasm memory 的 `DataView`。
这些被序列化出来的 mutable i32 globals，正是用来恢复 GC global root 的。

### 单快照分析流水线

Constructor view 是在“一份 dump + 一个带 debug 信息的 wasm 二进制”之上构建出来的。

#### 1. 解析 DWARF 和运行时元数据

分析器会从 wasm 二进制里读取 DWARF，用来重建：

- class name
- field layout
- reference field
- global-root metadata

这一步使得工具可以把一个原始运行时 type ID 映射回具体构造函数名，并知道对象内部哪些位置代表引用边。

#### 2. 从 TLSF block 中枚举 heap object

AssemblyScript 增量运行时把 heap object 存放在 TLSF block 中。
heap-analyzer 会遍历这些 block，枚举出已分配对象，并计算它们的 shallow size。

#### 3. 扫描引用并构建 object graph

借助 DWARF 还原出来的布局信息，分析器会扫描每个 live block，并提取它的出边引用。
这样就得到了一张图：节点是 payload pointer，边是对象引用关系。

#### 4. 发现 roots

当前实现会从三个地方识别 roots：

- 通过 DWARF 和 wasm global 元数据恢复出来的 globals
- `__stack_pointer` 到 `__heap_base` 之间的 shadow stack 区间
- GC color 为 transparent 的 pinned object

#### 5. 标记 live set

从这些 roots 出发，分析器会遍历 object graph，并只保留可达对象。
后续所有步骤都只在 live graph 上进行。

#### 6. 用 dominator tree 计算 retained size

Retained size 的实现基于 dominator analysis。

在 live graph 中，如果到达对象 `B` 的每一条路径都必须经过对象 `A`，那么就说 `A` dominates `B`。
分析器会构建 dominator tree，并自底向上聚合 retained size。

这样 retained size 就有了一个非常明确的操作语义：

- 对象自身的 shallow size
- 再加上那些只能被它单独保活的 live descendant 的 shallow size

#### 7. 按 constructor 聚合

最后，所有 live object 会按 `className` 进行分组。
对于每一行 constructor 数据，分析器会记录：

- 实例数量
- shallow size 总量
- retained size 总量
- 按 retained size 排序的实例列表

这就是 constructor view。

### Snapshot Comparison Pipeline

Comparison view 并不是直接对 raw memory 做 diff。
它真正比较的是两份 constructor snapshot。

流程如下：

1. 先把 baseline dump 分析成一份 constructor snapshot
2. 再把 current dump 分析成另一份 constructor snapshot
3. 按 `className` 对两边做分组
4. 在每个 constructor 内再按 `address` 匹配实例
5. 把新增和删除的实例聚合成 DevTools 风格的 diff 列

这种设计让 diff 逻辑保持得比较窄，也比较稳定：

- 顶层 diff 列使用 shallow size
- 展开行只展示发生变化的实例
- 相同地址且未变化的实例会被忽略

这也是为什么 constructor view 和 comparison view 是互补的：

- constructor view 解释当前的所有权关系与 retention
- comparison view 解释随时间发生的变化

它们组合起来，形成了一套适合 WARPO 生成的 WebAssembly 程序进行内存调试的工作流。
