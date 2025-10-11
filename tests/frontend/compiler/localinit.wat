(module
 (type $0 (func))
 (type $1 (func (param i32)))
 (type $2 (func (param i32) (result i32)))
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
 (func $localinit/initInIf
  (local $a i32)
  (drop
   (i32.gt_s
    (local.tee $a
     (i32.const 1)
    )
    (i32.const 0)
   )
  )
  (drop
   (local.get $a)
  )
  (drop
   (local.get $a)
  )
 )
 (func $localinit/initInIfElse
  (local $a i32)
  (drop
   (i32.gt_s
    (local.tee $a
     (i32.const 1)
    )
    (i32.const 0)
   )
  )
  (drop
   (local.get $a)
  )
  (drop
   (local.get $a)
  )
 )
 (func $localinit/initInIfAnd (param $cond i32)
  (local $a i32)
  (local $b i32)
  (if
   (if (result i32)
    (if (result i32)
     (local.get $cond)
     (then
      (local.tee $a
       (i32.const 0)
      )
     )
     (else
      (i32.const 0)
     )
    )
    (then
     (local.tee $b
      (i32.const 0)
     )
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (drop
     (local.get $a)
    )
    (drop
     (local.get $b)
    )
   )
  )
 )
 (func $localinit/initInIfOr (param $cond i32)
  (local $a i32)
  (local $b i32)
  (if
   (if (result i32)
    (if (result i32)
     (local.get $cond)
     (then
      (i32.const 1)
     )
     (else
      (local.tee $a
       (i32.const 0)
      )
     )
    )
    (then
     (i32.const 1)
    )
    (else
     (local.tee $b
      (i32.const 0)
     )
    )
   )
   (then
    (return)
   )
  )
  (drop
   (local.get $a)
  )
  (drop
   (local.get $b)
  )
 )
 (func $localinit/initInDo (param $cond i32)
  (local $a i32)
  (loop $do-loop|0
   (local.set $a
    (i32.const 1)
   )
   (br_if $do-loop|0
    (local.get $cond)
   )
  )
  (drop
   (local.get $a)
  )
 )
 (func $localinit/initInWhile
  (local $a i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (local.tee $a
      (i32.const 1)
     )
     (then
      (drop
       (local.get $a)
      )
      (br $while-break|0)
      (br $while-continue|0)
     )
    )
   )
  )
  (drop
   (local.get $a)
  )
 )
 (func $localinit/initInWhileAnd (param $cond i32)
  (local $a i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (if (result i32)
      (local.get $cond)
      (then
       (local.tee $a
        (i32.const 0)
       )
      )
      (else
       (i32.const 0)
      )
     )
     (then
      (drop
       (local.get $a)
      )
      (br $while-continue|0)
     )
    )
   )
  )
 )
 (func $localinit/initInWhileOr (param $cond i32)
  (local $a i32)
  (local $b i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (if (result i32)
      (if (result i32)
       (local.get $cond)
       (then
        (i32.const 1)
       )
       (else
        (local.tee $a
         (i32.const 1)
        )
       )
      )
      (then
       (i32.const 1)
      )
      (else
       (local.tee $b
        (i32.const 1)
       )
      )
     )
     (then
      (return)
      (br $while-continue|0)
     )
    )
   )
  )
  (drop
   (local.get $a)
  )
  (drop
   (local.get $b)
  )
 )
 (func $start:localinit
  (call $localinit/initInIf)
  (call $localinit/initInIfElse)
  (call $localinit/initInIfAnd
   (i32.const 1)
  )
  (call $localinit/initInIfOr
   (i32.const 1)
  )
  (call $localinit/initInDo
   (i32.const 0)
  )
  (call $localinit/initInWhile)
  (call $localinit/initInWhileAnd
   (i32.const 1)
  )
  (call $localinit/initInWhileOr
   (i32.const 1)
  )
 )
 (func $~start
  (call $start:localinit)
 )
)
