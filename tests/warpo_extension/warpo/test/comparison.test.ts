import { describe, expect, test } from "../../../../warpo_extension/std/warpo/test";

describe("base type equal", () => {
  test("i32", () => {
    let a: i32 = 1;
    expect(a).equal(1);
  });
  test("i64", () => {
    let b: i64 = i64.MAX_VALUE;
    expect(b).equal(i64.MAX_VALUE);
    expect(b).notEqual(i64.MIN_VALUE);
  });
  test("f32", () => {
    let c: f32 = 2.5;
    expect(c).closeTo(2.5, 1e-5);
  });
  test("f64", () => {
    let d: f64 = 0.1 + 0.2;
    expect(d).closeTo(0.3, 1e-5);
  });
});

describe("single level container type equal", () => {
  test("string", () => {
    let a: string = "test";
    expect(a).equal("test");
  });
  test("3 bytes ArrayBuffer", () => {
    let a: Array<i8> = [1, 3, 5];
    let b = new ArrayBuffer(3);
    store<i8>(changetype<i32>(b), 1);
    store<i8>(changetype<i32>(b) + 1, 3);
    store<i8>(changetype<i32>(b) + 2, 5);
    expect(changetype<ArrayBuffer>(a.dataStart)).equal(b);
  });
  test("8 bytes ArrayBuffer", () => {
    let a: Array<i32> = [1, 3];
    let b = new ArrayBuffer(8);
    store<i32>(changetype<i32>(b), 1);
    store<i32>(changetype<i32>(b) + 4, 3);
    expect(changetype<ArrayBuffer>(a.dataStart)).equal(b);
  });
  test("array", () => {
    let b: Array<i32> = [1, 2, 3, 4];
    expect(b).equal([1, 2, 3, 4]);
    expect(b).notEqual([1, 2, 4, 3]);
    expect(b).notEqual([1, 2, 3]);
    expect(b).notEqual([1, 2, 3, 4, 5]);
  });
  test("TypedArray", () => {
    let c: Int32Array = new Int32Array(2);
    c[0] = 1;
    c[1] = 2;
    let c1: Int32Array = new Int32Array(2);
    c1[0] = 1;
    c1[1] = 2;
    expect(c).equal(c1);
  });
  test("StaticArray", () => {
    let d: StaticArray<f32> = new StaticArray(2);
    d[0] = 1.2;
    d[1] = 2.4;
    expect(d).equal(StaticArray.fromArray<f32>([1.2, 2.4]));
  });

  describe("Map", () => {
    test("normal", () => {
      let e: Map<i32, f32> = new Map();
      e.set(1, 1.5);
      e.set(2, 2.5);
      let e1: Map<i32, f32> = new Map();
      e1.set(1, 1.5);
      e1.set(2, 2.5);
      expect(e).equal(e1);
    });
    test("disorder", () => {
      let e: Map<i32, f32> = new Map();
      e.set(1, 1.5);
      e.set(2, 2.5);
      let e1: Map<i32, f32> = new Map();
      e1.set(2, 2.5);
      e1.set(1, 1.5);
      expect(e).equal(e1);
    });
    test("value not equal", () => {
      let e: Map<i32, f32> = new Map();
      e.set(1, 1.5);
      e.set(2, 2.5);
      let e1: Map<i32, f32> = new Map();
      e1.set(1, 1.6);
      e1.set(2, 2.6);
      expect(e).notEqual(e1);
    });
    test("key not equal", () => {
      let e: Map<i32, f32> = new Map();
      e.set(1, 1.5);
      e.set(2, 2.5);
      let e1: Map<i32, f32> = new Map();
      e1.set(1, 1.5);
      e1.set(3, 2.5);
      expect(e).notEqual(e1);
    });
    test("more context", () => {
      let e: Map<i32, f32> = new Map();
      e.set(1, 1.5);
      e.set(2, 2.5);
      let e1: Map<i32, f32> = new Map();
      e1.set(1, 1.5);
      e1.set(2, 2.5);
      e1.set(3, 3.5);
      expect(e).notEqual(e1);
    });
    test("less context", () => {
      let e: Map<i32, f32> = new Map();
      e.set(1, 1.5);
      e.set(2, 2.5);
      let e1: Map<i32, f32> = new Map();
      e1.set(1, 1.5);
      expect(e).notEqual(e1);
    });
  });

  describe("Set", () => {
    test("normal", () => {
      let a = new Set<i32>();
      a.add(10);
      let b = new Set<i32>();
      b.add(10);
      expect(a).equal(b);
    });
    test("not equal", () => {
      let a = new Set<i32>();
      a.add(10);
      let b = new Set<i32>();
      b.add(8);
      expect(a).notEqual(b);
    });
    test("more context", () => {
      let a = new Set<i32>();
      a.add(10);
      let b = new Set<i32>();
      b.add(10);
      b.add(11);
      expect(a).notEqual(b);
    });
    test("less context", () => {
      let a = new Set<i32>();
      a.add(11);
      a.add(10);
      let b = new Set<i32>();
      b.add(10);
      expect(a).notEqual(b);
    });
    test("disorder", () => {
      let a = new Set<i32>();
      a.add(11);
      a.add(10);
      let b = new Set<i32>();
      b.add(10);
      b.add(11);
      expect(a).equal(b);
    });
  });

  describe("nullable", () => {
    test("normal", () => {
      let a: i32[] | null = [1, 2];
      let b: i32[] = [1, 2];
      expect(a).equal(b);
      expect<i32[] | null>(a).notEqual(null);
    });
    test("nullable equal null", () => {
      let a: i32[] | null = null;
      let b: i32[] = [1, 2];
      expect<i32[] | null>(a).notEqual(b);
      expect<i32[] | null>(a).equal(null);
    });
    test("nullable equal normal", () => {});
  });
});

describe("multi-level container type equal", () => {
  test("multi-level nested container equality", () => {
    let arr = new Array<Map<i32, Set<f64>>>();
    for (let i = 0; i < 5; i++) {
      let map = new Map<i32, Set<f64>>();
      arr.push(map);
      for (let j = 0; j < 5; j++) {
        let set = new Set<f64>();
        map.set(j, set);
        for (let k = 0; k < 10; k++) {
          set.add(f64(k) * 1.25);
        }
      }
    }
    let arr2 = new Array<Map<i32, Set<f64>>>();
    for (let i = 0; i < 5; i++) {
      let map = new Map<i32, Set<f64>>();
      arr2.push(map);
      for (let j = 4; j >= 0; j--) {
        let set = new Set<f64>();
        map.set(j, set);
        for (let k = 9; k >= 0; k--) {
          set.add(f64(k) * 1.25);
        }
      }
    }
    expect(arr).equal(arr2);
  });
});
