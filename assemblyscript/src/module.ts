// Copyright (C) 2025 Daniel Wirtz / The AssemblyScript Authors
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import { BuiltinNames } from "./builtins";
import { CommonNames, Target } from "./common";
import { isHighSurrogate, isLowSurrogate, combineSurrogates, SURROGATE_HIGH, SURROGATE_LOW } from "./util";
import { Type, TypeFlags, TypeKind } from "./types";
import { ElementKind, PropertyPrototype } from "./program";
import * as binaryen from "./glue/binaryen";
import {
  ExpressionId,
  UnaryOp,
  BinaryOp,
  SIMDExtractOp,
  SIMDReplaceOp,
  SIMDShiftOp,
  SIMDLoadOp,
  SIMDLoadStoreLaneOp,
  SIMDTernaryOp,
  RefAsOp,
  ExpressionRunnerFlags,
} from "./glue/binaryen-enums";

export {
  ExpressionId,
  ExternalKind,
  UnaryOp,
  BinaryOp,
  SIMDExtractOp,
  SIMDReplaceOp,
  SIMDShiftOp,
  SIMDLoadOp,
  SIMDLoadStoreLaneOp,
  SIMDTernaryOp,
  RefAsOp,
  BrOnOp,
  StringNewOp,
  StringMeasureOp,
  StringEncodeOp,
  StringEqOp,
  ExpressionRunnerFlags,
} from "./glue/binaryen-enums";

/** A Binaryen-compatible index. */
export type Index = binaryen.Index;
/** Reference to a Binaryen-compatible string. */
export type StringRef = binaryen.StringRef;
/** Reference to a Binaryen module. */
export type ModuleRef = binaryen.ModuleRef;
/** Reference to a Binaryen function. */
export type FunctionRef = binaryen.FunctionRef;
/** Reference to a Binaryen expression. */
export type ExpressionRef = binaryen.ExpressionRef;
/** Reference to a Binaryen global. */
export type GlobalRef = binaryen.GlobalRef;
/** Reference to a Binaryen tag. */
export type TagRef = binaryen.TagRef;
/** Reference to a Binaryen import. */
export type ImportRef = binaryen.ImportRef;
/** Reference to a Binaryen export. */
export type ExportRef = binaryen.ExportRef;
/** Reference to a Binaryen relooper. */
export type RelooperRef = binaryen.RelooperRef;
/** Reference to a Binaryen relooper block. */
export type RelooperBlockRef = binaryen.RelooperBlockRef;

// The following constants must be updated by running scripts/update-constants.
// This is necessary because the functions are not yet callable with Binaryen
// compiled to WebAssembly, requiring awaiting the ready promise first. Note
// that this essentially fixes the compiler to specific versions of Binaryen
// sometimes, because these constants can differ between Binaryen versions.

/** Reference to a Binaryen type. */
export type TypeRef = binaryen.TypeRef;
export namespace TypeRef {
  // special types
  export const None: TypeRef = 0; /* _BinaryenTypeNone */
  export const Unreachable: TypeRef = 1; /* _BinaryenTypeUnreachable */
  // value types
  export const I32: TypeRef = 2; /* _BinaryenTypeInt32 */
  export const I64: TypeRef = 3; /* _BinaryenTypeInt64 */
  export const F32: TypeRef = 4; /* _BinaryenTypeFloat32 */
  export const F64: TypeRef = 5; /* _BinaryenTypeFloat64 */
  export const V128: TypeRef = 6; /* _BinaryenTypeVec128 */
  // reference/gc types
  export const Funcref = binaryen._BinaryenTypeFuncref();
  export const Externref = binaryen._BinaryenTypeExternref();
  export const Anyref = binaryen._BinaryenTypeAnyref();
  export const Eqref = binaryen._BinaryenTypeEqref();
  export const Structref = binaryen._BinaryenTypeStructref();
  export const Arrayref = binaryen._BinaryenTypeArrayref();
  export const I31ref = binaryen._BinaryenTypeI31ref();
  export const Stringref = binaryen._BinaryenTypeStringref();
  export const Noneref = binaryen._BinaryenTypeNullref();
  export const Nofuncref = binaryen._BinaryenTypeNullFuncref();
  export const Noexternref = binaryen._BinaryenTypeNullExternref();
}

/** Reference to a Binaryen heap type. */
export type HeapTypeRef = binaryen.HeapTypeRef;
export namespace HeapTypeRef {
  //        any                  extern      func
  //         |                      |          |
  //     __ eq __          ?     noextern    (...)
  //    /    |   \         |                   |
  // i31  struct  array  string              nofunc
  //  |      |      |      |
  // none  (...)  (...)    ?
  //         |      |
  //        none   none
  //
  // where (...) represents the concrete subtypes

  export const Extern: HeapTypeRef = 8; /* _BinaryenHeapTypeExt */
  export const Func: HeapTypeRef = 16; /* _BinaryenHeapTypeFunc */
  export const Any: HeapTypeRef = 32; /* _BinaryenHeapTypeAny */
  export const Eq: HeapTypeRef = 40; /* _BinaryenHeapTypeEq */
  export const I31: HeapTypeRef = 48; /* _BinaryenHeapTypeI31 */
  export const Struct: HeapTypeRef = 56; /* _BinaryenHeapTypeStruct */
  export const Array: HeapTypeRef = 64; /* _BinaryenHeapTypeArray */
  export const Exn: HeapTypeRef = 7; /* TODO: BinaryenHeapTypeExn */
  export const String: HeapTypeRef = 80; /* _BinaryenHeapTypeString */
  export const None: HeapTypeRef = 88; /* _BinaryenHeapTypeNone */
  export const Noextern: HeapTypeRef = 96; /* _BinaryenHeapTypeNoext */
  export const Nofunc: HeapTypeRef = 104; /* _BinaryenHeapTypeNofunc */

  export function isBottom(ht: HeapTypeRef): bool {
    return binaryen._BinaryenHeapTypeIsBottom(ht);
  }

  export function getBottom(ht: HeapTypeRef): HeapTypeRef {
    return binaryen._BinaryenHeapTypeGetBottom(ht);
  }

  export function isSubtype(ht: HeapTypeRef, superHt: HeapTypeRef): bool {
    return binaryen._BinaryenHeapTypeIsSubType(ht, superHt);
  }

  export function leastUpperBound(a: HeapTypeRef, b: HeapTypeRef): HeapTypeRef {
    // see binaryen/src/wasm/wasm-type.cpp
    if (a == b) return a;
    if (getBottom(a) != getBottom(b)) return -1;
    if (isBottom(a)) return b;
    if (isBottom(b)) return a;
    if (a > b) {
      let t = a;
      a = b;
      b = t;
    }
    switch (a) {
      case HeapTypeRef.Extern:
        return b == HeapTypeRef.String ? a : -1;
      case HeapTypeRef.Func:
        return -1;
      case HeapTypeRef.Any:
        return a;
      case HeapTypeRef.Eq: {
        return b == HeapTypeRef.I31 || b == HeapTypeRef.Struct || b == HeapTypeRef.Array
          ? HeapTypeRef.Eq
          : HeapTypeRef.Any;
      }
      case HeapTypeRef.I31: {
        return b == HeapTypeRef.Struct || b == HeapTypeRef.Array ? HeapTypeRef.Eq : HeapTypeRef.Any;
      }
      case HeapTypeRef.Struct: {
        return b == HeapTypeRef.Array ? HeapTypeRef.Eq : HeapTypeRef.Any;
      }
      case HeapTypeRef.Array:
        return HeapTypeRef.Any;
    }
    assert(false);
    return -1;
  }
}

/** Packed array element respectively struct field types. */
export type PackedType = binaryen.PackedType;
export namespace PackedType {
  export const NotPacked: PackedType = 0; /* _BinaryenPackedTypeNotPacked */
  export const I8: PackedType = 1; /* _BinaryenPackedTypeInt8 */
  export const I16: PackedType = 2; /* _BinaryenPackedTypeInt16 */
}

/** Type builder error reasons. */
export type TypeBuilderErrorReason = binaryen.TypeBuilderErrorReason;
export namespace TypeBuilderErrorReason {
  /** Indicates a cycle in the supertype relation. */
  export const SelfSupertype: TypeBuilderErrorReason = 0; /* _TypeBuilderErrorReasonSelfSupertype */
  /** Indicates that the declared supertype of a type is invalid. */
  export const InvalidSupertype: TypeBuilderErrorReason = 1; /* _TypeBuilderErrorReasonInvalidSupertype */
  /** Indicates that the declared supertype is an invalid forward reference. */
  export const ForwardSupertypeReference: TypeBuilderErrorReason = 2; /* _TypeBuilderErrorReasonForwardSupertypeReference */
  /** Indicates that a child of a type is an invalid forward reference. */
  export const ForwardChildReference: TypeBuilderErrorReason = 3; /* _TypeBuilderErrorReasonForwardChildReference */
  /** Converts a type builder error reason to a string. */
  export function toString(reason: TypeBuilderErrorReason): string {
    switch (reason) {
      case SelfSupertype:
        return "SelfSupertype";
      case InvalidSupertype:
        return "InvalidSupertype";
      case ForwardSupertypeReference:
        return "ForwardSupertypeReference";
      case ForwardChildReference:
        return "ForwardChildReference";
    }
    assert(false);
    return "";
  }
}
export class MemorySegment {
  constructor(
    /** Segment data. */
    public buffer: Uint8Array,
    /** Segment offset. */
    public offset: i64
  ) {}
}

export class Module {
  constructor(
    /** Binaryen module reference. */
    public ref: ModuleRef,
    /** Whether a shadow stack is used. */
    public useShadowStack: bool,
    /** Architecture-dependent size type. */
    public sizeType: TypeRef
  ) {
    assert(sizeType == TypeRef.I32 || sizeType == TypeRef.I64);
    this.lit = binaryen._malloc(binaryen._BinaryenSizeofLiteral());
  }

  private lit: binaryen.Ref;

  static create(useShadowStack: bool, sizeType: TypeRef): Module {
    return new Module(binaryen._BinaryenModuleCreate(), useShadowStack, sizeType);
  }

  static createFrom(buffer: Uint8Array, useShadowStack: bool, sizeType: TypeRef): Module {
    let cArr = allocU8Array(buffer);
    let module = new Module(binaryen._BinaryenModuleRead(cArr, buffer.length), useShadowStack, sizeType);
    binaryen._free(changetype<usize>(cArr));
    return module;
  }

