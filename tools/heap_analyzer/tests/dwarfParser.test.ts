import assert from "node:assert/strict";
import { before, describe, it } from "node:test";
import {
  DW_AT,
  DW_FORM,
  DW_TAG,
  extractWasmSections,
  parseAbbrevTable,
  parseWasmDebugInfo,
  tagName,
  attrName,
  getAttr,
  walkDIEs,
  findDIEsByTag,
  buildOffsetMap,
  type DwarfDIE,
  type WasmDebugInfo,
} from "../../dwarf/dwarfParser.js";
import { CLASS_PREFIX, describeIntegration } from "./testHelper.js";

// ── Helpers ──────────────────────────────────────────────────────────────────

function assertDefined<T>(value: T | undefined, message?: string): T {
  if (value === undefined) {
    assert.fail(message ?? "Expected value to be defined");
  }
  return value;
}

// ── Tests ────────────────────────────────────────────────────────────────────

describeIntegration("dwarfParser", (ctx) => {
  let debugInfo: WasmDebugInfo;
  let root: DwarfDIE;

  function findFixtureClass(name: string): DwarfDIE {
    return assertDefined(
      findDIEsByTag(root, DW_TAG.class_type).find((c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + name)
    );
  }

  function findNamedChild(die: DwarfDIE, tag: number, name: string): DwarfDIE {
    return assertDefined(die.children.find((c) => c.tag === tag && getAttr(c, DW_AT.name)?.value === name));
  }

  function findConstructor(die: DwarfDIE): DwarfDIE {
    return assertDefined(
      die.children.find(
        (c) => c.tag === DW_TAG.subprogram && (getAttr(c, DW_AT.name)?.value as string)?.includes("#constructor")
      )
    );
  }

  before(() => {
    ctx.compileFixture();
    debugInfo = parseWasmDebugInfo(ctx.loadFixtureWasm());
    root = debugInfo.compilationUnits[0].rootDIE;
  });

  describe("extractWasmSections", () => {
    it("finds DWARF custom sections in wasm binary", () => {
      const sections = extractWasmSections(ctx.loadFixtureWasm());
      const names = new Set(sections.customSections.map((s) => s.name));
      assert.ok(names.has("debug_info"));
      assert.ok(names.has("debug_abbrev"));
      assert.ok(names.has("debug_str"));
    });

    it("returns non-empty payloads for DWARF sections", () => {
      const sections = extractWasmSections(ctx.loadFixtureWasm());
      const debugInfoSection = assertDefined(sections.customSections.find((s) => s.name === "debug_info"));
      const debugAbbrevSection = assertDefined(sections.customSections.find((s) => s.name === "debug_abbrev"));
      assert.ok(debugInfoSection.payload.length > 0);
      assert.ok(debugAbbrevSection.payload.length > 0);
    });

    it("returns the fixture's global entries with the expected mutability split", () => {
      const sections = extractWasmSections(ctx.loadFixtureWasm());
      const mutableGlobals = sections.globals.filter((entry) => entry.mutable);

      assert.strictEqual(sections.globals.length, 25);
      assert.strictEqual(mutableGlobals.length, 16);
    });
  });

  describe("parseAbbrevTable", () => {
    it("parses abbreviation entries from debug_abbrev", () => {
      const sections = extractWasmSections(ctx.loadFixtureWasm());
      const abbrevSection = assertDefined(sections.customSections.find((s) => s.name === "debug_abbrev"));
      const table = parseAbbrevTable(abbrevSection.payload);

      assert.ok(table.size > 0);

      const entry1 = assertDefined(table.get(1));
      assert.strictEqual(entry1.tag, DW_TAG.compile_unit);
      assert.strictEqual(entry1.hasChildren, true);
      assert.ok(entry1.attributes.some((a) => a.name === DW_AT.producer && a.form === DW_FORM.strp));
    });

    it("parses class_type abbreviation", () => {
      const sections = extractWasmSections(ctx.loadFixtureWasm());
      const abbrevSection = assertDefined(sections.customSections.find((s) => s.name === "debug_abbrev"));
      const table = parseAbbrevTable(abbrevSection.payload);

      const classAbbrev = assertDefined([...table.values()].find((e) => e.tag === DW_TAG.class_type));
      assert.notStrictEqual(classAbbrev, undefined);
      assert.strictEqual(classAbbrev.hasChildren, true);
      assert.ok(classAbbrev.attributes.some((a) => a.name === DW_AT.name));
    });

    it("parses member abbreviation", () => {
      const sections = extractWasmSections(ctx.loadFixtureWasm());
      const abbrevSection = assertDefined(sections.customSections.find((s) => s.name === "debug_abbrev"));
      const table = parseAbbrevTable(abbrevSection.payload);

      const memberAbbrev = assertDefined([...table.values()].find((e) => e.tag === DW_TAG.member));
      assert.notStrictEqual(memberAbbrev, undefined);
      assert.strictEqual(memberAbbrev.hasChildren, false);
      const attrNames = new Set(memberAbbrev.attributes.map((a) => a.name));
      assert.ok(attrNames.has(DW_AT.name));
      assert.ok(attrNames.has(DW_AT.type));
      assert.ok(attrNames.has(DW_AT.data_member_location));
    });
  });

  describe("parseWasmDebugInfo", () => {
    it("parses a single DWARF4 compilation unit", () => {
      assert.strictEqual(debugInfo.compilationUnits.length, 1);
      const unit = debugInfo.compilationUnits[0];
      assert.strictEqual(unit.version, 4);
      assert.strictEqual(unit.addressSize, 4);
    });

    it("returns wasm globals alongside DWARF units", () => {
      const mutableGlobals = debugInfo.globals.filter((entry) => entry.mutable);

      assert.strictEqual(debugInfo.globals.length, 25);
      assert.strictEqual(mutableGlobals.length, 16);
    });

    it("accepts ArrayBuffer input", () => {
      const result = parseWasmDebugInfo(ctx.loadFixtureWasm().buffer as ArrayBuffer);
      assert.strictEqual(result.compilationUnits.length, 1);
      assert.strictEqual(result.globals.length, debugInfo.globals.length);
    });

    it("has warpo as producer", () => {
      assert.strictEqual(getAttr(root, DW_AT.producer)?.value, "warpo");
    });

    it("throws when debug_abbrev is missing", () => {
      const minimalWasm = new Uint8Array([0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00]);
      assert.throws(() => parseWasmDebugInfo(minimalWasm), /Missing .debug_abbrev section/);
    });

    it("has non-empty abbreviations table", () => {
      assert.ok(debugInfo.abbreviations.size > 0);
    });

    it("has abbrevOffset of 0", () => {
      assert.strictEqual(debugInfo.compilationUnits[0].abbrevOffset, 0);
    });
  });

  describe("stringTable", () => {
    it("is a non-empty Map", () => {
      assert.ok(debugInfo.stringTable instanceof Map);
      assert.ok(debugInfo.stringTable.size > 0);
    });

    it("contains producer string 'warpo'", () => {
      const values = [...debugInfo.stringTable.values()];
      assert.ok(values.includes("warpo"));
    });

    it("all values are non-empty strings", () => {
      for (const str of debugInfo.stringTable.values()) {
        assert.strictEqual(typeof str, "string");
        assert.ok(str.length > 0);
      }
    });

    it("strp attributes resolve to strings in the table", () => {
      const producer = assertDefined(getAttr(root, DW_AT.producer));
      assert.notStrictEqual(producer, undefined);
      assert.strictEqual(producer.form, DW_FORM.strp);
      assert.strictEqual(typeof producer.value, "string");
      assert.strictEqual(debugInfo.stringTable.get(0), producer.value);
    });
  });

  describe("tagName", () => {
    it("returns known tag names from real DIEs", () => {
      assert.strictEqual(tagName(root.tag), "DW_TAG_compile_unit");

      const classes = findDIEsByTag(root, DW_TAG.class_type);
      assert.strictEqual(tagName(classes[0].tag), "DW_TAG_class_type");

      const members = classes[0].children.filter((c) => c.tag === DW_TAG.member);
      if (members.length > 0) {
        assert.strictEqual(tagName(members[0].tag), "DW_TAG_member");
      }
    });

    it("returns hex for unknown tags", () => {
      assert.strictEqual(tagName(0xff), "DW_TAG_0xff");
    });
  });

  describe("attrName", () => {
    it("returns known attribute names from real DIEs", () => {
      const producer = assertDefined(root.attributes.find((a) => a.name === DW_AT.producer));
      assert.strictEqual(attrName(producer.name), "DW_AT_producer");

      const classes = findDIEsByTag(root, DW_TAG.class_type);
      const nameAttr = assertDefined(classes[0].attributes.find((a) => a.name === DW_AT.name));
      assert.strictEqual(attrName(nameAttr.name), "DW_AT_name");
    });

    it("returns hex for unknown attributes", () => {
      assert.strictEqual(attrName(0xff), "DW_AT_0xff");
    });
  });

  describe("getAttr", () => {
    it("returns attribute when present", () => {
      const attr = getAttr(root, DW_AT.producer);
      assert.notStrictEqual(attr, undefined);
      assert.strictEqual(attr?.value, "warpo");
    });

    it("returns undefined when not present", () => {
      const baseTypes = findDIEsByTag(root, DW_TAG.base_type);
      assert.strictEqual(getAttr(baseTypes[0], DW_AT.producer), undefined);
    });
  });

  describe("walkDIEs", () => {
    it("yields root as first element", () => {
      const dies = [...walkDIEs(root)];
      assert.strictEqual(dies[0], root);
    });

    it("yields all DIEs in depth-first order", () => {
      const vec2 = findFixtureClass("Vector2");
      const dies = [...walkDIEs(vec2)];
      assert.strictEqual(dies[0], vec2);
      assert.ok(dies.length > 1);
      for (const child of vec2.children) {
        assert.ok(dies.includes(child));
      }
    });

    it("visits nested children (members and subprograms)", () => {
      const vec2 = findFixtureClass("Vector2");
      const ctor = findConstructor(vec2);
      const dies = new Set(walkDIEs(vec2));
      assert.ok(dies.has(ctor));
      for (const param of ctor.children) {
        assert.ok(dies.has(param));
      }
    });
  });

  describe("findDIEsByTag", () => {
    it("finds all class types", () => {
      const classes = findDIEsByTag(root, DW_TAG.class_type);
      assert.ok(classes.length > 10);
      const names = new Set(classes.map((c) => getAttr(c, DW_AT.name)?.value));
      assert.ok(names.has(CLASS_PREFIX + "Vector2"));
      assert.ok(names.has(CLASS_PREFIX + "Character"));
    });

    it("finds user-defined class types", () => {
      const classes = findDIEsByTag(root, DW_TAG.class_type);
      const names = new Set(classes.map((c) => getAttr(c, DW_AT.name)?.value));
      const userClasses = ["Vector2", "Item", "Entity", "Character", "Player", "NPC", "TreeNode", "ListNode", "KVPair"];
      for (const cls of userClasses) {
        assert.ok(names.has(CLASS_PREFIX + cls));
      }
    });

    it("finds base types", () => {
      const baseTypes = findDIEsByTag(root, DW_TAG.base_type);
      const names = new Set(baseTypes.map((t) => getAttr(t, DW_AT.name)?.value));
      assert.ok(names.has("i32"));
      assert.ok(names.has("f32"));
      assert.ok(names.has("f64"));
      assert.ok(names.has("bool"));
    });

    it("returns empty for tags not present", () => {
      assert.strictEqual(findDIEsByTag(root, 0xff).length, 0);
    });

    it("finds stdlib class types", () => {
      const classes = findDIEsByTag(root, DW_TAG.class_type);
      const names = new Set(classes.map((c) => getAttr(c, DW_AT.name)?.value));
      assert.ok(names.has("~lib/string/String"));
      assert.ok(names.has("~lib/arraybuffer/ArrayBuffer"));
    });
  });

  describe("buildOffsetMap", () => {
    it("maps every DIE by its offset", () => {
      const offsetMap = buildOffsetMap(root);
      assert.strictEqual(offsetMap.get(root.offset), root);

      const allDIEs = [...walkDIEs(root)];
      assert.strictEqual(offsetMap.size, allDIEs.length);
      for (const die of allDIEs) {
        assert.strictEqual(offsetMap.get(die.offset), die);
      }
    });

    it("resolves type references", () => {
      const offsetMap = buildOffsetMap(root);
      const character = findFixtureClass("Character");
      const hpField = findNamedChild(character, DW_TAG.member, "hp");
      const typeRef = getAttr(hpField, DW_AT.type)?.value as number;
      const typeDie = assertDefined(offsetMap.get(typeRef));
      assert.notStrictEqual(typeDie, undefined);
      assert.strictEqual(getAttr(typeDie, DW_AT.name)?.value, "i32");
    });
  });

  describe("class members", () => {
    it("parses Vector2 class members", () => {
      const vec2 = findFixtureClass("Vector2");
      const members = vec2.children.filter((c) => c.tag === DW_TAG.member);
      assert.strictEqual(members.length, 2);

      const xField = assertDefined(members.find((m) => getAttr(m, DW_AT.name)?.value === "x"));
      assert.strictEqual(getAttr(xField, DW_AT.data_member_location)?.value, 0);

      const yField = assertDefined(members.find((m) => getAttr(m, DW_AT.name)?.value === "y"));
      assert.strictEqual(getAttr(yField, DW_AT.data_member_location)?.value, 4);
    });

    it("parses Character class members with correct offsets", () => {
      const character = findFixtureClass("Character");
      const members = character.children.filter((c) => c.tag === DW_TAG.member);

      const nameField = assertDefined(members.find((m) => getAttr(m, DW_AT.name)?.value === "name"));
      assert.strictEqual(getAttr(nameField, DW_AT.data_member_location)?.value, 8);

      const hpField = assertDefined(members.find((m) => getAttr(m, DW_AT.name)?.value === "hp"));
      assert.strictEqual(getAttr(hpField, DW_AT.data_member_location)?.value, 12);
    });

    it("member DW_AT.type is a numeric reference", () => {
      const character = findFixtureClass("Character");
      const nameField = findNamedChild(character, DW_TAG.member, "name");
      assert.strictEqual(typeof getAttr(nameField, DW_AT.type)?.value, "number");
    });

    it("class has DW_AT.signature (rtid)", () => {
      const character = findFixtureClass("Character");
      const sig = assertDefined(getAttr(character, DW_AT.signature));
      assert.notStrictEqual(sig, undefined);
      assert.strictEqual(typeof sig.value, "number");
    });

    it("Character has DW_TAG_inheritance child pointing to Entity", () => {
      const character = findFixtureClass("Character");
      const inheritance = assertDefined(character.children.find((c) => c.tag === DW_TAG.inheritance));
      assert.notStrictEqual(inheritance, undefined);

      const typeRef = getAttr(inheritance, DW_AT.type)?.value as number;
      const parentDie = assertDefined(buildOffsetMap(root).get(typeRef));
      assert.strictEqual(getAttr(parentDie, DW_AT.name)?.value, CLASS_PREFIX + "Entity");
    });
  });

  describe("subprograms", () => {
    it("parses subprograms inside classes", () => {
      const player = findFixtureClass("Player");
      const subprograms = player.children.filter((c) => c.tag === DW_TAG.subprogram);
      const names = subprograms.map((s) => getAttr(s, DW_AT.name)?.value as string);

      assert.ok(names.some((n) => n.includes("#constructor")));
      assert.ok(names.some((n) => n.includes("#addItem")));
    });

    it("constructor has 'this' as first formal parameter", () => {
      const vec2 = findFixtureClass("Vector2");
      const ctor = findConstructor(vec2);
      const params = ctor.children.filter((c) => c.tag === DW_TAG.formal_parameter);
      assert.ok(params.length > 0);
      assert.strictEqual(getAttr(params[0], DW_AT.name)?.value, "this");
    });
  });
});
