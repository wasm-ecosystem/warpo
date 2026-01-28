import { describe, expect, test } from "../../../../warpo_extension/std/warpo/test";

class Base {}
class Ext_0 extends Base {}
class Ext_0_0 extends Ext_0 {}
class Ext_0_0_0 extends Ext_0 {}
class Ext_1 extends Base {}
class Ext_1_1 extends Ext_1 {}

describe("expect", () => {
  test("< = >", () => {
    expect(1).greaterThan(0);
    expect(1).greaterThanOrEqual(0);
    expect(1).greaterThanOrEqual(1);
    expect(1).lessThan(2);
    expect(1).lessThanOrEqual(2);
    expect(1).lessThanOrEqual(1);
  });
  test("null", () => {
    expect<string | null>(null).isNull();
    expect<string | null>("test").notNull();
  });
  test("not", () => {
    expect(1).not.equal(2);
  });
  test("isa", () => {
    let ext: Base = new Ext_0_0();
    expect(ext).isa<Base>();
    expect(ext).isa<Ext_0>();
    expect(ext).isa<Ext_0_0>();
    expect(ext).not.isa<Ext_0_0_0>();
    expect(ext).not.isa<Ext_1>();
    expect(ext).not.isa<Ext_1_1>();
  });
  test("isExactly", () => {
    let ext: Base = new Ext_0_0();
    expect(ext).isExactly<Ext_0_0>();
    expect(ext).not.isExactly<Base>();
    expect(ext).not.isExactly<Ext_0>();
    expect(ext).not.isExactly<Ext_0_0_0>();
  });
  test("nullable isExactly", () => {
    let extNull: Base | null = null;
    let extNonNull: Base | null = new Base();
    expect(extNull).not.isExactly<Base>();
    expect(extNonNull).isExactly<Base>();
  });
});
