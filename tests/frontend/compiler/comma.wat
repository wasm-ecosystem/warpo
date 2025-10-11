(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $comma/a (mut i32) (i32.const 0))
 (global $comma/b (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00c\00o\00m\00m\00a\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:comma
  (local $0 i32)
  (local $c i32)
  (block
   (global.set $comma/b
    (block (result i32)
     (global.set $comma/a
      (i32.add
       (local.tee $0
        (global.get $comma/a)
       )
       (i32.const 1)
      )
     )
     (local.get $0)
    )
   )
   (drop
    (global.get $comma/a)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $comma/a)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 5)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $comma/b)
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
  (block
   (global.set $comma/a
    (i32.add
     (global.get $comma/a)
     (i32.const 1)
    )
   )
   (global.set $comma/b
    (global.get $comma/a)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $comma/a)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 9)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $comma/b)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 10)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $comma/a
   (block (result i32)
    (global.set $comma/b
     (i32.const 0)
    )
    (global.get $comma/b)
   )
  )
  (global.set $comma/b
   (block (result i32)
    (global.set $comma/a
     (i32.add
      (global.get $comma/a)
      (i32.const 1)
     )
    )
    (global.get $comma/a)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $comma/a)
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
     (global.get $comma/b)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 16)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $comma/a
   (block (result i32)
    (global.set $comma/a
     (i32.add
      (global.get $comma/a)
      (i32.const 1)
     )
    )
    (block (result i32)
     (global.set $comma/b
      (global.get $comma/a)
     )
     (global.get $comma/b)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $comma/a)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 19)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $comma/b)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 20)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (block
   (local.set $c
    (i32.const 0)
   )
   (loop $for-loop|0
    (if
     (i32.lt_s
      (local.get $c)
      (global.get $comma/a)
     )
     (then
      (nop)
      (block
       (global.set $comma/a
        (i32.sub
         (global.get $comma/a)
         (i32.const 1)
        )
       )
       (local.set $c
        (i32.add
         (local.get $c)
         (i32.const 1)
        )
       )
      )
      (br $for-loop|0)
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (local.get $c)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (block
   (drop
    (i32.const 1)
   )
   (drop
    (i32.const 2)
   )
   (drop
    (i32.const 3)
   )
  )
 )
 (func $~start
  (call $start:comma)
 )
)
