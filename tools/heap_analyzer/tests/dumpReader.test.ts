import { readFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { parseDumpFile } from "../src/dumpReader.js";
import { DUMP_HEADER_SIZE } from "../src/constants.js";

const FIXTURE_PATH = resolve(
  dirname(fileURLToPath(import.meta.url)),
  "fixture/memory.dump",
);

function loadFixture(): ArrayBuffer {
  const buf = readFileSync(FIXTURE_PATH);
  return buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.byteLength);
}

describe("parseDumpFile", () => {
  let buffer: ArrayBuffer;

  beforeAll(() => {
    buffer = loadFixture();
  });

  it("parses metadata from real dump", () => {
    const result = parseDumpFile(buffer);
    expect(result.metadata.dataEnd).toBe(3464);
    expect(result.metadata.heapBase).toBe(36232);
    expect(result.metadata.stackPointer).toBe(36144);
  });

  it("returns a DataView over the memory region", () => {
    const result = parseDumpFile(buffer);
    expect(result.memory).toBeInstanceOf(DataView);
  });

  it("memory size equals file size minus header", () => {
    const result = parseDumpFile(buffer);
    expect(result.memory.byteLength).toBe(buffer.byteLength - DUMP_HEADER_SIZE);
    expect(result.memory.byteLength).toBe(65536);
  });

  it("memory content is readable at address 0", () => {
    const result = parseDumpFile(buffer);
    expect(() => result.memory.getUint8(0)).not.toThrow();
  });

  it("throws on truncated input", () => {
    const truncated = buffer.slice(0, 10);
    expect(() => parseDumpFile(truncated)).toThrow(/too small/);
  });

  it("throws on corrupt magic", () => {
    const corrupt = buffer.slice(0);
    new Uint8Array(corrupt).set([0, 0, 0, 0], 0);
    expect(() => parseDumpFile(corrupt)).toThrow(/Invalid dump magic/);
  });

  it("throws on wrong version", () => {
    const badVersion = buffer.slice(0);
    new DataView(badVersion).setUint32(4, 99, true);
    expect(() => parseDumpFile(badVersion)).toThrow(/Unsupported dump version/);
  });
});
