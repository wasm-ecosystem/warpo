import assert from "node:assert/strict";
import { before, it } from "node:test";
import { parseDumpFile } from "../src/dumpReader.js";
import { analyzeHeap } from "../src/snapshot.js";
import type { DumpedMemory } from "../src/types.js";
import { CLASS_PREFIX, describeIntegration, type FixtureContext } from "./testHelper.js";

function loadFixture(ctx: FixtureContext): DumpedMemory {
  return parseDumpFile(ctx.loadFixtureDumpBuffer());
}

describeIntegration("analyzeHeap", (ctx) => {
  let dump: DumpedMemory;
  let snapshot: ReturnType<typeof analyzeHeap>;
  let objectCounts: Map<string, number>;

  before(() => {
    ctx.compileFixture();
    ctx.generateFixtureDump();
    dump = loadFixture(ctx);
    snapshot = analyzeHeap(dump.memory, dump.rtGlobals, ctx.loadFixtureWasm());
    objectCounts = new Map<string, number>();
    for (const obj of snapshot.objects) {
      objectCounts.set(obj.className, (objectCounts.get(obj.className) ?? 0) + 1);
    }
  });

  it("matches the fixture's live-object and root counts", () => {
    assert.strictEqual(snapshot.objectCount, 93);
    assert.strictEqual(snapshot.objects.length, 93);
    assert.strictEqual(snapshot.roots.length, 19);
  });

  it("reports only local roots for the current fixture", () => {
    const rootTypeCounts: Record<string, number> = {};
    for (const root of snapshot.roots) {
      rootTypeCounts[root.rootType] = (rootTypeCounts[root.rootType] ?? 0) + 1;
    }

    assert.deepStrictEqual(rootTypeCounts, { local: 19 });
  });

  it("propagates local rootType to all live objects", () => {
    const objectRootTypeCounts: Record<string, number> = {};
    for (const obj of snapshot.objects) {
      objectRootTypeCounts[obj.rootType] = (objectRootTypeCounts[obj.rootType] ?? 0) + 1;
    }

    assert.deepStrictEqual(objectRootTypeCounts, { local: 93 });
  });

  it("matches expected class counts for key fixture types", () => {
    assert.strictEqual(objectCounts.get(`${CLASS_PREFIX}TreeNode`), 31);
    assert.strictEqual(objectCounts.get("~lib/arraybuffer/ArrayBuffer"), 17);
    assert.strictEqual(objectCounts.get(`${CLASS_PREFIX}Item`), 13);
    assert.strictEqual(objectCounts.get(`${CLASS_PREFIX}Vector2`), 8);
    assert.strictEqual(objectCounts.get(`${CLASS_PREFIX}ListNode`), 5);
    assert.strictEqual(objectCounts.get(`${CLASS_PREFIX}NPC`), 3);
    assert.strictEqual(objectCounts.get(`${CLASS_PREFIX}Player`), 2);
    assert.strictEqual(objectCounts.get("~lib/string/String"), 1);
  });

  it("keeps summary sorted by retained size and matches key summary rows", () => {
    for (let index = 1; index < snapshot.summary.length; index++) {
      assert.ok(snapshot.summary[index - 1].totalRetainedSize >= snapshot.summary[index].totalRetainedSize);
    }

    assert.deepStrictEqual(snapshot.summary[0], {
      className: `${CLASS_PREFIX}TreeNode`,
      classId: snapshot.summary[0].classId,
      count: 31,
      totalShallowSize: 992,
      totalRetainedSize: 4128,
    });

    const players = snapshot.summary.find((entry) => entry.className === `${CLASS_PREFIX}Player`);
    const npc = snapshot.summary.find((entry) => entry.className === `${CLASS_PREFIX}NPC`);
    const strings = snapshot.summary.find((entry) => entry.className === "~lib/string/String");

    assert.deepStrictEqual(
      players && {
        count: players.count,
        shallow: players.totalShallowSize,
        retained: players.totalRetainedSize,
      },
      { count: 2, shallow: 96, retained: 544 }
    );
    assert.deepStrictEqual(
      npc && {
        count: npc.count,
        shallow: npc.totalShallowSize,
        retained: npc.totalRetainedSize,
      },
      { count: 3, shallow: 144, retained: 240 }
    );
    assert.deepStrictEqual(
      strings && {
        count: strings.count,
        shallow: strings.totalShallowSize,
        retained: strings.totalRetainedSize,
      },
      { count: 1, shallow: 304, retained: 304 }
    );
  });

  it("computes totals consistent with the object and summary rows", () => {
    const totalLiveSize = snapshot.objects.reduce((sum, obj) => sum + obj.shallowSize, 0);
    const totalCount = snapshot.summary.reduce((sum, entry) => sum + entry.count, 0);
    const totalShallowSize = snapshot.summary.reduce((sum, entry) => sum + entry.totalShallowSize, 0);

    assert.strictEqual(snapshot.totalLiveSize, totalLiveSize);
    assert.strictEqual(totalCount, snapshot.objects.length);
    assert.strictEqual(totalShallowSize, snapshot.totalLiveSize);
    assert.ok(snapshot.totalHeapSize >= snapshot.totalLiveSize);
    assert.strictEqual(snapshot.totalFreeSize, snapshot.totalHeapSize - snapshot.totalLiveSize);
    assert.ok(snapshot.totalFreeSize >= 0);
  });

  it("enriches every root with a resolved class name present in the object set", () => {
    const objectAddresses = new Set(snapshot.objects.map((obj) => obj.address));
    assert.ok(snapshot.roots.length > 0);

    for (const root of snapshot.roots) {
      assert.notStrictEqual(root.className, "");
      assert.ok(objectAddresses.has(root.objectPtr));
    }
  });
});
