Unlike AssemblyScript's coarse-grained approach to third-party library path resolution via `--path` and `--lib` parameters, WARPO provides a script-based, fine-grained path resolution solution for third-party libraries.

Similar to Rust's `build.rs` mechanism. WARPO will search the `create.ts` file in project root (can be defined by `--project`, `pwd` by default) and run it during build.

We can inject custom module resolution functions through the `onModuleResolve` API exposed by WARPO in `create.ts` to hack the default module resolve behavior.

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
