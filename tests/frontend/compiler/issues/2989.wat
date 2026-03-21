(module
 (type $0 (func (param i32)))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $issues/2989/value (mut i32) (i32.const 0))
 (global $issues/2989/fn (mut i32) (i32.const 32))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 124))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32892))
 (global $~lib/memory/__heap_base i32 (i32.const 32892))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 76) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00i\00s\00s\00u\00e\00s\00/\002\009\008\009\00.\00t\00s\00")
 (table $0 3 3 funcref)
 (elem $0 (i32.const 1) $issues/2989/logA $issues/2989/logB)
 (export "memory" (memory $0))
 (start $~start)
 (func $issues/2989/logA (param $x i32)
  (global.set $issues/2989/value
   (i32.const 100)
  )
 )
 (func $issues/2989/logB (param $x i32)
  (global.set $issues/2989/value
   (i32.const 200)
  )
 )
 (func $issues/2989/foo (param $x i32) (result i32)
  (global.set $issues/2989/fn
   (i32.const 64)
  )
  (return
   (local.get $x)
  )
 )
 (func $start:issues/2989
  (local $0 i32)
  (block
   (local.set $0
    (global.get $issues/2989/fn)
   )
   (call_indirect (type $0)
    (call $issues/2989/foo
     (i32.const 42)
    )
    (block (result i32)
     (call $~lib/rt/closure/setClosureEnv
      (i32.load offset=4
       (local.get $0)
      )
     )
     (global.set $~argumentsLength
      (i32.const 1)
     )
     (i32.load
      (local.get $0)
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $issues/2989/value)
     (i32.const 100)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 19)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:issues/2989)
 )
)
