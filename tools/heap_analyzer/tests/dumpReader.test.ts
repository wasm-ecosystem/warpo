import { parseDumpFile } from "../src/dumpReader.js";
import { DUMP_HEADER_SIZE } from "../src/constants.js";
import { compileFixture, describeIntegration, generateFixtureDump, loadFixtureDumpBuffer } from "./testHelper.js";

describeIntegration("parseDumpFile", () => {
  let buffer: ArrayBuffer;

  beforeAll(() => {
    compileFixture();
    generateFixtureDump();
    buffer = loadFixtureDumpBuffer();
  });

  it("parses metadata from generated dump", () => {
    const result = parseDumpFile(buffer);
    const header = new DataView(buffer);
    expect(result.rtGlobals.dataEnd).toBe(header.getUint32(8, true));
    expect(result.rtGlobals.heapBase).toBe(header.getUint32(12, true));
    expect(result.rtGlobals.stackPointer).toBe(header.getUint32(16, true));
    expect(result.rtGlobals.dataEnd).toBeGreaterThan(0);
    expect(result.rtGlobals.heapBase).toBeGreaterThan(result.rtGlobals.dataEnd);
    expect(result.rtGlobals.stackPointer).toBeLessThanOrEqual(result.rtGlobals.heapBase);
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
