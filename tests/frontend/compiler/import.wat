(module
 (type $0 (func))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32) (result i32)))
 (type $3 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $export/a i32 (i32.const 1))
 (global $export/b i32 (i32.const 2))
 (global $export/c i32 (i32.const 3))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $export/add (param $a i32) (param $b i32) (result i32)
  (return
   (i32.add
    (local.get $a)
    (local.get $b)
   )
  )
 )
 (func $export/sub (param $a i32) (param $b i32) (result i32)
  (return
   (i32.sub
    (local.get $a)
    (local.get $b)
   )
  )
 )
 (func $export/mul (param $a i32) (param $b i32) (result i32)
  (return
   (i32.mul
    (local.get $a)
    (local.get $b)
   )
  )
 )
 (func $export/ns.two
  (nop)
 )
 (func $export-default/theDefault
  (nop)
 )
 (func $start:import
  (drop
   (i32.add
    (i32.add
     (call $export/add
      (global.get $export/a)
      (global.get $export/b)
     )
     (call $export/sub
      (global.get $export/b)
      (global.get $export/c)
     )
    )
    (call $export/mul
     (global.get $export/c)
     (global.get $export/a)
    )
   )
  )
  (call $export/ns.two)
  (drop
   (i32.add
    (i32.add
     (call $export/add
      (global.get $export/a)
      (global.get $export/b)
     )
     (call $export/sub
      (global.get $export/b)
      (global.get $export/c)
     )
    )
    (call $export/mul
     (global.get $export/c)
     (global.get $export/a)
    )
   )
  )
  (call $export/ns.two)
  (call $export/ns.two)
  (call $export-default/theDefault)
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32) (param $2 i32)
  (memory.fill
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )
 (func $~start
  (call $start:import)
 )
)
