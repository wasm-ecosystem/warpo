(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $bool-Oz/f (mut f32) (f32.const 2))
 (global $bool-Oz/f0 (mut f32) (f32.const 0))
 (global $bool-Oz/f1 (mut f32) (f32.const -0))
 (global $bool-Oz/f2 (mut f32) (f32.const nan:0x400000))
 (global $bool-Oz/f3 (mut f32) (f32.const 0))
 (global $~lib/builtins/f32.MAX_VALUE f32 (f32.const 3402823466385288598117041e14))
 (global $bool-Oz/f4 (mut f32) (f32.const 0))
 (global $bool-Oz/f5 (mut f32) (f32.const 0))
 (global $bool-Oz/f6 (mut f32) (f32.const inf))
 (global $bool-Oz/f7 (mut f32) (f32.const 0))
 (global $~lib/builtins/f32.MIN_VALUE f32 (f32.const 1.401298464324817e-45))
 (global $bool-Oz/f8 (mut f32) (f32.const 0))
 (global $bool-Oz/f9 (mut f32) (f32.const 0))
 (global $bool-Oz/f10 (mut f32) (f32.const 0))
 (global $bool-Oz/f11 (mut f32) (f32.const 0))
 (global $bool-Oz/f12 (mut f32) (f32.const 0))
 (global $bool-Oz/f13 (mut f32) (f32.const 0))
 (global $bool-Oz/F (mut f64) (f64.const 2))
 (global $bool-Oz/F0 (mut f64) (f64.const 0))
 (global $bool-Oz/F1 (mut f64) (f64.const -0))
 (global $bool-Oz/F2 (mut f64) (f64.const nan:0x8000000000000))
 (global $bool-Oz/F3 (mut f64) (f64.const 0))
 (global $~lib/builtins/f64.MAX_VALUE f64 (f64.const 1797693134862315708145274e284))
 (global $bool-Oz/F4 (mut f64) (f64.const 0))
 (global $bool-Oz/F5 (mut f64) (f64.const 0))
 (global $bool-Oz/F6 (mut f64) (f64.const inf))
 (global $bool-Oz/F7 (mut f64) (f64.const 0))
 (global $~lib/builtins/f64.MIN_VALUE f64 (f64.const 5e-324))
 (global $bool-Oz/F8 (mut f64) (f64.const 0))
 (global $bool-Oz/F9 (mut f64) (f64.const 0))
 (global $bool-Oz/F10 (mut f64) (f64.const 0))
 (global $bool-Oz/F11 (mut f64) (f64.const 0))
 (global $bool-Oz/F12 (mut f64) (f64.const 0))
 (global $bool-Oz/F13 (mut f64) (f64.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00b\00o\00o\00l\00-\00O\00z\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:bool-Oz
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 1)
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
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f0)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
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
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f1)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 0)
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
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f2)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 0)
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
  (global.set $bool-Oz/f3
   (f32.neg
    (f32.const nan:0x400000)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f3)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 10)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $bool-Oz/f4
   (global.get $~lib/builtins/f32.MAX_VALUE)
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f4)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 1)
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
  (global.set $bool-Oz/f5
   (f32.neg
    (global.get $~lib/builtins/f32.MAX_VALUE)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f5)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 1)
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
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f6)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 1)
    )
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
  (global.set $bool-Oz/f7
   (f32.neg
    (f32.const inf)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f7)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 1)
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
  (global.set $bool-Oz/f8
   (global.get $~lib/builtins/f32.MIN_VALUE)
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f8)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 20)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $bool-Oz/f9
   (f32.neg
    (global.get $~lib/builtins/f32.MIN_VALUE)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f9)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 1)
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
  (global.set $bool-Oz/f10
   (f32.reinterpret_i32
    (i32.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f10)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 1)
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
  (global.set $bool-Oz/f11
   (f32.reinterpret_i32
    (i32.sub
     (i32.const 2139095040)
     (i32.const 1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f11)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 1)
    )
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
  (global.set $bool-Oz/f12
   (f32.reinterpret_i32
    (i32.add
     (i32.const 2139095040)
     (i32.const 1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f12)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 0)
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
  (global.set $bool-Oz/f13
   (f32.reinterpret_i32
    (i32.add
     (i32.const -8388608)
     (i32.const 1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.le_u
      (i32.sub
       (i32.shl
        (i32.reinterpret_f32
         (global.get $bool-Oz/f13)
        )
        (i32.const 1)
       )
       (i32.const 2)
      )
      (i32.const -16777218)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 30)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 1)
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
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F0)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 35)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F1)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 0)
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
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F2)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 0)
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
  (global.set $bool-Oz/F3
   (f64.neg
    (f64.const nan:0x8000000000000)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F3)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 0)
    )
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
  (global.set $bool-Oz/F4
   (global.get $~lib/builtins/f64.MAX_VALUE)
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F4)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 1)
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
  (global.set $bool-Oz/F5
   (f64.neg
    (global.get $~lib/builtins/f64.MAX_VALUE)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F5)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 45)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F6)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 1)
    )
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
  (global.set $bool-Oz/F7
   (f64.neg
    (f64.const inf)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F7)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 1)
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
  (global.set $bool-Oz/F8
   (global.get $~lib/builtins/f64.MIN_VALUE)
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F8)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 1)
    )
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
  (global.set $bool-Oz/F9
   (f64.neg
    (global.get $~lib/builtins/f64.MIN_VALUE)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F9)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 1)
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
  (global.set $bool-Oz/F10
   (f64.reinterpret_i64
    (i64.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F10)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 55)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $bool-Oz/F11
   (f64.reinterpret_i64
    (i64.sub
     (i64.const 9218868437227405312)
     (i64.const 1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F11)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 1)
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
  (global.set $bool-Oz/F12
   (f64.reinterpret_i64
    (i64.add
     (i64.const 9218868437227405312)
     (i64.const 1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F12)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 0)
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
  (global.set $bool-Oz/F13
   (f64.reinterpret_i64
    (i64.add
     (i64.const -4503599627370496)
     (i64.const 1)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $bool-Oz/F13)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
     (i32.const 0)
    )
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
 )
 (func $~start
  (call $start:bool-Oz)
 )
)
