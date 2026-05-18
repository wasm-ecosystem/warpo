/**
 * Dominator tree computation using the Lengauer-Tarjan algorithm.
 * Computes immediate dominators for all nodes reachable from GC roots.
 */

/**
 * Virtual super-root node ID. Must not collide with any real payloadPtr.
 * Using -1 (which is 0xFFFFFFFF in unsigned, impossible as a wasm address).
 */
export const VIRTUAL_ROOT = -1;

/**
 * Build dominator tree using the Lengauer-Tarjan algorithm.
 *
 * @param graph Adjacency list (node → successors)
 * @param rootNodes Set of GC root payloadPtrs (deduplicated from RootInfo[])
 * @returns Map<node, immediate dominator> for all reachable nodes
 */
// eslint-disable-next-line sonarjs/cognitive-complexity
export function buildDominatorTree(graph: Map<number, number[]>, rootNodes: Set<number>): Map<number, number> {
  // DFS numbering arrays
  const semi: number[] = []; // semi-dominator DFS number
  const vertex: number[] = []; // DFS number → node
  const parent: number[] = []; // DFS number → parent DFS number
  const label: number[] = []; // used for path compression (EVAL)
  const ancestor: number[] = []; // union-find ancestor
  const idom: number[] = []; // immediate dominator in DFS numbering
  const bucket: number[][] = []; // bucket[v] = list of vertices whose sdom is v

  // Mapping between node IDs and DFS numbers
  const nodeToNum = new Map<number, number>();
  let n = 0; // counter

  // Build predecessor map (reverse edges) for all nodes
  const pred: number[][] = [];
  const rootSuccessors = Array.from(rootNodes);

  // Augment graph with virtual root edges
  const augSuccessors = (node: number): number[] => {
    if (node === VIRTUAL_ROOT) {
      return rootSuccessors;
    }
    return graph.get(node) ?? [];
  };

  // Step 1: DFS from VIRTUAL_ROOT
  // Iterative DFS to avoid stack overflow on large graphs
  const dfsStack: Array<{ node: number; parentNum: number }> = [{ node: VIRTUAL_ROOT, parentNum: -1 }];

  while (dfsStack.length > 0) {
    const { node, parentNum } = dfsStack.pop();

    if (nodeToNum.has(node)) {
      continue;
    }

    const num = n++;
    nodeToNum.set(node, num);
    vertex[num] = node;
    parent[num] = parentNum;
    semi[num] = num;
    label[num] = num;
    ancestor[num] = -1;
    idom[num] = 0;
    bucket[num] = [];
    pred[num] = [];

    const succs = augSuccessors(node);
    // Push in reverse so we visit in forward order
    for (let i = succs.length - 1; i >= 0; i--) {
      const succ = succs[i];
      if (!nodeToNum.has(succ)) {
        // TODO: to be optimized, reduce memory allocation
        dfsStack.push({ node: succ, parentNum: num });
      }
    }
  }

  if (n === 0) {
    return new Map();
  }

  // Build predecessor lists using DFS numbering
  for (let u = 0; u < n; u++) {
    const node = vertex[u];
    const succs = augSuccessors(node);
    for (const succ of succs) {
      const vNum = nodeToNum.get(succ);
      if (vNum !== undefined) {
        pred[vNum].push(u);
      }
    }
  }

  // COMPRESS: path compression on the forest
  function compress(v: number): void {
    const stack: number[] = [];
    let cur = v;
    while (ancestor[ancestor[cur]] !== -1) {
      stack.push(cur);
      cur = ancestor[cur];
    }
    // Now cur's ancestor is a root (ancestor[ancestor[cur]] === -1)
    for (let i = stack.length - 1; i >= 0; i--) {
      const u = stack[i];
      if (semi[label[ancestor[u]]] < semi[label[u]]) {
        label[u] = label[ancestor[u]];
      }
      ancestor[u] = ancestor[cur];
    }
  }

  // EVAL: return vertex with minimum semi in ancestor chain
  function evalNode(v: number): number {
    if (ancestor[v] === -1) {
      return v;
    }
    compress(v);
    return label[v];
  }

  // LINK: set ancestor[w] = v
  function link(v: number, w: number): void {
    ancestor[w] = v;
  }

  // Step 2 & 3: Process vertices in reverse DFS order
  for (let i = n - 1; i >= 1; i--) {
    const w = i;
    const p = parent[w];

    // Step 2: Compute semi-dominator
    let s = p;
    for (const v of pred[w]) {
      const u = evalNode(v);
      if (semi[u] < s) {
        s = semi[u];
      }
    }
    semi[w] = s;
    bucket[s].push(w);
    link(p, w);

    // Step 3: Process bucket of parent
    for (const v of bucket[p]) {
      const u = evalNode(v);
      idom[v] = semi[u] < semi[v] ? u : p;
    }
    bucket[p].length = 0;
  }

  // Step 4: Finalize idom values
  for (let i = 1; i < n; i++) {
    if (idom[i] !== semi[i]) {
      idom[i] = idom[idom[i]];
    }
  }
  idom[0] = -1; // VIRTUAL_ROOT has no dominator

  // Build result map: node → idom node
  const result = new Map<number, number>();
  for (let i = 1; i < n; i++) {
    result.set(vertex[i], vertex[idom[i]]);
  }

  return result;
}
