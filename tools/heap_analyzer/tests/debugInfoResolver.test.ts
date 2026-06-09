import assert from "node:assert/strict";
import { before, describe, it } from "node:test";
import { TypeKind } from "wasmparser/dist/cjs/WasmParser.js";
import { attachBuiltinKind, DebugInfoResolver, resolveClassLayouts } from "../src/debugInfoResolver.js";
import { parseWasmDebugInfo, DW_AT, DW_TAG, getAttr } from "../src/dwarfParser.js";
import { BuiltinContainerKind, type ClassField, type ClassLayout } from "../src/types.js";
import { CLASS_PREFIX, describeIntegration } from "./testHelper.js";

function mustGetLayout(classMap: Map<string, ClassLayout>, className: string): ClassLayout {
  const classLayout = classMap.get(className);
  if (!classLayout) {
    throw new Error(`missing class layout ${className}`);
  }
  return classLayout;
}

function mustGetField(classLayout: ClassLayout, fieldName: string): ClassField {
  const field = classLayout.fields.find((candidate) => candidate.name === fieldName);
  if (!field) {
    throw new Error(`missing field ${fieldName} on ${classLayout.name}`);
  }
  return field;
}

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

  it("keeps only ~lib/object/Object among zero-rtid layouts", () => {
    const zeroRtIdNames = classes
      .filter((c) => c.rtid === 0)
      .map((c) => c.name)
      .toSorted((left, right) => left.localeCompare(right));
    assert.deepStrictEqual(zeroRtIdNames, ["~lib/object/Object"]);
  });

  describe("Vector2 layout", () => {
    it("has two f32 fields at correct offsets", () => {
      const vec2 = mustGetLayout(classMap, CLASS_PREFIX + "Vector2");
      assert.strictEqual(vec2.fields.length, 2);

      const x = mustGetField(vec2, "x");
      assert.strictEqual(x.offset, 0);
      assert.strictEqual(x.size, 4);
      assert.strictEqual(x.isReference, false);

      const y = mustGetField(vec2, "y");
      assert.strictEqual(y.offset, 4);
      assert.strictEqual(y.size, 4);
      assert.strictEqual(y.isReference, false);
    });
  });

  describe("Character layout", () => {
    it("has inherited fields from Entity and own fields", () => {
      const character = mustGetLayout(classMap, CLASS_PREFIX + "Character");
      const fieldNames = character.fields.map((f) => f.name);
      assert.deepStrictEqual(fieldNames, ["id", "position", "name", "hp"]);
    });

    it("has base set to Entity", () => {
      const character = mustGetLayout(classMap, CLASS_PREFIX + "Character");
      assert.strictEqual(character.base, CLASS_PREFIX + "Entity");
    });

    it("name field is a reference", () => {
      const character = mustGetLayout(classMap, CLASS_PREFIX + "Character");
      const name = mustGetField(character, "name");
      assert.strictEqual(name.isReference, true);
    });

    it("hp field is not a reference", () => {
      const character = mustGetLayout(classMap, CLASS_PREFIX + "Character");
      const hp = mustGetField(character, "hp");
      assert.strictEqual(hp.isReference, false);
    });
  });

  describe("Player layout (deep inheritance)", () => {
    it("has all inherited fields from Entity→Character plus own fields", () => {
      const player = mustGetLayout(classMap, CLASS_PREFIX + "Player");
      const fieldNames = player.fields.map((f) => f.name);
      assert.deepStrictEqual(fieldNames, ["id", "position", "name", "hp", "inventory", "score"]);
    });

    it("has base set to Character", () => {
      const player = mustGetLayout(classMap, CLASS_PREFIX + "Player");
      assert.strictEqual(player.base, CLASS_PREFIX + "Character");
    });

    it("inherited fields have correct offsets", () => {
      const player = mustGetLayout(classMap, CLASS_PREFIX + "Player");
      assert.strictEqual(mustGetField(player, "id").offset, 0);
      assert.strictEqual(mustGetField(player, "position").offset, 4);
      assert.strictEqual(mustGetField(player, "name").offset, 8);
      assert.strictEqual(mustGetField(player, "hp").offset, 12);
      assert.strictEqual(mustGetField(player, "inventory").offset, 16);
      assert.strictEqual(mustGetField(player, "score").offset, 20);
    });
  });

  describe("TreeNode layout", () => {
    it("has self-referencing fields", () => {
      const treeNode = mustGetLayout(classMap, CLASS_PREFIX + "TreeNode");
      const left = mustGetField(treeNode, "left");
      const right = mustGetField(treeNode, "right");
      assert.strictEqual(left.isReference, true);
      assert.strictEqual(right.isReference, true);
    });
  });

  describe("template types", () => {
    it("resolves template type metadata for Array<Item>", () => {
      const arrayItem = classes.find((c) => c.name === `~lib/array/Array<${CLASS_PREFIX}Item>`);
      assert.ok(arrayItem);
      assert.strictEqual(arrayItem.builtinKind, BuiltinContainerKind.Array);
      assert.strictEqual(arrayItem.templateType, `${CLASS_PREFIX}Item`);
      assert.strictEqual(arrayItem.templateTypeIsReference, true);
    });

    it("resolves builtin kinds for stdlib containers", () => {
      const functionLayout: Pick<ClassLayout, "name" | "builtinKind"> = {
        name: "~lib/function/Function<(i32)=>i32>",
      };
      attachBuiltinKind(functionLayout);

      assert.strictEqual(
        classMap.get("~lib/staticarray/StaticArray<i32>")?.builtinKind,
        BuiltinContainerKind.StaticArray
      );
      assert.strictEqual(classMap.get("~lib/set/Set<i32>")?.builtinKind, BuiltinContainerKind.MapOrSet);
      assert.strictEqual(classMap.get("~lib/map/Map<i32,i32>")?.builtinKind, BuiltinContainerKind.MapOrSet);
      assert.strictEqual(functionLayout.builtinKind, BuiltinContainerKind.Function);
    });
  });

  describe("entry layouts", () => {
    it("resolves Set entry layouts", () => {
      assert.deepStrictEqual(classMap.get("~lib/set/Set<i32>")?.entryLayout, {
        size: 8,
        referenceOffsets: [],
      });
      assert.deepStrictEqual(classMap.get(`~lib/set/Set<${CLASS_PREFIX}Item>`)?.entryLayout, {
        size: 8,
        referenceOffsets: [0],
      });
    });

    it("resolves Map entry layouts", () => {
      assert.deepStrictEqual(classMap.get("~lib/map/Map<i32,i32>")?.entryLayout, {
        size: 12,
        referenceOffsets: [],
      });
      assert.deepStrictEqual(classMap.get(`~lib/map/Map<~lib/string/String,${CLASS_PREFIX}Player>`)?.entryLayout, {
        size: 12,
        referenceOffsets: [0, 4],
      });
    });
  });

  it("excludes classes without rtid", () => {
    for (const cls of classes) {
      assert.notStrictEqual(cls.rtid, undefined);
    }
  });

  describe("global roots", () => {
    it("maps mutable i32 runtime globals back to their wasm global indices", () => {
      const wasmDebugInfo = parseWasmDebugInfo(fixtureWasm);
      const wasmGlobalEntries = wasmDebugInfo.globals;
      const mutableI32GlobalValues = new Array<number>(
        wasmGlobalEntries.filter((entry) => entry.mutable && entry.type.kind === TypeKind.i32).length
      ).fill(0);
      const topLevelGlobalVariableDIEs = wasmDebugInfo.compilationUnits[0].rootDIE.children.filter(
        (child) => child.tag === DW_TAG.variable
      );
      const maybeGlobalTreeDie = topLevelGlobalVariableDIEs.find((die) =>
        String(getAttr(die, DW_AT.name)?.value).endsWith("/globalTree")
      );
      if (!maybeGlobalTreeDie) {
        throw new Error("missing globalTree DIE");
      }
      const globalTreeDie = maybeGlobalTreeDie;
      const globalTreeIndex = getAttr(globalTreeDie, DW_AT.location)?.value as number;

      let expectedSlot = -1;
      let mutableI32Slot = 0;
      for (const wasmGlobalEntry of wasmGlobalEntries) {
        if (wasmGlobalEntry.type.kind !== TypeKind.i32) {
          continue;
        }
        if (wasmGlobalEntry.mutable) {
          if (wasmGlobalEntry.index === globalTreeIndex) {
            expectedSlot = mutableI32Slot;
            break;
          }
          mutableI32Slot++;
        }
      }

      assert.ok(expectedSlot >= 0);

      const expectedValue = 0x12345678;
      mutableI32GlobalValues[expectedSlot] = expectedValue;
      const rootMap = new Map(
        debugInfoResolver.getGlobalRoots(mutableI32GlobalValues).map((root) => [root.name, root])
      );

      assert.strictEqual(rootMap.get(`${CLASS_PREFIX}globalTree`)?.value, expectedValue);
      assert.strictEqual(rootMap.get(`${CLASS_PREFIX}globalTree`)?.globalIndex, globalTreeIndex);
      assert.strictEqual(rootMap.get(`${CLASS_PREFIX}globalTree`)?.className, `${CLASS_PREFIX}TreeNode`);
    });
  });
});
