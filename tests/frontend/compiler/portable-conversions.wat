(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $portable-conversions/i (mut i32) (i32.const 1))
 (global $portable-conversions/I (mut i64) (i64.const 1))
 (global $portable-conversions/f (mut f32) (f32.const 1))
 (global $portable-conversions/F (mut f64) (f64.const 1))
 (global $~lib/memory/__data_end i32 (i32.const 92))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32860))
 (global $~lib/memory/__heap_base i32 (i32.const 32860))
 (memory $0 1)
 (data $0 (i32.const 12) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00.\00\00\00p\00o\00r\00t\00a\00b\00l\00e\00-\00c\00o\00n\00v\00e\00r\00s\00i\00o\00n\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:portable-conversions
  (if
   (i32.eqz
    (i32.extend8_s
     (global.get $portable-conversions/i)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 6)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.extend8_s
     (i32.wrap_i64
      (global.get $portable-conversions/I)
     )
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
    (i32.extend8_s
     (i32.trunc_f32_s
      (global.get $portable-conversions/f)
     )
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
    (i32.extend8_s
     (i32.trunc_f64_s
      (global.get $portable-conversions/F)
     )
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
    (i32.extend16_s
     (global.get $portable-conversions/i)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 11)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.extend16_s
     (i32.wrap_i64
      (global.get $portable-conversions/I)
     )
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
    (i32.extend16_s
     (i32.trunc_f32_s
      (global.get $portable-conversions/f)
     )
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
    (i32.extend16_s
     (i32.trunc_f64_s
      (global.get $portable-conversions/F)
     )
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
    (global.get $portable-conversions/i)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 16)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.wrap_i64
     (global.get $portable-conversions/I)
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
    (i32.trunc_f32_s
     (global.get $portable-conversions/f)
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
    (i32.trunc_f64_s
     (global.get $portable-conversions/F)
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
   (i64.eqz
    (i64.extend_i32_s
     (global.get $portable-conversions/i)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 21)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i64.eqz
    (global.get $portable-conversions/I)
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
   (i64.eqz
    (i64.trunc_f32_s
     (global.get $portable-conversions/f)
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
   (i64.eqz
    (i64.trunc_f64_s
     (global.get $portable-conversions/F)
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
    (global.get $portable-conversions/i)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 26)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.wrap_i64
     (global.get $portable-conversions/I)
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
    (i32.trunc_f32_s
     (global.get $portable-conversions/f)
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
    (i32.trunc_f64_s
     (global.get $portable-conversions/F)
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
    (i32.and
     (global.get $portable-conversions/i)
     (i32.const 255)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 31)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.and
     (i32.wrap_i64
      (global.get $portable-conversions/I)
     )
     (i32.const 255)
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
    (i32.and
     (i32.trunc_f32_u
      (global.get $portable-conversions/f)
     )
     (i32.const 255)
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
    (i32.and
     (i32.trunc_f64_u
      (global.get $portable-conversions/F)
     )
     (i32.const 255)
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
    (i32.and
     (global.get $portable-conversions/i)
     (i32.const 65535)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 36)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.and
     (i32.wrap_i64
      (global.get $portable-conversions/I)
     )
     (i32.const 65535)
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
    (i32.and
     (i32.trunc_f32_u
      (global.get $portable-conversions/f)
     )
     (i32.const 65535)
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
    (i32.and
     (i32.trunc_f64_u
      (global.get $portable-conversions/F)
     )
     (i32.const 65535)
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
  (if
   (i32.eqz
    (global.get $portable-conversions/i)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 41)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.wrap_i64
     (global.get $portable-conversions/I)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 42)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.trunc_f32_u
     (global.get $portable-conversions/f)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 43)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.trunc_f64_u
     (global.get $portable-conversions/F)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 44)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i64.eqz
    (i64.extend_i32_s
     (global.get $portable-conversions/i)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 46)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i64.eqz
    (global.get $portable-conversions/I)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 47)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i64.eqz
    (i64.trunc_f32_u
     (global.get $portable-conversions/f)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 48)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i64.eqz
    (i64.trunc_f64_u
     (global.get $portable-conversions/F)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 49)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (global.get $portable-conversions/i)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 51)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.wrap_i64
     (global.get $portable-conversions/I)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 52)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.trunc_f32_u
     (global.get $portable-conversions/f)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 53)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.trunc_f64_u
     (global.get $portable-conversions/F)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 54)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.ne
     (global.get $portable-conversions/i)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 56)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.ne
     (global.get $portable-conversions/I)
     (i64.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 57)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.le_u
     (i32.sub
      (i32.shl
       (i32.reinterpret_f32
        (global.get $portable-conversions/f)
       )
       (i32.const 1)
      )
      (i32.const 2)
     )
     (i32.const -16777218)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 58)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i64.le_u
     (i64.sub
      (i64.shl
       (i64.reinterpret_f64
        (global.get $portable-conversions/F)
       )
       (i64.const 1)
      )
      (i64.const 2)
     )
     (i64.const -9007199254740994)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 59)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (f32.eq
    (f32.convert_i32_s
     (global.get $portable-conversions/i)
    )
    (f32.const 0)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 61)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (f32.eq
    (f32.convert_i64_s
     (global.get $portable-conversions/I)
    )
    (f32.const 0)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 62)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (f32.eq
    (global.get $portable-conversions/f)
    (f32.const 0)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 63)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (f32.eq
    (f32.demote_f64
     (global.get $portable-conversions/F)
    )
    (f32.const 0)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 64)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (f64.eq
    (f64.convert_i32_s
     (global.get $portable-conversions/i)
    )
    (f64.const 0)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 66)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (f64.eq
    (f64.convert_i64_s
     (global.get $portable-conversions/I)
    )
    (f64.const 0)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 67)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (f64.eq
    (f64.promote_f32
     (global.get $portable-conversions/f)
    )
    (f64.const 0)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 68)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (f64.eq
    (global.get $portable-conversions/F)
    (f64.const 0)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 69)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:portable-conversions)
 )
)
