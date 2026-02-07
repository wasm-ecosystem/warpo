import { describe, expect, test } from "warpo/test";

import {
  BinaryExpression,
  IntegerLiteralExpression,
  ParenthesizedExpression,
  Source,
  SourceKind,
  UnaryPrefixExpression,
} from "../../assemblyscript/src/ast";
import { Range } from "../../assemblyscript/src/diagnostics";
import { Evaluator } from "../../assemblyscript/src/eval";
import { Token } from "../../assemblyscript/src/tokenizer";

function makeRange(source: Source): Range {
  let range = new Range(0, 0);
  range.source = source;
  return range;
}

describe("evaluator", () => {
  test("integer literal", () => {
    let source = new Source(SourceKind.User, "eval.test.ts", "");
    let range = makeRange(source);
    let expr = new IntegerLiteralExpression(5, range);

    let ret = new Evaluator(expr).evalI32();
    expect(ret.success).equal(true);
    expect(ret.value).equal(5);
  });

  test("parenthesized", () => {
    let source = new Source(SourceKind.User, "eval.test.ts", "");
    let range = makeRange(source);
    let expr = new ParenthesizedExpression(new IntegerLiteralExpression(7, range), range);

    let ret = new Evaluator(expr).evalI32();
    expect(ret.success).equal(true);
    expect(ret.value).equal(7);
  });

  test("unary minus", () => {
    let source = new Source(SourceKind.User, "eval.test.ts", "");
    let range = makeRange(source);
    let expr = new UnaryPrefixExpression(Token.Minus, new IntegerLiteralExpression(1, range), range);

    let ret = new Evaluator(expr).evalI32();
    expect(ret.success).equal(true);
    expect(ret.value).equal(-1);
  });

  test("binary plus", () => {
    let source = new Source(SourceKind.User, "eval.test.ts", "");
    let range = makeRange(source);
    let expr = new BinaryExpression(
      Token.Plus,
      new IntegerLiteralExpression(1, range),
      new IntegerLiteralExpression(2, range),
      range
    );

    let ret = new Evaluator(expr).evalI32();
    expect(ret.success).equal(true);
    expect(ret.value).equal(3);
  });

  test("shift", () => {
    let source = new Source(SourceKind.User, "eval.test.ts", "");
    let range = makeRange(source);
    let expr = new BinaryExpression(
      Token.LessThan_LessThan,
      new IntegerLiteralExpression(1, range),
      new IntegerLiteralExpression(2, range),
      range
    );

    let ret = new Evaluator(expr).evalI32();
    expect(ret.success).equal(true);
    expect(ret.value).equal(4);
  });

  test("division by zero fails", () => {
    let source = new Source(SourceKind.User, "eval.test.ts", "");
    let range = makeRange(source);
    let expr = new BinaryExpression(
      Token.Slash,
      new IntegerLiteralExpression(1, range),
      new IntegerLiteralExpression(0, range),
      range
    );

    let ret = new Evaluator(expr).evalI32();
    expect(ret.success).equal(false);
  });
});
