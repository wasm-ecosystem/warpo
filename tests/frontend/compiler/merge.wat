(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $merge/globalType i32 (i32.const 2))
 (global $merge/globalType_test (mut i32) (i32.const 0))
 (global $merge/typeGlobal i32 (i32.const 3))
 (global $merge/typeGlobal_test (mut i32) (i32.const 0))
 (global $merge/namespaceType_test (mut i32) (i32.const 0))
 (global $merge/typeNamespace_test (mut i32) (i32.const 0))
 (global $merge/functionType_test (mut i32) (i32.const 0))
 (global $merge/typeFunction_test (mut i32) (i32.const 0))
 (global $merge/enumNamespace.val i32 (i32.const 1))
 (global $merge/namespaceEnum.val i32 (i32.const 2))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $merge/namespaceType.test
  (nop)
 )
 (func $merge/typeNamespace.test
  (nop)
 )
 (func $merge/functionType
  (nop)
 )
 (func $merge/typeFunction
  (nop)
 )
 (func $merge/classNamespace.test1
  (nop)
 )
 (func $merge/classNamespace.test2
  (nop)
 )
 (func $merge/namespaceClass.test1
  (nop)
 )
 (func $merge/namespaceClass.test2
  (nop)
 )
 (func $merge/functionNamespace
  (nop)
 )
 (func $merge/functionNamespace.test
  (nop)
 )
 (func $merge/namespaceFunction.test
  (nop)
 )
 (func $merge/namespaceFunction
  (nop)
 )
 (func $merge/enumNamespace.test
  (nop)
 )
 (func $merge/namespaceEnum.test
  (nop)
 )
 (func $merge/namespaceNamespace.test1
  (nop)
 )
 (func $merge/namespaceNamespace.test2
  (nop)
 )
 (func $start:merge
  (drop
   (global.get $merge/globalType)
  )
  (drop
   (global.get $merge/typeGlobal)
  )
  (call $merge/namespaceType.test)
  (call $merge/typeNamespace.test)
  (call $merge/functionType)
  (call $merge/typeFunction)
  (call $merge/classNamespace.test1)
  (call $merge/classNamespace.test2)
  (call $merge/namespaceClass.test1)
  (call $merge/namespaceClass.test2)
  (call $merge/functionNamespace)
  (call $merge/functionNamespace.test)
  (call $merge/namespaceFunction.test)
  (call $merge/namespaceFunction)
  (drop
   (global.get $merge/enumNamespace.val)
  )
  (call $merge/enumNamespace.test)
  (call $merge/namespaceEnum.test)
  (drop
   (global.get $merge/namespaceEnum.val)
  )
  (call $merge/namespaceNamespace.test1)
  (call $merge/namespaceNamespace.test2)
 )
 (func $~lib/memory/memory.fill (param $0 i32) (param $1 i32) (param $2 i32)
  (memory.fill
   (local.get $0)
   (local.get $1)
   (local.get $2)
  )
 )
 (func $~start
  (call $start:merge)
 )
)
