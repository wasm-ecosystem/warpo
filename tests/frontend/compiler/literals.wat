(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:literals
  (drop
   (i32.const 0)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 2)
  )
  (drop
   (i32.const 3)
  )
  (drop
   (i32.const 4)
  )
  (drop
   (i32.const 5)
  )
  (drop
   (i32.const 6)
  )
  (drop
   (i32.const 7)
  )
  (drop
   (i32.const 8)
  )
  (drop
   (i32.const 9)
  )
  (drop
   (i32.const 0)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 2)
  )
  (drop
   (i32.const 3)
  )
  (drop
   (i32.const 4)
  )
  (drop
   (i32.const 5)
  )
  (drop
   (i32.const 6)
  )
  (drop
   (i32.const 7)
  )
  (drop
   (i32.const 8)
  )
  (drop
   (i32.const 9)
  )
  (drop
   (i32.const 10)
  )
  (drop
   (i32.const 11)
  )
  (drop
   (i32.const 12)
  )
  (drop
   (i32.const 13)
  )
  (drop
   (i32.const 14)
  )
  (drop
   (i32.const 15)
  )
  (drop
   (i32.const 10)
  )
  (drop
   (i32.const 11)
  )
  (drop
   (i32.const 12)
  )
  (drop
   (i32.const 13)
  )
  (drop
   (i32.const 14)
  )
  (drop
   (i32.const 15)
  )
  (drop
   (i32.const 0)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 2)
  )
  (drop
   (i32.const 3)
  )
  (drop
   (i32.const 4)
  )
  (drop
   (i32.const 5)
  )
  (drop
   (i32.const 6)
  )
  (drop
   (i32.const 7)
  )
  (drop
   (i32.const 0)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const 0)
  )
  (drop
   (i64.const -9223372036854775808)
  )
  (drop
   (i64.const -9223372036854775808)
  )
  (drop
   (i64.const -9223372036854775808)
  )
  (drop
   (i64.const -9223372036854775808)
  )
  (drop
   (i32.const 0)
  )
  (drop
   (i64.const 0)
  )
  (drop
   (f64.const -0)
  )
  (drop
   (f32.const -0)
  )
  (drop
   (f64.const -0)
  )
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32) (param $2 i32)
  (memory.fill
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )
 (func $~start
  (call $start:literals)
 )
)
