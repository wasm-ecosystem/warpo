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
 (export "testFor" (func $unify-local-flags/testFor))
 (export "testWhile" (func $unify-local-flags/testWhile))
 (export "testDo" (func $unify-local-flags/testDo))
 (export "memory" (memory $0))
 (func $unify-local-flags/testFor
  (local $x i32)
  (local $i i32)
  (local.set $x
   (i32.const 0)
  )
  (local.set $i
   (i32.const 0)
  )
  (loop $for-loop|0
   (if
    (i32.lt_u
     (local.get $i)
     (i32.const 255)
    )
    (then
     (local.set $x
      (local.get $i)
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
 )
 (func $unify-local-flags/testWhile
  (local $x i32)
  (local $i i32)
  (local.set $x
   (i32.const 0)
  )
  (local.set $i
   (i32.const 0)
  )
  (block $while-break|2
   (loop $while-continue|2
    (if
     (i32.lt_u
      (i32.and
       (local.get $i)
       (i32.const 255)
      )
      (i32.const 255)
     )
     (then
      (local.set $x
       (local.get $i)
      )
      (local.set $i
       (i32.add
        (local.get $i)
        (i32.const 1)
       )
      )
      (br $while-continue|2)
     )
    )
   )
  )
 )
 (func $unify-local-flags/testDo
  (local $x i32)
  (local $i i32)
  (local.set $x
   (i32.const 0)
  )
  (local.set $i
   (i32.const 0)
  )
  (loop $do-loop|2
   (local.set $x
    (local.get $i)
   )
   (br_if $do-loop|2
    (i32.lt_u
     (i32.and
      (local.tee $i
       (i32.add
        (local.get $i)
        (i32.const 1)
       )
      )
      (i32.const 255)
     )
     (i32.const 255)
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
