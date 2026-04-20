import { readFileSync } from "node:fs";
import { resolve, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import { parseDumpFile } from "../src/dumpReader.js";
import { walkBlocks } from "../src/tlsf.js";
import { FREE, TAGS_MASK, TOTAL_OVERHEAD, BLOCK_OVERHEAD, AL_MASK, ROOT_SIZE, COLOR_MASK } from "../src/constants.js";
import type { ObjectHeader, ParsedDump } from "../src/types.js";

const FIXTURE_PATH = resolve(dirname(fileURLToPath(import.meta.url)), "fixture/memory.dump");

function loadFixture(): ParsedDump {
  const buf = readFileSync(FIXTURE_PATH);
  const buffer = buf.buffer.slice(buf.byteOffset, buf.byteOffset + buf.byteLength);
  return parseDumpFile(buffer);
}

describe("walkBlocks", () => {
  let dump: ParsedDump;
  let blocks: ObjectHeader[];

  beforeAll(() => {
    dump = loadFixture();
    blocks = walkBlocks(dump.memory, dump.metadata.heapBase);
  });

  it("returns 110 used blocks from the fixture", () => {
    expect(blocks).toHaveLength(110);
  });

  it("all returned blocks are used (not free)", () => {
    for (const b of blocks) {
      expect(b.mmInfo & FREE).toBe(0);
    }
  });

  it("all blocks have positive size", () => {
    for (const b of blocks) {
      expect(b.mmInfo & ~TAGS_MASK).toBeGreaterThan(0);
    }
  });

  it("payloadPtr increases monotonically", () => {
    for (let i = 1; i < blocks.length; i++) {
      expect(blocks[i].payloadPtr).toBeGreaterThan(blocks[i - 1].payloadPtr);
    }
  });

  it("all payloadPtrs are within memory bounds", () => {
    for (const b of blocks) {
      expect(b.payloadPtr).toBeLessThan(dump.memory.byteLength);
    }
  });

  it("gcColor is in range [0, 3]", () => {
    for (const b of blocks) {
      expect(b.gcColor).toBeGreaterThanOrEqual(0);
      expect(b.gcColor).toBeLessThanOrEqual(COLOR_MASK);
    }
  });

  it("first block payloadPtr matches computed firstBlock + TOTAL_OVERHEAD", () => {
    const heapBase = dump.metadata.heapBase;
    const tlsfRoot = (heapBase + AL_MASK) & ~AL_MASK;
    const afterRoot = (tlsfRoot + ROOT_SIZE + AL_MASK) & ~AL_MASK;
    const firstBlock = ((afterRoot + BLOCK_OVERHEAD + AL_MASK) & ~AL_MASK) - BLOCK_OVERHEAD;
    expect(blocks[0].payloadPtr).toBe(firstBlock + TOTAL_OVERHEAD);
  });
});

describe("object header parsing", () => {
  let blocks: ObjectHeader[];

  beforeAll(() => {
    const dump = loadFixture();
    blocks = walkBlocks(dump.memory, dump.metadata.heapBase);
  });

  it("contains expected rtId values", () => {
    const rtIds = new Set(blocks.map((b) => b.rtId));
    expect(rtIds.has(1)).toBe(true);
    expect(rtIds.has(2)).toBe(true);
    expect(rtIds.has(13)).toBe(true);
  });

  it("rtId distribution matches fixture", () => {
    const counts: Record<number, number> = {};
    for (const b of blocks) {
      counts[b.rtId] = (counts[b.rtId] || 0) + 1;
    }
    expect(counts[1]).toBe(29);
    expect(counts[2]).toBe(3);
    expect(counts[13]).toBe(31);
  });

  it("block at index 4 has rtId 14, rtSize 12, blockSize 28", () => {
    expect(blocks[4].rtId).toBe(14);
    expect(blocks[4].rtSize).toBe(12);
    expect(blocks[4].mmInfo & ~TAGS_MASK).toBe(28);
  });

  it("blocks with rtId 2 have non-zero rtSize", () => {
    const strings = blocks.filter((b) => b.rtId === 2);
    expect(strings).toHaveLength(3);
    for (const s of strings) {
      expect(s.rtSize).toBeGreaterThan(0);
    }
  });

  it("blocks with rtId 10 all have rtSize 8", () => {
    const items = blocks.filter((b) => b.rtId === 10);
    expect(items).toHaveLength(13);
    for (const item of items) {
      expect(item.rtSize).toBe(8);
    }
  });
});
