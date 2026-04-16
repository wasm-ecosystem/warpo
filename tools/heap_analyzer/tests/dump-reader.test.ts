import { describe, it, expect } from "vitest";
import { parseDumpFile } from "../src/dump-reader.js";
import { DUMP_HEADER_SIZE, DUMP_MAGIC_BYTES } from "../src/constants.js";

function createDumpBuffer(opts?: {
  magic?: Uint8Array;
  version?: number;
  dataEnd?: number;
  heapBase?: number;
  stackPointer?: number;
  memorySize?: number;
}): ArrayBuffer {
  const {
    magic = DUMP_MAGIC_BYTES,
    version = 1,
    dataEnd = 1024,
    heapBase = 4096,
    stackPointer = 3072,
    memorySize = 64,
  } = opts ?? {};

  const totalSize = DUMP_HEADER_SIZE + memorySize;
  const buffer = new ArrayBuffer(totalSize);
  const view = new DataView(buffer);
  const bytes = new Uint8Array(buffer);

  // Magic
  bytes.set(magic, 0);
  // Version
  view.setUint32(4, version, true);
  // dataEnd
  view.setUint32(8, dataEnd, true);
  // heapBase
  view.setUint32(12, heapBase, true);
  // stackPointer
  view.setUint32(16, stackPointer, true);
  // Reserved bytes 20-23 are already zero

  // Fill memory region with recognizable pattern
  for (let i = DUMP_HEADER_SIZE; i < totalSize; i++) {
    bytes[i] = i & 0xff;
  }

  return buffer;
}

describe("parseDumpFile", () => {
  it("parses a valid dump file", () => {
    const buffer = createDumpBuffer({
      dataEnd: 2048,
      heapBase: 8192,
      stackPointer: 6000,
      memorySize: 128,
    });

    const result = parseDumpFile(buffer);

    expect(result.metadata.dataEnd).toBe(2048);
    expect(result.metadata.heapBase).toBe(8192);
    expect(result.metadata.stackPointer).toBe(6000);
    expect(result.memory).toBeInstanceOf(DataView);
    expect(result.memory.byteLength).toBe(128);
  });

  it("throws on corrupt magic", () => {
    const buffer = createDumpBuffer({
      magic: new Uint8Array([0x00, 0x00, 0x00, 0x00]),
    });

    expect(() => parseDumpFile(buffer)).toThrow(/Invalid dump magic/);
  });

  it("throws on truncated file", () => {
    const buffer = new ArrayBuffer(10); // less than DUMP_HEADER_SIZE
    expect(() => parseDumpFile(buffer)).toThrow(/too small/);
  });

  it("throws on wrong version", () => {
    const buffer = createDumpBuffer({ version: 2 });
    expect(() => parseDumpFile(buffer)).toThrow(/Unsupported dump version/);
  });

  it("memory DataView covers entire buffer", () => {
    const memorySize = 256;
    const buffer = createDumpBuffer({ memorySize });

    const result = parseDumpFile(buffer);

    expect(result.memory.byteLength).toBe(memorySize);
    // Verify we can read memory content (offset 0 in header-stripped view = wasm address 0)
    const expectedByte = DUMP_HEADER_SIZE & 0xff;
    expect(result.memory.getUint8(0)).toBe(expectedByte);
  });

  it("handles minimum valid dump (header only, no memory)", () => {
    const buffer = createDumpBuffer({ memorySize: 0 });
    const result = parseDumpFile(buffer);
    expect(result.memory.byteLength).toBe(0);
  });
});
