import { test, expect, describe, afterEach } from "warpo/test";

let teardown0 = 0;
let teardown1 = 0;
describe("teardown", () => {
  afterEach(() => {
    teardown0 = 10;
    teardown1 = 20;
  });
  test("1st", () => {
    expect(teardown0).equal(0);
    expect(teardown1).equal(0);
    teardown0 = 100;
    teardown1 = 200;
  });
  test("2nd", () => {
    expect(teardown0).equal(10);
    expect(teardown1).equal(20);
    teardown0 = 100;
    teardown1 = 200;
  });
  test("3ed", () => {
    expect(teardown0).equal(10);
    expect(teardown1).equal(20);
  });
});