  // constants

  i32(value: i32): ExpressionRef {
    let out = this.lit;
    binaryen._BinaryenLiteralInt32(out, value);
    return binaryen._BinaryenConst(this.ref, out);
  }

  i64(valueLow: i32, valueHigh: i32 = 0): ExpressionRef {
    let out = this.lit;
    binaryen._BinaryenLiteralInt64(out, valueLow, valueHigh);
    return binaryen._BinaryenConst(this.ref, out);
  }

  usize(value: i64): ExpressionRef {
    if (i64_is(value)) {
      if (this.sizeType == TypeRef.I64) {
        return this.i64(i64_low(value), i64_high(value));
      }
      assert(i64_is_u32(value));
      return this.i32(i64_low(value));
    }
    return this.sizeType == TypeRef.I64 ? this.i64(i32(value)) : this.i32(i32(value));
  }

  f32(value: f32): ExpressionRef {
    let out = this.lit;
    binaryen._BinaryenLiteralFloat32(out, value);
    return binaryen._BinaryenConst(this.ref, out);
  }

  f64(value: f64): ExpressionRef {
    let out = this.lit;
    binaryen._BinaryenLiteralFloat64(out, value);
    return binaryen._BinaryenConst(this.ref, out);
  }

  v128(bytes: Uint8Array): ExpressionRef {
    assert(bytes.length == 16);
    let out = this.lit;
    for (let i = 0; i < 16; ++i) {
      binaryen.__i32_store8(out + i, unchecked(bytes[i]));
    }
    binaryen._BinaryenLiteralVec128(out, out);
    return binaryen._BinaryenConst(this.ref, out);
  }

  ref_null(type: TypeRef): ExpressionRef {
    // TODO: Provide the desired bottom type directly? Currently, Binaryen does
    // this under the hood, but this API could change to take a heap type.
    // type = binaryen._BinaryenTypeFromHeapType(
    //   binaryen._BinaryenHeapTypeGetBottom(
    //     binaryen._BinaryenTypeGetHeapType(type)
    //   ),
    //   true
    // );
    return binaryen._BinaryenRefNull(this.ref, type);
  }

  ref_eq(left: ExpressionRef, right: ExpressionRef): ExpressionRef {
    return binaryen._BinaryenRefEq(this.ref, left, right);
  }

  // expressions

  unary(op: UnaryOp, value: ExpressionRef): ExpressionRef {
    if (op > UnaryOp._last) {
      let isWam64 = this.sizeType == TypeRef.I64;
      switch (op) {
        case UnaryOp.ClzSize:
          op = isWam64 ? UnaryOp.ClzI64 : UnaryOp.ClzI32;
          break;
        case UnaryOp.CtzSize:
          op = isWam64 ? UnaryOp.CtzI64 : UnaryOp.CtzI32;
          break;
        case UnaryOp.PopcntSize:
          op = isWam64 ? UnaryOp.PopcntI64 : UnaryOp.PopcntI32;
          break;
        case UnaryOp.EqzSize:
          op = isWam64 ? UnaryOp.EqzI64 : UnaryOp.EqzI32;
          break;
        default:
          assert(false);
      }
    }
    return binaryen._BinaryenUnary(this.ref, op, value);
  }

  binary(op: BinaryOp, left: ExpressionRef, right: ExpressionRef): ExpressionRef {
    if (op > BinaryOp._last) {
      let is64BitSizeType = this.sizeType == TypeRef.I64;
      switch (op) {
        case BinaryOp.AddSize:
          op = is64BitSizeType ? BinaryOp.AddI64 : BinaryOp.AddI32;
          break;
        case BinaryOp.SubSize:
          op = is64BitSizeType ? BinaryOp.SubI64 : BinaryOp.SubI32;
          break;
        case BinaryOp.MulSize:
          op = is64BitSizeType ? BinaryOp.MulI64 : BinaryOp.MulI32;
          break;
        case BinaryOp.DivISize:
          op = is64BitSizeType ? BinaryOp.DivI64 : BinaryOp.DivI32;
          break;
        case BinaryOp.DivUSize:
          op = is64BitSizeType ? BinaryOp.DivU64 : BinaryOp.DivU32;
          break;
        case BinaryOp.RemISize:
          op = is64BitSizeType ? BinaryOp.RemI64 : BinaryOp.RemI32;
          break;
        case BinaryOp.RemUSize:
          op = is64BitSizeType ? BinaryOp.RemU64 : BinaryOp.RemU32;
          break;
        case BinaryOp.AndSize:
          op = is64BitSizeType ? BinaryOp.AndI64 : BinaryOp.AndI32;
          break;
        case BinaryOp.OrSize:
          op = is64BitSizeType ? BinaryOp.OrI64 : BinaryOp.OrI32;
          break;
        case BinaryOp.XorSize:
          op = is64BitSizeType ? BinaryOp.XorI64 : BinaryOp.XorI32;
          break;
        case BinaryOp.ShlSize:
          op = is64BitSizeType ? BinaryOp.ShlI64 : BinaryOp.ShlI32;
          break;
        case BinaryOp.ShrISize:
          op = is64BitSizeType ? BinaryOp.ShrI64 : BinaryOp.ShrI32;
          break;
        case BinaryOp.ShrUSize:
          op = is64BitSizeType ? BinaryOp.ShrU64 : BinaryOp.ShrU32;
          break;
        case BinaryOp.RotlSize:
          op = is64BitSizeType ? BinaryOp.RotlI64 : BinaryOp.RotlI32;
          break;
        case BinaryOp.RotrSize:
          op = is64BitSizeType ? BinaryOp.RotrI64 : BinaryOp.RotrI32;
          break;
        case BinaryOp.EqSize:
          op = is64BitSizeType ? BinaryOp.EqI64 : BinaryOp.EqI32;
          break;
        case BinaryOp.NeSize:
          op = is64BitSizeType ? BinaryOp.NeI64 : BinaryOp.NeI32;
          break;
        case BinaryOp.LtISize:
          op = is64BitSizeType ? BinaryOp.LtI64 : BinaryOp.LtI32;
          break;
        case BinaryOp.LtUSize:
          op = is64BitSizeType ? BinaryOp.LtU64 : BinaryOp.LtU32;
          break;
        case BinaryOp.LeISize:
          op = is64BitSizeType ? BinaryOp.LeI64 : BinaryOp.LeI32;
          break;
        case BinaryOp.LeUSize:
          op = is64BitSizeType ? BinaryOp.LeU64 : BinaryOp.LeU32;
          break;
        case BinaryOp.GtISize:
          op = is64BitSizeType ? BinaryOp.GtI64 : BinaryOp.GtI32;
          break;
        case BinaryOp.GtUSize:
          op = is64BitSizeType ? BinaryOp.GtU64 : BinaryOp.GtU32;
          break;
        case BinaryOp.GeISize:
          op = is64BitSizeType ? BinaryOp.GeI64 : BinaryOp.GeI32;
          break;
        case BinaryOp.GeUSize:
          op = is64BitSizeType ? BinaryOp.GeU64 : BinaryOp.GeU32;
          break;
        default:
          assert(false);
      }
    }
    return binaryen._BinaryenBinary(this.ref, op, left, right);
  }

