// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import assert from "node:assert/strict";
import { DW_AT, DW_TAG, buildOffsetMap, getAttr, parseWasmDebugInfo, type DwarfDIE } from "./dwarfParser.js";

export const WARPO_DEBUG_CLOSURE_ENV_LOCAL_NAME = "~__warpo_debug_closure_env";

export interface DwarfLocalVariableInfo {
  name: string;
  typeName: string;
  localIndex: number;
  fieldOffset?: number;
}

export interface DwarfClosureVariableInfo {
  name: string;
  typeName: string;
  closureEnvLocalIndex: number;
  fieldOffset: number;
}

export interface DwarfRangeInfo {
  lowPc: number;
  highPc: number;
}

export type DwarfScopeChild = DwarfScopeInfo | DwarfFunctionInfo;
export type DwarfParentInfo = DwarfScopeInfo | DwarfFunctionInfo;
type DwarfTreeNode = DwarfFunctionInfo | DwarfScopeInfo;

export interface DwarfScopeInfo {
  kind: "scope";
  parent: DwarfParentInfo;
  range: DwarfRangeInfo;
  closureEnvLocalIndex?: number;
  variables: DwarfLocalVariableInfo[];
  children: DwarfScopeChild[];
}

export interface DwarfFunctionInfo {
  kind: "function";
  parent?: DwarfParentInfo;
  name: string;
  range: DwarfRangeInfo;
  closureEnvLocalIndex?: number;
  parameters: DwarfLocalVariableInfo[];
  variables: DwarfLocalVariableInfo[];
  children: DwarfScopeChild[];
}

export class DwarfFunctionInfoResolver {
  private readonly functions: DwarfFunctionInfo[];

  private constructor(functions: DwarfFunctionInfo[]) {
    this.functions = functions;
  }

  static fromWasm(wasmBinary: Uint8Array | ArrayBuffer): DwarfFunctionInfoResolver {
    const debugInfo = parseWasmDebugInfo(wasmBinary);
    const functions: DwarfFunctionInfo[] = [];

    for (const unit of debugInfo.compilationUnits) {
      const offsetMap = buildOffsetMap(unit.rootDIE);
      for (const subprogramDie of findRootSubprogramDIEs(unit.rootDIE)) {
        const functionInfo = resolveFunctionInfo(subprogramDie, offsetMap);
        if (functionInfo) {
          functions.push(functionInfo);
        }
      }
    }

    sortByRange(functions);

    return new DwarfFunctionInfoResolver(functions);
  }

  getFunctions(): DwarfFunctionInfo[] {
    return this.functions;
  }

  findFunctionByBytecodeOffset(bytecodeOffset: number): DwarfFunctionInfo | undefined {
    const node = findClosestNodeByBytecodeOffset(this.functions, bytecodeOffset);
    return node ? getScopeTrace(node)?.functionInfo : undefined;
  }
}

function findRootSubprogramDIEs(root: DwarfDIE): DwarfDIE[] {
  const subprograms: DwarfDIE[] = [];

  function visit(die: DwarfDIE, insideFunctionScope: boolean): void {
    if (die.tag === DW_TAG.subprogram && !insideFunctionScope) {
      subprograms.push(die);
      return;
    }

    const nextInsideFunctionScope = insideFunctionScope || die.tag === DW_TAG.lexical_block;
    for (const child of die.children) {
      visit(child, nextInsideFunctionScope);
    }
  }

  visit(root, false);
  return subprograms;
}

function resolveFunctionInfo(
  subprogramDie: DwarfDIE,
  offsetMap: Map<number, DwarfDIE>,
  parent?: DwarfParentInfo
): DwarfFunctionInfo | null {
  const name = getAttr(subprogramDie, DW_AT.name)?.value as string | undefined;
  if (!name) {
    return null;
  }

  const parameters: DwarfLocalVariableInfo[] = [];
  const variables: DwarfLocalVariableInfo[] = [];
  const children: DwarfScopeChild[] = [];
  let closureEnvLocalIndex: number | undefined;

  const functionInfo: DwarfFunctionInfo = {
    kind: "function",
    parent,
    name,
    range: resolveRangeInfo(subprogramDie),
    parameters,
    variables,
    children,
  };

  for (const die of subprogramDie.children) {
    const childClosureEnvLocalIndex = collectFunctionChild(
      die,
      offsetMap,
      functionInfo,
      parameters,
      variables,
      children
    );
    closureEnvLocalIndex ??= childClosureEnvLocalIndex;
  }

  functionInfo.closureEnvLocalIndex = closureEnvLocalIndex;

  sortByRange(children);

  return functionInfo;
}

