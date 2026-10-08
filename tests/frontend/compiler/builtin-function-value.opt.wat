(module
 (type $0 (func (param i32 i32 f64 f64 f64 f64 f64)))
 (type $1 (func))
 (import "env" "trace" (func $~lib/builtins/trace (param i32 i32 f64 f64 f64 f64 f64)))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\04\00\00\00\08\00\00\00\01")
 (data $1 (i32.const 44) ",")
 (data $1.1 (i32.const 56) "\02\00\00\00\0e\00\00\00m\00e\00s\00s\00a\00g\00e")
 (export "memory" (memory $0))
 (start $~start)
 (func $~start
  i32.const 1
  global.set $~argumentsLength
  i32.const 64
  i32.const 0
  f64.const 0
  f64.const 0
  f64.const 0
  f64.const 0
  f64.const 0
  return_call $~lib/builtins/trace
 )
)
