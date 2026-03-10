# Logging

warpo’s logging is intentionally lightweight and split into two layers:

- **Always-on user-facing output**: diagnostics, errors, and high-level progress printed by the driver / tools.
- **Opt-in debug logs**: verbose internal traces intended for pass development and investigations.

This page focuses on the opt-in layer, especially how to **filter pass logs using environment variables**.

## Debug logging via environment variables

Debug logging is controlled by these environment variables:

- `WARPO_DEBUG=1`
  - Enables _all_ debug logs unconditionally.
  - If this is set, the pass/function filters below are ignored.

- `WARPO_DEBUG_PASSES=...`
  - Enables debug logs only for specific passes.
  - Value is a **semicolon-separated** list of **exact pass names**.
  - Matching is **case-sensitive**.

- `WARPO_DEBUG_FUNCTIONS=...`
  - Enables debug logs only for specific functions (for code paths that provide a function name).
  - Value is a **semicolon-separated** list of **exact function names**.
  - Matching is **case-sensitive**.

Important behavior:

- The environment is read **once** (on first use) and cached for the process lifetime.

## Filtering pass logs

Most pass-level debug prints are guarded by `warpo::support::isDebug(PASS_NAME)` (or the function-aware overload).
That means you can reduce noise by enabling logs only for the pass(es) you care about.

### Enable logs for a single pass

```bash
export 'WARPO_DEBUG_PASSES=AdvancedInlining'
```

### Enable logs for multiple passes

```bash
export 'WARPO_DEBUG_PASSES=AdvancedInlining;ImmutableLoadEliminating'
```

### Combine pass + function filtering

If you set **both** `WARPO_DEBUG_PASSES` and `WARPO_DEBUG_FUNCTIONS`, a log site guarded by
`isDebug(passName, functionName)` will only emit when **both match**.

```bash
export 'WARPO_DEBUG_PASSES=AdvancedInlining'
export 'WARPO_DEBUG_FUNCTIONS=foo;bar'
```

Notes:

- If a particular log site uses only `isDebug(PASS_NAME)` (no function name), then `WARPO_DEBUG_FUNCTIONS` has no effect.
- If you set only `WARPO_DEBUG_FUNCTIONS`, then function-aware log sites can emit regardless of pass name.

## How to find the pass names

`WARPO_DEBUG_PASSES` matches the **pass name string used in code**.
