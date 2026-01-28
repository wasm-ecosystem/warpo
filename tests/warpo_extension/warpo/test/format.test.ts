import { describe, expect, test } from "../../../../warpo_extension/std/warpo/test";
import { toJson } from "../../../../warpo_extension/std/warpo/test/formatPrint";

class A {}

describe("print", () => {
  test("array", () => {
    expect(toJson([1, 2, 3])).equal("[1, 2, 3]");
  });
  test("ArrayBuffer", () => {
    let a: Array<i32> = [1, 3];
    expect(toJson(changetype<ArrayBuffer>(a.dataStart))).equal("[1, 0, 0, 0, 3, 0, 0, 0]");
  });
  test("set", () => {
    const set = new Set<i32>();
    set.add(1).add(2).add(4);
    expect(toJson(set)).equal("[1, 2, 4]");
  });
  test("map", () => {
    const map = new Map<i32, string>();
    map.set(1, "aa").set(2, "bb").set(4, "cc");
    expect(toJson(map)).equal('{ 1 : "aa", 2 : "bb", 4 : "cc" }');
  });

  test("nullable", () => {
    const a: i32[] | null = null;
    expect(toJson(a)).equal("null");
  });

  test("bool", () => {
    expect(toJson(false)).equal("false");
    expect(toJson(true)).equal("true");
  });

  test("string", () => {
    expect(toJson("test")).equal('"test"');
  });
  test("unicode string", () => {
    expect(toJson("测试")).equal('"测试"');
  });
  test("normal control code", () => {
    expect(toJson("\0")).equal('"\\0"');
    expect(toJson("\b")).equal('"\\b"');
    expect(toJson("\t")).equal('"\\t"');
    expect(toJson("\n")).equal('"\\n"');
    expect(toJson("\v")).equal('"\\v"');
    expect(toJson("\f")).equal('"\\f"');
    expect(toJson("\r")).equal('"\\r"');
    expect(toJson('-"-')).equal('"-\\"-"');
    expect(toJson("\\")).equal('"\\\\"');
  });
  test("unknown control code", () => {
    expect(toJson("\u0001")).equal('"\\u0001"');
  });

  test("user defined class", () => {
    expect(toJson(new A())).equal("[Object A]");
  });
});
