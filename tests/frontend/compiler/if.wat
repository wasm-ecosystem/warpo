(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 76))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32844))
 (global $~lib/memory/__heap_base i32 (i32.const 32844))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00i\00f\00.\00t\00s\00\00\00")
 (data $1 (i32.const 44) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00e\00r\00r\00o\00r\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "ifThenElse" (func $if/ifThenElse))
 (export "ifThen" (func $if/ifThen))
 (export "ifThenElseBlock" (func $if/ifThenElseBlock))
 (export "ifAlwaysReturns" (func $if/ifAlwaysReturns))
 (export "memory" (memory $0))
 (start $~start)
 (func $if/ifThenElse (param $n i32) (result i32)
  (if
   (local.get $n)
   (then
    (return
     (i32.const 1)
    )
   )
   (else
    (return
     (i32.const 0)
    )
   )
  )
 )
 (func $if/ifThen (param $n i32) (result i32)
  (if
   (local.get $n)
   (then
    (return
     (i32.const 1)
    )
   )
  )
  (return
   (i32.const 0)
  )
 )
 (func $if/ifThenElseBlock (param $n i32) (result i32)
  (if
   (local.get $n)
   (then
    (return
     (i32.const 1)
    )
   )
   (else
    (return
     (i32.const 0)
    )
   )
  )
 )
 (func $start:if
  (if
   (i32.eqz
    (i32.eq
     (call $if/ifThenElse
      (i32.const 0)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 6)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $if/ifThenElse
      (i32.const 1)
     )
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
     (call $if/ifThen
      (i32.const 0)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 14)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $if/ifThen
      (i32.const 1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 15)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $if/ifThenElseBlock
      (i32.const 0)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 27)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $if/ifThenElseBlock
      (i32.const 1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 28)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $if/ifAlwaysReturns (param $n i32) (result i32)
  (if
   (local.get $n)
   (then
    (return
     (i32.const 1)
    )
   )
   (else
    (call $~lib/builtins/abort
     (i32.const 64)
     (i32.const 32)
     (i32.const 32)
     (i32.const 8)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:if)
 )
)
