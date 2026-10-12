(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32)))
 (type $3 (func (param i32 i32) (result i32)))
 (type $4 (func (result i32)))
 (type $5 (func (param i32 i32 i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $function-inline-regressions/struct i32 (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "baz" (func $function-inline-regressions/baz))
 (export "foo" (func $function-inline-regressions/foo))
 (export "memory" (memory $0))
 (func $function-inline-regressions/baz (param $v i32)
  (if
   (local.get $v)
   (then
    (unreachable)
   )
  )
 )
 (func $function-inline-regressions/loadX (param $a i32) (param $b i32) (result i32)
  (return
   (i32.load
    (i32.add
     (i32.mul
      (i32.const 2)
      (local.get $a)
     )
     (local.get $b)
    )
   )
  )
 )
 (func $function-inline-regressions/loadZ (result i32)
  (return
   (i32.load
    (i32.const 16)
   )
  )
 )
 (func $function-inline-regressions/Struct#set:v0 (param $this i32) (param $v0 i32)
  (i32.store
   (local.get $this)
   (local.get $v0)
  )
 )
 (func $function-inline-regressions/Struct#set:v1 (param $this i32) (param $v1 i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $v1)
  )
 )
 (func $function-inline-regressions/Struct#set:v2 (param $this i32) (param $v2 i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $v2)
  )
 )
 (func $function-inline-regressions/Struct#get:v0 (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $function-inline-regressions/Struct#get:v1 (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $function-inline-regressions/Struct#get:v2 (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $function-inline-regressions/foo (param $v0 i32) (param $v1 i32) (param $v2 i32) (result i32)
  (local $x i32)
  (local $y i32)
  (local $z i32)
  (local.set $x
   (call $function-inline-regressions/loadX
    (local.get $v0)
    (i32.const 0)
   )
  )
  (local.set $y
   (call $function-inline-regressions/loadX
    (local.get $v0)
    (i32.const 1)
   )
  )
  (local.set $z
   (call $function-inline-regressions/loadZ)
  )
  (call $function-inline-regressions/baz
   (i32.add
    (i32.add
     (local.get $z)
     (local.get $x)
    )
    (local.get $y)
   )
  )
  (call $function-inline-regressions/Struct#set:v0
   (global.get $function-inline-regressions/struct)
   (local.get $v0)
  )
  (call $function-inline-regressions/Struct#set:v1
   (global.get $function-inline-regressions/struct)
   (local.get $v1)
  )
  (call $function-inline-regressions/Struct#set:v2
   (global.get $function-inline-regressions/struct)
   (local.get $v2)
  )
  (call $function-inline-regressions/baz
   (i32.or
    (i32.or
     (call $function-inline-regressions/Struct#get:v0
      (global.get $function-inline-regressions/struct)
     )
     (call $function-inline-regressions/Struct#get:v1
      (global.get $function-inline-regressions/struct)
     )
    )
    (call $function-inline-regressions/Struct#get:v2
     (global.get $function-inline-regressions/struct)
    )
   )
  )
  (return
   (local.get $z)
  )
 )
)
