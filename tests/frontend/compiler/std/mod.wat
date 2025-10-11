(module
 (type $0 (func (param f64 f64) (result f64)))
 (type $1 (func))
 (type $2 (func (param i32) (result i32)))
 (type $3 (func (param f64 f64) (result i32)))
 (type $4 (func (param f64 f64 f64) (result i32)))
 (type $5 (func (param i32 i32 i32 i32)))
 (type $6 (func (param f32 f32) (result f32)))
 (type $7 (func (param f32 f32) (result i32)))
 (type $8 (func (param f32 f32 f32) (result i32)))
 (import "mod" "mod" (func $std/mod/mod (param f64 f64) (result f64)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $std/mod/js i32 (i32.const 1))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00s\00t\00d\00/\00m\00o\00d\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "mod" (func $std/mod/mod))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/math/NativeMath.mod (param $x f64) (param $y f64) (result f64)
  (local $ux i64)
  (local $uy i64)
  (local $ex i64)
  (local $ey i64)
  (local $sx i64)
  (local $uy1 i64)
  (local $m f64)
  (local $ux1 i64)
  (local $shift i64)
  (if
   (f64.eq
    (f64.abs
     (local.get $y)
    )
    (f64.const 1)
   )
   (then
    (return
     (f64.copysign
      (f64.sub
       (local.get $x)
       (f64.trunc
        (local.get $x)
       )
      )
      (local.get $x)
     )
    )
   )
  )
  (local.set $ux
   (i64.reinterpret_f64
    (local.get $x)
   )
  )
  (local.set $uy
   (i64.reinterpret_f64
    (local.get $y)
   )
  )
  (local.set $ex
   (i64.and
    (i64.shr_u
     (local.get $ux)
     (i64.const 52)
    )
    (i64.const 2047)
   )
  )
  (local.set $ey
   (i64.and
    (i64.shr_u
     (local.get $uy)
     (i64.const 52)
    )
    (i64.const 2047)
   )
  )
  (local.set $sx
   (i64.shr_u
    (local.get $ux)
    (i64.const 63)
   )
  )
  (local.set $uy1
   (i64.shl
    (local.get $uy)
    (i64.const 1)
   )
  )
  (if
   (if (result i32)
    (if (result i32)
     (i64.eq
      (local.get $uy1)
      (i64.const 0)
     )
     (then
      (i32.const 1)
     )
     (else
      (i64.eq
       (local.get $ex)
       (i64.const 2047)
      )
     )
    )
    (then
     (i32.const 1)
    )
    (else
     (f64.ne
      (local.get $y)
      (local.get $y)
     )
    )
   )
   (then
    (local.set $m
     (f64.mul
      (local.get $x)
      (local.get $y)
     )
    )
    (return
     (f64.div
      (local.get $m)
      (local.get $m)
     )
    )
   )
  )
  (local.set $ux1
   (i64.shl
    (local.get $ux)
    (i64.const 1)
   )
  )
  (if
   (i64.le_u
    (local.get $ux1)
    (local.get $uy1)
   )
   (then
    (return
     (f64.mul
      (local.get $x)
      (f64.convert_i32_u
       (i64.ne
        (local.get $ux1)
        (local.get $uy1)
       )
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (i64.ne
     (local.get $ex)
     (i64.const 0)
    )
   )
   (then
    (local.set $ex
     (i64.sub
      (local.get $ex)
      (i64.clz
       (i64.shl
        (local.get $ux)
        (i64.const 12)
       )
      )
     )
    )
    (local.set $ux
     (i64.shl
      (local.get $ux)
      (i64.sub
       (i64.const 1)
       (local.get $ex)
      )
     )
    )
   )
   (else
    (local.set $ux
     (i64.and
      (local.get $ux)
      (i64.shr_u
       (i64.const -1)
       (i64.const 12)
      )
     )
    )
    (local.set $ux
     (i64.or
      (local.get $ux)
      (i64.shl
       (i64.const 1)
       (i64.const 52)
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (i64.ne
     (local.get $ey)
     (i64.const 0)
    )
   )
   (then
    (local.set $ey
     (i64.sub
      (local.get $ey)
      (i64.clz
       (i64.shl
        (local.get $uy)
        (i64.const 12)
       )
      )
     )
    )
    (local.set $uy
     (i64.shl
      (local.get $uy)
      (i64.sub
       (i64.const 1)
       (local.get $ey)
      )
     )
    )
   )
   (else
    (local.set $uy
     (i64.and
      (local.get $uy)
      (i64.shr_u
       (i64.const -1)
       (i64.const 12)
      )
     )
    )
    (local.set $uy
     (i64.or
      (local.get $uy)
      (i64.shl
       (i64.const 1)
       (i64.const 52)
      )
     )
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i64.gt_s
      (local.get $ex)
      (local.get $ey)
     )
     (then
      (if
       (i64.ge_u
        (local.get $ux)
        (local.get $uy)
       )
       (then
        (if
         (i64.eq
          (local.get $ux)
          (local.get $uy)
         )
         (then
          (return
           (f64.mul
            (f64.const 0)
            (local.get $x)
           )
          )
         )
        )
        (local.set $ux
         (i64.sub
          (local.get $ux)
          (local.get $uy)
         )
        )
       )
      )
      (local.set $ux
       (i64.shl
        (local.get $ux)
        (i64.const 1)
       )
      )
      (local.set $ex
       (i64.sub
        (local.get $ex)
        (i64.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (i64.ge_u
    (local.get $ux)
    (local.get $uy)
   )
   (then
    (if
     (i64.eq
      (local.get $ux)
      (local.get $uy)
     )
     (then
      (return
       (f64.mul
        (f64.const 0)
        (local.get $x)
       )
      )
     )
    )
    (local.set $ux
     (i64.sub
      (local.get $ux)
      (local.get $uy)
     )
    )
   )
  )
  (local.set $shift
   (i64.clz
    (i64.shl
     (local.get $ux)
     (i64.const 11)
    )
   )
  )
  (local.set $ex
   (i64.sub
    (local.get $ex)
    (local.get $shift)
   )
  )
  (local.set $ux
   (i64.shl
    (local.get $ux)
    (local.get $shift)
   )
  )
  (if
   (i64.gt_s
    (local.get $ex)
    (i64.const 0)
   )
   (then
    (local.set $ux
     (i64.sub
      (local.get $ux)
      (i64.shl
       (i64.const 1)
       (i64.const 52)
      )
     )
    )
    (local.set $ux
     (i64.or
      (local.get $ux)
      (i64.shl
       (local.get $ex)
       (i64.const 52)
      )
     )
    )
   )
   (else
    (local.set $ux
     (i64.shr_u
      (local.get $ux)
      (i64.add
       (i64.sub
        (i64.const 0)
        (local.get $ex)
       )
       (i64.const 1)
      )
     )
    )
   )
  )
  (return
   (f64.reinterpret_i64
    (i64.or
     (local.get $ux)
     (i64.shl
      (local.get $sx)
      (i64.const 63)
     )
    )
   )
  )
 )
 (func $std/mod/check<f64> (param $actual f64) (param $expected f64) (result i32)
  (if
   (f64.ne
    (local.get $expected)
    (local.get $expected)
   )
   (then
    (return
     (f64.ne
      (local.get $actual)
      (local.get $actual)
     )
    )
   )
  )
  (if
   (f64.eq
    (local.get $expected)
    (f64.const 0)
   )
   (then
    (return
     (f64.eq
      (f64.div
       (f64.convert_i32_u
        (i32.const 1)
       )
       (local.get $expected)
      )
      (f64.div
       (f64.const 1)
       (local.get $actual)
      )
     )
    )
   )
  )
  (return
   (f64.eq
    (local.get $actual)
    (local.get $expected)
   )
  )
 )
 (func $std/mod/test_fmod (param $left f64) (param $right f64) (param $expected f64) (result i32)
  (return
   (if (result i32)
    (call $std/mod/check<f64>
     (call $~lib/math/NativeMath.mod
      (local.get $left)
      (local.get $right)
     )
     (local.get $expected)
    )
    (then
     (call $std/mod/check<f64>
      (call $std/mod/mod
       (local.get $left)
       (local.get $right)
      )
      (local.get $expected)
     )
    )
    (else
     (i32.const 0)
    )
   )
  )
 )
 (func $~lib/math/NativeMathf.mod (param $x f32) (param $y f32) (result f32)
  (local $ux i32)
  (local $uy i32)
  (local $ex i32)
  (local $ey i32)
  (local $sm i32)
  (local $uy1 i32)
  (local $m f32)
  (local $ux1 i32)
  (local $shift i32)
  (if
   (f32.eq
    (f32.abs
     (local.get $y)
    )
    (f32.const 1)
   )
   (then
    (return
     (f32.copysign
      (f32.sub
       (local.get $x)
       (f32.trunc
        (local.get $x)
       )
      )
      (local.get $x)
     )
    )
   )
  )
  (local.set $ux
   (i32.reinterpret_f32
    (local.get $x)
   )
  )
  (local.set $uy
   (i32.reinterpret_f32
    (local.get $y)
   )
  )
  (local.set $ex
   (i32.and
    (i32.shr_u
     (local.get $ux)
     (i32.const 23)
    )
    (i32.const 255)
   )
  )
  (local.set $ey
   (i32.and
    (i32.shr_u
     (local.get $uy)
     (i32.const 23)
    )
    (i32.const 255)
   )
  )
  (local.set $sm
   (i32.and
    (local.get $ux)
    (i32.const -2147483648)
   )
  )
  (local.set $uy1
   (i32.shl
    (local.get $uy)
    (i32.const 1)
   )
  )
  (if
   (if (result i32)
    (if (result i32)
     (i32.eq
      (local.get $uy1)
      (i32.const 0)
     )
     (then
      (i32.const 1)
     )
     (else
      (i32.eq
       (local.get $ex)
       (i32.const 255)
      )
     )
    )
    (then
     (i32.const 1)
    )
    (else
     (f32.ne
      (local.get $y)
      (local.get $y)
     )
    )
   )
   (then
    (local.set $m
     (f32.mul
      (local.get $x)
      (local.get $y)
     )
    )
    (return
     (f32.div
      (local.get $m)
      (local.get $m)
     )
    )
   )
  )
  (local.set $ux1
   (i32.shl
    (local.get $ux)
    (i32.const 1)
   )
  )
  (if
   (i32.le_u
    (local.get $ux1)
    (local.get $uy1)
   )
   (then
    (return
     (f32.mul
      (local.get $x)
      (f32.convert_i32_u
       (i32.ne
        (local.get $ux1)
        (local.get $uy1)
       )
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (local.get $ex)
   )
   (then
    (local.set $ex
     (i32.sub
      (local.get $ex)
      (i32.clz
       (i32.shl
        (local.get $ux)
        (i32.const 9)
       )
      )
     )
    )
    (local.set $ux
     (i32.shl
      (local.get $ux)
      (i32.sub
       (i32.const 1)
       (local.get $ex)
      )
     )
    )
   )
   (else
    (local.set $ux
     (i32.and
      (local.get $ux)
      (i32.shr_u
       (i32.const -1)
       (i32.const 9)
      )
     )
    )
    (local.set $ux
     (i32.or
      (local.get $ux)
      (i32.shl
       (i32.const 1)
       (i32.const 23)
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (local.get $ey)
   )
   (then
    (local.set $ey
     (i32.sub
      (local.get $ey)
      (i32.clz
       (i32.shl
        (local.get $uy)
        (i32.const 9)
       )
      )
     )
    )
    (local.set $uy
     (i32.shl
      (local.get $uy)
      (i32.sub
       (i32.const 1)
       (local.get $ey)
      )
     )
    )
   )
   (else
    (local.set $uy
     (i32.and
      (local.get $uy)
      (i32.shr_u
       (i32.const -1)
       (i32.const 9)
      )
     )
    )
    (local.set $uy
     (i32.or
      (local.get $uy)
      (i32.shl
       (i32.const 1)
       (i32.const 23)
      )
     )
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.gt_s
      (local.get $ex)
      (local.get $ey)
     )
     (then
      (if
       (i32.ge_u
        (local.get $ux)
        (local.get $uy)
       )
       (then
        (if
         (i32.eq
          (local.get $ux)
          (local.get $uy)
         )
         (then
          (return
           (f32.mul
            (f32.const 0)
            (local.get $x)
           )
          )
         )
        )
        (local.set $ux
         (i32.sub
          (local.get $ux)
          (local.get $uy)
         )
        )
       )
      )
      (local.set $ux
       (i32.shl
        (local.get $ux)
        (i32.const 1)
       )
      )
      (local.set $ex
       (i32.sub
        (local.get $ex)
        (i32.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (i32.ge_u
    (local.get $ux)
    (local.get $uy)
   )
   (then
    (if
     (i32.eq
      (local.get $ux)
      (local.get $uy)
     )
     (then
      (return
       (f32.mul
        (f32.const 0)
        (local.get $x)
       )
      )
     )
    )
    (local.set $ux
     (i32.sub
      (local.get $ux)
      (local.get $uy)
     )
    )
   )
  )
  (local.set $shift
   (i32.clz
    (i32.shl
     (local.get $ux)
     (i32.const 8)
    )
   )
  )
  (local.set $ex
   (i32.sub
    (local.get $ex)
    (local.get $shift)
   )
  )
  (local.set $ux
   (i32.shl
    (local.get $ux)
    (local.get $shift)
   )
  )
  (if
   (i32.gt_s
    (local.get $ex)
    (i32.const 0)
   )
   (then
    (local.set $ux
     (i32.sub
      (local.get $ux)
      (i32.shl
       (i32.const 1)
       (i32.const 23)
      )
     )
    )
    (local.set $ux
     (i32.or
      (local.get $ux)
      (i32.shl
       (local.get $ex)
       (i32.const 23)
      )
     )
    )
   )
   (else
    (local.set $ux
     (i32.shr_u
      (local.get $ux)
      (i32.add
       (i32.sub
        (i32.const 0)
        (local.get $ex)
       )
       (i32.const 1)
      )
     )
    )
   )
  )
  (return
   (f32.reinterpret_i32
    (i32.or
     (local.get $ux)
     (local.get $sm)
    )
   )
  )
 )
 (func $std/mod/check<f32> (param $actual f32) (param $expected f32) (result i32)
  (if
   (f32.ne
    (local.get $expected)
    (local.get $expected)
   )
   (then
    (return
     (f32.ne
      (local.get $actual)
      (local.get $actual)
     )
    )
   )
  )
  (if
   (f32.eq
    (local.get $expected)
    (f32.const 0)
   )
   (then
    (return
     (f32.eq
      (f32.div
       (f32.convert_i32_u
        (i32.const 1)
       )
       (local.get $expected)
      )
      (f32.div
       (f32.const 1)
       (local.get $actual)
      )
     )
    )
   )
  )
  (return
   (f32.eq
    (local.get $actual)
    (local.get $expected)
   )
  )
 )
 (func $std/mod/test_fmodf (param $left f32) (param $right f32) (param $expected f32) (result i32)
  (return
   (call $std/mod/check<f32>
    (call $~lib/math/NativeMathf.mod
     (local.get $left)
     (local.get $right)
    )
    (local.get $expected)
   )
  )
 )
 (func $start:std/mod
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 3)
     (f64.const 2)
     (f64.const 1)
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
    (call $std/mod/test_fmod
     (f64.const 3)
     (f64.const -2)
     (f64.const 1)
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
    (call $std/mod/test_fmod
     (f64.const -3)
     (f64.const 2)
     (f64.const -1)
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
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -3)
     (f64.const -2)
     (f64.const -1)
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 3.5)
     (f64.const 2)
     (f64.const 1.5)
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
    (call $std/mod/test_fmod
     (f64.const 3.5)
     (f64.const -2)
     (f64.const 1.5)
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
    (call $std/mod/test_fmod
     (f64.const -3.5)
     (f64.const 2)
     (f64.const -1.5)
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
    (call $std/mod/test_fmod
     (f64.const -3.5)
     (f64.const -2)
     (f64.const -1.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 25)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 3)
     (f64.const 2.5)
     (f64.const 0.5)
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
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 3)
     (f64.const -2.5)
     (f64.const 0.5)
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
    (call $std/mod/test_fmod
     (f64.const -3)
     (f64.const 2.5)
     (f64.const -0.5)
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
    (call $std/mod/test_fmod
     (f64.const -3)
     (f64.const -2.5)
     (f64.const -0.5)
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
    (call $std/mod/test_fmod
     (f64.const 0.5)
     (f64.const 1)
     (f64.const 0.5)
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
    (call $std/mod/test_fmod
     (f64.const 0.5)
     (f64.const -1)
     (f64.const 0.5)
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
    (call $std/mod/test_fmod
     (f64.const -0.5)
     (f64.const 1)
     (f64.const -0.5)
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
    (call $std/mod/test_fmod
     (f64.const -0.5)
     (f64.const -1)
     (f64.const -0.5)
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
    (call $std/mod/test_fmod
     (f64.const 1.5)
     (f64.const 1)
     (f64.const 0.5)
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
    (call $std/mod/test_fmod
     (f64.const 1.5)
     (f64.const -1)
     (f64.const 0.5)
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
    (call $std/mod/test_fmod
     (f64.const -1.5)
     (f64.const 1)
     (f64.const -0.5)
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
    (call $std/mod/test_fmod
     (f64.const -1.5)
     (f64.const -1)
     (f64.const -0.5)
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
    (call $std/mod/test_fmod
     (f64.const 1.25)
     (f64.const 1)
     (f64.const 0.25)
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
    (call $std/mod/test_fmod
     (f64.const 1.25)
     (f64.const -1)
     (f64.const 0.25)
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
    (call $std/mod/test_fmod
     (f64.const -1.25)
     (f64.const 1)
     (f64.const -0.25)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 40)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -1.25)
     (f64.const -1)
     (f64.const -0.25)
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
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 1)
     (f64.const 1.25)
     (f64.const 1)
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
    (call $std/mod/test_fmod
     (f64.const 1)
     (f64.const -1.25)
     (f64.const 1)
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
    (call $std/mod/test_fmod
     (f64.const -1)
     (f64.const 1.25)
     (f64.const -1)
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -1)
     (f64.const -1.25)
     (f64.const -1)
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
    (call $std/mod/test_fmod
     (f64.const -13)
     (f64.const 64)
     (f64.const -13)
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 0)
     (f64.const 0)
     (f64.const nan:0x8000000000000)
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
    (call $std/mod/test_fmod
     (f64.const -0)
     (f64.const 0)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 50)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 0)
     (f64.const -0)
     (f64.const nan:0x8000000000000)
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
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -0)
     (f64.const -0)
     (f64.const nan:0x8000000000000)
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
    (call $std/mod/test_fmod
     (f64.const 0)
     (f64.const 1)
     (f64.const 0)
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
    (call $std/mod/test_fmod
     (f64.const -0)
     (f64.const 1)
     (f64.const -0)
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
    (call $std/mod/test_fmod
     (f64.const 0)
     (f64.const -1)
     (f64.const 0)
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
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -0)
     (f64.const -1)
     (f64.const -0)
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
    (call $std/mod/test_fmod
     (f64.const 1)
     (f64.const 0)
     (f64.const nan:0x8000000000000)
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
    (call $std/mod/test_fmod
     (f64.const -1)
     (f64.const 0)
     (f64.const nan:0x8000000000000)
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
    (call $std/mod/test_fmod
     (f64.const 1)
     (f64.const -0)
     (f64.const nan:0x8000000000000)
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -1)
     (f64.const -0)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 60)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const 0)
     (f64.const nan:0x8000000000000)
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
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const -0)
     (f64.const nan:0x8000000000000)
    )
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const 1)
     (f64.const nan:0x8000000000000)
    )
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const -1)
     (f64.const nan:0x8000000000000)
    )
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const 0)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 65)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const -0)
     (f64.const nan:0x8000000000000)
    )
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const 1)
     (f64.const nan:0x8000000000000)
    )
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const -1)
     (f64.const nan:0x8000000000000)
    )
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
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const nan:0x8000000000000)
     (f64.const nan:0x8000000000000)
    )
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
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 0)
     (f64.const inf)
     (f64.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 70)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -0)
     (f64.const inf)
     (f64.const -0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 71)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 0)
     (f64.neg
      (f64.const inf)
     )
     (f64.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 72)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -0)
     (f64.neg
      (f64.const inf)
     )
     (f64.const -0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 73)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 1)
     (f64.const inf)
     (f64.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 74)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -1)
     (f64.const inf)
     (f64.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 75)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const 1)
     (f64.neg
      (f64.const inf)
     )
     (f64.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 76)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const -1)
     (f64.neg
      (f64.const inf)
     )
     (f64.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 77)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const inf)
     (f64.const 0)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 78)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const inf)
     (f64.const -0)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 79)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.neg
      (f64.const inf)
     )
     (f64.const 0)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 80)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.neg
      (f64.const inf)
     )
     (f64.const -0)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 81)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const inf)
     (f64.const 1)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 82)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const inf)
     (f64.const -1)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 83)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.neg
      (f64.const inf)
     )
     (f64.const 1)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 84)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.neg
      (f64.const inf)
     )
     (f64.const -1)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 85)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const inf)
     (f64.const inf)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 86)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.neg
      (f64.const inf)
     )
     (f64.const inf)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 87)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const inf)
     (f64.neg
      (f64.const inf)
     )
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 88)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.neg
      (f64.const inf)
     )
     (f64.neg
      (f64.const inf)
     )
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 89)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const inf)
     (f64.const nan:0x8000000000000)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 90)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.neg
      (f64.const inf)
     )
     (f64.const nan:0x8000000000000)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 91)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.const inf)
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 92)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmod
     (f64.const nan:0x8000000000000)
     (f64.neg
      (f64.const inf)
     )
     (f64.const nan:0x8000000000000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 93)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 3)
     (f32.const 2)
     (f32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 102)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 3)
     (f32.const -2)
     (f32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 103)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -3)
     (f32.const 2)
     (f32.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 104)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -3)
     (f32.const -2)
     (f32.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 105)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 3.5)
     (f32.const 2)
     (f32.const 1.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 106)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 3.5)
     (f32.const -2)
     (f32.const 1.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 107)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -3.5)
     (f32.const 2)
     (f32.const -1.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 108)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -3.5)
     (f32.const -2)
     (f32.const -1.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 109)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 3)
     (f32.const 2.5)
     (f32.const 0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 110)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 3)
     (f32.const -2.5)
     (f32.const 0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 111)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -3)
     (f32.const 2.5)
     (f32.const -0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 112)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -3)
     (f32.const -2.5)
     (f32.const -0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 113)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 0.5)
     (f32.const 1)
     (f32.const 0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 114)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 0.5)
     (f32.const -1)
     (f32.const 0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 115)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -0.5)
     (f32.const 1)
     (f32.const -0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 116)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -0.5)
     (f32.const -1)
     (f32.const -0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 117)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 1.5)
     (f32.const 1)
     (f32.const 0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 118)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 1.5)
     (f32.const -1)
     (f32.const 0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 119)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -1.5)
     (f32.const 1)
     (f32.const -0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 120)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -1.5)
     (f32.const -1)
     (f32.const -0.5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 121)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 0)
     (f32.const 0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 124)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -0)
     (f32.const 0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 125)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 0)
     (f32.const -0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 126)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -0)
     (f32.const -0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 127)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 1)
     (f32.const 0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 128)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -1)
     (f32.const 0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 129)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 1)
     (f32.const -0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 130)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -1)
     (f32.const -0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 131)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const 0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 132)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const -0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 133)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const 1)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 134)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const -1)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 135)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const 0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 136)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const -0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 137)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const 1)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 138)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const -1)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 139)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const nan:0x400000)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 140)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 0)
     (f32.const inf)
     (f32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 141)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -0)
     (f32.const inf)
     (f32.const -0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 142)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 0)
     (f32.neg
      (f32.const inf)
     )
     (f32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 143)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -0)
     (f32.neg
      (f32.const inf)
     )
     (f32.const -0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 144)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 1)
     (f32.const inf)
     (f32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 145)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -1)
     (f32.const inf)
     (f32.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 146)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const 1)
     (f32.neg
      (f32.const inf)
     )
     (f32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 147)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const -1)
     (f32.neg
      (f32.const inf)
     )
     (f32.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 148)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const inf)
     (f32.const 0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 149)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const inf)
     (f32.const -0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 150)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.neg
      (f32.const inf)
     )
     (f32.const 0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 151)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.neg
      (f32.const inf)
     )
     (f32.const -0)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 152)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const inf)
     (f32.const 1)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 153)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const inf)
     (f32.const -1)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 154)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.neg
      (f32.const inf)
     )
     (f32.const 1)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 155)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.neg
      (f32.const inf)
     )
     (f32.const -1)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 156)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const inf)
     (f32.const inf)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 157)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.neg
      (f32.const inf)
     )
     (f32.const inf)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 158)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const inf)
     (f32.neg
      (f32.const inf)
     )
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 159)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.neg
      (f32.const inf)
     )
     (f32.neg
      (f32.const inf)
     )
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 160)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const inf)
     (f32.const nan:0x400000)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 161)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.neg
      (f32.const inf)
     )
     (f32.const nan:0x400000)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 162)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.const inf)
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 163)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $std/mod/test_fmodf
     (f32.const nan:0x400000)
     (f32.neg
      (f32.const inf)
     )
     (f32.const nan:0x400000)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 164)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:std/mod)
 )
)
