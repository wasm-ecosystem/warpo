import { describe, expect, test } from "warpo/test";

import { ClosureScanner } from "../../../assemblyscript/src/ast/closureScanner";
import { Parser } from "../../../assemblyscript/src/parser";
import {
  DoStatement,
  ForOfStatement,
  ForStatement,
  FunctionDeclaration,
  MethodDeclaration,
  Node,
  WhileStatement,
} from "../../../assemblyscript/src/ast";

function getNodeName(node: Node): string {
  if (node instanceof FunctionDeclaration) return (<FunctionDeclaration>node).name.text;
  if (node instanceof MethodDeclaration) return (<MethodDeclaration>node).name.getReadableName();
  if (node instanceof ForStatement) return "<for>";
  if (node instanceof ForOfStatement) return "<for-of>";
  if (node instanceof WhileStatement) return "<while>";
  if (node instanceof DoStatement) return "<do>";
  return "";
}

function makeScanner(sourceCode: string): ClosureScanner {
  const parser = new Parser();
  parser.parseFile(sourceCode, "test.ts", false);
  assert(parser.sources.length > 0, "Parser should have at least one source");
  const closureScanner = new ClosureScanner();
  parser.sources[0].accept(closureScanner);
  return closureScanner;
}

describe("closureScanner", () => {
  test("basic closure: inner captures outer variable", () => {
    const scanner = makeScanner(`
      export function outer():i32 {
          let a = 1;
          let b = 2;
          function inner():i32 {
              let b = a + 1;
              return b;
          }
          return inner() + b;
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected function name: ${name}`);
      }
    }
  });

  test("no closure: function without nested functions", () => {
    const scanner = makeScanner(`
      export function standalone(): i32 {
          let a = 1;
          return a;
      }
    `);
    expect(scanner.closureFunctions.size).equal(0);
  });

  test("multiple variables captured", () => {
    const scanner = makeScanner(`
      export function outer(): i32 {
          let a = 1;
          let b = 2;
          function inner(): i32 {
              return a + b;
          }
          return inner();
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "outer") {
        expect(info.closureVariables.size).equal(2);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected function name: ${name}`);
      }
    }
  });

  test("only the capturing inner function is a closure", () => {
    const scanner = makeScanner(`
      export function outer(): i32 {
          let a = 1;
          function capturing(): i32 {
              return a;
          }
          function nonCapturing(): i32 {
              return 42;
          }
          return capturing() + nonCapturing();
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      assert(name === "outer" || name === "capturing", `Unexpected closure function: ${name}`);
      const info = scanner.closureFunctions.get(func);
      if (name === "capturing") {
        expect(info.nestedLevel).equal(1);
      } else if (name === "outer") {
        expect(info.nestedLevel).equal(0);
      }
    }
  });

  test("deep nesting: middle function is also a closure", () => {
    const scanner = makeScanner(`
        export function outer(): i32 {
            let a = 1;
            function middle(): i32 {
                function inner(): i32 {
                    return a;
                }
                return inner();
            }
            return middle();
        }
      `);
    // outer provides 'a', middle and inner both transitively depend on it
    expect(scanner.closureFunctions.size).equal(3);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else if (name === "middle") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(2);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure inside if block", () => {
    const scanner = makeScanner(`
      export function outer(cond: bool): i32 {
          if (cond) {
              let a = 0;
              function inner(): i32 {
                  return a;
              }
              return inner();
          }
          return 0;
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure in both if and else branches", () => {
    const scanner = makeScanner(`
      export function outer(cond: bool): i32 {
          if (cond) {
              let a = 1;
              function innerIf(): i32 {
                  return a;
              }
              return innerIf();
          } else {
              let b = 2;
              function innerElse(): i32 {
                  return b;
              }
              return innerElse();
          }
      }
    `);
    // innerIf, innerElse, and outer are all closures
    expect(scanner.closureFunctions.size).equal(3);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "innerIf" || name === "innerElse") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "outer") {
        // outer captures both a (from if branch) and b (from else branch)
        expect(info.closureVariables.size).equal(2);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure inside switch case", () => {
    const scanner = makeScanner(`
      export function outer(x: i32): i32 {
          switch (x) {
              case 0:
                  let a = 1;
                  function inner(): i32 {
                      return a;
                  }
                  return inner();
          }
          return 0;
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure inside for loop", () => {
    const scanner = makeScanner(`
      export function outer(): void {
          for (let i = 0; i < 10; i++) {
              function inner(): i32 {
                  return i;
              }
              inner();
          }
      }
    `);
    // chain: outer(0) -> <for>(1) -> inner(2)
    // i is declared in the for loop scope; inner crosses a function boundary to access it
    // outer is NOT a closure (no function boundary crossed from its perspective)
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(2);
      } else if (name === "<for>") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(1);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure captures variable declared in for body", () => {
    const scanner = makeScanner(`
      export function outer(): void {
          for (let i = 0; i < 10; i++) {
              let x = i * 2;
              function inner(): i32 {
                  return x;
              }
              inner();
          }
      }
    `);
    // chain: outer(0) -> <for>(1) -> inner(2)
    // x is in for's block scope; inner crosses function boundary
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(2);
      } else if (name === "<for>") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(1);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure inside while loop", () => {
    const scanner = makeScanner(`
      export function outer(): void {
          let i = 0;
          while (i < 10) {
              function inner(): i32 {
                  return i;
              }
              inner();
              i++;
          }
      }
    `);
    // chain: outer(0) -> <while>(1) -> inner(2)
    // i is declared in outer, not in the while scope
    expect(scanner.closureFunctions.size).equal(3);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(2);
      } else if (name === "<while>") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure inside do-while loop", () => {
    const scanner = makeScanner(`
      export function outer(): void {
          do {
              let x = 1;
              function inner(): i32 {
                  return x;
              }
              inner();
          } while (true);
      }
    `);
    // chain: outer(0) -> <do>(1) -> inner(2)
    // x is in the do scope; inner crosses function boundary
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(2);
      } else if (name === "<do>") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(1);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure inside for-of loop", () => {
    const scanner = makeScanner(`
      export function outer(arr: i32[]): void {
          for (let v of arr) {
              function inner(): i32 {
                  return v;
              }
              inner();
          }
      }
    `);
    // chain: outer(0) -> <for-of>(1) -> inner(2)
    // v is in the for-of scope; inner crosses function boundary
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(2);
      } else if (name === "<for-of>") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(1);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure captures function parameter", () => {
    const scanner = makeScanner(`
      export function outer(a: i32): i32 {
          function inner(): i32 {
              return a;
          }
          return inner();
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "outer") {
        // outer's parameter 'a' is captured by inner
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("no closure: parameter shadowed by inner declaration", () => {
    const scanner = makeScanner(`
      export function outer(a: i32): i32 {
          function inner(): i32 {
              let a = 99;
              return a;
          }
          return inner();
      }
    `);
    expect(scanner.closureFunctions.size).equal(0);
  });

  test("no closure: type alias name should not be treated as variable reference", () => {
    const scanner = makeScanner(`
      export function outer(): void {
          let alias: i32 = 1;
          function inner(): void {
              type alias = f64;
              let alias: alias = 1;
          }
          inner();
      }
    `);
    expect(scanner.closureFunctions.size).equal(0);
  });

  test("closure: inner function in class method captures method variable", () => {
    const scanner = makeScanner(`
      export class Foo {
          bar(): i32 {
              let a = 1;
              function inner(): i32 {
                  return a;
              }
              return inner();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "bar") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure: inner function in class method captures method parameter", () => {
    const scanner = makeScanner(`
      export class Foo {
          bar(a: i32): i32 {
              function inner(): i32 {
                  return a;
              }
              return inner();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "bar") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure: inner function in getter captures getter variable", () => {
    const scanner = makeScanner(`
      export class Foo {
          get value(): i32 {
              let a = 1;
              function inner(): i32 {
                  return a;
              }
              return inner();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "value") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure: inner function in setter captures setter parameter", () => {
    const scanner = makeScanner(`
      export class Foo {
          _v: i32 = 0;
          set value(v: i32) {
              function getV(): i32 {
                  return v;
              }
              this._v = getV();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "getV") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "value") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure: inner function in constructor captures constructor variable", () => {
    const scanner = makeScanner(`
      export class Foo {
          x: i32;
          constructor(a: i32) {
              let b = a + 1;
              function init(): i32 {
                  return b;
              }
              this.x = init();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "init") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "constructor") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("no closure: inner function in class method does not capture", () => {
    const scanner = makeScanner(`
      export class Foo {
          bar(): i32 {
              let a = 1;
              function inner(): i32 {
                  return 42;
              }
              return inner() + a;
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(0);
  });

  test("closure: arrow function in method captures this", () => {
    const scanner = makeScanner(`
      export class Foo {
          x: i32 = 0;
          bar(): i32 {
              let inner = (): i32 => {
                  return this.x;
              }
              return inner();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "") {
        expect(info.capturesThis).equal(false);
        expect(info.nestedLevel).equal(1);
      } else if (name === "bar") {
        expect(info.capturesThis).equal(true);
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure: inner function captures both this and variable", () => {
    const scanner = makeScanner(`
      export class Foo {
          x: i32 = 0;
          bar(): i32 {
              let a = 1;
              let inner = (): i32 => {
                  return this.x + a;
              }
              return inner();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "") {
        expect(info.capturesThis).equal(false);
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (name === "bar") {
        expect(info.capturesThis).equal(true);
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("no closure: this used in own method scope", () => {
    const scanner = makeScanner(`
      export class Foo {
          x: i32 = 0;
          bar(): i32 {
              return this.x;
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(0);
  });

  test("no capturesThis: closure in static method does not capture this", () => {
    const scanner = makeScanner(`
      export class Foo {
          static bar(): i32 {
              let a = 1;
              let inner = (): i32 => {
                  return a;
              }
              return inner();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      expect(info.capturesThis).equal(false);
    }
  });

  test("closure: deep nesting captures this", () => {
    const scanner = makeScanner(`
      export class Foo {
          x: i32 = 0;
          bar(): i32 {
              let middle = (): i32 => {
                  let inner = (): i32 => {
                      return this.x;
                  }
                  return inner();
              }
              return middle();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(3);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "bar") {
        expect(info.capturesThis).equal(true);
        expect(info.nestedLevel).equal(0);
      } else if (info.nestedLevel === 1) {
        expect(info.capturesThis).equal(false);
      } else if (info.nestedLevel === 2) {
        expect(info.capturesThis).equal(false);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure: constructor arrow function captures this", () => {
    const scanner = makeScanner(`
      export class Foo {
          x: i32;
          constructor() {
              let init = (): void => {
                  this.x = 42;
              }
              init();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "") {
        expect(info.capturesThis).equal(false);
        expect(info.nestedLevel).equal(1);
      } else if (name === "constructor") {
        expect(info.capturesThis).equal(true);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${name}`);
      }
    }
  });

  test("closure: static method arrow captures this", () => {
    const scanner = makeScanner(`
      export class Foo {
          static bar: i32 = 42;
          static getBar(): i32 {
              let inner = (): i32 => {
                  return this.bar;
              };
              return inner();
          }
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const name = getNodeName(func);
      const info = scanner.closureFunctions.get(func);
      if (name === "getBar") {
        // Static method that has a captured-this arrow: it IS a closure owner
        expect(info.capturesThis).equal(true);
        expect(info.nestedLevel).equal(0);
      } else {
        // The arrow itself does not directly capture this (it's propagated to getBar)
        expect(info.capturesThis).equal(false);
        expect(info.nestedLevel).equal(1);
      }
    }
  });

  test("no capturesThis: arrow function in standalone function", () => {
    const scanner = makeScanner(`
      export function outer(): i32 {
          let a = 1;
          let inner = (): i32 => {
              return a;
          }
          return inner();
      }
    `);
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      expect(info.capturesThis).equal(false);
    }
  });

  test("function type param name should not shadow captured variable", () => {
    const scanner = makeScanner(`
      function run(cb: (fn: (value: Object) => void) => void): void {
        cb((v: Object): void => {});
      }
      function make<U>(value: U): void {
        run((fn: (value: Object) => void) => { fn(value); });
      }
    `);
    // make should be a closure function because the arrow captures `value`
    let found = false;
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      const name = getNodeName(func);
      if (name === "make") {
        expect(info.closureVariables.size).equal(1);
        found = true;
      }
    }
    expect(found).equal(true);
  });
});
