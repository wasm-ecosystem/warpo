(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 76))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32844))
 (global $~lib/memory/__heap_base i32 (i32.const 32844))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00,\00\00\00p\00o\00s\00t\00f\00i\00x\00-\00u\00p\00d\00a\00t\00e\00-\00c\00a\00s\00t\00.\00t\00s\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $postfix-update-cast/postfixUpdateCast
  (local $v i32)
  (local $1 i32)
  (local.set $v
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.eq
     (block (result i32)
      (local.set $v
       (i32.add
        (local.tee $1
         (local.get $v)
        )
        (i32.const 1)
       )
      )
      (local.get $1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 3)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (local.get $v)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 4)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $start:postfix-update-cast
  (call $postfix-update-cast/postfixUpdateCast)
 )
 (func $~start
  (call $start:postfix-update-cast)
 )
)
