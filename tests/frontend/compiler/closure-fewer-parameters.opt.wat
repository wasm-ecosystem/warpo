(module
 (type $0 (func (param i32 i64 f64) (result i32)))
 (type $1 (func (param i64)))
 (type $2 (func (param i32)))
 (type $3 (func (result i32)))
 (type $4 (func (param i32) (result i32)))
 (type $5 (func))
 (type $6 (func (param i32 i32) (result i32)))
 (type $7 (func (param i64 f64) (result i32)))
 (type $8 (func (param i32 i32 i32)))
 (type $9 (func (param i32 i32)))
 (type $10 (func (param i32 i32 i32 i32)))
 (type $11 (func (param i32 i32 i64)))
 (type $12 (func (param i32 i64) (result i32)))
 (type $13 (func (param i32 i32 i32) (result i32)))
 (type $14 (func (param i32 i64)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/rt/closure/env (mut i32) (i32.const 0))
 (global $closure-fewer-parameters/observed (mut i32) (i32.const 32))
 (global $~lib/rt/itcms/total (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/threshold (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/state (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/visitCount (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/pinSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/iter (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/toSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/white (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/fromSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $closure-fewer-parameters/firstCallback (mut i32) (i32.const 0))
 (global $closure-fewer-parameters/secondCallback (mut i32) (i32.const 0))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33808))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02")
 (data $1 (i32.const 44) "\1c")
 (data $1.1 (i32.const 56) "\02\00\00\00\0c\00\00\00g\00l\00o\00b\00a\00l\00\1c")
 (data $2.1 (i32.const 88) "\02\00\00\00\06\00\00\00a\00b\00c")
 (data $3 (i32.const 108) "<")
 (data $3.1 (i32.const 120) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00<")
 (data $4.1 (i32.const 184) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $7 (i32.const 300) "<")
 (data $7.1 (i32.const 312) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $8 (i32.const 364) ",")
 (data $8.1 (i32.const 376) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $10 (i32.const 444) "<")
 (data $10.1 (i32.const 456) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $11 (i32.const 508) "L")
 (data $11.1 (i32.const 520) "\02\00\00\006\00\00\00c\00l\00o\00s\00u\00r\00e\00-\00f\00e\00w\00e\00r\00-\00p\00a\00r\00a\00m\00e\00t\00e\00r\00s\00.\00t\00s")
 (data $12 (i32.const 588) "\1c")
 (data $12.1 (i32.const 600) "\02\00\00\00\0c\00\00\00b\00e\00f\00o\00r\00e\00\1c")
 (data $13.1 (i32.const 632) "\02\00\00\00\n\00\00\00a\00f\00t\00e\00r\00\00\00,")
 (data $14.1 (i32.const 664) "\02\00\00\00\12\00\00\00p\00a\00r\00a\00m\00e\00t\00e\00r")
 (data $15 (i32.const 700) ",")
 (data $15.1 (i32.const 712) "\02\00\00\00\10\00\00\00m\00a\00t\00c\00h\00i\00n\00g")
 (data $16 (i32.const 748) ",")
 (data $16.1 (i32.const 760) "\02\00\00\00\0e\00\00\00l\00i\00t\00e\00r\00a\00l")
 (data $17 (i32.const 796) "\1c")
 (data $17.1 (i32.const 808) "\05\00\00\00\08\00\00\00\05")
 (data $18 (i32.const 828) "\1c")
 (data $18.1 (i32.const 840) "\05\00\00\00\08\00\00\00\06")
 (data $19 (i32.const 860) "<")
 (data $19.1 (i32.const 872) "\02\00\00\00(\00\00\00O\00b\00j\00e\00c\00t\00 \00i\00s\00 \00n\00o\00t\00 \00p\00i\00n\00n\00e\00d\00\00\00\00\00<")
 (data $20.1 (i32.const 936) "\02\00\00\00*\00\00\00O\00b\00j\00e\00c\00t\00 \00a\00l\00r\00e\00a\00d\00y\00 \00p\00i\00n\00n\00e\00d")
 (data $21 (i32.const 992) "\0b\00\00\00 \00\00\00 \00\00\00 ")
 (data $21.1 (i32.const 1028) " ")
 (table $0 19 19 funcref)
 (elem $0 (i32.const 1) $closure-fewer-parameters/testConstCapture~anonymous|0 $closure-fewer-parameters/testLetCapture~anonymous|0 $closure-fewer-parameters/testLetCapture~anonymous|0 $closure-fewer-parameters/testMatchingArity~anonymous|0 $closure-fewer-parameters/testNonCapturing~anonymous|0 $closure-fewer-parameters/testGlobalCapture~anonymous|0 $closure-fewer-parameters/testZeroParameters~anonymous|0 $closure-fewer-parameters/testOneParameter~anonymous|0 $closure-fewer-parameters/testOneParameter~anonymous|0 $closure-fewer-parameters/makeCallback~anonymous|0 $closure-fewer-parameters/testNestedParameterCapture~anonymous|0~anonymous|0 $closure-fewer-parameters/testNestedParameterCapture~anonymous|0 $closure-fewer-parameters/testTwoParameters~anonymous|0~anonymous|0 $closure-fewer-parameters/testTwoParameters~anonymous|0 $closure-fewer-parameters/ArityCapture#makeCallback~anonymous|0 $closure-fewer-parameters/testZeroParameterFFI~anonymous|0 $closure-fewer-parameters/ffiWrapper~anonymous|0 $closure-fewer-parameters/testOneParameterFFI~anonymous|0)
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/itcms/visitRoots
  (local $0 i32)
  (local $1 i32)
  global.get $closure-fewer-parameters/observed
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $closure-fewer-parameters/firstCallback
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $closure-fewer-parameters/secondCallback
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $~lib/rt/closure/env
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $~lib/rt/itcms/pinSpace
  local.tee $1
  i32.load offset=4
  i32.const -4
  i32.and
  local.set $0
  loop $while-continue|0
   local.get $0
   local.get $1
   i32.ne
   if
    local.get $0
    i32.load offset=4
    i32.const 3
    i32.and
    i32.const 3
    i32.ne
    if
     i32.const 0
     i32.const 192
     i32.const 159
     i32.const 16
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 20
    i32.add
    call $~lib/rt/__visit_members
    local.get $0
    i32.load offset=4
    i32.const -4
    i32.and
    local.set $0
    br $while-continue|0
   end
  end
 )
 (func $~lib/rt/itcms/Object#unlink (param $0 i32)
  (local $1 i32)
  local.get $0
  i32.load offset=4
  i32.const -4
  i32.and
  local.tee $1
  i32.eqz
  if
   local.get $0
   i32.load offset=8
   i32.eqz
   local.get $0
   i32.const 33808
   i32.lt_u
   i32.and
   i32.eqz
   if
    i32.const 0
    i32.const 192
    i32.const 127
    i32.const 18
    call $~lib/builtins/abort
    unreachable
   end
   return
  end
  local.get $0
  i32.load offset=8
  local.tee $0
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 131
   i32.const 16
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $0
  i32.store offset=8
  local.get $0
  local.get $1
  local.get $0
  i32.load offset=4
  i32.const 3
  i32.and
  i32.or
  i32.store offset=4
 )
 (func $~lib/rt/itcms/Object#linkTo (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  i32.load offset=8
  local.set $3
  local.get $0
  local.get $1
  local.get $2
  i32.or
  i32.store offset=4
  local.get $0
  local.get $3
  i32.store offset=8
  local.get $3
  local.get $0
  local.get $3
  i32.load offset=4
  i32.const 3
  i32.and
  i32.or
  i32.store offset=4
  local.get $1
  local.get $0
  i32.store offset=8
 )
 (func $~lib/rt/itcms/Object#makeGray (param $0 i32)
  (local $1 i32)
  local.get $0
  global.get $~lib/rt/itcms/iter
  i32.eq
  if
   local.get $0
   i32.load offset=8
   local.tee $1
   if (result i32)
    local.get $1
   else
    i32.const 0
    i32.const 192
    i32.const 147
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   end
   global.set $~lib/rt/itcms/iter
  end
  local.get $0
  call $~lib/rt/itcms/Object#unlink
  local.get $0
  global.get $~lib/rt/itcms/toSpace
  local.get $0
  i32.load offset=12
  local.tee $0
  i32.const 2
  i32.le_u
  if (result i32)
   i32.const 1
  else
   local.get $0
   i32.const 992
   i32.load
   i32.gt_u
   if
    i32.const 320
    i32.const 384
    i32.const 22
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2
   i32.shl
   i32.const 996
   i32.add
   i32.load
   i32.const 32
   i32.and
  end
  if (result i32)
   global.get $~lib/rt/itcms/white
   i32.eqz
  else
   i32.const 2
  end
  return_call $~lib/rt/itcms/Object#linkTo
 )
 (func $~lib/rt/itcms/__visit (param $0 i32)
  local.get $0
  if
   global.get $~lib/rt/itcms/white
   local.get $0
   i32.const 20
   i32.sub
   local.tee $0
   i32.load offset=4
   i32.const 3
   i32.and
   i32.eq
   if
    local.get $0
    call $~lib/rt/itcms/Object#makeGray
    global.get $~lib/rt/itcms/visitCount
    i32.const 1
    i32.add
    global.set $~lib/rt/itcms/visitCount
   end
  end
 )
 (func $~lib/rt/tlsf/removeBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $1
  i32.load
  local.tee $2
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 245
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const -4
  i32.and
  local.tee $2
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 464
   i32.const 247
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $2
   i32.const 4
   i32.shr_u
   local.set $3
   i32.const 0
  else
   i32.const 31
   i32.const 1073741820
   local.get $2
   local.get $2
   i32.const 1073741820
   i32.ge_u
   select
   local.tee $3
   i32.clz
   i32.sub
   local.set $2
   local.get $3
   local.get $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $3
   local.get $2
   i32.const 7
   i32.sub
  end
  local.set $4
  local.get $3
  i32.const 16
  i32.lt_u
  local.get $4
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 261
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load offset=8
  local.set $2
  local.get $1
  i32.load offset=4
  local.tee $5
  if
   local.get $5
   local.get $2
   i32.store offset=8
  end
  local.get $2
  if
   local.get $2
   local.get $5
   i32.store offset=4
  end
  local.get $1
  local.get $0
  local.get $4
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.tee $5
  i32.load offset=96
  i32.eq
  if
   local.get $5
   local.get $2
   i32.store offset=96
   local.get $2
   i32.eqz
   if
    local.get $0
    local.get $4
    i32.const 2
    i32.shl
    i32.add
    local.tee $1
    local.get $1
    i32.load offset=4
    i32.const -2
    local.get $3
    i32.rotl
    i32.and
    local.tee $1
    i32.store offset=4
    local.get $1
    i32.eqz
    if
     local.get $0
     local.get $0
     i32.load
     i32.const -2
     local.get $4
     i32.rotl
     i32.and
     i32.store
    end
   end
  end
 )
 (func $~lib/rt/tlsf/insertBlock (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $1
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 178
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.load
  local.tee $2
  i32.const 1
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 180
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 4
  i32.add
  local.tee $5
  local.get $1
  i32.load
  i32.const -4
  i32.and
  i32.add
  local.tee $3
  i32.load
  local.tee $4
  i32.const 1
  i32.and
  if
   local.get $0
   local.get $3
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $2
   i32.const 4
   i32.add
   local.get $4
   i32.const -4
   i32.and
   i32.add
   local.tee $2
   i32.store
   local.get $1
   i32.load
   i32.const -4
   i32.and
   local.get $5
   i32.add
   local.tee $3
   i32.load
   local.set $4
  end
  local.get $2
  i32.const 2
  i32.and
  if
   local.get $1
   i32.const 4
   i32.sub
   i32.load
   local.tee $1
   i32.load
   local.tee $5
   i32.const 1
   i32.and
   i32.eqz
   if
    i32.const 0
    i32.const 464
    i32.const 198
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   local.get $1
   call $~lib/rt/tlsf/removeBlock
   local.get $1
   local.get $5
   i32.const 4
   i32.add
   local.get $2
   i32.const -4
   i32.and
   i32.add
   local.tee $2
   i32.store
  end
  local.get $3
  local.get $4
  i32.const 2
  i32.or
  i32.store
  local.get $2
  i32.const -4
  i32.and
  local.tee $2
  i32.const 12
  i32.lt_u
  if
   i32.const 0
   i32.const 464
   i32.const 210
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  local.get $1
  i32.const 4
  i32.add
  local.get $2
  i32.add
  i32.ne
  if
   i32.const 0
   i32.const 464
   i32.const 211
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  i32.const 4
  i32.sub
  local.get $1
  i32.store
  local.get $2
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $2
   i32.const 4
   i32.shr_u
   local.set $3
   i32.const 0
  else
   i32.const 31
   i32.const 1073741820
   local.get $2
   local.get $2
   i32.const 1073741820
   i32.ge_u
   select
   local.tee $3
   i32.clz
   i32.sub
   local.set $2
   local.get $3
   local.get $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $3
   local.get $2
   i32.const 7
   i32.sub
  end
  local.set $2
  local.get $3
  i32.const 16
  i32.lt_u
  local.get $2
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 228
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $2
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=96
  local.set $4
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
  local.get $4
  i32.store offset=8
  local.get $4
  if
   local.get $4
   local.get $1
   i32.store offset=4
  end
  local.get $0
  local.get $2
  i32.const 4
  i32.shl
  local.get $3
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.get $1
  i32.store offset=96
  local.get $0
  local.get $0
  i32.load
  i32.const 1
  local.get $2
  i32.shl
  i32.or
  i32.store
  local.get $0
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  local.tee $0
  local.get $0
  i32.load offset=4
  i32.const 1
  local.get $3
  i32.shl
  i32.or
  i32.store offset=4
 )
 (func $~lib/rt/tlsf/addMemory (param $0 i32) (param $1 i32) (param $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  block $~CONDITION_RETURN/~lib/rt/tlsf/addMemory
   local.get $2
   local.get $1
   i64.extend_i32_u
   i64.lt_u
   if
    i32.const 0
    i32.const 464
    i32.const 357
    i32.const 14
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   i32.const 19
   i32.add
   i32.const -16
   i32.and
   i32.const 4
   i32.sub
   local.set $1
   local.get $0
   i32.load offset=1568
   local.tee $4
   if
    local.get $4
    i32.const 4
    i32.add
    local.get $1
    i32.gt_u
    if
     i32.const 0
     i32.const 464
     i32.const 365
     i32.const 16
     call $~lib/builtins/abort
     unreachable
    end
    local.get $1
    i32.const 16
    i32.sub
    local.tee $3
    local.get $4
    i32.eq
    if
     local.get $4
     i32.load
     local.set $5
     local.get $3
     local.set $1
    end
   else
    local.get $0
    i32.const 1572
    i32.add
    local.get $1
    i32.gt_u
    if
     i32.const 0
     i32.const 464
     i32.const 378
     i32.const 5
     call $~lib/builtins/abort
     unreachable
    end
   end
   local.get $2
   i32.wrap_i64
   i32.const -16
   i32.and
   local.get $1
   i32.sub
   local.tee $3
   i32.const 20
   i32.lt_u
   br_if $~CONDITION_RETURN/~lib/rt/tlsf/addMemory
   local.get $1
   local.get $5
   i32.const 2
   i32.and
   local.get $3
   i32.const 8
   i32.sub
   local.tee $3
   i32.const 1
   i32.or
   i32.or
   i32.store
   local.get $1
   i32.const 0
   i32.store offset=4
   local.get $1
   i32.const 0
   i32.store offset=8
   local.get $1
   i32.const 4
   i32.add
   local.get $3
   i32.add
   local.tee $3
   i32.const 2
   i32.store
   local.get $0
   local.get $3
   i32.store offset=1568
   local.get $0
   local.get $1
   return_call $~lib/rt/tlsf/insertBlock
  end
 )
 (func $~lib/rt/tlsf/initialize
  (local $0 i32)
  (local $1 i32)
  memory.size
  local.tee $0
  i32.const 0
  i32.le_s
  if (result i32)
   i32.const 1
   local.get $0
   i32.sub
   memory.grow
   i32.const 0
   i32.lt_s
  else
   i32.const 0
  end
  if
   unreachable
  end
  i32.const 33808
  i32.const 0
  i32.store
  i32.const 35376
  i32.const 0
  i32.store
  i32.const 0
  local.set $0
  loop $for-loop|0
   local.get $0
   i32.const 23
   i32.lt_u
   if
    local.get $0
    i32.const 2
    i32.shl
    i32.const 33808
    i32.add
    i32.const 0
    i32.store offset=4
    i32.const 0
    local.set $1
    loop $for-loop|1
     local.get $1
     i32.const 16
     i32.lt_u
     if
      local.get $0
      i32.const 4
      i32.shl
      local.get $1
      i32.add
      i32.const 2
      i32.shl
      i32.const 33808
      i32.add
      i32.const 0
      i32.store offset=96
      local.get $1
      i32.const 1
      i32.add
      local.set $1
      br $for-loop|1
     end
    end
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
  i32.const 33808
  i32.const 35380
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 33808
  global.set $~lib/rt/tlsf/ROOT
 )
 (func $~lib/rt/tlsf/searchBlock (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $1
  i32.const 256
  i32.lt_u
  if (result i32)
   local.get $1
   i32.const 4
   i32.shr_u
   local.set $1
   i32.const 0
  else
   i32.const 31
   local.get $1
   i32.const 1
   i32.const 27
   local.get $1
   i32.clz
   i32.sub
   i32.shl
   i32.add
   i32.const 1
   i32.sub
   local.get $1
   local.get $1
   i32.const 536870910
   i32.lt_u
   select
   local.tee $1
   i32.clz
   i32.sub
   local.set $2
   local.get $1
   local.get $2
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 16
   i32.xor
   local.set $1
   local.get $2
   i32.const 7
   i32.sub
  end
  local.set $2
  local.get $1
  i32.const 16
  i32.lt_u
  local.get $2
  i32.const 23
  i32.lt_u
  i32.and
  i32.eqz
  if
   i32.const 0
   i32.const 464
   i32.const 309
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=4
  i32.const -1
  local.get $1
  i32.shl
  i32.and
  local.tee $1
  if (result i32)
   local.get $0
   local.get $1
   i32.ctz
   local.get $2
   i32.const 4
   i32.shl
   i32.add
   i32.const 2
   i32.shl
   i32.add
   i32.load offset=96
  else
   local.get $0
   i32.load
   i32.const -1
   local.get $2
   i32.const 1
   i32.add
   i32.shl
   i32.and
   local.tee $1
   if (result i32)
    local.get $0
    local.get $1
    i32.ctz
    local.tee $1
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=4
    local.tee $2
    i32.eqz
    if
     i32.const 0
     i32.const 464
     i32.const 322
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    local.get $2
    i32.ctz
    local.get $1
    i32.const 4
    i32.shl
    i32.add
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=96
   else
    i32.const 0
   end
  end
 )
 (func $~lib/rt/itcms/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $0
  i32.const 1073741804
  i32.ge_u
  if
   i32.const 128
   i32.const 192
   i32.const 262
   i32.const 31
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/itcms/total
  global.get $~lib/rt/itcms/threshold
  i32.ge_u
  if
   block $__inlined_func$~lib/rt/itcms/interrupt$67
    i32.const 2048
    local.set $2
    loop $do-loop|0
     local.get $2
     block $__inlined_func$~lib/rt/itcms/step$112 (result i32)
      block $break|0
       block $case2|0
        block $case1|0
         block $case0|0
          global.get $~lib/rt/itcms/state
          br_table $case0|0 $case1|0 $case2|0 $break|0
         end
         i32.const 1
         global.set $~lib/rt/itcms/state
         i32.const 0
         global.set $~lib/rt/itcms/visitCount
         call $~lib/rt/itcms/visitRoots
         global.get $~lib/rt/itcms/toSpace
         global.set $~lib/rt/itcms/iter
         global.get $~lib/rt/itcms/visitCount
         br $__inlined_func$~lib/rt/itcms/step$112
        end
        global.get $~lib/rt/itcms/white
        i32.eqz
        local.set $3
        global.get $~lib/rt/itcms/iter
        i32.load offset=4
        i32.const -4
        i32.and
        local.set $2
        loop $while-continue|1
         local.get $2
         global.get $~lib/rt/itcms/toSpace
         i32.ne
         if
          local.get $2
          global.set $~lib/rt/itcms/iter
          local.get $3
          local.get $2
          i32.load offset=4
          i32.const 3
          i32.and
          i32.ne
          if
           local.get $2
           local.get $2
           i32.load offset=4
           i32.const -4
           i32.and
           local.get $3
           i32.or
           i32.store offset=4
           i32.const 0
           global.set $~lib/rt/itcms/visitCount
           local.get $2
           i32.const 20
           i32.add
           call $~lib/rt/__visit_members
           global.get $~lib/rt/itcms/visitCount
           br $__inlined_func$~lib/rt/itcms/step$112
          end
          local.get $2
          i32.load offset=4
          i32.const -4
          i32.and
          local.set $2
          br $while-continue|1
         end
        end
        i32.const 0
        global.set $~lib/rt/itcms/visitCount
        call $~lib/rt/itcms/visitRoots
        global.get $~lib/rt/itcms/toSpace
        global.get $~lib/rt/itcms/iter
        i32.load offset=4
        i32.const -4
        i32.and
        i32.eq
        if
         global.get $~lib/memory/__stack_pointer
         local.set $2
         loop $while-continue|0
          local.get $2
          i32.const 33808
          i32.lt_u
          if
           local.get $2
           i32.load
           call $~lib/rt/itcms/__visit
           local.get $2
           i32.const 4
           i32.add
           local.set $2
           br $while-continue|0
          end
         end
         global.get $~lib/rt/itcms/iter
         i32.load offset=4
         i32.const -4
         i32.and
         local.set $2
         loop $while-continue|2
          local.get $2
          global.get $~lib/rt/itcms/toSpace
          i32.ne
          if
           local.get $3
           local.get $2
           i32.load offset=4
           i32.const 3
           i32.and
           i32.ne
           if
            local.get $2
            local.get $2
            i32.load offset=4
            i32.const -4
            i32.and
            local.get $3
            i32.or
            i32.store offset=4
            local.get $2
            i32.const 20
            i32.add
            call $~lib/rt/__visit_members
           end
           local.get $2
           i32.load offset=4
           i32.const -4
           i32.and
           local.set $2
           br $while-continue|2
          end
         end
         global.get $~lib/rt/itcms/fromSpace
         local.set $2
         global.get $~lib/rt/itcms/toSpace
         global.set $~lib/rt/itcms/fromSpace
         local.get $2
         global.set $~lib/rt/itcms/toSpace
         local.get $3
         global.set $~lib/rt/itcms/white
         local.get $2
         i32.load offset=4
         i32.const -4
         i32.and
         global.set $~lib/rt/itcms/iter
         i32.const 2
         global.set $~lib/rt/itcms/state
        end
        global.get $~lib/rt/itcms/visitCount
        br $__inlined_func$~lib/rt/itcms/step$112
       end
       global.get $~lib/rt/itcms/iter
       local.tee $2
       global.get $~lib/rt/itcms/toSpace
       i32.ne
       if
        local.get $2
        i32.load offset=4
        i32.const -4
        i32.and
        global.set $~lib/rt/itcms/iter
        global.get $~lib/rt/itcms/white
        i32.eqz
        local.get $2
        i32.load offset=4
        i32.const 3
        i32.and
        i32.ne
        if
         i32.const 0
         i32.const 192
         i32.const 229
         i32.const 20
         call $~lib/builtins/abort
         unreachable
        end
        local.get $2
        i32.const 33808
        i32.lt_u
        if
         local.get $2
         i32.const 0
         i32.store offset=4
         local.get $2
         i32.const 0
         i32.store offset=8
        else
         global.get $~lib/rt/itcms/total
         local.get $2
         i32.load
         i32.const -4
         i32.and
         i32.const 4
         i32.add
         i32.sub
         global.set $~lib/rt/itcms/total
         local.get $2
         i32.const 4
         i32.add
         local.tee $3
         i32.const 33808
         i32.ge_u
         if
          global.get $~lib/rt/tlsf/ROOT
          i32.eqz
          if
           call $~lib/rt/tlsf/initialize
          end
          global.get $~lib/rt/tlsf/ROOT
          local.set $4
          local.get $3
          i32.const 4
          i32.sub
          local.set $2
          local.get $3
          i32.const 15
          i32.and
          i32.const 1
          local.get $3
          select
          if (result i32)
           i32.const 1
          else
           local.get $2
           i32.load
           i32.const 1
           i32.and
          end
          if
           i32.const 0
           i32.const 464
           i32.const 532
           i32.const 3
           call $~lib/builtins/abort
           unreachable
          end
          local.get $2
          local.get $2
          i32.load
          i32.const 1
          i32.or
          i32.store
          local.get $4
          local.get $2
          call $~lib/rt/tlsf/insertBlock
         end
        end
        i32.const 10
        br $__inlined_func$~lib/rt/itcms/step$112
       end
       global.get $~lib/rt/itcms/toSpace
       global.get $~lib/rt/itcms/toSpace
       i32.store offset=4
       global.get $~lib/rt/itcms/toSpace
       global.get $~lib/rt/itcms/toSpace
       i32.store offset=8
       i32.const 0
       global.set $~lib/rt/itcms/state
      end
      i32.const 0
     end
     i32.sub
     local.set $2
     global.get $~lib/rt/itcms/state
     i32.eqz
     if
      global.get $~lib/rt/itcms/total
      i32.const 1
      i32.shl
      i32.const 1024
      i32.add
      global.set $~lib/rt/itcms/threshold
      br $__inlined_func$~lib/rt/itcms/interrupt$67
     end
     local.get $2
     i32.const 0
     i32.gt_s
     br_if $do-loop|0
    end
    global.get $~lib/rt/itcms/total
    global.get $~lib/rt/itcms/total
    global.get $~lib/rt/itcms/threshold
    i32.sub
    i32.const 1024
    i32.lt_u
    i32.const 10
    i32.shl
    i32.add
    global.set $~lib/rt/itcms/threshold
   end
  end
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   call $~lib/rt/tlsf/initialize
  end
  global.get $~lib/rt/tlsf/ROOT
  local.set $4
  local.get $0
  i32.const 16
  i32.add
  local.tee $2
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 128
   i32.const 464
   i32.const 435
   i32.const 29
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 12
  local.get $2
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.get $2
  i32.const 12
  i32.le_u
  select
  local.tee $3
  call $~lib/rt/tlsf/searchBlock
  local.tee $2
  i32.eqz
  if
   i32.const 4
   local.get $4
   i32.load offset=1568
   memory.size
   local.tee $2
   i32.const 16
   i32.shl
   i32.const 4
   i32.sub
   i32.ne
   i32.shl
   local.get $3
   i32.const 1
   i32.const 27
   local.get $3
   i32.clz
   i32.sub
   i32.shl
   i32.add
   i32.const 1
   i32.sub
   local.get $3
   local.get $3
   i32.const 536870910
   i32.lt_u
   select
   local.get $3
   local.get $3
   i32.const 256
   i32.ge_u
   select
   i32.add
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.set $5
   local.get $2
   local.get $5
   local.get $2
   local.get $5
   i32.gt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $5
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
   local.get $4
   local.get $2
   i32.const 16
   i32.shl
   memory.size
   i64.extend_i32_s
   i64.const 16
   i64.shl
   call $~lib/rt/tlsf/addMemory
   local.get $4
   local.get $3
   call $~lib/rt/tlsf/searchBlock
   local.tee $2
   i32.eqz
   if
    i32.const 0
    i32.const 464
    i32.const 472
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $3
  local.get $2
  i32.load
  i32.const -4
  i32.and
  i32.gt_u
  if
   i32.const 0
   i32.const 464
   i32.const 474
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  local.get $2
  call $~lib/rt/tlsf/removeBlock
  local.get $2
  i32.load
  local.set $5
  local.get $3
  i32.const 4
  i32.add
  i32.const 15
  i32.and
  if
   i32.const 0
   i32.const 464
   i32.const 336
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  i32.const -4
  i32.and
  local.get $3
  i32.sub
  local.tee $6
  i32.const 16
  i32.ge_u
  if
   local.get $2
   local.get $3
   local.get $5
   i32.const 2
   i32.and
   i32.or
   i32.store
   local.get $2
   i32.const 4
   i32.add
   local.get $3
   i32.add
   local.tee $3
   local.get $6
   i32.const 4
   i32.sub
   i32.const 1
   i32.or
   i32.store
   local.get $4
   local.get $3
   call $~lib/rt/tlsf/insertBlock
  else
   local.get $2
   local.get $5
   i32.const -2
   i32.and
   i32.store
   local.get $2
   i32.const 4
   i32.add
   local.get $2
   i32.load
   i32.const -4
   i32.and
   i32.add
   local.tee $3
   local.get $3
   i32.load
   i32.const -3
   i32.and
   i32.store
  end
  local.get $2
  local.get $1
  i32.store offset=12
  local.get $2
  local.get $0
  i32.store offset=16
  local.get $2
  global.get $~lib/rt/itcms/fromSpace
  global.get $~lib/rt/itcms/white
  call $~lib/rt/itcms/Object#linkTo
  global.get $~lib/rt/itcms/total
  local.get $2
  i32.load
  i32.const -4
  i32.and
  i32.const 4
  i32.add
  i32.add
  global.set $~lib/rt/itcms/total
  local.get $2
  i32.const 20
  i32.add
  local.tee $1
  i32.const 0
  local.get $0
  memory.fill
  local.get $1
 )
 (func $~lib/rt/__newTuple (param $0 i32) (param $1 i64) (result i32)
  (local $2 i32)
  local.get $0
  local.get $0
  i32.const 8
  i32.add
  i32.const 4
  call $~lib/rt/itcms/__new
  local.tee $2
  i32.add
  local.get $1
  i64.store
  local.get $2
 )
 (func $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null> (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $0
  local.get $1
  i32.add
  local.get $2
  i32.store
  local.get $2
  if
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 192
    i32.const 296
    i32.const 14
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/rt/itcms/white
   local.get $2
   i32.const 20
   i32.sub
   local.tee $1
   i32.load offset=4
   i32.const 3
   i32.and
   i32.eq
   if
    local.get $0
    i32.const 20
    i32.sub
    i32.load offset=4
    i32.const 3
    i32.and
    local.tee $0
    global.get $~lib/rt/itcms/white
    i32.eqz
    i32.eq
    if
     local.get $1
     return_call $~lib/rt/itcms/Object#makeGray
    else
     global.get $~lib/rt/itcms/state
     i32.const 1
     i32.eq
     local.get $0
     i32.const 3
     i32.eq
     i32.and
     if
      local.get $1
      return_call $~lib/rt/itcms/Object#makeGray
     end
    end
   end
  end
 )
 (func $closure-fewer-parameters/testConstCapture~anonymous|0 (param $0 i64)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 96
  global.set $closure-fewer-parameters/observed
 )
 (func $~lib/rt/__newFunction (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  i32.const 8
  local.get $2
  call $~lib/rt/itcms/__new
  local.tee $2
  local.get $0
  i32.store
  local.get $2
  i32.const 4
  i32.add
  local.get $1
  i32.store
  local.get $2
 )
 (func $closure-fewer-parameters/setT (param $0 i32) (param $1 i64)
  local.get $0
  i32.load offset=4
  global.set $~lib/rt/closure/env
  local.get $1
  local.get $0
  i32.load
  return_call_indirect (type $1)
 )
 (func $~lib/string/String.__eq (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  local.get $1
  i32.eq
  if
   i32.const 1
   return
  end
  local.get $1
  i32.eqz
  local.get $0
  i32.eqz
  i32.or
  if
   i32.const 0
   return
  end
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  local.tee $3
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.ne
  if
   i32.const 0
   return
  end
  block $__inlined_func$~lib/util/string/compareImpl$74 (result i32)
   local.get $0
   local.tee $2
   i32.const 7
   i32.and
   local.get $1
   i32.const 7
   i32.and
   i32.or
   i32.eqz
   local.get $3
   local.tee $0
   i32.const 4
   i32.ge_u
   i32.and
   if
    loop $do-loop|0
     local.get $2
     i64.load
     local.get $1
     i64.load
     i64.eq
     if
      local.get $2
      i32.const 8
      i32.add
      local.set $2
      local.get $1
      i32.const 8
      i32.add
      local.set $1
      local.get $0
      i32.const 4
      i32.sub
      local.tee $0
      i32.const 4
      i32.ge_u
      br_if $do-loop|0
     end
    end
   end
   loop $while-continue|1
    local.get $0
    local.tee $3
    i32.const 1
    i32.sub
    local.set $0
    local.get $3
    if
     local.get $2
     i32.load16_u
     local.tee $3
     local.get $1
     i32.load16_u
     local.tee $4
     i32.ne
     if
      local.get $3
      local.get $4
      i32.sub
      br $__inlined_func$~lib/util/string/compareImpl$74
     end
     local.get $2
     i32.const 2
     i32.add
     local.set $2
     local.get $1
     i32.const 2
     i32.add
     local.set $1
     br $while-continue|1
    end
   end
   i32.const 0
  end
  i32.eqz
 )
 (func $closure-fewer-parameters/testLetCapture~anonymous|0 (param $0 i64)
  (local $1 i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $1
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $1
  i32.load
  i32.const 4
  i32.add
  i32.load
  global.set $closure-fewer-parameters/observed
 )
 (func $closure-fewer-parameters/testMatchingArity~anonymous|0 (param $0 i64)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $0
  i64.const 42
  i64.ne
  if
   i32.const 0
   i32.const 528
   i32.const 42
   i32.const 5
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 720
  global.set $closure-fewer-parameters/observed
 )
 (func $closure-fewer-parameters/testNonCapturing~anonymous|0 (param $0 i64)
  i32.const 768
  global.set $closure-fewer-parameters/observed
 )
 (func $closure-fewer-parameters/testGlobalCapture~anonymous|0 (param $0 i64)
  i32.const 64
  global.set $closure-fewer-parameters/observed
 )
 (func $closure-fewer-parameters/testZeroParameters~anonymous|0 (param $0 i32) (param $1 i64) (param $2 f64) (result i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 42
 )
 (func $closure-fewer-parameters/invokeMixed (param $0 i32) (result i32)
  local.get $0
  i32.load offset=4
  global.set $~lib/rt/closure/env
  i32.const 2
  i64.const 3
  f64.const 4.5
  local.get $0
  i32.load
  return_call_indirect (type $0)
 )
 (func $closure-fewer-parameters/testOneParameter~anonymous|0 (param $0 i32) (param $1 i64) (param $2 f64) (result i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $0
  i32.const 40
  i32.add
 )
 (func $closure-fewer-parameters/makeCallback~anonymous|0 (param $0 i32) (param $1 i64) (param $2 f64) (result i32)
  (local $3 i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $3
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $0
  local.get $3
  i32.load
  i32.const 4
  i32.add
  i32.load
  i32.add
 )
 (func $closure-fewer-parameters/testNestedParameterCapture~anonymous|0~anonymous|0 (result i32)
  (local $0 i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $0
  i32.load
  local.tee $0
  i32.const 4
  i32.add
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 1
  i32.add
  i32.store
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 40
  i32.add
 )
 (func $closure-fewer-parameters/testNestedParameterCapture~anonymous|0 (param $0 i32) (param $1 i64) (param $2 f64) (result i32)
  (local $3 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 8
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $3
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $3
  i32.const 4
  i32.add
  local.get $0
  i32.store
  i32.const 11
  local.get $3
  i32.const 7
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.load offset=4
  global.set $~lib/rt/closure/env
  local.get $0
  i32.load
  call_indirect (type $3)
  local.get $0
  i32.load offset=4
  global.set $~lib/rt/closure/env
  local.get $0
  i32.load
  call_indirect (type $3)
  i32.add
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $closure-fewer-parameters/testTwoParameters~anonymous|0~anonymous|0 (result i32)
  (local $0 i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $0
  i32.load
  local.tee $0
  i32.const 8
  i32.add
  i64.load
  i32.wrap_i64
  local.get $0
  i32.const 4
  i32.add
  i32.load
  i32.const 37
  i32.add
  i32.add
 )
 (func $closure-fewer-parameters/testTwoParameters~anonymous|0 (param $0 i32) (param $1 i64) (param $2 f64) (result i32)
  (local $3 i32)
  i32.const 16
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $3
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $3
  i32.const 4
  i32.add
  local.get $0
  i32.store
  local.get $3
  i32.const 8
  i32.add
  local.get $1
  i64.store
  i32.const 13
  local.get $3
  i32.const 7
  call $~lib/rt/__newFunction
  local.tee $0
  i32.load offset=4
  global.set $~lib/rt/closure/env
  local.get $0
  i32.load
  return_call_indirect (type $3)
 )
 (func $closure-fewer-parameters/ArityCapture#makeCallback~anonymous|0 (param $0 i32) (param $1 i64) (param $2 f64) (result i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $0
  i32.load
  i32.const 4
  i32.add
  i32.load
  i32.load
 )
 (func $closure-fewer-parameters/testZeroParameterFFI~anonymous|0 (param $0 i64) (param $1 f64) (result i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 42
 )
 (func $closure-fewer-parameters/ffiWrapper~anonymous|0 (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $1
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $1
  local.get $0
  i32.store
  local.get $0
  if
   local.get $0
   i32.const 20
   i32.sub
   local.tee $0
   i32.load offset=4
   i32.const 3
   i32.and
   i32.const 3
   i32.ne
   if
    i32.const 880
    i32.const 192
    i32.const 352
    i32.const 5
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/rt/itcms/state
   i32.const 1
   i32.eq
   if
    local.get $0
    call $~lib/rt/itcms/Object#makeGray
   else
    local.get $0
    call $~lib/rt/itcms/Object#unlink
    local.get $0
    global.get $~lib/rt/itcms/fromSpace
    global.get $~lib/rt/itcms/white
    call $~lib/rt/itcms/Object#linkTo
   end
  end
  local.get $1
  i32.load
  i32.const 4
  i32.add
  i32.load
  local.tee $0
  i32.load offset=4
  global.set $~lib/rt/closure/env
  i64.const 2
  f64.const 4.5
  local.get $0
  i32.load
  return_call_indirect (type $7)
 )
 (func $closure-fewer-parameters/ffiWrapper (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 8
  i64.const 3
  call $~lib/rt/__newTuple
  local.tee $1
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  local.get $1
  i32.const 4
  local.get $0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 17
  local.get $1
  i32.const 10
  call $~lib/rt/__newFunction
  local.tee $0
  i32.load offset=4
  local.tee $1
  if
   local.get $1
   i32.const 20
   i32.sub
   local.tee $1
   i32.load offset=4
   i32.const 3
   i32.and
   i32.const 3
   i32.eq
   if
    i32.const 944
    i32.const 192
    i32.const 338
    i32.const 7
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   call $~lib/rt/itcms/Object#unlink
   local.get $1
   global.get $~lib/rt/itcms/pinSpace
   i32.const 3
   call $~lib/rt/itcms/Object#linkTo
  end
  local.get $0
  i32.load offset=4
  local.get $0
  i32.load
  return_call_indirect (type $4)
 )
 (func $closure-fewer-parameters/testOneParameterFFI~anonymous|0 (param $0 i64) (param $1 f64) (result i32)
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  i32.const 0
  global.get $~lib/rt/closure/env
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $0
  i32.wrap_i64
  i32.const 40
  i32.add
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  (local $1 i64)
  block $folding-inner0
   block $invalid
    block $closure-fewer-parameters/ArityCapture
     block $~lib/tuple/SmallTuple
      block $~lib/arraybuffer/ArrayBufferView
       local.get $0
       i32.const 8
       i32.sub
       i32.load
       br_table $closure-fewer-parameters/ArityCapture $closure-fewer-parameters/ArityCapture $closure-fewer-parameters/ArityCapture $~lib/arraybuffer/ArrayBufferView $~lib/tuple/SmallTuple $folding-inner0 $folding-inner0 $folding-inner0 $closure-fewer-parameters/ArityCapture $folding-inner0 $folding-inner0 $invalid
      end
      local.get $0
      i32.load
      return_call $~lib/rt/itcms/__visit
     end
     local.get $0
     local.get $0
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.add
     i32.const 8
     i32.sub
     i64.load
     local.set $1
     loop $while-continue|0
      local.get $1
      i64.const 0
      i64.ne
      if
       local.get $0
       local.get $1
       i64.ctz
       i32.wrap_i64
       i32.const 2
       i32.shl
       i32.add
       i32.load
       call $~lib/rt/itcms/__visit
       local.get $1
       local.get $1
       i64.const 1
       i64.sub
       i64.and
       local.set $1
       br $while-continue|0
      end
     end
     return
    end
    return
   end
   unreachable
  end
  local.get $0
  i32.load offset=4
  return_call $~lib/rt/itcms/__visit
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  memory.size
  i32.const 16
  i32.shl
  i32.const 33808
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 244
  i32.const 240
  i32.store
  i32.const 248
  i32.const 240
  i32.store
  i32.const 240
  global.set $~lib/rt/itcms/pinSpace
  i32.const 276
  i32.const 272
  i32.store
  i32.const 280
  i32.const 272
  i32.store
  i32.const 272
  global.set $~lib/rt/itcms/toSpace
  i32.const 420
  i32.const 416
  i32.store
  i32.const 424
  i32.const 416
  i32.store
  i32.const 416
  global.set $~lib/rt/itcms/fromSpace
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 1
  local.get $0
  i32.const 5
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i64.const 0
  call $closure-fewer-parameters/setT
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $closure-fewer-parameters/observed
  i32.const 96
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 139
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 8
  call $~lib/rt/__decrease_sp
  i32.const 8
  i64.const 3
  call $~lib/rt/__newTuple
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=4 align=1
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  local.get $0
  i32.const 4
  i32.const 608
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 2
  local.get $0
  i32.const 5
  call $~lib/rt/__newFunction
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $0
  i32.const 4
  i32.const 640
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  local.get $1
  i64.const 0
  call $closure-fewer-parameters/setT
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $closure-fewer-parameters/observed
  i32.const 640
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 141
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 8
  i64.const 3
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  local.get $0
  i32.const 4
  i32.const 672
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 3
  local.get $0
  i32.const 5
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i64.const 0
  call $closure-fewer-parameters/setT
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $closure-fewer-parameters/observed
  i32.const 672
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 143
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 4
  local.get $0
  i32.const 5
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i64.const 42
  call $closure-fewer-parameters/setT
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $closure-fewer-parameters/observed
  i32.const 720
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 145
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 816
  i64.const 0
  call $closure-fewer-parameters/setT
  global.get $closure-fewer-parameters/observed
  i32.const 768
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 147
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 848
  i64.const 0
  call $closure-fewer-parameters/setT
  global.get $closure-fewer-parameters/observed
  i32.const 64
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 149
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 7
  local.get $0
  i32.const 6
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $closure-fewer-parameters/invokeMixed
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 150
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 8
  local.get $0
  i32.const 6
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $closure-fewer-parameters/invokeMixed
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 151
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 9
  local.get $0
  i32.const 6
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $closure-fewer-parameters/invokeMixed
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 152
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 8
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  local.get $0
  i32.const 4
  i32.add
  i32.const 40
  i32.store
  i32.const 10
  local.get $0
  i32.const 6
  call $~lib/rt/__newFunction
  global.set $closure-fewer-parameters/firstCallback
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 8
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  local.get $0
  i32.const 4
  i32.add
  i32.const 100
  i32.store
  i32.const 10
  local.get $0
  i32.const 6
  call $~lib/rt/__newFunction
  global.set $closure-fewer-parameters/secondCallback
  global.get $closure-fewer-parameters/firstCallback
  call $closure-fewer-parameters/invokeMixed
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 155
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $closure-fewer-parameters/secondCallback
  call $closure-fewer-parameters/invokeMixed
  i32.const 102
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 156
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $closure-fewer-parameters/firstCallback
  call $closure-fewer-parameters/invokeMixed
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 157
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 12
  local.get $0
  i32.const 6
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $closure-fewer-parameters/invokeMixed
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 87
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 158
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 14
  local.get $0
  i32.const 6
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $closure-fewer-parameters/invokeMixed
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 159
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  i32.const 8
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  i32.const 42
  i32.store
  i32.const 8
  i64.const 3
  call $~lib/rt/__newTuple
  local.tee $1
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  local.get $1
  i32.const 4
  local.get $0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 15
  local.get $1
  i32.const 6
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $closure-fewer-parameters/invokeMixed
  i32.const 42
  i32.ne
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  if
   i32.const 0
   i32.const 528
   i32.const 160
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 16
  local.get $0
  i32.const 9
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $closure-fewer-parameters/ffiWrapper
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 161
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 4
  i64.const 1
  call $~lib/rt/__newTuple
  local.tee $0
  i32.const 0
  i32.const 0
  call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
  i32.const 0
  global.set $~lib/rt/closure/env
  i32.const 18
  local.get $0
  i32.const 9
  call $~lib/rt/__newFunction
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $closure-fewer-parameters/ffiWrapper
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 42
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 162
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
 )
 (func $~lib/rt/__decrease_sp (param $0 i32)
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.sub
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  i32.const 0
  local.get $0
  memory.fill
  global.get $~lib/memory/__stack_pointer
  i32.const 1040
  i32.lt_s
  if
   unreachable
  end
 )
)