  memory_size(name: string = CommonNames.DefaultMemory, is64: bool = false): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenMemorySize(this.ref, cStr, is64);
  }

  memory_grow(delta: ExpressionRef, name: string = CommonNames.DefaultMemory, is64: bool = false): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenMemoryGrow(this.ref, delta, cStr, is64);
  }

  table_size(name: string): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenTableSize(this.ref, cStr);
  }

  table_grow(name: string, delta: ExpressionRef, value: ExpressionRef = 0): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenTableGrow(this.ref, cStr, value, delta);
  }

  local_get(index: i32, type: TypeRef): ExpressionRef {
    return binaryen._BinaryenLocalGet(this.ref, index, type);
  }

  local_to_stack(value: ExpressionRef): ExpressionRef {
    if (this.useShadowStack) {
      let type = binaryen._BinaryenExpressionGetType(value);
      assert(type == TypeRef.I32 || type == TypeRef.Unreachable);
      return this.call(BuiltinNames.localToStack, [value], type);
    }
    return value;
  }
  tmp_to_stack(value: ExpressionRef): ExpressionRef {
    if (this.useShadowStack) {
      let type = binaryen._BinaryenExpressionGetType(value);
      assert(type == TypeRef.I32 || type == TypeRef.Unreachable);
      return this.call(BuiltinNames.tmpToStack, [value], type);
    }
    return value;
  }

  get_closure_env(): ExpressionRef {
    return this.call(BuiltinNames.getClosureEnv, null, TypeRef.I32);
  }

  set_closure_env(value: ExpressionRef): ExpressionRef {
    let type = binaryen._BinaryenExpressionGetType(value);
    assert(type == TypeRef.I32 || type == TypeRef.Unreachable);
    return this.call(BuiltinNames.setClosureEnv, [value], TypeRef.None);
  }

  get_closure_env_by_level(level: i32): ExpressionRef {
    assert(level >= 0);
    return this.call(BuiltinNames.getClosureEnvByLevel, [this.i32(level)], TypeRef.I32);
  }

  local_tee(index: i32, value: ExpressionRef, isManaged: bool, type: TypeRef = -1): ExpressionRef {
    if (type == -1) type = binaryen._BinaryenExpressionGetType(value);
    if (isManaged && this.useShadowStack) {
      value = this.local_to_stack(value);
    }
    return binaryen._BinaryenLocalTee(this.ref, index, value, type);
  }

  global_get(name: string, type: TypeRef): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenGlobalGet(this.ref, cStr, type);
  }

  table_get(name: string, index: ExpressionRef, type: TypeRef): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenTableGet(this.ref, cStr, index, type);
  }

  load(
    bytes: Index,
    signed: bool,
    ptr: ExpressionRef,
    type: TypeRef,
    offset: Index = 0,
    align: Index = bytes, // naturally aligned by default
    name: string = CommonNames.DefaultMemory
  ): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenLoad(this.ref, bytes, signed, offset, align, type, ptr, cStr);
  }

  store(
    bytes: Index,
    ptr: ExpressionRef,
    value: ExpressionRef,
    type: TypeRef,
    offset: Index = 0,
    align: Index = bytes, // naturally aligned by default
    name: string = CommonNames.DefaultMemory
  ): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenStore(this.ref, bytes, offset, align, ptr, value, type, cStr);
  }

  // statements

  local_set(index: Index, value: ExpressionRef, isManaged: bool): ExpressionRef {
    if (isManaged && this.useShadowStack) {
      value = this.local_to_stack(value);
    }
    return binaryen._BinaryenLocalSet(this.ref, index, value);
  }

  global_set(name: string, value: ExpressionRef): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenGlobalSet(this.ref, cStr, value);
  }

  table_set(name: string, index: ExpressionRef, value: ExpressionRef): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenTableSet(this.ref, cStr, index, value);
  }

  block(label: string | null, children: ExpressionRef[], type: TypeRef = TypeRef.None): ExpressionRef {
    let cStr = this.allocStringCached(label);
    let cArr = allocPtrArray(children);
    let ret = binaryen._BinaryenBlock(this.ref, cStr, cArr, children.length, type);
    binaryen._free(cArr);
    return ret;
  }

  /** Attempts to trivially flatten a series of expressions instead of emitting a block. */
  flatten(stmts: ExpressionRef[], type: TypeRef = TypeRef.None): ExpressionRef {
    let length = stmts.length;
    if (length == 0) return this.nop(); // usually filtered out again
    if (length == 1) {
      let single = stmts[0];
      switch (getExpressionId(single)) {
        case ExpressionId.Return:
        case ExpressionId.Throw:
        case ExpressionId.Unreachable: {
          // type does no matter, terminates anyway
          return single;
        }
      }
      let singleType = getExpressionType(single);
      if (singleType != TypeRef.Unreachable && singleType != type) {
        // can happen when there was a diagnostic prior
        return this.unreachable();
      }
      return single;
    }
    return this.block(null, stmts, type);
  }

  br(label: string | null, condition: ExpressionRef = 0, value: ExpressionRef = 0): ExpressionRef {
    let cStr = this.allocStringCached(label);
    return binaryen._BinaryenBreak(this.ref, cStr, condition, value);
  }

  drop(expression: ExpressionRef): ExpressionRef {
    return binaryen._BinaryenDrop(this.ref, expression);
  }

  /** Drops an expression if it evaluates to a value. */
  maybeDrop(expression: ExpressionRef): ExpressionRef {
    let type = binaryen._BinaryenExpressionGetType(expression);
    if (type != TypeRef.None && type != TypeRef.Unreachable) {
      return binaryen._BinaryenDrop(this.ref, expression);
    }
    return expression;
  }

  maybeDropCondition(condition: ExpressionRef, result: ExpressionRef): ExpressionRef {
    // FIXME: This is necessary because Binaryen's ExpressionRunner bails early
    // when encountering a local with an unknown value. This helper only drops
    // the pre-evaluated condition if it has relevant side effects.
    // see WebAssembly/binaryen#1237
    if ((getSideEffects(condition, this.ref) & ~(SideEffects.ReadsLocal | SideEffects.ReadsGlobal)) != 0) {
      return this.block(null, [this.drop(condition), result], getExpressionType(result));
    }
    return result;
  }

  loop(label: string | null, body: ExpressionRef): ExpressionRef {
    let cStr = this.allocStringCached(label);
    return binaryen._BinaryenLoop(this.ref, cStr, body);
  }

  if(condition: ExpressionRef, ifTrue: ExpressionRef, ifFalse: ExpressionRef = 0): ExpressionRef {
    return binaryen._BinaryenIf(this.ref, condition, ifTrue, ifFalse);
  }

  nop(): ExpressionRef {
    return binaryen._BinaryenNop(this.ref);
  }

  return(expression: ExpressionRef = 0): ExpressionRef {
    return binaryen._BinaryenReturn(this.ref, expression);
  }

  select(ifTrue: ExpressionRef, ifFalse: ExpressionRef, condition: ExpressionRef): ExpressionRef {
    return binaryen._BinaryenSelect(this.ref, condition, ifTrue, ifFalse);
  }

  switch(
    names: string[],
    defaultName: string | null,
    condition: ExpressionRef,
    value: ExpressionRef = 0
  ): ExpressionRef {
    let numNames = names.length;
    let strs = new Array<StringRef>(numNames);
    for (let i = 0; i < numNames; ++i) {
      unchecked((strs[i] = this.allocStringCached(names[i])));
    }
    let cArr = allocPtrArray(strs);
    let cStr = this.allocStringCached(defaultName);
    let ret = binaryen._BinaryenSwitch(this.ref, cArr, numNames, cStr, condition, value);
    binaryen._free(cArr);
    return ret;
  }

  call(target: string, operands: ExpressionRef[] | null, returnType: TypeRef, isReturn: bool = false): ExpressionRef {
    let cStr = this.allocStringCached(target);
    let cArr = allocPtrArray(operands);
    let ret = isReturn
      ? binaryen._BinaryenReturnCall(this.ref, cStr, cArr, operands ? operands.length : 0, returnType)
      : binaryen._BinaryenCall(this.ref, cStr, cArr, operands ? operands.length : 0, returnType);
    binaryen._free(cArr);
    return ret;
  }

  return_call(target: string, operands: ExpressionRef[] | null, returnType: TypeRef): ExpressionRef {
    return this.call(target, operands, returnType, true);
  }

  call_indirect(
    tableName: string | null,
    index: ExpressionRef,
    operands: ExpressionRef[] | null,
    params: TypeRef,
    results: TypeRef,
    isReturn: bool = false
  ): ExpressionRef {
    let cStr = this.allocStringCached(tableName != null ? tableName : CommonNames.DefaultTable);
    let cArr = allocPtrArray(operands);
    let ret = isReturn
      ? binaryen._BinaryenReturnCallIndirect(
          this.ref,
          cStr,
          index,
          cArr,
          operands ? operands.length : 0,
          params,
          results
        )
      : binaryen._BinaryenCallIndirect(this.ref, cStr, index, cArr, operands ? operands.length : 0, params, results);
    binaryen._free(cArr);
    return ret;
  }

  return_call_indirect(
    tableName: string | null,
    index: ExpressionRef,
    operands: ExpressionRef[] | null,
    params: TypeRef,
    results: TypeRef
  ): ExpressionRef {
    return this.call_indirect(tableName, index, operands, params, results, true);
  }

  unreachable(): ExpressionRef {
    return binaryen._BinaryenUnreachable(this.ref);
  }

  // bulk memory

  memory_copy(
    dest: ExpressionRef,
    source: ExpressionRef,
    size: ExpressionRef,
    destName: string = CommonNames.DefaultMemory,
    sourceName: string = CommonNames.DefaultMemory
  ): ExpressionRef {
    let cStr1 = this.allocStringCached(destName);
    let cStr2 = this.allocStringCached(sourceName);
    return binaryen._BinaryenMemoryCopy(this.ref, dest, source, size, cStr1, cStr2);
  }

  memory_fill(
    dest: ExpressionRef,
    value: ExpressionRef,
    size: ExpressionRef,
    name: string = CommonNames.DefaultMemory
  ): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenMemoryFill(this.ref, dest, value, size, cStr);
  }

  // exception handling

  try(
    name: string | null,
    body: ExpressionRef,
    catchTags: string[],
    catchBodies: ExpressionRef[],
    delegateTarget: string | null = null
  ): ExpressionRef {
    let numCatchTags = catchTags.length;
    let strs = new Array<TagRef>(numCatchTags);
    for (let i = 0; i < numCatchTags; ++i) {
      strs[i] = this.allocStringCached(catchTags[i]);
    }
    let cArr1 = allocPtrArray(strs);
    let cArr2 = allocPtrArray(catchBodies);
    let cStr1 = this.allocStringCached(name);
    let cStr2 = this.allocStringCached(delegateTarget);
    let ret = binaryen._BinaryenTry(this.ref, cStr1, body, cArr1, numCatchTags, cArr2, catchBodies.length, cStr2);
    binaryen._free(cArr2);
    binaryen._free(cArr1);
    return ret;
  }

  throw(tagName: string, operands: ExpressionRef[]): ExpressionRef {
    let cStr = this.allocStringCached(tagName);
    let cArr = allocPtrArray(operands);
    let ret = binaryen._BinaryenThrow(this.ref, cStr, cArr, operands.length);
    binaryen._free(cArr);
    return ret;
  }

  rethrow(target: string): ExpressionRef {
    let cStr = this.allocStringCached(target);
    return binaryen._BinaryenRethrow(this.ref, cStr);
  }

  // multi value (pseudo instructions)

  pop(type: TypeRef): ExpressionRef {
    return binaryen._BinaryenPop(this.ref, type);
  }

  tuple_make(operands: ExpressionRef[]): ExpressionRef {
    let cArr = allocPtrArray(operands);
    let ret = binaryen._BinaryenTupleMake(this.ref, cArr, operands.length);
    binaryen._free(cArr);
    return ret;
  }

  tuple_extract(tuple: ExpressionRef, index: Index): ExpressionRef {
    return binaryen._BinaryenTupleExtract(this.ref, tuple, index);
  }

  // simd

  simd_extract(op: SIMDExtractOp, vec: ExpressionRef, idx: u8): ExpressionRef {
    return binaryen._BinaryenSIMDExtract(this.ref, op, vec, idx);
  }

  simd_replace(op: SIMDReplaceOp, vec: ExpressionRef, idx: u8, value: ExpressionRef): ExpressionRef {
    return binaryen._BinaryenSIMDReplace(this.ref, op, vec, idx, value);
  }

  simd_shuffle(vec1: ExpressionRef, vec2: ExpressionRef, mask: Uint8Array): ExpressionRef {
    assert(mask.length == 16);
    let cArr = allocU8Array(mask);
    let ret = binaryen._BinaryenSIMDShuffle(this.ref, vec1, vec2, cArr);
    binaryen._free(cArr);
    return ret;
  }

  simd_ternary(op: SIMDTernaryOp, a: ExpressionRef, b: ExpressionRef, c: ExpressionRef): ExpressionRef {
    return binaryen._BinaryenSIMDTernary(this.ref, op, a, b, c);
  }

  simd_shift(op: SIMDShiftOp, vec: ExpressionRef, shift: ExpressionRef): ExpressionRef {
    return binaryen._BinaryenSIMDShift(this.ref, op, vec, shift);
  }

  simd_load(
    op: SIMDLoadOp,
    ptr: ExpressionRef,
    offset: u32,
    align: u32,
    name: string = CommonNames.DefaultMemory
  ): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenSIMDLoad(this.ref, op, offset, align, ptr, cStr);
  }

  simd_loadstorelane(
    op: SIMDLoadStoreLaneOp,
    ptr: ExpressionRef,
    offset: u32,
    align: u32,
    index: u8,
    vec: ExpressionRef,
    name: string = CommonNames.DefaultMemory
  ): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenSIMDLoadStoreLane(this.ref, op, offset, align, index, ptr, vec, cStr);
  }

  // reference types / gc

  ref_is_null(expr: ExpressionRef): ExpressionRef {
    return binaryen._BinaryenRefIsNull(this.ref, expr);
  }

  ref_as(op: RefAsOp, expr: ExpressionRef): ExpressionRef {
    return binaryen._BinaryenRefAs(this.ref, op, expr);
  }

  ref_as_nonnull(expr: ExpressionRef): ExpressionRef {
    if (isNullableType(getExpressionType(expr))) {
      return binaryen._BinaryenRefAs(this.ref, RefAsOp.NonNull, expr);
    } else {
      return expr;
    }
  }

  ref_func(name: string, type: TypeRef): ExpressionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenRefFunc(this.ref, cStr, binaryen._BinaryenTypeGetHeapType(type));
  }

  i31_new(value: ExpressionRef): ExpressionRef {
    return binaryen._BinaryenRefI31(this.ref, value);
  }

  i31_get(expr: ExpressionRef, signed: bool): ExpressionRef {
    return binaryen._BinaryenI31Get(this.ref, expr, signed);
  }

  // globals

  addGlobal(name: string, type: TypeRef, mutable: bool, initializer: ExpressionRef): GlobalRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenAddGlobal(this.ref, cStr, type, mutable, initializer);
  }

  getGlobal(name: string): GlobalRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenGetGlobal(this.ref, cStr);
  }

  removeGlobal(name: string): bool {
    let cStr = this.allocStringCached(name);
    if (!binaryen._BinaryenGetGlobal(this.ref, cStr)) return false;
    binaryen._BinaryenRemoveGlobal(this.ref, cStr);
    return true;
  }

  // tags

  addTag(name: string, params: TypeRef, results: TypeRef): TagRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenAddTag(this.ref, cStr, params, results);
  }

  getTag(name: string): TagRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenGetTag(this.ref, cStr);
  }

  removeTag(name: string): void {
    let cStr = this.allocStringCached(name);
    binaryen._BinaryenRemoveTag(this.ref, cStr);
  }

  // functions

  addFunction(
    name: string,
    params: TypeRef,
    results: TypeRef,
    varTypes: TypeRef[] | null,
    body: ExpressionRef
  ): FunctionRef {
    let cStr = this.allocStringCached(name);
    let cArr = allocPtrArray(varTypes);
    let ret = binaryen._BinaryenAddFunction(
      this.ref,
      cStr,
      params,
      results,
      cArr,
      varTypes ? varTypes.length : 0,
      body
    );
    binaryen._free(cArr);
    return ret;
  }

  setLocalName(funcRef: FunctionRef, index: u32, name: string): void {
    binaryen._BinaryenFunctionSetLocalName(funcRef, index, this.allocStringCached(name));
  }

  getFunction(name: string): FunctionRef {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenGetFunction(this.ref, cStr);
  }

  removeFunction(name: string): void {
    let cStr = this.allocStringCached(name);
    binaryen._BinaryenRemoveFunction(this.ref, cStr);
  }

  hasFunction(name: string): bool {
    let cStr = this.allocStringCached(name);
    return binaryen._BinaryenGetFunction(this.ref, cStr) != 0;
  }

  private hasTemporaryFunction: bool = false;

  addTemporaryFunction(result: TypeRef, paramTypes: TypeRef[] | null, body: ExpressionRef): FunctionRef {
    this.hasTemporaryFunction = assert(!this.hasTemporaryFunction);
    let tempName = this.allocStringCached("");
    let cArr = allocPtrArray(paramTypes);
    let ret = binaryen._BinaryenAddFunction(this.ref, tempName, createType(paramTypes), result, 0, 0, body);
    binaryen._free(cArr);
    return ret;
  }

  removeTemporaryFunction(): void {
    this.hasTemporaryFunction = !assert(this.hasTemporaryFunction);
    let tempName = this.allocStringCached("");
    binaryen._BinaryenRemoveFunction(this.ref, tempName);
  }

  setStart(func: FunctionRef): void {
    binaryen._BinaryenSetStart(this.ref, func);
  }

  // exports

  addFunctionExport(internalName: string, externalName: string): ExportRef {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalName);
    return binaryen._BinaryenAddFunctionExport(this.ref, cStr1, cStr2);
  }

  addTableExport(internalName: string, externalName: string): ExportRef {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalName);
    return binaryen._BinaryenAddTableExport(this.ref, cStr1, cStr2);
  }

  addMemoryExport(internalName: string, externalName: string): ExportRef {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalName);
    return binaryen._BinaryenAddMemoryExport(this.ref, cStr1, cStr2);
  }

  addGlobalExport(internalName: string, externalName: string): ExportRef {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalName);
    return binaryen._BinaryenAddGlobalExport(this.ref, cStr1, cStr2);
  }

  addTagExport(internalName: string, externalName: string): ExportRef {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalName);
    return binaryen._BinaryenAddTagExport(this.ref, cStr1, cStr2);
  }

  removeExport(externalName: string): void {
    let cStr = this.allocStringCached(externalName);
    binaryen._BinaryenRemoveExport(this.ref, cStr);
  }

  hasExport(externalName: string): bool {
    let cStr = this.allocStringCached(externalName);
    return binaryen._BinaryenGetExport(this.ref, cStr) != 0;
  }

  // imports

  addFunctionImport(
    internalName: string,
    externalModuleName: string,
    externalBaseName: string,
    params: TypeRef,
    results: TypeRef
  ): void {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalModuleName);
    let cStr3 = this.allocStringCached(externalBaseName);
    binaryen._BinaryenAddFunctionImport(this.ref, cStr1, cStr2, cStr3, params, results);
  }

  addTableImport(internalName: string, externalModuleName: string, externalBaseName: string): void {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalModuleName);
    let cStr3 = this.allocStringCached(externalBaseName);
    binaryen._BinaryenAddTableImport(this.ref, cStr1, cStr2, cStr3);
  }

  addMemoryImport(internalName: string, externalModuleName: string, externalBaseName: string): void {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalModuleName);
    let cStr3 = this.allocStringCached(externalBaseName);
    binaryen._BinaryenAddMemoryImport(this.ref, cStr1, cStr2, cStr3, false);
  }

  addGlobalImport(
    internalName: string,
    externalModuleName: string,
    externalBaseName: string,
    globalType: TypeRef,
    mutable: bool = false
  ): void {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalModuleName);
    let cStr3 = this.allocStringCached(externalBaseName);
    binaryen._BinaryenAddGlobalImport(this.ref, cStr1, cStr2, cStr3, globalType, mutable);
  }

  addTagImport(
    internalName: string,
    externalModuleName: string,
    externalBaseName: string,
    params: TypeRef,
    results: TypeRef
  ): void {
    let cStr1 = this.allocStringCached(internalName);
    let cStr2 = this.allocStringCached(externalModuleName);
    let cStr3 = this.allocStringCached(externalBaseName);
    binaryen._BinaryenAddTagImport(this.ref, cStr1, cStr2, cStr3, params, results);
  }

  // memory

  /** Unlimited memory constant. */
  static readonly UNLIMITED_MEMORY: Index = <Index>-1;

  setMemory(
    initial: Index,
    maximum: Index,
    segments: MemorySegment[],
    target: Target,
    exportName: string | null = null,
    name: string = CommonNames.DefaultMemory
  ): void {
    let cExportName = this.allocStringCached(exportName);
    let cName = this.allocStringCached(name);
    let k = segments.length;
    let segs = new Array<binaryen.ArrayRef<u8>>(k);
    let isPassive = new Uint8Array(k);
    let offsets = new Array<ExpressionRef>(k);
    let sizes = new Array<Index>(k);
    for (let i = 0; i < k; ++i) {
      let segment = unchecked(segments[i]);
      let buffer = segment.buffer;
      let offset = segment.offset;
      unchecked((segs[i] = allocU8Array(buffer)));
      unchecked((isPassive[i] = 0)); // no passive segments currently
      unchecked((offsets[i] = this.i32(i64_low(offset))));
      unchecked((sizes[i] = buffer.length));
    }
    let cSegs = allocPtrArray(segs);
    let cIsPassive = allocU8Array(isPassive);
    let cOffsets = allocPtrArray(offsets);
    let cSizes = allocU32Array(sizes);
    binaryen._BinaryenSetMemory(
      this.ref,
      initial,
      maximum,
      cExportName,
      0,
      cSegs,
      cIsPassive,
      cOffsets,
      cSizes,
      k,
      false,
      false,
      cName
    );
    binaryen._free(cSizes);
    binaryen._free(cOffsets);
    binaryen._free(cIsPassive);
    binaryen._free(cSegs);
    for (let i = k - 1; i >= 0; --i) {
      binaryen._free(unchecked(segs[i]));
    }
  }

  // table

  /** Unlimited table constant. */
  static readonly UNLIMITED_TABLE: Index = <Index>-1;

  addFunctionTable(name: string, initial: Index, maximum: Index, funcs: string[], offset: ExpressionRef): void {
    let cStr = this.allocStringCached(name);
    let numNames = funcs.length;
    let names = new Array<StringRef>(numNames);
    for (let i = 0; i < numNames; ++i) {
      unchecked((names[i] = this.allocStringCached(funcs[i])));
    }
    let cArr = allocPtrArray(names);
    let tableRef = binaryen._BinaryenGetTable(this.ref, cStr);
    if (!tableRef) {
      tableRef = binaryen._BinaryenAddTable(this.ref, cStr, initial, maximum, TypeRef.Funcref);
    } else {
      binaryen._BinaryenTableSetInitial(tableRef, initial);
      binaryen._BinaryenTableSetMax(tableRef, maximum);
    }
    binaryen._BinaryenAddActiveElementSegment(this.ref, cStr, cStr, cArr, numNames, offset);
    binaryen._free(cArr);
  }

  /* setFunctionTable(
    initial: Index,
    maximum: Index,
    funcs: string[],
    offset: ExpressionRef
  ): void {
    let numNames = funcs.length;
    let names = new Array<CString>(numNames);
    for (let i = 0; i < numNames; ++i) {
      names[i] = this.allocStringCached(funcs[i]);
    }
    let cArr = allocPtrArray(names);
    binaryen._BinaryenSetFunctionTable(
      this.ref, initial, maximum, cArr, numNames, offset
    );
    binaryen._free(cArr);
  } */

  // sections

  addCustomSection(name: string, contents: Uint8Array): void {
    let cStr = this.allocStringCached(name);
    let cArr = allocU8Array(contents);
    binaryen._BinaryenAddCustomSection(this.ref, cStr, cArr, contents.length);
    binaryen._free(cArr);
  }

  // meta (global)

  setLowMemoryUnused(on: bool): void {
    binaryen._BinaryenSetLowMemoryUnused(on);
  }

  getZeroFilledMemory(): bool {
    return binaryen._BinaryenGetZeroFilledMemory();
  }

  setZeroFilledMemory(on: bool): void {
    binaryen._BinaryenSetZeroFilledMemory(on);
  }

  getFastMath(): bool {
    return binaryen._BinaryenGetFastMath();
  }

  setFastMath(on: bool): void {
    binaryen._BinaryenSetFastMath(on);
  }

  getGenerateStackIR(): bool {
    return binaryen._BinaryenGetGenerateStackIR();
  }

  setGenerateStackIR(on: bool): void {
    binaryen._BinaryenSetGenerateStackIR(on);
  }

  getOptimizeStackIR(): bool {
    return binaryen._BinaryenGetOptimizeStackIR();
  }

  setOptimizeStackIR(on: bool): void {
    binaryen._BinaryenSetOptimizeStackIR(on);
  }

  getPassArgument(key: string): string | null {
    let cStr = this.allocStringCached(key);
    let ptr = binaryen._BinaryenGetPassArgument(cStr);
    return ptr ? readString(ptr) : null;
  }

  setPassArgument(key: string, value: string | null): void {
    let cStr1 = this.allocStringCached(key);
    let cStr2 = this.allocStringCached(value);
    binaryen._BinaryenSetPassArgument(cStr1, cStr2);
  }

  clearPassArguments(): void {
    binaryen._BinaryenClearPassArguments();
  }

  getAlwaysInlineMaxSize(): Index {
    return binaryen._BinaryenGetAlwaysInlineMaxSize();
  }

  setAlwaysInlineMaxSize(size: Index): void {
    binaryen._BinaryenSetAlwaysInlineMaxSize(size);
  }

  getFlexibleInlineMaxSize(): Index {
    return binaryen._BinaryenGetFlexibleInlineMaxSize();
  }

  setFlexibleInlineMaxSize(size: Index): void {
    binaryen._BinaryenSetFlexibleInlineMaxSize(size);
  }

  getOneCallerInlineMaxSize(): Index {
    return binaryen._BinaryenGetOneCallerInlineMaxSize();
  }

  setOneCallerInlineMaxSize(size: Index): void {
    binaryen._BinaryenSetOneCallerInlineMaxSize(size);
  }

  getAllowInliningFunctionsWithLoops(): bool {
    return binaryen._BinaryenGetAllowInliningFunctionsWithLoops();
  }

  setAllowInliningFunctionsWithLoops(enabled: bool): void {
    binaryen._BinaryenSetAllowInliningFunctionsWithLoops(enabled);
  }

  // meta (module)

  private cachedStringsToPointers: Map<string, StringRef> = new Map();
  private cachedPointersToStrings: Map<binaryen.Ref, string | null> = new Map();

  allocStringCached(str: string | null): StringRef {
    if (str == null) return 0;
    let cached = this.cachedStringsToPointers;
    if (cached.has(str)) return cached.get(str);
    let ptr = allocString(str);
    cached.set(str, ptr);
    return ptr;
  }

  readStringCached(ptr: StringRef): string | null {
    // Binaryen internalizes names, so using this method where it's safe can
    // avoid quite a bit of unnecessary garbage.
    if (ptr == 0) return null;
    let cached = this.cachedPointersToStrings;
    if (cached.has(ptr)) return changetype<string>(cached.get(ptr));
    let str = readString(ptr);
    cached.set(ptr, str);
    return str;
  }

  /** Makes a copy of a trivial expression (doesn't contain subexpressions). Returns `0` if non-trivial. */
  tryCopyTrivialExpression(expr: ExpressionRef): ExpressionRef {
    switch (binaryen._BinaryenExpressionGetId(expr)) {
      case ExpressionId.LocalGet:
      case ExpressionId.GlobalGet:
      case ExpressionId.Const:
      case ExpressionId.MemorySize:
      case ExpressionId.Nop:
      case ExpressionId.Unreachable:
      case ExpressionId.DataDrop:
      case ExpressionId.RefNull:
        return this.copyExpression(expr);
    }
    return 0;
  }

  /** Makes a copy of any expression including all subexpressions. */
  copyExpression(expr: ExpressionRef): ExpressionRef {
    // TODO: Copy debug location as well (needs Binaryen support)
    return binaryen._BinaryenExpressionCopy(expr, this.ref);
  }

  runExpression(
    expr: ExpressionRef,
    flags: ExpressionRunnerFlags,
    maxDepth: i32 = 50,
    maxLoopIterations: i32 = 1
  ): ExpressionRef {
    let runner = binaryen._ExpressionRunnerCreate(this.ref, flags, maxDepth, maxLoopIterations);
    let precomp = binaryen._ExpressionRunnerRunAndDispose(runner, expr);
    if (precomp) {
      if (!this.isConstExpression(precomp)) return 0;
      assert(getExpressionType(precomp) == getExpressionType(expr));
    }
    return precomp;
  }

  isConstExpression(expr: ExpressionRef): bool {
    switch (getExpressionId(expr)) {
      case ExpressionId.Const:
      case ExpressionId.RefNull:
      case ExpressionId.RefFunc:
      case ExpressionId.RefI31:
        return true;
    }
    return false;
  }

  // source map generation

  addDebugInfoFile(name: string): Index {
    let cStr = allocString(name);
    let ret = binaryen._BinaryenModuleAddDebugInfoFileName(this.ref, cStr);
    binaryen._free(cStr);
    return ret;
  }

  setDebugLocation(
    func: FunctionRef,
    expr: ExpressionRef,
    fileIndex: Index,
    lineNumber: Index,
    columnNumber: Index
  ): void {
    binaryen._BinaryenFunctionSetDebugLocation(func, expr, fileIndex, lineNumber, columnNumber);
  }
}

