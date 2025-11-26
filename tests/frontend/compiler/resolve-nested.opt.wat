(module
 (type $0 (func (param i32 i32 i32)))
 (memory $0 0)
 (export "outer" (func $resolve-nested/outer))
 (export "memory" (memory $0))
 (func $resolve-nested/outer (param $0 i32) (param $1 i32) (param $2 i32)
  nop
 )
)
