(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32 i32 i32)))
 (type $2 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02\00\00\00\n\00\00\00i\00f\00.\00t\00s")
 (data $1 (i32.const 44) "\1c")
 (data $1.1 (i32.const 56) "\02\00\00\00\n\00\00\00e\00r\00r\00o\00r")
 (export "ifThenElse" (func $if/ifThenElse))
 (export "ifThen" (func $if/ifThen))
 (export "ifThenElseBlock" (func $if/ifThenElse))
 (export "ifAlwaysReturns" (func $if/ifAlwaysReturns))
 (export "memory" (memory $0))
 (start $~start)
 (func $if/ifThenElse (param $0 i32) (result i32)
  local.get $0
  i32.eqz
  i32.eqz
 )
 (func $if/ifThen (param $0 i32) (result i32)
  local.get $0
  if
   i32.const 1
   return
  end
  i32.const 0
 )
 (func $if/ifAlwaysReturns (param $0 i32) (result i32)
  local.get $0
  if (result i32)
   i32.const 1
  else
   i32.const 64
   i32.const 32
   i32.const 32
   i32.const 8
   call $~lib/builtins/abort
   unreachable
  end
 )
 (func $~start
  i32.const 0
  call $if/ifThen
  if
   i32.const 0
   i32.const 32
   i32.const 14
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  call $if/ifThen
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 32
   i32.const 15
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
)
