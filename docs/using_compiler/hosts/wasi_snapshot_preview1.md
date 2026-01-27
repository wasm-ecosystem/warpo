# WASI Snapshot Preview 1 Host

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/stable.svg" alt="stable" />
</p>

When you compile with `--host wasi_snapshot_preview1`, WARPO targets the WASI Snapshot Preview 1 import surface (module name `wasi_snapshot_preview1`).

In addition, WARPO automatically provides WASI-backed global APIs so you can write familiar code like `console.log(...)` and `process.exit(...)`.

## Enable The Host

In `asconfig.json`:

```json
{
  "options": {
    "host": "wasi_snapshot_preview1"
  }
}
```

Or via CLI:

```bash
warpo assembly/index.ts -o build/app.wasm --host wasi_snapshot_preview1
```

## Provided Globals

WARPO injects these aliases when `host` is `wasi_snapshot_preview1`:

- `console` (WASI-backed) from `~lib/wasi_snapshot_preview1/wasi_console/wasi_console`
- `process` (WASI-backed) from `~lib/wasi_snapshot_preview1/wasi_process/wasi_process`
- `Date` (WASI-backed) from `~lib/wasi_snapshot_preview1/wasi_date/wasi_Date`
- `performance` (WASI-backed) from `~lib/wasi_snapshot_preview1/wasi_performance/wasi_performance`
- `crypto` (WASI-backed) from `~lib/wasi_snapshot_preview1/wasi_crypto/wasi_crypto`
- `abort` (WASI-backed) from `~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort`
- `seed` (WASI-backed) from `~lib/wasi_snapshot_preview1/wasi_internal/wasi_seed`
- `trace` (WASI-backed) from `~lib/wasi_snapshot_preview1/wasi_internal/wasi_trace`

## Example

```ts
console.log("hello from WASI");
console.time("work");

console.log("argv[0] = " + (process.argv.length ? process.argv[0] : ""));
console.log("HOME = " + (process.env.has("HOME") ? process.env.get("HOME") : ""));

console.timeEnd("work");

// Exit with success
process.exit(0);
```
