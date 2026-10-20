# 新增特性 :tada:

与 AssemblyScript（AS）相比，warpo 支持一些新增特性：

<Badge type="info" text="2.2.0" />

- [CPU 性能分析](/zh-CN/executing_webassembly/profiling)

<Badge type="info" text="2.2.3" />

- [utf8 常量字符串](/zh-CN/using_language/details/utf8_const_string)
- [导入 JSON](/zh-CN/using_language/details/import_json)

<Badge type="info" text="2.3.0" />

- [Radical GC](/zh-CN/using_runtime/radical_gc)
- [Iterator](/zh-CN/using_language/details/iterator)（不包含 Map iterator）
- [for...of](/zh-CN/using_language/details/for_of)
- [编译选项配置](/zh-CN/using_compiler/config)

<Badge type="info" text="2.4.0" />

- [Host API](/zh-CN/using_compiler/config#host)
  - [wasi_snapshot_preview1 host](/zh-CN/using_compiler/hosts/wasi_snapshot_preview1)
- [Tuple](/zh-CN/using_language/details/tuple)

<Badge type="info" text="3.0.0" />

- [使用 WARPO CLI 进行构建与测试](/zh-CN/using_compiler/build_and_test)
- [闭包函数](/en/using_language/details/closure)
- [Promise](/en/using_language/details/promise)

<Badge type="info" text="3.1.0" />

- [Multi Return](/en/using_language/details/multi_return)

<Badge type="info" text="3.1.1" />

- [Heap Analyzer](/zh-CN/executing_webassembly/heap-analyzer)

<Badge type="info" text="3.3.0" />

- [从数组和 tuple 中解包](/zh-CN/using_language/details/unpack)
- [Tagged template literals](/zh-CN/using_language/details/template_literal)
- [ReadonlyArray](/zh-CN/using_language/details/readonlyarray)

<Badge type="tip" text="nightly" />

- 未使用字段存储消除
- [共享 GC 返回 epilogue（`return-to-br`）](/zh-CN/using_compiler/config#return-to-br)
- [类对象字面量的初始化顺序](/zh-CN/using_language/details/object_literal_initialization)
