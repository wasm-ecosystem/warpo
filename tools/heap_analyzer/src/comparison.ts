// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import type {
  ComparisonInstance,
  ConstructorComparisonEntry,
  ConstructorEntry,
  ConstructorInstance,
  HeapComparison,
  HeapSnapshot,
} from "./types.js";

export function compareSnapshots(before: HeapSnapshot, after: HeapSnapshot): HeapComparison {
  const beforeConstructors = new Map(before.constructors.map((entry) => [entry.className, entry]));
  const afterConstructors = new Map(after.constructors.map((entry) => [entry.className, entry]));
  const classNames = new Set([...beforeConstructors.keys(), ...afterConstructors.keys()]);

  return {
    beforeTotalHeapSize: before.totalHeapSize,
    afterTotalHeapSize: after.totalHeapSize,
    totalHeapSizeDelta: after.totalHeapSize - before.totalHeapSize,
    beforeTotalLiveSize: before.totalLiveSize,
    afterTotalLiveSize: after.totalLiveSize,
    totalLiveSizeDelta: after.totalLiveSize - before.totalLiveSize,
    constructors: [...classNames]
      .map((className) => compareConstructorEntries(className, beforeConstructors.get(className), afterConstructors.get(className)))
      .filter((entry) => entry.instances.length > 0)
      .toSorted(sortConstructorComparisons),
  };
}

function compareConstructorEntries(
  className: string,
  beforeEntry: ConstructorEntry | undefined,
  afterEntry: ConstructorEntry | undefined
): ConstructorComparisonEntry {
  const beforeInstancesByAddress = indexInstancesByAddress(beforeEntry?.instances ?? []);
  const afterInstancesByAddress = indexInstancesByAddress(afterEntry?.instances ?? []);
  const newInstances: ComparisonInstance[] = [...afterInstancesByAddress.entries()]
    .filter(([address]) => !beforeInstancesByAddress.has(address))
    .map(([, instance]) => ({
      address: instance.address,
      shallowSize: instance.shallowSize,
      retainedSize: instance.retainedSize,
      changeKind: "new",
    }));
  const deletedInstances: ComparisonInstance[] = [...beforeInstancesByAddress.entries()]
    .filter(([address]) => !afterInstancesByAddress.has(address))
    .map(([, instance]) => ({
      address: instance.address,
      shallowSize: instance.shallowSize,
      retainedSize: instance.retainedSize,
      changeKind: "delete",
    }));
  const instances = [...newInstances, ...deletedInstances].toSorted(sortComparisonInstances);
  const allocatedSize = sumShallowSize(newInstances);
  const freedSize = sumShallowSize(deletedInstances);

  return {
    className,
    newCount: newInstances.length,
    deletedCount: deletedInstances.length,
    countDelta: newInstances.length - deletedInstances.length,
    allocatedSize,
    freedSize,
    sizeDelta: allocatedSize - freedSize,
    instances,
  };
}

function indexInstancesByAddress(instances: ConstructorInstance[]): Map<number, ConstructorInstance> {
  return new Map(instances.map((instance) => [instance.address, instance]));
}

function sortConstructorComparisons(lhs: ConstructorComparisonEntry, rhs: ConstructorComparisonEntry): number {
  return (
    rhs.sizeDelta - lhs.sizeDelta ||
    rhs.allocatedSize - lhs.allocatedSize ||
    rhs.countDelta - lhs.countDelta ||
    lhs.className.localeCompare(rhs.className)
  );
}

function sortComparisonInstances(lhs: ComparisonInstance, rhs: ComparisonInstance): number {
  return (
    compareChangeKind(lhs.changeKind, rhs.changeKind) ||
    rhs.shallowSize - lhs.shallowSize ||
    rhs.retainedSize - lhs.retainedSize ||
    lhs.address - rhs.address
  );
}

function compareChangeKind(lhs: ComparisonInstance["changeKind"], rhs: ComparisonInstance["changeKind"]): number {
  if (lhs === rhs) {
    return 0;
  }

  return lhs === "new" ? -1 : 1;
}

function sumShallowSize(instances: Array<Pick<ComparisonInstance, "shallowSize">>): number {
  return instances.reduce((sum, instance) => sum + instance.shallowSize, 0);
}