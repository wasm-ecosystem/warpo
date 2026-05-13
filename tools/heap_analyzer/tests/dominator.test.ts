// Copyright (C) 2024 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { buildDominatorTree, VIRTUAL_ROOT } from "../src/dominator.js";

function assertIdom(tree: Map<number, number>, node: number, expected: number): void {
  assert.strictEqual(tree.get(node), expected);
}

describe("buildDominatorTree", () => {
  it("should handle an empty graph", () => {
    const graph = new Map<number, number[]>();
    const roots = new Set<number>();
    const domTree = buildDominatorTree(graph, roots);
    assert.strictEqual(domTree.size, 0);
  });

  it("should handle a graph with a single root node", () => {
    const graph = new Map<number, number[]>();
    const roots = new Set([10]);
    const domTree = buildDominatorTree(graph, roots);
    assert.strictEqual(domTree.size, 1);
    assertIdom(domTree, 10, VIRTUAL_ROOT);
  });

  it("should handle a simple chain", () => {
    // 10 -> 20 -> 30
    const graph = new Map([
      [10, [20]],
      [20, [30]],
    ]);
    const roots = new Set([10]);
    const domTree = buildDominatorTree(graph, roots);
    assert.strictEqual(domTree.size, 3);
    assertIdom(domTree, 10, VIRTUAL_ROOT);
    assertIdom(domTree, 20, 10);
    assertIdom(domTree, 30, 20);
  });

  it("should handle multiple roots", () => {
    // R1 -> 10
    // R2 -> 20
    const graph = new Map([
      [1, [10]],
      [2, [20]],
    ]);
    const roots = new Set([1, 2]);
    const domTree = buildDominatorTree(graph, roots);
    assert.strictEqual(domTree.size, 4);
    assertIdom(domTree, 1, VIRTUAL_ROOT);
    assertIdom(domTree, 2, VIRTUAL_ROOT);
    assertIdom(domTree, 10, 1);
    assertIdom(domTree, 20, 2);
  });

  it("should handle a simple diamond graph", () => {
    //    10
    //   /  \
    //  20  30
    //   \  /
    //    40
    const graph = new Map([
      [10, [20, 30]],
      [20, [40]],
      [30, [40]],
    ]);
    const roots = new Set([10]);
    const domTree = buildDominatorTree(graph, roots);
    assert.strictEqual(domTree.size, 4);
    assertIdom(domTree, 10, VIRTUAL_ROOT);
    assertIdom(domTree, 20, 10);
    assertIdom(domTree, 30, 10);
    assertIdom(domTree, 40, 10);
  });

  it("should handle a graph with a cycle", () => {
    // 10 -> 20 -> 30 -> 20
    const graph = new Map([
      [10, [20]],
      [20, [30]],
      [30, [20]],
    ]);
    const roots = new Set([10]);
    const domTree = buildDominatorTree(graph, roots);
    assert.strictEqual(domTree.size, 3);
    assertIdom(domTree, 10, VIRTUAL_ROOT);
    assertIdom(domTree, 20, 10);
    assertIdom(domTree, 30, 20);
  });

  it("should handle unreachable nodes", () => {
    // 10 -> 20
    // 30 (unreachable)
    const graph = new Map([
      [10, [20]],
      [30, []],
    ]);
    const roots = new Set([10]);
    const domTree = buildDominatorTree(graph, roots);
    assert.strictEqual(domTree.size, 2);
    assert.strictEqual(domTree.has(10), true);
    assert.strictEqual(domTree.has(20), true);
    assert.strictEqual(domTree.has(30), false);
  });

  it("should handle a more complex graph (from Lengauer-Tarjan paper)", () => {
    // This is a classic example graph for dominator algorithms.
    //       R(1)
    //      / | \
    //     2  3  4
    //     |  |  | \
    //     5--+--6  7
    //     |  |  | /
    //     8--+--9
    //      \ | /
    //       10
    //        |
    //       11
    //        |
    //       12
    //      /
    //     1
    const graph = new Map([
      [1, [2, 3, 4]],
      [2, [5]],
      [3, [6]],
      [4, [6, 7]],
      [5, [8]],
      [6, [9]],
      [7, [9]],
      [8, [10]],
      [9, [10]],
      [10, [11]],
      [11, [12]],
      [12, [1]], // Cycle back to root
    ]);
    const roots = new Set([1]);
    const domTree = buildDominatorTree(graph, roots);

    assert.strictEqual(domTree.size, 12);
    assertIdom(domTree, 1, VIRTUAL_ROOT);
    assertIdom(domTree, 2, 1);
    assertIdom(domTree, 3, 1);
    assertIdom(domTree, 4, 1);
    assertIdom(domTree, 5, 2);
    assertIdom(domTree, 6, 1); // Dominated by 1, not 3 or 4
    assertIdom(domTree, 7, 4);
    assertIdom(domTree, 8, 5);
    assertIdom(domTree, 9, 1); // Dominated by 1, not 6 or 7
    assertIdom(domTree, 10, 1); // Dominated by 1, not 8 or 9
    assertIdom(domTree, 11, 10);
    assertIdom(domTree, 12, 11);
  });

  it("should handle a case where semi-dominator is not the idom", () => {
    //      1
    //      |
    //      2
    //     / \
    //    3   4
    //    |   |
    //    5<--6
    //    |
    //    7
    //    |
    //    8
    //    ^
    //    4
    const graph = new Map([
      [1, [2]],
      [2, [3, 4]],
      [3, [5]],
      [4, [6, 8]],
      [5, [7]],
      [6, [5]],
      [7, [8]],
    ]);
    const roots = new Set([1]);
    const domTree = buildDominatorTree(graph, roots);

    // sdom(8) is 4.
    // But idom(8) is 2, because of the path 1-2-3-5-7-8
    assertIdom(domTree, 1, VIRTUAL_ROOT);
    assertIdom(domTree, 2, 1);
    assertIdom(domTree, 3, 2);
    assertIdom(domTree, 4, 2);
    assertIdom(domTree, 5, 2); // Dom by 2, not 3 or 6
    assertIdom(domTree, 6, 4);
    assertIdom(domTree, 7, 5);
    assertIdom(domTree, 8, 2); // Dom by 2, not 4 or 7
  });
});
