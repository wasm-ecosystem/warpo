// @ts-nocheck

import { describe, expect, test } from "warpo/test";
import { importedValue } from "./debugger_import";

describe("debugger import", () => {
  test("calls the injected import", () => {
    expect(importedValue()).equal(42);
  });
});
