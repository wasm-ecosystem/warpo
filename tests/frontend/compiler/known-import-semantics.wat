(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32) (result f32)))
 (type $2 (func (param f32) (result f32)))
 (type $3 (func))
 (type $4 (func (result f32)))
 (import "builtin" "getF32FromLinkedMemory" (func $known-import-semantics/getF32FromLinkedMemory (param i32) (result f32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "discardDecodedValue" (func $known-import-semantics/discardDecodedValue))
 (export "keepDecodedValue" (func $known-import-semantics/keepDecodedValue))
 (export "memory" (memory $0))
 (func $~lib/polyfills/bswap<i32> (param $value i32) (result i32)
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 1)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 2)
    )
   )
   (drop
    (i32.eq
     (i32.const 4)
     (i32.const 4)
    )
   )
   (return
    (i32.or
     (i32.rotl
      (i32.and
       (local.get $value)
       (i32.const -16711936)
      )
      (i32.const 8)
     )
     (i32.rotr
      (i32.and
       (local.get $value)
       (i32.const 16711935)
      )
      (i32.const 8)
     )
    )
   )
  )
 )
 (func $known-import-semantics/bswap_f32 (param $value f32) (result f32)
  (return
   (f32.reinterpret_i32
    (call $~lib/polyfills/bswap<i32>
     (i32.reinterpret_f32
      (local.get $value)
     )
    )
   )
  )
 )
 (func $known-import-semantics/discardDecodedValue
  (drop
   (call $known-import-semantics/bswap_f32
    (call $known-import-semantics/getF32FromLinkedMemory
     (i32.const 0)
    )
   )
  )
 )
 (func $known-import-semantics/keepDecodedValue (result f32)
  (return
   (call $known-import-semantics/bswap_f32
    (call $known-import-semantics/getF32FromLinkedMemory
     (i32.const 4)
    )
   )
  )
 )
)
