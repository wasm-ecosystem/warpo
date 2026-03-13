# 快速开始

按如下方式配置 `tsconfig.json`。

```json
{
  "extends": "warpo/tsconfig-warpo.json",
  "include": ["./**/*.ts"]
}
```

在 `assembly/index.ts` 中编写 TS 代码：

```ts
export function add(a: i32, b: i32): i32 {
  return a + b;
}
```

编译：

```bash
npx warpo build
npx warpo build --target debug
npx warpo build --target release
npx warpo test
npx warpo -h
```

关于最新的 CLI 工作流，可进一步参考 [使用 WARPO CLI 进行构建与测试](/zh-CN/using_compiler/build_and_test)。

旧的直接调用方式仍然可用：

```bash
npx warpo assembly/index.ts -o build/debug.wat
```

## 调试构建

使用 `--debug` 生成调试符号。
调试器开发者可参考 [调试符号的详细设计](/tech/debug_symbol/index.md)。
