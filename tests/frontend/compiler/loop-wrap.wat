(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
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
 (export "testAlwaysWrapped" (func $loop-wrap/testAlwaysWrapped))
 (export "testFirstWrapped" (func $loop-wrap/testFirstWrapped))
 (export "testSubsequentWrapped" (func $loop-wrap/testSubsequentWrapped))
 (export "memory" (memory $0))
 (func $loop-wrap/testAlwaysWrapped
  (local $i i32)
  (local.set $i
   (i32.const 0)
  )
  (block $do-break|0
   (loop $do-loop|0
    (if
     (i32.eq
      (local.get $i)
      (i32.const 10)
     )
     (then
      (br $do-break|0)
     )
    )
    (br_if $do-loop|0
     (local.tee $i
      (i32.and
       (i32.add
        (local.get $i)
        (i32.const 1)
       )
       (i32.const 255)
      )
     )
    )
   )
  )
 )
 (func $loop-wrap/testFirstWrapped
  (local $i i32)
  (local.set $i
   (i32.const 0)
  )
  (block $do-break|1
   (loop $do-loop|1
    (if
     (i32.eq
      (i32.and
       (local.get $i)
       (i32.const 255)
      )
      (i32.const 10)
     )
     (then
      (br $do-break|1)
     )
    )
    (br_if $do-loop|1
     (i32.and
      (local.tee $i
       (i32.add
        (local.get $i)
        (i32.const 1)
       )
      )
      (i32.const 255)
     )
    )
   )
  )
 )
 (func $loop-wrap/testSubsequentWrapped (param $a i32)
  (local $i i32)
  (local.set $i
   (local.get $a)
  )
  (block $do-break|0
   (loop $do-loop|0
    (if
     (i32.eq
      (i32.and
       (local.get $i)
       (i32.const 255)
      )
      (i32.const 10)
     )
     (then
      (br $do-break|0)
     )
    )
    (br_if $do-loop|0
     (local.tee $i
      (i32.and
       (i32.add
        (local.get $i)
        (i32.const 1)
       )
       (i32.const 255)
      )
     )
    )
   )
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
