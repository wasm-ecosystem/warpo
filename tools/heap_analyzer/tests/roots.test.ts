import assert from "node:assert/strict";
import { before, it } from "node:test";
import { DebugInfoResolver } from "../src/debugInfoResolver.js";
import { GC_COLOR_TRANSPARENT } from "../src/constants.js";
import { parseDumpFile } from "../src/dumpReader.js";
import { findRoots } from "../src/roots.js";
import { walkBlocks } from "../src/tlsf.js";
import type { DumpedMemory, ObjectHeader, RootInfo } from "../src/types.js";
import { describeIntegration, type FixtureContext } from "./testHelper.js";

function loadFixture(ctx: FixtureContext): DumpedMemory {
  return parseDumpFile(ctx.loadFixtureDumpBuffer());
}

describeIntegration("findRoots", (ctx) => {
  let dump: DumpedMemory;
  let objects: ObjectHeader[];
  let roots: RootInfo[];
  let debugInfoResolver: DebugInfoResolver;

  before(() => {
    ctx.compileFixture();
    ctx.generateFixtureDump();
    dump = loadFixture(ctx);
    objects = walkBlocks(dump.memory, dump.rtGlobals.heapBase);
    debugInfoResolver = DebugInfoResolver.fromWasm(ctx.loadFixtureWasm());
    roots = findRoots(dump.memory, dump.rtGlobals, objects, debugInfoResolver.getGlobalRoots(dump.rtGlobals));
  });

  it("currently reports local roots only for the shared fixture dump", () => {
    const rootTypes = new Set(roots.map((root) => root.rootType));
    assert.deepStrictEqual(
      [...rootTypes].toSorted((lhs, rhs) => lhs.localeCompare(rhs)),
      ["local"]
    );
  });

  it("finds at least one shadow-stack root", () => {
    const localRoots = roots.filter((root) => root.rootType === "local");
    assert.ok(localRoots.length > 0);
  });

  it("all local roots come from the shadow-stack range", () => {
    for (const root of roots) {
      if (root.rootType !== "local") {
        continue;
      }
      assert.ok(root.sourceAddress >= dump.rtGlobals.stackPointer);
      assert.ok(root.sourceAddress < dump.rtGlobals.heapBase);
    }
  });

  it("returns all transparent objects as pinned roots", () => {
    const pinnedObjectPtrs = new Set(
      objects.filter((obj) => obj.gcColor === GC_COLOR_TRANSPARENT).map((obj) => obj.payloadPtr)
    );
    const pinnedRoots = roots.filter((root) => root.rootType === "pinned");

    assert.strictEqual(pinnedRoots.length, pinnedObjectPtrs.size);
    for (const root of pinnedRoots) {
      assert.strictEqual(root.sourceAddress, 0);
      assert.ok(pinnedObjectPtrs.has(root.objectPtr));
    }
  });

  it("only reports roots that point to valid object payloads", () => {
    const validPtrs = new Set(objects.map((obj) => obj.payloadPtr));
    for (const root of roots) {
      assert.ok(validPtrs.has(root.objectPtr));
    }
  });

  it("shared fixture dump has no serialized mutable globals yet", () => {
    assert.strictEqual(dump.rtGlobals.mutableI32Globals.length, 0);
    assert.strictEqual(
      roots.some((root) => root.rootType === "global"),
      false
    );
  });
});

it("reports transparent-color objects as pinned roots", () => {
  const memory = new DataView(new ArrayBuffer(64));
  const objects: ObjectHeader[] = [
    { mmInfo: 24, rtId: 1, rtSize: 8, payloadPtr: 16, gcColor: 0 },
    { mmInfo: 24, rtId: 2, rtSize: 8, payloadPtr: 32, gcColor: GC_COLOR_TRANSPARENT },
  ];

  memory.setUint32(0, 16, true);

  const roots = findRoots(memory, { dataEnd: 0, stackPointer: 0, heapBase: 4, mutableI32Globals: [] }, objects);
  const pinnedRoots = roots.filter((root) => root.rootType === "pinned");
  const localRoots = roots.filter((root) => root.rootType === "local");

  assert.deepStrictEqual(localRoots, [{ objectPtr: 16, className: "", rootType: "local", sourceAddress: 0 }]);
  assert.deepStrictEqual(pinnedRoots, [{ objectPtr: 32, className: "", rootType: "pinned", sourceAddress: 0 }]);
});

it("reports global roots when resolved wasm globals point at valid objects", () => {
  const memory = new DataView(new ArrayBuffer(64));
  const objects: ObjectHeader[] = [
    { mmInfo: 24, rtId: 1, rtSize: 8, payloadPtr: 16, gcColor: 0 },
    { mmInfo: 24, rtId: 2, rtSize: 8, payloadPtr: 32, gcColor: 0 },
  ];

  const roots = findRoots(memory, { dataEnd: 0, stackPointer: 0, heapBase: 0, mutableI32Globals: [] }, objects, [
    { name: "globalTree", className: "TreeNode", globalIndex: 2, value: 32 },
    { name: "globalNull", className: "TreeNode", globalIndex: 3, value: 0 },
    { name: "globalDead", className: "TreeNode", globalIndex: 4, value: 48 },
  ]);

  assert.deepStrictEqual(roots, [{ objectPtr: 32, className: "", rootType: "global", sourceAddress: 2 }]);
});
