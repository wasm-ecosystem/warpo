# import json

<p style="display: flex; gap: 10px;">
	<img src="/version/2.2.3.svg" alt="2.2.3" />
	<img src="/stability/rc.svg" alt="rc" />
</p>

WARPO 支持像 TS 一样导入 JSON 文件。

```ts
import { name, uuid } from "../package.json";
// name is "project-name"
// uuid is 123456
```

```json
{
  "name": "project-name",
  "uuid": 123456
}
```

## 限制

TS 的类型系统支持 duck typing 与 `any`，因此更容易表达 JSON 的类型。
不幸的是，WARPO 并不支持这种灵活的类型系统，这导致 WARPO 无法支持任意形态的 JSON 对象导入。

在当前限制下，我们仅支持导入标量（scalar）类型：WARPO 可以在编译期不依赖额外类型提示就推导出其类型。

- 对于 JSON string 类型，WARPO 将其视为 `string`。
- 对于 JSON number 类型：如果是整数，WARPO 将其视为 `i64`；否则视为 `f64`。
- 对于 JSON array 类型：仅当数组内所有元素类型一致时，WARPO 才会将其视为 `Array<inside_type>`。
