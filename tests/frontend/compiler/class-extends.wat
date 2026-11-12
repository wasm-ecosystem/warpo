(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32)))
 (type $3 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "test" (func $class-extends/test))
 (export "memory" (memory $0))
 (func $class-extends/A#get:a (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $class-extends/B#get:b (param $this i32) (result i32)
  (i32.load16_s offset=4
   (local.get $this)
  )
 )
 (func $class-extends/A#set:a (param $this i32) (param $a i32)
  (i32.store
   (local.get $this)
   (local.get $a)
  )
 )
 (func $class-extends/B#set:b (param $this i32) (param $b i32)
  (i32.store16 offset=4
   (local.get $this)
   (local.get $b)
  )
 )
 (func $class-extends/test (param $b i32)
  (drop
   (call $class-extends/A#get:a
    (call $~lib/rt/__tmptostack
     (local.get $b)
    )
   )
  )
  (drop
   (call $class-extends/B#get:b
    (call $~lib/rt/__tmptostack
     (local.get $b)
    )
   )
  )
  (call $class-extends/A#set:a
   (call $~lib/rt/__tmptostack
    (local.get $b)
   )
   (i32.const 2)
  )
  (call $class-extends/B#set:b
   (call $~lib/rt/__tmptostack
    (local.get $b)
   )
   (i32.const 3)
  )
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32) (param $2 i32)
  (memory.fill
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )
)
