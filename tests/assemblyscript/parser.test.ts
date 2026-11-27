import { describe, expect, test } from "warpo/test";
import {
  AssertionExpression,
  BinaryExpression,
  CallExpression,
  ElementAccessExpression,
  Expression,
  ExpressionStatement,
  NodeKind,
  OptionalChainExpression,
  ParenthesizedExpression,
  PropertyAccessExpression,
  Source,
  SourceKind,
} from "../../assemblyscript/src/ast";
import { DiagnosticCode } from "../../assemblyscript/src/diagnostics";
import { Parser } from "../../assemblyscript/src/parser";
import { Token, Tokenizer } from "../../assemblyscript/src/tokenizer";

function parseExpression(text: string): Expression {
  let parser = new Parser();
  parser.parseFile(text, "test.ts", false);
  expect(parser.diagnostics.length).equal(0);
  let statement = parser.sources[0].statements[0];
  assert(statement instanceof ExpressionStatement);
  return (<ExpressionStatement>statement).expression;
}

function parseOptionalChain(text: string): OptionalChainExpression {
  let expression = parseExpression(text);
  assert(expression instanceof OptionalChainExpression);
  return <OptionalChainExpression>expression;
}

describe("optional-chain syntax", () => {
  test("tokenizes ?. without consuming conditional decimal literals or separated punctuation", () => {
    let tn = new Tokenizer(new Source(SourceKind.User, "test.ts", "?. ?.0 ?.9 ? ."));
    expect(tn.next()).equal(Token.Question_Dot);
    expect(tn.range().toString()).equal("?.");
    expect(tn.next()).equal(Token.Question);
    expect(tn.next()).equal(Token.FloatLiteral);
    expect(tn.readFloat()).equal(0.0);
    expect(tn.next()).equal(Token.Question);
    expect(tn.next()).equal(Token.FloatLiteral);
    expect(tn.readFloat()).equal(0.9);
    expect(tn.next()).equal(Token.Question);
    expect(tn.next()).equal(Token.Dot);
    expect(tn.next()).equal(Token.EndOfFile);
    expect(tn.diagnostics.length).equal(0);
  });

  test("keeps optional and ordinary property links in one chain", () => {
    let outer = parseOptionalChain("a?.b.c;").expression;
    assert(outer instanceof PropertyAccessExpression);
    expect((<PropertyAccessExpression>outer).isOptional).equal(false);
    let inner = (<PropertyAccessExpression>outer).expression;
    assert(inner instanceof PropertyAccessExpression);
    expect((<PropertyAccessExpression>inner).isOptional).equal(true);
    expect(assert((<PropertyAccessExpression>inner).questionDotRange).toString()).equal("?.");
  });

  test("keeps ordinary indexing inside a property chain", () => {
    let expression = parseOptionalChain("a?.b[i];").expression;
    assert(expression instanceof ElementAccessExpression);
    expect((<ElementAccessExpression>expression).expression.kind).equal(NodeKind.PropertyAccess);
    expect((<ElementAccessExpression>expression).elementExpression.range.toString()).equal("i");
  });

  test("keeps ordinary calls inside a property chain", () => {
    let expression = parseOptionalChain("a?.b<Ref>(arg);").expression;
    assert(expression instanceof CallExpression);
    let call = <CallExpression>expression;
    expect(call.expression.kind).equal(NodeKind.PropertyAccess);
    expect(assert(call.typeArguments)[0].range.toString()).equal("Ref");
    expect(call.args[0].range.toString()).equal("arg");
    let direct = parseOptionalChain("a?.b();").expression;
    assert(direct instanceof CallExpression);
    expect((<CallExpression>direct).typeArguments === null).equal(true);
  });

  test("ends a chain at parentheses", () => {
    let outer = parseExpression("(a?.b).c;");
    assert(outer instanceof PropertyAccessExpression);
    let receiver = (<PropertyAccessExpression>outer).expression;
    assert(receiver instanceof ParenthesizedExpression);
    expect((<ParenthesizedExpression>receiver).expression.kind).equal(NodeKind.OptionalChain);
  });

  test("closes boundaries before operators but not non-null assertions", () => {
    let expression = parseExpression("a?.b + c;");
    assert(expression instanceof BinaryExpression);
    expect((<BinaryExpression>expression).left.kind).equal(NodeKind.OptionalChain);
    let assertion = parseOptionalChain("a?.b!;").expression;
    assert(assertion instanceof AssertionExpression);
    expect((<AssertionExpression>assertion).expression.kind).equal(NodeKind.PropertyAccess);
  });

  test("rejects optional-chain update targets without rejecting ordinary outer accesses", () => {
    let cases = ["a?.b++;", "++a?.b;"];
    for (let i = 0; i < cases.length; ++i) {
      let parser = new Parser();
      parser.parseFile(cases[i], "test.ts", false);
      expect(parser.diagnostics[0].code).equal(
        DiagnosticCode.The_operand_of_an_increment_or_decrement_operator_must_be_a_variable_or_a_property_access
      );
    }
    expect(parseExpression("(a?.b).c++;").kind).equal(NodeKind.UnaryPostfix);
  });

  test("requires a property name after ?.", () => {
    let cases = ["a?.;", "a?.[i];", "a?.();", "a?.<Ref>();"];
    for (let i = 0; i < cases.length; ++i) {
      let parser = new Parser();
      parser.parseFile(cases[i], "test.ts", false);
      expect(parser.diagnostics[0].code).equal(DiagnosticCode.Identifier_expected);
    }
  });
});
