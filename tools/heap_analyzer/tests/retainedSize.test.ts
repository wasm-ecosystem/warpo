import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { BLOCK_OVERHEAD } from "../src/constants.js";
import { buildDominatorTree, VIRTUAL_ROOT } from "../src/dominator.js";
import { computeRetainedSizes } from "../src/retainedSize.js";
import type { ObjectHeader } from "../src/types.js";

function makeObject(payloadPtr: number, blockSize: number): ObjectHeader {
  return {
    mmInfo: blockSize,
    rtId: 1,
    rtSize: blockSize,
    payloadPtr,
    gcColor: 0,
  };
}

describe("computeRetainedSizes", () => {
  it("computes retained sizes for a simple chain", () => {
    const graph = new Map<number, number[]>([
      [10, [20]],
      [20, [30]],
      [30, []],
    ]);
    const domTree = buildDominatorTree(graph, new Set([10]));
    const objects = [makeObject(10, 16), makeObject(20, 24), makeObject(30, 32)];

    const retained = computeRetainedSizes(objects, domTree);

    const shallow10 = BLOCK_OVERHEAD + 16;
    const shallow20 = BLOCK_OVERHEAD + 24;
    const shallow30 = BLOCK_OVERHEAD + 32;

    assert.strictEqual(retained.get(30), shallow30);
    assert.strictEqual(retained.get(20), shallow20 + shallow30);
    assert.strictEqual(retained.get(10), shallow10 + shallow20 + shallow30);
  });

  it("handles a diamond where the join is dominated by the root", () => {
    const graph = new Map<number, number[]>([
      [10, [20, 30]],
      [20, [40]],
      [30, [40]],
      [40, []],
    ]);
    const domTree = buildDominatorTree(graph, new Set([10]));
    const objects = [makeObject(10, 16), makeObject(20, 16), makeObject(30, 16), makeObject(40, 16)];

    const retained = computeRetainedSizes(objects, domTree);
    const shallow = BLOCK_OVERHEAD + 16;

    assert.strictEqual(domTree.get(10), VIRTUAL_ROOT);
    assert.strictEqual(domTree.get(20), 10);
    assert.strictEqual(domTree.get(30), 10);
    assert.strictEqual(domTree.get(40), 10);

    assert.strictEqual(retained.get(20), shallow);
    assert.strictEqual(retained.get(30), shallow);
    assert.strictEqual(retained.get(40), shallow);
    assert.strictEqual(retained.get(10), shallow * 4);
  });

  it("throws if a dominator-tree node has no matching object header", () => {
    const domTree = new Map<number, number>([[10, VIRTUAL_ROOT]]);

    assert.throws(() => computeRetainedSizes([], domTree), /Missing object header for dominator-tree node 10/);
  });
});
