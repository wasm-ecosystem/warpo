import { ObjectHeader } from "./types.js";
import { AL_MASK, BLOCK_OVERHEAD, ROOT_SIZE, FREE, TAGS_MASK, TOTAL_OVERHEAD, COLOR_MASK } from "./constants.js";

/**
 * Walk all TLSF blocks in the heap and return parsed object headers for used blocks.
 *
 * Combines block walking with object header parsing in a single pass.
 * Object header layout (20 bytes from block start):
 *   cursor + 0:  mmInfo (u32) — block metadata
 *   cursor + 4:  nextWithColor (u32) — GC list next ptr | color (2 bits)
 *   cursor + 8:  prev (u32) — GC list prev ptr
 *   cursor + 12: rtId (u32) — class ID
 *   cursor + 16: rtSize (u32) — payload byte size
 *   cursor + 20: payload starts
 *
 * @param memory DataView of wasm linear memory (header-stripped, address 0 = offset 0)
 * @param heapBase Value of __heap_base from dump metadata
 * @returns Array of ObjectHeader for all used (non-free) blocks
 */
export function walkBlocks(memory: DataView, heapBase: number): ObjectHeader[] {
  const tlsfRoot = (heapBase + AL_MASK) & ~AL_MASK;
  // Matches AS runtime rt/tlsf.ts:
  //   initialize() calls addMemory(root, (rootOffset + ROOT_SIZE + AL_MASK) & ~AL_MASK, ...)
  //   addMemory() computes start = ((start + BLOCK_OVERHEAD + AL_MASK) & ~AL_MASK) - BLOCK_OVERHEAD
  const afterRoot = (tlsfRoot + ROOT_SIZE + AL_MASK) & ~AL_MASK;
  const firstBlock = ((afterRoot + BLOCK_OVERHEAD + AL_MASK) & ~AL_MASK) - BLOCK_OVERHEAD;
  const memoryEnd = memory.byteLength;

  const objects: ObjectHeader[] = [];
  let cursor = firstBlock;

  while (cursor + 4 <= memoryEnd) {
    const mmInfo = memory.getUint32(cursor, true);
    const blockSize = mmInfo & ~TAGS_MASK;

    // Tail sentinel: size portion is 0
    if (blockSize === 0) break;

    const isFree = (mmInfo & FREE) !== 0;
    if (!isFree) {
      const gcColor = memory.getUint32(cursor + 4, true) & COLOR_MASK;
      const rtId = memory.getUint32(cursor + 12, true);
      const rtSize = memory.getUint32(cursor + 16, true);
      const payloadPtr = cursor + TOTAL_OVERHEAD;

      objects.push({ mmInfo, rtId, rtSize, payloadPtr, gcColor });
    }

    cursor = cursor + BLOCK_OVERHEAD + blockSize;
  }

  return objects;
}
