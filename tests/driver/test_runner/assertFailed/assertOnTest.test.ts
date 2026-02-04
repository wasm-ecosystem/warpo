import { test } from "warpo/test";

test("assert on test", () => {
  trace("this test will fail due to an assertion error");
  assert(false, "this assertion is expected to fail");
});
