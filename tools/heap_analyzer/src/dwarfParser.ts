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
  /** Parsed .debug_str string table. */
  stringTable: Uint8Array;
  /** Parsed abbreviation tables. */
  abbreviations: AbbrevTable;
  /** All compilation units in .debug_info. */
  compilationUnits: CompilationUnit[];
}

// ── Raw section extraction ───────────────────────────────────────────────────

interface CustomSection {
  name: string;
  payload: Uint8Array;
}

/**
 * Read an unsigned LEB128 value from a buffer.
 * @returns The decoded value and number of bytes consumed.
 */
function readULEB128(buf: Uint8Array, offset: number): { value: number; size: number } {
  let result = 0;
  let shift = 0;
  let i = offset;
  let byte: number;
  do {
    if (i >= buf.length) {
      throw new Error(`ULEB128 read past end of buffer at offset ${offset}`);
    }
    byte = buf[i++];
    result |= (byte & 0x7f) << shift;
    shift += 7;
  } while (byte & 0x80);
  return { value: result >>> 0, size: i - offset };
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
  let pos = 0;

  while (pos < data.length) {
    const code = readULEB128(data, pos);
    pos += code.size;
    if (code.value === 0) {
      break;
    } // end of table

    const tag = readULEB128(data, pos);
    pos += tag.size;

    const hasChildren = data[pos++] === 1;

    const attributes: AbbrevAttribute[] = [];
    for (;;) {
      const attrName = readULEB128(data, pos);
      pos += attrName.size;
      const attrForm = readULEB128(data, pos);
      pos += attrForm.size;
      if (attrName.value === 0 && attrForm.value === 0) {
        break;
      }
      attributes.push({ name: attrName.value, form: attrForm.value });
    }

    table.set(code.value, {
      code: code.value,
      tag: tag.value,
      hasChildren,
      attributes,
    });
  }

  return table;
}

// ── debug_info parsing ───────────────────────────────────────────────────────

/**
 * Read a null-terminated UTF-8 string from a buffer.
 */
function readString(buf: Uint8Array, offset: number): { value: string; size: number } {
  let end = offset;
  while (end < buf.length && buf[end] !== 0) {
    end++;
  }
  const value = new TextDecoder().decode(buf.subarray(offset, end));
  return { value, size: end - offset + 1 }; // +1 for the null terminator
}

/**
 * Read an attribute value according to its DW_FORM encoding.
 */
