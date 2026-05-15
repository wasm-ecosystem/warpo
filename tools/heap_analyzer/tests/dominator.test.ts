// Copyright (C) 2024 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { buildDominatorTree, VIRTUAL_ROOT } from "../src/dominator.js";

function assertIdom(tree: Map<number, number>, node: number, expected: number): void {
  assert.strictEqual(tree.get(node), expected);
}

function dominates(tree: Map<number, number>, dominator: number, node: number): boolean {
  if (dominator === node) {
    return true;
  }

  let current = tree.get(node);
  while (current !== undefined) {
    if (current === dominator) {
      return true;
    }
    if (current === VIRTUAL_ROOT) {
      return false;
    }
    current = tree.get(current);
  }

  return false;
}

function nearestCommonDominator(tree: Map<number, number>, lhs: number, rhs: number): number | undefined {
  const dominators = new Set<number>([lhs]);

  let current = tree.get(lhs);
  while (current !== undefined) {
    dominators.add(current);
    if (current === VIRTUAL_ROOT) {
      break;
    }
    current = tree.get(current);
  }

  if (dominators.has(rhs)) {
    return rhs;
  }

  current = tree.get(rhs);
  while (current !== undefined) {
    if (dominators.has(current)) {
      return current;
    }
    if (current === VIRTUAL_ROOT) {
      break;
    }
    current = tree.get(current);
  }

  return undefined;
}

