# Heap Analyzer

WARPO heap-analyzer is a heap snapshot analysis tool for AssemblyScript programs running on the incremental runtime.
It is designed for the stage where you already know that memory is growing or staying alive for too long, but a raw linear-memory dump is still too low-level to explain why.

## 1. Why do we need heap-analyzer?

At runtime, the WebAssembly heap is just bytes.
A raw memory dump tells you that memory exists, but not which objects are alive, which constructors dominate the live heap, or what changed between two moments in time.

There are two recurring debugging questions:

1. What is currently taking space?
2. What changed after a specific action, scene switch, request, or frame?

WARPO heap-analyzer answers these two questions with two views modeled after the Chrome DevTools heap snapshot workflow.

### Constructor View

Constructor view solves the “what is taking space right now?” problem.

An object-by-object list is usually too noisy:

- addresses are unstable across runs
- hundreds or thousands of objects from the same class get mixed together
- root-oriented data explains reachability, but not where memory is concentrated

Constructor view groups live objects by `className` first, then lets you drill down into individual instances.
That makes it easy to spot patterns such as:

- one constructor unexpectedly dominating retained size
- a container class with a small shallow size but a very large retained size
- a single oversized instance that keeps an entire object subgraph alive

### Comparison View

Comparison view solves the “what changed between two snapshots?” problem.

Without a structured diff, you end up manually comparing addresses or scanning two large JSON files side by side.
That is both slow and misleading, because the interesting question is not “which addresses differ?” but rather:

- which constructors gained objects
- which constructors lost objects
- how many bytes were newly allocated
- how many bytes were freed

WARPO comparison view follows the DevTools mental model:

- constructor rows show `New`, `Delete`, `Delta`, `Alloc.size`, `Freed size`, and `Size Delta`
- expanded instance rows show only changed instances
- instance rows keep per-object `retainedSize` for drill-down, while constructor diff rows intentionally use shallow-size-based columns

This split matters.
Retained size is very useful for understanding ownership in a single snapshot, but it overlaps across objects and is not a good top-level diff column.
For change analysis, shallow-size deltas are much easier to reason about.

## 2. How to use heap-analyzer?

### Prerequisites

heap-analyzer needs two inputs:

1. A dump file captured from the running WebAssembly module.
2. The corresponding wasm binary compiled with DWARF debug information.

The debug information is required because heap-analyzer reconstructs class layouts, field metadata, and global-root metadata from DWARF.
Without `--debug`, the analyzer cannot map runtime objects back to source-level constructors and reference fields reliably.

Compile your wasm with debug info enabled:

```bash
./build/warpo/warpo_asc ./build_work/dwarfFixture.ts -o ./build_work/dwarfFixture.wasm --debug
```

If you use project configuration instead of direct compiler arguments, the effective requirement is the same: the build must emit DWARF debug information.

### Dump a Heap Snapshot at Runtime

heap-analyzer does not pause a running wasm VM by itself.
Instead, your program imports a host function that writes a dump at the point you choose.

On the wasm side, declare a host import and call it with a UTF-8 encoded output path:

```ts

@external("MemoryDump", "dumpMemoryRegion")
declare function dumpMemoryRegion(filePathOffset: i32, filePathSize: i32): void;

const dumpPath = "./build_work/example-before.dump";
const encodedPath = String.UTF8.encode(dumpPath);
dumpMemoryRegion(changetype<i32>(encodedPath), String.UTF8.byteLength(dumpPath));
```

