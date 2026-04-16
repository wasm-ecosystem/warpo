import {
  DW_AT,
  DW_FORM,
  DW_TAG,
  parseAbbrevTable,
  parseDebugInfo,
  extractCustomSections,
  parseDwarf,
  tagName,
  attrName,
  getAttr,
  walkDIEs,
  findDIEsByTag,
  buildOffsetMap,
  type DwarfDIE,
} from "../src/dwarfParser.js";

// ── Helpers to build binary DWARF data ───────────────────────────────────────

function encodeLEB128(value: number): number[] {
  const bytes: number[] = [];
  do {
    let byte = value & 0x7f;
    value >>>= 7;
    if (value !== 0) byte |= 0x80;
    bytes.push(byte);
  } while (value !== 0);
  return bytes;
}

function encodeString(str: string): number[] {
  const bytes = [...new TextEncoder().encode(str), 0];
  return bytes;
}

function uint32LE(value: number): number[] {
  return [value & 0xff, (value >> 8) & 0xff, (value >> 16) & 0xff, (value >> 24) & 0xff];
}

function uint16LE(value: number): number[] {
  return [value & 0xff, (value >> 8) & 0xff];
}

/**
 * Build a minimal .debug_abbrev section:
 *   [1] DW_TAG_compile_unit, DW_CHILDREN_yes
 *       DW_AT_producer DW_FORM_strp
 *   [2] DW_TAG_base_type, DW_CHILDREN_no
 *       DW_AT_name DW_FORM_string
 *   0 (end of table)
 */
function buildAbbrevSection(): Uint8Array {
  const bytes: number[] = [
    // Entry 1: compile_unit with children
    ...encodeLEB128(1), // code
    ...encodeLEB128(DW_TAG.compile_unit), // tag
    1, // DW_CHILDREN_yes
    ...encodeLEB128(DW_AT.producer),
    ...encodeLEB128(DW_FORM.strp),
    0,
    0, // end of attributes

    // Entry 2: base_type no children
    ...encodeLEB128(2), // code
    ...encodeLEB128(DW_TAG.base_type), // tag
    0, // DW_CHILDREN_no
    ...encodeLEB128(DW_AT.name),
    ...encodeLEB128(DW_FORM.string),
    0,
    0, // end of attributes

    0, // end of table
  ];
  return new Uint8Array(bytes);
}

/**
 * Build a .debug_str section with a single string "warpo" at offset 0.
 */
function buildStrSection(): Uint8Array {
  return new Uint8Array(encodeString("warpo"));
}

/**
 * Build a .debug_info section with:
 *   Compile unit header (version=4, addr_size=4)
 *   DW_TAG_compile_unit (producer = strp 0 -> "warpo")
 *     DW_TAG_base_type (name = "i32")
 *     NULL (end children)
 */
function buildInfoSection(): Uint8Array {
  // DIE data (after header)
  const dieBytes: number[] = [
    // root DIE: compile_unit (abbrev code 1)
    ...encodeLEB128(1),
    ...uint32LE(0), // DW_AT_producer -> strp offset 0 ("warpo")

    // child DIE: base_type (abbrev code 2)
    ...encodeLEB128(2),
    ...encodeString("i32"), // DW_AT_name -> "i32"

    // null terminator for compile_unit's children
    0,
  ];

  // Header: unit_length (4) + version (2) + abbrev_offset (4) + address_size (1) = 11 bytes
  const headerSize = 11;
  const unitLength = headerSize - 4 + dieBytes.length; // exclude the 4-byte length field itself

  const header: number[] = [
    ...uint32LE(unitLength), // unit_length
    ...uint16LE(4), // version = 4
    ...uint32LE(0), // abbrev_offset = 0
    4, // address_size = 4
  ];

  return new Uint8Array([...header, ...dieBytes]);
}

/**
 * Build a minimal valid wasm binary with custom sections.
 */
function buildWasmWithCustomSections(
  sections: { name: string; payload: Uint8Array }[]
): Uint8Array {
  const parts: number[] = [
    // Wasm magic + version
    0x00, 0x61, 0x73, 0x6d, 0x01, 0x00, 0x00, 0x00,
  ];

  for (const section of sections) {
    const nameBytes = new TextEncoder().encode(section.name);
    const nameWithLen = [...encodeLEB128(nameBytes.length), ...nameBytes];
    const sectionPayload = [...nameWithLen, ...section.payload];
    // Custom section: id=0, then LEB128 length, then payload
    parts.push(0); // section id = 0 (custom)
    parts.push(...encodeLEB128(sectionPayload.length));
    parts.push(...sectionPayload);
  }

  return new Uint8Array(parts);
}

// ── Tests ────────────────────────────────────────────────────────────────────

