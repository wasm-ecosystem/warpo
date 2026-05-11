import { ObjectHeader } from "./types.js";
import { ClassResolver } from "./classResolver.js";

/**
 * Scan object payloads to build a precise reference graph using debug info.
 *
 * @param memory Header-stripped DataView (wasm addr 0 = offset 0)
 * @param objects Parsed object headers from parseAllObjects
 * @param classResolver ClassResolver built from debug info
 * @returns Adjacency list: payloadPtr → array of referenced payloadPtrs
 */
export function scanReferences(
  memory: DataView,
  objects: ObjectHeader[],
  classResolver: ClassResolver,
): Map<number, number[]> {
  const validPtrs = new Set<number>();
  for (const obj of objects) {
    validPtrs.add(obj.payloadPtr);
  }

  const graph = new Map<number, number[]>();

  for (const obj of objects) {
    const edges: number[] = [];

    if (classResolver.isPointerfree(obj.rtId)) {
      graph.set(obj.payloadPtr, edges);
      continue;
    }

    const classLayout = classResolver.getClassDef(obj.rtId);
    if (!classLayout) {
      graph.set(obj.payloadPtr, edges);
      continue;
    }

    // Scan declared reference fields (including inherited via getReferenceFields)
    const refFields = classResolver.getReferenceFields(obj.rtId);
    for (const field of refFields) {
      if (field.offset + field.size <= obj.rtSize) {
        const ptr = memory.getUint32(obj.payloadPtr + field.offset, true);
        // Note: pointers to static data region objects (e.g. string constants)
        // will not be in validPtrs since walkBlocks only covers TLSF heap blocks.
        // This is intentional — static objects are not GC-managed and should not
        // participate in retained size calculation.
        if (ptr !== 0 && validPtrs.has(ptr)) {
          edges.push(ptr);
        }
      }
    }

    // Container element scanning
    if (classResolver.hasReferenceElements(obj.rtId)) {
      const name = classLayout.name;

      if (name.startsWith("~lib/array/Array<")) {
        // Array<T>: elements stored in external ArrayBuffer via dataStart
        // Layout: buffer@0, dataStart@4, byteLength@8, length_@12
        if (obj.rtSize >= 16) {
          const dataStart = memory.getUint32(obj.payloadPtr + 4, true);
          const length_ = memory.getUint32(obj.payloadPtr + 12, true);
          for (let i = 0; i < length_; i++) {
            const elemAddr = dataStart + i * 4;
            if (elemAddr + 4 <= memory.byteLength) {
              const elemPtr = memory.getUint32(elemAddr, true);
              if (elemPtr !== 0 && validPtrs.has(elemPtr)) {
                edges.push(elemPtr);
              }
            }
          }
        }
      } else if (name.startsWith("~lib/staticarray/StaticArray<")) {
        // StaticArray<T>: elements inline in payload
        const elementCount = obj.rtSize >>> 2;
        for (let i = 0; i < elementCount; i++) {
          const elemPtr = memory.getUint32(obj.payloadPtr + i * 4, true);
          if (elemPtr !== 0 && validPtrs.has(elemPtr)) {
            edges.push(elemPtr);
          }
        }
      }
    }

    // Set/Map entry scanning: walk entries buffer using entryLayout
    if (classLayout.entryLayout && classLayout.entryLayout.referenceOffsets.length > 0) {
      const entryLayout = classLayout.entryLayout;
      // Set layout: buckets@0, bucketsMask@4, entries@8, entriesCount@12, entriesOffset@16, ...
      // Map layout: same as Set
      if (obj.rtSize >= 20) {
        const entriesPtr = memory.getUint32(obj.payloadPtr + 8, true);
        const entriesOffset = memory.getInt32(obj.payloadPtr + 16, true);

        if (entriesPtr !== 0 && validPtrs.has(entriesPtr)) {
          for (let i = 0; i < entriesOffset; i++) {
            const entryBase = entriesPtr + i * entryLayout.size;
            // taggedNext is at the last 4 bytes of the entry
            const taggedNextAddr = entryBase + entryLayout.size - 4;
            if (taggedNextAddr + 4 > memory.byteLength) break;
            const taggedNext = memory.getUint32(taggedNextAddr, true);
            // Low bit set means EMPTY (deleted) entry — skip
            if (taggedNext & 1) continue;

            for (const refOffset of entryLayout.referenceOffsets) {
              const addr = entryBase + refOffset;
              if (addr + 4 <= memory.byteLength) {
                const ptr = memory.getUint32(addr, true);
                if (ptr !== 0 && validPtrs.has(ptr)) {
                  edges.push(ptr);
                }
              }
            }
          }
        }
      }
    }

    graph.set(obj.payloadPtr, edges);
  }

  return graph;
}
