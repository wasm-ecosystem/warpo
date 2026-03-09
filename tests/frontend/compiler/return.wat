(module
 (type $0 (func))
 (type $1 (func (param i32)))
 (type $2 (func (param i32) (result i32)))
 (type $3 (func (param i32 i32)))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 44))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32812))
 (global $~lib/memory/__heap_base i32 (i32.const 32812))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $start:return~anonymous|0)
 (export "testVoidReturn" (func $return/testVoidReturn))
 (export "testVoidReturnFunction" (func $return/testVoidReturnFunction))
 (export "memory" (memory $0))
 (start $~start)
 (func $return/nop
  (nop)
 )
 (func $start:return~anonymous|0
  (call $return/nop)
 )
 (func $return/testVoidReturnFunction (param $cond i32) (param $fn i32)
  (if
   (local.get $cond)
   (then
    (call_indirect (type $0)
     (block (result i32)
      (call $~lib/rt/closure/setClosureEnv
       (i32.load offset=4
        (local.get $fn)
       )
      )
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (i32.load
       (local.get $fn)
      )
     )
    )
    (return)
   )
  )
  (call_indirect (type $0)
   (block (result i32)
    (call $~lib/rt/closure/setClosureEnv
     (i32.load offset=4
      (local.get $fn)
     )
    )
    (global.set $~argumentsLength
     (i32.const 0)
    )
    (i32.load
     (local.get $fn)
    )
   )
  )
  (return)
 )
 (func $start:return
  (call $return/testVoidReturnFunction
   (i32.const 1)
   (call $~lib/rt/__tmptostack
    (i32.const 32)
   )
  )
 )
 (func $return/testVoidReturn (param $cond i32)
  (if
   (local.get $cond)
   (then
    (call $return/nop)
    (return)
   )
  )
  (call $return/nop)
  (return)
 )
 (func $~start
  (call $start:return)
 )
)