function readAttributeValue(
  data: Uint8Array,
  view: DataView,
  offset: number,
  form: number,
  addressSize: number,
  stringTable: Uint8Array,
  cuOffset: number
): { value: string | number; size: number } {
  switch (form) {
    case DW_FORM.string: {
      return readString(data, offset);
    }
    case DW_FORM.data4: {
      return { value: view.getUint32(offset, true), size: 4 };
    }
    case DW_FORM.strp: {
      const strOffset = view.getUint32(offset, true);
      const str = readString(stringTable, strOffset);
      return { value: str.value, size: 4 };
    }
    case DW_FORM.ref4: {
      return { value: cuOffset + view.getUint32(offset, true), size: 4 };
    }
    case DW_FORM.addr: {
      if (addressSize === 4) {
        return { value: view.getUint32(offset, true), size: 4 };
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
  stringTable: Uint8Array
): CompilationUnit[] {
  const units: CompilationUnit[] = [];
  const view = new DataView(infoData.buffer, infoData.byteOffset, infoData.byteLength);
  let offset = 0;

  while (offset < infoData.length) {
    const unitStart = offset;

    // Compilation unit header
    const unitLength = view.getUint32(offset, true);
    offset += 4;
    const version = view.getUint16(offset, true);
    offset += 2;
    const abbrevOffset = view.getUint32(offset, true);
    offset += 4;
    const addressSize = infoData[offset++];

    const unitEnd = unitStart + 4 + unitLength; // unitLength doesn't include the 4-byte length field

    // Parse DIEs recursively
    const { die } = parseDIETree(
      infoData,
      view,
      offset,
      unitEnd,
      abbrevTable,
      addressSize,
      stringTable,
      unitStart
    );

    if (die) {
      units.push({
        unitLength,
        version,
        abbrevOffset,
        addressSize,
        rootDIE: die,
      });
    }

    offset = unitEnd;
  }

  return units;
}

interface ParseResult {
  die: DwarfDIE | null;
  nextOffset: number;
}

/**
 * Parse a DIE and its children from debug_info.
 */
function parseChildren(
  data: Uint8Array,
  view: DataView,
  pos: number,
  unitEnd: number,
  abbrevTable: AbbrevTable,
  addressSize: number,
  stringTable: Uint8Array,
  cuOffset: number
): { children: DwarfDIE[]; nextOffset: number } {
  const children: DwarfDIE[] = [];

  while (pos < unitEnd) {
    const code = readULEB128(data, pos);
    if (code.value === 0) {
      pos += code.size;
      break;
    }

    const childAbbrev = abbrevTable.get(code.value);
    if (!childAbbrev) {
      throw new Error(`Unknown abbreviation code ${code.value} at offset ${pos}`);
    }

    const childResult = parseSingleDIE(data, view, pos, abbrevTable, addressSize, stringTable, cuOffset);
    if (!childResult.die) {
      pos = childResult.nextOffset;
      continue;
    }

    const childDie = childResult.die;
    pos = childResult.nextOffset;

    if (childAbbrev.hasChildren) {
      const nested = parseChildren(data, view, pos, unitEnd, abbrevTable, addressSize, stringTable, cuOffset);
      childDie.children = nested.children;
      pos = nested.nextOffset;
    }

    children.push(childDie);
  }

  return { children, nextOffset: pos };
}

function parseDIETree(
  data: Uint8Array,
  view: DataView,
  offset: number,
  unitEnd: number,
  abbrevTable: AbbrevTable,
  addressSize: number,
  stringTable: Uint8Array,
  cuOffset: number
): ParseResult & { siblings: DwarfDIE[] } {
  const firstResult = parseSingleDIE(data, view, offset, abbrevTable, addressSize, stringTable, cuOffset);
  if (!firstResult.die) {
    return { die: null, nextOffset: firstResult.nextOffset, siblings: [] };
  }

  const rootDie = firstResult.die;
  let pos = firstResult.nextOffset;

  const abbrev = abbrevTable.get(readULEB128(data, offset).value);
  if (abbrev?.hasChildren) {
    const result = parseChildren(data, view, pos, unitEnd, abbrevTable, addressSize, stringTable, cuOffset);
    rootDie.children = result.children;
    pos = result.nextOffset;
  }

  return { die: rootDie, nextOffset: pos, siblings: [] };
}

/**
 * Parse a single DIE (no children) and return it with the next offset.
 */
function parseSingleDIE(
  data: Uint8Array,
  view: DataView,
  offset: number,
  abbrevTable: AbbrevTable,
  addressSize: number,
  stringTable: Uint8Array,
  cuOffset: number
): ParseResult {
  const dieOffset = offset;
  const code = readULEB128(data, offset);
  offset += code.size;

  if (code.value === 0) {
    return { die: null, nextOffset: offset };
  }

  const abbrev = abbrevTable.get(code.value);
  if (!abbrev) {
    throw new Error(`Unknown abbreviation code ${code.value} at offset ${dieOffset}`);
  }

  const attributes: DwarfAttributeValue[] = [];
  for (const attr of abbrev.attributes) {
    const val = readAttributeValue(data, view, offset, attr.form, addressSize, stringTable, cuOffset);
    attributes.push({ name: attr.name, form: attr.form, value: val.value });
    offset += val.size;
  }

  return {
    die: {
      offset: dieOffset,
      tag: abbrev.tag,
      attributes,
      children: [],
    },
    nextOffset: offset,
  };
}

// ── High-level API ───────────────────────────────────────────────────────────

/**
 * Parse DWARF debug information from a WebAssembly binary.
 *
 * @param wasmBinary The raw wasm file content as a Uint8Array or ArrayBuffer.
 * @returns Parsed DWARF info including compilation units, abbreviations, and string table.
 * @throws If required DWARF sections are missing or malformed.
 *
 * @example
 * ```ts
 * import { readFileSync } from "fs";
 * import { parseDwarf } from "./dwarf-parser.js";
 *
 * const wasm = readFileSync("module.wasm");
 * const dwarf = parseDwarf(new Uint8Array(wasm));
 *
 * for (const unit of dwarf.compilationUnits) {
 *   console.log("Compilation unit version:", unit.version);
 *   for (const child of unit.rootDIE.children) {
 *     console.log("  DIE tag:", child.tag);
 *   }
 * }
 * ```
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

  const stringTable = debugStr?.payload ?? new Uint8Array(0);
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
