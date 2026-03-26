(module
 (type $0 (func (result i32)))
 (type $1 (func))
 (type $2 (func (param i32) (result i32)))
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
 (data $1 (i32.const 44) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00<\00\00\00c\00l\00o\00s\00u\00r\00e\00-\00l\00o\00c\00a\00l\00-\00s\00h\00a\00d\00o\00w\00s\00-\00o\00u\00t\00e\00r\00.\00t\00s\00")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $closure-local-shadows-outer/test~inner)
 (export "test" (func $closure-local-shadows-outer/test))
 (export "memory" (memory $0))
 (start $~start)
 (func $closure-local-shadows-outer/test~inner (result i32)
  (local $x i32)
  (local.set $x
   (i32.const 10)
  )
  (return
   (local.get $x)
  )
 )
 (func $closure-local-shadows-outer/test (result i32)
  (local $x i32)
  (local $inner i32)
  (local.set $x
   (i32.const 42)
  )
  (drop
   (local.tee $inner
    (call $~lib/rt/__localtostack
     (i32.const 32)
    )
   )
  )
  (return
   (call_indirect (type $0)
    (block (result i32)
     (call $~lib/rt/closure/setClosureEnv
      (i32.load offset=4
       (local.get $inner)
      )
     )
     (global.set $~argumentsLength
      (i32.const 0)
     )
     (i32.load
      (local.get $inner)
     )
    )
   )
  )
 )
 (func $start:closure-local-shadows-outer
  (if
   (i32.eqz
    (i32.eq
     (call $closure-local-shadows-outer/test)
     (i32.const 10)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 14)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:closure-local-shadows-outer)
 )
)