// types

export function createType(types: TypeRef[] | null): TypeRef {
  if (!types) return TypeRef.None;
  switch (types.length) {
    case 0:
      return TypeRef.None;
    case 1:
      return types[0];
  }
  let cArr = allocPtrArray(types);
  let ret = binaryen._BinaryenTypeCreate(cArr, types.length);
  binaryen._free(cArr);
  return ret;
}

export function expandType(type: TypeRef): TypeRef[] {
  let arity = binaryen._BinaryenTypeArity(type);
  let cArr = binaryen._malloc((<usize>arity) << 2);
  binaryen._BinaryenTypeExpand(type, cArr);
  let types = new Array<TypeRef>(arity);
  for (let i: u32 = 0; i < arity; ++i) {
    unchecked((types[i] = binaryen.__i32_load(cArr + ((<usize>i) << 2))));
  }
  binaryen._free(cArr);
  return types;
}

export function isNullableType(type: TypeRef): bool {
  return binaryen._BinaryenTypeIsNullable(type);
}

// expressions

export function getExpressionId(expr: ExpressionRef): ExpressionId {
  if (expr == 0) return ExpressionId.Invalid;
  return binaryen._BinaryenExpressionGetId(expr);
}

export function getExpressionType(expr: ExpressionRef): TypeRef {
  return binaryen._BinaryenExpressionGetType(expr);
}

