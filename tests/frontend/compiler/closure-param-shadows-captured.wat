(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 140))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32908))
 (global $~lib/memory/__heap_base i32 (i32.const 32908))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "\\\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00B\00\00\00c\00l\00o\00s\00u\00r\00e\00-\00p\00a\00r\00a\00m\00-\00s\00h\00a\00d\00o\00w\00s\00-\00c\00a\00p\00t\00u\00r\00e\00d\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $closure-param-shadows-captured/test~inner)
 (export "test" (func $closure-param-shadows-captured/test))
 (export "memory" (memory $0))
 (func $closure-param-shadows-captured/test~inner (param $x i32) (result i32)
  (return
   (local.get $x)
  )
 )
 (func $closure-param-shadows-captured/test
  (local $x i32)
  (local $inner i32)
  (local.set $x
   (i32.const 0)
  )
  (drop
   (local.tee $inner
    (call $~lib/rt/__localtostack
     (i32.const 32)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call_indirect (type $0)
      (i32.const 1)
      (block (result i32)
       (call $~lib/rt/closure/setClosureEnv
        (i32.load offset=4
         (local.get $inner)
        )
       )
       (global.set $~argumentsLength
        (i32.const 1)
       )
       (i32.load
        (local.get $inner)
       )
      )
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 8)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call_indirect (type $0)
      (i32.const 42)
      (block (result i32)
       (call $~lib/rt/closure/setClosureEnv
        (i32.load offset=4
         (local.get $inner)
        )
       )
       (global.set $~argumentsLength
        (i32.const 1)
       )
       (i32.load
        (local.get $inner)
       )
      )
     )
     (i32.const 42)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 9)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
)
