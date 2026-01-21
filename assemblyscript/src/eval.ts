import {
  AssertionExpression,
  BinaryExpression,
  CommaExpression,
  Expression,
  IntegerLiteralExpression,
  LiteralExpression,
  LiteralKind,
  NodeKind,
  ParenthesizedExpression,
  UnaryPrefixExpression,
} from "./ast";
import { Token } from "./tokenizer";

export class EvalResult<T> {
  constructor(
    public value: T,
    public success: bool
  ) {}
}

export class Evaluator {
  constructor(private expr: Expression) {}

  evalI32(): EvalResult<i32> {
    return this.evalExprI32(this.expr);
  }

  private evalExprI32(expr: Expression): EvalResult<i32> {
    switch (expr.kind) {
      case NodeKind.Parenthesized: {
        return this.evalExprI32((expr as ParenthesizedExpression).expression);
      }
      case NodeKind.Assertion: {
        // For the purposes of compile-time evaluation, assertions do not affect the value.
        return this.evalExprI32((expr as AssertionExpression).expression);
      }
      case NodeKind.Comma: {
        let expressions = (expr as CommaExpression).expressions;
        let len = expressions.length;
        if (!len) return new EvalResult<i32>(0, false);
        return this.evalExprI32(expressions[len - 1]);
      }
      case NodeKind.Literal: {
        let lit = expr as LiteralExpression;
        if (lit.literalKind != LiteralKind.Integer) return new EvalResult<i32>(0, false);
        let value = (expr as IntegerLiteralExpression).value;
        if (value < i64_new(i32.MIN_VALUE, -1) || value > i64_new(i32.MAX_VALUE)) return new EvalResult<i32>(0, false);
        return new EvalResult<i32>(i64_low(value), true);
      }
      case NodeKind.UnaryPrefix: {
        let unary = expr as UnaryPrefixExpression;
        let operand = this.evalExprI32(unary.operand);
        if (!operand.success) return operand;
        switch (unary.operator) {
          case Token.Plus:
            return operand;
          case Token.Minus:
            return new EvalResult<i32>(0 - operand.value, true);
          case Token.Tilde:
            return new EvalResult<i32>(~operand.value, true);
          default:
            return new EvalResult<i32>(0, false);
        }
      }
      case NodeKind.Binary: {
        let bin = expr as BinaryExpression;
        let left = this.evalExprI32(bin.left);
        if (!left.success) return left;
        let right = this.evalExprI32(bin.right);
        if (!right.success) return right;
        let l = left.value;
        let r = right.value;
        switch (bin.operator) {
          case Token.Plus:
            return new EvalResult<i32>(l + r, true);
          case Token.Minus:
            return new EvalResult<i32>(l - r, true);
          case Token.Asterisk:
            return new EvalResult<i32>(l * r, true);
          case Token.Slash:
            if (r == 0) return new EvalResult<i32>(0, false); // divide by zero
            if (r == -1 && l == i32.MIN_VALUE) return new EvalResult<i32>(0, false); // overflow
            return new EvalResult<i32>(l / r, true);
          case Token.Percent:
            if (r == 0) return new EvalResult<i32>(0, false); // divide by zero
            if (r == -1 && l == i32.MIN_VALUE) return new EvalResult<i32>(0, false); // overflow
            return new EvalResult<i32>(l % r, true);
          case Token.Ampersand:
            return new EvalResult<i32>(l & r, true);
          case Token.Bar:
            return new EvalResult<i32>(l | r, true);
          case Token.Caret:
            return new EvalResult<i32>(l ^ r, true);
          case Token.LessThan_LessThan: {
            let shift = r & 31;
            return new EvalResult<i32>(l << shift, true);
          }
          case Token.GreaterThan_GreaterThan: {
            let shift = r & 31;
            return new EvalResult<i32>(l >> shift, true);
          }
          case Token.GreaterThan_GreaterThan_GreaterThan: {
            let shift = <u32>(r & 31);
            return new EvalResult<i32>(<i32>((<u32>l) >>> shift), true);
          }
          default:
            return new EvalResult<i32>(0, false);
        }
      }
      default:
        return new EvalResult<i32>(0, false);
    }
  }
}
