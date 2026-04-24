import assert from "node:assert/strict";
import { before, describe, it } from "node:test";
import { resolveClassLayouts } from "../src/classResolver.js";
import type { ClassLayout } from "../src/types.js";
import { CLASS_PREFIX, describeIntegration } from "./testHelper.js";

describeIntegration("class-resolver", (ctx) => {
  let classes: ClassLayout[];
  let classMap: Map<string, ClassLayout>;

  before(() => {
    ctx.compileFixture();
    classes = resolveClassLayouts(ctx.loadFixtureWasm());
    classMap = new Map(classes.map((c) => [c.name, c]));
  });

  it("contains user-defined classes", () => {
    const userClasses = ["Vector2", "Item", "Entity", "Character", "Player", "NPC", "TreeNode", "ListNode", "KVPair"];
    for (const name of userClasses) {
      assert.ok(classMap.has(CLASS_PREFIX + name), `missing class ${name}`);
    }
  });

  it("contains stdlib classes with rtid", () => {
    assert.ok(classMap.has("~lib/string/String"));
    assert.ok(classMap.has("~lib/arraybuffer/ArrayBuffer"));
  });

  it("every class has a numeric rtid", () => {
    for (const cls of classes) {
      assert.strictEqual(typeof cls.rtid, "number");
    }
  });

  it("non-zero rtIds are unique", () => {
    const nonZeroRtIds = classes.filter((c) => c.rtid !== 0).map((c) => c.rtid);
    assert.strictEqual(new Set(nonZeroRtIds).size, nonZeroRtIds.length);
  });

  describe("Vector2 layout", () => {
    it("has two f32 fields at correct offsets", () => {
      const vec2 = classMap.get(CLASS_PREFIX + "Vector2");
      assert.strictEqual(vec2.fields.length, 2);

      const x = vec2.fields.find((f) => f.name === "x");
      assert.strictEqual(x.offset, 0);
      assert.strictEqual(x.size, 4);
      assert.strictEqual(x.isReference, false);

      const y = vec2.fields.find((f) => f.name === "y");
      assert.strictEqual(y.offset, 4);
      assert.strictEqual(y.size, 4);
      assert.strictEqual(y.isReference, false);
    });
  });

  describe("Character layout", () => {
    it("has own fields (DWARF does not emit inherited fields)", () => {
      const character = classMap.get(CLASS_PREFIX + "Character");
      const fieldNames = new Set(character.fields.map((f) => f.name));
      assert.ok(fieldNames.has("name"));
      assert.ok(fieldNames.has("hp"));
    });

    it("name field is a reference", () => {
      const character = classMap.get(CLASS_PREFIX + "Character");
      const name = character.fields.find((f) => f.name === "name");
      assert.strictEqual(name.isReference, true);
    });

    it("hp field is not a reference", () => {
      const character = classMap.get(CLASS_PREFIX + "Character");
      const hp = character.fields.find((f) => f.name === "hp");
      assert.strictEqual(hp.isReference, false);
    });
  });

  describe("TreeNode layout", () => {
    it("has self-referencing fields", () => {
      const treeNode = classMap.get(CLASS_PREFIX + "TreeNode");
      const left = treeNode.fields.find((f) => f.name === "left");
      const right = treeNode.fields.find((f) => f.name === "right");
      assert.strictEqual(left.isReference, true);
      assert.strictEqual(right.isReference, true);
    });
  });

  describe("template types", () => {
    it("resolves template type for Array<Item>", () => {
      const arrayItem = classes.find((c) => c.name === `~lib/array/Array<${CLASS_PREFIX}Item>`);
      if (arrayItem) {
        assert.notStrictEqual(arrayItem.templateType, undefined);
      }
    });
  });

  it("excludes classes without rtid", () => {
    for (const cls of classes) {
      assert.notStrictEqual(cls.rtid, undefined);
    }
  });
});
