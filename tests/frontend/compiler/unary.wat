(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $unary/i (mut i32) (i32.const 0))
 (global $unary/I (mut i64) (i64.const 0))
 (global $unary/f (mut f32) (f32.const 0))
 (global $unary/F (mut f64) (f64.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:unary
  (local $0 i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i64)
  (local $4 f32)
  (local $5 f32)
  (local $6 f64)
  (local $7 f64)
  (drop
   (i32.const 1)
  )
  (drop
   (i32.const -1)
  )
  (drop
   (i32.eqz
    (i32.const 1)
   )
  )
  (drop
   (i32.xor
    (i32.const 1)
    (i32.const -1)
   )
  )
  (drop
   (f64.const 1.25)
  )
  (drop
   (f64.const -1.25)
  )
  (drop
   (i32.eqz
    (i64.le_u
     (i64.sub
      (i64.shl
       (i64.reinterpret_f64
        (f64.const 1.25)
       )
       (i64.const 1)
      )
      (i64.const 2)
     )
     (i64.const -9007199254740994)
    )
   )
  )
  (drop
   (global.get $unary/i)
  )
  (drop
   (i32.sub
    (i32.const 0)
    (global.get $unary/i)
   )
  )
  (drop
   (i32.eqz
    (global.get $unary/i)
   )
  )
  (drop
   (i32.xor
    (global.get $unary/i)
    (i32.const -1)
   )
  )
  (global.set $unary/i
   (i32.add
    (global.get $unary/i)
    (i32.const 1)
   )
  )
  (global.set $unary/i
   (i32.sub
    (global.get $unary/i)
    (i32.const 1)
   )
  )
  (global.set $unary/i
   (i32.add
    (global.get $unary/i)
    (i32.const 1)
   )
  )
  (global.set $unary/i
   (i32.sub
    (global.get $unary/i)
    (i32.const 1)
   )
  )
  (global.set $unary/i
   (i32.const 1)
  )
  (global.set $unary/i
   (i32.const -1)
  )
  (global.set $unary/i
   (i32.eqz
    (i32.const 1)
   )
  )
  (global.set $unary/i
   (i32.xor
    (i32.const 1)
    (i32.const -1)
   )
  )
  (global.set $unary/i
   (global.get $unary/i)
  )
  (global.set $unary/i
   (i32.sub
    (i32.const 0)
    (global.get $unary/i)
   )
  )
  (global.set $unary/i
   (i32.eqz
    (global.get $unary/i)
   )
  )
  (global.set $unary/i
   (i32.xor
    (global.get $unary/i)
    (i32.const -1)
   )
  )
  (global.set $unary/i
   (block (result i32)
    (global.set $unary/i
     (i32.add
      (global.get $unary/i)
      (i32.const 1)
     )
    )
    (global.get $unary/i)
   )
  )
  (global.set $unary/i
   (block (result i32)
    (global.set $unary/i
     (i32.sub
      (global.get $unary/i)
      (i32.const 1)
     )
    )
    (global.get $unary/i)
   )
  )
  (global.set $unary/i
   (block (result i32)
    (global.set $unary/i
     (i32.add
      (local.tee $0
       (global.get $unary/i)
      )
      (i32.const 1)
     )
    )
    (local.get $0)
   )
  )
  (global.set $unary/i
   (block (result i32)
    (global.set $unary/i
     (i32.sub
      (local.tee $1
       (global.get $unary/i)
      )
      (i32.const 1)
     )
    )
    (local.get $1)
   )
  )
  (drop
   (global.get $unary/I)
  )
  (drop
   (i64.sub
    (i64.const 0)
    (global.get $unary/I)
   )
  )
  (drop
   (i32.eqz
    (i64.ne
     (global.get $unary/I)
     (i64.const 0)
    )
   )
  )
  (drop
   (i64.xor
    (global.get $unary/I)
    (i64.const -1)
   )
  )
  (global.set $unary/I
   (i64.add
    (global.get $unary/I)
    (i64.const 1)
   )
  )
  (global.set $unary/I
   (i64.sub
    (global.get $unary/I)
    (i64.const 1)
   )
  )
  (global.set $unary/I
   (i64.add
    (global.get $unary/I)
    (i64.const 1)
   )
  )
  (global.set $unary/I
   (i64.sub
    (global.get $unary/I)
    (i64.const 1)
   )
  )
  (global.set $unary/I
   (i64.const 1)
  )
  (global.set $unary/I
   (i64.const -1)
  )
  (global.set $unary/I
   (i64.extend_i32_u
    (i32.eqz
     (i64.ne
      (i64.const 1)
      (i64.const 0)
     )
    )
   )
  )
  (global.set $unary/I
   (i64.xor
    (i64.const 1)
    (i64.const -1)
   )
  )
  (global.set $unary/I
   (global.get $unary/I)
  )
  (global.set $unary/I
   (i64.sub
    (i64.const 0)
    (global.get $unary/I)
   )
  )
  (global.set $unary/I
   (i64.extend_i32_u
    (i32.eqz
     (i64.ne
      (global.get $unary/I)
      (i64.const 0)
     )
    )
   )
  )
  (global.set $unary/I
   (i64.xor
    (global.get $unary/I)
    (i64.const -1)
   )
  )
  (global.set $unary/I
   (block (result i64)
    (global.set $unary/I
     (i64.add
      (global.get $unary/I)
      (i64.const 1)
     )
    )
    (global.get $unary/I)
   )
  )
  (global.set $unary/I
   (block (result i64)
    (global.set $unary/I
     (i64.sub
      (global.get $unary/I)
      (i64.const 1)
     )
    )
    (global.get $unary/I)
   )
  )
  (global.set $unary/I
   (block (result i64)
    (global.set $unary/I
     (i64.add
      (local.tee $2
       (global.get $unary/I)
      )
      (i64.const 1)
     )
    )
    (local.get $2)
   )
  )
  (global.set $unary/I
   (block (result i64)
    (global.set $unary/I
     (i64.sub
      (local.tee $3
       (global.get $unary/I)
      )
      (i64.const 1)
     )
    )
    (local.get $3)
   )
  )
  (drop
   (global.get $unary/f)
  )
  (drop
   (f32.neg
    (global.get $unary/f)
   )
  )
  (drop
   (i32.eqz
    (i32.le_u
     (i32.sub
      (i32.shl
       (i32.reinterpret_f32
        (global.get $unary/f)
       )
       (i32.const 1)
      )
      (i32.const 2)
     )
     (i32.const -16777218)
    )
   )
  )
  (global.set $unary/f
   (f32.add
    (global.get $unary/f)
    (f32.const 1)
   )
  )
  (global.set $unary/f
   (f32.sub
    (global.get $unary/f)
    (f32.const 1)
   )
  )
  (global.set $unary/f
   (f32.add
    (global.get $unary/f)
    (f32.const 1)
   )
  )
  (global.set $unary/f
   (f32.sub
    (global.get $unary/f)
    (f32.const 1)
   )
  )
  (global.set $unary/f
   (f32.const 1.25)
  )
  (global.set $unary/f
   (f32.const -1.25)
  )
  (global.set $unary/i
   (i32.eqz
    (i64.le_u
     (i64.sub
      (i64.shl
       (i64.reinterpret_f64
        (f64.const 1.25)
       )
       (i64.const 1)
      )
      (i64.const 2)
     )
     (i64.const -9007199254740994)
    )
   )
  )
  (global.set $unary/f
   (global.get $unary/f)
  )
  (global.set $unary/f
   (f32.neg
    (global.get $unary/f)
   )
  )
  (global.set $unary/i
   (i32.eqz
    (i32.le_u
     (i32.sub
      (i32.shl
       (i32.reinterpret_f32
        (global.get $unary/f)
       )
       (i32.const 1)
      )
      (i32.const 2)
     )
     (i32.const -16777218)
    )
   )
  )
  (global.set $unary/f
   (block (result f32)
    (global.set $unary/f
     (f32.add
      (global.get $unary/f)
      (f32.const 1)
     )
    )
    (global.get $unary/f)
   )
  )
  (global.set $unary/f
   (block (result f32)
    (global.set $unary/f
     (f32.sub
      (global.get $unary/f)
      (f32.const 1)
     )
    )
    (global.get $unary/f)
   )
  )
  (global.set $unary/f
   (block (result f32)
    (global.set $unary/f
     (f32.add
      (local.tee $4
       (global.get $unary/f)
      )
      (f32.const 1)
     )
    )
    (local.get $4)
   )
  )
  (global.set $unary/f
   (block (result f32)
    (global.set $unary/f
     (f32.sub
      (local.tee $5
       (global.get $unary/f)
      )
      (f32.const 1)
     )
    )
    (local.get $5)
   )
  )
  (drop
   (global.get $unary/F)
  )
  (drop
   (f64.neg
    (global.get $unary/F)
   )
  )
  (drop
   (i32.eqz
    (i64.le_u
     (i64.sub
      (i64.shl
       (i64.reinterpret_f64
        (global.get $unary/F)
       )
       (i64.const 1)
      )
      (i64.const 2)
     )
     (i64.const -9007199254740994)
    )
   )
  )
  (global.set $unary/F
   (f64.add
    (global.get $unary/F)
    (f64.const 1)
   )
  )
  (global.set $unary/F
   (f64.sub
    (global.get $unary/F)
    (f64.const 1)
   )
  )
  (global.set $unary/F
   (f64.add
    (global.get $unary/F)
    (f64.const 1)
   )
  )
  (global.set $unary/F
   (f64.sub
    (global.get $unary/F)
    (f64.const 1)
   )
  )
  (global.set $unary/F
   (f64.const 1.25)
  )
  (global.set $unary/F
   (f64.const -1.25)
  )
  (global.set $unary/I
   (i64.extend_i32_u
    (i32.eqz
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (f64.const 1.25)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
    )
   )
  )
  (global.set $unary/F
   (global.get $unary/F)
  )
  (global.set $unary/F
   (f64.neg
    (global.get $unary/F)
   )
  )
  (global.set $unary/I
   (i64.extend_i32_u
    (i32.eqz
     (i64.le_u
      (i64.sub
       (i64.shl
        (i64.reinterpret_f64
         (global.get $unary/F)
        )
        (i64.const 1)
       )
       (i64.const 2)
      )
      (i64.const -9007199254740994)
     )
    )
   )
  )
  (global.set $unary/F
   (block (result f64)
    (global.set $unary/F
     (f64.add
      (global.get $unary/F)
      (f64.const 1)
     )
    )
    (global.get $unary/F)
   )
  )
  (global.set $unary/F
   (block (result f64)
    (global.set $unary/F
     (f64.sub
      (global.get $unary/F)
      (f64.const 1)
     )
    )
    (global.get $unary/F)
   )
  )
  (global.set $unary/F
   (block (result f64)
    (global.set $unary/F
     (f64.add
      (local.tee $6
       (global.get $unary/F)
      )
      (f64.const 1)
     )
    )
    (local.get $6)
   )
  )
  (global.set $unary/F
   (block (result f64)
    (global.set $unary/F
     (f64.sub
      (local.tee $7
       (global.get $unary/F)
      )
      (f64.const 1)
     )
    )
    (local.get $7)
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
  (call $start:unary)
 )
)
