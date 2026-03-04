import { describe, expect, test } from "warpo/test";

import { ClosureScanner } from "../../../assemblyscript/src/ast/closureScanner";
import { Parser } from "../../../assemblyscript/src/parser";

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
      if (func.name.text === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (func.name.text === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected function name: ${func.name.text}`);
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
      if (func.name.text === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (func.name.text === "outer") {
        expect(info.closureVariables.size).equal(2);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected function name: ${func.name.text}`);
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
      const name = func.name.text;
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
      const name = func.name.text;
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
      if (func.name.text === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (func.name.text === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${func.name.text}`);
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
      const name = func.name.text;
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
      if (func.name.text === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (func.name.text === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${func.name.text}`);
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
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      if (func.name.text === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (func.name.text === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${func.name.text}`);
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
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      if (func.name.text === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (func.name.text === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${func.name.text}`);
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
    expect(scanner.closureFunctions.size).equal(2);
    for (let keys = scanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const info = scanner.closureFunctions.get(func);
      if (func.name.text === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (func.name.text === "outer") {
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${func.name.text}`);
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
      if (func.name.text === "inner") {
        expect(info.closureVariables.size).equal(0);
        expect(info.nestedLevel).equal(1);
      } else if (func.name.text === "outer") {
        // outer's parameter 'a' is captured by inner
        expect(info.closureVariables.size).equal(1);
        expect(info.nestedLevel).equal(0);
      } else {
        assert(false, `Unexpected closure function: ${func.name.text}`);
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
});
