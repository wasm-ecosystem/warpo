/**
 * DWARF debug information parser for WebAssembly files.
 *
 * Parses DWARF4 debug sections (debug_info, debug_abbrev, debug_str) from
 * wasm custom sections. Uses wasmparser to decode the wasm binary and
 * extract custom sections, then performs low-level DWARF parsing on the
 * raw bytes.
 */

import { BinaryReader, BinaryReaderState, ISectionInformation, SectionCode } from "wasmparser";

// ── DWARF constants ──────────────────────────────────────────────────────────

/** DWARF tag values (DW_TAG_*). */
export const DW_TAG = {
  compile_unit: 0x11,
  class_type: 0x02,
  inheritance: 0x1c,
  member: 0x0d,
  base_type: 0x24,
  template_type_parameter: 0x2f,
  formal_parameter: 0x05,
  lexical_block: 0x0b,
  subprogram: 0x2e,
  variable: 0x34,
} as const;

/** DWARF attribute names (DW_AT_*). */
export const DW_AT = {
  name: 0x03,
  location: 0x02,
  byte_size: 0x0b,
  producer: 0x25,
  type: 0x49,
  data_member_location: 0x38,
  signature: 0x69,
  low_pc: 0x11,
  high_pc: 0x12,
} as const;

/** DWARF form values (DW_FORM_*). */
export const DW_FORM = {
  addr: 0x01,
  data4: 0x06,
  string: 0x08,
  strp: 0x0e,
  ref4: 0x13,
} as const;

// ── Types ────────────────────────────────────────────────────────────────────

export interface AbbrevAttribute {
  name: number; // DW_AT_* value
  form: number; // DW_FORM_* value
}

export interface AbbrevEntry {
  code: number;
  tag: number; // DW_TAG_* value
  hasChildren: boolean;
  attributes: AbbrevAttribute[];
}

export type AbbrevTable = Map<number, AbbrevEntry>;

export interface DwarfAttributeValue {
  name: number; // DW_AT_* value
  form: number; // DW_FORM_* value
  value: string | number;
}

export interface DwarfDIE {
  offset: number; // byte offset within .debug_info
  tag: number; // DW_TAG_* value
  attributes: DwarfAttributeValue[];
  children: DwarfDIE[];
}

export interface CompilationUnit {
  unitLength: number;
  version: number;
  abbrevOffset: number;
  addressSize: number;
  rootDIE: DwarfDIE;
}

export interface DwarfInfo {
  /** Parsed .debug_str string table (offset → string). */
  stringTable: Map<number, string>;
  /** Parsed abbreviation tables. */
  abbreviations: AbbrevTable;
  /** All compilation units in .debug_info. */
  compilationUnits: CompilationUnit[];
}

class BufferReader {
  readonly view: DataView;
  offset: number;

  constructor(data: DataView | Uint8Array, offset: number = 0) {
    this.view = data instanceof Uint8Array ? new DataView(data.buffer, data.byteOffset, data.byteLength) : data;
    this.offset = offset;
  }

  get length(): number {
    return this.view.byteLength;
  }

  readUint8(): number {
    return this.view.getUint8(this.offset++);
  }

  readUint16LE(): number {
    const val = this.view.getUint16(this.offset, true);
    this.offset += 2;
    return val;
  }

  readUint32LE(): number {
    const val = this.view.getUint32(this.offset, true);
    this.offset += 4;
    return val;
  }

  readULEB128(): number {
    let result = 0;
    let shift = 0;
    let byte: number;
    const start = this.offset;
    do {
      if (this.offset >= this.view.byteLength) {
        throw new Error(`ULEB128 read past end of buffer at offset ${start}`);
      }
      byte = this.view.getUint8(this.offset++);
      result |= (byte & 0x7f) << shift;
      shift += 7;
    } while (byte & 0x80);
    return result >>> 0;
  }

  readString(): string {
    let end = this.offset;
    while (end < this.view.byteLength && this.view.getUint8(end) !== 0) {
      end++;
    }
    const bytes = new Uint8Array(this.view.buffer, this.view.byteOffset + this.offset, end - this.offset);
    const value = new TextDecoder().decode(bytes);
    this.offset = end + 1; // skip null terminator
    return value;
  }
}

// ── Raw section extraction ───────────────────────────────────────────────────

interface CustomSection {
  name: string;
  payload: Uint8Array;
}

/**
 * Extract custom sections from a wasm binary using wasmparser's BinaryReader.
 * The reader validates wasm structure while iterating through sections.
 */
