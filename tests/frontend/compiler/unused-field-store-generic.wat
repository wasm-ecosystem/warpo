(module
 (type $0 (func (param i32 i32)))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "baseToDerived" (func $unused-field-store-generic/baseToDerived))
 (export "derivedToBase" (func $unused-field-store-generic/derivedToBase))
 (export "unusedBaseWrite" (func $unused-field-store-generic/unusedBaseWrite))
 (export "unusedDerivedWrite" (func $unused-field-store-generic/unusedDerivedWrite))
 (export "memory" (memory $0))
 (func $unused-field-store-generic/Base<i32>#set:forward (param $this i32) (param $forward i32)
  (i32.store
   (local.get $this)
   (local.get $forward)
  )
 )
 (func $unused-field-store-generic/writeBaseForward<i32> (param $box i32) (param $value i32)
  (call $unused-field-store-generic/Base<i32>#set:forward
   (call $~lib/rt/__tmptostack
    (local.get $box)
   )
   (local.get $value)
  )
 )
 (func $unused-field-store-generic/Derived<i32>#get:forward (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $unused-field-store-generic/readDerivedForward<i32> (param $box i32) (result i32)
  (return
   (call $unused-field-store-generic/Derived<i32>#get:forward
    (call $~lib/rt/__tmptostack
     (local.get $box)
    )
   )
  )
 )
 (func $unused-field-store-generic/baseToDerived (param $box i32) (param $value i32) (result i32)
  (call $unused-field-store-generic/writeBaseForward<i32>
   (call $~lib/rt/__tmptostack
    (local.get $box)
   )
   (local.get $value)
  )
  (return
   (call $unused-field-store-generic/readDerivedForward<i32>
    (call $~lib/rt/__tmptostack
     (local.get $box)
    )
   )
  )
 )
 (func $unused-field-store-generic/Derived<i32>#set:reverse (param $this i32) (param $reverse i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $reverse)
  )
 )
 (func $unused-field-store-generic/writeDerivedReverse<i32> (param $box i32) (param $value i32)
  (call $unused-field-store-generic/Derived<i32>#set:reverse
   (call $~lib/rt/__tmptostack
    (local.get $box)
   )
   (local.get $value)
  )
 )
 (func $unused-field-store-generic/Base<i32>#get:reverse (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $unused-field-store-generic/readBaseReverse<i32> (param $box i32) (result i32)
  (return
   (call $unused-field-store-generic/Base<i32>#get:reverse
    (call $~lib/rt/__tmptostack
     (local.get $box)
    )
   )
  )
 )
 (func $unused-field-store-generic/derivedToBase (param $box i32) (param $value i32) (result i32)
  (call $unused-field-store-generic/writeDerivedReverse<i32>
   (call $~lib/rt/__tmptostack
    (local.get $box)
   )
   (local.get $value)
  )
  (return
   (call $unused-field-store-generic/readBaseReverse<i32>
    (call $~lib/rt/__tmptostack
     (local.get $box)
    )
   )
  )
 )
 (func $unused-field-store-generic/Base<i32>#set:forwardUnused (param $this i32) (param $forwardUnused i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $forwardUnused)
  )
 )
 (func $unused-field-store-generic/writeBaseUnused<i32> (param $box i32) (param $value i32)
  (call $unused-field-store-generic/Base<i32>#set:forwardUnused
   (call $~lib/rt/__tmptostack
    (local.get $box)
   )
   (local.get $value)
  )
 )
 (func $unused-field-store-generic/unusedBaseWrite (param $box i32) (param $value i32)
  (call $unused-field-store-generic/writeBaseUnused<i32>
   (call $~lib/rt/__tmptostack
    (local.get $box)
   )
   (local.get $value)
  )
 )
 (func $unused-field-store-generic/Derived<i32>#set:reverseUnused (param $this i32) (param $reverseUnused i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $reverseUnused)
  )
 )
 (func $unused-field-store-generic/writeDerivedUnused<i32> (param $box i32) (param $value i32)
  (call $unused-field-store-generic/Derived<i32>#set:reverseUnused
   (call $~lib/rt/__tmptostack
    (local.get $box)
   )
   (local.get $value)
  )
 )
 (func $unused-field-store-generic/unusedDerivedWrite (param $box i32) (param $value i32)
  (call $unused-field-store-generic/writeDerivedUnused<i32>
   (call $~lib/rt/__tmptostack
    (local.get $box)
   )
   (local.get $value)
  )
 )
)
