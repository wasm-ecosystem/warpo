import assert from "node:assert/strict";
import { before, describe, it } from "node:test";
import { DebugInfoResolver, resolveClassLayouts } from "../src/debugInfoResolver.js";
import { parseWasmDebugInfo, DW_AT, DW_TAG, getAttr } from "../src/dwarfParser.js";
import type { ClassLayout, RuntimeGlobals } from "../src/types.js";
import { CLASS_PREFIX, describeIntegration } from "./testHelper.js";

const I32_TYPE_KIND = -1;

describeIntegration("debug-info-resolver", (ctx) => {
  let classes: ClassLayout[];
  let classMap: Map<string, ClassLayout>;
  let debugInfoResolver: DebugInfoResolver;
  let fixtureWasm: Uint8Array;

  before(() => {
    ctx.compileFixture();
    fixtureWasm = ctx.loadFixtureWasm();
    debugInfoResolver = DebugInfoResolver.fromWasm(fixtureWasm);
    classes = resolveClassLayouts(fixtureWasm);
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
    it("has inherited fields from Entity and own fields", () => {
      const character = classMap.get(CLASS_PREFIX + "Character");
      const fieldNames = character.fields.map((f) => f.name);
      assert.deepStrictEqual(fieldNames, ["id", "position", "name", "hp"]);
    });

    it("has base set to Entity", () => {
      const character = classMap.get(CLASS_PREFIX + "Character");
      assert.strictEqual(character.base, CLASS_PREFIX + "Entity");
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

  describe("Player layout (deep inheritance)", () => {
    it("has all inherited fields from Entity→Character plus own fields", () => {
      const player = classMap.get(CLASS_PREFIX + "Player");
      const fieldNames = player.fields.map((f) => f.name);
      assert.deepStrictEqual(fieldNames, ["id", "position", "name", "hp", "inventory", "score"]);
    });

    it("has base set to Character", () => {
      const player = classMap.get(CLASS_PREFIX + "Player");
      assert.strictEqual(player.base, CLASS_PREFIX + "Character");
    });

    it("inherited fields have correct offsets", () => {
      const player = classMap.get(CLASS_PREFIX + "Player");
      assert.strictEqual(player.fields.find((f) => f.name === "id").offset, 0);
      assert.strictEqual(player.fields.find((f) => f.name === "position").offset, 4);
      assert.strictEqual(player.fields.find((f) => f.name === "name").offset, 8);
      assert.strictEqual(player.fields.find((f) => f.name === "hp").offset, 12);
      assert.strictEqual(player.fields.find((f) => f.name === "inventory").offset, 16);
      assert.strictEqual(player.fields.find((f) => f.name === "score").offset, 20);
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

  describe("global roots", () => {
    it("maps mutable i32 runtime globals back to their wasm global indices", () => {
      const debugInfo = parseWasmDebugInfo(fixtureWasm);
      const mutableI32Globals = new Array<number>(
        debugInfo.globals.filter((entry) => entry.mutable && entry.type.kind === I32_TYPE_KIND).length
      ).fill(0);
      const topLevelGlobals = debugInfo.compilationUnits[0].rootDIE.children.filter(
        (child) => child.tag === DW_TAG.variable
      );
      const globalTreeDie = topLevelGlobals.find((die) =>
        String(getAttr(die, DW_AT.name)?.value).endsWith("/globalTree")
      );
      const globalTreeIndex = getAttr(globalTreeDie, DW_AT.location)?.value as number;

      let expectedSlot = -1;
      let mutableI32Slot = 0;
      for (const globalEntry of debugInfo.globals) {
        if (globalEntry.type.kind !== I32_TYPE_KIND) {
          continue;
        }
        if (globalEntry.mutable) {
          if (globalEntry.index === globalTreeIndex) {
            expectedSlot = mutableI32Slot;
            break;
          }
          mutableI32Slot++;
        }
      }

      assert.ok(expectedSlot >= 0);

      const expectedValue = 0x12345678;
      mutableI32Globals[expectedSlot] = expectedValue;
      const runtimeGlobals: RuntimeGlobals = { dataEnd: 0, heapBase: 0, stackPointer: 0, mutableI32Globals };
      const rootMap = new Map(debugInfoResolver.getGlobalRoots(runtimeGlobals).map((root) => [root.name, root]));

      assert.strictEqual(rootMap.get(`${CLASS_PREFIX}globalTree`)?.value, expectedValue);
      assert.strictEqual(rootMap.get(`${CLASS_PREFIX}globalTree`)?.globalIndex, globalTreeIndex);
      assert.strictEqual(rootMap.get(`${CLASS_PREFIX}globalTree`)?.className, `${CLASS_PREFIX}TreeNode`);
    });
  });
});
