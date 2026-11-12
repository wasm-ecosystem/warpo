(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/a/index/a i32 (i32.const 1))
 (global $~lib/c/index/c i32 (i32.const 3))
 (global $~lib/b/index/b i32 (i32.const 2))
 (global $~lib/a/other/a_other i32 (i32.const 11))
 (global $~lib/b/other/b_other i32 (i32.const 22))
 (global $~lib/b/other/index/b_other_index i32 (i32.const 222))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:~lib/c/index
  (drop
   (i32.eq
    (global.get $~lib/a/index/a)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/b/index/b)
    (i32.const 2)
   )
  )
 )
 (func $start:~lib/a/index
  (call $start:~lib/c/index)
  (drop
   (i32.eq
    (global.get $~lib/c/index/c)
    (i32.const 3)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/b/index/b)
    (i32.const 2)
   )
  )
 )
 (func $start:~lib/_/index
  (call $start:~lib/a/index)
  (drop
   (i32.eq
    (global.get $~lib/a/index/a)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/a/index/a)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/a/index/a)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/a/other/a_other)
    (i32.const 11)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/b/index/b)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/b/index/b)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/b/index/b)
    (i32.const 2)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/b/other/b_other)
    (i32.const 22)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/b/other/index/b_other_index)
    (i32.const 222)
   )
  )
  (drop
   (i32.eq
    (global.get $~lib/b/other/index/b_other_index)
    (i32.const 222)
   )
  )
 )
 (func $start:packages
  (call $start:~lib/_/index)
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32) (param $2 i32)
  (memory.fill
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )
 (func $~start
  (call $start:packages)
 )
)