export function getConstValueI32(expr: ExpressionRef): i32 {
  return binaryen._BinaryenConstGetValueI32(expr);
}

export function getConstValueI64(expr: ExpressionRef): i64 {
  return binaryen._BinaryenConstGetValueI64(expr);
}

export function getConstValueInteger(expr: ExpressionRef): i64 {
  return i64_new(getConstValueI32(expr), 0);
}

export function getConstValueF32(expr: ExpressionRef): f32 {
  return binaryen._BinaryenConstGetValueF32(expr);
}

export function getConstValueF64(expr: ExpressionRef): f64 {
  return binaryen._BinaryenConstGetValueF64(expr);
}

export function getConstValueV128(expr: ExpressionRef): Uint8Array {
  let cArr = binaryen._malloc(16);
  binaryen._BinaryenConstGetValueV128(expr, cArr);
  let out = new Uint8Array(16);
  for (let i = 0; i < 16; ++i) {
    out[i] = binaryen.__i32_load8_u(cArr + i);
  }
  binaryen._free(cArr);
  return out;
}

export function isConstZero(expr: ExpressionRef): bool {
  if (getExpressionId(expr) != ExpressionId.Const) return false;
  let type = getExpressionType(expr);
  if (type == TypeRef.I32) return getConstValueI32(expr) == 0;
  if (type == TypeRef.I64) return getConstValueI64(expr) == 0;
  if (type == TypeRef.F32) return getConstValueF32(expr) == 0;
  if (type == TypeRef.F64) return getConstValueF64(expr) == 0;
  return false;
}

export function isConstNonZero(expr: ExpressionRef): bool {
  if (getExpressionId(expr) != ExpressionId.Const) return false;
  let type = getExpressionType(expr);
  if (type == TypeRef.I32) return getConstValueI32(expr) != 0;
  if (type == TypeRef.I64) return getConstValueI64(expr) != 0;
  if (type == TypeRef.F32) return getConstValueF32(expr) != 0;
  if (type == TypeRef.F64) return getConstValueF64(expr) != 0;
  return false;
}

export function isConstNegZero(expr: ExpressionRef): bool {
  if (getExpressionId(expr) != ExpressionId.Const) return false;
  let type = getExpressionType(expr);
  if (type == TypeRef.F32) {
    let d = getConstValueF32(expr);
    return d == 0 && f32_as_i32(d) < 0;
  }
  if (type == TypeRef.F64) {
    let d = getConstValueF64(expr);
    return d == 0 && i64_signbit(f64_as_i64(d));
  }
  return false;
}

