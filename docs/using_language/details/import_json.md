# import json

<p style="display: flex; gap: 10px;">
  <img src="/version/2.2.3.svg" alt="2.2.3" />
  <img src="/stability/rc.svg" alt="2.2.3" />
</p>

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
