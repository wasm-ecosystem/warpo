import assert from "node:assert/strict";
import { it } from "node:test";
import { compareSnapshots } from "../src/comparison.js";
import type { ConstructorEntry, ConstructorInstance, HeapSnapshot } from "../src/types.js";

it("returns no constructor rows when two snapshots are identical", () => {
  const snapshot = createSnapshot(1024, [createConstructor("Foo", [createInstance(100, 32, 64)])]);

  assert.deepStrictEqual(compareSnapshots(snapshot, snapshot), {
    beforeTotalHeapSize: 1024,
    afterTotalHeapSize: 1024,
    totalHeapSizeDelta: 0,
    beforeTotalLiveSize: 32,
    afterTotalLiveSize: 32,
    totalLiveSizeDelta: 0,
    constructors: [],
  });
});

it("aggregates constructor diffs and keeps only changed instances", () => {
  const before = createSnapshot(1024, [
    createConstructor("Foo", [createInstance(100, 32, 64), createInstance(101, 16, 16)]),
    createConstructor("Bar", [createInstance(200, 24, 24)]),
  ]);
  const after = createSnapshot(1152, [
    createConstructor("Foo", [createInstance(101, 16, 16), createInstance(102, 48, 80)]),
    createConstructor("Baz", [createInstance(300, 40, 40)]),
  ]);

  assert.deepStrictEqual(compareSnapshots(before, after), {
    beforeTotalHeapSize: 1024,
    afterTotalHeapSize: 1152,
    totalHeapSizeDelta: 128,
    beforeTotalLiveSize: 72,
    afterTotalLiveSize: 104,
    totalLiveSizeDelta: 32,
    constructors: [
      {
        className: "Baz",
        newCount: 1,
        deletedCount: 0,
        countDelta: 1,
        allocatedSize: 40,
        freedSize: 0,
        sizeDelta: 40,
        instances: [
          {
            address: 300,
            shallowSize: 40,
            retainedSize: 40,
            changeKind: "new",
          },
        ],
      },
      {
        className: "Foo",
        newCount: 1,
        deletedCount: 1,
        countDelta: 0,
        allocatedSize: 48,
        freedSize: 32,
        sizeDelta: 16,
        instances: [
          {
            address: 102,
            shallowSize: 48,
            retainedSize: 80,
            changeKind: "new",
          },
          {
            address: 100,
            shallowSize: 32,
            retainedSize: 64,
            changeKind: "delete",
          },
        ],
      },
      {
        className: "Bar",
        newCount: 0,
        deletedCount: 1,
        countDelta: -1,
        allocatedSize: 0,
        freedSize: 24,
        sizeDelta: -24,
        instances: [
          {
            address: 200,
            shallowSize: 24,
            retainedSize: 24,
            changeKind: "delete",
          },
        ],
      },
    ],
  });
});

it("treats same-address instances as unchanged even if sizes differ", () => {
  const before = createSnapshot(1024, [createConstructor("Foo", [createInstance(100, 32, 64)])]);
  const after = createSnapshot(1024, [createConstructor("Foo", [createInstance(100, 64, 96)])]);

  assert.deepStrictEqual(compareSnapshots(before, after).constructors, []);
});

function createSnapshot(totalHeapSize: number, constructors: ConstructorEntry[]): HeapSnapshot {
  return {
    constructors,
    totalHeapSize,
    totalLiveSize: constructors.reduce((sum, entry) => sum + entry.totalShallowSize, 0),
  };
}

function createConstructor(className: string, instances: ConstructorInstance[]): ConstructorEntry {
  return {
    className,
    count: instances.length,
    totalShallowSize: instances.reduce((sum, instance) => sum + instance.shallowSize, 0),
    totalRetainedSize: instances.reduce((sum, instance) => sum + instance.retainedSize, 0),
    instances,
  };
}

function createInstance(address: number, shallowSize: number, retainedSize: number): ConstructorInstance {
  return {
    address,
    shallowSize,
    retainedSize,
  };
}
