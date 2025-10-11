(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $memset/dest (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00m\00e\00m\00s\00e\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $memset/memset (param $dest i32) (param $c i32) (param $n i32) (result i32)
  (local $ret i32)
  (local $k i32)
  (local $c32 i32)
  (local $c64 i64)
  (local.set $ret
   (local.get $dest)
  )
  (if
   (i32.eqz
    (local.get $n)
   )
   (then
    (return
     (local.get $ret)
    )
   )
  )
  (i32.store8
   (local.get $dest)
   (local.get $c)
  )
  (i32.store8
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 1)
   )
   (local.get $c)
  )
  (if
   (i32.le_u
    (local.get $n)
    (i32.const 2)
   )
   (then
    (return
     (local.get $ret)
    )
   )
  )
  (i32.store8
   (i32.add
    (local.get $dest)
    (i32.const 1)
   )
   (local.get $c)
  )
  (i32.store8
   (i32.add
    (local.get $dest)
    (i32.const 2)
   )
   (local.get $c)
  )
  (i32.store8
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 2)
   )
   (local.get $c)
  )
  (i32.store8
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 3)
   )
   (local.get $c)
  )
  (if
   (i32.le_u
    (local.get $n)
    (i32.const 6)
   )
   (then
    (return
     (local.get $ret)
    )
   )
  )
  (i32.store8
   (i32.add
    (local.get $dest)
    (i32.const 3)
   )
   (local.get $c)
  )
  (i32.store8
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 4)
   )
   (local.get $c)
  )
  (if
   (i32.le_u
    (local.get $n)
    (i32.const 8)
   )
   (then
    (return
     (local.get $ret)
    )
   )
  )
  (local.set $k
   (i32.and
    (i32.sub
     (i32.const 0)
     (local.get $dest)
    )
    (i32.const 3)
   )
  )
  (local.set $dest
   (i32.add
    (local.get $dest)
    (local.get $k)
   )
  )
  (local.set $n
   (i32.sub
    (local.get $n)
    (local.get $k)
   )
  )
  (local.set $n
   (i32.and
    (local.get $n)
    (i32.const -4)
   )
  )
  (local.set $c32
   (i32.mul
    (i32.div_u
     (i32.const -1)
     (i32.const 255)
    )
    (i32.and
     (local.get $c)
     (i32.const 255)
    )
   )
  )
  (i32.store
   (local.get $dest)
   (local.get $c32)
  )
  (i32.store
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 4)
   )
   (local.get $c32)
  )
  (if
   (i32.le_u
    (local.get $n)
    (i32.const 8)
   )
   (then
    (return
     (local.get $ret)
    )
   )
  )
  (i32.store
   (i32.add
    (local.get $dest)
    (i32.const 4)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.add
    (local.get $dest)
    (i32.const 8)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 12)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 8)
   )
   (local.get $c32)
  )
  (if
   (i32.le_u
    (local.get $n)
    (i32.const 24)
   )
   (then
    (return
     (local.get $ret)
    )
   )
  )
  (i32.store
   (i32.add
    (local.get $dest)
    (i32.const 12)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.add
    (local.get $dest)
    (i32.const 16)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.add
    (local.get $dest)
    (i32.const 20)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.add
    (local.get $dest)
    (i32.const 24)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 28)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 24)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 20)
   )
   (local.get $c32)
  )
  (i32.store
   (i32.sub
    (i32.add
     (local.get $dest)
     (local.get $n)
    )
    (i32.const 16)
   )
   (local.get $c32)
  )
  (local.set $k
   (i32.add
    (i32.const 24)
    (i32.and
     (local.get $dest)
     (i32.const 4)
    )
   )
  )
  (local.set $dest
   (i32.add
    (local.get $dest)
    (local.get $k)
   )
  )
  (local.set $n
   (i32.sub
    (local.get $n)
    (local.get $k)
   )
  )
  (local.set $c64
   (i64.or
    (i64.extend_i32_u
     (local.get $c32)
    )
    (i64.shl
     (i64.extend_i32_u
      (local.get $c32)
     )
     (i64.const 32)
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.ge_u
      (local.get $n)
      (i32.const 32)
     )
     (then
      (i64.store
       (local.get $dest)
       (local.get $c64)
      )
      (i64.store
       (i32.add
        (local.get $dest)
        (i32.const 8)
       )
       (local.get $c64)
      )
      (i64.store
       (i32.add
        (local.get $dest)
        (i32.const 16)
       )
       (local.get $c64)
      )
      (i64.store
       (i32.add
        (local.get $dest)
        (i32.const 24)
       )
       (local.get $c64)
      )
      (local.set $n
       (i32.sub
        (local.get $n)
        (i32.const 32)
       )
      )
      (local.set $dest
       (i32.add
        (local.get $dest)
        (i32.const 32)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (return
   (local.get $ret)
  )
 )
 (func $start:memset
  (global.set $memset/dest
   (global.get $~lib/memory/__heap_base)
  )
  (drop
   (call $memset/memset
    (global.get $memset/dest)
    (i32.const 1)
    (i32.const 16)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.load8_u
      (global.get $memset/dest)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 66)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.load8_u
      (i32.add
       (global.get $memset/dest)
       (i32.const 15)
      )
     )
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
  (drop
   (call $memset/memset
    (i32.add
     (global.get $memset/dest)
     (i32.const 1)
    )
    (i32.const 2)
    (i32.const 14)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.load8_u
      (global.get $memset/dest)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 71)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.load8_u
      (i32.add
       (global.get $memset/dest)
       (i32.const 1)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 72)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.load8_u
      (i32.add
       (global.get $memset/dest)
       (i32.const 14)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 73)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.load8_u
      (i32.add
       (global.get $memset/dest)
       (i32.const 15)
      )
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 74)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:memset)
 )
)
