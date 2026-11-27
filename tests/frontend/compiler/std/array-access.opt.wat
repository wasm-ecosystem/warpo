(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32 i32 i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "<")
 (data $0.1 (i32.const 24) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $1 (i32.const 76) ",")
 (data $1.1 (i32.const 88) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00|")
 (data $2.1 (i32.const 136) "\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y")
 (data $3 (i32.const 252) "\1c")
 (data $3.1 (i32.const 264) "\02")
 (table $0 1 1 funcref)
 (export "i32ArrayArrayElementAccess" (func $std/array-access/i32ArrayArrayElementAccess))
 (export "stringArrayPropertyAccess" (func $std/array-access/stringArrayPropertyAccess))
 (export "stringArrayMethodCall" (func $std/array-access/stringArrayMethodCall))
 (export "stringArrayArrayPropertyAccess" (func $std/array-access/stringArrayArrayPropertyAccess))
 (export "stringArrayArrayMethodCall" (func $std/array-access/stringArrayArrayMethodCall))
 (export "functionArrayElementCall" (func $std/array-access/functionArrayElementCall))
 (export "memory" (memory $0))
 (func $~lib/array/Array<~lib/array/Array<i32>>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   i32.const 32
   i32.const 96
   i32.const 124
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.tee $0
  i32.eqz
  if
   i32.const 144
   i32.const 96
   i32.const 128
   i32.const 40
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
 )
 (func $std/array-access/i32ArrayArrayElementAccess (param $0 i32) (result i32)
  local.get $0
  i32.const 0
  call $~lib/array/Array<~lib/array/Array<i32>>#__get
  local.tee $0
  i32.load offset=12
  i32.const 1
  i32.le_u
  if
   i32.const 32
   i32.const 96
   i32.const 124
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.const 4
  i32.add
  i32.load
 )
 (func $std/array-access/stringArrayPropertyAccess (param $0 i32) (result i32)
  local.get $0
  i32.const 0
  call $~lib/array/Array<~lib/array/Array<i32>>#__get
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
 )
 (func $~lib/string/String#startsWith (param $0 i32) (result i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  drop
  i32.const 1
 )
 (func $std/array-access/stringArrayMethodCall (param $0 i32) (result i32)
  local.get $0
  i32.const 0
  call $~lib/array/Array<~lib/array/Array<i32>>#__get
  return_call $~lib/string/String#startsWith
 )
 (func $std/array-access/stringArrayArrayPropertyAccess (param $0 i32) (result i32)
  local.get $0
  i32.const 0
  call $~lib/array/Array<~lib/array/Array<i32>>#__get
  i32.const 1
  call $~lib/array/Array<~lib/array/Array<i32>>#__get
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
 )
 (func $std/array-access/stringArrayArrayMethodCall (param $0 i32) (result i32)
  local.get $0
  i32.const 0
  call $~lib/array/Array<~lib/array/Array<i32>>#__get
  i32.const 1
  call $~lib/array/Array<~lib/array/Array<i32>>#__get
  return_call $~lib/string/String#startsWith
 )
 (func $std/array-access/functionArrayElementCall (param $0 i32) (result i32)
  i32.const 123
  local.get $0
  i32.const 0
  call $~lib/array/Array<~lib/array/Array<i32>>#__get
  i32.load
  return_call_indirect (type $0)
 )
)
