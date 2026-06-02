// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

// TLSF Allocator Constants (32-bit)
export const AL_BITS = 4;
export const AL_SIZE = 1 << AL_BITS; // 16
export const AL_MASK = AL_SIZE - 1; // 15

export const BLOCK_OVERHEAD = 4; // mmInfo only
export const OBJECT_OVERHEAD = 16; // nextWithColor + prev + rtId + rtSize
export const TOTAL_OVERHEAD = BLOCK_OVERHEAD + OBJECT_OVERHEAD; // 20

export const SL_BITS = 4;
export const SB_BITS = 8;
export const FL_BITS = 23;
export const SL_SIZE = 1 << SL_BITS; // 16
export const ROOT_SIZE = 1572; // TLSF root structure size

// Block flags (in mmInfo)
export const FREE = 1;
export const LEFT_FREE = 2;
export const TAGS_MASK = 3;

// GC Color (in nextWithColor & 3)
export const COLOR_MASK = 3;
// 0 and 1 are white/black but swap each GC cycle (white ^= 1 in rt/itcms.ts)
// Only gray (2) and transparent (3) have fixed meaning
export const GC_COLOR_GRAY = 2;
export const GC_COLOR_TRANSPARENT = 3; // pinned, always reachable

// Dump file
export const DUMP_MAGIC = 0x44485341; // "A S H D" in LE
export const DUMP_MAGIC_BYTES = new Uint8Array([0x41, 0x53, 0x48, 0x44]); // A, S, H, D
export const DUMP_VERSION = 2;
export const DUMP_HEADER_SIZE = 24;