export function extractCustomSections(wasmBinary: Uint8Array): CustomSection[] {
  const reader = new BinaryReader();
  reader.setData(wasmBinary.buffer as ArrayBuffer, wasmBinary.byteOffset, wasmBinary.byteLength);

  const sections: CustomSection[] = [];
  let currentSectionName: string | undefined;

  while (reader.read()) {
    switch (reader.state) {
      case BinaryReaderState.BEGIN_SECTION: {
        const info = reader.result as ISectionInformation;
        if (info.id === SectionCode.Custom && info.name) {
          currentSectionName = new TextDecoder().decode(info.name);
        } else {
          currentSectionName = undefined;
          reader.skipSection();
        }
        break;
      }
      case BinaryReaderState.SECTION_RAW_DATA: {
        if (currentSectionName !== undefined) {
          const rawData = reader.result as Uint8Array;
          sections.push({
            name: currentSectionName,
            payload: new Uint8Array(rawData),
          });
          currentSectionName = undefined;
        }
        break;
      }
      case BinaryReaderState.ERROR: {
        throw new Error("Failed to parse wasm binary");
      }
    }
  }

  return sections;
}

// ── Abbreviation table parsing ───────────────────────────────────────────────

/**
 * Parse a .debug_abbrev section into an abbreviation table.
 */
export function parseAbbrevTable(data: Uint8Array): AbbrevTable {
  const table: AbbrevTable = new Map();
  const reader = new BufferReader(data);

  while (reader.offset < reader.length) {
    const code = reader.readULEB128();
    if (code === 0) {
      break;
    }

    const tag = reader.readULEB128();
    const hasChildren = reader.readUint8() === 1;

    const attributes: AbbrevAttribute[] = [];
    for (;;) {
      const name = reader.readULEB128();
      const form = reader.readULEB128();
      if (name === 0 && form === 0) {
        break;
      }
      attributes.push({ name, form });
    }

    table.set(code, { code, tag, hasChildren, attributes });
  }

  return table;
}

// ── String table parsing ─────────────────────────────────────────────────────

function parseStringTable(data: Uint8Array): Map<number, string> {
  const table = new Map<number, string>();
  const decoder = new TextDecoder();
  let offset = 0;
  while (offset < data.length) {
    let end = offset;
    while (end < data.length && data[end] !== 0) {
      end++;
    }
    table.set(offset, decoder.decode(data.subarray(offset, end)));
    offset = end + 1;
  }
  return table;
}

// ── debug_info parsing ───────────────────────────────────────────────────────

// eslint-disable-next-line sonarjs/function-return-type
function readAttributeValue(
  reader: BufferReader,
  form: number,
  addressSize: number,
  stringTable: Map<number, string>,
  cuOffset: number
): string | number {
  switch (form) {
    case DW_FORM.string: {
      return reader.readString();
    }
    case DW_FORM.data4: {
      return reader.readUint32LE();
    }
    case DW_FORM.strp: {
      const strOffset = reader.readUint32LE();
      const str = stringTable.get(strOffset);
      if (str === undefined) {
        throw new Error(`String not found at offset ${strOffset} in .debug_str`);
      }
      return str;
    }
    case DW_FORM.ref4: {
      return cuOffset + reader.readUint32LE();
    }
    case DW_FORM.addr: {
      if (addressSize === 4) {
        return reader.readUint32LE();
      }
      throw new Error(`Unsupported address size: ${addressSize}`);
    }
    default: {
      throw new Error(`Unsupported DW_FORM: 0x${form.toString(16)}`);
    }
  }
}

/**
 * Parse all compilation units from a .debug_info section.
 */
export function parseDebugInfo(
  infoData: Uint8Array,
  abbrevTable: AbbrevTable,
  stringTable: Map<number, string>
): CompilationUnit[] {
  const units: CompilationUnit[] = [];
  const reader = new BufferReader(infoData);

  while (reader.offset < reader.length) {
    const unitStart = reader.offset;

    const unitLength = reader.readUint32LE();
    const version = reader.readUint16LE();
    const abbrevOffset = reader.readUint32LE();
    const addressSize = reader.readUint8();

    const unitEnd = unitStart + 4 + unitLength;

    const die = parseDIETree(reader, unitEnd, abbrevTable, addressSize, stringTable, unitStart);

    if (die) {
      units.push({
        unitLength,
        version,
        abbrevOffset,
        addressSize,
        rootDIE: die,
      });
    }

    reader.offset = unitEnd;
  }

  return units;
}

interface ParsedDIE {
  die: DwarfDIE;
  hasChildren: boolean;
}

function parseSingleDIE(
  reader: BufferReader,
  abbrevTable: AbbrevTable,
  addressSize: number,
  stringTable: Map<number, string>,
  cuOffset: number
): ParsedDIE | null {
  const dieOffset = reader.offset;
  const code = reader.readULEB128();

  if (code === 0) {
    return null;
  }

  const abbrev = abbrevTable.get(code);
  if (!abbrev) {
    throw new Error(`Unknown abbreviation code ${code} at offset ${dieOffset}`);
  }

  const attributes: DwarfAttributeValue[] = [];
  for (const attr of abbrev.attributes) {
    const value = readAttributeValue(reader, attr.form, addressSize, stringTable, cuOffset);
    attributes.push({ name: attr.name, form: attr.form, value });
  }

  return {
    die: { offset: dieOffset, tag: abbrev.tag, attributes, children: [] },
    hasChildren: abbrev.hasChildren,
  };
}

