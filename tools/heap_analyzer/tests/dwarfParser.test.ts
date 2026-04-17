import { readFileSync, existsSync, mkdirSync } from "node:fs";
import { tmpdir } from "node:os";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { execSync } from "node:child_process";
import {
  DW_AT,
  DW_FORM,
  DW_TAG,
  extractCustomSections,
  parseAbbrevTable,
  parseDwarf,
  tagName,
  attrName,
  getAttr,
  walkDIEs,
  findDIEsByTag,
  buildOffsetMap,
  type DwarfDIE,
  type DwarfInfo,
} from "../src/dwarfParser.js";

// ── Helpers ──────────────────────────────────────────────────────────────────

const PROJECT_ROOT = resolve(dirname(fileURLToPath(import.meta.url)), "../../..");
const WARPO_ASC = resolve(PROJECT_ROOT, "build/warpo/warpo_asc");
const FIXTURE_SRC = resolve(PROJECT_ROOT, "tools/heap_analyzer/tests/fixture/dwarfFixture.ts");
const OUTPUT_DIR = resolve(tmpdir(), "warpo_test");
const FIXTURE_WASM = resolve(OUTPUT_DIR, "dwarfFixture.wasm");
const CLASS_PREFIX = "tools/heap_analyzer/tests/fixture/dwarfFixture/";

function compileFixture(): void {
  if (!existsSync(OUTPUT_DIR)) {
    mkdirSync(OUTPUT_DIR, { recursive: true });
  }
  // eslint-disable-next-line sonarjs/os-command
  execSync(`${WARPO_ASC} ${FIXTURE_SRC} -o ${FIXTURE_WASM} --debug`, {
    cwd: PROJECT_ROOT,
    stdio: "pipe",
  });
}

function loadFixtureWasm(): Uint8Array {
  return new Uint8Array(readFileSync(FIXTURE_WASM));
}

const canRunIntegration = existsSync(WARPO_ASC);
const describeIntegration = canRunIntegration ? describe : describe.skip;

// ── Tests ────────────────────────────────────────────────────────────────────

