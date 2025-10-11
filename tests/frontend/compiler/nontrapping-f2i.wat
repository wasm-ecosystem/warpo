(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/builtins/f32.MAX_VALUE f32 (f32.const 3402823466385288598117041e14))
 (global $~lib/builtins/i32.MAX_VALUE i32 (i32.const 2147483647))
 (global $~lib/builtins/i32.MIN_VALUE i32 (i32.const -2147483648))
 (global $~lib/builtins/f32.NaN f32 (f32.const nan:0x400000))
 (global $~lib/builtins/i64.MAX_VALUE i64 (i64.const 9223372036854775807))
 (global $~lib/builtins/i64.MIN_VALUE i64 (i64.const -9223372036854775808))
 (global $~lib/builtins/u32.MAX_VALUE i32 (i32.const -1))
 (global $~lib/builtins/u32.MIN_VALUE i32 (i32.const 0))
 (global $~lib/builtins/u64.MAX_VALUE i64 (i64.const -1))
 (global $~lib/builtins/u64.MIN_VALUE i64 (i64.const 0))
 (global $~lib/builtins/f64.MAX_VALUE f64 (f64.const 1797693134862315708145274e284))
 (global $~lib/builtins/f64.NaN f64 (f64.const nan:0x8000000000000))
 (global $~lib/memory/__data_end i32 (i32.const 76))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32844))
 (global $~lib/memory/__heap_base i32 (i32.const 32844))
 (global $~started (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00n\00o\00n\00t\00r\00a\00p\00p\00i\00n\00g\00-\00f\002\00i\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (export "_start" (func $~start))
 (func $start:nontrapping-f2i
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f32_s
      (global.get $~lib/builtins/f32.MAX_VALUE)
     )
     (global.get $~lib/builtins/i32.MAX_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 2)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f32_s
      (f32.neg
       (global.get $~lib/builtins/f32.MAX_VALUE)
      )
     )
     (global.get $~lib/builtins/i32.MIN_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 3)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f32_s
      (global.get $~lib/builtins/f32.NaN)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 4)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f32_s
      (global.get $~lib/builtins/f32.MAX_VALUE)
     )
     (global.get $~lib/builtins/i64.MAX_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 7)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f32_s
      (f32.neg
       (global.get $~lib/builtins/f32.MAX_VALUE)
      )
     )
     (global.get $~lib/builtins/i64.MIN_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 8)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f32_s
      (global.get $~lib/builtins/f32.NaN)
     )
     (i64.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 9)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f32_u
      (global.get $~lib/builtins/f32.MAX_VALUE)
     )
     (global.get $~lib/builtins/u32.MAX_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 12)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f32_u
      (f32.neg
       (global.get $~lib/builtins/f32.MAX_VALUE)
      )
     )
     (global.get $~lib/builtins/u32.MIN_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 13)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f32_u
      (global.get $~lib/builtins/f32.NaN)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 14)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f32_u
      (global.get $~lib/builtins/f32.MAX_VALUE)
     )
     (global.get $~lib/builtins/u64.MAX_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 17)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f32_u
      (f32.neg
       (global.get $~lib/builtins/f32.MAX_VALUE)
      )
     )
     (global.get $~lib/builtins/u64.MIN_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 18)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f32_u
      (global.get $~lib/builtins/f32.NaN)
     )
     (i64.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 19)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f64_s
      (global.get $~lib/builtins/f64.MAX_VALUE)
     )
     (global.get $~lib/builtins/i32.MAX_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 22)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f64_s
      (f64.neg
       (global.get $~lib/builtins/f64.MAX_VALUE)
      )
     )
     (global.get $~lib/builtins/i32.MIN_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f64_s
      (global.get $~lib/builtins/f64.NaN)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 24)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f64_s
      (global.get $~lib/builtins/f64.MAX_VALUE)
     )
     (global.get $~lib/builtins/i64.MAX_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 27)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f64_s
      (f64.neg
       (global.get $~lib/builtins/f64.MAX_VALUE)
      )
     )
     (global.get $~lib/builtins/i64.MIN_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 28)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f64_s
      (global.get $~lib/builtins/f64.NaN)
     )
     (i64.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 29)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f64_u
      (global.get $~lib/builtins/f64.MAX_VALUE)
     )
     (global.get $~lib/builtins/u32.MAX_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 32)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f64_u
      (f64.neg
       (global.get $~lib/builtins/f64.MAX_VALUE)
      )
     )
     (global.get $~lib/builtins/u32.MIN_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 33)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.trunc_f64_u
      (global.get $~lib/builtins/f64.NaN)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 34)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f64_u
      (global.get $~lib/builtins/f64.MAX_VALUE)
     )
     (global.get $~lib/builtins/u64.MAX_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 37)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f64_u
      (f64.neg
       (global.get $~lib/builtins/f64.MAX_VALUE)
      )
     )
     (global.get $~lib/builtins/u64.MIN_VALUE)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 38)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.eq
     (i64.trunc_f64_u
      (global.get $~lib/builtins/f64.NaN)
     )
     (i64.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 39)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (if
   (global.get $~started)
   (then
    (return)
   )
  )
  (global.set $~started
   (i32.const 1)
  )
  (call $start:nontrapping-f2i)
 )
)
