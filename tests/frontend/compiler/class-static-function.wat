(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (result i32)))
 (type $2 (func))
 (type $3 (func (param i32)))
 (type $4 (func (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 124))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32892))
 (global $~lib/memory/__heap_base i32 (i32.const 32892))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\000\00\00\00c\00l\00a\00s\00s\00-\00s\00t\00a\00t\00i\00c\00-\00f\00u\00n\00c\00t\00i\00o\00n\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $class-static-function/Example.staticFunc)
 (export "memory" (memory $0))
 (start $~start)
 (func $class-static-function/Example.staticFunc (result i32)
  (return
   (i32.const 42)
  )
 )
 (func $class-static-function/call (param $func i32) (result i32)
  (return
   (call_indirect (type $1)
    (block (result i32)
     (call $~lib/rt/closure/setClosureEnv
      (i32.load offset=4
       (local.get $func)
      )
     )
     (global.set $~argumentsLength
      (i32.const 0)
     )
     (i32.load
      (local.get $func)
     )
    )
   )
  )
 )
 (func $start:class-static-function
  (if
   (i32.eqz
    (i32.eq
     (call $class-static-function/call
      (call $~lib/rt/__tmptostack
       (i32.const 32)
      )
     )
     (i32.const 42)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 11)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:class-static-function)
 )
)
