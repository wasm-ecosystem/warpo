Comparison with AS, we support some new features.

::: info
Features with :sparkles: means it is not enabled by default, a command line option `--experimental` is needed to enable these experimental features.
:::

# utf8 const string :sparkles:

In WARPO, string will be encoded to utf16 to ensure the same behavior with TS. But it is also a common requirement to use string in FFI.
In low level WebAssembly runtime, the native string most likely is utf8 encoded, for example rust or C++.

It is a experimental support to store the static string in linear memory with utf8 encoding to reduce the overhead in FFI.

# import json

WARPO support to import json file like TS.

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

## limitation

Type system in TS support duck typing and `any`. It can support typing of json easier. Unfortunately WARPO does not support this kind flexible typing system.
This resulted in WARPO being unable to support the import of any type of JSON object.

Under the current limitation, we only support to import scalar type which WARPO can infer the type during compilation time without any type hint in json.

- For JSON string type, WARPO will treat it as `string`.
- For JSON number type, if it a integer, WARPO will treat is as `i64`, otherwise `f64`.
- For JSON array type, WARPO will treat it as `Array<inside_type>` only when all elements inside JSON array type are the same type.
