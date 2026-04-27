import assert from "node:assert/strict";
import { before, it } from "node:test";
import { parseDumpFile } from "../src/dumpReader.js";
import { walkBlocks } from "../src/tlsf.js";
import { FREE, TAGS_MASK, TOTAL_OVERHEAD, BLOCK_OVERHEAD, AL_MASK, ROOT_SIZE, COLOR_MASK } from "../src/constants.js";
import type { ObjectHeader, DumpedMemory } from "../src/types.js";
import { describeIntegration, type FixtureContext } from "./testHelper.js";

function loadFixture(ctx: FixtureContext): DumpedMemory {
  return parseDumpFile(ctx.loadFixtureDumpBuffer());
}

describeIntegration("walkBlocks", (ctx) => {
  let dump: DumpedMemory;
  let blocks: ObjectHeader[];

  before(() => {
    ctx.compileFixture();
    ctx.generateFixtureDump();
    dump = loadFixture(ctx);
    blocks = walkBlocks(dump.memory, dump.rtGlobals.heapBase);
  });

  it("returns 110 used blocks from the fixture", () => {
    assert.strictEqual(blocks.length, 110);
  });

  it("all returned blocks are used (not free)", () => {
    for (const b of blocks) {
      assert.strictEqual(b.mmInfo & FREE, 0);
    }
  });

  it("all blocks have positive size", () => {
    for (const b of blocks) {
      assert.ok((b.mmInfo & ~TAGS_MASK) > 0);
    }
  });

  it("payloadPtr increases monotonically", () => {
    for (let i = 1; i < blocks.length; i++) {
      assert.ok(blocks[i].payloadPtr > blocks[i - 1].payloadPtr);
    }
  });

  it("all payloadPtrs are within memory bounds", () => {
    for (const b of blocks) {
      assert.ok(b.payloadPtr < dump.memory.byteLength);
    }
  });

  it("gcColor is in range [0, 3]", () => {
    for (const b of blocks) {
      assert.ok(b.gcColor >= 0);
      assert.ok(b.gcColor <= COLOR_MASK);
    }
  });

  it("first block payloadPtr matches computed firstBlock + TOTAL_OVERHEAD", () => {
    const heapBase = dump.rtGlobals.heapBase;
    const tlsfRoot = (heapBase + AL_MASK) & ~AL_MASK;
    const afterRoot = (tlsfRoot + ROOT_SIZE + AL_MASK) & ~AL_MASK;
    const firstBlock = ((afterRoot + BLOCK_OVERHEAD + AL_MASK) & ~AL_MASK) - BLOCK_OVERHEAD;
    assert.strictEqual(blocks[0].payloadPtr, firstBlock + TOTAL_OVERHEAD);
  });
});

describeIntegration("object header parsing", (ctx) => {
  let blocks: ObjectHeader[];

  before(() => {
    ctx.compileFixture();
    ctx.generateFixtureDump();
    const dump = loadFixture(ctx);
    blocks = walkBlocks(dump.memory, dump.rtGlobals.heapBase);
  });

  it("contains expected rtId values", () => {
    const rtIds = new Set(blocks.map((b) => b.rtId));
    assert.ok(rtIds.has(1));
    assert.ok(rtIds.has(2));
    assert.ok(rtIds.has(13));
  });

  it("rtId distribution matches fixture", () => {
    const counts: Record<number, number> = {};
    for (const b of blocks) {
      counts[b.rtId] = (counts[b.rtId] || 0) + 1;
    }
    assert.strictEqual(counts[1], 29);
    assert.strictEqual(counts[2], 3);
    assert.strictEqual(counts[13], 31);
  });

  it("block at index 4 has rtId 14, rtSize 12, blockSize 28", () => {
    assert.strictEqual(blocks[4].rtId, 14);
    assert.strictEqual(blocks[4].rtSize, 12);
    assert.strictEqual(blocks[4].mmInfo & ~TAGS_MASK, 28);
  });

  it("blocks with rtId 2 have non-zero rtSize", () => {
    const strings = blocks.filter((b) => b.rtId === 2);
    assert.strictEqual(strings.length, 3);
    for (const s of strings) {
      assert.ok(s.rtSize > 0);
    }
  });

  it("blocks with rtId 10 all have rtSize 8", () => {
    const items = blocks.filter((b) => b.rtId === 10);
    assert.strictEqual(items.length, 13);
    for (const item of items) {
      assert.strictEqual(item.rtSize, 8);
    }
  });
});
