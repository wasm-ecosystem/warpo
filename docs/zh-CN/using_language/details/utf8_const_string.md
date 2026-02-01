# utf8 const string

<p style="display: flex; gap: 10px;">
	<img src="/version/2.2.4.svg" alt="2.2.4" />
	<img src="/stability/rc.svg" alt="rc" />
</p>

## 基本用法

在 WARPO 中，string 会被编码为 utf16，以确保与 TS 的行为一致。但在 FFI 场景中，使用 string 也很常见。
在较底层的 WebAssembly 运行时里，原生 string 往往采用 utf8 编码，例如 rust 或 C++。

要使用该特性，需要显式从 `warpo:utf8_const_str` 导入：

```ts
import * as utf8 from "warpo/utf8/const_str";

let s = utf8.build("abcdef");
assert(s.size == 6);
assert(s.toString() == "abcdef");
```

## 从 [assemblyscript-transform](https://github.com/wasm-ecosystem/assemblyscript-transform) 升级指南

1. 移除命令行中的 transform 脚本 `--transform ./node_modules/@schleifner/assemblyscript-transform/dist/transformBuildUtf8ConstStr.mjs`。
2. 如果你不再回到 assemblyscript，则按示例代码替换 import 语句。
3. 如果你希望在 assemblyscript 与 warpo 之间保留灵活性，则创建 shim 并在项目根目录添加 `create.ts`。

   ```ts
   // lib/utf8-shim/as/utf8ConstStr.ts
   import * as utf8 from "warpo/utf8/const_str";
   export { utf8 };
   ```

   ```ts
   // create.ts
   import * as resolveModule from "warpo/create/resolveModule";
   import { __dirname } from "warpo/create";

   resolveModule.onModuleResolve((task: resolveModule.ModuleResolve): void => {
     if (task.packageName === "@schleifner/assemblyscript-transform") {
       task.setPackagePath(__dirname + "/lib/utf8-shim");
     }
   });
   ```
