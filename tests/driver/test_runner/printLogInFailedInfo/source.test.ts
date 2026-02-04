import { test, expect } from "warpo/test";
import { log } from "./env";

test("failed test", () => {
  log("This is a log message for the failed test.");
  expect(1 + 1).equal(3);
});

test("succeed test", () => {
  log("This is a log message for the succeed test.");
  expect(1 + 1).equal(2);
});
