(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func (param i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00i\00s\00s\00u\00e\00s\00/\002\008\002\005\00.\00t\00s\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "init" (func $issues/2825/init))
 (export "memory" (memory $0))
 (start $~start)
 (func $issues/2825/increment (param $x i32) (result i32)
  (if
   (i32.eqz
    (i32.ne
     (local.get $x)
     (i32.const 1234)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 2)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (return
   (i32.add
    (local.get $x)
    (i32.const 1)
   )
  )
 )
 (func $start:issues/2825
  (local $i i32)
  (local $i|1 i32)
  (local.set $i
   (i32.const 0)
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (i32.const 10)
    )
    (then
     (local.set $i|1
      (i32.const 1234)
     )
     (local.set $i
      (call $issues/2825/increment
       (local.get $i)
      )
     )
     (br $for-loop|0)
    )
   )
  )
 )
 (func $issues/2825/init
  (local $not_unassigned i32)
  (loop $for-loop|0
   (if
    (i32.const 1)
    (then
     (local.set $not_unassigned
      (i32.const 0)
     )
     (drop
      (local.get $not_unassigned)
     )
     (br $for-loop|0)
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
 (func $~start
  (call $start:issues/2825)
 )
)
