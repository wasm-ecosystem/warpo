// Copyright (C) 2025 Daniel Wirtz / The AssemblyScript Authors
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { Range } from "./diagnostics";
import { Expression, NodeKind } from "./ast";
import { IVisitor } from "./ast/visitor";
import { ExpressionRef } from "./module";
import { Type } from "./types";

export function createCompiledExpression(expr: ExpressionRef, type: Type, range: Range): Expression {
  return new CompiledExpression(expr, type, range);
}

/** Represents a special pre-compiled expression. If the expression has side-effects, special care has to be taken. */
export class CompiledExpression extends Expression {
  constructor(
    /** Compiled expression. */
    public expr: ExpressionRef,
    /** Type of the compiled expression. */
    public type: Type,
    /** Source range. */
    range: Range
  ) {
    super(NodeKind.Compiled, range);
  }

  accept(visitor: IVisitor): void {
    visitor.visitCompiledExpression(this);
  }
}