describe("parseAbbrevTable", () => {
  it("parses a basic abbreviation table", () => {
    const data = buildAbbrevSection();
    const table = parseAbbrevTable(data);

    expect(table.size).toBe(2);

    const entry1 = table.get(1)!;
    expect(entry1.tag).toBe(DW_TAG.compile_unit);
    expect(entry1.hasChildren).toBe(true);
    expect(entry1.attributes).toHaveLength(1);
    expect(entry1.attributes[0]).toEqual({ name: DW_AT.producer, form: DW_FORM.strp });

    const entry2 = table.get(2)!;
    expect(entry2.tag).toBe(DW_TAG.base_type);
    expect(entry2.hasChildren).toBe(false);
    expect(entry2.attributes).toHaveLength(1);
    expect(entry2.attributes[0]).toEqual({ name: DW_AT.name, form: DW_FORM.string });
  });

  it("returns empty table for empty input", () => {
    const table = parseAbbrevTable(new Uint8Array([0]));
    expect(table.size).toBe(0);
  });
});

describe("parseDebugInfo", () => {
  it("parses a compilation unit with base type child", () => {
    const abbrevTable = parseAbbrevTable(buildAbbrevSection());
    const stringTable = buildStrSection();
    const infoData = buildInfoSection();

    const units = parseDebugInfo(infoData, abbrevTable, stringTable);

    expect(units).toHaveLength(1);
    const unit = units[0];
    expect(unit.version).toBe(4);
    expect(unit.addressSize).toBe(4);

    const root = unit.rootDIE;
    expect(root.tag).toBe(DW_TAG.compile_unit);

    const producerAttr = root.attributes.find((a) => a.name === DW_AT.producer);
    expect(producerAttr).toBeDefined();
    expect(producerAttr!.value).toBe("warpo");

    expect(root.children).toHaveLength(1);
    const baseType = root.children[0];
    expect(baseType.tag).toBe(DW_TAG.base_type);
    const nameAttr = baseType.attributes.find((a) => a.name === DW_AT.name);
    expect(nameAttr).toBeDefined();
    expect(nameAttr!.value).toBe("i32");
  });

  it("converts DW_FORM_ref4 values to absolute offsets within debug_info", () => {
    // Abbrev table:
    //   [1] compile_unit, children=yes, DW_AT_producer DW_FORM_strp
    //   [2] variable, children=no, DW_AT_name DW_FORM_string, DW_AT_type DW_FORM_ref4
    //   [3] base_type, children=no, DW_AT_name DW_FORM_string
    const abbrevBytes: number[] = [
      ...encodeLEB128(1),
      ...encodeLEB128(DW_TAG.compile_unit),
      1,
      ...encodeLEB128(DW_AT.producer),
      ...encodeLEB128(DW_FORM.strp),
      0, 0,

      ...encodeLEB128(2),
      ...encodeLEB128(DW_TAG.variable),
      0,
      ...encodeLEB128(DW_AT.name),
      ...encodeLEB128(DW_FORM.string),
      ...encodeLEB128(DW_AT.type),
      ...encodeLEB128(DW_FORM.ref4),
      0, 0,

      ...encodeLEB128(3),
      ...encodeLEB128(DW_TAG.base_type),
      0,
      ...encodeLEB128(DW_AT.name),
      ...encodeLEB128(DW_FORM.string),
      0, 0,

      0,
    ];
    const abbrevTable = parseAbbrevTable(new Uint8Array(abbrevBytes));
    const stringTable = buildStrSection();

    // Build info: CU header (11 bytes) + DIEs
    // The base_type DIE starts at some offset after the header.
    // We'll record where it is and verify ref4 points to it.
    const dieBytes: number[] = [
      // root: compile_unit (code 1)
      ...encodeLEB128(1),
      ...uint32LE(0), // DW_AT_producer -> "warpo"

      // child: base_type (code 3) — note its CU-relative offset
      ...encodeLEB128(3),
      ...encodeString("i32"),

      // child: variable (code 2) with ref4 pointing to base_type
      ...encodeLEB128(2),
      ...encodeString("x"),
      // DW_AT_type = ref4 pointing to base_type's CU-relative offset
      // base_type starts at: 1 (CU abbrev code) + 4 (strp) = 5 bytes after header
      // CU-relative offset = header_content_size_offset + 5 = 11 + 5 - 4 = 12
      // Actually CU-relative means relative to the start of the CU header (unitStart)
      // unitStart = 0, header is 11 bytes, first DIE at offset 11
      // base_type DIE starts at 11 (header) + 1 (compile_unit code) + 4 (strp) = 16
      // CU-relative offset of base_type = 16 - 0 = 16... wait, ref4 is relative to CU start
      // which includes the 4-byte length field.
      // So the CU-relative offset is the absolute offset within .debug_info.
      // No: DWARF4 7.5.4 says "offset from the beginning of the compilation unit header"
      // unitStart = 0, so CU-relative = absolute for the first CU.
      // base_type is at offset: 4(len) + 2(ver) + 4(abbr_off) + 1(addr_sz) + 1(CU code) + 4(strp) = 16
      ...uint32LE(16),

      // null: end children
      0,
    ];

    const unitLength = 7 + dieBytes.length; // 7 = header bytes after length field
    const info = new Uint8Array([
      ...uint32LE(unitLength),
      ...uint16LE(4),
      ...uint32LE(0),
      4,
      ...dieBytes,
    ]);

    const units = parseDebugInfo(info, abbrevTable, stringTable);
    expect(units).toHaveLength(1);

    const root = units[0].rootDIE;
    // base_type is first child, variable is second child
    expect(root.children).toHaveLength(2);

    const variable = root.children[1];
    expect(variable.tag).toBe(DW_TAG.variable);
    const typeAttr = variable.attributes.find((a) => a.name === DW_AT.type);
    expect(typeAttr).toBeDefined();
    // The ref4 value (16) should be converted to absolute offset: cuOffset(0) + 16 = 16
    // And that should match the base_type DIE's offset
    const baseTypeDie = root.children[0];
    expect(typeAttr!.value).toBe(baseTypeDie.offset);
  });
});

