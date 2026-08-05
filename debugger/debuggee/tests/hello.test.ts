import { describe, expect, test } from "warpo/test";
import { main } from "../hello";

describe("test promise", () => {
  test("promise then", () => {
    const res = main();
    expect(res).equal(11193);
  });
});
