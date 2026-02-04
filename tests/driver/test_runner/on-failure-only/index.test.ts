import { test, expect } from "warpo/test";

test("failure on test", () => {
  expect(1 + 1).equal(3);
});

test("success on test", () => {
  expect(1 + 1).equal(2);
});