describe("extractCustomSections", () => {
  it("extracts custom sections from a wasm binary", () => {
    const payload = new Uint8Array([1, 2, 3]);
    const wasm = buildWasmWithCustomSections([{ name: "debug_info", payload }]);
    const sections = extractCustomSections(wasm);

    const debugInfo = sections.find((s) => s.name === "debug_info");
    expect(debugInfo).toBeDefined();
    expect([...debugInfo!.payload]).toEqual([1, 2, 3]);
  });

  it("extracts multiple custom sections", () => {
    const wasm = buildWasmWithCustomSections([
      { name: "debug_abbrev", payload: new Uint8Array([10]) },
      { name: "debug_info", payload: new Uint8Array([20]) },
      { name: "debug_str", payload: new Uint8Array([30]) },
    ]);
    const sections = extractCustomSections(wasm);
    expect(sections).toHaveLength(3);
    expect(sections.map((s) => s.name)).toEqual(["debug_abbrev", "debug_info", "debug_str"]);
  });
});

describe("parseDwarf", () => {
  it("parses a complete wasm binary with DWARF sections", () => {
    const wasm = buildWasmWithCustomSections([
      { name: "debug_abbrev", payload: buildAbbrevSection() },
      { name: "debug_info", payload: buildInfoSection() },
      { name: "debug_str", payload: buildStrSection() },
    ]);

    const dwarf = parseDwarf(wasm);

    expect(dwarf.compilationUnits).toHaveLength(1);
    expect(dwarf.abbreviations.size).toBe(2);
    expect(dwarf.compilationUnits[0].rootDIE.tag).toBe(DW_TAG.compile_unit);
  });

  it("accepts ArrayBuffer input", () => {
    const wasm = buildWasmWithCustomSections([
      { name: "debug_abbrev", payload: buildAbbrevSection() },
      { name: "debug_info", payload: buildInfoSection() },
      { name: "debug_str", payload: buildStrSection() },
    ]);

    const dwarf = parseDwarf(wasm.buffer as ArrayBuffer);
    expect(dwarf.compilationUnits).toHaveLength(1);
  });

  it("throws when debug_abbrev is missing", () => {
    const wasm = buildWasmWithCustomSections([
      { name: "debug_info", payload: buildInfoSection() },
    ]);
    expect(() => parseDwarf(wasm)).toThrow("Missing .debug_abbrev section");
  });

  it("throws when debug_info is missing", () => {
    const wasm = buildWasmWithCustomSections([
      { name: "debug_abbrev", payload: buildAbbrevSection() },
    ]);
    expect(() => parseDwarf(wasm)).toThrow("Missing .debug_info section");
  });

  it("works without debug_str section", () => {
    // Build abbrev with only string (not strp) attributes
    const abbrevBytes: number[] = [
      ...encodeLEB128(1),
      ...encodeLEB128(DW_TAG.compile_unit),
      0, // DW_CHILDREN_no
      ...encodeLEB128(DW_AT.name),
      ...encodeLEB128(DW_FORM.string),
      0,
      0,
      0,
    ];
    const abbrev = new Uint8Array(abbrevBytes);
    const abbrevTable = parseAbbrevTable(abbrev);

    // Build info section
    const dieBytes: number[] = [...encodeLEB128(1), ...encodeString("test")];
    const unitLength = 7 + dieBytes.length;
    const info = new Uint8Array([...uint32LE(unitLength), ...uint16LE(4), ...uint32LE(0), 4, ...dieBytes]);

    const wasm = buildWasmWithCustomSections([
      { name: "debug_abbrev", payload: abbrev },
      { name: "debug_info", payload: info },
    ]);

    const dwarf = parseDwarf(wasm);
    expect(dwarf.compilationUnits).toHaveLength(1);
  });
});