function collectFunctionChild(
  die: DwarfDIE,
  offsetMap: Map<number, DwarfDIE>,
  functionInfo: DwarfFunctionInfo,
  parameters: DwarfLocalVariableInfo[],
  variables: DwarfLocalVariableInfo[],
  children: DwarfScopeChild[]
): number | undefined {
  if (die.tag === DW_TAG.formal_parameter) {
    const parameter = resolveVariableInfo(die, offsetMap);
    if (parameter) {
      parameters.push(parameter);
    }
    return undefined;
  }

  if (die.tag === DW_TAG.variable) {
    const variable = resolveVariableInfo(die, offsetMap);
    if (variable) {
      if (isClosureEnvVariable(variable)) {
        return variable.localIndex;
      }
      variables.push(variable);
    }
    return undefined;
  }

  if (die.tag === DW_TAG.lexical_block) {
    children.push(resolveScopeInfo(die, offsetMap, functionInfo));
    return undefined;
  }

  if (die.tag === DW_TAG.subprogram) {
    const childFunctionInfo = resolveFunctionInfo(die, offsetMap, functionInfo);
    if (childFunctionInfo) {
      children.push(childFunctionInfo);
    }
  }

  return undefined;
}

export function getVariablesInFunctionAtBytecodeOffset(
  functionInfo: DwarfFunctionInfo,
  bytecodeOffset: number
): DwarfLocalVariableInfo[] {
  const variables: DwarfLocalVariableInfo[] = [];
  for (const parameter of functionInfo.parameters) {
    variables.push(parameter);
  }
  for (const variable of functionInfo.variables) {
    variables.push(variable);
  }
  const scope = findClosestScopeByBytecodeOffset(functionInfo.children, bytecodeOffset);
  if (!scope) {
    return variables;
  }

  const scopeTrace = getScopeTrace(scope);
  assert(scopeTrace !== undefined);
  for (const activeScope of scopeTrace.scopes) {
    for (const variable of activeScope.variables) {
      variables.push(variable);
    }
  }
  return variables;
}

export function getClosureVariablesInFunction(functionInfo: DwarfFunctionInfo): DwarfClosureVariableInfo[] {
  if (functionInfo.closureEnvLocalIndex === undefined) {
    return [];
  }

  const variables: DwarfClosureVariableInfo[] = [];
  let current = functionInfo.parent;
  while (current) {
    for (const variable of getNodeVariables(current)) {
      if (variable.fieldOffset !== undefined) {
        variables.push({
          name: variable.name,
          typeName: variable.typeName,
          closureEnvLocalIndex: functionInfo.closureEnvLocalIndex,
          fieldOffset: variable.fieldOffset,
        });
      }
    }
    current = current.parent;
  }
  return variables;
}

export function getScopeChainInFunctionAtBytecodeOffset(
  functionInfo: DwarfFunctionInfo,
  bytecodeOffset: number
): DwarfScopeInfo[] {
  const scope = findClosestScopeByBytecodeOffset(functionInfo.children, bytecodeOffset);
  if (!scope) {
    return [];
  }

  const scopeTrace = getScopeTrace(scope);
  assert(scopeTrace !== undefined);
  return scopeTrace.scopes;
}

function getNodeVariables(node: DwarfFunctionInfo | DwarfScopeInfo): DwarfLocalVariableInfo[] {
  if (isDwarfFunctionInfo(node)) {
    const variables: DwarfLocalVariableInfo[] = [];
    for (const parameter of node.parameters) {
      variables.push(parameter);
    }
    for (const variable of node.variables) {
      variables.push(variable);
    }
    return variables;
  }
  return node.variables;
}

interface DwarfScopeTrace {
  scopes: DwarfScopeInfo[];
  functionInfo: DwarfFunctionInfo;
}

function getScopeTrace(node: DwarfFunctionInfo | DwarfScopeInfo): DwarfScopeTrace | undefined {
  const scopes: DwarfScopeInfo[] = [];
  let current: DwarfParentInfo | undefined = node;

  while (current) {
    if (isDwarfFunctionInfo(current)) {
      return { scopes: scopes.toReversed(), functionInfo: current };
    }

    if (isDwarfScopeInfo(current)) {
      scopes.push(current);
      current = current.parent;
    }
  }

  return undefined;
}

function resolveScopeInfo(
  scopeDie: DwarfDIE,
  offsetMap: Map<number, DwarfDIE>,
  parent: DwarfParentInfo
): DwarfScopeInfo {
  const variables: DwarfLocalVariableInfo[] = [];
  const children: DwarfScopeChild[] = [];
  let closureEnvLocalIndex: number | undefined;

  const scopeInfo: DwarfScopeInfo = {
    kind: "scope",
    parent,
    range: resolveRangeInfo(scopeDie),
    variables,
    children,
  };

  for (const die of scopeDie.children) {
    const childClosureEnvLocalIndex = collectScopeChild(die, offsetMap, scopeInfo, variables, children);
    closureEnvLocalIndex ??= childClosureEnvLocalIndex;
  }

  scopeInfo.closureEnvLocalIndex = closureEnvLocalIndex;

  sortByRange(children);

  return scopeInfo;
}

