(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (param i32 i32 i32) (result i32)))
 (type $2 (func (param i32 i32 i32)))
 (type $3 (func (param i32 i32)))
 (type $4 (func (param i32)))
 (type $5 (func))
 (type $6 (func (param i32) (result i32)))
 (type $7 (func (param i32 i32 i32 i32)))
 (type $8 (func (param i32 i32 i64)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 35652))
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
 (global $std/readonlyarray/source (mut i32) (i32.const 0))
 (global $std/readonlyarray/values (mut i32) (i32.const 0))
 (global $~lib/rt/closure/env (mut i32) (i32.const 0))
 (global $std/readonlyarray/nestedSource (mut i32) (i32.const 0))
 (global $std/readonlyarray/nested (mut i32) (i32.const 0))
 (global $std/readonlyarray/flattened (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) ",")
 (data $0.1 (i32.const 24) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00,")
 (data $1.1 (i32.const 72) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00<")
 (data $2.1 (i32.const 120) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00<")
 (data $3.1 (i32.const 184) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $6 (i32.const 300) "<")
 (data $6.1 (i32.const 312) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $7 (i32.const 364) ",")
 (data $7.1 (i32.const 376) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $9 (i32.const 444) "<")
 (data $9.1 (i32.const 456) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $10 (i32.const 508) "<")
 (data $10.1 (i32.const 520) "\02\00\00\00(\00\00\00s\00t\00d\00/\00r\00e\00a\00d\00o\00n\00l\00y\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00\00\00\1c")
 (data $11.1 (i32.const 584) "\06\00\00\00\08\00\00\00\01")
 (data $12 (i32.const 604) "\1c")
 (data $12.1 (i32.const 616) "\06\00\00\00\08\00\00\00\02")
 (data $13 (i32.const 636) "\1c")
 (data $13.1 (i32.const 648) "\06\00\00\00\08\00\00\00\04")
 (data $14 (i32.const 668) "\1c")
 (data $14.1 (i32.const 680) "\06\00\00\00\08\00\00\00\05")
 (data $15 (i32.const 700) "\1c")
 (data $15.1 (i32.const 712) "\06\00\00\00\08\00\00\00\06")
 (data $16 (i32.const 732) "<")
 (data $16.1 (i32.const 744) "\02\00\00\00 \00\00\00i\00n\00v\00a\00l\00i\00d\00 \00d\00o\00w\00n\00c\00a\00s\00t")
 (data $17 (i32.const 796) "\1c")
 (data $17.1 (i32.const 808) "\02\00\00\00\02\00\00\00-")
 (data $18 (i32.const 828) ",")
 (data $18.1 (i32.const 840) "\02\00\00\00\0e\00\00\001\00-\002\00-\003\00-\002")
 (data $19 (i32.const 876) ",")
 (data $19.1 (i32.const 888) "\02\00\00\00\0e\00\00\001\00,\002\00,\003\00,\002")
 (data $20 (i32.const 924) "\1c")
 (data $20.1 (i32.const 936) "\01\00\00\00\08\00\00\00\01\00\00\00\02")
 (data $21 (i32.const 956) "\1c")
 (data $21.1 (i32.const 968) "\01\00\00\00\08\00\00\00\03\00\00\00\04")
 (data $22 (i32.const 988) "\1c")
 (data $22.1 (i32.const 1000) "\02")
 (data $23 (i32.const 1020) "|")
 (data $23.1 (i32.const 1032) "\02\00\00\00d\00\00\00t\00o\00S\00t\00r\00i\00n\00g\00(\00)\00 \00r\00a\00d\00i\00x\00 \00a\00r\00g\00u\00m\00e\00n\00t\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006")
 (data $24 (i32.const 1148) "<")
 (data $24.1 (i32.const 1160) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00u\00t\00i\00l\00/\00n\00u\00m\00b\00e\00r\00.\00t\00s")
 (data $25 (i32.const 1212) "\1c")
 (data $25.1 (i32.const 1224) "\02\00\00\00\02\00\00\000")
 (data $26 (i32.const 1244) "0\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\00\1c\04")
 (data $27.1 (i32.const 1656) "\02\00\00\00\00\04\00\000\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\000\00a\000\00b\000\00c\000\00d\000\00e\000\00f\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\00a\001\00b\001\00c\001\00d\001\00e\001\00f\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\002\00a\002\00b\002\00c\002\00d\002\00e\002\00f\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\003\00a\003\00b\003\00c\003\00d\003\00e\003\00f\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\004\00a\004\00b\004\00c\004\00d\004\00e\004\00f\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\005\00a\005\00b\005\00c\005\00d\005\00e\005\00f\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\006\00a\006\00b\006\00c\006\00d\006\00e\006\00f\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\007\00a\007\00b\007\00c\007\00d\007\00e\007\00f\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\008\00a\008\00b\008\00c\008\00d\008\00e\008\00f\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\009\00a\009\00b\009\00c\009\00d\009\00e\009\00f\00a\000\00a\001\00a\002\00a\003\00a\004\00a\005\00a\006\00a\007\00a\008\00a\009\00a\00a\00a\00b\00a\00c\00a\00d\00a\00e\00a\00f\00b\000\00b\001\00b\002\00b\003\00b\004\00b\005\00b\006\00b\007\00b\008\00b\009\00b\00a\00b\00b\00b\00c\00b\00d\00b\00e\00b\00f\00c\000\00c\001\00c\002\00c\003\00c\004\00c\005\00c\006\00c\007\00c\008\00c\009\00c\00a\00c\00b\00c\00c\00c\00d\00c\00e\00c\00f\00d\000\00d\001\00d\002\00d\003\00d\004\00d\005\00d\006\00d\007\00d\008\00d\009\00d\00a\00d\00b\00d\00c\00d\00d\00d\00e\00d\00f\00e\000\00e\001\00e\002\00e\003\00e\004\00e\005\00e\006\00e\007\00e\008\00e\009\00e\00a\00e\00b\00e\00c\00e\00d\00e\00e\00e\00f\00f\000\00f\001\00f\002\00f\003\00f\004\00f\005\00f\006\00f\007\00f\008\00f\009\00f\00a\00f\00b\00f\00c\00f\00d\00f\00e\00f\00f")
 (data $28 (i32.const 2700) "\\")
 (data $28.1 (i32.const 2712) "\02\00\00\00H\00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00\1c")
 (data $29.1 (i32.const 2808) "\02\00\00\00\02\00\00\00,")
 (data $30 (i32.const 2832) "\0c\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\02\t")
 (data $30.1 (i32.const 2868) " \00\00\00\02A")
 (table $0 7 7 funcref)
 (elem $0 (i32.const 1) $std/readonlyarray/checkReadonlyArray~anonymous|0 $std/readonlyarray/checkReadonlyArray~anonymous|1 $std/readonlyarray/checkReadonlyArray~anonymous|2 $std/readonlyarray/checkReadonlyArray~anonymous|3 $std/readonlyarray/checkReadonlyArray~anonymous|4 $std/readonlyarray/checkReadonlyArray~anonymous|5)
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/itcms/visitRoots
  (local $0 i32)
  (local $1 i32)
  global.get $std/readonlyarray/source
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $std/readonlyarray/values
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $std/readonlyarray/nestedSource
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $std/readonlyarray/nested
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $std/readonlyarray/flattened
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
  (local $2 i32)
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
  block $__inlined_func$~lib/rt/itcms/Object#unlink$173
   local.get $0
   i32.load offset=4
   i32.const -4
   i32.and
   local.tee $2
   i32.eqz
   if
    local.get $0
    i32.load offset=8
    i32.eqz
    local.get $0
    i32.const 35652
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
    br $__inlined_func$~lib/rt/itcms/Object#unlink$173
   end
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 192
    i32.const 131
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $2
   local.get $1
   i32.store offset=8
   local.get $1
   local.get $2
   local.get $1
   i32.load offset=4
   i32.const 3
   i32.and
   i32.or
   i32.store offset=4
  end
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
   i32.const 2832
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
   i32.const 2836
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
  i32.eqz
  if
   return
  end
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
  if
   return
  end
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
  i32.const 35664
  i32.const 0
  i32.store
  i32.const 37232
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
    i32.const 35664
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
      i32.const 35664
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
  i32.const 35664
  i32.const 37236
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 35664
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
     block $__inlined_func$~lib/rt/itcms/step$178 (result i32)
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
         br $__inlined_func$~lib/rt/itcms/step$178
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
           br $__inlined_func$~lib/rt/itcms/step$178
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
          i32.const 35652
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
        br $__inlined_func$~lib/rt/itcms/step$178
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
        i32.const 35652
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
         i32.const 35652
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
        br $__inlined_func$~lib/rt/itcms/step$178
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
 (func $~lib/rt/itcms/__link (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  i32.eqz
  if
   return
  end
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
  local.get $1
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
   local.tee $0
   i32.load offset=4
   i32.const 3
   i32.and
   local.tee $3
   global.get $~lib/rt/itcms/white
   i32.eqz
   i32.eq
   if
    local.get $0
    local.get $1
    local.get $2
    select
    return_call $~lib/rt/itcms/Object#makeGray
   else
    global.get $~lib/rt/itcms/state
    i32.const 1
    i32.eq
    local.get $3
    i32.const 3
    i32.eq
    i32.and
    if
     local.get $1
     return_call $~lib/rt/itcms/Object#makeGray
    end
   end
  end
 )
 (func $~lib/array/ensureCapacity (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  local.tee $2
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   local.get $1
   i32.const 268435455
   i32.gt_u
   if
    i32.const 32
    i32.const 80
    i32.const 31
    i32.const 48
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.load
   local.tee $4
   block $__inlined_func$~lib/rt/itcms/__renew$179 (result i32)
    i32.const 1073741820
    local.get $2
    i32.const 1
    i32.shl
    local.tee $2
    local.get $2
    i32.const 1073741820
    i32.ge_u
    select
    local.tee $2
    i32.const 8
    local.get $1
    local.get $1
    i32.const 8
    i32.le_u
    select
    i32.const 2
    i32.shl
    local.tee $1
    local.get $1
    local.get $2
    i32.lt_u
    select
    local.tee $3
    local.get $4
    i32.const 20
    i32.sub
    local.tee $1
    i32.load
    i32.const -4
    i32.and
    i32.const 16
    i32.sub
    i32.le_u
    if
     local.get $1
     local.get $3
     i32.store offset=16
     local.get $4
     br $__inlined_func$~lib/rt/itcms/__renew$179
    end
    local.get $3
    local.get $1
    i32.load offset=12
    call $~lib/rt/itcms/__new
    local.tee $2
    local.get $4
    local.get $3
    local.get $1
    i32.load offset=16
    local.tee $1
    local.get $1
    local.get $3
    i32.gt_u
    select
    memory.copy
    local.get $2
   end
   local.tee $1
   i32.ne
   if
    local.get $0
    local.get $1
    i32.store
    local.get $0
    local.get $1
    i32.store offset=4
    local.get $0
    local.get $1
    i32.const 0
    call $~lib/rt/itcms/__link
   end
   local.get $0
   local.get $3
   i32.store offset=8
  end
 )
 (func $~lib/array/Array<i32>#push (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $0
  i32.load offset=12
  local.tee $2
  i32.const 1
  i32.add
  local.tee $3
  call $~lib/array/ensureCapacity
  local.get $0
  i32.load offset=4
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  local.get $1
  i32.store
  local.get $0
  local.get $3
  i32.store offset=12
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|0 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $2
  local.get $1
  call $~lib/readonlyarray/ReadonlyArray<i32>#__get@override
  local.get $0
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 7
   i32.const 7
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 3
  i32.eq
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|1 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 2
  i32.eq
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|2 (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  i32.const 12
  i32.const 5
  call $~lib/rt/itcms/__new
  local.tee $3
  i32.const 4
  i32.add
  i64.const 1
  i64.store
  local.get $3
  global.get $~lib/rt/closure/env
  local.tee $4
  i32.store
  local.get $3
  local.get $4
  i32.const 0
  call $~lib/rt/itcms/__link
  i32.const 0
  global.set $~lib/rt/closure/env
  local.get $2
  local.get $1
  call $~lib/readonlyarray/ReadonlyArray<i32>#__get@override
  local.get $0
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 19
   i32.const 5
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  i32.load
  local.tee $1
  i32.const 4
  i32.add
  local.get $0
  local.get $1
  i32.const 4
  i32.add
  i32.load
  i32.add
  i32.store
  local.get $1
  i32.const 8
  i32.add
  local.tee $0
  local.get $0
  i32.load
  i32.const 1
  i32.add
  i32.store
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|3 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 0
  i32.gt_s
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|4 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 3
  i32.eq
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|5 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 1
  i32.and
  i32.eqz
 )
 (func $~lib/array/Array<i32>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   i32.const 320
   i32.const 80
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
 )
 (func $~lib/string/String.__eq (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  block $~CONDITION_RETURN/~lib/string/String.__eq (result i32)
   i32.const 1
   local.get $0
   local.get $1
   i32.eq
   br_if $~CONDITION_RETURN/~lib/string/String.__eq
   drop
   i32.const 0
   local.get $1
   i32.eqz
   local.get $0
   i32.eqz
   i32.or
   br_if $~CONDITION_RETURN/~lib/string/String.__eq
   drop
   i32.const 0
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
   br_if $~CONDITION_RETURN/~lib/string/String.__eq
   drop
   block $__inlined_func$~lib/util/string/compareImpl$88 (result i32)
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
       br $__inlined_func$~lib/util/string/compareImpl$88
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
  end
 )
 (func $~lib/rt/__newArray (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $0
  i32.const 2
  i32.shl
  local.tee $3
  i32.const 1
  call $~lib/rt/itcms/__new
  local.set $2
  local.get $1
  if
   local.get $2
   local.get $1
   local.get $3
   memory.copy
  end
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store align=1
  i32.const 16
  i32.const 4
  call $~lib/rt/itcms/__new
  local.tee $1
  local.get $2
  i32.store
  local.get $1
  local.get $2
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $1
  local.get $2
  i32.store offset=4
  local.get $1
  local.get $3
  i32.store offset=8
  local.get $1
  local.get $0
  i32.store offset=12
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $1
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#push (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $0
  i32.load offset=12
  local.tee $2
  i32.const 1
  i32.add
  local.tee $3
  call $~lib/array/ensureCapacity
  local.get $0
  i32.load offset=4
  local.get $2
  i32.const 2
  i32.shl
  i32.add
  local.get $1
  i32.store
  local.get $0
  local.get $1
  i32.const 1
  call $~lib/rt/itcms/__link
  local.get $0
  local.get $3
  i32.store offset=12
 )
 (func $~lib/array/Array<i32>#indexOf (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  block $~CONDITION_RETURN/~lib/array/Array<i32>#indexOf (result i32)
   i32.const -1
   local.get $0
   i32.load offset=12
   local.tee $3
   i32.eqz
   local.get $3
   i32.const 0
   i32.le_s
   i32.or
   br_if $~CONDITION_RETURN/~lib/array/Array<i32>#indexOf
   drop
   local.get $0
   i32.load offset=4
   local.set $0
   loop $while-continue|0
    local.get $2
    local.get $3
    i32.lt_s
    if
     local.get $2
     local.get $0
     local.get $2
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.get $1
     i32.eq
     br_if $~CONDITION_RETURN/~lib/array/Array<i32>#indexOf
     drop
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $while-continue|0
    end
   end
   i32.const -1
  end
 )
 (func $~lib/util/number/utoa32_dec_lut (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  loop $while-continue|0
   local.get $1
   i32.const 10000
   i32.ge_u
   if
    local.get $1
    i32.const 10000
    i32.rem_u
    local.set $3
    local.get $1
    i32.const 10000
    i32.div_u
    local.set $1
    local.get $0
    local.get $2
    i32.const 4
    i32.sub
    local.tee $2
    i32.const 1
    i32.shl
    i32.add
    local.get $3
    i32.const 100
    i32.div_u
    i32.const 2
    i32.shl
    i32.const 1244
    i32.add
    i64.load32_u
    local.get $3
    i32.const 100
    i32.rem_u
    i32.const 2
    i32.shl
    i32.const 1244
    i32.add
    i64.load32_u
    i64.const 32
    i64.shl
    i64.or
    i64.store
    br $while-continue|0
   end
  end
  local.get $1
  i32.const 100
  i32.ge_u
  if
   local.get $0
   local.get $2
   i32.const 2
   i32.sub
   local.tee $2
   i32.const 1
   i32.shl
   i32.add
   local.get $1
   i32.const 100
   i32.rem_u
   i32.const 2
   i32.shl
   i32.const 1244
   i32.add
   i32.load
   i32.store
   local.get $1
   i32.const 100
   i32.div_u
   local.set $1
  end
  local.get $1
  i32.const 10
  i32.ge_u
  if
   local.get $0
   local.get $2
   i32.const 2
   i32.sub
   i32.const 1
   i32.shl
   i32.add
   local.get $1
   i32.const 2
   i32.shl
   i32.const 1244
   i32.add
   i32.load
   i32.store
  else
   local.get $0
   local.get $2
   i32.const 1
   i32.sub
   i32.const 1
   i32.shl
   i32.add
   local.get $1
   i32.const 48
   i32.add
   i32.store16
  end
 )
 (func $~lib/util/number/itoa_buffered<i32> (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $1
  i32.const 0
  i32.lt_s
  local.tee $2
  if
   local.get $0
   i32.const 45
   i32.store16
   i32.const 0
   local.get $1
   i32.sub
   local.set $1
  end
  local.get $0
  local.get $2
  i32.const 1
  i32.shl
  i32.add
  local.set $0
  local.get $1
  i32.const 10
  i32.lt_u
  if
   local.get $0
   local.get $1
   i32.const 48
   i32.or
   i32.store16
   local.get $2
   i32.const 1
   i32.add
   return
  end
  local.get $0
  local.get $1
  local.get $1
  i32.const 10
  i32.ge_u
  i32.const 1
  i32.add
  local.get $1
  i32.const 10000
  i32.ge_u
  i32.const 3
  i32.add
  local.get $1
  i32.const 1000
  i32.ge_u
  i32.add
  local.get $1
  i32.const 100
  i32.lt_u
  select
  local.get $1
  i32.const 1000000
  i32.ge_u
  i32.const 6
  i32.add
  local.get $1
  i32.const 1000000000
  i32.ge_u
  i32.const 8
  i32.add
  local.get $1
  i32.const 100000000
  i32.ge_u
  i32.add
  local.get $1
  i32.const 10000000
  i32.lt_u
  select
  local.get $1
  i32.const 100000
  i32.lt_u
  select
  local.tee $0
  call $~lib/util/number/utoa32_dec_lut
  local.get $0
  local.get $2
  i32.add
 )
 (func $~lib/array/Array<i32>#join (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $0
  i32.load offset=4
  local.set $4
  local.get $0
  i32.load offset=12
  local.set $0
  i32.const 4
  call $~lib/rt/__decrease_sp
  block $__inlined_func$~lib/util/string/joinIntegerArray<i32>$198
   block $~CONDITION_RETURN/~lib/util/string/joinIntegerArray<i32> (result i32)
    i32.const 1008
    local.get $0
    i32.const 1
    i32.sub
    local.tee $3
    i32.const 0
    i32.lt_s
    br_if $~CONDITION_RETURN/~lib/util/string/joinIntegerArray<i32>
    drop
    local.get $3
    i32.eqz
    if
     local.get $4
     i32.load
     local.tee $0
     if (result i32)
      i32.const 0
      local.get $0
      i32.sub
      local.get $0
      local.get $0
      i32.const 31
      i32.shr_u
      i32.const 1
      i32.shl
      local.tee $1
      select
      local.set $0
      local.get $0
      i32.const 10
      i32.ge_u
      i32.const 1
      i32.add
      local.get $0
      i32.const 10000
      i32.ge_u
      i32.const 3
      i32.add
      local.get $0
      i32.const 1000
      i32.ge_u
      i32.add
      local.get $0
      i32.const 100
      i32.lt_u
      select
      local.get $0
      i32.const 1000000
      i32.ge_u
      i32.const 6
      i32.add
      local.get $0
      i32.const 1000000000
      i32.ge_u
      i32.const 8
      i32.add
      local.get $0
      i32.const 100000000
      i32.ge_u
      i32.add
      local.get $0
      i32.const 10000000
      i32.lt_u
      select
      local.get $0
      i32.const 100000
      i32.lt_u
      select
      local.tee $3
      i32.const 1
      i32.shl
      local.get $1
      i32.add
      i32.const 2
      call $~lib/rt/itcms/__new
      local.tee $2
      local.get $1
      i32.add
      local.get $0
      local.get $3
      call $~lib/util/number/utoa32_dec_lut
      local.get $1
      if
       local.get $2
       i32.const 45
       i32.store16
      end
      local.get $2
     else
      i32.const 1232
     end
     local.set $0
     br $__inlined_func$~lib/util/string/joinIntegerArray<i32>$198
    end
    local.get $1
    i32.const 20
    i32.sub
    i32.load offset=16
    i32.const 1
    i32.shr_u
    local.tee $5
    i32.const 11
    i32.add
    local.get $3
    i32.mul
    i32.const 11
    i32.add
    local.tee $7
    i32.const 1
    i32.shl
    i32.const 2
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store align=1
    loop $for-loop|0
     local.get $3
     local.get $6
     i32.gt_s
     if
      local.get $0
      local.get $2
      i32.const 1
      i32.shl
      i32.add
      local.get $4
      local.get $6
      i32.const 2
      i32.shl
      i32.add
      i32.load
      call $~lib/util/number/itoa_buffered<i32>
      local.get $2
      i32.add
      local.set $2
      local.get $5
      if
       local.get $0
       local.get $2
       i32.const 1
       i32.shl
       i32.add
       local.get $1
       local.get $5
       i32.const 1
       i32.shl
       memory.copy
       local.get $2
       local.get $5
       i32.add
       local.set $2
      end
      local.get $6
      i32.const 1
      i32.add
      local.set $6
      br $for-loop|0
     end
    end
    local.get $0
    local.get $2
    i32.const 1
    i32.shl
    i32.add
    local.get $4
    local.get $3
    i32.const 2
    i32.shl
    i32.add
    i32.load
    call $~lib/util/number/itoa_buffered<i32>
    local.get $2
    i32.add
    local.tee $3
    local.get $7
    i32.lt_s
    if
     block $~CONDITION_RETURN/~lib/string/String#substring (result i32)
      local.get $0
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
      local.set $1
      i32.const 0
      local.tee $2
      local.get $3
      i32.const 0
      local.get $3
      i32.const 0
      i32.gt_s
      select
      local.tee $3
      local.get $1
      local.get $1
      local.get $3
      i32.gt_s
      select
      local.tee $4
      local.tee $3
      local.get $2
      local.get $3
      i32.lt_s
      select
      i32.const 1
      i32.shl
      local.set $3
      i32.const 1008
      local.get $2
      local.get $4
      local.get $2
      local.get $4
      i32.gt_s
      select
      i32.const 1
      i32.shl
      local.tee $4
      local.get $3
      i32.sub
      local.tee $2
      i32.eqz
      br_if $~CONDITION_RETURN/~lib/string/String#substring
      drop
      local.get $0
      local.get $3
      i32.eqz
      local.get $4
      local.get $1
      i32.const 1
      i32.shl
      i32.eq
      i32.and
      br_if $~CONDITION_RETURN/~lib/string/String#substring
      drop
      local.get $2
      i32.const 2
      call $~lib/rt/itcms/__new
      local.tee $1
      local.get $0
      local.get $3
      i32.add
      local.get $2
      memory.copy
      local.get $1
     end
     br $~CONDITION_RETURN/~lib/util/string/joinIntegerArray<i32>
    end
    br $__inlined_func$~lib/util/string/joinIntegerArray<i32>$198
   end
   local.set $0
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#get:length@override (param $0 i32) (result i32)
  local.get $0
  i32.const 8
  i32.sub
  i32.load
  i32.const 4
  i32.eq
  if
   local.get $0
   i32.load offset=12
   return
  end
  unreachable
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#__get@override (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  i32.const 8
  i32.sub
  i32.load
  i32.const 4
  i32.eq
  if
   local.get $0
   local.get $1
   return_call $~lib/array/Array<i32>#__get
  end
  unreachable
 )
 (func $~lib/iterator/Iterator<i32>#next@override (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 8
  i32.sub
  i32.load
  i32.const 11
  i32.eq
  if
   block $__inlined_func$~lib/array/ArrayIterator<i32>#next$212 (result i32)
    local.get $0
    i32.load
    local.set $1
    local.get $0
    local.get $0
    i32.load
    i32.const 1
    i32.add
    i32.store
    i32.const 0
    local.get $1
    local.get $0
    i32.load offset=4
    i32.load offset=12
    i32.ge_s
    br_if $__inlined_func$~lib/array/ArrayIterator<i32>#next$212
    drop
    local.get $0
    i32.load offset=4
    i32.load offset=4
    local.get $1
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.set $0
    i32.const 4
    i32.const 8
    call $~lib/rt/itcms/__new
    local.tee $1
    local.get $0
    i32.store
    local.get $1
   end
   return
  end
  unreachable
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  (local $1 i64)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  block $folding-inner0
   block $invalid
    block $~lib/array/ArrayIterator<i32>
     block $~lib/array/Array<~lib/array/Array<i32>>
      block $~lib/iterator/IteratorResult<i32>
       block $~lib/tuple/SmallTuple
        block $~lib/array/Array<i32>
         local.get $0
         i32.const 8
         i32.sub
         i32.load
         br_table $~lib/iterator/IteratorResult<i32> $~lib/iterator/IteratorResult<i32> $~lib/iterator/IteratorResult<i32> $~lib/array/Array<i32> $~lib/array/Array<i32> $~lib/tuple/SmallTuple $folding-inner0 $folding-inner0 $~lib/iterator/IteratorResult<i32> $~lib/array/Array<~lib/array/Array<i32>> $folding-inner0 $~lib/array/ArrayIterator<i32> $invalid
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
     local.get $0
     i32.load offset=4
     local.tee $2
     local.get $0
     i32.load offset=12
     i32.const 2
     i32.shl
     i32.add
     local.set $3
     loop $while-continue|00
      local.get $2
      local.get $3
      i32.lt_u
      if
       local.get $2
       i32.load
       local.tee $4
       if
        local.get $4
        call $~lib/rt/itcms/__visit
       end
       local.get $2
       i32.const 4
       i32.add
       local.set $2
       br $while-continue|00
      end
     end
     local.get $0
     i32.load
     return_call $~lib/rt/itcms/__visit
    end
    local.get $0
    i32.load offset=4
    return_call $~lib/rt/itcms/__visit
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
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  memory.size
  i32.const 16
  i32.shl
  i32.const 35652
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
  i32.const 16
  i32.const 4
  call $~lib/rt/itcms/__new
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  i32.const 32
  i32.const 1
  call $~lib/rt/itcms/__new
  local.tee $0
  i32.store
  local.get $1
  local.get $0
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $1
  local.get $0
  i32.store offset=4
  local.get $1
  i32.const 32
  i32.store offset=8
  local.get $1
  i32.const 0
  i32.store offset=12
  local.get $1
  global.set $std/readonlyarray/source
  global.get $~lib/memory/__stack_pointer
  global.get $std/readonlyarray/source
  i32.store align=1
  global.get $std/readonlyarray/source
  i32.const 1
  call $~lib/array/Array<i32>#push
  global.get $~lib/memory/__stack_pointer
  global.get $std/readonlyarray/source
  i32.store align=1
  global.get $std/readonlyarray/source
  i32.const 2
  call $~lib/array/Array<i32>#push
  global.get $~lib/memory/__stack_pointer
  global.get $std/readonlyarray/source
  i32.store align=1
  global.get $std/readonlyarray/source
  i32.const 3
  call $~lib/array/Array<i32>#push
  global.get $~lib/memory/__stack_pointer
  global.get $std/readonlyarray/source
  i32.store align=1
  global.get $std/readonlyarray/source
  i32.const 2
  call $~lib/array/Array<i32>#push
  global.get $std/readonlyarray/source
  global.set $std/readonlyarray/values
  i32.const 0
  global.set $~lib/rt/closure/env
  global.get $~lib/memory/__stack_pointer
  global.get $std/readonlyarray/values
  i32.store align=1
  global.get $std/readonlyarray/values
  local.set $1
  i32.const 12
  call $~lib/rt/__decrease_sp
  i32.const 20
  i32.const 5
  call $~lib/rt/itcms/__new
  local.tee $0
  i32.const 12
  i32.add
  i64.const 1
  i64.store
  local.get $0
  local.set $2
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=8 align=1
  local.get $0
  i32.const 0
  i32.store
  local.get $0
  i32.const 0
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $1
  call $~lib/readonlyarray/ReadonlyArray<i32>#get:length@override
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 2
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 1
  call $~lib/readonlyarray/ReadonlyArray<i32>#__get@override
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 3
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#at@override$89 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    local.get $1
    i32.load offset=12
    local.tee $0
    i32.const 1
    i32.sub
    local.tee $3
    local.get $0
    i32.ge_u
    if
     i32.const 320
     i32.const 80
     i32.const 155
     i32.const 33
     call $~lib/builtins/abort
     unreachable
    end
    local.get $1
    i32.load offset=4
    local.get $3
    i32.const 2
    i32.shl
    i32.add
    i32.load
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#at@override$89
   end
   unreachable
  end
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 4
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#findIndex@override$90 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    block $__inlined_func$~lib/array/Array<i32>#findIndex$181 (result i32)
     i32.const 0
     local.set $0
     local.get $1
     i32.load offset=12
     local.set $3
     loop $for-loop|0
      local.get $0
      local.get $3
      local.get $1
      i32.load offset=12
      local.tee $4
      local.get $3
      local.get $4
      i32.lt_s
      select
      i32.lt_s
      if
       local.get $0
       local.get $1
       i32.load offset=4
       local.get $0
       i32.const 2
       i32.shl
       i32.add
       i32.load
       local.get $0
       local.get $1
       i32.const 0
       global.set $~lib/rt/closure/env
       i32.const 1
       call_indirect (type $1)
       br_if $__inlined_func$~lib/array/Array<i32>#findIndex$181
       drop
       local.get $0
       i32.const 1
       i32.add
       local.set $0
       br $for-loop|0
      end
     end
     i32.const -1
    end
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#findIndex@override$90
   end
   unreachable
  end
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 5
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#findLastIndex@override$91 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    block $__inlined_func$~lib/array/Array<i32>#findLastIndex$182 (result i32)
     local.get $1
     i32.load offset=12
     i32.const 1
     i32.sub
     local.set $0
     loop $for-loop|00
      local.get $0
      i32.const 0
      i32.ge_s
      if
       local.get $0
       local.get $1
       i32.load offset=4
       local.get $0
       i32.const 2
       i32.shl
       i32.add
       i32.load
       local.get $0
       local.get $1
       i32.const 0
       global.set $~lib/rt/closure/env
       i32.const 2
       call_indirect (type $1)
       br_if $__inlined_func$~lib/array/Array<i32>#findLastIndex$182
       drop
       local.get $0
       i32.const 1
       i32.sub
       local.set $0
       br $for-loop|00
      end
     end
     i32.const -1
    end
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#findLastIndex@override$91
   end
   unreachable
  end
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 11
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#includes@override$92 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    local.get $1
    i32.const 3
    call $~lib/array/Array<i32>#indexOf
    i32.const 0
    i32.ge_s
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#includes@override$92
   end
   unreachable
  end
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 12
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#indexOf@override$93 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    local.get $1
    i32.const 2
    call $~lib/array/Array<i32>#indexOf
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#indexOf@override$93
   end
   unreachable
  end
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 13
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#lastIndexOf@override$94 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    block $~CONDITION_RETURN/~lib/array/Array<i32>#lastIndexOf (result i32)
     i32.const -1
     local.get $1
     i32.load offset=12
     local.tee $0
     i32.eqz
     br_if $~CONDITION_RETURN/~lib/array/Array<i32>#lastIndexOf
     drop
     local.get $0
     i32.const 1
     i32.sub
     local.set $0
     local.get $1
     i32.load offset=4
     local.set $3
     loop $while-continue|0
      local.get $0
      i32.const 0
      i32.ge_s
      if
       local.get $0
       local.get $3
       local.get $0
       i32.const 2
       i32.shl
       i32.add
       i32.load
       i32.const 2
       i32.eq
       br_if $~CONDITION_RETURN/~lib/array/Array<i32>#lastIndexOf
       drop
       local.get $0
       i32.const 1
       i32.sub
       local.set $0
       br $while-continue|0
      end
     end
     i32.const -1
    end
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#lastIndexOf@override$94
   end
   unreachable
  end
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 14
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 4
  i32.add
  i32.const 0
  i32.store
  local.get $2
  i32.const 8
  i32.add
  i32.const 0
  i32.store
  i32.const 8
  i32.const 7
  call $~lib/rt/itcms/__new
  local.tee $3
  i32.const 3
  i32.store
  local.get $3
  i32.const 4
  i32.add
  local.get $2
  i32.store
  global.get $~lib/memory/__stack_pointer
  local.get $3
  i32.store offset=4 align=1
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#forEach@override$96
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    i32.const 0
    local.set $0
    local.get $1
    i32.load offset=12
    local.set $4
    loop $for-loop|01
     local.get $0
     local.get $4
     local.get $1
     i32.load offset=12
     local.tee $5
     local.get $4
     local.get $5
     i32.lt_s
     select
     i32.lt_s
     if
      local.get $1
      i32.load offset=4
      local.get $0
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.get $0
      local.get $1
      local.get $3
      i32.load offset=4
      global.set $~lib/rt/closure/env
      local.get $3
      i32.load
      call_indirect (type $2)
      local.get $0
      i32.const 1
      i32.add
      local.set $0
      br $for-loop|01
     end
    end
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#forEach@override$96
   end
   unreachable
  end
  local.get $2
  i32.const 4
  i32.add
  i32.load
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 23
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 8
  i32.add
  i32.load
  local.get $1
  call $~lib/readonlyarray/ReadonlyArray<i32>#get:length@override
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 24
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#every@override$97 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    block $__inlined_func$~lib/array/Array<i32>#every$186 (result i32)
     i32.const 0
     local.set $0
     local.get $1
     i32.load offset=12
     local.set $2
     loop $for-loop|02
      local.get $0
      local.get $2
      local.get $1
      i32.load offset=12
      local.tee $3
      local.get $2
      local.get $3
      i32.lt_s
      select
      i32.lt_s
      if
       i32.const 0
       local.get $1
       i32.load offset=4
       local.get $0
       i32.const 2
       i32.shl
       i32.add
       i32.load
       local.get $0
       local.get $1
       i32.const 0
       global.set $~lib/rt/closure/env
       i32.const 4
       call_indirect (type $1)
       i32.eqz
       br_if $__inlined_func$~lib/array/Array<i32>#every$186
       drop
       local.get $0
       i32.const 1
       i32.add
       local.set $0
       br $for-loop|02
      end
     end
     i32.const 1
    end
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#every@override$97
   end
   unreachable
  end
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 26
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#some@override$98 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    block $__inlined_func$~lib/array/Array<i32>#some$187 (result i32)
     i32.const 0
     local.set $0
     local.get $1
     i32.load offset=12
     local.set $2
     loop $for-loop|03
      local.get $0
      local.get $2
      local.get $1
      i32.load offset=12
      local.tee $3
      local.get $2
      local.get $3
      i32.lt_s
      select
      i32.lt_s
      if
       i32.const 1
       local.get $1
       i32.load offset=4
       local.get $0
       i32.const 2
       i32.shl
       i32.add
       i32.load
       local.get $0
       local.get $1
       i32.const 0
       global.set $~lib/rt/closure/env
       i32.const 5
       call_indirect (type $1)
       br_if $__inlined_func$~lib/array/Array<i32>#some$187
       drop
       local.get $0
       i32.const 1
       i32.add
       local.set $0
       br $for-loop|03
      end
     end
     i32.const 0
    end
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#some@override$98
   end
   unreachable
  end
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 27
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 720
  i32.store offset=4 align=1
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#filter@override$99 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    i32.const 0
    local.set $0
    i32.const 4
    call $~lib/rt/__decrease_sp
    i32.const 0
    i32.const 0
    call $~lib/rt/__newArray
    local.set $2
    global.get $~lib/memory/__stack_pointer
    local.get $2
    i32.store align=1
    local.get $1
    i32.load offset=12
    local.set $3
    loop $for-loop|04
     local.get $0
     local.get $3
     local.get $1
     i32.load offset=12
     local.tee $4
     local.get $3
     local.get $4
     i32.lt_s
     select
     i32.lt_s
     if
      local.get $1
      i32.load offset=4
      local.get $0
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.tee $4
      local.get $0
      local.get $1
      call $std/readonlyarray/checkReadonlyArray~anonymous|5
      if
       local.get $2
       local.get $4
       call $~lib/array/Array<i32>#push
      end
      local.get $0
      i32.const 1
      i32.add
      local.set $0
      br $for-loop|04
     end
    end
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
    local.get $2
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#filter@override$99
   end
   unreachable
  end
  local.tee $0
  i32.load offset=12
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 30
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/array/Array<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 31
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/array/Array<i32>#__get
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 32
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  call $~lib/array/Array<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 33
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#slice@override$100 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    i32.const 1
    local.get $1
    i32.load offset=12
    local.tee $0
    local.get $0
    i32.const 1
    i32.gt_s
    select
    local.set $2
    i32.const 3
    local.get $0
    local.get $0
    i32.const 3
    i32.gt_s
    select
    local.get $2
    i32.sub
    local.tee $0
    i32.const 0
    local.get $0
    i32.const 0
    i32.gt_s
    select
    local.tee $0
    i32.const 0
    call $~lib/rt/__newArray
    local.tee $3
    i32.load offset=4
    local.get $1
    i32.load offset=4
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    local.get $0
    i32.const 2
    i32.shl
    memory.copy
    local.get $3
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#slice@override$100
   end
   unreachable
  end
  local.tee $0
  i32.load offset=12
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 36
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/array/Array<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 37
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/array/Array<i32>#__get
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 38
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 8
  i32.sub
  i32.load
  i32.const 4
  i32.ne
  if
   i32.const 752
   i32.const 528
   i32.const 40
   i32.const 36
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store offset=4 align=1
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#concat@override$102 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    local.get $1
    i32.load offset=12
    local.tee $0
    local.get $1
    i32.load offset=12
    local.tee $2
    i32.add
    local.tee $3
    i32.const 268435455
    i32.gt_u
    if
     i32.const 32
     i32.const 80
     i32.const 236
     i32.const 62
     call $~lib/builtins/abort
     unreachable
    end
    local.get $3
    i32.const 0
    call $~lib/rt/__newArray
    local.tee $3
    i32.load offset=4
    local.tee $4
    local.get $1
    i32.load offset=4
    local.get $0
    i32.const 2
    i32.shl
    local.tee $0
    memory.copy
    local.get $0
    local.get $4
    i32.add
    local.get $1
    i32.load offset=4
    local.get $2
    i32.const 2
    i32.shl
    memory.copy
    local.get $3
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#concat@override$102
   end
   unreachable
  end
  local.tee $0
  i32.load offset=12
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 41
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  call $~lib/array/Array<i32>#__get
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 42
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#join@override$103 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    local.get $1
    i32.const 816
    call $~lib/array/Array<i32>#join
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#join@override$103
   end
   unreachable
  end
  i32.const 848
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 44
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#toString@override$104 (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    local.get $1
    i32.const 2816
    call $~lib/array/Array<i32>#join
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<i32>#toString@override$104
   end
   unreachable
  end
  i32.const 896
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 528
   i32.const 45
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store offset=4 align=1
  block $"__inlined_func$~lib/iterator/Iterable<i32>#[~lib/symbol/Symbol.iterator]@override$105" (result i32)
   local.get $1
   i32.const 8
   i32.sub
   i32.load
   i32.const 4
   i32.eq
   if
    i32.const 8
    i32.const 11
    call $~lib/rt/itcms/__new
    local.tee $2
    local.get $1
    i32.store offset=4
    local.get $2
    local.get $1
    i32.const 0
    call $~lib/rt/itcms/__link
    local.get $2
    br $"__inlined_func$~lib/iterator/Iterable<i32>#[~lib/symbol/Symbol.iterator]@override$105"
   end
   unreachable
  end
  local.set $3
  global.get $~lib/memory/__stack_pointer
  local.get $3
  i32.store offset=8 align=1
  local.get $3
  call $~lib/iterator/Iterator<i32>#next@override
  local.set $2
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store offset=4 align=1
  loop $for-of-loop|0
   local.get $2
   if
    local.get $2
    i32.load
    local.set $2
    local.get $1
    local.get $0
    call $~lib/readonlyarray/ReadonlyArray<i32>#__get@override
    local.get $2
    i32.ne
    if
     i32.const 0
     i32.const 528
     i32.const 49
     i32.const 5
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    local.get $3
    call $~lib/iterator/Iterator<i32>#next@override
    local.set $2
    br $for-of-loop|0
   end
  end
  local.get $1
  call $~lib/readonlyarray/ReadonlyArray<i32>#get:length@override
  local.get $0
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 52
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 12
  i32.add
  global.set $~lib/memory/__stack_pointer
  i32.const 16
  i32.const 9
  call $~lib/rt/itcms/__new
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  i32.const 32
  i32.const 1
  call $~lib/rt/itcms/__new
  local.tee $0
  i32.store
  local.get $1
  local.get $0
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $1
  local.get $0
  i32.store offset=4
  local.get $1
  i32.const 32
  i32.store offset=8
  local.get $1
  i32.const 0
  i32.store offset=12
  local.get $1
  global.set $std/readonlyarray/nestedSource
  global.get $~lib/memory/__stack_pointer
  global.get $std/readonlyarray/nestedSource
  i32.store offset=4 align=1
  global.get $std/readonlyarray/nestedSource
  i32.const 2
  i32.const 944
  call $~lib/rt/__newArray
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  call $~lib/array/Array<~lib/array/Array<i32>>#push
  global.get $~lib/memory/__stack_pointer
  global.get $std/readonlyarray/nestedSource
  i32.store offset=4 align=1
  global.get $std/readonlyarray/nestedSource
  i32.const 2
  i32.const 976
  call $~lib/rt/__newArray
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  call $~lib/array/Array<~lib/array/Array<i32>>#push
  global.get $std/readonlyarray/nestedSource
  global.set $std/readonlyarray/nested
  global.get $~lib/memory/__stack_pointer
  global.get $std/readonlyarray/nested
  i32.store align=1
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<~lib/array/Array<i32>>#flat@override$111 (result i32)
   global.get $std/readonlyarray/nested
   local.tee $0
   i32.const 8
   i32.sub
   i32.load
   i32.const 9
   i32.eq
   if
    i32.const 0
    local.set $1
    local.get $0
    i32.load offset=4
    local.set $4
    local.get $0
    i32.load offset=12
    local.set $5
    i32.const 0
    local.set $0
    loop $for-loop|05
     local.get $0
     local.get $5
     i32.lt_s
     if
      local.get $4
      local.get $0
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.tee $2
      if (result i32)
       local.get $2
       i32.load offset=12
      else
       i32.const 0
      end
      local.get $1
      i32.add
      local.set $1
      local.get $0
      i32.const 1
      i32.add
      local.set $0
      br $for-loop|05
     end
    end
    i32.const 4
    call $~lib/rt/__decrease_sp
    local.get $1
    i32.const 2
    i32.shl
    local.tee $3
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store align=1
    i32.const 16
    i32.const 4
    call $~lib/rt/itcms/__new
    local.tee $2
    local.get $1
    i32.store offset=12
    local.get $2
    local.get $3
    i32.store offset=8
    local.get $2
    local.get $0
    i32.store offset=4
    local.get $2
    local.get $0
    i32.store
    local.get $2
    local.get $0
    i32.const 0
    call $~lib/rt/itcms/__link
    i32.const 0
    local.set $3
    i32.const 0
    local.set $1
    loop $for-loop|1
     local.get $1
     local.get $5
     i32.lt_s
     if
      local.get $4
      local.get $1
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.tee $6
      if
       local.get $0
       local.get $3
       i32.add
       local.get $6
       i32.load offset=4
       local.get $6
       i32.load offset=12
       i32.const 2
       i32.shl
       local.tee $6
       memory.copy
       local.get $3
       local.get $6
       i32.add
       local.set $3
      end
      local.get $1
      i32.const 1
      i32.add
      local.set $1
      br $for-loop|1
     end
    end
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
    local.get $2
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<~lib/array/Array<i32>>#flat@override$111
   end
   unreachable
  end
  global.set $std/readonlyarray/flattened
  global.get $std/readonlyarray/flattened
  i32.load offset=12
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 69
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/readonlyarray/flattened
  i32.const 0
  call $~lib/array/Array<i32>#__get
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 70
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/readonlyarray/flattened
  i32.const 3
  call $~lib/array/Array<i32>#__get
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 528
   i32.const 71
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
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
  i32.const 2884
  i32.lt_s
  if
   unreachable
  end
 )
)
