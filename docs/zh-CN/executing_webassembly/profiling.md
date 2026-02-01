WARPO 采用插桩（instrumentation）技术来分析代码中潜在的 CPU 性能问题。

## 概念

当把 AssemblyScript 编译为 WebAssembly 时，命令行参数 `--trace-point-mapping-file` 用于指定 trace point mapping 文件的路径。
WARPO 会在用户代码的每个函数入口与出口自动插入插桩。
这些插桩点对应导入函数 `builtin.tracePoint(id: i32)`；trace point ID 与函数名之间的映射关系会存储在 trace point mapping 文件中。

WebAssembly 执行引擎需要为 `builtin.tracePoint` 函数提供兼容支持：将当前时间点与对应的 trace point ID 持久化写入本地存储介质。
后续分析工具即可通过函数入口/出口处的时间信息重建完整的执行时间线，并据此生成可视化的火焰图。

## 技术细节

### 插入插桩

为进行 CPU 性能分析，WARPO 需要追踪函数的入口与出口。
为了便于后处理，假设某函数的映射 ID 为 `N`：WARPO 会在函数入口插入 `builtin.tracePoint(N)`，并在函数出口插入 `builtin.tracePoint(-N)`。

::: details
函数会从 `0x1'000000` 开始编号。
:::

### 执行时记录

参见 wasm-compiler 文档：[tracing](https://github.com/wasm-ecosystem/wasm-compiler/blob/develop/extensions/README.md#tracing)

简而言之：设置环境变量 `WARP_TRACING_RECORDER_FILE=<trace-point-record-file>` 来启用 tracing 扩展。

### 后处理

`warpo_trace_visualizer` 是一个专用工具，用于把 wasm-compiler 生成的 trace record 转换为 perfetto 格式的 trace 文件。

基本用法：`warpo_trace_visualizer --trace-point-mapping-file <trace-point-mapping-file> --trace-point-record-file <trace-point-record-file> --output-pftrace-file <out-file>`。

- `<trace-point-mapping-file>` 是编译阶段由编译器生成的元数据文件，
  对应 `--trace-point-mapping-file` 命令行参数指定的输出路径。
- `<trace-point-record-file>` 是 wasm-compiler 在执行阶段生成的二进制文件，
  对应环境变量 `WARP_TRACING_RECORDER_FILE` 指定的输出路径。
- `--max-slice-count N` 指定最大处理的 slice 数。
  slice 定义为从 host 环境进入 WASM 虚拟机再返回的完整调用周期。
  当处理大规模 trace record 时，该参数能显著提升后处理效率。<br/>
  默认不限制。
- `--count-to-perfetto-timestamp-rate` 指定 `<trace-point-record-file>` 中时间值与 perfetto 时间线实际时间戳之间的比例。
  当后处理程序运行在与 wasm-compiler 执行阶段不同的机器上时，必须提供该参数。<br/>
  默认会动态计算，并假设后处理阶段 CPU 频率与录制阶段一致。
