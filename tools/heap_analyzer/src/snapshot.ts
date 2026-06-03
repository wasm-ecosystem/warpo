// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { AL_MASK, BLOCK_OVERHEAD, ROOT_SIZE } from "./constants.js";
import { DebugInfoResolver } from "./debugInfoResolver.js";
import { buildDominatorTree } from "./dominator.js";
import { computeRetainedSizes, shallowSize } from "./retainedSize.js";
import { findRoots } from "./roots.js";
import { scanReferences } from "./referenceScanner.js";
import { walkBlocks } from "./tlsf.js";
import type { HeapObject, HeapSnapshot, RootInfo, RootType, RuntimeGlobals, SnapshotSummaryEntry } from "./types.js";

function getAssignedRootType(rootTypes: Map<number, RootType>, payloadPtr: number): RootType {
  const rootType = rootTypes.get(payloadPtr);
  if (!rootType) {
    throw new Error(`Missing root type for live object ${payloadPtr}`);
  }
  return rootType;
}

export function analyzeHeap(
  memory: DataView,
  rtGlobals: RuntimeGlobals,
  wasmBinary: Uint8Array | ArrayBuffer
): HeapSnapshot {
  // Resolve DWARF-derived class and global metadata once up front for the entire pipeline.
  const debugInfoResolver = DebugInfoResolver.fromWasm(wasmBinary);

  // Step 1: Enumerate all allocated heap objects from TLSF blocks.
  const objects = walkBlocks(memory, rtGlobals.heapBase);

  // Step 2: Build the full object reference graph.
  const graph = scanReferences(memory, objects, debugInfoResolver);

  // Step 3: Discover current roots from globals, shadow stack, and pinned objects.
  const roots = findRoots(memory, rtGlobals, objects, debugInfoResolver.getGlobalRoots(rtGlobals.mutableI32Globals));

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

  // Step 8: Propagate root categories across the live graph.
  const rootTypes = classifyRootTypes(roots, liveGraph);

  const objectRtIds = new Map(objects.map((obj) => [obj.payloadPtr, obj.rtId]));

  // Step 9: Materialize per-object results.
  const heapObjects: HeapObject[] = liveObjects.map((obj) => ({
    address: obj.payloadPtr,
    classId: obj.rtId,
    className: debugInfoResolver.getClassName(obj.rtId),
    shallowSize: shallowSize(obj),
    retainedSize: retainedSizes.get(obj.payloadPtr) ?? shallowSize(obj),
    rootType: getAssignedRootType(rootTypes, obj.payloadPtr),
  }));

  // Step 10: Enrich root records with resolved class names.
  const rootsWithClassName = roots.map((root) => {
    const className = debugInfoResolver.getClassName(objectRtIds.get(root.objectPtr) ?? -1);
    return {
      objectPtr: root.objectPtr,
      className,
      rootType: root.rootType,
      sourceAddress: root.sourceAddress,
    };
  });

  // Step 11: Compute top-level totals and the class summary view.
  const totalLiveSize = heapObjects.reduce((sum, obj) => sum + obj.shallowSize, 0);
  const totalHeapSize = memory.byteLength - computeFirstBlock(rtGlobals.heapBase);
  const totalFreeSize = Math.max(0, totalHeapSize - totalLiveSize);

  return {
    objects: heapObjects,
    summary: buildSummary(heapObjects),
    roots: rootsWithClassName,
    totalHeapSize,
    totalLiveSize,
    totalFreeSize,
    objectCount: heapObjects.length,
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

function classifyRootTypes(roots: RootInfo[], graph: Map<number, number[]>): Map<number, RootType> {
  // Root-type propagation is priority-based: global > local > pinned.
  const result = new Map<number, RootType>();
  const localRoots = new Set<number>();
  const pinnedRoots = new Set<number>();
  const globalRoots = new Set<number>();

  for (const root of roots) {
    switch (root.rootType) {
      case "global": {
        globalRoots.add(root.objectPtr);
        break;
      }
      case "local": {
        localRoots.add(root.objectPtr);
        break;
      }
      case "pinned": {
        pinnedRoots.add(root.objectPtr);
        break;
      }
    }
  }

  bfsAssignRootType(pinnedRoots, graph, result, "pinned");
  bfsAssignRootType(localRoots, graph, result, "local");
  bfsAssignRootType(globalRoots, graph, result, "global");

  return result;
}

function bfsAssignRootType(
  startPtrs: Set<number>,
  graph: Map<number, number[]>,
  result: Map<number, RootType>,
  rootType: RootType
): void {
  // Walk one root category at a time and stamp every reachable node with that category.
  const visited = new Set<number>();
  const workList = Array.from(startPtrs);

  for (let index = 0; index < workList.length; index++) {
    const ptr = workList[index];
    if (visited.has(ptr)) {
      continue;
    }

    visited.add(ptr);
    result.set(ptr, rootType);

    for (const child of graph.get(ptr) ?? []) {
      if (!visited.has(child)) {
        workList.push(child);
      }
    }
  }
}

function buildSummary(objects: HeapObject[]): SnapshotSummaryEntry[] {
  // Summary is grouped by class name and sorted like a heap-summary view.
  const summaryByClass = new Map<string, SnapshotSummaryEntry>();

  for (const obj of objects) {
    let entry = summaryByClass.get(obj.className);
    if (!entry) {
      entry = {
        className: obj.className,
        classId: obj.classId,
        count: 0,
        totalShallowSize: 0,
        totalRetainedSize: 0,
      };
      summaryByClass.set(obj.className, entry);
    }

    entry.count++;
    entry.totalShallowSize += obj.shallowSize;
    entry.totalRetainedSize += obj.retainedSize;
  }

  return [...summaryByClass.values()].toSorted((lhs, rhs) => rhs.totalRetainedSize - lhs.totalRetainedSize);
}

function computeFirstBlock(heapBase: number): number {
  // Match the AssemblyScript runtime's TLSF root and first-block alignment rules.
  const tlsfRoot = (heapBase + AL_MASK) & ~AL_MASK;
  return ((tlsfRoot + ROOT_SIZE + BLOCK_OVERHEAD + AL_MASK) & ~AL_MASK) - BLOCK_OVERHEAD;
}
