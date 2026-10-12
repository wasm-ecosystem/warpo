(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 124))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32892))
 (global $~lib/memory/__heap_base i32 (i32.const 32892))
 (memory $0 1)
 (data $0 (i32.const 12) "l\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00P\00\00\00s\00w\00i\00t\00c\00h\00-\00u\00n\00r\00e\00a\00c\00h\00a\00b\00l\00e\00-\00b\00r\00e\00a\00k\00-\00a\00f\00t\00e\00r\00-\00r\00e\00t\00u\00r\00n\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "main" (func $switch-unreachable-break-after-return/main))
 (export "memory" (memory $0))
 (start $~start)
 (func $switch-unreachable-break-after-return/main (param $condition i32) (result i32)
  (local $1 i32)
  (block $break|0
   (block $case1|0
    (block $case0|0
     (local.set $1
      (local.get $condition)
     )
     (br_if $case0|0
      (i32.eq
       (i32.ne
        (local.get $1)
        (i32.const 0)
       )
       (i32.const 1)
      )
     )
     (br $case1|0)
    )
    (return
     (i32.const 0)
    )
   )
   (return
    (i32.const 1)
   )
  )
 )
 (func $start:switch-unreachable-break-after-return
  (if
   (i32.eqz
    (i32.eq
     (call $switch-unreachable-break-after-return/main
      (i32.const 1)
     )
     (i32.const 0)
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
  (if
   (i32.eqz
    (i32.eq
     (call $switch-unreachable-break-after-return/main
      (i32.const 0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 11)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:switch-unreachable-break-after-return)
 )
)