function parseChildren(
  reader: BufferReader,
  unitEnd: number,
  abbrevTable: AbbrevTable,
  addressSize: number,
  stringTable: Map<number, string>,
  cuOffset: number
): DwarfDIE[] {
  const children: DwarfDIE[] = [];

  while (reader.offset < unitEnd) {
    const result = parseSingleDIE(reader, abbrevTable, addressSize, stringTable, cuOffset);
    if (!result) {
      break;
    }

    if (result.hasChildren) {
      result.die.children = parseChildren(reader, unitEnd, abbrevTable, addressSize, stringTable, cuOffset);
    }

    children.push(result.die);
  }

  return children;
}

function parseDIETree(
  reader: BufferReader,
  unitEnd: number,
  abbrevTable: AbbrevTable,
  addressSize: number,
  stringTable: Map<number, string>,
  cuOffset: number
): DwarfDIE | null {
  const result = parseSingleDIE(reader, abbrevTable, addressSize, stringTable, cuOffset);
  if (!result) {
    return null;
  }

  if (result.hasChildren) {
    result.die.children = parseChildren(reader, unitEnd, abbrevTable, addressSize, stringTable, cuOffset);
  }

  return result.die;
}

// ── High-level API ───────────────────────────────────────────────────────────

/**
 * Parse DWARF debug information from a WebAssembly binary.
 *
 * @param wasmBinary The raw wasm file content as a Uint8Array or ArrayBuffer.
 * @returns Parsed DWARF info including compilation units, abbreviations, and string table.
 * @throws If required DWARF sections are missing or malformed.
 *
 */
export function parseDwarf(wasmBinary: Uint8Array | ArrayBuffer): DwarfInfo {
  const binary = wasmBinary instanceof Uint8Array ? wasmBinary : new Uint8Array(wasmBinary);

  const customSections = extractCustomSections(binary);

  const debugAbbrev = customSections.find((s) => s.name === "debug_abbrev");
  const debugInfo = customSections.find((s) => s.name === "debug_info");
  const debugStr = customSections.find((s) => s.name === "debug_str");

  if (!debugAbbrev) {
    throw new Error("Missing .debug_abbrev section in wasm binary");
  }
  if (!debugInfo) {
    throw new Error("Missing .debug_info section in wasm binary");
  }

  const stringTable = parseStringTable(debugStr?.payload ?? new Uint8Array(0));
  const abbreviations = parseAbbrevTable(debugAbbrev.payload);
  const compilationUnits = parseDebugInfo(debugInfo.payload, abbreviations, stringTable);

  return { stringTable, abbreviations, compilationUnits };
}

// ── Convenience helpers ──────────────────────────────────────────────────────

/** Human-readable tag name for known DWARF tags. */
export function tagName(tag: number): string {
  for (const [name, value] of Object.entries(DW_TAG)) {
    if (value === tag) {
      return `DW_TAG_${name}`;
    }
  }
  return `DW_TAG_0x${tag.toString(16)}`;
}

/** Human-readable attribute name for known DWARF attributes. */
export function attrName(attr: number): string {
  for (const [name, value] of Object.entries(DW_AT)) {
    if (value === attr) {
      return `DW_AT_${name}`;
    }
  }
  return `DW_AT_0x${attr.toString(16)}`;
}

/**
 * Get a named attribute value from a DIE, or undefined if not present.
 */
export function getAttr(die: DwarfDIE, attrId: number): DwarfAttributeValue | undefined {
  return die.attributes.find((a) => a.name === attrId);
}

/**
 * Depth-first iterate all DIEs in a tree starting from root.
 */
export function* walkDIEs(root: DwarfDIE): Generator<DwarfDIE> {
  const stack: DwarfDIE[] = [root];
  while (stack.length > 0) {
    const die = stack.pop();
    yield die;
    for (let i = die.children.length - 1; i >= 0; i--) {
      stack.push(die.children[i]);
    }
  }
}

/**
 * Find all DIEs with a specific tag in the tree (depth-first).
 */
export function findDIEsByTag(root: DwarfDIE, tag: number): DwarfDIE[] {
  const results: DwarfDIE[] = [];
  for (const die of walkDIEs(root)) {
    if (die.tag === tag) {
      results.push(die);
    }
  }
  return results;
}

/**
 * Build a map from DIE offset to DIE for resolving DW_FORM_ref4 references.
 */
export function buildOffsetMap(root: DwarfDIE): Map<number, DwarfDIE> {
  const map = new Map<number, DwarfDIE>();
  for (const die of walkDIEs(root)) {
    map.set(die.offset, die);
  }
  return map;
}
