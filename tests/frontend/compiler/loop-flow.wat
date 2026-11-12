(module
 (type $0 (func (result i32)))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func))
 (type $3 (func (param i32 i32 i32 i32)))
 (type $4 (func (param i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 92))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32860))
 (global $~lib/memory/__heap_base i32 (i32.const 32860))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\18\00\00\00l\00o\00o\00p\00-\00f\00l\00o\00w\00.\00t\00s\00\00\00\00\00")
 (data $1 (i32.const 60) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00t\00e\00r\00m\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "whileReturn" (func $loop-flow/whileReturn))
 (export "whileThrow" (func $loop-flow/whileThrow))
 (export "whileContinue" (func $loop-flow/whileContinue))
 (export "whileAny" (func $loop-flow/whileAny))
 (export "forReturn" (func $loop-flow/forReturn))
 (export "forThrow" (func $loop-flow/forThrow))
 (export "forContinue" (func $loop-flow/forContinue))
 (export "forAny" (func $loop-flow/forAny))
 (export "doReturn" (func $loop-flow/doReturn))
 (export "doThrow" (func $loop-flow/doThrow))
 (export "doAny" (func $loop-flow/doAny))
 (export "memory" (memory $0))
 (start $~start)
 (func $loop-flow/whileReturn (result i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.const 1)
     (then
      (return
       (i32.const 1)
      )
      (br $while-continue|0)
     )
    )
   )
   (unreachable)
  )
 )
 (func $loop-flow/whileAny (param $a i32) (result i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.const 1)
     (then
      (if
       (i32.eq
        (local.get $a)
        (i32.const 1)
       )
       (then
        (return
         (i32.const 1)
        )
       )
       (else
        (if
         (i32.eq
          (local.get $a)
          (i32.const 2)
         )
         (then
          (call $~lib/builtins/abort
           (i32.const 80)
           (i32.const 32)
           (i32.const 24)
           (i32.const 22)
          )
          (unreachable)
         )
         (else
          (br $while-continue|0)
         )
        )
       )
      )
      (br $while-continue|0)
     )
    )
   )
   (unreachable)
  )
 )
 (func $loop-flow/forReturn (result i32)
  (if
   (i32.const 1)
   (then
    (return
     (i32.const 1)
    )
   )
  )
  (unreachable)
 )
 (func $loop-flow/forAny (param $a i32) (result i32)
  (loop $for-loop|0
   (if
    (i32.const 1)
    (then
     (block $for-continue|0
      (if
       (i32.eq
        (local.get $a)
        (i32.const 1)
       )
       (then
        (return
         (i32.const 1)
        )
       )
       (else
        (if
         (i32.eq
          (local.get $a)
          (i32.const 2)
         )
         (then
          (call $~lib/builtins/abort
           (i32.const 80)
           (i32.const 32)
           (i32.const 54)
           (i32.const 22)
          )
          (unreachable)
         )
         (else
          (br $for-continue|0)
         )
        )
       )
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (unreachable)
 )
 (func $loop-flow/doReturn (result i32)
  (loop $do-loop|0
   (return
    (i32.const 1)
   )
   (unreachable)
  )
  (unreachable)
 )
 (func $loop-flow/doAny (param $a i32) (result i32)
  (loop $do-loop|0
   (block $do-continue|0
    (if
     (i32.eq
      (local.get $a)
      (i32.const 1)
     )
     (then
      (return
       (i32.const 1)
      )
     )
     (else
      (if
       (i32.eq
        (local.get $a)
        (i32.const 2)
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 80)
         (i32.const 32)
         (i32.const 78)
         (i32.const 22)
        )
        (unreachable)
       )
       (else
        (br $do-continue|0)
       )
      )
     )
    )
   )
   (br_if $do-loop|0
    (i32.const 1)
   )
  )
  (unreachable)
 )
 (func $start:loop-flow
  (if
   (i32.eqz
    (i32.eq
     (call $loop-flow/whileReturn)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 7)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $loop-flow/whileAny
      (i32.const 1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 29)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $loop-flow/forReturn)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 37)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $loop-flow/forAny
      (i32.const 1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 59)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $loop-flow/doReturn)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 67)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $loop-flow/doAny
      (i32.const 1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 83)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $loop-flow/whileThrow (result i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.const 1)
     (then
      (call $~lib/builtins/abort
       (i32.const 80)
       (i32.const 32)
       (i32.const 11)
       (i32.const 5)
      )
      (unreachable)
      (br $while-continue|0)
     )
    )
   )
   (unreachable)
  )
 )
 (func $loop-flow/whileContinue (result i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.const 1)
     (then
      (br $while-continue|0)
      (br $while-continue|0)
     )
    )
   )
   (unreachable)
  )
 )
 (func $loop-flow/forThrow (result i32)
  (if
   (i32.const 1)
   (then
    (call $~lib/builtins/abort
     (i32.const 80)
     (i32.const 32)
     (i32.const 41)
     (i32.const 5)
    )
    (unreachable)
   )
  )
  (unreachable)
 )
 (func $loop-flow/forContinue (result i32)
  (loop $for-loop|0
   (if
    (i32.const 1)
    (then
     (block $for-continue|0
      (br $for-continue|0)
     )
     (br $for-loop|0)
    )
   )
  )
  (unreachable)
 )
 (func $loop-flow/doThrow (result i32)
  (loop $do-loop|0
   (call $~lib/builtins/abort
    (i32.const 80)
    (i32.const 32)
    (i32.const 71)
    (i32.const 5)
   )
   (unreachable)
   (unreachable)
  )
  (unreachable)
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32) (param $2 i32)
  (memory.fill
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )
 (func $~start
  (call $start:loop-flow)
 )
)
