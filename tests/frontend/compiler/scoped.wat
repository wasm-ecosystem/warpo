(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32)))
 (type $3 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $scoped/aGlobal (mut i32) (i32.const 1))
 (global $scoped/aConstant i32 (i32.const 3))
 (global $scoped/aStartFunctionLocal (mut i32) (i32.const 2))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $scoped/fn (param $c i32)
  (local $a i32)
  (local $b i32)
  (local.set $a
   (i32.const 0)
  )
  (local.set $b
   (local.get $c)
  )
 )
 (func $start:scoped
  (local $anotherStartFunctionLocal i32)
  (local $aGlobal i32)
  (local $aConstant i64)
  (local $aConstant|3 f32)
  (block
   (local.set $anotherStartFunctionLocal
    (i32.const 0)
   )
   (loop $for-loop|0
    (if
     (i32.lt_s
      (local.get $anotherStartFunctionLocal)
      (i32.const 1)
     )
     (then
      (nop)
      (local.set $anotherStartFunctionLocal
       (i32.add
        (local.get $anotherStartFunctionLocal)
        (i32.const 1)
       )
      )
      (br $for-loop|0)
     )
    )
   )
  )
  (block
   (local.set $aGlobal
    (i32.const 0)
   )
   (loop $for-loop|1
    (if
     (i32.lt_s
      (local.get $aGlobal)
      (i32.const 1)
     )
     (then
      (drop
       (local.get $aGlobal)
      )
      (local.set $aGlobal
       (i32.add
        (local.get $aGlobal)
        (i32.const 1)
       )
      )
      (br $for-loop|1)
     )
    )
   )
  )
  (block
   (local.set $aConstant
    (i64.const 5)
   )
   (local.set $aConstant|3
    (f32.const 10)
   )
  )
  (call $scoped/fn
   (i32.const 42)
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
  (call $start:scoped)
 )
)
