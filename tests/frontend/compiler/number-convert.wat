(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:number-convert
  (drop
   (f32.eq
    (f32.convert_i32_u
     (i32.const 1)
    )
    (f32.const 1)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_u
     (i32.const 255)
    )
    (f32.const 255)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_u
     (i32.and
      (i32.const 256)
      (i32.const 255)
     )
    )
    (f32.const 0)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_u
     (i32.and
      (i32.const 257)
      (i32.const 255)
     )
    )
    (f32.const 1)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_s
     (i32.const 1)
    )
    (f32.const 1)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_s
     (i32.extend8_s
      (i32.const 255)
     )
    )
    (f32.const -1)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_s
     (i32.extend8_s
      (i32.const 256)
     )
    )
    (f32.const 0)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_s
     (i32.extend8_s
      (i32.const 257)
     )
    )
    (f32.const 1)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_u
     (i32.const 1)
    )
    (f32.const 1)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_u
     (i32.const 65535)
    )
    (f32.const 65535)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_u
     (i32.and
      (i32.const 65536)
      (i32.const 65535)
     )
    )
    (f32.const 0)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_u
     (i32.and
      (i32.const 65537)
      (i32.const 65535)
     )
    )
    (f32.const 1)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_s
     (i32.const 1)
    )
    (f32.const 1)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_s
     (i32.extend16_s
      (i32.const 65535)
     )
    )
    (f32.const -1)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_s
     (i32.extend16_s
      (i32.const 65536)
     )
    )
    (f32.const 0)
   )
  )
  (drop
   (f32.eq
    (f32.convert_i32_s
     (i32.extend16_s
      (i32.const 65537)
     )
    )
    (f32.const 1)
   )
  )
  (drop
   (f64.eq
    (f64.convert_i32_u
     (i32.const 1)
    )
    (f64.const 1)
   )
  )
  (drop
   (f64.eq
    (f64.convert_i32_u
     (i32.const 255)
    )
    (f64.const 255)
   )
  )
  (drop
   (f64.eq
    (f64.convert_i32_u
     (i32.and
      (i32.const 256)
      (i32.const 255)
     )
    )
    (f64.const 0)
   )
  )
  (drop
   (f64.eq
    (f64.convert_i32_u
     (i32.and
      (i32.const 257)
      (i32.const 255)
     )
    )
    (f64.const 1)
   )
  )
  (drop
   (f64.eq
    (f64.convert_i32_s
     (i32.const 1)
    )
    (f64.const 1)
   )
  )
  (drop
   (f64.eq
    (f64.convert_i32_s
     (i32.extend8_s
      (i32.const 255)
     )
    )
    (f64.const -1)
   )
  )
  (drop
   (f64.eq
    (f64.convert_i32_s
     (i32.extend8_s
      (i32.const 256)
     )
    )
    (f64.const 0)
   )
  )
  (drop
   (f64.eq
    (f64.convert_i32_s
     (i32.extend8_s
      (i32.const 257)
     )
    )
    (f64.const 1)
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
  (call $start:number-convert)
 )
)
