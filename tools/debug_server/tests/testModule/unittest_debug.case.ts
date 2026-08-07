// @ts-nocheck

import { describe, expect, test } from "warpo/test";
import { main } from "./unittest_debug";

describe("debugger unit test", () => {
  test("runs main before asserting", () => {
    const result = main();
    expect(result).equal(42);
  });
});