export function isConstNaN(expr: ExpressionRef): bool {
  if (getExpressionId(expr) != ExpressionId.Const) return false;
  let type = getExpressionType(expr);
  if (type == TypeRef.F32) return isNaN(getConstValueF32(expr));
  if (type == TypeRef.F64) return isNaN(getConstValueF64(expr));
  return false;
}

export function isConstExpressionNaN(module: Module, expr: ExpressionRef): bool {
  let id = getExpressionId(expr);
  let type = getExpressionType(expr);
  if (type == TypeRef.F32 || type == TypeRef.F64) {
    if (id == ExpressionId.Const) {
      return isNaN(type == TypeRef.F32 ? getConstValueF32(expr) : getConstValueF64(expr));
    } else if (id == ExpressionId.GlobalGet) {
      let precomp = module.runExpression(expr, ExpressionRunnerFlags.Default, 8);
      if (precomp) {
        return isNaN(type == TypeRef.F32 ? getConstValueF32(precomp) : getConstValueF64(precomp));
      }
    }
  }
  return false;
}

export function getLocalGetIndex(expr: ExpressionRef): Index {
  return binaryen._BinaryenLocalGetGetIndex(expr);
}

export function getLocalSetIndex(expr: ExpressionRef): Index {
  return binaryen._BinaryenLocalSetGetIndex(expr);
}

export function getLocalSetValue(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenLocalSetGetValue(expr);
}

export function isLocalTee(expr: ExpressionRef): bool {
  return binaryen._BinaryenLocalSetIsTee(expr);
}

export function getGlobalGetName(expr: ExpressionRef): string | null {
  return readString(binaryen._BinaryenGlobalGetGetName(expr));
}

export function getBinaryOp(expr: ExpressionRef): BinaryOp {
  return binaryen._BinaryenBinaryGetOp(expr);
}

export function getBinaryLeft(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenBinaryGetLeft(expr);
}

export function getBinaryRight(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenBinaryGetRight(expr);
}

export function getUnaryOp(expr: ExpressionRef): UnaryOp {
  return binaryen._BinaryenUnaryGetOp(expr);
}

export function getUnaryValue(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenUnaryGetValue(expr);
}

export function getLoadBytes(expr: ExpressionRef): u32 {
  return binaryen._BinaryenLoadGetBytes(expr);
}

export function getLoadOffset(expr: ExpressionRef): u32 {
  return binaryen._BinaryenLoadGetOffset(expr);
}

export function getLoadPtr(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenLoadGetPtr(expr);
}

export function isLoadSigned(expr: ExpressionRef): bool {
  return binaryen._BinaryenLoadIsSigned(expr);
}

export function getStoreBytes(expr: ExpressionRef): u32 {
  return binaryen._BinaryenStoreGetBytes(expr);
}

export function getStoreOffset(expr: ExpressionRef): u32 {
  return binaryen._BinaryenStoreGetOffset(expr);
}

export function getStorePtr(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenStoreGetPtr(expr);
}

export function getStoreValue(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenStoreGetValue(expr);
}

export function getBlockName(expr: ExpressionRef): string | null {
  return readString(binaryen._BinaryenBlockGetName(expr));
}

export function getBlockChildCount(expr: ExpressionRef): Index {
  return binaryen._BinaryenBlockGetNumChildren(expr);
}

export function getBlockChildAt(expr: ExpressionRef, index: Index): ExpressionRef {
  return binaryen._BinaryenBlockGetChildAt(expr, index);
}

export function getIfCondition(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenIfGetCondition(expr);
}

export function getIfTrue(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenIfGetIfTrue(expr);
}

export function getIfFalse(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenIfGetIfFalse(expr);
}

export function getLoopName(expr: ExpressionRef): string | null {
  return readString(binaryen._BinaryenLoopGetName(expr));
}

export function getLoopBody(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenLoopGetBody(expr);
}

export function getBreakName(expr: ExpressionRef): string | null {
  return readString(binaryen._BinaryenBreakGetName(expr));
}

export function getBreakCondition(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenBreakGetCondition(expr);
}

export function getSelectThen(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenSelectGetIfTrue(expr);
}

export function getSelectElse(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenSelectGetIfFalse(expr);
}

export function getSelectCondition(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenSelectGetCondition(expr);
}

export function getDropValue(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenDropGetValue(expr);
}

export function getReturnValue(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenReturnGetValue(expr);
}

export function getCallTarget(expr: ExpressionRef): string | null {
  return readString(binaryen._BinaryenCallGetTarget(expr));
}

export function getCallOperandCount(expr: ExpressionRef): i32 {
  return binaryen._BinaryenCallGetNumOperands(expr);
}

export function getCallOperandAt(expr: ExpressionRef, index: Index): ExpressionRef {
  return binaryen._BinaryenCallGetOperandAt(expr, index);
}

export function getMemoryGrowDelta(expr: ExpressionRef): ExpressionRef {
  return binaryen._BinaryenMemoryGrowGetDelta(expr);
}

// functions

export function getFunctionBody(func: FunctionRef): ExpressionRef {
  return binaryen._BinaryenFunctionGetBody(func);
}

export function getFunctionName(func: FunctionRef): string | null {
  return readString(binaryen._BinaryenFunctionGetName(func));
}

export function getFunctionParams(func: FunctionRef): TypeRef {
  return binaryen._BinaryenFunctionGetParams(func);
}

export function getFunctionResults(func: FunctionRef): TypeRef {
  return binaryen._BinaryenFunctionGetResults(func);
}

export function getFunctionVars(func: FunctionRef): TypeRef[] {
  let count = binaryen._BinaryenFunctionGetNumVars(func);
  let types = new Array<TypeRef>(count);
  for (let i: Index = 0; i < count; ++i) {
    unchecked((types[i] = binaryen._BinaryenFunctionGetVar(func, i)));
  }
  return types;
}

// globals

export function getGlobalName(global: GlobalRef): string | null {
  return readString(binaryen._BinaryenGlobalGetName(global));
}

export function getGlobalType(global: GlobalRef): TypeRef {
  return binaryen._BinaryenGlobalGetType(global);
}

export function isGlobalMutable(global: GlobalRef): bool {
  return binaryen._BinaryenGlobalIsMutable(global);
}

export function getGlobalInit(global: GlobalRef): ExpressionRef {
  return binaryen._BinaryenGlobalGetInitExpr(global);
}

// tags

export function getTagName(tag: TagRef): string | null {
  return readString(binaryen._BinaryenTagGetName(tag));
}

export function getTagParams(tag: TagRef): TypeRef {
  return binaryen._BinaryenTagGetParams(tag);
}

export function getTagResults(tag: TagRef): TypeRef {
  return binaryen._BinaryenTagGetResults(tag);
}

export class Relooper {
  constructor(
    /** Module this relooper belongs to. */
    public module: Module,
    /** Binaryen relooper reference. */
    public ref: RelooperRef
  ) {}

  static create(module: Module): Relooper {
    return new Relooper(module, binaryen._RelooperCreate(module.ref));
  }

  addBlock(code: ExpressionRef): RelooperBlockRef {
    return binaryen._RelooperAddBlock(this.ref, code);
  }

  addBranch(from: RelooperBlockRef, to: RelooperBlockRef, condition: ExpressionRef = 0, code: ExpressionRef = 0): void {
    binaryen._RelooperAddBranch(from, to, condition, code);
  }

  addBlockWithSwitch(code: ExpressionRef, condition: ExpressionRef): RelooperBlockRef {
    return binaryen._RelooperAddBlockWithSwitch(this.ref, code, condition);
  }

  addBranchForSwitch(from: RelooperBlockRef, to: RelooperBlockRef, indexes: i32[], code: ExpressionRef = 0): void {
    let cArr = allocI32Array(indexes);
    binaryen._RelooperAddBranchForSwitch(from, to, cArr, indexes.length, code);
    binaryen._free(cArr);
  }

  renderAndDispose(entry: RelooperBlockRef, labelHelper: Index): ExpressionRef {
    return binaryen._RelooperRenderAndDispose(this.ref, entry, labelHelper);
  }
}

/** Builds a switch using a sequence of `br_if`s. */
export class SwitchBuilder {
  // This is useful because Binaryen understands sequences of `br_if`s and
  // knows how to make a `br_table` from such a sequence if switched over
  // values are considered dense enough, respectively a size-efficient sequence
  // of `if`s if not, depending on optimization levels.

  private module: Module;
  private condition: ExpressionRef;
  private values: i32[] = new Array();
  private indexes: i32[] = new Array();
  private cases: ExpressionRef[][] = new Array();
  private defaultIndex: i32 = -1;

  /** Creates a new builder using the specified i32 condition. */
  constructor(module: Module, condition: ExpressionRef) {
    this.module = module;
    this.condition = condition;
  }

  /** Links a case to the specified branch, replace old case if it is linked. */
  addOrReplaceCase(value: i32, code: ExpressionRef[]): void {
    const valueIndex = this.values.indexOf(value);
    const codeIndex = this.addCode(code);
    if (valueIndex >= 0) {
      this.indexes[valueIndex] = codeIndex;
    } else {
      this.values.push(value);
      this.indexes.push(codeIndex);
    }
  }

  /** Links a case to the specified branch. */
  addCase(value: i32, code: ExpressionRef[]): void {
    this.values.push(value);
    this.indexes.push(this.addCode(code));
  }

  private addCode(code: ExpressionRef[]): i32 {
    let cases = this.cases;
    let index = cases.indexOf(code);
    if (index < 0) {
      index = cases.length;
      cases.push(code);
    }
    return index;
  }

  /** Links the default branch. */
  addDefault(code: ExpressionRef[]): void {
    assert(this.defaultIndex == -1);
    let cases = this.cases;
    this.defaultIndex = cases.length;
    cases.push(code);
  }

