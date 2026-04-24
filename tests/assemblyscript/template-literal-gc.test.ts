import { describe, expect, test } from "warpo/test";

describe("template literal gc safety", () => {
    test("template literal with 3+ expressions produces correct result", () => {
        for (let i = 0; i < 100; i++) {
            let result = `a${i}b${i + 1}c${i + 2}`;
            let expected = "a" + i.toString() + "b" + (i + 1).toString() + "c" + (i + 2).toString();
            expect(result).equal(expected);
        }
    });
});