function assertDomChildren(tree: Map<number, number>, node: number, expectedChildren: number[]): void {
  const actualChildren = Array.from(tree.entries())
    .filter(([, idom]) => idom === node)
    .map(([child]) => child)
    .toSorted((lhs, rhs) => lhs - rhs);
  const sortedExpectedChildren = expectedChildren.toSorted((lhs, rhs) => lhs - rhs);
  assert.deepStrictEqual(actualChildren, sortedExpectedChildren);
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

  it("matches the LLVM dominance no-regions case", () => {
    const graph = new Map([
      [0, [1]],
      [1, [2, 3]],
      [2, [4]],
      [3, [4]],
      [4, [5]],
    ]);
    const roots = new Set([0]);
    const domTree = buildDominatorTree(graph, roots);

    assert.strictEqual(dominates(domTree, 1, 4), true);
    assert.strictEqual(dominates(domTree, 4, 1), false);

    assert.strictEqual(dominates(domTree, 1, 2), true);
    assert.strictEqual(dominates(domTree, 2, 1), false);

    assert.strictEqual(dominates(domTree, 1, 3), true);
    assert.strictEqual(dominates(domTree, 3, 1), false);

    assert.strictEqual(nearestCommonDominator(domTree, 2, 3), 1);
    assert.strictEqual(nearestCommonDominator(domTree, 2, 4), 1);
    assert.strictEqual(nearestCommonDominator(domTree, 4, 4), 4);
  });

  it("matches the rust paper example", () => {
    const graph = new Map([
      [6, [5, 4]],
      [5, [1]],
      [4, [2, 3]],
      [1, [2]],
      [2, [3, 1]],
      [3, [2]],
    ]);
    const roots = new Set([6]);
    const domTree = buildDominatorTree(graph, roots);

    assert.strictEqual(domTree.get(0), undefined);
    assertIdom(domTree, 1, 6);
    assertIdom(domTree, 2, 6);
    assertIdom(domTree, 3, 6);
    assertIdom(domTree, 4, 6);
    assertIdom(domTree, 5, 6);
    assertIdom(domTree, 6, VIRTUAL_ROOT);
  });

  it("handles the rust paper_slt example", () => {
    const graph = new Map([
      [1, [2, 3]],
      [2, [3, 7]],
      [3, [4, 6]],
      [4, [5]],
      [5, [4]],
      [6, [7]],
      [7, [8]],
      [8, [5]],
    ]);
    const roots = new Set([1]);

    buildDominatorTree(graph, roots);
  });

  it("matches the rust immediate_dominator case", () => {
    const graph = new Map([
      [1, [2]],
      [2, [3]],
    ]);
    const roots = new Set([1]);
    const domTree = buildDominatorTree(graph, roots);

    assert.strictEqual(domTree.get(0), undefined);
    assertIdom(domTree, 1, VIRTUAL_ROOT);
    assertIdom(domTree, 2, 1);
    assertIdom(domTree, 3, 2);
  });

  it("matches the rust transitive_dominator case", () => {
    const graph = new Map([
      [0, [1, 7]],
      [1, [2, 5]],
      [2, [3]],
      [3, [4]],
      [5, [6, 3]],
      [7, [2]],
    ]);
    const roots = new Set([0]);
    const domTree = buildDominatorTree(graph, roots);

    assertIdom(domTree, 2, 0);
    assertIdom(domTree, 3, 0);
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

  it("matches the DomTreeImpl complex branching-and-join case", () => {
    //        0
    //       / \
    //      1   2
    //     / \   \
    //    3   4   5
    //    |    \ /
    //    6     7
    //     \   /
    //       8
    const graph = new Map([
      [0, [1, 2]],
      [1, [3, 4]],
      [2, [5]],
      [3, [6]],
      [4, [7]],
      [5, [7]],
      [6, [8]],
      [7, [8]],
    ]);
    const roots = new Set([0]);
    const domTree = buildDominatorTree(graph, roots);

    assert.strictEqual(domTree.size, 9);
    assertIdom(domTree, 0, VIRTUAL_ROOT);
    assertIdom(domTree, 1, 0);
    assertIdom(domTree, 2, 0);
    assertIdom(domTree, 3, 1);
    assertIdom(domTree, 4, 1);
    assertIdom(domTree, 5, 2);
    assertIdom(domTree, 6, 3);
    assertIdom(domTree, 7, 0);
    assertIdom(domTree, 8, 0);
  });

  it("matches the DomTreeImpl loop case", () => {
    //        0
    //        |
    //        1
    //      /   \
    //     2     3 <-+
    //     |     |   |
    //     4     5 --6
    //      \   /
    //        7
    //        |
    //        8
    const graph = new Map([
      [0, [1]],
      [1, [2, 3]],
      [2, [4]],
      [3, [5]],
      [4, [7]],
      [5, [6, 7]],
      [6, [3]],
      [7, [8]],
    ]);
    const roots = new Set([0]);
    const domTree = buildDominatorTree(graph, roots);

    assert.strictEqual(domTree.size, 9);
    assertIdom(domTree, 0, VIRTUAL_ROOT);
    assertIdom(domTree, 1, 0);
    assertIdom(domTree, 2, 1);
    assertIdom(domTree, 3, 1);
    assertIdom(domTree, 4, 2);
    assertIdom(domTree, 5, 3);
    assertIdom(domTree, 6, 5);
    assertIdom(domTree, 7, 1);
    assertIdom(domTree, 8, 7);
  });

  it("matches the LLVM consecutive-regions graph at block level", () => {
    const graph = new Map([
      [0, [10]],
      [10, [11]],
      [11, [12, 13]],
      [12, [14]],
      [13, [13, 14]],
      [14, [20]],
      [20, [21]],
      [21, [22]],
      [22, [30]],
    ]);
    const roots = new Set([0]);
    const domTree = buildDominatorTree(graph, roots);

    assertDomChildren(domTree, 10, [11]);
    assertDomChildren(domTree, 11, [12, 13, 14]);
    assertDomChildren(domTree, 12, []);
    assertDomChildren(domTree, 13, []);
    assertDomChildren(domTree, 14, [20]);
    assertDomChildren(domTree, 20, [21]);
    assertDomChildren(domTree, 21, [22]);

    assert.strictEqual(dominates(domTree, 10, 20), true);
    assert.strictEqual(dominates(domTree, 20, 10), false);

    assert.strictEqual(dominates(domTree, 11, 14), true);
    assert.strictEqual(dominates(domTree, 14, 11), false);

    assert.strictEqual(dominates(domTree, 21, 22), true);
    assert.strictEqual(dominates(domTree, 22, 21), false);

    assert.strictEqual(dominates(domTree, 11, 21), true);
    assert.strictEqual(dominates(domTree, 21, 11), false);

    assert.strictEqual(dominates(domTree, 14, 21), true);
    assert.strictEqual(dominates(domTree, 13, 21), false);

    assert.strictEqual(dominates(domTree, 10, 21), true);
    assert.strictEqual(dominates(domTree, 21, 10), false);
  });

  it("matches the LLVM nested-regions graph at block level", () => {
    const graph = new Map([
      [0, [10]],
      [10, [11]],
      [11, [20, 12]],
      [20, [21]],
      [21, [22]],
      [22, [21, 23]],
      [23, [13]],
      [12, [13]],
      [13, [30]],
      [30, [31]],
    ]);
    const roots = new Set([0]);
    const domTree = buildDominatorTree(graph, roots);

    assertDomChildren(domTree, 0, [10]);
    assertDomChildren(domTree, 10, [11]);
    assertDomChildren(domTree, 11, [12, 13, 20]);
    assertDomChildren(domTree, 12, []);
    assertDomChildren(domTree, 20, [21]);
    assertDomChildren(domTree, 21, [22]);
    assertDomChildren(domTree, 22, [23]);
    assertDomChildren(domTree, 23, []);
    assertDomChildren(domTree, 13, [30]);
    assertDomChildren(domTree, 30, [31]);
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
