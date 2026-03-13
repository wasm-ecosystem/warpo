# 使用 WARPO CLI 进行构建与测试

<p style="display: flex; gap: 10px;">
  <img src="/version/nightly.svg" alt="nightly" />
  <img src="/stability/experimental.svg" alt="experimental" />
</p>

WARPO CLI 现在提供了面向项目工作流的高层子命令：

- `npx warpo build` 用于构建当前项目。
- `npx warpo test` 用于运行 WARPO 单元测试。

在 WARPO 项目中，建议优先使用这两个入口，而不是手写底层编译命令。

## 构建项目

`npx warpo build` 会把额外参数继续透传给编译器，并补充一些面向项目的默认行为：

- 如果当前目录存在 `asconfig.json`，且没有传入 `--config`，WARPO 会自动使用它。
- 如果当前目录存在 `create.ts`，且没有传入 `--project`，WARPO 会自动启用 project mode。

典型的 `asconfig.json` 如下：

```json
{
  "entries": ["assembly/index.ts"],
  "targets": {
    "debug": {
      "debug": true,
      "sourceMap": true
    },
    "release": {
      "optimizeLevel": 3,
      "shrinkLevel": 2
    }
  }
}
```

常见命令：

```bash
npx warpo build
npx warpo build --target debug
npx warpo build --target release
npx warpo build --config ./configs/asconfig.json --target release
```

旧的直接调用方式仍然可用：

```bash
npx warpo assembly/index.ts -o build/debug.wat
```

## 运行单元测试

`npx warpo test` 会启动 WARPO 的测试运行器。它是基于 [assemblyscript-unittest-framework](https://wasm-ecosystem.github.io/assemblyscript-unittest-framework/) 集成而来的，因此测试组织方式、`as-test.config.js` 配置文件以及常见断言风格都与该框架保持一致。默认情况下，它会在当前目录查找 `as-test.config.js`。如果测试配置文件在其他位置，可以通过 `--config` 指定。

如果你还没有写过相关测试，建议先阅读 assemblyscript-unittest-framework 的 [quick start](https://wasm-ecosystem.github.io/assemblyscript-unittest-framework/quick-start.html)。WARPO 的 `test` 子命令可以看作是在 WARPO 工具链中对这套测试能力的直接集成。

典型的 `as-test.config.js` 如下：

```js
export default {
  include: ["tests/assemblyscript/**/*.ts"],
  collectCoverage: false,
  output: "build_coverage",
};
```

常见命令：

```bash
npx warpo test
npx warpo test --testFiles tests/assemblyscript/add.spec.ts
npx warpo test --testNamePattern add
npx warpo test --onlyFailures
npx warpo test --collectCoverage true --mode html --output build_coverage
```

补充说明：

- `--testFiles` 只运行指定测试文件。
- `--testNamePattern` 用正则表达式筛选测试用例。
- `--onlyFailures` 只重跑上一次失败的测试。
- 当你使用 `--testFiles`、`--testNamePattern` 或 `--onlyFailures` 过滤测试时，覆盖率收集默认会关闭；如有需要，请显式传入 `--collectCoverage true`。

## 另见

- [WARPO 配置文件](/zh-CN/using_compiler/config)
- [assemblyscript-unittest-framework quick start](https://wasm-ecosystem.github.io/assemblyscript-unittest-framework/quick-start.html)
