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
node node_modules/.bin/warpo assembly/index.ts -o build/debug.wat
node node_modules/.bin/warpo assembly/index.ts -o build/release.wasm --optimizeLevel 3 --shrinkLevel 2
npx warpo assembly/index.ts -o build/debug.wat # 使用 npx 简化命令
npx warpo -h # 查看更多 CLI 选项
```

## 调试构建

使用 `--debug` 生成调试符号。
调试器开发者可参考 [调试符号的详细设计](/tech/debug_symbol/index.md)。