describeIntegration("dwarfParser", () => {
  let dwarf: DwarfInfo;
  let root: DwarfDIE;

  beforeAll(() => {
    compileFixture();
    dwarf = parseDwarf(loadFixtureWasm());
    root = dwarf.compilationUnits[0].rootDIE;
  });

  describe("extractCustomSections", () => {
    it("finds DWARF custom sections in wasm binary", () => {
      const sections = extractCustomSections(loadFixtureWasm());
      const names = sections.map((s) => s.name);
      expect(names).toContain("debug_info");
      expect(names).toContain("debug_abbrev");
      expect(names).toContain("debug_str");
    });

    it("returns non-empty payloads for DWARF sections", () => {
      const sections = extractCustomSections(loadFixtureWasm());
      const debugInfo = sections.find((s) => s.name === "debug_info");
      const debugAbbrev = sections.find((s) => s.name === "debug_abbrev");
      expect(debugInfo.payload.length).toBeGreaterThan(0);
      expect(debugAbbrev.payload.length).toBeGreaterThan(0);
    });
  });

  describe("parseAbbrevTable", () => {
    it("parses abbreviation entries from debug_abbrev", () => {
      const sections = extractCustomSections(loadFixtureWasm());
      const abbrevSection = sections.find((s) => s.name === "debug_abbrev");
      const table = parseAbbrevTable(abbrevSection.payload);

      expect(table.size).toBeGreaterThan(0);

      const entry1 = table.get(1);
      expect(entry1.tag).toBe(DW_TAG.compile_unit);
      expect(entry1.hasChildren).toBe(true);
      expect(entry1.attributes).toContainEqual({
        name: DW_AT.producer,
        form: DW_FORM.strp,
      });
    });

    it("parses class_type abbreviation", () => {
      const sections = extractCustomSections(loadFixtureWasm());
      const table = parseAbbrevTable(sections.find((s) => s.name === "debug_abbrev").payload);

      const classAbbrev = [...table.values()].find((e) => e.tag === DW_TAG.class_type);
      expect(classAbbrev).toBeDefined();
      expect(classAbbrev.hasChildren).toBe(true);
      expect(classAbbrev.attributes.some((a) => a.name === DW_AT.name)).toBe(true);
    });

    it("parses member abbreviation", () => {
      const sections = extractCustomSections(loadFixtureWasm());
      const table = parseAbbrevTable(sections.find((s) => s.name === "debug_abbrev").payload);

      const memberAbbrev = [...table.values()].find((e) => e.tag === DW_TAG.member);
      expect(memberAbbrev).toBeDefined();
      expect(memberAbbrev.hasChildren).toBe(false);
      const attrNames = memberAbbrev.attributes.map((a) => a.name);
      expect(attrNames).toContain(DW_AT.name);
      expect(attrNames).toContain(DW_AT.type);
      expect(attrNames).toContain(DW_AT.data_member_location);
    });
  });

  describe("parseDwarf", () => {
    it("parses a single DWARF4 compilation unit", () => {
      expect(dwarf.compilationUnits).toHaveLength(1);
      const unit = dwarf.compilationUnits[0];
      expect(unit.version).toBe(4);
      expect(unit.addressSize).toBe(4);
    });

    it("accepts ArrayBuffer input", () => {
      const result = parseDwarf(loadFixtureWasm().buffer as ArrayBuffer);
      expect(result.compilationUnits).toHaveLength(1);
    });

    it("has warpo as producer", () => {
      expect(getAttr(root, DW_AT.producer)?.value).toBe("warpo");
    });

    it("throws when debug_abbrev is missing", () => {
      const minimalWasm = new Uint8Array([0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00]);
      expect(() => parseDwarf(minimalWasm)).toThrow("Missing .debug_abbrev section");
    });

    it("has non-empty abbreviations table", () => {
      expect(dwarf.abbreviations.size).toBeGreaterThan(0);
    });

    it("has abbrevOffset of 0", () => {
      expect(dwarf.compilationUnits[0].abbrevOffset).toBe(0);
    });
  });

  describe("tagName", () => {
    it("returns known tag names from real DIEs", () => {
      expect(tagName(root.tag)).toBe("DW_TAG_compile_unit");

      const classes = findDIEsByTag(root, DW_TAG.class_type);
      expect(tagName(classes[0].tag)).toBe("DW_TAG_class_type");

      const members = classes[0].children.filter((c) => c.tag === DW_TAG.member);
      if (members.length > 0) {
        expect(tagName(members[0].tag)).toBe("DW_TAG_member");
      }
    });

    it("returns hex for unknown tags", () => {
      expect(tagName(0xff)).toBe("DW_TAG_0xff");
    });
  });

  describe("attrName", () => {
    it("returns known attribute names from real DIEs", () => {
      const producer = root.attributes.find((a) => a.name === DW_AT.producer);
      expect(attrName(producer.name)).toBe("DW_AT_producer");

      const classes = findDIEsByTag(root, DW_TAG.class_type);
      const nameAttr = classes[0].attributes.find((a) => a.name === DW_AT.name);
      expect(attrName(nameAttr.name)).toBe("DW_AT_name");
    });

    it("returns hex for unknown attributes", () => {
      expect(attrName(0xff)).toBe("DW_AT_0xff");
    });
  });

  describe("getAttr", () => {
    it("returns attribute when present", () => {
      const attr = getAttr(root, DW_AT.producer);
      expect(attr).toBeDefined();
      expect(attr?.value).toBe("warpo");
    });

    it("returns undefined when not present", () => {
      const baseTypes = findDIEsByTag(root, DW_TAG.base_type);
      expect(getAttr(baseTypes[0], DW_AT.producer)).toBeUndefined();
    });
  });

  describe("walkDIEs", () => {
    it("yields root as first element", () => {
      const dies = [...walkDIEs(root)];
      expect(dies[0]).toBe(root);
    });

    it("yields all DIEs in depth-first order", () => {
      const vec2 = findDIEsByTag(root, DW_TAG.class_type).find(
        (c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + "Vector2"
      );
      const dies = [...walkDIEs(vec2)];
      expect(dies[0]).toBe(vec2);
      expect(dies.length).toBeGreaterThan(1);
      for (const child of vec2.children) {
        expect(dies).toContain(child);
      }
    });

    it("visits nested children (members and subprograms)", () => {
      const vec2 = findDIEsByTag(root, DW_TAG.class_type).find(
        (c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + "Vector2"
      );
      const ctor = vec2.children.find(
        (c) => c.tag === DW_TAG.subprogram && (getAttr(c, DW_AT.name)?.value as string)?.includes("#constructor")
      );
      const dies = [...walkDIEs(vec2)];
      expect(dies).toContain(ctor);
      for (const param of ctor.children) {
        expect(dies).toContain(param);
      }
    });
  });

  describe("findDIEsByTag", () => {
    it("finds all class types", () => {
      const classes = findDIEsByTag(root, DW_TAG.class_type);
      expect(classes.length).toBeGreaterThan(10);
      const names = classes.map((c) => getAttr(c, DW_AT.name)?.value);
      expect(names).toContain(CLASS_PREFIX + "Vector2");
      expect(names).toContain(CLASS_PREFIX + "Character");
    });

    it("finds user-defined class types", () => {
      const classes = findDIEsByTag(root, DW_TAG.class_type);
      const names = classes.map((c) => getAttr(c, DW_AT.name)?.value);
      const userClasses = ["Vector2", "Item", "Entity", "Character", "Player", "NPC", "TreeNode", "ListNode", "KVPair"];
      for (const cls of userClasses) {
        expect(names).toContain(CLASS_PREFIX + cls);
      }
    });

    it("finds base types", () => {
      const baseTypes = findDIEsByTag(root, DW_TAG.base_type);
      const names = baseTypes.map((t) => getAttr(t, DW_AT.name)?.value);
      expect(names).toContain("i32");
      expect(names).toContain("f32");
      expect(names).toContain("f64");
      expect(names).toContain("bool");
    });

    it("returns empty for tags not present", () => {
      expect(findDIEsByTag(root, 0xff)).toHaveLength(0);
    });

    it("finds stdlib class types", () => {
      const classes = findDIEsByTag(root, DW_TAG.class_type);
      const names = classes.map((c) => getAttr(c, DW_AT.name)?.value);
      expect(names).toContain("~lib/string/String");
      expect(names).toContain("~lib/arraybuffer/ArrayBuffer");
    });
  });

  describe("buildOffsetMap", () => {
    it("maps every DIE by its offset", () => {
      const offsetMap = buildOffsetMap(root);
      expect(offsetMap.get(root.offset)).toBe(root);

      const allDIEs = [...walkDIEs(root)];
      expect(offsetMap.size).toBe(allDIEs.length);
      for (const die of allDIEs) {
        expect(offsetMap.get(die.offset)).toBe(die);
      }
    });

    it("resolves type references", () => {
      const offsetMap = buildOffsetMap(root);
      const character = findDIEsByTag(root, DW_TAG.class_type).find(
        (c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + "Character"
      );
      const hpField = character.children.find((c) => c.tag === DW_TAG.member && getAttr(c, DW_AT.name)?.value === "hp");
      const typeRef = getAttr(hpField, DW_AT.type)?.value as number;
      const typeDie = offsetMap.get(typeRef);
      expect(typeDie).toBeDefined();
      expect(getAttr(typeDie, DW_AT.name)?.value).toBe("i32");
    });
  });

  describe("class members", () => {
    it("parses Vector2 class members", () => {
      const vec2 = findDIEsByTag(root, DW_TAG.class_type).find(
        (c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + "Vector2"
      );
      const members = vec2.children.filter((c) => c.tag === DW_TAG.member);
      expect(members).toHaveLength(2);

      const xField = members.find((m) => getAttr(m, DW_AT.name)?.value === "x");
      expect(getAttr(xField, DW_AT.data_member_location)?.value).toBe(0);

      const yField = members.find((m) => getAttr(m, DW_AT.name)?.value === "y");
      expect(getAttr(yField, DW_AT.data_member_location)?.value).toBe(4);
    });

    it("parses Character class members with correct offsets", () => {
      const character = findDIEsByTag(root, DW_TAG.class_type).find(
        (c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + "Character"
      );
      const members = character.children.filter((c) => c.tag === DW_TAG.member);

      const nameField = members.find((m) => getAttr(m, DW_AT.name)?.value === "name");
      expect(getAttr(nameField, DW_AT.data_member_location)?.value).toBe(8);

      const hpField = members.find((m) => getAttr(m, DW_AT.name)?.value === "hp");
      expect(getAttr(hpField, DW_AT.data_member_location)?.value).toBe(12);
    });

    it("member DW_AT.type is a numeric reference", () => {
      const character = findDIEsByTag(root, DW_TAG.class_type).find(
        (c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + "Character"
      );
      const nameField = character.children.find(
        (c) => c.tag === DW_TAG.member && getAttr(c, DW_AT.name)?.value === "name"
      );
      expect(typeof getAttr(nameField, DW_AT.type)?.value).toBe("number");
    });

    it("class has DW_AT.signature (rtid)", () => {
      const character = findDIEsByTag(root, DW_TAG.class_type).find(
        (c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + "Character"
      );
      const sig = getAttr(character, DW_AT.signature);
      expect(sig).toBeDefined();
      expect(typeof sig.value).toBe("number");
    });
  });

  describe("subprograms", () => {
    it("parses subprograms inside classes", () => {
      const player = findDIEsByTag(root, DW_TAG.class_type).find(
        (c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + "Player"
      );
      const subprograms = player.children.filter((c) => c.tag === DW_TAG.subprogram);
      const names = subprograms.map((s) => getAttr(s, DW_AT.name)?.value as string);

      expect(names.some((n) => n.includes("#constructor"))).toBe(true);
      expect(names.some((n) => n.includes("#addItem"))).toBe(true);
    });

    it("constructor has 'this' as first formal parameter", () => {
      const vec2 = findDIEsByTag(root, DW_TAG.class_type).find(
        (c) => getAttr(c, DW_AT.name)?.value === CLASS_PREFIX + "Vector2"
      );
      const ctor = vec2.children.find(
        (c) => c.tag === DW_TAG.subprogram && (getAttr(c, DW_AT.name)?.value as string)?.includes("#constructor")
      );
      const params = ctor.children.filter((c) => c.tag === DW_TAG.formal_parameter);
      expect(params.length).toBeGreaterThan(0);
      expect(getAttr(params[0], DW_AT.name)?.value).toBe("this");
    });
  });
});
