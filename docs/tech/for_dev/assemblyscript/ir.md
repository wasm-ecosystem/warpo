# AssemblyScript IR

AssemblyScript does not maintain a statement or expression level IR.<br/>
However it has namespace / class / function level IR to handle generic and layered symbol resolving.

For each source file, it will be mapped to `File` in IR. It contains all sub element in this TS source file.

For json file, currently it will be treat as a special source file and generated a fake IR.

The namespace will be mapped to `Namespace`.

For each class / interface / function

- During initialization it will be mapped to prototype.<br/>
- When resolving it, a detail `Class` / `Interface` / `Function` will be created according to prototype.

For each method

- During initialization it will be mapped to unbound prototype.<br/>
- When resolving it, a bound prototype will be created (see `FunctionPrototype.toBound`).<br/>
- Then a detail `Function` will be created according to bound prototype.

The global variable will be mapped to `Global`.

The local variable and parameter will be mapped to `Local`.