function collectScopeChild(
  die: DwarfDIE,
  offsetMap: Map<number, DwarfDIE>,
  scopeInfo: DwarfScopeInfo,
  variables: DwarfLocalVariableInfo[],
  children: DwarfScopeChild[]
): number | undefined {
  if (die.tag === DW_TAG.variable) {
    const variable = resolveVariableInfo(die, offsetMap);
    if (!variable) {
      return undefined;
    }

    if (isClosureEnvVariable(variable)) {
      return variable.localIndex;
    }

    variables.push(variable);
    return undefined;
  }

  if (die.tag === DW_TAG.lexical_block) {
    children.push(resolveScopeInfo(die, offsetMap, scopeInfo));
    return undefined;
  }

  if (die.tag === DW_TAG.subprogram) {
    const functionInfo = resolveFunctionInfo(die, offsetMap, scopeInfo);
    if (functionInfo) {
      children.push(functionInfo);
    }
  }

  return undefined;
}

function isClosureEnvVariable(variable: DwarfLocalVariableInfo): boolean {
  return variable.name === WARPO_DEBUG_CLOSURE_ENV_LOCAL_NAME;
}

function isDwarfScopeInfo(child: DwarfScopeChild): child is DwarfScopeInfo {
  return child.kind === "scope";
}

function isDwarfFunctionInfo(child: DwarfScopeChild): child is DwarfFunctionInfo {
  return child.kind === "function";
}

function findClosestNodeByBytecodeOffset(nodes: DwarfTreeNode[], bytecodeOffset: number): DwarfTreeNode | undefined {
  let closest: DwarfTreeNode | undefined;

  function visit(node: DwarfTreeNode): void {
    if (containsBytecodeOffset(node, bytecodeOffset) && isCloserNode(node, closest)) {
      closest = node;
    }

    for (const child of node.children) {
      visit(child);
    }
  }

  for (const node of nodes) {
    visit(node);
  }

  return closest;
}

function containsBytecodeOffset(node: DwarfTreeNode, bytecodeOffset: number): boolean {
  return bytecodeOffset >= node.range.lowPc && bytecodeOffset <= node.range.highPc;
}

function isCloserNode(node: DwarfTreeNode, current: DwarfTreeNode | undefined): boolean {
  if (!current) {
    return true;
  }

  return getRangeSize(node) < getRangeSize(current);
}

function getRangeSize(node: DwarfTreeNode): number {
  return node.range.highPc - node.range.lowPc;
}

function findClosestScopeByBytecodeOffset(
  children: DwarfScopeChild[],
  bytecodeOffset: number
): DwarfScopeInfo | undefined {
  const child = findByBytecodeOffset(children, bytecodeOffset);
  if (!child || !isDwarfScopeInfo(child)) {
    return undefined;
  }

  return findClosestScopeByBytecodeOffset(child.children, bytecodeOffset) ?? child;
}

function findByBytecodeOffset<T extends DwarfFunctionInfo | DwarfScopeInfo>(
  nodes: T[],
  bytecodeOffset: number
): T | undefined {
  let left = 0;
  let right = nodes.length - 1;

  while (left <= right) {
    const mid = Math.floor((left + right) / 2);
    const range = nodes[mid].range;

    if (bytecodeOffset < range.lowPc) {
      right = mid - 1;
    } else if (bytecodeOffset > range.highPc) {
      left = mid + 1;
    } else {
      return nodes[mid];
    }
  }

  return undefined;
}

function sortByRange<T extends DwarfFunctionInfo | DwarfScopeInfo>(nodes: T[]): void {
  nodes.sort((left, right) => {
    return left.range.lowPc - right.range.lowPc || left.range.highPc - right.range.highPc;
  });
}

function resolveRangeInfo(die: DwarfDIE): DwarfRangeInfo {
  const lowPc = getAttr(die, DW_AT.low_pc)?.value as number | undefined;
  const highPc = getAttr(die, DW_AT.high_pc)?.value as number | undefined;
  assert(lowPc !== undefined);
  assert(highPc !== undefined);

  return { lowPc, highPc };
}

function resolveVariableInfo(die: DwarfDIE, offsetMap: Map<number, DwarfDIE>): DwarfLocalVariableInfo | null {
  const name = getAttr(die, DW_AT.name)?.value as string | undefined;
  const typeRef = getAttr(die, DW_AT.type)?.value as number | undefined;
  const location = getAttr(die, DW_AT.location)?.value as number | undefined;
  if (!name || typeRef === undefined || location === undefined) {
    return null;
  }

  const typeDie = offsetMap.get(typeRef);
  const typeName = (typeDie ? getAttr(typeDie, DW_AT.name)?.value : undefined) as string | undefined;
  if (!typeName) {
    return null;
  }

  const fieldOffset = getAttr(die, DW_AT.data_member_location)?.value as number | undefined;
  return {
    name,
    typeName,
    localIndex: location,
    fieldOffset,
  };
}
