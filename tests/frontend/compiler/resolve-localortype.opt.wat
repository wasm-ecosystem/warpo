(module
 (type $0 (func (param i32) (result i32)))
 (memory $0 0)
 (export "test" (func $resolve-localortype/test))
 (export "memory" (memory $0))
 (func $resolve-localortype/test (param $0 i32) (result i32)
  local.get $0
 )
)
