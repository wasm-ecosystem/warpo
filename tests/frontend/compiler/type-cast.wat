(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 60))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32828))
 (global $~lib/memory/__heap_base i32 (i32.const 32828))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\18\00\00\00t\00y\00p\00e\00-\00c\00a\00s\00t\00.\00t\00s\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $type-cast/typecast
  (local $a i32)
  (local $b i32)
  (local.set $a
   (i32.const 256)
  )
  (local.set $b
   (local.get $a)
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.and
      (local.get $b)
      (i32.const 255)
     )
     (i32.const 0)
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
 (func $type-cast/typpecastWithUnaryPrefix
  (local $a i32)
  (local $b i32)
  (local.set $a
   (i32.const -100)
  )
  (local.set $b
   (i32.sub
    (i32.const 0)
    (local.get $a)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (local.get $b)
     )
     (i32.const 100)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 11)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $type-cast/typpecastWithUnaryPostfix
  (local $a i32)
  (local $1 i32)
  (local $b i32)
  (local.set $a
   (i32.const 127)
  )
  (local.set $b
   (block (result i32)
    (local.set $a
     (i32.add
      (local.tee $1
       (local.get $a)
      )
      (i32.const 1)
     )
    )
    (local.get $1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (local.get $a)
     (i32.const 128)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 18)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.extend8_s
      (local.get $b)
     )
     (i32.const 127)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 19)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $start:type-cast
  (call $type-cast/typecast)
  (call $type-cast/typpecastWithUnaryPrefix)
  (call $type-cast/typpecastWithUnaryPostfix)
 )
 (func $~start
  (call $start:type-cast)
 )
)
