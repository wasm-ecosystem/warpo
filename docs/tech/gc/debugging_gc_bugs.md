# Debugging GC Bugs

## Note on Minimal Reproduction

Creating a minimal reproduction for GC bugs is often difficult.

Reason: removing code can change GC execution order (`__new` and `__collect`) and change object reachability paths.

In practice, changing export-function call order or removing code that looks unrelated can make the bug disappear.

## Why Direct Analysis Fails

1. **Heap is corrupted at crash time** - crash location is where corruption is detected, not where it happened
2. **WAT files are 600K+ lines** - humans and AI cannot reliably analyze such massive code
3. **Backtrace is useless** - problem occurred earlier, reasoning from crash site is futile

Don't try to find root causes by reading crash backtraces or WAT files.

## Systematic Trace Approach

### 1. Add Trace at Boundaries

Instrument GC allocation, mark, sweep, and memory access points. Answer:

- What is the full lifecycle of the target object? (alloc -> refs -> GC cycles -> final state)
- Did GC behavior match expectation? (kept alive when needed, collected when dead)
- Is the failure class premature free, missing root/edge, stale pointer use, or unexpected retention?

### 2. No Template Strings

Template strings create objects during execution and change GC behavior. Results become unreliable.

WRONG:

```typescript
trace(`alloc ptr=${ptr} size=${size}`);
```

CORRECT:

```typescript
__gc_trace_alloc(ptr, size); // number arguments only
```

### 3. Trace Function Pattern

Runtime-level functions with numeric IDs. Strings in imported layer:

E.g. in assemblyscript/std/assembly/rt.ts:

```typescript
export declare function __gc_trace_alloc(ptr: usize, size: u32, site: u32): void;
export declare function __gc_trace_mark(ptr: usize, phase: u32): void;
export declare function __gc_trace_sweep(ptr: usize, phase: u32): void;
```

In runtime imports:

```typescript
__gc_trace_alloc(ptr: usize, size: u32, site: u32) {
  const labels = { 1: "new_object", 2: "new_array", 3: "clone_object" };
  console.log(`[GC_ALLOC] ptr=0x${ptr.toString(16)} size=${size} site=${labels[site]}`);
}
```

Emit after sensitive operations:

```typescript
obj = __new(size, idof<T>());
__gc_trace_alloc(changetype<usize>(obj), size, siteId);
```

### 4. Collect Trace Events

- `alloc ptr=0xXXX size=N` - object created
- `free ptr=0xXXX` - object freed by GC
- `visit ptr=0xXXX` - object marked in GC
- `link parent=0xP child=0xC` - reference created
- `read ptr=0xXXX from=global_name` - global accessed

### 5. Ask AI Specific Questions

Don't ask: "Why is my code crashing?"

Instead ask AI these factual questions about trace logs:

- When was object 0xNNNN allocated and who referenced it?
- In each GC cycle, what happened to 0xNNNN?
- Did 0xNNNN die too early, stay alive too long, or change state as expected?
- Which edge/root transition changed its reachability?

AI is reliable at pattern-matching in logs.

### 6. Root Cause from Trace Facts

From AI answers, identify the invariant violation pattern:

For GC bugs in general:

1. **Failure type** - Premature free, stale pointer use, missing root/edge, or retention leak
2. **Check invariant** - What should have kept it alive? (GC root, live variable, etc)
3. **Identify responsibility** - Who owns clearing/protecting it? (runtime, IR lowering, GC)
4. **Design fix** - Add missing clear/protect at the right abstraction level

## Note on Release Builds

This method may not work in release builds.

Reason: adding import calls for tracing can change optimization behavior in passes, so code shape and lifetime patterns may differ from the original release binary.
