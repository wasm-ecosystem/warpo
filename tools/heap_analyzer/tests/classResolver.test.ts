import { resolveClassLayouts } from "../src/classResolver.js";
import type { ClassLayout } from "../src/types.js";
import { CLASS_PREFIX, compileFixture, describeIntegration, loadFixtureWasm } from "./testHelper.js";

describeIntegration("class-resolver", () => {
  let classes: ClassLayout[];
  let classMap: Map<string, ClassLayout>;

  beforeAll(() => {
    compileFixture();
    classes = resolveClassLayouts(loadFixtureWasm());
    classMap = new Map(classes.map((c) => [c.name, c]));
  });

  it("contains user-defined classes", () => {
    const userClasses = ["Vector2", "Item", "Entity", "Character", "Player", "NPC", "TreeNode", "ListNode", "KVPair"];
    for (const name of userClasses) {
      expect(classMap.has(CLASS_PREFIX + name)).toBe(true);
    }
  });

  it("contains stdlib classes with rtid", () => {
    expect(classMap.has("~lib/string/String")).toBe(true);
    expect(classMap.has("~lib/arraybuffer/ArrayBuffer")).toBe(true);
  });

  it("every class has a numeric rtid", () => {
    for (const cls of classes) {
      expect(typeof cls.rtid).toBe("number");
    }
  });

  it("non-zero rtIds are unique", () => {
    const nonZeroRtIds = classes.filter((c) => c.rtid !== 0).map((c) => c.rtid);
    expect(new Set(nonZeroRtIds).size).toBe(nonZeroRtIds.length);
  });

  describe("Vector2 layout", () => {
    it("has two f32 fields at correct offsets", () => {
      const vec2 = classMap.get(CLASS_PREFIX + "Vector2");
      expect(vec2.fields).toHaveLength(2);

      const x = vec2.fields.find((f) => f.name === "x");
      expect(x.offset).toBe(0);
      expect(x.size).toBe(4);
      expect(x.isReference).toBe(false);

      const y = vec2.fields.find((f) => f.name === "y");
      expect(y.offset).toBe(4);
      expect(y.size).toBe(4);
      expect(y.isReference).toBe(false);
    });
  });

  describe("Character layout", () => {
    it("has own fields (DWARF does not emit inherited fields)", () => {
      const character = classMap.get(CLASS_PREFIX + "Character");
      const fieldNames = character.fields.map((f) => f.name);
      expect(fieldNames).toContain("name");
      expect(fieldNames).toContain("hp");
    });

    it("name field is a reference", () => {
      const character = classMap.get(CLASS_PREFIX + "Character");
      const name = character.fields.find((f) => f.name === "name");
      expect(name.isReference).toBe(true);
    });

    it("hp field is not a reference", () => {
      const character = classMap.get(CLASS_PREFIX + "Character");
      const hp = character.fields.find((f) => f.name === "hp");
      expect(hp.isReference).toBe(false);
    });
  });

  describe("TreeNode layout", () => {
    it("has self-referencing fields", () => {
      const treeNode = classMap.get(CLASS_PREFIX + "TreeNode");
      const left = treeNode.fields.find((f) => f.name === "left");
      const right = treeNode.fields.find((f) => f.name === "right");
      expect(left.isReference).toBe(true);
      expect(right.isReference).toBe(true);
    });
  });

  describe("template types", () => {
    it("resolves template type for Array<Item>", () => {
      const arrayItem = classes.find((c) => c.name === `~lib/array/Array<${CLASS_PREFIX}Item>`);
      if (arrayItem) {
        expect(arrayItem.templateType).toBeDefined();
      }
    });
  });

  it("excludes classes without rtid", () => {
    for (const cls of classes) {
      expect(cls.rtid).toBeDefined();
    }
  });
});
