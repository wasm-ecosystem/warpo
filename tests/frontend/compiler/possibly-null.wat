(module
 (type $0 (func (param i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32) (result i32)))
 (type $3 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "testTrue" (func $possibly-null/testTrue))
 (export "testFalseElse" (func $possibly-null/testFalseElse))
 (export "testFalseContinuation" (func $possibly-null/testFalseContinuation))
 (export "testNeNull" (func $possibly-null/testNeNull))
 (export "testEqNullElse" (func $possibly-null/testEqNullElse))
 (export "testEqNullContinuation" (func $possibly-null/testEqNullContinuation))
 (export "testNotEqNull" (func $possibly-null/testNotEqNull))
 (export "testNotNeNullElse" (func $possibly-null/testNotNeNullElse))
 (export "testNotNeNullContinuation" (func $possibly-null/testNotNeNullContinuation))
 (export "testWhile" (func $possibly-null/testWhile))
 (export "testWhile2" (func $possibly-null/testWhile2))
 (export "testWhile3" (func $possibly-null/testWhile3))
 (export "testLogicalAnd" (func $possibly-null/testLogicalAnd))
 (export "testLogicalOr" (func $possibly-null/testLogicalOr))
 (export "testLogicalAndMulti" (func $possibly-null/testLogicalAndMulti))
 (export "testLogicalOrMulti" (func $possibly-null/testLogicalOrMulti))
 (export "testAssign" (func $possibly-null/testAssign))
 (export "testNeverNull" (func $possibly-null/testNeverNull))
 (export "memory" (memory $0))
 (func $possibly-null/testTrue (param $a i32)
  (if
   (local.get $a)
   (then
    (drop
     (i32.const 0)
    )
   )
  )
 )
 (func $possibly-null/testFalseElse (param $a i32)
  (if
   (i32.eqz
    (local.get $a)
   )
   (then
    (return)
   )
   (else
    (drop
     (i32.const 0)
    )
   )
  )
 )
 (func $possibly-null/testFalseContinuation (param $a i32)
  (if
   (i32.eqz
    (local.get $a)
   )
   (then
    (return)
   )
  )
  (drop
   (i32.const 0)
  )
 )
 (func $possibly-null/testNeNull (param $a i32)
  (if
   (i32.ne
    (local.get $a)
    (i32.const 0)
   )
   (then
    (drop
     (i32.const 0)
    )
   )
  )
 )
 (func $possibly-null/testEqNullElse (param $a i32)
  (if
   (i32.eq
    (local.get $a)
    (i32.const 0)
   )
   (then
    (return)
   )
   (else
    (drop
     (i32.const 0)
    )
   )
  )
 )
 (func $possibly-null/testEqNullContinuation (param $a i32)
  (if
   (i32.eq
    (local.get $a)
    (i32.const 0)
   )
   (then
    (return)
   )
  )
  (drop
   (i32.const 0)
  )
 )
 (func $possibly-null/testNotEqNull (param $a i32)
  (if
   (i32.eqz
    (i32.eq
     (local.get $a)
     (i32.const 0)
    )
   )
   (then
    (drop
     (i32.const 0)
    )
   )
  )
 )
 (func $possibly-null/testNotNeNullElse (param $a i32)
  (if
   (i32.eqz
    (i32.ne
     (local.get $a)
     (i32.const 0)
    )
   )
   (then
    (return)
   )
   (else
    (drop
     (i32.const 0)
    )
   )
  )
 )
 (func $possibly-null/testNotNeNullContinuation (param $a i32)
  (if
   (i32.eqz
    (i32.ne
     (local.get $a)
     (i32.const 0)
    )
   )
   (then
    (return)
   )
  )
  (drop
   (i32.const 0)
  )
 )
 (func $possibly-null/testWhile (param $a i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (local.get $a)
     (then
      (drop
       (i32.const 0)
      )
      (local.set $a
       (call $~lib/rt/__localtostack
        (i32.const 0)
       )
      )
      (drop
       (i32.eqz
        (i32.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
 )
 (func $possibly-null/testWhile2 (param $a i32) (param $b i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (local.get $a)
     (then
      (drop
       (i32.const 0)
      )
      (local.set $a
       (call $~lib/rt/__localtostack
        (local.get $b)
       )
      )
      (drop
       (i32.eqz
        (i32.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
 )
 (func $possibly-null/testWhile3 (param $a i32) (param $b i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (local.get $a)
     (then
      (drop
       (i32.const 0)
      )
      (if
       (local.get $b)
       (then
        (local.set $a
         (call $~lib/rt/__localtostack
          (local.get $b)
         )
        )
        (drop
         (i32.const 0)
        )
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
 )
 (func $possibly-null/requireNonNull (param $a i32) (result i32)
  (return
   (local.get $a)
  )
 )
 (func $possibly-null/testLogicalAnd (param $a i32)
  (drop
   (if (result i32)
    (local.get $a)
    (then
     (call $possibly-null/requireNonNull
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
    )
    (else
     (i32.const 0)
    )
   )
  )
 )
 (func $possibly-null/testLogicalOr (param $a i32)
  (drop
   (if (result i32)
    (i32.eqz
     (local.get $a)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.ne
      (call $possibly-null/requireNonNull
       (call $~lib/rt/__tmptostack
        (local.get $a)
       )
      )
      (i32.const 0)
     )
    )
   )
  )
 )
 (func $possibly-null/testLogicalAndMulti (param $a i32) (param $b i32)
  (if
   (if (result i32)
    (local.get $a)
    (then
     (local.get $b)
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (drop
     (i32.const 0)
    )
    (drop
     (i32.const 0)
    )
   )
   (else
    (drop
     (i32.eqz
      (i32.const 1)
     )
    )
    (drop
     (i32.eqz
      (i32.const 1)
     )
    )
   )
  )
 )
 (func $possibly-null/testLogicalOrMulti (param $a i32) (param $b i32)
  (if
   (if (result i32)
    (i32.eqz
     (local.get $a)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.eqz
      (local.get $b)
     )
    )
   )
   (then
    (drop
     (i32.eqz
      (i32.const 1)
     )
    )
    (drop
     (i32.eqz
      (i32.const 1)
     )
    )
   )
   (else
    (drop
     (i32.const 0)
    )
    (drop
     (i32.const 0)
    )
   )
  )
 )
 (func $possibly-null/testAssign (param $a i32) (param $b i32)
  (local.set $a
   (call $~lib/rt/__localtostack
    (local.get $b)
   )
  )
  (drop
   (i32.const 0)
  )
 )
 (func $possibly-null/testNeverNull (param $a i32)
  (if
   (local.get $a)
   (then
    (drop
     (local.get $a)
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