  /** Renders the switch to a block. */
  render(localIndex: i32, labelPostfix: string = ""): ExpressionRef {
    let module = this.module;
    let cases = this.cases;
    let numCases = cases.length;
    if (!numCases) {
      return module.drop(this.condition);
    }
    let values = this.values;
    let numValues = values.length;
    let indexes = this.indexes;
    let entry = new Array<ExpressionRef>(1 + numValues + 1);
    let labels = new Array<string>(numCases);
    for (let i = 0; i < numCases; ++i) {
      unchecked((labels[i] = `case${i}${labelPostfix}`));
    }
    entry[0] = module.local_set(localIndex, this.condition, false); // u32
    for (let i = 0; i < numValues; ++i) {
      let index = unchecked(indexes[i]);
      unchecked(
        (entry[1 + i] = module.br(
          labels[index],
          module.binary(BinaryOp.EqI32, module.local_get(localIndex, TypeRef.I32), module.i32(values[i]))
        ))
      );
    }
    let defaultIndex = this.defaultIndex;
    let defaultLabel = `default${labelPostfix}`;
    entry[1 + numValues] = module.br(~defaultIndex ? labels[defaultIndex] : defaultLabel);
    let current = module.block(labels[0], entry);
    for (let i = 1; i < numCases; ++i) {
      let block = cases[i - 1];
      block.unshift(current);
      current = module.block(unchecked(labels[i]), block);
    }
    let lastCase = cases[numCases - 1];
    lastCase.unshift(current);
    return module.block(~defaultIndex ? null : defaultLabel, lastCase);
  }
}

export const enum SideEffects {
  None = 0 /* _BinaryenSideEffectNone */,
  Branches = 1 /* _BinaryenSideEffectBranches */,
  Calls = 2 /* _BinaryenSideEffectCalls */,
  ReadsLocal = 4 /* _BinaryenSideEffectReadsLocal */,
  WritesLocal = 8 /* _BinaryenSideEffectWritesLocal */,
  ReadsGlobal = 16 /* _BinaryenSideEffectReadsGlobal */,
  WritesGlobal = 32 /* _BinaryenSideEffectWritesGlobal */,
  ReadsMemory = 64 /* _BinaryenSideEffectReadsMemory */,
  WritesMemory = 128 /* _BinaryenSideEffectWritesMemory */,
  ReadsTable = 256 /* _BinaryenSideEffectReadsTable */,
  WritesTable = 512 /* _BinaryenSideEffectWritesTable */,
  ImplicitTrap = 1024 /* _BinaryenSideEffectImplicitTrap */,
  Throws = 4096 /* _BinaryenSideEffectThrows */,
  DanglingPop = 8192 /* _BinaryenSideEffectDanglingPop */,
  TrapsNeverHappen = 16384 /* _BinaryenSideEffectTrapsNeverHappen */,
  Any = 30719 /* _BinaryenSideEffectAny */,
}

export function getSideEffects(expr: ExpressionRef, module: ModuleRef): SideEffects {
  return binaryen._BinaryenExpressionGetSideEffects(expr, module);
}

export function mustPreserveSideEffects(expr: ExpressionRef, module: ModuleRef): bool {
  return (getSideEffects(expr, module) & ~(SideEffects.ReadsLocal | SideEffects.ReadsGlobal)) != SideEffects.None;
}

// helpers
// can't do stack allocation here: STACKTOP is a global in WASM but a hidden variable in asm.js

function allocU8Array(u8s: Uint8Array | null): binaryen.ArrayRef<u8> {
  if (!u8s) return 0;
  let len = u8s.length;
  let ptr = binaryen._malloc(len);
  for (let i = 0; i < len; ++i) {
    binaryen.__i32_store8(ptr + i, unchecked(u8s[i]));
  }
  return ptr;
}

function allocI32Array(i32s: i32[] | null): binaryen.ArrayRef<i32> {
  if (!i32s) return 0;
  let len = i32s.length;
  let ptr = binaryen._malloc(len << 2);
  let idx = ptr;
  for (let i = 0; i < len; ++i) {
    let val = unchecked(i32s[i]);
    binaryen.__i32_store(idx, val);
    idx += 4;
  }
  return ptr;
}

function allocU32Array(u32s: u32[] | null): binaryen.ArrayRef<u32> {
  if (!u32s) return 0;
  let len = u32s.length;
  let ptr = binaryen._malloc(len << 2);
  let idx = ptr;
  for (let i = 0; i < len; ++i) {
    let val = unchecked(u32s[i]);
    binaryen.__i32_store(idx, val);
    idx += 4;
  }
  return ptr;
}

export function allocPtrArray(ptrs: binaryen.Ref[] | null): binaryen.ArrayRef<binaryen.Ref> {
  if (!ptrs) return 0;
  let len = ptrs.length;
  let ptr = binaryen._malloc(len << 3);
  let idx = ptr;
  for (let i = 0, k = len; i < k; ++i) {
    let val = unchecked(ptrs[i]);
    binaryen.__i64_store(idx, <i64>val);
    idx += 8;
  }
  return ptr;
}

function stringLengthUTF8(str: string): usize {
  let len = 0;
  for (let i = 0, k = str.length; i < k; ++i) {
    let c1 = str.charCodeAt(i) >>> 0;
    if (c1 <= 0x7f) {
      len += 1;
    } else if (c1 <= 0x7ff) {
      len += 2;
    } else if (isHighSurrogate(c1) && i + 1 < k && isLowSurrogate(str.charCodeAt(i + 1))) {
      i++;
      len += 4;
    } else {
      len += 3;
    }
  }
  return len;
}

function allocString(str: string | null): StringRef {
  if (str == null) return 0;
  let len = stringLengthUTF8(str);
  let ptr = binaryen._malloc(len + 1) >>> 0;
  let idx = ptr;
  if (len == str.length) {
    // fast path when all chars are ascii
    for (let i = 0, k = str.length; i < k; ++i) {
      let u = str.charCodeAt(i) >>> 0;
      binaryen.__i32_store8(idx++, u as u8);
    }
  } else {
    for (let i = 0, k = str.length; i < k; ++i) {
      let c1 = str.charCodeAt(i) >>> 0,
        c2: i32;
      if (c1 <= 0x7f) {
        binaryen.__i32_store8(idx++, c1 as u8);
      } else if (c1 <= 0x7ff) {
        binaryen.__i32_store8(idx++, (0xc0 | (c1 >>> 6)) as u8);
        binaryen.__i32_store8(idx++, (0x80 | (c1 & 63)) as u8);
      } else if (isHighSurrogate(c1) && i + 1 < k && isLowSurrogate((c2 = str.charCodeAt(i + 1)))) {
        c1 = combineSurrogates(c1, c2);
        ++i;
        binaryen.__i32_store8(idx++, (0xf0 | (c1 >>> 18)) as u8);
        binaryen.__i32_store8(idx++, (0x80 | ((c1 >>> 12) & 63)) as u8);
        binaryen.__i32_store8(idx++, (0x80 | ((c1 >>> 6) & 63)) as u8);
        binaryen.__i32_store8(idx++, (0x80 | (c1 & 63)) as u8);
      } else {
        binaryen.__i32_store8(idx++, (0xe0 | (c1 >>> 12)) as u8);
        binaryen.__i32_store8(idx++, (0x80 | ((c1 >>> 6) & 63)) as u8);
        binaryen.__i32_store8(idx++, (0x80 | (c1 & 63)) as u8);
      }
    }
  }
  binaryen.__i32_store8(idx, 0); // \0
  return ptr;
}

function readBuffer(ptr: binaryen.Ref, len: i32): Uint8Array {
  let ret = new Uint8Array(len);
  for (let i = 0; i < len; ++i) {
    unchecked((ret[i] = binaryen.__i32_load8_u(ptr + i)));
  }
  return ret;
}

export function readString(ptr: binaryen.Ref): string | null {
  if (!ptr) return null;
  let arr = new Array<i32>();
  // the following is based on Emscripten's UTF8ArrayToString
  let cp: u32;
  let u1: u32, u2: u32, u3: u32;
  while ((cp = binaryen.__i32_load8_u(ptr++))) {
    if (!(cp & 0x80)) {
      arr.push(cp);
      continue;
    }
    u1 = binaryen.__i32_load8_u(ptr++) & 63;
    if ((cp & 0xe0) == 0xc0) {
      arr.push(((cp & 31) << 6) | u1);
      continue;
    }
    u2 = binaryen.__i32_load8_u(ptr++) & 63;
    if ((cp & 0xf0) == 0xe0) {
      cp = ((cp & 15) << 12) | (u1 << 6) | u2;
    } else {
      u3 = binaryen.__i32_load8_u(ptr++) & 63;
      if ((cp & 0xf8) == 0xf0) {
        cp = ((cp & 7) << 18) | (u1 << 12) | (u2 << 6) | u3;
      } else {
        assert(false, "Invalid UTF8 sequence during readString");
      }
    }
    if (cp < 0x10000) {
      arr.push(cp);
    } else {
      let ch = cp - 0x10000;
      arr.push(SURROGATE_HIGH | (ch >>> 10));
      arr.push(SURROGATE_LOW | (ch & 0x3ff));
    }
  }
  // TODO: implement and use String.fromCodePoints
  return String.fromCharCodes(arr);
}

/** Result structure of {@link Module#toBinary}. */
export class BinaryModule {
  constructor(
    /** WebAssembly binary. */
    public output: Uint8Array,
    /** Source map, if generated. */
    public sourceMap: string | null
  ) {}
}

// TypeBuilder

