// @ts-nocheck

import { describe, expect, test } from "warpo/test";
import { main } from "./unittest_debug";

let excludedTestRan = false;

describe("debugger unit test", () => {
  test("excluded test", () => {
    excludedTestRan = true;
  });

  test("runs main before asserting", () => {
    expect(excludedTestRan).equal(false);
    const result = main();
    expect(result).equal(42);
  });
});
