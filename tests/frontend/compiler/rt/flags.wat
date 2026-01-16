(module
 (type $0 (func (param i32)))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $rt/flags/VALUE_ALIGN_REF i32 (i32.const 256))
 (global $rt/flags/KEY_ALIGN_REF i32 (i32.const 131072))
 (global $~lib/rt/__rtti_base i32 (i32.const 176))
 (global $~lib/memory/__data_end i32 (i32.const 444))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33212))
 (global $~lib/memory/__heap_base i32 (i32.const 33212))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 76) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 124) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00r\00t\00/\00f\00l\00a\00g\00s\00.\00t\00s\00\00\00\00\00\00\00")
 (data $3 (i32.const 176) "B\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00A\08\00\00 \00\00\00A\00\00\00 \00\00\00A\00\00\00\81\08\00\00 \00\00\00\81\00\00\00 \00\00\00\01\t\00\00 \00\00\00\01\01\00\00 \00\00\00\01\n\00\00 \00\00\00\01\02\00\00 \00\00\00\01\19\00\00 \00\00\00\01\1a\00\00 \00\00\00B\08\00\00B\00\00\00\82\08\00\00\82\00\00\00\02\t\00\00\02\01\00\00\02\n\00\00\02\02\00\00\02\19\00\00\02\1a\00\00\02\04\00\00 \00\00\00 \00\00\00\02A\00\00 \00\00\00\02a\00\00 \00\00\00H\08\00\00H\00\00\00\88\08\00\00\88\00\00\00\08\t\00\00\08\01\00\00\08\n\00\00\08\02\00\00\08\19\00\00\08\1a\00\00\08\04\00\00\08A\00\00\08a\00\00P\08\08\00\90\08\14\00\10\t\12\00\10\n\11\00\10\84\10\00P\08\82\00P\08\c2\00\10\c1\10\00\10\e1\10\00\10a\c2\00\10\t2\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/shared/typeinfo/Typeinfo#get:flags (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/rt/__typeinfo (param $id i32) (result i32)
  (local $ptr i32)
  (local.set $ptr
   (global.get $~lib/rt/__rtti_base)
  )
  (if
   (i32.gt_u
    (local.get $id)
    (i32.load
     (local.get $ptr)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 32)
     (i32.const 96)
     (i32.const 21)
     (i32.const 28)
    )
    (unreachable)
   )
  )
  (return
   (call $~lib/shared/typeinfo/Typeinfo#get:flags
    (i32.add
     (i32.add
      (local.get $ptr)
      (i32.const 4)
     )
     (i32.mul
      (local.get $id)
      (i32.const 4)
     )
    )
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Int8Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 4)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Uint8Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 6)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Uint8ClampedArray> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 8)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Int16Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 9)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Uint16Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 11)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Int32Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 13)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Uint32Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 15)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Int64Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 17)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Uint64Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 19)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Float32Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 21)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/typedarray/Float64Array> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 23)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<i8>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 25)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<u8>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 26)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<i16>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 27)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<u16>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 28)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<i32>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 29)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<u32>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 30)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<i64>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 31)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<u64>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 32)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<f32>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 33)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<f64>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 34)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<v128>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 35)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<rt/flags/Ref>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 38)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/array/Array<rt/flags/Ref|null>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 40)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<i8>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 42)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<u8>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 43)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<i16>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 44)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<u16>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 45)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<i32>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 46)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<u32>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 47)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<i64>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 48)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<u64>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 49)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<f32>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 50)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<f64>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 51)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<v128>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 52)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<rt/flags/Ref>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 53)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $rt/flags/test<~lib/set/Set<rt/flags/Ref|null>> (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 54)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<v128,i8>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 55)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<i64,i16>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 56)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<i32,i32>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 57)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<i16,i64>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 58)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<i8,v128>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 59)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<rt/flags/Ref,i8>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 60)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<rt/flags/Ref|null,i8>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 61)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<i8,rt/flags/Ref>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 62)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<i8,rt/flags/Ref|null>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 63)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<rt/flags/Ref|null,rt/flags/Ref|null>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 64)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $"rt/flags/test<~lib/map/Map<f32,i32>>" (param $flags i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/__typeinfo
      (i32.const 65)
     )
     (local.get $flags)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 144)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $start:rt/flags
  (call $rt/flags/test<~lib/typedarray/Int8Array>
   (i32.or
    (i32.or
     (i32.const 1)
     (i32.const 64)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Uint8Array>
   (i32.or
    (i32.const 1)
    (i32.const 64)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Uint8ClampedArray>
   (i32.or
    (i32.const 1)
    (i32.const 64)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Int16Array>
   (i32.or
    (i32.or
     (i32.const 1)
     (i32.const 128)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Uint16Array>
   (i32.or
    (i32.const 1)
    (i32.const 128)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Int32Array>
   (i32.or
    (i32.or
     (i32.const 1)
     (i32.const 256)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Uint32Array>
   (i32.or
    (i32.const 1)
    (i32.const 256)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Int64Array>
   (i32.or
    (i32.or
     (i32.const 1)
     (i32.const 512)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Uint64Array>
   (i32.or
    (i32.const 1)
    (i32.const 512)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Float32Array>
   (i32.or
    (i32.or
     (i32.or
      (i32.const 1)
      (i32.const 256)
     )
     (i32.const 2048)
    )
    (i32.const 4096)
   )
  )
  (call $rt/flags/test<~lib/typedarray/Float64Array>
   (i32.or
    (i32.or
     (i32.or
      (i32.const 1)
      (i32.const 512)
     )
     (i32.const 2048)
    )
    (i32.const 4096)
   )
  )
  (call $rt/flags/test<~lib/array/Array<i8>>
   (i32.or
    (i32.or
     (i32.const 2)
     (i32.const 64)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/array/Array<u8>>
   (i32.or
    (i32.const 2)
    (i32.const 64)
   )
  )
  (call $rt/flags/test<~lib/array/Array<i16>>
   (i32.or
    (i32.or
     (i32.const 2)
     (i32.const 128)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/array/Array<u16>>
   (i32.or
    (i32.const 2)
    (i32.const 128)
   )
  )
  (call $rt/flags/test<~lib/array/Array<i32>>
   (i32.or
    (i32.or
     (i32.const 2)
     (i32.const 256)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/array/Array<u32>>
   (i32.or
    (i32.const 2)
    (i32.const 256)
   )
  )
  (call $rt/flags/test<~lib/array/Array<i64>>
   (i32.or
    (i32.or
     (i32.const 2)
     (i32.const 512)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/array/Array<u64>>
   (i32.or
    (i32.const 2)
    (i32.const 512)
   )
  )
  (call $rt/flags/test<~lib/array/Array<f32>>
   (i32.or
    (i32.or
     (i32.or
      (i32.const 2)
      (i32.const 256)
     )
     (i32.const 2048)
    )
    (i32.const 4096)
   )
  )
  (call $rt/flags/test<~lib/array/Array<f64>>
   (i32.or
    (i32.or
     (i32.or
      (i32.const 2)
      (i32.const 512)
     )
     (i32.const 2048)
    )
    (i32.const 4096)
   )
  )
  (call $rt/flags/test<~lib/array/Array<v128>>
   (i32.or
    (i32.const 2)
    (i32.const 1024)
   )
  )
  (call $rt/flags/test<~lib/array/Array<rt/flags/Ref>>
   (i32.or
    (i32.or
     (i32.const 2)
     (global.get $rt/flags/VALUE_ALIGN_REF)
    )
    (i32.const 16384)
   )
  )
  (call $rt/flags/test<~lib/array/Array<rt/flags/Ref|null>>
   (i32.or
    (i32.or
     (i32.or
      (i32.const 2)
      (global.get $rt/flags/VALUE_ALIGN_REF)
     )
     (i32.const 8192)
    )
    (i32.const 16384)
   )
  )
  (call $rt/flags/test<~lib/set/Set<i8>>
   (i32.or
    (i32.or
     (i32.const 8)
     (i32.const 64)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/set/Set<u8>>
   (i32.or
    (i32.const 8)
    (i32.const 64)
   )
  )
  (call $rt/flags/test<~lib/set/Set<i16>>
   (i32.or
    (i32.or
     (i32.const 8)
     (i32.const 128)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/set/Set<u16>>
   (i32.or
    (i32.const 8)
    (i32.const 128)
   )
  )
  (call $rt/flags/test<~lib/set/Set<i32>>
   (i32.or
    (i32.or
     (i32.const 8)
     (i32.const 256)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/set/Set<u32>>
   (i32.or
    (i32.const 8)
    (i32.const 256)
   )
  )
  (call $rt/flags/test<~lib/set/Set<i64>>
   (i32.or
    (i32.or
     (i32.const 8)
     (i32.const 512)
    )
    (i32.const 2048)
   )
  )
  (call $rt/flags/test<~lib/set/Set<u64>>
   (i32.or
    (i32.const 8)
    (i32.const 512)
   )
  )
  (call $rt/flags/test<~lib/set/Set<f32>>
   (i32.or
    (i32.or
     (i32.or
      (i32.const 8)
      (i32.const 256)
     )
     (i32.const 2048)
    )
    (i32.const 4096)
   )
  )
  (call $rt/flags/test<~lib/set/Set<f64>>
   (i32.or
    (i32.or
     (i32.or
      (i32.const 8)
      (i32.const 512)
     )
     (i32.const 2048)
    )
    (i32.const 4096)
   )
  )
  (call $rt/flags/test<~lib/set/Set<v128>>
   (i32.or
    (i32.const 8)
    (i32.const 1024)
   )
  )
  (call $rt/flags/test<~lib/set/Set<rt/flags/Ref>>
   (i32.or
    (i32.or
     (i32.const 8)
     (global.get $rt/flags/VALUE_ALIGN_REF)
    )
    (i32.const 16384)
   )
  )
  (call $rt/flags/test<~lib/set/Set<rt/flags/Ref|null>>
   (i32.or
    (i32.or
     (i32.or
      (i32.const 8)
      (global.get $rt/flags/VALUE_ALIGN_REF)
     )
     (i32.const 8192)
    )
    (i32.const 16384)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<v128,i8>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.const 16)
      (i32.const 524288)
     )
     (i32.const 64)
    )
    (i32.const 2048)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<i64,i16>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.or
       (i32.const 16)
       (i32.const 262144)
      )
      (i32.const 1048576)
     )
     (i32.const 128)
    )
    (i32.const 2048)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<i32,i32>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.or
       (i32.const 16)
       (i32.const 131072)
      )
      (i32.const 1048576)
     )
     (i32.const 256)
    )
    (i32.const 2048)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<i16,i64>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.or
       (i32.const 16)
       (i32.const 65536)
      )
      (i32.const 1048576)
     )
     (i32.const 512)
    )
    (i32.const 2048)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<i8,v128>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.const 16)
      (i32.const 32768)
     )
     (i32.const 1048576)
    )
    (i32.const 1024)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<rt/flags/Ref,i8>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.or
       (i32.const 16)
       (global.get $rt/flags/KEY_ALIGN_REF)
      )
      (i32.const 8388608)
     )
     (i32.const 64)
    )
    (i32.const 2048)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<rt/flags/Ref|null,i8>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.or
       (i32.or
        (i32.const 16)
        (global.get $rt/flags/KEY_ALIGN_REF)
       )
       (i32.const 4194304)
      )
      (i32.const 8388608)
     )
     (i32.const 64)
    )
    (i32.const 2048)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<i8,rt/flags/Ref>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.or
       (i32.const 16)
       (i32.const 32768)
      )
      (i32.const 1048576)
     )
     (i32.const 16384)
    )
    (global.get $rt/flags/VALUE_ALIGN_REF)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<i8,rt/flags/Ref|null>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.or
       (i32.or
        (i32.const 16)
        (i32.const 32768)
       )
       (i32.const 1048576)
      )
      (i32.const 8192)
     )
     (i32.const 16384)
    )
    (global.get $rt/flags/VALUE_ALIGN_REF)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<rt/flags/Ref|null,rt/flags/Ref|null>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.or
       (i32.or
        (i32.or
         (i32.const 16)
         (i32.const 4194304)
        )
        (i32.const 8388608)
       )
       (global.get $rt/flags/KEY_ALIGN_REF)
      )
      (i32.const 8192)
     )
     (i32.const 16384)
    )
    (global.get $rt/flags/VALUE_ALIGN_REF)
   )
  )
  (call $"rt/flags/test<~lib/map/Map<f32,i32>>"
   (i32.or
    (i32.or
     (i32.or
      (i32.or
       (i32.or
        (i32.const 16)
        (i32.const 131072)
       )
       (i32.const 1048576)
      )
      (i32.const 2097152)
     )
     (i32.const 256)
    )
    (i32.const 2048)
   )
  )
 )
 (func $~start
  (call $start:rt/flags)
 )
)
