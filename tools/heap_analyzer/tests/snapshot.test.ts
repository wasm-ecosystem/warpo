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
  let constructorCounts: Map<string, number>;

  before(() => {
    ctx.compileFixture();
    ctx.generateFixtureDump();
    dump = loadFixture(ctx);
    snapshot = analyzeHeap(dump.memory, dump.rtGlobals, ctx.loadFixtureWasm());
    constructorCounts = new Map<string, number>();
    for (const entry of snapshot.constructors) {
      constructorCounts.set(entry.className, entry.count);
    }
  });

  it("matches the fixture's live-object count through constructor rows", () => {
    const totalCount = snapshot.constructors.reduce((sum, entry) => sum + entry.count, 0);

    assert.strictEqual(totalCount, 94);
  });

  it("matches expected class counts for key fixture types", () => {
    assert.strictEqual(constructorCounts.get(`${CLASS_PREFIX}TreeNode`), 31);
    assert.strictEqual(constructorCounts.get("~lib/arraybuffer/ArrayBuffer"), 18);
    assert.strictEqual(constructorCounts.get(`${CLASS_PREFIX}Item`), 13);
    assert.strictEqual(constructorCounts.get(`${CLASS_PREFIX}Vector2`), 8);
    assert.strictEqual(constructorCounts.get(`${CLASS_PREFIX}ListNode`), 5);
    assert.strictEqual(constructorCounts.get(`${CLASS_PREFIX}NPC`), 3);
    assert.strictEqual(constructorCounts.get(`${CLASS_PREFIX}Player`), 2);
    assert.strictEqual(constructorCounts.get("~lib/string/String"), 1);
  });

  it("keeps constructors sorted by retained size and matches key rows", () => {
    for (let index = 1; index < snapshot.constructors.length; index++) {
      assert.ok(snapshot.constructors[index - 1].totalRetainedSize >= snapshot.constructors[index].totalRetainedSize);
    }

    assert.deepStrictEqual(snapshot.constructors[0], {
      className: `${CLASS_PREFIX}TreeNode`,
      count: 31,
      totalShallowSize: 992,
      totalRetainedSize: 4128,
      instances: snapshot.constructors[0].instances,
    });

    const players = snapshot.constructors.find((entry) => entry.className === `${CLASS_PREFIX}Player`);
    const npc = snapshot.constructors.find((entry) => entry.className === `${CLASS_PREFIX}NPC`);
    const strings = snapshot.constructors.find((entry) => entry.className === "~lib/string/String");

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

  it("includes instance rows by default", () => {
    for (const entry of snapshot.constructors) {
      assert.ok(Array.isArray(entry.instances));
    }
  });

  it("keeps instance rows sorted", () => {
    const totalInstanceCount = snapshot.constructors.reduce((sum, entry) => sum + entry.instances.length, 0);
    assert.strictEqual(totalInstanceCount, 94);

    const treeNodes = snapshot.constructors.find((entry) => entry.className === `${CLASS_PREFIX}TreeNode`);
    assert.ok(treeNodes);
    assert.strictEqual(treeNodes.instances.length, 31);
    assert.deepStrictEqual(
      Object.keys(treeNodes.instances[0]).toSorted((lhs, rhs) => lhs.localeCompare(rhs)),
      ["address", "retainedSize", "shallowSize"]
    );
    assert.strictEqual(treeNodes.instances[0].shallowSize, 32);
    assert.strictEqual(treeNodes.instances[0].retainedSize, 992);
    assertInstancesSorted(treeNodes.instances);

    const players = snapshot.constructors.find((entry) => entry.className === `${CLASS_PREFIX}Player`);
    assert.ok(players);
    assert.strictEqual(players.instances[0].shallowSize, 48);
    assert.strictEqual(players.instances[0].retainedSize, 288);
    assertInstancesSorted(players.instances);
  });

  it("computes totals consistent with the constructor rows", () => {
    const totalCount = snapshot.constructors.reduce((sum, entry) => sum + entry.count, 0);
    const totalShallowSize = snapshot.constructors.reduce((sum, entry) => sum + entry.totalShallowSize, 0);

    assert.strictEqual(totalCount, 94);
    assert.strictEqual(totalShallowSize, snapshot.totalLiveSize);
    assert.ok(snapshot.totalHeapSize >= snapshot.totalLiveSize);
  });
});

function assertInstancesSorted(instances: Array<{ address: number; shallowSize: number; retainedSize: number }>): void {
  for (let index = 1; index < instances.length; index++) {
    const previous = instances[index - 1];
    const current = instances[index];
    assert.ok(
      previous.retainedSize > current.retainedSize ||
        (previous.retainedSize === current.retainedSize &&
          (previous.shallowSize > current.shallowSize ||
            (previous.shallowSize === current.shallowSize && previous.address <= current.address)))
    );
  }
}
