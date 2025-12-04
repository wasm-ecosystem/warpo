(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:rt/ids
  (drop
   (i32.eq
    (i32.const 0)
    (i32.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.const 1)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (i32.const 2)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (i32.const 3)
    (i32.const 3)
   )
  )
 )
 (func $~start
  (call $start:rt/ids)
 )
)
