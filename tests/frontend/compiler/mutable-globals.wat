(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func (param i32 i32 i32)))
 (import "mutable-globals" "external" (global $mutable-globals/external (mut i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $mutable-globals/internal (mut i32) (i32.const 124))
 (global $~lib/memory/__data_end i32 (i32.const 76))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32844))
 (global $~lib/memory/__heap_base i32 (i32.const 32844))
 (global $~started (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00m\00u\00t\00a\00b\00l\00e\00-\00g\00l\00o\00b\00a\00l\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "external" (global $mutable-globals/external))
 (export "internal" (global $mutable-globals/internal))
 (export "memory" (memory $0))
 (export "_start" (func $~start))
 (func $start:mutable-globals
  (if
   (i32.eqz
    (i32.eq
     (global.get $mutable-globals/external)
     (i32.const 123)
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
     (global.get $mutable-globals/internal)
     (i32.const 124)
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
  (global.set $mutable-globals/external
   (i32.add
    (global.get $mutable-globals/external)
    (i32.const 10)
   )
  )
  (global.set $mutable-globals/internal
   (i32.add
    (global.get $mutable-globals/internal)
    (i32.const 10)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $mutable-globals/external)
     (i32.const 133)
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
  (if
   (i32.eqz
    (i32.eq
     (global.get $mutable-globals/internal)
     (i32.const 134)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 12)
     (i32.const 1)
    )
    (unreachable)
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
  (if
   (global.get $~started)
   (then
    (return)
   )
  )
  (global.set $~started
   (i32.const 1)
  )
  (call $start:mutable-globals)
 )
)
