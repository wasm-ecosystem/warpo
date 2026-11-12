(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (result i32)))
 (type $3 (func (result i64)))
 (type $4 (func (result f32)))
 (type $5 (func (result f64)))
 (type $6 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $infer-type/i i32 (i32.const 10))
 (global $infer-type/I i64 (i64.const 4294967296))
 (global $infer-type/F f64 (f64.const 1.5))
 (global $infer-type/ri (mut i32) (i32.const 0))
 (global $infer-type/rI (mut i64) (i64.const 0))
 (global $infer-type/rf (mut f32) (f32.const 0))
 (global $infer-type/rF (mut f64) (f64.const 0))
 (global $infer-type/inferi (mut i32) (i32.const -2147483648))
 (global $infer-type/inferu (mut i32) (i32.const 2147483647))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $infer-type/locals
  (local $li i32)
  (local $lI i64)
  (local $lF f64)
  (local $ai i32)
  (local $aI i64)
  (local $aF f64)
  (local.set $li
   (i32.const 10)
  )
  (local.set $lI
   (i64.const 4294967296)
  )
  (local.set $lF
   (f64.const 1.5)
  )
  (local.set $ai
   (global.get $infer-type/i)
  )
  (local.set $aI
   (global.get $infer-type/I)
  )
  (local.set $aF
   (global.get $infer-type/F)
  )
 )
 (func $infer-type/reti (result i32)
  (return
   (i32.const 0)
  )
 )
 (func $infer-type/retI (result i64)
  (return
   (i64.const 0)
  )
 )
 (func $infer-type/retf (result f32)
  (return
   (f32.const 0)
  )
 )
 (func $infer-type/refF (result f64)
  (return
   (f64.const 0)
  )
 )
 (func $start:infer-type
  (local $a i32)
  (local $b i32)
  (drop
   (global.get $infer-type/i)
  )
  (drop
   (global.get $infer-type/I)
  )
  (drop
   (global.get $infer-type/F)
  )
  (call $infer-type/locals)
  (global.set $infer-type/ri
   (call $infer-type/reti)
  )
  (drop
   (global.get $infer-type/ri)
  )
  (global.set $infer-type/rI
   (call $infer-type/retI)
  )
  (drop
   (global.get $infer-type/rI)
  )
  (global.set $infer-type/rf
   (call $infer-type/retf)
  )
  (drop
   (global.get $infer-type/rf)
  )
  (global.set $infer-type/rF
   (call $infer-type/refF)
  )
  (drop
   (global.get $infer-type/rF)
  )
  (block
   (block
    (local.set $a
     (i32.const 0)
    )
    (local.set $b
     (i32.const 10)
    )
   )
   (loop $for-loop|0
    (if
     (i32.lt_s
      (local.get $a)
      (local.get $b)
     )
     (then
      (local.set $a
       (i32.add
        (local.get $a)
        (i32.const 1)
       )
      )
      (br $for-loop|0)
     )
    )
   )
  )
  (drop
   (i32.eqz
    (i32.const 0)
   )
  )
  (drop
   (i32.const 1)
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
  (call $start:infer-type)
 )
)
