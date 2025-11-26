(module
 (type $0 (func (param i32 i32 i32 i32)))
 (type $1 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~started (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "<")
 (data $0.1 (i32.const 24) "\02\00\00\00$\00\00\00n\00o\00n\00t\00r\00a\00p\00p\00i\00n\00g\00-\00f\002\00i\00.\00t\00s")
 (export "memory" (memory $0))
 (export "_start" (func $~start))
 (func $~start
  global.get $~started
  i32.eqz
  if
   i32.const 1
   global.set $~started
   f32.const 3402823466385288598117041e14
   i32.trunc_f32_s
   i32.const 2147483647
   i32.ne
   if
    i32.const 0
    i32.const 32
    i32.const 2
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const -3402823466385288598117041e14
   i32.trunc_f32_s
   i32.const -2147483648
   i32.ne
   if
    i32.const 0
    i32.const 32
    i32.const 3
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const nan:0x400000
   i32.trunc_f32_s
   if
    i32.const 0
    i32.const 32
    i32.const 4
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const 3402823466385288598117041e14
   i64.trunc_f32_s
   i64.const 9223372036854775807
   i64.ne
   if
    i32.const 0
    i32.const 32
    i32.const 7
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const -3402823466385288598117041e14
   i64.trunc_f32_s
   i64.const -9223372036854775808
   i64.ne
   if
    i32.const 0
    i32.const 32
    i32.const 8
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const nan:0x400000
   i64.trunc_f32_s
   i64.eqz
   i32.eqz
   if
    i32.const 0
    i32.const 32
    i32.const 9
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const 3402823466385288598117041e14
   i32.trunc_f32_u
   i32.const -1
   i32.ne
   if
    i32.const 0
    i32.const 32
    i32.const 12
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const -3402823466385288598117041e14
   i32.trunc_f32_u
   if
    i32.const 0
    i32.const 32
    i32.const 13
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const nan:0x400000
   i32.trunc_f32_u
   if
    i32.const 0
    i32.const 32
    i32.const 14
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const 3402823466385288598117041e14
   i64.trunc_f32_u
   i64.const -1
   i64.ne
   if
    i32.const 0
    i32.const 32
    i32.const 17
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const -3402823466385288598117041e14
   i64.trunc_f32_u
   i64.const 0
   i64.ne
   if
    i32.const 0
    i32.const 32
    i32.const 18
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f32.const nan:0x400000
   i64.trunc_f32_u
   i64.eqz
   i32.eqz
   if
    i32.const 0
    i32.const 32
    i32.const 19
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const 1797693134862315708145274e284
   i32.trunc_f64_s
   i32.const 2147483647
   i32.ne
   if
    i32.const 0
    i32.const 32
    i32.const 22
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const -1797693134862315708145274e284
   i32.trunc_f64_s
   i32.const -2147483648
   i32.ne
   if
    i32.const 0
    i32.const 32
    i32.const 23
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const nan:0x8000000000000
   i32.trunc_f64_s
   if
    i32.const 0
    i32.const 32
    i32.const 24
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const 1797693134862315708145274e284
   i64.trunc_f64_s
   i64.const 9223372036854775807
   i64.ne
   if
    i32.const 0
    i32.const 32
    i32.const 27
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const -1797693134862315708145274e284
   i64.trunc_f64_s
   i64.const -9223372036854775808
   i64.ne
   if
    i32.const 0
    i32.const 32
    i32.const 28
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const nan:0x8000000000000
   i64.trunc_f64_s
   i64.eqz
   i32.eqz
   if
    i32.const 0
    i32.const 32
    i32.const 29
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const 1797693134862315708145274e284
   i32.trunc_f64_u
   i32.const -1
   i32.ne
   if
    i32.const 0
    i32.const 32
    i32.const 32
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const -1797693134862315708145274e284
   i32.trunc_f64_u
   if
    i32.const 0
    i32.const 32
    i32.const 33
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const nan:0x8000000000000
   i32.trunc_f64_u
   if
    i32.const 0
    i32.const 32
    i32.const 34
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const 1797693134862315708145274e284
   i64.trunc_f64_u
   i64.const -1
   i64.ne
   if
    i32.const 0
    i32.const 32
    i32.const 37
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const -1797693134862315708145274e284
   i64.trunc_f64_u
   i64.const 0
   i64.ne
   if
    i32.const 0
    i32.const 32
    i32.const 38
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   f64.const nan:0x8000000000000
   i64.trunc_f64_u
   i64.eqz
   i32.eqz
   if
    i32.const 0
    i32.const 32
    i32.const 39
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
  end
 )
)
