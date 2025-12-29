In binaryen, each pass is constructed by several visitors and walkers.

This page is about how to select suitable visitors and walkers for your passes.

in [wasm-traversal.h](https://github.com/wasm-ecosystem/warpo/tree/main/third_party/binaryen/src/wasm-traversal.h),
we can find all basic visitors and walkers.

There are two layers of abstraction here, visitors and walkers.

## visitor

The visitor provides a set of interfaces for accessing expressions.

- `Visitor`: will call `visit<OpCode>` for each expression.
- `UnifiedExpressionVisitor`: will call `visitExpression` for each expression.

## walker

The walker is decoupled with visitors, is used to control the order of access expressions.

- `PostWalker`: will call visitor in post-order, i.e., children first. Its access order is related to the execution order of the wasm bytecode.
- `ExpressionStackWalker`: based on `PostWalker`, and using a stack to store the parent expression.

### hook point

Each walker maintains a stack to store operation (static method pointer and `Expression *`).
Hook point can be found by searching `self->pushTask(SubType::...` in base class.
These static methods need to be _overridden_ in derived classes to hook.

A common used hook point:

`scan` can be used to change the visit behavior. We can insert specific methods into the scan or adjust the traversal order.
