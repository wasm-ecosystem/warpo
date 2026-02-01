warpo 维护了一套面向 [WebAssembly](https://webassembly.org/) 的 [TypeScript](https://www.typescriptlang.org/) 变体。

它从 [AssemblyScript](https://www.assemblyscript.org/using_language.html) 分支演进而来，并在其基础上做进一步扩展，使其更现代。

### 目标

- 兼容 TS 的基础语法
- 常见场景下尽量与 TS 运行结果一致，否则直接拒绝编译
- 兼容大多数 TS 工具链
- 使用 TS 类型系统来表达 WebAssembly 的特性
- 降低代码体积并提升执行性能

### 非目标

- JavaScript
- Type Gymnastics（复杂类型体操）
