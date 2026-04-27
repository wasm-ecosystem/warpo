import assert from "node:assert/strict";
import { before, it } from "node:test";
import { parseDumpFile } from "../src/dumpReader.js";
import { DUMP_HEADER_SIZE } from "../src/constants.js";
import { describeIntegration } from "./testHelper.js";

describeIntegration("parseDumpFile", (ctx) => {
  let buffer: ArrayBuffer;

  before(() => {
    ctx.compileFixture();
    ctx.generateFixtureDump();
    buffer = ctx.loadFixtureDumpBuffer();
  });

  it("parses metadata from generated dump", () => {
    const result = parseDumpFile(buffer);
    const header = new DataView(buffer);
    assert.strictEqual(result.rtGlobals.dataEnd, header.getUint32(8, true));
    assert.strictEqual(result.rtGlobals.heapBase, header.getUint32(12, true));
    assert.strictEqual(result.rtGlobals.stackPointer, header.getUint32(16, true));
    assert.ok(result.rtGlobals.dataEnd > 0);
    assert.ok(result.rtGlobals.heapBase > result.rtGlobals.dataEnd);
    assert.ok(result.rtGlobals.stackPointer <= result.rtGlobals.heapBase);
  });

  it("returns a DataView over the memory region", () => {
    const result = parseDumpFile(buffer);
    assert.ok(result.memory instanceof DataView);
  });

  it("memory size equals file size minus header", () => {
    const result = parseDumpFile(buffer);
    assert.strictEqual(result.memory.byteLength, buffer.byteLength - DUMP_HEADER_SIZE);
    assert.strictEqual(result.memory.byteLength, 65536);
  });

  it("memory content is readable at address 0", () => {
    const result = parseDumpFile(buffer);
    assert.doesNotThrow(() => result.memory.getUint8(0));
  });

  it("throws on truncated input", () => {
    const truncated = buffer.slice(0, 10);
    assert.throws(() => parseDumpFile(truncated), /too small/);
  });

  it("throws on corrupt magic", () => {
    const corrupt = buffer.slice(0);
    new Uint8Array(corrupt).set([0, 0, 0, 0], 0);
    assert.throws(() => parseDumpFile(corrupt), /Invalid dump magic/);
  });

  it("throws on wrong version", () => {
    const badVersion = buffer.slice(0);
    new DataView(badVersion).setUint32(4, 99, true);
    assert.throws(() => parseDumpFile(badVersion), /Unsupported dump version/);
  });
});