describe("tagName", () => {
  it("returns known tag names", () => {
    expect(tagName(DW_TAG.compile_unit)).toBe("DW_TAG_compile_unit");
    expect(tagName(DW_TAG.base_type)).toBe("DW_TAG_base_type");
    expect(tagName(DW_TAG.member)).toBe("DW_TAG_member");
    expect(tagName(DW_TAG.subprogram)).toBe("DW_TAG_subprogram");
  });

  it("returns hex for unknown tags", () => {
    expect(tagName(0xff)).toBe("DW_TAG_0xff");
  });
});

describe("attrName", () => {
  it("returns known attribute names", () => {
    expect(attrName(DW_AT.name)).toBe("DW_AT_name");
    expect(attrName(DW_AT.type)).toBe("DW_AT_type");
    expect(attrName(DW_AT.producer)).toBe("DW_AT_producer");
  });

  it("returns hex for unknown attributes", () => {
    expect(attrName(0xff)).toBe("DW_AT_0xff");
  });
});

describe("getAttr", () => {
  const die: DwarfDIE = {
    offset: 0,
    tag: DW_TAG.base_type,
    attributes: [{ name: DW_AT.name, form: DW_FORM.string, value: "i32" }],
    children: [],
  };

  it("returns attribute when present", () => {
    const attr = getAttr(die, DW_AT.name);
    expect(attr).toBeDefined();
    expect(attr!.value).toBe("i32");
  });

  it("returns undefined when not present", () => {
    expect(getAttr(die, DW_AT.type)).toBeUndefined();
  });
});

describe("walkDIEs", () => {
  it("yields all DIEs in depth-first order", () => {
    const child1: DwarfDIE = { offset: 10, tag: DW_TAG.base_type, attributes: [], children: [] };
    const child2: DwarfDIE = { offset: 20, tag: DW_TAG.base_type, attributes: [], children: [] };
    const root: DwarfDIE = { offset: 0, tag: DW_TAG.compile_unit, attributes: [], children: [child1, child2] };

    const offsets = [...walkDIEs(root)].map((d) => d.offset);
    expect(offsets).toEqual([0, 10, 20]);
  });

  it("handles nested children", () => {
    const grandchild: DwarfDIE = { offset: 30, tag: DW_TAG.member, attributes: [], children: [] };
    const child: DwarfDIE = { offset: 10, tag: DW_TAG.class_type, attributes: [], children: [grandchild] };
    const root: DwarfDIE = { offset: 0, tag: DW_TAG.compile_unit, attributes: [], children: [child] };

    const offsets = [...walkDIEs(root)].map((d) => d.offset);
    expect(offsets).toEqual([0, 10, 30]);
  });
});

describe("findDIEsByTag", () => {
  it("finds all DIEs with matching tag", () => {
    const bt1: DwarfDIE = { offset: 10, tag: DW_TAG.base_type, attributes: [], children: [] };
    const bt2: DwarfDIE = { offset: 20, tag: DW_TAG.base_type, attributes: [], children: [] };
    const cls: DwarfDIE = { offset: 15, tag: DW_TAG.class_type, attributes: [], children: [] };
    const root: DwarfDIE = { offset: 0, tag: DW_TAG.compile_unit, attributes: [], children: [bt1, cls, bt2] };

    const baseTypes = findDIEsByTag(root, DW_TAG.base_type);
    expect(baseTypes).toHaveLength(2);
    expect(baseTypes.map((d) => d.offset)).toEqual([10, 20]);
  });

  it("returns empty for no matches", () => {
    const root: DwarfDIE = { offset: 0, tag: DW_TAG.compile_unit, attributes: [], children: [] };
    expect(findDIEsByTag(root, DW_TAG.member)).toHaveLength(0);
  });
});

describe("buildOffsetMap", () => {
  it("builds offset-to-DIE map", () => {
    const child: DwarfDIE = { offset: 10, tag: DW_TAG.base_type, attributes: [], children: [] };
    const root: DwarfDIE = { offset: 0, tag: DW_TAG.compile_unit, attributes: [], children: [child] };

    const map = buildOffsetMap(root);
    expect(map.size).toBe(2);
    expect(map.get(0)).toBe(root);
    expect(map.get(10)).toBe(child);
  });
});
