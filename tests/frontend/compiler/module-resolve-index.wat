(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $node_modules/module-resolve-lib/as/test/v0 i32 (i32.const 1))
 (global $node_modules/module-resolve-lib/index/v i32 (i32.const 1))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:module-resolve-index
  (drop
   (i32.eq
    (global.get $node_modules/module-resolve-lib/index/v)
    (i32.const 1)
   )
  )
 )
 (func $~start
  (call $start:module-resolve-index)
 )
)
