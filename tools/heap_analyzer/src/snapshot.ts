// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { AL_MASK, BLOCK_OVERHEAD, ROOT_SIZE } from "./constants.js";
import { DebugInfoResolver } from "./debugInfoResolver.js";
import { buildDominatorTree } from "./dominator.js";
import { computeRetainedSizes, shallowSize } from "./retainedSize.js";
import { findRoots } from "./roots.js";
import { scanReferences } from "./referenceScanner.js";
import { walkBlocks } from "./tlsf.js";
import type {
  ConstructorEntry,
  ConstructorInstance,
  HeapObject,
  HeapSnapshot,
  RootInfo,
  RuntimeGlobalValues,
} from "./types.js";

export function analyzeHeap(
  memory: DataView,
  rtGlobals: RuntimeGlobalValues,
  wasmBinary: Uint8Array | ArrayBuffer
): HeapSnapshot {
  // Resolve DWARF-derived class and global metadata once up front for the entire pipeline.
  const debugInfoResolver = DebugInfoResolver.fromWasm(wasmBinary);

  // Step 1: Enumerate all allocated heap objects from TLSF blocks.
  const objects = walkBlocks(memory, rtGlobals.heapBase);

  // Step 2: Build the full object reference graph.
  const graph = scanReferences(memory, objects, debugInfoResolver);

  // Step 3: Discover current roots from globals, shadow stack, and pinned objects.
  const roots = findRoots(
    memory,
    rtGlobals,
    objects,
    debugInfoResolver.getGlobalRoots(rtGlobals.mutableI32GlobalValues)
  );

  // Step 4: Traverse from roots to determine the live object set.
  const liveSet = markLive(roots, graph);

  // Step 5: Restrict both the object list and the graph to live nodes only.
  const liveObjects = objects.filter((obj) => liveSet.has(obj.payloadPtr));
  const liveGraph = buildLiveGraph(liveSet, graph);

  // Step 6: Build the dominator tree over the live graph only.
  const rootPtrs = new Set(roots.map((root) => root.objectPtr).filter((ptr) => liveSet.has(ptr)));
  const dominatorTree = buildDominatorTree(liveGraph, rootPtrs);

  // Step 7: Aggregate retained sizes bottom-up on the dominator tree.
  const retainedSizes = computeRetainedSizes(liveObjects, dominatorTree);

  // Step 8: Materialize per-object results for constructor aggregation.
  const heapObjects: HeapObject[] = liveObjects.map((obj) => ({
    address: obj.payloadPtr,
    classId: obj.rtId,
    className: debugInfoResolver.getClassName(obj.rtId),
    shallowSize: shallowSize(obj),
    retainedSize: retainedSizes.get(obj.payloadPtr) ?? shallowSize(obj),
    rootType: "local",
  }));

  // Step 9: Compute top-level totals and constructor view.
  const totalLiveSize = heapObjects.reduce((sum, obj) => sum + obj.shallowSize, 0);
  const totalHeapSize = memory.byteLength - computeFirstBlock(rtGlobals.heapBase);

  return {
    constructors: buildConstructors(heapObjects),
    totalHeapSize,
    totalLiveSize,
  };
}

function markLive(roots: RootInfo[], graph: Map<number, number[]>): Set<number> {
  // The workList stores payload pointers that are known reachable but not yet expanded.
  const live = new Set<number>();
  const workList = Array.from(new Set(roots.map((root) => root.objectPtr)));

  for (let index = 0; index < workList.length; index++) {
    const ptr = workList[index];
    if (live.has(ptr)) {
      continue;
    }

    live.add(ptr);

    for (const child of graph.get(ptr) ?? []) {
      if (!live.has(child)) {
        workList.push(child);
      }
    }
  }

  return live;
}

function buildLiveGraph(liveSet: Set<number>, graph: Map<number, number[]>): Map<number, number[]> {
  // Keep only the induced subgraph over live objects so dead nodes never enter
  // dominator or retained-size computation.
  const liveGraph = new Map<number, number[]>();

  for (const node of liveSet) {
    liveGraph.set(
      node,
      (graph.get(node) ?? []).filter((child) => liveSet.has(child))
    );
  }

  return liveGraph;
}
function buildConstructors(objects: HeapObject[]): ConstructorEntry[] {
  const constructorsByClass = new Map<string, ConstructorEntry>();

  for (const obj of objects) {
    let entry = constructorsByClass.get(obj.className);
    if (!entry) {
      entry = {
        className: obj.className,
        count: 0,
        totalShallowSize: 0,
        totalRetainedSize: 0,
        instances: [],
      };
      constructorsByClass.set(obj.className, entry);
    }

    entry.count++;
    entry.totalShallowSize += obj.shallowSize;
    entry.totalRetainedSize += obj.retainedSize;

    entry.instances.push({
      address: obj.address,
      shallowSize: obj.shallowSize,
      retainedSize: obj.retainedSize,
    });
  }

  return [...constructorsByClass.values()]
    .map((entry) => ({
      ...entry,
      instances: sortConstructorInstances(entry.instances),
    }))
    .toSorted(sortConstructors);
}

function sortConstructors(lhs: ConstructorEntry, rhs: ConstructorEntry): number {
  return (
    rhs.totalRetainedSize - lhs.totalRetainedSize ||
    rhs.totalShallowSize - lhs.totalShallowSize ||
    rhs.count - lhs.count ||
    lhs.className.localeCompare(rhs.className)
  );
}

function sortConstructorInstances(instances: ConstructorInstance[]): ConstructorInstance[] {
  return instances.toSorted(
    (lhs, rhs) => rhs.retainedSize - lhs.retainedSize || rhs.shallowSize - lhs.shallowSize || lhs.address - rhs.address
  );
}

function computeFirstBlock(heapBase: number): number {
  // Match the AssemblyScript runtime's TLSF root and first-block alignment rules.
  const tlsfRoot = (heapBase + AL_MASK) & ~AL_MASK;
  return ((tlsfRoot + ROOT_SIZE + BLOCK_OVERHEAD + AL_MASK) & ~AL_MASK) - BLOCK_OVERHEAD;
}
