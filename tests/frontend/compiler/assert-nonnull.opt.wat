(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (type $3 (func (param i32 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (memory $0 1)
 (data $0 (i32.const 12) "|")
 (data $0.1 (i32.const 24) "\02\00\00\00^\00\00\00U\00n\00e\00x\00p\00e\00c\00t\00e\00d\00 \00\'\00n\00u\00l\00l\00\'\00 \00(\00n\00o\00t\00 \00a\00s\00s\00i\00g\00n\00e\00d\00 \00o\00r\00 \00f\00a\00i\00l\00e\00d\00 \00c\00a\00s\00t\00)")
 (data $1 (i32.const 140) "<")
 (data $1.1 (i32.const 152) "\02\00\00\00\"\00\00\00a\00s\00s\00e\00r\00t\00-\00n\00o\00n\00n\00u\00l\00l\00.\00t\00s")
 (data $2 (i32.const 204) "<")
 (data $2.1 (i32.const 216) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $3 (i32.const 268) ",")
 (data $3.1 (i32.const 280) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $4 (i32.const 316) "|")
 (data $4.1 (i32.const 328) "\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y")
 (table $0 1 1 funcref)
 (export "testVar" (func $assert-nonnull/testVar))
 (export "testObj" (func $assert-nonnull/testObj))
 (export "testProp" (func $assert-nonnull/testProp))
 (export "testArr" (func $assert-nonnull/testArr))
 (export "testElem" (func $assert-nonnull/testElem))
 (export "testAll" (func $assert-nonnull/testAll))
 (export "testAll2" (func $assert-nonnull/testAll2))
 (export "testFn" (func $assert-nonnull/testFn))
 (export "testFn2" (func $assert-nonnull/testFn2))
 (export "testRet" (func $assert-nonnull/testRet))
 (export "testObjFn" (func $assert-nonnull/testObjFn))
 (export "testObjRet" (func $assert-nonnull/testObjRet))
 (export "memory" (memory $0))
 (func $assert-nonnull/testVar (param $0 i32) (result i32)
  local.get $0
  if (result i32)
   local.get $0
  else
   i32.const 32
   i32.const 160
   i32.const 2
   i32.const 10
   call $~lib/builtins/abort
   unreachable
  end
 )
 (func $assert-nonnull/testObj (param $0 i32) (result i32)
  local.get $0
  if (result i32)
   local.get $0
  else
   i32.const 32
   i32.const 160
   i32.const 11
   i32.const 10
   call $~lib/builtins/abort
   unreachable
  end
  i32.load
 )
 (func $assert-nonnull/testProp (param $0 i32) (result i32)
  local.get $0
  i32.load
  local.tee $0
  if (result i32)
   local.get $0
  else
   i32.const 32
   i32.const 160
   i32.const 15
   i32.const 10
   call $~lib/builtins/abort
   unreachable
  end
 )
 (func $assert-nonnull/testArr (param $0 i32) (result i32)
  local.get $0
  if (result i32)
   local.get $0
  else
   i32.const 32
   i32.const 160
   i32.const 19
   i32.const 10
   call $~lib/builtins/abort
   unreachable
  end
  i32.load offset=12
  i32.eqz
  if
   i32.const 224
   i32.const 288
   i32.const 129
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.load
  local.tee $0
  i32.eqz
  if
   i32.const 336
   i32.const 288
   i32.const 133
   i32.const 40
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
 )
 (func $assert-nonnull/testElem (param $0 i32) (result i32)
  local.get $0
  i32.load offset=12
  i32.eqz
  if
   i32.const 224
   i32.const 288
   i32.const 129
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  i32.load
  local.tee $0
  if (result i32)
   local.get $0
  else
   i32.const 32
   i32.const 160
   i32.const 23
   i32.const 10
   call $~lib/builtins/abort
   unreachable
  end
 )
 (func $assert-nonnull/testAll (param $0 i32) (result i32)
  local.get $0
  i32.const 27
  call $byn$mgfn-shared$assert-nonnull/testAll
 )
 (func $assert-nonnull/testAll2 (param $0 i32) (result i32)
  local.get $0
  i32.const 31
  call $byn$mgfn-shared$assert-nonnull/testAll
 )
 (func $assert-nonnull/testFn (param $0 i32) (result i32)
  local.get $0
  if (result i32)
   local.get $0
  else
   i32.const 32
   i32.const 160
   i32.const 35
   i32.const 10
   call $~lib/builtins/abort
   unreachable
  end
  i32.load
  call_indirect (type $1)
 )
 (func $assert-nonnull/testFn2 (param $0 i32) (result i32)
  local.get $0
  i32.eqz
  if
   i32.const 32
   i32.const 160
   i32.const 39
   i32.const 13
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load
  call_indirect (type $1)
 )
 (func $assert-nonnull/testRet (param $0 i32) (result i32)
  block $folding-inner0
   local.get $0
   if (result i32)
    local.get $0
   else
    br $folding-inner0
   end
   i32.load
   call_indirect (type $1)
   local.tee $0
   if (result i32)
    local.get $0
   else
    br $folding-inner0
   end
   return
  end
  i32.const 32
  i32.const 160
  i32.const 44
  i32.const 10
  call $~lib/builtins/abort
  unreachable
 )
 (func $assert-nonnull/testObjFn (param $0 i32) (result i32)
  local.get $0
  i32.load offset=4
  local.tee $0
  if (result i32)
   local.get $0
  else
   i32.const 32
   i32.const 160
   i32.const 48
   i32.const 10
   call $~lib/builtins/abort
   unreachable
  end
  i32.load
  call_indirect (type $1)
 )
 (func $assert-nonnull/testObjRet (param $0 i32) (result i32)
  block $folding-inner0
   local.get $0
   i32.load offset=4
   local.tee $0
   if (result i32)
    local.get $0
   else
    br $folding-inner0
   end
   i32.load
   call_indirect (type $1)
   local.tee $0
   if (result i32)
    local.get $0
   else
    br $folding-inner0
   end
   return
  end
  i32.const 32
  i32.const 160
  i32.const 52
  i32.const 10
  call $~lib/builtins/abort
  unreachable
 )
 (func $byn$mgfn-shared$assert-nonnull/testAll (param $0 i32) (param $1 i32) (result i32)
  block $folding-inner0
   local.get $0
   i32.eqz
   br_if $folding-inner0
   local.get $0
   i32.load offset=12
   i32.eqz
   if
    i32.const 224
    i32.const 288
    i32.const 129
    i32.const 42
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.load offset=4
   i32.load
   local.tee $0
   i32.eqz
   br_if $folding-inner0
   local.get $0
   i32.load
   local.tee $0
   if (result i32)
    local.get $0
   else
    br $folding-inner0
   end
   return
  end
  i32.const 32
  i32.const 160
  local.get $1
  i32.const 10
  call $~lib/builtins/abort
  unreachable
 )
)
