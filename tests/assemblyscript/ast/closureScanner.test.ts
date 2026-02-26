import { describe, expect, test } from "warpo/test";

import { ClosureScanner } from "../../../assemblyscript/src/ast/closureScanner";
import { Parser } from "../../../assemblyscript/src/parser";

describe("closureScanner", () => {
  test("prints variable statement", () => {
    const sourceCode = `
        export function outer():i32 {
            let a = 1;
            let b = 2;
            function inner():i32 {
                let b = a + 1;
                return b;
            }
            return inner() + b;
        }
    `;
    const parser = new Parser();
    parser.parseFile(sourceCode, "closureScanner.test.ts", false);
    const closureScanner = new ClosureScanner();
    assert(parser.sources.length > 0, "Parser should have at least one source");
    parser.sources[0].accept(closureScanner);
    expect(closureScanner.closureFunctions.size).equal(2);
    for (let keys = closureScanner.closureFunctions.keys(), j = 0, k = keys.length; j < k; j++) {
      const func = keys[j];
      const capturedVars = closureScanner.closureFunctions.get(func);
      if (func.name.text === "inner") {
        expect(capturedVars.size).equal(0);
      } else if (func.name.text === "outer") {
        expect(capturedVars.size).equal(1);
      } else {
        assert(false, `Unexpected function name: ${func.name.text}`);
      }
    }
  });
});
