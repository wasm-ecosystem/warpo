(module
 (type $0 (func (result i32)))
 (type $1 (func))
 (type $2 (func (param i32) (result i32)))
 (type $3 (func (param i32 i32 i32 i32)))
 (type $4 (func (param i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $abi/condition (mut i32) (i32.const 0))
 (global $abi/y (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 44))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32812))
 (global $~lib/memory/__heap_base i32 (i32.const 32812))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00a\00b\00i\00.\00t\00s\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "exported" (func $abi/exported))
 (export "exportedExported" (func $abi/exportedExported))
 (export "exportedInternal" (func $abi/exportedInternal))
 (export "memory" (memory $0))
 (start $~start)
 (func $abi/internal (result i32)
  (return
   (i32.const 128)
  )
 )
 (func $start:abi
  (local $x i32)
  (local $x|1 i32)
  (local $x|2 i32)
  (local $b i32)
  (local $x|4 i32)
  (drop
   (call $abi/internal)
  )
  (global.set $abi/condition
   (i32.eqz
    (i32.const 0)
   )
  )
  (block
   (local.set $x
    (i32.const 256)
   )
   (if
    (i32.eqz
     (i32.eqz
      (i32.extend8_s
       (local.get $x)
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 32)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $x|1
    (i32.const 256)
   )
   (if
    (global.get $abi/condition)
    (then
     (local.set $x|1
      (i32.div_s
       (i32.extend8_s
        (local.get $x|1)
       )
       (i32.const 2)
      )
     )
    )
    (else
     (local.set $x|1
      (i32.div_s
       (i32.extend8_s
        (local.get $x|1)
       )
       (i32.const 2)
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eqz
      (i32.extend8_s
       (local.get $x|1)
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 45)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $x|2
    (i32.const 256)
   )
   (if
    (global.get $abi/condition)
    (then
     (local.set $x|2
      (i32.shr_s
       (i32.extend8_s
        (local.get $x|2)
       )
       (i32.and
        (i32.const 24)
        (i32.const 7)
       )
      )
     )
    )
    (else
     (local.set $x|2
      (i32.and
       (local.get $x|2)
       (i32.const 127)
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eqz
      (local.get $x|2)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 58)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (global.set $abi/y
    (i32.extend8_s
     (i32.const 256)
    )
   )
   (if
    (i32.eqz
     (i32.eqz
      (global.get $abi/y)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 65)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $b
    (i32.ctz
     (i32.const 2)
    )
   )
   (if
    (i32.eqz
     (i32.ne
      (local.get $b)
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 72)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $b
    (i32.clz
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (i32.ne
      (local.get $b)
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 74)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $x|4
    (i32.ctz
     (i32.const 2)
    )
   )
   (if
    (i32.eqz
     (local.get $x|4)
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 77)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $x|4
    (i32.clz
     (i32.const 1)
    )
   )
   (if
    (i32.eqz
     (local.get $x|4)
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 32)
      (i32.const 79)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
 )
 (func $abi/exported (result i32)
  (return
   (i32.extend8_s
    (i32.const 128)
   )
  )
 )
 (func $abi/exportedExported (result i32)
  (return
   (call $abi/exported)
  )
 )
 (func $abi/exportedInternal (result i32)
  (return
   (i32.extend8_s
    (call $abi/internal)
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
 (func $~start
  (call $start:abi)
 )
)
