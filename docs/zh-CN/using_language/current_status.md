# 当前状态

## TS 特性

WARPO 支持大多数常见 TS 特性：

- 数值计算
- 函数
- class、interface 与多态
- 泛型

但也缺失一些特性：

- `undefined`  
  在脚本中，你可以用 `null` 完全替代 `undefined`。  
  在标准库中，如果按 TS 语义返回 `undefined`（例如从 Map 中读取不存在的 key），脚本会在运行时崩溃。
- `any`、`unknown`
- prototype
- iterator、for...of、for...in
- closure
- 类型推导

## WebAssembly 特性

#### 成熟度 T0：默认启用 🚀

- Mutable Globals
- Bulk Memory Operations For Optimization
- Sign-extension Operators
- Non-trapping float-to-int Conversions

#### 成熟度 T1：已实现 🏁

- Fixed-width SIMD

#### 未实现 🔨

- Branch Hinting
- Bulk Memory Operations
- Exception Handling
- Multi-value
- Reference Types
- Tail Call
- Typed Function References
- Relaxed SIMD

#### 无计划（对 WARPO 意义不大）

- Multiple Memories
- Garbage Collection
- Memory64
