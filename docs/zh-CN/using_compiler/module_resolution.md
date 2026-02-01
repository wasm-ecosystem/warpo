不同于 AssemblyScript 通过 `--path` 与 `--lib` 参数对第三方库做较粗粒度的路径解析方式，WARPO 提供了脚本化、细粒度的第三方库路径解析方案。

它与 Rust 的 `build.rs` 机制类似：WARPO 会在项目根目录（可通过 `--project` 指定，默认是 `pwd`）查找 `create.ts` 文件，并在构建过程中执行该脚本。

你可以在 `create.ts` 中通过 WARPO 暴露的 `onModuleResolve` API 注入自定义的模块解析函数，以“劫持”默认的模块解析行为。

```ts
import * as resolveModule from "warpo/create/resolveModule";
import { __dirname } from "warpo/create";

resolveModule.onModuleResolve((task: resolveModule.ModuleResolve): void => {
  trace("resolved @as/A to @as/B");
  if (task.packageName === "@as/A") {
    task.setPackagePath(__dirname + "/node_modules/@as/B");
  }
});
```