/** Ensures that the given potentially complex type has a corresponding GC type. */
export function ensureType(type: Type): TypeRef {
  // Obtain basic type if applicable
  if (type == Type.void) return TypeRef.None;
  let typeRef = tryEnsureBasicType(type);
  if (typeRef) return typeRef;

  // From here on we are dealing with heap types independent of nullability.
  // Nullability is applied again when returning the final type.
  let originalType = type;
  type = type.nonNullableType;

  // Obtain cached type if already built. Guaranteed to be not a temp type.
  if ((typeRef = type.ref)) {
    return binaryen._BinaryenTypeFromHeapType(
      binaryen._BinaryenTypeGetHeapType(typeRef),
      originalType.is(TypeFlags.Nullable) // apply nullability
    );
  }

  // Otherwise use a type builder
  if (ASC_TARGET) {
    // @ts-ignore: Wasm only
    assert(sizeof<usize>() == 4); // ABI code below assumes 32-bit pointers
  }
  let builder = binaryen._TypeBuilderCreate(0);
  let seen = new Map<Type, HeapTypeRef>();
  prepareType(builder, seen, type); // drop temp return
  let size = binaryen._TypeBuilderGetSize(builder);
  let out = binaryen._malloc(max(4 * size, 8)); // either each heap type or index + reason
  if (!binaryen._TypeBuilderBuildAndDispose(builder, out, out, out + 4)) {
    let errorIndex = binaryen.__i32_load(out);
    let errorReason = binaryen.__i32_load(out + 4);
    binaryen._free(out);
    throw new Error(`type builder error at index ${errorIndex}: ${TypeBuilderErrorReason.toString(errorReason)}`);
  }

  // Assign all the built types to their respective non-nullable type
  for (let _keys = Map_keys(seen), i = 0, k = _keys.length; i < k; ++i) {
    let seenType = _keys[i];
    assert(!seenType.is(TypeFlags.Nullable)); // non-nullable only
    let heapType = <HeapTypeRef>binaryen.__i32_load(out + 4 * i);
    let fullType = binaryen._BinaryenTypeFromHeapType(heapType, false);
    assert(!seenType.ref);
    seenType.ref = fullType;
    let classInstance = seenType.getClass();
    if (classInstance) {
      let module = classInstance.program.module;
      binaryen._BinaryenModuleSetTypeName(module.ref, heapType, module.allocStringCached(classInstance.internalName));
      let members = classInstance.members;
      if (members) {
        let numFieldsInType = binaryen._BinaryenStructTypeGetNumFields(heapType);
        let numFieldsInClass = 0;
        for (let _values = Map_values(members), i = 0, k = _values.length; i < k; ++i) {
          let member = _values[i];
          if (member.kind != ElementKind.PropertyPrototype) continue;
          // only interested in fields (resolved during class finalization)
          let property = (<PropertyPrototype>member).instance;
          if (!property || !property.isField) continue;
          binaryen._BinaryenModuleSetFieldName(
            module.ref,
            heapType,
            numFieldsInClass++,
            module.allocStringCached(property.name)
          );
        }
        assert(numFieldsInType == numFieldsInClass);
      }
    }
  }
  binaryen._free(out);

  // Initial type should now exist in its non-nullable variant
  typeRef = assert(type.ref);
  return binaryen._BinaryenTypeFromHeapType(
    binaryen._BinaryenTypeGetHeapType(typeRef),
    originalType.is(TypeFlags.Nullable) // apply nullability
  );
}

/** Obtains the basic type of the given type, if any. */
function tryEnsureBasicType(type: Type): TypeRef {
  switch (type.kind) {
    case TypeKind.Bool:
    case TypeKind.I8:
    case TypeKind.U8:
    case TypeKind.I16:
    case TypeKind.U16:
    case TypeKind.I32:
    case TypeKind.U32:
      return TypeRef.I32;
    case TypeKind.I64:
    case TypeKind.U64:
      return TypeRef.I64;
    case TypeKind.Isize:
    case TypeKind.Usize: {
      if (type.isInternalReference) break; // non-basic
      return type.size == 64 ? TypeRef.I64 : TypeRef.I32;
    }
    case TypeKind.F32:
      return TypeRef.F32;
    case TypeKind.F64:
      return TypeRef.F64;
    case TypeKind.V128:
      return TypeRef.V128;
    case TypeKind.Func: {
      return binaryen._BinaryenTypeFromHeapType(HeapTypeRef.Func, type.is(TypeFlags.Nullable));
    }
    case TypeKind.Extern: {
      return binaryen._BinaryenTypeFromHeapType(HeapTypeRef.Extern, type.is(TypeFlags.Nullable));
    }
    case TypeKind.Any: {
      return binaryen._BinaryenTypeFromHeapType(HeapTypeRef.Any, type.is(TypeFlags.Nullable));
    }
    case TypeKind.Eq: {
      return binaryen._BinaryenTypeFromHeapType(HeapTypeRef.Eq, type.is(TypeFlags.Nullable));
    }
    case TypeKind.Struct: {
      return binaryen._BinaryenTypeFromHeapType(HeapTypeRef.Struct, type.is(TypeFlags.Nullable));
    }
    case TypeKind.Array: {
      return binaryen._BinaryenTypeFromHeapType(HeapTypeRef.Array, type.is(TypeFlags.Nullable));
    }
    case TypeKind.I31: {
      return binaryen._BinaryenTypeFromHeapType(HeapTypeRef.I31, type.is(TypeFlags.Nullable));
    }
    case TypeKind.Void:
      assert(false); // invalid here
  }
  return 0; // non-basic
}

/** Determines the packed GC type of the given type, if applicable. */
function determinePackedType(type: Type): PackedType {
  switch (type.kind) {
    case TypeKind.Bool:
    case TypeKind.I8:
    case TypeKind.U8:
      return PackedType.I8;
    case TypeKind.I16:
    case TypeKind.U16:
      return PackedType.I16;
  }
  return PackedType.NotPacked;
}

/** Recursively prepares the given GC type, potentially returning a temporary type. */
function prepareType(builder: binaryen.TypeBuilderRef, seen: Map<Type, HeapTypeRef>, type: Type): TypeRef {
  // Obtain basic type if applicable
  if (type == Type.void) return TypeRef.None;
  let typeRef = tryEnsureBasicType(type);
  if (typeRef) return typeRef;

  assert(!type.is(TypeFlags.Nullable)); // operating on non-nullable types only

  // Reuse existing type
  if ((typeRef = type.ref)) return typeRef;

  // Reuse seen temporary type if it exists
  if (seen.has(type)) {
    return changetype<HeapTypeRef>(seen.get(type));
  }

  // Otherwise construct a new class type. Note that arrays are not supported, as these would
  // have to involve a Wasm-level `array`, either wrapped in `Array` or `Uint8Array` etc., or
  // directly representing an `ArrayBuffer` or `StaticArray`. TBD.
  let classReference = type.getClass();
  if (classReference) {
    // Make sure the base type has been built prior, at a lower index
    let base = classReference.base;
    let baseRef: HeapTypeRef = 0;
    if (base) baseRef = prepareType(builder, seen, base.type); // might be temporary, is non-nullable

    // Block this index with a temporary type and cache
    let index = binaryen._TypeBuilderGetSize(builder);
    binaryen._TypeBuilderGrow(builder, 1);
    let heapTypeRef = binaryen._TypeBuilderGetTempHeapType(builder, index);
    typeRef = binaryen._TypeBuilderGetTempRefType(builder, heapTypeRef, false);
    seen.set(type, typeRef);

    // Populate the struct type (TODO: names)
    let fieldTypes = new Array<TypeRef>();
    let packedTypes = new Array<PackedType>();
    let fieldMutables = new Array<u32>();
    let members = classReference.members;
    if (members) {
      for (let _values = Map_values(members), i = 0, k = _values.length; i < k; ++i) {
        let member = _values[i];
        if (member.kind != ElementKind.PropertyPrototype) continue;
        // only interested in fields (resolved during class finalization)
        let property = (<PropertyPrototype>member).instance;
        if (!property || !property.isField) continue;
        let fieldType = property.type;
        if (fieldType.is(TypeFlags.Nullable)) {
          fieldTypes.push(
            binaryen._TypeBuilderGetTempRefType(
              builder,
              binaryen._BinaryenTypeGetHeapType(prepareType(builder, seen, fieldType.nonNullableType)),
              true
            )
          );
        } else {
          fieldTypes.push(prepareType(builder, seen, fieldType));
        }
        packedTypes.push(determinePackedType(fieldType));
        fieldMutables.push(1);
      }
    }
    let cArrFT = allocPtrArray(fieldTypes);
    let cArrPT = allocU32Array(packedTypes);
    let cArrFM = allocU32Array(fieldMutables);
    binaryen._TypeBuilderSetStructType(builder, index, cArrFT, cArrPT, cArrFM, fieldTypes.length);
    if (base) {
      binaryen._TypeBuilderSetSubType(builder, index, binaryen._BinaryenTypeGetHeapType(baseRef));
    }
    binaryen._free(cArrFM);
    binaryen._free(cArrPT);
    binaryen._free(cArrFT);
    return typeRef;
  }

  // Respectively a new signature type
  let signatureReference = type.getSignature();
  if (signatureReference) {
    // Block this index with a temporary type and cache
    let index = binaryen._TypeBuilderGetSize(builder);
    binaryen._TypeBuilderGrow(builder, 1);
    let tempTypeRef = binaryen._TypeBuilderGetTempRefType(
      builder,
      binaryen._TypeBuilderGetTempHeapType(builder, index),
      false
    );
    seen.set(type, tempTypeRef);

    let paramTypes = new Array<TypeRef>();
    let resultTypes = new Array<TypeRef>();
    let parameterTypes = signatureReference.parameterTypes;
    for (let i = 0, k = parameterTypes.length; i < k; ++i) {
      let paramType = parameterTypes[i];
      if (paramType.is(TypeFlags.Nullable)) {
        paramTypes.push(
          binaryen._TypeBuilderGetTempRefType(
            builder,
            binaryen._BinaryenTypeGetHeapType(prepareType(builder, seen, paramType.nonNullableType)),
            true
          )
        );
      } else {
        paramTypes.push(prepareType(builder, seen, paramType));
      }
    }
    let returnType = signatureReference.returnType;
    resultTypes.push(
      returnType == Type.void
        ? TypeRef.None
        : returnType.is(TypeFlags.Nullable)
          ? binaryen._TypeBuilderGetTempRefType(
              builder,
              binaryen._BinaryenTypeGetHeapType(prepareType(builder, seen, returnType.nonNullableType)),
              true
            )
          : prepareType(builder, seen, returnType)
    );
    let tempParamType: TypeRef;
    if (paramTypes.length > 1) {
      let cArrPT = allocPtrArray(paramTypes);
      tempParamType = binaryen._TypeBuilderGetTempTupleType(builder, cArrPT, paramTypes.length);
      binaryen._free(cArrPT);
    } else {
      tempParamType = paramTypes.length ? paramTypes[0] : TypeRef.None;
    }
    let tempResultType: TypeRef;
    if (resultTypes.length > 1) {
      let cArrRT = allocPtrArray(resultTypes);
      tempResultType = binaryen._TypeBuilderGetTempTupleType(builder, cArrRT, resultTypes.length);
      binaryen._free(cArrRT);
    } else {
      tempResultType = resultTypes[0];
    }
    binaryen._TypeBuilderSetSignatureType(builder, index, tempParamType, tempResultType);
    return tempTypeRef;
  }

  throw new Error(`unexpected complex type: ${type.toString()}`);
}
