// Copyright (C) 2025 Daniel Wirtz / The AssemblyScript Authors
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

const MASK_32 = 0xffff_ffffn;
const MASK_64 = 0xffff_ffff_ffff_ffffn;
const SIGN_64 = 0x8000_0000_0000_0000n;

declare function BigInt(value: number | string | bigint | boolean): bigint;

declare global {
  var i64_zero: i64;
  var i64_one: i64;

  function i64_new(lo: i32, hi?: i32): i64;
  function i64_add(left: i64, right: i64): i64;
  function i64_mul(left: i64, right: i64): i64;
  function i64_or(left: i64, right: i64): i64;
  function i64_shl(left: i64, right: i64): i64;
  function i64_gt(left: i64, right: i64): bool;
  function i64_gt_u(left: i64, right: i64): bool;
  function i64_low(value: i64): i32;
  function i64_high(value: i64): i32;
}

function toUnsigned(value: bigint): bigint {
  return value & MASK_64;
}

function toSigned(value: bigint): bigint {
  let normalized = toUnsigned(value);
  return normalized >= SIGN_64 ? normalized - (MASK_64 + 1n) : normalized;
}

function asBigInt(value: i64): bigint {
  return toSigned(value as unknown as bigint);
}

function asI64(value: bigint): i64 {
  return toSigned(value) as unknown as i64;
}

function asI32(value: bigint): i32 {
  let textValue = (value & MASK_32) as unknown as { toString(radix?: number): string };
  return (parseInt(textValue.toString(), 10) | 0) as i32;
}

let runtime = globalThis as any;

runtime.assert =
  runtime.assert ??
  function assert<T>(value: T, message?: string): T {
    if (!value) throw new Error(message ?? "Assertion failed");
    return value;
  };

if (!runtime.i32) {
  let cast = ((value: number): i32 => value | 0) as ((value: number) => i32) & { MAX_VALUE: i32 };
  cast.MAX_VALUE = 0x7fff_ffff as i32;
  runtime.i32 = cast;
}

runtime.unchecked =
  runtime.unchecked ??
  function unchecked<T>(value: T): T {
    return value;
  };

runtime.i64_zero = asI64(0n);
runtime.i64_one = asI64(1n);

runtime.i64_new = function i64_new(lo: i32, hi: i32 = lo < 0 ? -1 : 0): i64 {
  let low = BigInt(lo >>> 0);
  let high = BigInt(hi | 0);
  return asI64((high << 32n) | low);
};

runtime.i64_add = function i64_add(left: i64, right: i64): i64 {
  return asI64(asBigInt(left) + asBigInt(right));
};

runtime.i64_mul = function i64_mul(left: i64, right: i64): i64 {
  return asI64(asBigInt(left) * asBigInt(right));
};

runtime.i64_or = function i64_or(left: i64, right: i64): i64 {
  return asI64(toUnsigned(asBigInt(left)) | toUnsigned(asBigInt(right)));
};

runtime.i64_shl = function i64_shl(left: i64, right: i64): i64 {
  let shift = BigInt(i64_low(right) & 63);
  return asI64(toUnsigned(asBigInt(left)) << shift);
};

runtime.i64_gt = function i64_gt(left: i64, right: i64): bool {
  return asBigInt(left) > asBigInt(right);
};

runtime.i64_gt_u = function i64_gt_u(left: i64, right: i64): bool {
  return toUnsigned(asBigInt(left)) > toUnsigned(asBigInt(right));
};

runtime.i64_low = function i64_low(value: i64): i32 {
  return asI32(toUnsigned(asBigInt(value)));
};

runtime.i64_high = function i64_high(value: i64): i32 {
  return asI32(toUnsigned(asBigInt(value)) >> 32n);
};

export {};