The import itself is just a hook.
The host runtime must implement `MemoryDump.dumpMemoryRegion` and serialize the current heap state to disk.
If you are using wasm-compiler as the host, this import is already supported by its `MemoryDump` extension: [MemoryDumpAPI.cpp](https://github.com/wasm-ecosystem/wasm-compiler/blob/develop/extensions/MemoryDumpAPI.cpp).

In a real Node host, `dumpMemoryRegion` also needs to decode the UTF-8 path from wasm linear memory and then forward that path to the dump writer:

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

A minimal JavaScript host-side implementation looks like this:

```js
import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";

const DUMP_MAGIC = new Uint8Array([0x41, 0x53, 0x48, 0x44]); // "ASHD"
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

The dump file format is:

- magic: `ASHD`
- version
- `__data_end`
- `__heap_base`
- `__stack_pointer`
- `numMutableI32GlobalValues`
- `mutableI32GlobalValues[]`
- the raw linear memory payload

The minimal Node example above intentionally writes `0` for `numMutableI32GlobalValues`.
That is enough for simple fixtures, but it is not the full dump format.

This field is used to reconstruct GC global roots.
heap-analyzer maps the serialized mutable i32 global values back to wasm global indices, then uses them to recover managed objects kept alive by global variables.

Today, the Node-side example does not have a general way to enumerate and serialize all runtime mutable i32 globals from an arbitrary instance.
Because of that, the example focuses on the stable part of the format: runtime boundary globals plus the raw memory image.

If your program keeps managed objects in mutable wasm globals, omitting `mutableI32GlobalValues[]` can make some live objects look unreachable.
For full GC-global accuracy, your host-side dump writer needs to serialize those mutable i32 globals before the raw memory payload.

To use comparison view, capture two dumps at two different moments, for example:

- before entering a scene and after leaving it
- before a request and after the response is fully processed
- before and after a stress loop that is suspected to leak

### Run Constructor View

If `warpo` is installed in your project, invoke heap-analyzer directly from the package contents:

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js
```

Inside the repository, the equivalent entry point is still `node ./tools/heap_analyzer/bin/cli.js`.

Basic usage:

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js analyze ./build_work/example-before.dump --wasm ./build_work/dwarfFixture.wasm
```

Useful options:

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js analyze ./build_work/example-before.dump --wasm ./build_work/dwarfFixture.wasm --sort retained
node ./node_modules/warpo/dist/heap_analyzer/cli.js analyze ./build_work/example-before.dump --wasm ./build_work/dwarfFixture.wasm --sort shallow
node ./node_modules/warpo/dist/heap_analyzer/cli.js analyze ./build_work/example-before.dump --wasm ./build_work/dwarfFixture.wasm --sort count --top 20
```

The output is JSON with this top-level shape:

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

Field meanings:

- `totalHeapSize`: total TLSF-managed heap region currently present in linear memory.
  This is allocator space, not just live objects.
- `totalLiveSize`: sum of shallow sizes of all reachable objects.
- `className`: source-level constructor name resolved from DWARF.
- `count`: number of live instances for that constructor.
- `totalShallowSize`: sum of shallow sizes for instances of that constructor.
- `totalRetainedSize`: sum of retained sizes for instances of that constructor.
- `instances`: per-instance drill-down rows.

For each instance:

- `address`: payload pointer in wasm linear memory.
- `shallowSize`: allocator cost of that object itself.
  In WARPO this is based on the object block size, so it includes allocator/header overhead rather than only source-visible field bytes.
- `retainedSize`: The size of memory that you can free after an object is deleted (and the dependents are made no longer reachable) is called the retained size.

One important caveat: constructor-level `totalRetainedSize` is useful for ranking, but it is not a partition of `totalLiveSize`.
Retained regions overlap when you sum them across many objects, so constructor totals can exceed the live heap size.

### Run Comparison View

Comparison view takes a baseline dump and a current dump:

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js diff ./build_work/example-before.dump ./build_work/example-after.dump --wasm ./build_work/dwarfFixture.wasm
```

Useful options:

```bash
node ./node_modules/warpo/dist/heap_analyzer/cli.js diff ./build_work/example-before.dump ./build_work/example-after.dump --wasm ./build_work/dwarfFixture.wasm --sort delta
node ./node_modules/warpo/dist/heap_analyzer/cli.js diff ./build_work/example-before.dump ./build_work/example-after.dump --wasm ./build_work/dwarfFixture.wasm --sort alloc
node ./node_modules/warpo/dist/heap_analyzer/cli.js diff ./build_work/example-before.dump ./build_work/example-after.dump --wasm ./build_work/dwarfFixture.wasm --sort freed --top 20
```

The top-level output shape is:

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

Field meanings follow the DevTools comparison model:

- `newCount`: instances present only in the current dump.
- `deletedCount`: instances present only in the baseline dump.
- `countDelta`: `newCount - deletedCount`.
- `allocatedSize`: sum of shallow sizes for `new` instances.
- `freedSize`: sum of shallow sizes for `delete` instances.
- `sizeDelta`: `allocatedSize - freedSize`.

Expanded instance rows keep:

- `address`
- `shallowSize`
- `retainedSize`
- `changeKind: "new" | "delete"`

Comparison view matches instances by `className + address`.
If the same class/address pair exists in both dumps, it is treated as unchanged and omitted from the expanded change list.

## 3. How do we implement?

At a high level, heap-analyzer has three layers:

1. dump capture
2. single-snapshot analysis
3. snapshot-to-snapshot comparison

### Dump Capture

The runtime dump file is a lightweight container around a raw memory snapshot.
The current format stores:

- dump magic and version
- `__data_end`
- `__heap_base`
- `__stack_pointer`
- the number of serialized mutable i32 global values
- serialized mutable i32 global values
- the linear memory payload itself

The analyzer entrypoint first parses this dump header and then exposes the remaining bytes as a `DataView` over wasm memory.
Those serialized mutable i32 globals are specifically used to recover GC global roots.

### Single-Snapshot Analysis Pipeline

The constructor view is built as a pipeline over one dump and one debug-enabled wasm binary.

#### 1. Parse DWARF and runtime metadata

The analyzer reads DWARF from the wasm binary to reconstruct:

- class names
- field layouts
- reference fields
- global-root metadata

This is what lets the tool map a raw runtime type ID back to a constructor name and know where reference edges exist inside each object.

#### 2. Enumerate heap objects from TLSF blocks

The AssemblyScript incremental runtime stores heap objects in TLSF blocks.
heap-analyzer walks these blocks to enumerate allocated objects and compute their shallow sizes.

#### 3. Scan references and build the object graph

Using the DWARF-derived layouts, the analyzer scans each live block and extracts outgoing references.
This produces a graph where nodes are payload pointers and edges are object references.

#### 4. Discover roots

The current implementation recognizes roots from three places:

- globals resolved from DWARF and wasm global metadata
- the shadow stack range between `__stack_pointer` and `__heap_base`
- pinned objects identified by the transparent GC color

#### 5. Mark the live set

Starting from the discovered roots, the analyzer traverses the object graph and keeps only reachable objects.
Everything after this point operates on the live graph only.

#### 6. Compute retained sizes with a dominator tree

Retained size is implemented through dominator analysis.

In the live graph, if every path to object `B` goes through object `A`, then `A` dominates `B`.
The analyzer builds the dominator tree and aggregates retained sizes bottom-up.

This gives a precise operational meaning to retained size:

- shallow size of the object itself
- plus the shallow sizes of live descendants that are exclusively kept alive by it

#### 7. Aggregate by constructor

Finally, live objects are grouped by `className`.
For each constructor row, the analyzer records:

- instance count
- total shallow size
- total retained size
- per-instance rows sorted by retained size

This is the constructor view.

### Snapshot Comparison Pipeline

Comparison view does not diff raw memory directly.
Instead, it compares two constructor snapshots.

The process is:

1. analyze the baseline dump into a constructor snapshot
2. analyze the current dump into another constructor snapshot
3. group both snapshots by `className`
4. match instances by `address` within each constructor
5. aggregate added and removed instances into DevTools-style diff columns

This design keeps the diff logic narrow and predictable:

- top-level diff columns use shallow size
- expanded rows show only changed instances
- unchanged same-address instances are ignored

That is why constructor view and comparison view complement each other:

- constructor view explains current ownership and retention
- comparison view explains change over time

Together they provide a practical workflow for memory debugging in WARPO-generated WebAssembly.
