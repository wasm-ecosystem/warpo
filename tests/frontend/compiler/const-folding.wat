(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i64) (result i64)))
 (type $3 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $const-folding/w (mut i32) (i32.const 0))
 (global $const-folding/x (mut i32) (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "x" (global $const-folding/x))
 (export "test" (func $const-folding/test))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:const-folding
  (global.set $const-folding/w
   (i32.shr_s
    (i32.const 42)
    (i32.const 1)
   )
  )
  (global.set $const-folding/w
   (i32.or
    (i32.and
     (global.get $const-folding/w)
     (i32.const 252)
    )
    (i32.shr_s
     (global.get $const-folding/w)
     (i32.const 1)
    )
   )
  )
  (global.set $const-folding/x
   (global.get $const-folding/w)
  )
 )
 (func $const-folding/test (param $value i64) (result i64)
  (local $mod1 i64)
  (local $mod2 i64)
  (local $rlo i64)
  (local $rhi i64)
  (local.set $mod1
   (i64.const -1)
  )
  (local.set $mod2
   (i64.const -1)
  )
  (local.set $rlo
   (i64.shl
    (local.get $value)
    (i64.const 1)
   )
  )
  (local.set $rhi
   (i64.and
    (local.get $rlo)
    (i64.xor
     (local.get $mod2)
     (i64.const -1)
    )
   )
  )
  (local.set $rhi
   (i64.or
    (local.get $rhi)
    (i64.shl
     (local.get $rhi)
     (i64.const 1)
    )
   )
  )
  (local.set $rhi
   (i64.or
    (local.get $rhi)
    (i64.and
     (i64.shr_u
      (local.get $value)
      (i64.const 63)
     )
     (local.get $mod1)
    )
   )
  )
  (return
   (i64.add
    (local.get $rlo)
    (local.get $rhi)
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
  (call $start:const-folding)
 )
)
