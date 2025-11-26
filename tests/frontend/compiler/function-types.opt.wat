(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (param i32 i32 i32 i32)))
 (type $2 (func (param i64 i64) (result i64)))
 (type $3 (func (param f64 f64) (result f64)))
 (type $4 (func (param i32 i32 i32) (result i32)))
 (type $5 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32972))
 (global $function-types/i32Adder (mut i32) (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\04\00\00\00\08\00\00\00\01")
 (data $1 (i32.const 44) "<")
 (data $1.1 (i32.const 56) "\02\00\00\00\"\00\00\00f\00u\00n\00c\00t\00i\00o\00n\00-\00t\00y\00p\00e\00s\00.\00t\00s")
 (data $2 (i32.const 108) "\1c")
 (data $2.1 (i32.const 120) "\05\00\00\00\08\00\00\00\02")
 (data $3 (i32.const 140) "\1c")
 (data $3.1 (i32.const 152) "\06\00\00\00\08\00\00\00\03")
 (data $4 (i32.const 172) "\1c")
 (data $4.1 (i32.const 184) "\04\00\00\00\08\00\00\00\04")
 (table $0 5 5 funcref)
 (elem $0 (i32.const 1) $function-types/makeAdder<i32>~anonymous|0 $function-types/makeAdder<i64>~anonymous|0 $function-types/makeAdder<f64>~anonymous|0 $function-types/makeAdder<i32>~anonymous|0)
 (export "memory" (memory $0))
 (start $~start)
 (func $function-types/makeAdder<i32>~anonymous|0 (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  i32.add
 )
 (func $function-types/makeAdder<i64>~anonymous|0 (param $0 i64) (param $1 i64) (result i64)
  local.get $0
  local.get $1
  i64.add
 )
 (func $function-types/makeAdder<f64>~anonymous|0 (param $0 f64) (param $1 f64) (result f64)
  local.get $0
  local.get $1
  f64.add
 )
 (func $function-types/doAddWithFn<i32> (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  i32.const 2
  global.set $~argumentsLength
  local.get $0
  local.get $1
  local.get $2
  i32.load
  call_indirect (type $0)
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 204
  i32.lt_s
  if
   unreachable
  end
  i32.const 32
  global.set $function-types/i32Adder
  i32.const 2
  global.set $~argumentsLength
  i32.const 1
  i32.const 2
  call $function-types/makeAdder<i32>~anonymous|0
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 11
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  global.set $~argumentsLength
  i64.const 10
  i64.const 20
  call $function-types/makeAdder<i64>~anonymous|0
  i64.const 30
  i64.ne
  if
   i32.const 0
   i32.const 64
   i32.const 15
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  global.set $~argumentsLength
  f64.const 1.5
  f64.const 2.5
  call $function-types/makeAdder<f64>~anonymous|0
  f64.const 4
  f64.ne
  if
   i32.const 0
   i32.const 64
   i32.const 17
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  global.get $function-types/i32Adder
  local.tee $1
  i32.store align=1
  i32.const 2
  i32.const 3
  local.get $1
  call $function-types/doAddWithFn<i32>
  i32.const 5
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 23
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  global.set $~argumentsLength
  i32.const 3
  i32.const 4
  call $function-types/makeAdder<i32>~anonymous|0
  i32.const 7
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 29
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 192
  i32.store align=1
  i32.const 4
  i32.const 5
  i32.const 192
  call $function-types/doAddWithFn<i32>
  i32.const 9
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 35
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2
  global.set $~argumentsLength
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i64.const 0
  i64.store align=1
  global.get $~lib/memory/__stack_pointer
  i32.const 204
  i32.lt_s
  if
   unreachable
  end
  block $1of1
   block $0of1
    block $outOfRange
     global.get $~argumentsLength
     i32.const 2
     i32.sub
     br_table $0of1 $1of1 $outOfRange
    end
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 32
   i32.store align=1
   i32.const 32
   local.set $0
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  local.get $0
  i32.store align=1
  i32.const 1
  i32.const 2
  local.get $0
  call $function-types/doAddWithFn<i32>
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 41
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 32
  i32.store align=1
  i32.const 1
  i32.const 2
  i32.const 32
  call $function-types/doAddWithFn<i32>
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 64
   i32.const 42
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
)
