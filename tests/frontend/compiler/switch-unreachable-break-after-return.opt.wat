(module
 (type $0 (func (result i32)))
 (memory $0 0)
 (export "main" (func $switch-unreachable-break-after-return/main))
 (export "memory" (memory $0))
 (func $switch-unreachable-break-after-return/main (result i32)
  i32.const 1
 )
)
