(module
  (type (func (param i64) (result i64)))

  (func (param i64) (result i64)
    
    local.get 0)
  (func (;3;) (result i64)
   

    i64.const 123
    
    i32.const 0
    i32.const 0
    i32.add
    call_indirect (type 0)
    )
  
  (table 1 funcref)
  
  (global (mut i32) (i32.const 10))

  (export "func_0" (func 1))
  (elem (i32.const 0) func 0)
)

(assert_return (invoke "func_0") (i64.const 123))
