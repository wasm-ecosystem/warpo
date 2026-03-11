(module
 (type $0 (func (param i32 i32 i32) (result i32)))
 (type $1 (func))
 (type $2 (func (param i32) (result i32)))
 (type $3 (func (param i32 i32 i32 i32)))
 (type $4 (func (param i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $call-optional/optIndirect (mut i32) (i32.const 96))
 (global $~lib/memory/__data_end i32 (i32.const 108))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32876))
 (global $~lib/memory/__heap_base i32 (i32.const 32876))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00c\00a\00l\00l\00-\00o\00p\00t\00i\00o\00n\00a\00l\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 76) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $call-optional/opt@varargs)
 (export "memory" (memory $0))
 (start $~start)
 (func $call-optional/opt (param $a i32) (param $b i32) (param $c i32) (result i32)
  (return
   (i32.add
    (i32.add
     (local.get $a)
     (local.get $b)
    )
    (local.get $c)
   )
  )
 )
 (func $call-optional/opt@varargs (param $a i32) (param $b i32) (param $c i32) (result i32)
  (block $2of2
   (block $1of2
    (block $0of2
     (block $outOfRange
      (br_table $0of2 $1of2 $2of2 $outOfRange
       (i32.sub
        (global.get $~argumentsLength)
        (i32.const 1)
       )
      )
     )
     (unreachable)
    )
    (local.set $b
     (i32.const -1)
    )
   )
   (local.set $c
    (i32.const -2)
   )
  )
  (call $call-optional/opt
   (local.get $a)
   (local.get $b)
   (local.get $c)
  )
 )
 (func $start:call-optional
  (if
   (i32.eqz
    (i32.eq
     (call $call-optional/opt@varargs
      (i32.const 3)
      (i32.const 0)
      (block (result i32)
       (global.set $~argumentsLength
        (i32.const 1)
       )
       (i32.const 0)
      )
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
     (call $call-optional/opt@varargs
      (i32.const 3)
      (i32.const 4)
      (block (result i32)
       (global.set $~argumentsLength
        (i32.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 5)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $call-optional/opt
      (i32.const 3)
      (i32.const 4)
      (i32.const 5)
     )
     (i32.const 12)
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
     (call_indirect (type $0)
      (i32.const 3)
      (i32.const 0)
      (i32.const 0)
      (block (result i32)
       (call $~lib/rt/closure/setClosureEnv
        (i32.load offset=4
         (global.get $call-optional/optIndirect)
        )
       )
       (global.set $~argumentsLength
        (i32.const 1)
       )
       (i32.load
        (global.get $call-optional/optIndirect)
       )
      )
     )
     (i32.const 0)
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
     (call_indirect (type $0)
      (i32.const 3)
      (i32.const 4)
      (i32.const 0)
      (block (result i32)
       (call $~lib/rt/closure/setClosureEnv
        (i32.load offset=4
         (global.get $call-optional/optIndirect)
        )
       )
       (global.set $~argumentsLength
        (i32.const 2)
       )
       (i32.load
        (global.get $call-optional/optIndirect)
       )
      )
     )
     (i32.const 5)
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
  (if
   (i32.eqz
    (i32.eq
     (call_indirect (type $0)
      (i32.const 3)
      (i32.const 4)
      (i32.const 5)
      (block (result i32)
       (call $~lib/rt/closure/setClosureEnv
        (i32.load offset=4
         (global.get $call-optional/optIndirect)
        )
       )
       (global.set $~argumentsLength
        (i32.const 3)
       )
       (i32.load
        (global.get $call-optional/optIndirect)
       )
      )
     )
     (i32.const 12)
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
 )
 (func $~start
  (call $start:call-optional)
 )
)
