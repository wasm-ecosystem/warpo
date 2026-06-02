WARPO supports `--path` for coarse-grained third-party package resolution and also provides a script-based, fine-grained override mechanism.

Use `--path <dir>` to add extra package search roots, similar to `node_modules`. Repeat the option to add multiple roots. WARPO first searches the usual upward `node_modules` directories, then the extra `--path` roots in the order provided.

```bash
npx warpo build assembly/index.ts -o build/app.wat --path ./vendor --path ../shared-packages
```

When you need package-specific redirection or custom logic, use `create.ts`. Similar to Rust's `build.rs` mechanism, WARPO searches the `create.ts` file in project root (can be defined by `--project`, `pwd` by default) and runs it during build.

You can inject custom module resolution functions through the `onModuleResolve` API exposed by WARPO in `create.ts`. If a custom resolver returns a package path, it takes precedence over the default resolver and any `--path` roots.

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
