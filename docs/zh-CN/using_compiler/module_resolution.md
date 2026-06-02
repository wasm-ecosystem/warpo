WARPO 现在支持通过 `--path` 做粗粒度的第三方包路径解析，同时也提供脚本化、细粒度的覆盖机制。

使用 `--path <dir>` 可以添加额外的包搜索根目录，行为类似 `node_modules`。该参数可重复传入多个路径。WARPO 会先按照默认规则向上查找 `node_modules`，再按传入顺序依次查找额外的 `--path` 根目录。

```bash
npx warpo build assembly/index.ts -o build/app.wat --path ./vendor --path ../shared-packages
```

当你需要按包名做定向重写，或者需要更灵活的自定义逻辑时，可以使用 `create.ts`。它与 Rust 的 `build.rs` 机制类似：WARPO 会在项目根目录（可通过 `--project` 指定，默认是 `pwd`）查找 `create.ts` 文件，并在构建过程中执行该脚本。

你可以在 `create.ts` 中通过 WARPO 暴露的 `onModuleResolve` API 注入自定义的模块解析函数。如果自定义解析器返回了包路径，它的优先级高于默认解析流程和所有 `--path` 根目录。

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
