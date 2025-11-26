(module
 (type $0 (func))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02")
 (export "memory" (memory $0))
 (start $~start)
 (func $~start
  i32.const 28
  i32.load
  drop
  i32.const 28
  i32.load
  drop
  i32.const 28
  i32.load
  drop
  i32.const 28
  i32.load
  drop
  i32.const 28
  i32.load
  drop
  i32.const 28
  i32.load
  i32.const 1
  i32.shr_u
  if
   i32.const 28
   i32.load
   drop
  end
 )
)
