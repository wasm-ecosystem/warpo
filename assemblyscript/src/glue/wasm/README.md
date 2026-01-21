These glue files should not contain any export or import to make sure they are global visible.

> A module script is a script that contains import or export declarations. A script is a script that does not contain import or export declarations.
>
> When a module script is evaluated, it is executed in a module environment, which is a separate lexical environment from the global environment. The module environment has its own set of bindings that are not accessible from the global environment. In contrast, when a script is evaluated, it is executed in the global environment, and all bindings are added to the global environment.

https://www.typescriptlang.org/docs/handbook/2/modules.html#how-javascript-modules-are-defined
