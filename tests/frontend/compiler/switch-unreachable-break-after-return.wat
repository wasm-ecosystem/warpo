(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "main" (func $switch-unreachable-break-after-return/main))
 (export "memory" (memory $0))
 (func $switch-unreachable-break-after-return/main (result i32)
  (local $0 i32)
  (block $break|0
   (block $case0|0
    (local.set $0
     (i32.const 1)
    )
    (br $case0|0)
   )
   (return
    (i32.const 1)
   )
  )
 )
)
