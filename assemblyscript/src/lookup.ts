// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { Expression, IdentifierExpression, Node, NodeKind, PropertyAccessExpression } from "./ast";
import { Element } from "./program";

/** lightweight resolver, during initializing, resolver should not be used */
export class Lookup {
  lookupExpression(expr: Expression, ctxElement: Element): Element | null {
    switch (expr.kind) {
      case NodeKind.Identifier:
        const element = ctxElement.lookup((<IdentifierExpression>expr).text);
        return element;
      case NodeKind.PropertyAccess:
        const propertyAccessExpr = <PropertyAccessExpression>expr;
        const targetElement = this.lookupExpression(propertyAccessExpr.expression, ctxElement);
        if (targetElement == null) return null;
        return targetElement.getMember(propertyAccessExpr.property.text);
      default:
        return null;
    }
  }
}
