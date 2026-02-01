# WASI Snapshot Preview 1 Host

<p style="display: flex; gap: 10px;">
	<img src="/version/2.4.0.svg" alt="2.4.0" />
	<img src="/stability/stable.svg" alt="stable" />
</p>

当你使用 `--host wasi_snapshot_preview1` 进行编译时，WARPO 会面向 WASI Snapshot Preview 1 的导入接口（module 名为 `wasi_snapshot_preview1`）。

此外，WARPO 还会自动提供一组基于 WASI 的全局 API，让你可以直接写类似 `console.log(...)`、`process.exit(...)` 的熟悉代码。

## 启用 Host

在 `asconfig.json` 中：

```json
{
  "options": {
    "host": "wasi_snapshot_preview1"
  }
}
```

或者使用 CLI：

```bash
warpo assembly/index.ts -o build/app.wasm --host wasi_snapshot_preview1
```

## 提供的全局对象

当 `host` 为 `wasi_snapshot_preview1` 时，WARPO 会注入如下别名：

- `console`（WASI-backed），来自 `~lib/wasi_snapshot_preview1/wasi_console/wasi_console`
- `process`（WASI-backed），来自 `~lib/wasi_snapshot_preview1/wasi_process/wasi_process`
- `Date`（WASI-backed），来自 `~lib/wasi_snapshot_preview1/wasi_date/wasi_Date`
- `performance`（WASI-backed），来自 `~lib/wasi_snapshot_preview1/wasi_performance/wasi_performance`
- `crypto`（WASI-backed），来自 `~lib/wasi_snapshot_preview1/wasi_crypto/wasi_crypto`
- `abort`（WASI-backed），来自 `~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort`
- `seed`（WASI-backed），来自 `~lib/wasi_snapshot_preview1/wasi_internal/wasi_seed`
- `trace`（WASI-backed），来自 `~lib/wasi_snapshot_preview1/wasi_internal/wasi_trace`

## 示例

```ts
console.log("hello from WASI");
console.time("work");

console.log("argv[0] = " + (process.argv.length ? process.argv[0] : ""));
console.log("HOME = " + (process.env.has("HOME") ? process.env.get("HOME") : ""));

console.timeEnd("work");

// Exit with success
process.exit(0);
```
