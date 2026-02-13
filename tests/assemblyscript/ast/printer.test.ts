import { describe, expect, test } from "warpo/test";

import { CommonFlags } from "../../../assemblyscript/src/common";
import { Range } from "../../../assemblyscript/src/diagnostics";
import { Token } from "../../../assemblyscript/src/tokenizer";
import {
  ArrowKind,
  BinaryExpression,
  BlockStatement,
  ClassDeclaration,
  ConstructorExpression,
  ExpressionStatement,
  FieldDeclaration,
  FunctionDeclaration,
  FunctionTypeNode,
  IdentifierExpression,
  IntegerLiteralExpression,
  MethodDeclaration,
  NamedTypeNode,
  Node,
  ParameterKind,
  ParameterNode,
  PropertyAccessExpression,
  ReturnStatement,
  Source,
  SourceKind,
  ThisExpression,
  VariableDeclaration,
  VariableStatement,
} from "../../../assemblyscript/src/ast";
import { ASTPrinter } from "../../../assemblyscript/src/ast/printer";

function makeRange(source: Source): Range {
  let range = new Range(0, 0);
  range.source = source;
  return range;
}

function makeId(name: string, range: Range): IdentifierExpression {
  return Node.createIdentifierExpression(name, range);
}

function makeNamedType(name: string, range: Range): NamedTypeNode {
  return Node.createNamedType(Node.createSimpleTypeName(name, range), null, false, range);
}

describe("ASTPrinter", () => {
  test("prints variable statement", () => {
    let source = new Source(SourceKind.User, "printer.test.ts", "");
    let range = makeRange(source);
    let decl = new VariableDeclaration(
      makeId("x", range),
      null,
      CommonFlags.Const,
      makeNamedType("i32", range),
      new IntegerLiteralExpression(1, range),
      range
    );
    let stmt = new VariableStatement(null, [decl], range);

    source.statements.push(stmt);

    expect(ASTPrinter.build(source)).equal("const x: i32 = 1;\n");
  });

  test("prints function declaration", () => {
    let source = new Source(SourceKind.User, "printer.test.ts", "");
    let range = makeRange(source);
    let paramA = new ParameterNode(ParameterKind.Default, makeId("a", range), makeNamedType("i32", range), null, range);
    let paramB = new ParameterNode(ParameterKind.Default, makeId("b", range), makeNamedType("i32", range), null, range);
    let signature = new FunctionTypeNode([paramA, paramB], makeNamedType("i32", range), null, false, range);
    let body = new BlockStatement(
      [new ReturnStatement(new BinaryExpression(Token.Plus, makeId("a", range), makeId("b", range), range), range)],
      range
    );
    let decl = new FunctionDeclaration(
      makeId("add", range),
      null,
      CommonFlags.None,
      null,
      signature,
      body,
      ArrowKind.None,
      range
    );

    source.statements.push(decl);

    expect(ASTPrinter.build(source)).equal("function add(a: i32, b: i32): i32 {\n  return a + b;\n}\n");
  });

  test("prints class with field and constructor", () => {
    let source = new Source(SourceKind.User, "printer.test.ts", "");
    let range = makeRange(source);
    let field = new FieldDeclaration(
      makeId("x", range),
      null,
      CommonFlags.None,
      makeNamedType("i32", range),
      null,
      -1,
      range
    );
    let paramX = new ParameterNode(ParameterKind.Default, makeId("x", range), makeNamedType("i32", range), null, range);
    let constructorSignature = new FunctionTypeNode([paramX], Node.createOmittedType(range), null, false, range);
    let assignment = new BinaryExpression(
      Token.Equals,
      new PropertyAccessExpression(new ThisExpression(range), makeId("x", range), range),
      makeId("x", range),
      range
    );
    let constructorBody = new BlockStatement([new ExpressionStatement(assignment)], range);
    let constructorDecl = new MethodDeclaration(
      new ConstructorExpression(range),
      null,
      CommonFlags.Constructor,
      null,
      constructorSignature,
      constructorBody,
      range
    );
    let classDecl = new ClassDeclaration(
      makeId("Point", range),
      null,
      CommonFlags.None,
      null,
      null,
      null,
      [field, constructorDecl],
      range
    );

    source.statements.push(classDecl);

    expect(ASTPrinter.build(source)).equal(
      "class Point {\n  x: i32;\n  constructor(x: i32) {\n    this.x = x;\n  }\n}\n"
    );
  });
});
