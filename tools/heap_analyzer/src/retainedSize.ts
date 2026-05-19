// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { BLOCK_OVERHEAD, TAGS_MASK } from "./constants.js";
import { VIRTUAL_ROOT } from "./dominator.js";
import type { ObjectHeader } from "./types.js";

export function shallowSize(obj: ObjectHeader): number {
  return BLOCK_OVERHEAD + (obj.mmInfo & ~TAGS_MASK);
}

function buildChildrenMap(objects: ObjectHeader[], dominatorTree: Map<number, number>): Map<number, number[]> {
  const objectByPtr = new Map(objects.map((obj) => [obj.payloadPtr, obj]));
  const children = new Map<number, number[]>();

  for (const [node, idom] of dominatorTree) {
    if (!objectByPtr.has(node)) {
      throw new Error(`Missing object header for dominator-tree node ${node}`);
    }

    const bucket = children.get(idom);
    if (bucket) {
      bucket.push(node);
    } else {
      children.set(idom, [node]);
    }
  }

  return children;
}

function aggregateRetainedSizes(
  root: number,
  objectByPtr: Map<number, ObjectHeader>,
  children: Map<number, number[]>
): Map<number, number> {
  const retained = new Map<number, number>();
  const stack: Array<{ node: number; visited: boolean }> = [{ node: root, visited: false }];

  while (stack.length > 0) {
    const current = stack.pop();

    if (!current.visited) {
      stack.push({ node: current.node, visited: true });
      for (const child of children.get(current.node) ?? []) {
        stack.push({ node: child, visited: false });
      }
      continue;
    }

    if (current.node === VIRTUAL_ROOT) {
      continue;
    }

    const obj = objectByPtr.get(current.node);
    if (!obj) {
      throw new Error(`Missing object header for retained-size node ${current.node}`);
    }

    let size = shallowSize(obj);
    for (const child of children.get(current.node) ?? []) {
      size += retained.get(child) ?? 0;
    }
    retained.set(current.node, size);
  }

  return retained;
}

/**
 * Compute retained sizes for the live objects represented in the dominator tree.
 *
 * The input objects are expected to be the live-object slice that was used to
 * build the live graph and dominator tree.
 */
export function computeRetainedSizes(objects: ObjectHeader[], dominatorTree: Map<number, number>): Map<number, number> {
  const objectByPtr = new Map(objects.map((obj) => [obj.payloadPtr, obj]));
  const children = buildChildrenMap(objects, dominatorTree);
  return aggregateRetainedSizes(VIRTUAL_ROOT, objectByPtr, children);
}
