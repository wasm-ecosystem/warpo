## utf8 const string

<p style="display: flex; gap: 10px;">
  <img src="/version/2.2.3.svg" alt="2.2.3" />
  <img src="/stability/experimental.svg" alt="2.2.3" />
</p>

In WARPO, string will be encoded to utf16 to ensure the same behavior with TS. But it is also a common requirement to use string in FFI.
In low level WebAssembly runtime, the native string most likely is utf8 encoded, for example rust or C++.

To use this feature, explicit import `warpo:utf8_const_str` from

```ts
import * as utf8 from "warpo/utf8/const_str";

let s = utf8.build("abcdef");

assert(s.size == 6);

assert(s.toString() == "abcdef");
```
