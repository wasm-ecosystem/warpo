[[toc]]

## Why

In warpo, `@inline` in the source code is an **intent**: the user wants some calls to be inlined.
This is most important when there is a chain like `f1 -> f2 -> f3`. People expect the chain to be
inlined **from bottom to top**.

Historically this logic lived in the frontend while building IR. That approach tends to require the
frontend to track extra “where am I in the source vs where am I emitting IR” context, which adds
complexity and makes it harder to reuse mid-end inlining machinery.

Moving inline-decorator work into the mid-end lowering gives us:

- **Less frontend work**: the frontend only records “this call should be inlined”, and does not do the inlining itself.
- **Reuse of inlining code**: lowering can reuse warpo’s existing inliner implementation (based on Binaryen).
- **Earlier help for later lowering (GC lowering)**: `InlinedDecoratorLower` runs before GC lowering.
  Earlier inlining can turn values that live across calls into values inside one function, which can
  make GC shadow-stack work easier and reduce shadow-stack slots and prologue/epilogue work.

## What

**Inline decorator lowering** means: take the source `@inline` intent into Wasm IR, and during
lowering do a **force inline** on the marked call sites. This is different from later
optimization-time inlining like `AdvancedInlining`, which is based on a cost model.

In warpo, this is implemented as a dedicated lowering pass (see `passes/InlinedDecoratorLower.cpp`,
and the run order in `passes/Runner.cpp`). Conceptually, it consumes a “force-inline hint set”
produced by the frontend, then performs real inlining at those specific call sites.

### How the frontend expresses `@inline`

When the AssemblyScript compiler builds a call expression, if:

- the callee function has `@inline`, or
- we are in an inline context (`FlowFlags.InlineContext`),

then it reports this call expression to warpo as “this call site should be force-inlined”.

In code terms (without relying on specific symbol names):

- The frontend invokes a small host API to tag a particular call expression.
- warpo records a reference to that call site into a per-module hint collection.

This step only **marks** which call sites should be force-inlined. It does not inline yet.

### What lowering does

During lowering, `InlinedDecoratorLower` scans the module:

- Find every call expression that was tagged by the frontend.
- For each tagged call, build an internal “inline this callee into this caller at this exact
  location” action.
- Split actions into multiple **steps** based on the call graph, so inline chains happen from
  callee to caller.
- For each step, invoke the existing inliner to perform the actual transformation.

Notes:

- This is not the cost-model inlining in `AdvancedInlining`. It only handles the force hints from `@inline`.
- It runs in lowering, before GC lowering (see `lowering()` in `passes/Runner.cpp`).

## How

This section describes the algorithm at a high level. For implementation details, see
`passes/InlinedDecoratorLower.cpp`.

### Collect call sites

The pass first walks the module and visits call expressions in each function:

- If a call expression is present in the frontend-provided hint collection, treat it as a
  “force-inline call site”.
- If the callee is imported, skip it (imported functions cannot be inlined).
- Record an internal action that captures:
  - which caller function contains the call site,
  - which callee function should be inlined,
  - and a reference to the call site location so the call expression can be replaced in-place.

### Order by relation: split actions into steps

When there is a nested chain, we must inline from bottom to top. For example:

```ts

@inline
function f1(): i32 {
  return f2();
}


@inline
function f2(): i32 {
  return f3();
}


@inline
function f3(): i32 {
  return 7;
}
```

If we inline `f1 -> f2` first, the body of `f2` may still call `f3`. That is not what users expect
for an `@inline` chain.

The pass builds steps in a layered order based on the force-inline call relation:

- Keep a set of caller functions that still have force-inline work to do.
- In each round, select a set of callers that are safe to process now. A caller can be processed in
  this round only if all the callees it needs to inline are **not** also waiting to be processed
  (meaning those callees were already handled earlier, or they have no force-inline work at all).
- Append this round to the step list, and remove those callers from the waiting set.

This gives:

- `f2` goes to step0 first (its callee `f3` has no force-inline work / is already handled).
- `f1` goes to step1 later (its callee `f2` was handled in step0).
- Two unrelated chains can be handled in the same step (for example `f4 -> f5` and `f2 -> f3`).

#### Recursive cycles

If `@inline` forms a cycle (for example `f1 -> f2 -> f3 -> f1`), then no round can pick a valid
set of callers to process.

The current behavior will:

- Print a warning.
- Stop building new steps for the remaining callers that are part of the cycle (so that part is not
  handled).

If some steps were already built before the cycle is found (for example, chains not related to the
cycle), those steps will still run. Only the “stuck” part will be skipped.

This is a safe choice: force inlining on a cycle can lead to endless growth and huge code.

### Where it runs in the pipeline

`InlinedDecoratorLower` runs in lowering, before GC lowering (see `lowering()` in `passes/Runner.cpp`):

- Inline-decorator lowering
- GC lowering

Later, the optimize stage may run `AdvancedInlining`. That is a general optimize inliner. It does not
promise to follow `@inline` force intent, and it does not affect GC lowering stack layout decisions.
