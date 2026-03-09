(module
 (type $0 (func))
 (type $1 (func (param i32)))
 (type $2 (func (param i32) (result i32)))
 (type $3 (func (param i32 i32 i32) (result i32)))
 (type $4 (func (param i32 i32)))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $ternary/a (mut i32) (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 44))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32812))
 (global $~lib/memory/__heap_base i32 (i32.const 32812))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00a\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "test" (func $ternary/test))
 (export "testDropWithTypeMismatch" (func $ternary/testDropWithTypeMismatch))
 (export "testVoidInclTypeMismatch" (func $ternary/testVoidInclTypeMismatch))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:ternary
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (global.set $ternary/a
   (i32.const 1)
  )
  (global.set $ternary/a
   (i32.const 1)
  )
  (global.set $ternary/a
   (i32.const 1)
  )
 )
 (func $ternary/test (param $x i32) (param $y i32) (param $z i32) (result i32)
  (return
   (if (result i32)
    (local.get $x)
    (then
     (local.get $y)
    )
    (else
     (local.get $z)
    )
   )
  )
 )
 (func $ternary/testDropWithTypeMismatch (param $cond i32)
  (local $x i32)
  (local $y i32)
  (local.set $x
   (i32.const 1)
  )
  (local.set $y
   (call $~lib/rt/__localtostack
    (i32.const 32)
   )
  )
  (if
   (local.get $cond)
   (then
    (drop
     (local.get $x)
    )
   )
   (else
    (drop
     (local.get $y)
    )
   )
  )
 )
 (func $ternary/testVoidInclTypeMismatch (param $cond i32) (param $nop i32)
  (if
   (local.get $cond)
   (then
    (call_indirect (type $0)
     (block (result i32)
      (call $~lib/rt/closure/setClosureEnv
       (i32.load offset=4
        (local.get $nop)
       )
      )
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (i32.load
       (local.get $nop)
      )
     )
    )
   )
   (else
    (call_indirect (type $0)
     (block (result i32)
      (call $~lib/rt/closure/setClosureEnv
       (i32.load offset=4
        (local.get $nop)
       )
      )
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (i32.load
       (local.get $nop)
      )
     )
    )
   )
  )
  (if
   (local.get $cond)
   (then
    (call_indirect (type $0)
     (block (result i32)
      (call $~lib/rt/closure/setClosureEnv
       (i32.load offset=4
        (local.get $nop)
       )
      )
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (i32.load
       (local.get $nop)
      )
     )
    )
   )
   (else
    (drop
     (i32.const 1)
    )
   )
  )
  (if
   (local.get $cond)
   (then
    (drop
     (i32.const 1)
    )
   )
   (else
    (call_indirect (type $0)
     (block (result i32)
      (call $~lib/rt/closure/setClosureEnv
       (i32.load offset=4
        (local.get $nop)
       )
      )
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (i32.load
       (local.get $nop)
      )
     )
    )
   )
  )
 )
 (func $~start
  (call $start:ternary)
 )
)
