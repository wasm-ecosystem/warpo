// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import assert from "node:assert/strict";
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

function pushChildrenOntoStack(
  node: number,
  children: Map<number, number[]>,
  stack: Array<{ node: number; visited: boolean }>
): void {
  const childNodes = children.get(node);
  if (!childNodes) {
    return;
  }

  for (const child of childNodes) {
    stack.push({ node: child, visited: false });
  }
}

function sumRetainedChildren(node: number, children: Map<number, number[]>, retained: Map<number, number>): number {
  const childNodes = children.get(node);
  if (!childNodes) {
    return 0;
  }

  let size = 0;
  for (const child of childNodes) {
    size += retained.get(child) ?? 0;
  }
  return size;
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
    assert(current !== undefined);

    if (!current.visited) {
      stack.push({ node: current.node, visited: true });
      pushChildrenOntoStack(current.node, children, stack);
      continue;
    }

    if (current.node === VIRTUAL_ROOT) {
      continue;
    }

    const obj = objectByPtr.get(current.node);
    if (!obj) {
      throw new Error(`Missing object header for retained-size node ${current.node}`);
    }

    const size = shallowSize(obj) + sumRetainedChildren(current.node, children, retained);
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
