(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (param i32 i32 i32) (result i32)))
 (type $2 (func (param i32)))
 (type $3 (func (param i32 i32 i32)))
 (type $4 (func (param i32 i32)))
 (type $5 (func))
 (type $6 (func (param i32 i32 i32 i32)))
 (type $7 (func (param i32) (result i32)))
 (type $8 (func (param i32 i32 i64)))
 (type $9 (func (result i32)))
 (type $10 (func (param i32 i32 i32 i32) (result i32)))
 (type $11 (func (param i32 i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 35712))
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
 (global $std/staticarray/arr3 (mut i32) (i32.const 0))
 (global $std/staticarray/arr4 (mut i32) (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $std/staticarray/maxVal (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\04\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03")
 (data $1 (i32.const 44) "<")
 (data $1.1 (i32.const 56) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $2 (i32.const 108) "<")
 (data $2.1 (i32.const 120) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00s\00t\00a\00t\00i\00c\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $3 (i32.const 172) "<")
 (data $3.1 (i32.const 184) "\02\00\00\00$\00\00\00s\00t\00d\00/\00s\00t\00a\00t\00i\00c\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $4 (i32.const 236) "\1c")
 (data $4.1 (i32.const 248) "\04\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03")
 (data $5 (i32.const 268) "\1c")
 (data $5.1 (i32.const 280) "\04\00\00\00\0c\00\00\00\05\00\00\00\06\00\00\00\07")
 (data $6 (i32.const 300) "<")
 (data $6.1 (i32.const 312) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $7 (i32.const 364) "<")
 (data $7.1 (i32.const 376) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $10 (i32.const 492) ",")
 (data $10.1 (i32.const 504) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $12 (i32.const 572) "<")
 (data $12.1 (i32.const 584) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $13 (i32.const 636) ",")
 (data $13.1 (i32.const 648) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h")
 (data $14 (i32.const 684) ",")
 (data $14.1 (i32.const 696) "\01\00\00\00\18\00\00\00\00\00\00\00\01\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00\05")
 (data $15 (i32.const 732) ",")
 (data $15.1 (i32.const 744) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $16 (i32.const 780) "\1c")
 (data $16.1 (i32.const 792) "\01")
 (data $17 (i32.const 812) "\1c")
 (data $17.1 (i32.const 824) "\04\00\00\00\08\00\00\00\01\00\00\00\02")
 (data $18 (i32.const 844) "\1c")
 (data $18.1 (i32.const 856) "\04\00\00\00\04\00\00\00\01")
 (data $19 (i32.const 876) "\1c")
 (data $19.1 (i32.const 888) "\04")
 (data $20 (i32.const 908) "\1c")
 (data $20.1 (i32.const 920) "\02\00\00\00\02\00\00\001")
 (data $21 (i32.const 940) "\1c")
 (data $21.1 (i32.const 952) "\02\00\00\00\02\00\00\002")
 (data $22 (i32.const 972) "\1c")
 (data $22.1 (i32.const 984) "\t\00\00\00\08\00\00\00\a0\03\00\00\c0\03")
 (data $23 (i32.const 1004) "\1c")
 (data $23.1 (i32.const 1016) "\02\00\00\00\02\00\00\003")
 (data $24 (i32.const 1036) "\1c")
 (data $24.1 (i32.const 1048) "\t\00\00\00\04\00\00\00\00\04")
 (data $25 (i32.const 1068) "\1c")
 (data $25.1 (i32.const 1080) "\02\00\00\00\06\00\00\00a\00n\00t")
 (data $26 (i32.const 1100) "\1c")
 (data $26.1 (i32.const 1112) "\02\00\00\00\n\00\00\00b\00i\00s\00o\00n")
 (data $27 (i32.const 1132) "\1c")
 (data $27.1 (i32.const 1144) "\02\00\00\00\n\00\00\00c\00a\00m\00e\00l")
 (data $28 (i32.const 1164) "\1c")
 (data $28.1 (i32.const 1176) "\02\00\00\00\08\00\00\00d\00u\00c\00k")
 (data $29 (i32.const 1196) ",")
 (data $29.1 (i32.const 1208) "\02\00\00\00\10\00\00\00e\00l\00e\00p\00h\00a\00n\00t")
 (data $30 (i32.const 1244) ",")
 (data $30.1 (i32.const 1256) "\t\00\00\00\14\00\00\00@\04\00\00`\04\00\00\80\04\00\00\a0\04\00\00\c0\04")
 (data $31 (i32.const 1292) "|")
 (data $31.1 (i32.const 1304) "\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y")
 (data $32 (i32.const 1420) ",")
 (data $32.1 (i32.const 1432) "\t\00\00\00\14\00\00\00@\04\00\00`\04\00\00\80\04\00\00\a0\04\00\00\c0\04")
 (data $33 (i32.const 1468) "\1c")
 (data $33.1 (i32.const 1480) "\01")
 (data $34 (i32.const 1500) "\1c")
 (data $34.1 (i32.const 1512) "\02\00\00\00\06\00\00\00f\00o\00o")
 (data $35 (i32.const 1532) "\1c")
 (data $35.1 (i32.const 1544) "\01\00\00\00\04\00\00\00\f0\05")
 (data $36 (i32.const 1564) ",")
 (data $36.1 (i32.const 1576) "\t\00\00\00\14\00\00\00@\04\00\00`\04\00\00\80\04\00\00\a0\04\00\00\c0\04")
 (data $37 (i32.const 1612) "\1c")
 (data $37.1 (i32.const 1624) "\0c\00\00\00\08")
 (data $37.2 (i32.const 1638) "\f8\7f")
 (data $38 (i32.const 1644) "\1c")
 (data $38.1 (i32.const 1656) "\r\00\00\00\04\00\00\00\00\00\c0\7f")
 (data $39 (i32.const 1676) "\1c")
 (data $39.1 (i32.const 1688) "\04\00\00\00\0c\00\00\00\02\00\00\00\t\00\00\00\t")
 (data $40 (i32.const 1708) ",")
 (data $40.1 (i32.const 1720) "\04\00\00\00\10\00\00\00\02\00\00\00\05\00\00\00\t\00\00\00\02")
 (data $41 (i32.const 1756) "\1c")
 (data $41.1 (i32.const 1768) "\02\00\00\00\08\00\00\00F\00i\00r\00e")
 (data $42 (i32.const 1788) "\1c")
 (data $42.1 (i32.const 1800) "\02\00\00\00\06\00\00\00A\00i\00r")
 (data $43 (i32.const 1820) "\1c")
 (data $43.1 (i32.const 1832) "\02\00\00\00\n\00\00\00W\00a\00t\00e\00r")
 (data $44 (i32.const 1852) "\1c")
 (data $44.1 (i32.const 1864) "\t\00\00\00\0c\00\00\00\f0\06\00\00\10\07\00\000\07")
 (data $45 (i32.const 1884) "\1c")
 (data $45.1 (i32.const 1896) "\02")
 (data $46 (i32.const 1916) "\1c")
 (data $46.1 (i32.const 1928) "\02\00\00\00\02\00\00\00,")
 (data $47 (i32.const 1948) ",")
 (data $47.1 (i32.const 1960) "\02\00\00\00\1c\00\00\00F\00i\00r\00e\00,\00A\00i\00r\00,\00W\00a\00t\00e\00r")
 (data $48 (i32.const 1996) ",")
 (data $48.1 (i32.const 2008) "\02\00\00\00\18\00\00\00F\00i\00r\00e\00A\00i\00r\00W\00a\00t\00e\00r")
 (data $49 (i32.const 2044) "\1c")
 (data $49.1 (i32.const 2056) "\02\00\00\00\02\00\00\00-")
 (data $50 (i32.const 2076) ",")
 (data $50.1 (i32.const 2088) "\02\00\00\00\1c\00\00\00F\00i\00r\00e\00-\00A\00i\00r\00-\00W\00a\00t\00e\00r")
 (data $51 (i32.const 2124) "\1c")
 (data $51.1 (i32.const 2136) "\02\00\00\00\06\00\00\00 \00+\00 ")
 (data $52 (i32.const 2156) "<")
 (data $52.1 (i32.const 2168) "\02\00\00\00$\00\00\00F\00i\00r\00e\00 \00+\00 \00A\00i\00r\00 \00+\00 \00W\00a\00t\00e\00r")
 (data $53 (i32.const 2220) "\1c")
 (data $53.1 (i32.const 2232) "\04\00\00\00\08")
 (data $54 (i32.const 2252) "\1c")
 (data $54.1 (i32.const 2264) "\04\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03")
 (data $55 (i32.const 2284) ",")
 (data $55.1 (i32.const 2296) "\04\00\00\00\14\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00\04\00\00\00\05")
 (data $56 (i32.const 2332) "\1c")
 (data $56.1 (i32.const 2344) "\04\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03")
 (data $57 (i32.const 2364) "\1c")
 (data $57.1 (i32.const 2376) "\0e\00\00\00\08\00\00\00\01")
 (data $58 (i32.const 2396) "\1c")
 (data $58.1 (i32.const 2408) "\0f\00\00\00\08\00\00\00\02")
 (data $59 (i32.const 2428) "\1c")
 (data $59.1 (i32.const 2440) "\10\00\00\00\08\00\00\00\03")
 (data $60 (i32.const 2460) "\1c")
 (data $60.1 (i32.const 2472) "\11\00\00\00\08\00\00\00\04")
 (data $61 (i32.const 2492) "\1c")
 (data $61.1 (i32.const 2504) "\11\00\00\00\08\00\00\00\05")
 (data $62 (i32.const 2524) "\1c")
 (data $62.1 (i32.const 2536) "\10\00\00\00\08\00\00\00\06")
 (data $63 (i32.const 2556) "\1c")
 (data $63.1 (i32.const 2568) "\10\00\00\00\08\00\00\00\07")
 (data $64 (i32.const 2588) "\1c")
 (data $64.1 (i32.const 2600) "\10\00\00\00\08\00\00\00\08")
 (data $65 (i32.const 2620) "\1c")
 (data $65.1 (i32.const 2632) "\10\00\00\00\08\00\00\00\t")
 (data $66 (i32.const 2652) "\1c")
 (data $66.1 (i32.const 2664) "\10\00\00\00\08\00\00\00\n")
 (data $67 (i32.const 2684) "\1c")
 (data $67.1 (i32.const 2696) "\10\00\00\00\08\00\00\00\0b")
 (data $68 (i32.const 2716) "\1c")
 (data $68.1 (i32.const 2728) "\10\00\00\00\08\00\00\00\0c")
 (data $69 (i32.const 2748) "\1c")
 (data $69.1 (i32.const 2760) "\10\00\00\00\08\00\00\00\r")
 (data $70 (i32.const 2780) ",")
 (data $70.1 (i32.const 2792) "\04\00\00\00\10\00\00\00\00\00\00\00\03\00\00\00\02\00\00\00\01")
 (data $71 (i32.const 2828) "\1c")
 (data $71.1 (i32.const 2840) "\12\00\00\00\08\00\00\00\0e")
 (data $72 (i32.const 2864) "\13\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00$\t\00\00 \00\00\00\04A\00\00\02\t\00\00 \00\00\00\04A\00\00\02A\00\00 \00\00\00$\1a\00\00$\19")
 (table $0 15 15 funcref)
 (elem $0 (i32.const 1) $start:std/staticarray~anonymous|0 $start:std/staticarray~anonymous|1 $start:std/staticarray~anonymous|2 $start:std/staticarray~anonymous|3 $start:std/staticarray~anonymous|3 $start:std/staticarray~anonymous|5 $start:std/staticarray~anonymous|6 $start:std/staticarray~anonymous|7 $start:std/staticarray~anonymous|8 $start:std/staticarray~anonymous|5 $start:std/staticarray~anonymous|6 $start:std/staticarray~anonymous|5 $start:std/staticarray~anonymous|6 $~lib/util/sort/COMPARATOR<i32>~anonymous|0)
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/staticarray/StaticArray<i32>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   i32.const 64
   i32.const 128
   i32.const 77
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
 )
 (func $~lib/staticarray/StaticArray<i32>#__set (param $0 i32) (param $1 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 1
  i32.le_u
  if
   i32.const 64
   i32.const 128
   i32.const 94
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 4
  i32.add
  local.get $1
  i32.store
 )
 (func $~lib/rt/itcms/visitRoots
  (local $0 i32)
  (local $1 i32)
  i32.const 32
  call $~lib/rt/itcms/__visit
  i32.const 256
  call $~lib/rt/itcms/__visit
  global.get $std/staticarray/arr3
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $std/staticarray/arr4
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
     i32.const 384
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
    i32.const 384
    i32.const 147
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   end
   global.set $~lib/rt/itcms/iter
  end
  block $__inlined_func$~lib/rt/itcms/Object#unlink$132
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
    i32.const 35712
    i32.lt_u
    i32.and
    i32.eqz
    if
     i32.const 0
     i32.const 384
     i32.const 127
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    br $__inlined_func$~lib/rt/itcms/Object#unlink$132
   end
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 384
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
   i32.const 2864
   i32.load
   i32.gt_u
   if
    i32.const 64
    i32.const 512
    i32.const 21
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2
   i32.shl
   i32.const 2868
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
  call $~lib/rt/itcms/Object#linkTo
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
   i32.const 592
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
   i32.const 592
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
   i32.const 592
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
   i32.const 592
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
   i32.const 592
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
    i32.const 592
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
   i32.const 592
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
   i32.const 592
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
   i32.const 592
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
  block $CONDITION_RETURN#0
   local.get $2
   local.get $1
   i64.extend_i32_u
   i64.lt_u
   if
    i32.const 0
    i32.const 592
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
     i32.const 592
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
     i32.const 592
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
   br_if $CONDITION_RETURN#0
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
   call $~lib/rt/tlsf/insertBlock
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
  i32.const 35712
  i32.const 0
  i32.store
  i32.const 37280
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
    i32.const 35712
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
      i32.const 35712
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
  i32.const 35712
  i32.const 37284
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 35712
  global.set $~lib/rt/tlsf/ROOT
 )
 (func $~lib/rt/tlsf/__free (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  i32.const 35712
  i32.ge_u
  if
   global.get $~lib/rt/tlsf/ROOT
   i32.eqz
   if
    call $~lib/rt/tlsf/initialize
   end
   global.get $~lib/rt/tlsf/ROOT
   local.set $2
   local.get $0
   i32.const 4
   i32.sub
   local.set $1
   local.get $0
   i32.const 15
   i32.and
   i32.const 1
   local.get $0
   select
   if (result i32)
    i32.const 1
   else
    local.get $1
    i32.load
    i32.const 1
    i32.and
   end
   if
    i32.const 0
    i32.const 592
    i32.const 532
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   local.get $1
   i32.load
   i32.const 1
   i32.or
   i32.store
   local.get $2
   local.get $1
   call $~lib/rt/tlsf/insertBlock
  end
 )
 (func $~lib/rt/itcms/step (result i32)
  (local $0 i32)
  (local $1 i32)
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
     return
    end
    global.get $~lib/rt/itcms/white
    i32.eqz
    local.set $1
    global.get $~lib/rt/itcms/iter
    i32.load offset=4
    i32.const -4
    i32.and
    local.set $0
    loop $while-continue|1
     local.get $0
     global.get $~lib/rt/itcms/toSpace
     i32.ne
     if
      local.get $0
      global.set $~lib/rt/itcms/iter
      local.get $1
      local.get $0
      i32.load offset=4
      i32.const 3
      i32.and
      i32.ne
      if
       local.get $0
       local.get $0
       i32.load offset=4
       i32.const -4
       i32.and
       local.get $1
       i32.or
       i32.store offset=4
       i32.const 0
       global.set $~lib/rt/itcms/visitCount
       local.get $0
       i32.const 20
       i32.add
       call $~lib/rt/__visit_members
       global.get $~lib/rt/itcms/visitCount
       return
      end
      local.get $0
      i32.load offset=4
      i32.const -4
      i32.and
      local.set $0
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
     local.set $0
     loop $while-continue|0
      local.get $0
      i32.const 35712
      i32.lt_u
      if
       local.get $0
       i32.load
       call $~lib/rt/itcms/__visit
       local.get $0
       i32.const 4
       i32.add
       local.set $0
       br $while-continue|0
      end
     end
     global.get $~lib/rt/itcms/iter
     i32.load offset=4
     i32.const -4
     i32.and
     local.set $0
     loop $while-continue|2
      local.get $0
      global.get $~lib/rt/itcms/toSpace
      i32.ne
      if
       local.get $1
       local.get $0
       i32.load offset=4
       i32.const 3
       i32.and
       i32.ne
       if
        local.get $0
        local.get $0
        i32.load offset=4
        i32.const -4
        i32.and
        local.get $1
        i32.or
        i32.store offset=4
        local.get $0
        i32.const 20
        i32.add
        call $~lib/rt/__visit_members
       end
       local.get $0
       i32.load offset=4
       i32.const -4
       i32.and
       local.set $0
       br $while-continue|2
      end
     end
     global.get $~lib/rt/itcms/fromSpace
     local.set $0
     global.get $~lib/rt/itcms/toSpace
     global.set $~lib/rt/itcms/fromSpace
     local.get $0
     global.set $~lib/rt/itcms/toSpace
     local.get $1
     global.set $~lib/rt/itcms/white
     local.get $0
     i32.load offset=4
     i32.const -4
     i32.and
     global.set $~lib/rt/itcms/iter
     i32.const 2
     global.set $~lib/rt/itcms/state
    end
    global.get $~lib/rt/itcms/visitCount
    return
   end
   global.get $~lib/rt/itcms/iter
   local.tee $0
   global.get $~lib/rt/itcms/toSpace
   i32.ne
   if
    local.get $0
    i32.load offset=4
    i32.const -4
    i32.and
    global.set $~lib/rt/itcms/iter
    global.get $~lib/rt/itcms/white
    i32.eqz
    local.get $0
    i32.load offset=4
    i32.const 3
    i32.and
    i32.ne
    if
     i32.const 0
     i32.const 384
     i32.const 229
     i32.const 20
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 35712
    i32.lt_u
    if
     local.get $0
     i32.const 0
     i32.store offset=4
     local.get $0
     i32.const 0
     i32.store offset=8
    else
     global.get $~lib/rt/itcms/total
     local.get $0
     i32.load
     i32.const -4
     i32.and
     i32.const 4
     i32.add
     i32.sub
     global.set $~lib/rt/itcms/total
     local.get $0
     i32.const 4
     i32.add
     call $~lib/rt/tlsf/__free
    end
    i32.const 10
    return
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
   i32.const 592
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
     i32.const 592
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
 (func $~lib/rt/tlsf/__alloc (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   call $~lib/rt/tlsf/initialize
  end
  global.get $~lib/rt/tlsf/ROOT
  local.set $2
  local.get $0
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 320
   i32.const 592
   i32.const 435
   i32.const 29
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 12
  local.get $0
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.get $0
  i32.const 12
  i32.le_u
  select
  local.tee $1
  call $~lib/rt/tlsf/searchBlock
  local.tee $0
  i32.eqz
  if
   memory.size
   local.tee $3
   local.get $1
   local.tee $0
   i32.const 256
   i32.ge_u
   if (result i32)
    local.get $0
    i32.const 1
    i32.const 27
    local.get $0
    i32.clz
    i32.sub
    i32.shl
    i32.add
    i32.const 1
    i32.sub
    local.get $0
    local.get $0
    i32.const 536870910
    i32.lt_u
    select
   else
    local.get $0
   end
   i32.const 4
   local.get $2
   i32.load offset=1568
   local.get $3
   i32.const 16
   i32.shl
   i32.const 4
   i32.sub
   i32.ne
   i32.shl
   i32.add
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.tee $0
   local.get $0
   local.get $3
   i32.lt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $0
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
   local.get $2
   local.get $3
   i32.const 16
   i32.shl
   memory.size
   i64.extend_i32_s
   i64.const 16
   i64.shl
   call $~lib/rt/tlsf/addMemory
   local.get $2
   local.get $1
   call $~lib/rt/tlsf/searchBlock
   local.tee $0
   i32.eqz
   if
    i32.const 0
    i32.const 592
    i32.const 472
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $1
  local.get $0
  i32.load
  i32.const -4
  i32.and
  i32.gt_u
  if
   i32.const 0
   i32.const 592
   i32.const 474
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  local.get $0
  call $~lib/rt/tlsf/removeBlock
  local.get $0
  i32.load
  local.set $3
  local.get $1
  i32.const 4
  i32.add
  i32.const 15
  i32.and
  if
   i32.const 0
   i32.const 592
   i32.const 336
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  i32.const -4
  i32.and
  local.get $1
  i32.sub
  local.tee $4
  i32.const 16
  i32.ge_u
  if
   local.get $0
   local.get $1
   local.get $3
   i32.const 2
   i32.and
   i32.or
   i32.store
   local.get $0
   i32.const 4
   i32.add
   local.get $1
   i32.add
   local.tee $1
   local.get $4
   i32.const 4
   i32.sub
   i32.const 1
   i32.or
   i32.store
   local.get $2
   local.get $1
   call $~lib/rt/tlsf/insertBlock
  else
   local.get $0
   local.get $3
   i32.const -2
   i32.and
   i32.store
   local.get $0
   i32.const 4
   i32.add
   local.tee $1
   local.get $0
   i32.load
   i32.const -4
   i32.and
   local.tee $2
   i32.add
   local.get $1
   local.get $2
   i32.add
   i32.load
   i32.const -3
   i32.and
   i32.store
  end
  local.get $0
  i32.const 4
  i32.add
 )
 (func $~lib/rt/itcms/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $0
  i32.const 1073741804
  i32.ge_u
  if
   i32.const 320
   i32.const 384
   i32.const 262
   i32.const 31
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/itcms/total
  global.get $~lib/rt/itcms/threshold
  i32.ge_u
  if
   block $__inlined_func$~lib/rt/itcms/interrupt$69
    i32.const 2048
    local.set $2
    loop $do-loop|0
     local.get $2
     call $~lib/rt/itcms/step
     i32.sub
     local.set $2
     global.get $~lib/rt/itcms/state
     i32.eqz
     if
      global.get $~lib/rt/itcms/total
      i64.extend_i32_u
      i64.const 200
      i64.mul
      i64.const 100
      i64.div_u
      i32.wrap_i64
      i32.const 1024
      i32.add
      global.set $~lib/rt/itcms/threshold
      br $__inlined_func$~lib/rt/itcms/interrupt$69
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
  local.get $0
  i32.const 16
  i32.add
  call $~lib/rt/tlsf/__alloc
  i32.const 4
  i32.sub
  local.tee $2
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
 (func $~lib/rt/__newBuffer (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  local.get $1
  call $~lib/rt/itcms/__new
  local.set $1
  local.get $2
  if
   local.get $1
   local.get $2
   local.get $0
   memory.copy
  end
  local.get $1
 )
 (func $~lib/rt/itcms/__link (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  if
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 384
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
     call $~lib/rt/itcms/Object#makeGray
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
      call $~lib/rt/itcms/Object#makeGray
     end
    end
   end
  end
 )
 (func $~lib/rt/__newArray (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $0
  i32.const 2
  i32.shl
  local.tee $3
  i32.const 1
  local.get $2
  call $~lib/rt/__newBuffer
  local.set $2
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store align=1
  i32.const 16
  local.get $1
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
 (func $~lib/staticarray/StaticArray.fromArray<i32> (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  i32.load offset=12
  i32.const 2
  i32.shl
  local.tee $1
  i32.const 4
  call $~lib/rt/itcms/__new
  local.tee $2
  local.get $0
  i32.load offset=4
  local.get $1
  memory.copy
  local.get $2
 )
 (func $~lib/array/Array<i32>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   i32.const 64
   i32.const 752
   i32.const 123
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
 (func $~lib/staticarray/StaticArray<i32>#concat<~lib/staticarray/StaticArray<i32>> (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $3
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $4
  i32.add
  local.tee $2
  i32.const 268435455
  i32.gt_u
  if
   i32.const 656
   i32.const 128
   i32.const 181
   i32.const 7
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 2
  i32.shl
  i32.const 4
  call $~lib/rt/itcms/__new
  local.tee $2
  local.get $0
  local.get $3
  i32.const 2
  i32.shl
  local.tee $0
  memory.copy
  local.get $0
  local.get $2
  i32.add
  local.get $1
  local.get $4
  i32.const 2
  i32.shl
  memory.copy
  local.get $2
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>> (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.set $3
  local.get $0
  local.get $1
  i32.const 0
  i32.lt_s
  if (result i32)
   local.get $1
   local.get $3
   i32.add
   local.tee $1
   i32.const 0
   local.get $1
   i32.const 0
   i32.gt_s
   select
  else
   local.get $1
   local.get $3
   local.get $1
   local.get $3
   i32.lt_s
   select
  end
  local.tee $1
  i32.const 2
  i32.shl
  i32.add
  local.set $4
  local.get $2
  i32.const 0
  i32.lt_s
  if (result i32)
   local.get $2
   local.get $3
   i32.add
   local.tee $0
   i32.const 0
   local.get $0
   i32.const 0
   i32.gt_s
   select
  else
   local.get $2
   local.get $3
   local.get $2
   local.get $3
   i32.lt_s
   select
  end
  local.get $1
  i32.sub
  local.tee $0
  i32.const 0
  local.get $0
  i32.const 0
  i32.gt_s
  select
  i32.const 2
  i32.shl
  local.tee $2
  i32.const 9
  call $~lib/rt/itcms/__new
  local.set $1
  i32.const 0
  local.set $0
  loop $while-continue|0
   local.get $0
   local.get $2
   i32.lt_u
   if
    local.get $0
    local.get $1
    i32.add
    local.get $0
    local.get $4
    i32.add
    i32.load
    local.tee $3
    i32.store
    local.get $1
    local.get $3
    i32.const 1
    call $~lib/rt/itcms/__link
    local.get $0
    i32.const 4
    i32.add
    local.set $0
    br $while-continue|0
   end
  end
  local.get $1
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  block $2of2
   block $1of2
    block $0of2
     block $outOfRange
      global.get $~argumentsLength
      br_table $0of2 $1of2 $2of2 $outOfRange
     end
     unreachable
    end
    i32.const 0
    local.set $1
   end
   i32.const 2147483647
   local.set $2
  end
  local.get $0
  local.get $1
  local.get $2
  call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   i32.const 64
   i32.const 128
   i32.const 77
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.tee $0
  i32.eqz
  if
   i32.const 1312
   i32.const 128
   i32.const 81
   i32.const 40
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
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
  block $__inlined_func$~lib/util/string/compareImpl$78 (result i32)
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
      br $__inlined_func$~lib/util/string/compareImpl$78
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
 (func $~lib/staticarray/StaticArray<~lib/string/String>#concat<~lib/array/Array<~lib/string/String>> (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $3
  local.get $1
  i32.load offset=12
  local.tee $5
  i32.add
  local.tee $2
  i32.const 268435455
  i32.gt_u
  if
   i32.const 656
   i32.const 128
   i32.const 181
   i32.const 7
   call $~lib/builtins/abort
   unreachable
  end
  local.get $3
  i32.const 2
  i32.shl
  local.set $4
  local.get $2
  i32.const 10
  i32.const 0
  call $~lib/rt/__newArray
  local.tee $3
  i32.load offset=4
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $6
  i32.const 0
  local.set $1
  loop $for-loop|0
   local.get $1
   local.get $4
   i32.lt_u
   if
    local.get $1
    local.get $2
    i32.add
    local.get $0
    local.get $1
    i32.add
    i32.load
    local.tee $7
    i32.store
    local.get $3
    local.get $7
    i32.const 1
    call $~lib/rt/itcms/__link
    local.get $1
    i32.const 4
    i32.add
    local.set $1
    br $for-loop|0
   end
  end
  local.get $2
  local.get $4
  i32.add
  local.set $1
  local.get $5
  i32.const 2
  i32.shl
  local.set $4
  i32.const 0
  local.set $0
  loop $for-loop|1
   local.get $0
   local.get $4
   i32.lt_u
   if
    local.get $0
    local.get $1
    i32.add
    local.get $0
    local.get $6
    i32.add
    i32.load
    local.tee $2
    i32.store
    local.get $3
    local.get $2
    i32.const 1
    call $~lib/rt/itcms/__link
    local.get $0
    i32.const 4
    i32.add
    local.set $0
    br $for-loop|1
   end
  end
  local.get $3
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#includes (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  block $__inlined_func$~lib/staticarray/StaticArray<~lib/string/String>#indexOf$81 (result i32)
   i32.const -1
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   local.tee $3
   i32.eqz
   local.get $2
   local.get $3
   i32.ge_s
   i32.or
   br_if $__inlined_func$~lib/staticarray/StaticArray<~lib/string/String>#indexOf$81
   drop
   local.get $2
   i32.const 0
   i32.lt_s
   if
    local.get $2
    local.get $3
    i32.add
    local.tee $2
    i32.const 0
    local.get $2
    i32.const 0
    i32.gt_s
    select
    local.set $2
   end
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
     call $~lib/string/String.__eq
     br_if $__inlined_func$~lib/staticarray/StaticArray<~lib/string/String>#indexOf$81
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
  i32.const 0
  i32.ge_s
 )
 (func $~lib/staticarray/StaticArray<i32>#indexOf (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $3
  i32.eqz
  local.get $2
  local.get $3
  i32.ge_s
  i32.or
  if
   i32.const -1
   return
  end
  local.get $2
  i32.const 0
  i32.lt_s
  if
   local.get $2
   local.get $3
   i32.add
   local.tee $2
   i32.const 0
   local.get $2
   i32.const 0
   i32.gt_s
   select
   local.set $2
  end
  loop $while-continue|0
   local.get $2
   local.get $3
   i32.lt_s
   if
    local.get $0
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.get $1
    i32.eq
    if
     local.get $2
     return
    end
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $while-continue|0
   end
  end
  i32.const -1
 )
 (func $~lib/staticarray/StaticArray<i32>#lastIndexOf (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $3
  i32.eqz
  if
   i32.const -1
   return
  end
  local.get $2
  local.get $3
  i32.add
  local.get $3
  i32.const 1
  i32.sub
  local.get $2
  local.get $2
  local.get $3
  i32.ge_s
  select
  local.get $2
  i32.const 0
  i32.lt_s
  select
  local.set $2
  loop $while-continue|0
   local.get $2
   i32.const 0
   i32.ge_s
   if
    local.get $0
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.get $1
    i32.eq
    if
     local.get $2
     return
    end
    local.get $2
    i32.const 1
    i32.sub
    local.set $2
    br $while-continue|0
   end
  end
  i32.const -1
 )
 (func $~lib/staticarray/StaticArray<i32>#lastIndexOf@varargs (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  block $1of1
   block $0of1
    block $outOfRange
     global.get $~argumentsLength
     i32.const 1
     i32.sub
     br_table $0of1 $1of1 $outOfRange
    end
    unreachable
   end
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   local.set $2
  end
  local.get $0
  local.get $1
  local.get $2
  call $~lib/staticarray/StaticArray<i32>#lastIndexOf
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#join (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  block $__inlined_func$~lib/util/string/joinStringArray$83 (result i32)
   i32.const 1904
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   local.tee $4
   i32.const 1
   i32.sub
   local.tee $6
   i32.const 0
   i32.lt_s
   br_if $__inlined_func$~lib/util/string/joinStringArray$83
   drop
   local.get $6
   i32.eqz
   if
    local.get $0
    i32.load
    local.tee $0
    if (result i32)
     local.get $0
    else
     i32.const 1904
    end
    br $__inlined_func$~lib/util/string/joinStringArray$83
   end
   loop $for-loop|0
    local.get $2
    local.get $4
    i32.lt_s
    if
     local.get $0
     local.get $2
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $5
     if
      local.get $3
      local.get $5
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
      i32.add
      local.set $3
     end
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $for-loop|0
    end
   end
   i32.const 0
   local.set $2
   local.get $3
   local.get $1
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 1
   i32.shr_u
   local.tee $5
   local.get $6
   i32.mul
   i32.add
   i32.const 1
   i32.shl
   i32.const 2
   call $~lib/rt/itcms/__new
   local.set $4
   i32.const 0
   local.set $3
   loop $for-loop|1
    local.get $3
    local.get $6
    i32.lt_s
    if
     local.get $0
     local.get $3
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $7
     if
      local.get $4
      local.get $2
      i32.const 1
      i32.shl
      i32.add
      local.get $7
      local.get $7
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
      local.tee $7
      i32.const 1
      i32.shl
      memory.copy
      local.get $2
      local.get $7
      i32.add
      local.set $2
     end
     local.get $5
     if
      local.get $4
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
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $for-loop|1
    end
   end
   local.get $0
   local.get $6
   i32.const 2
   i32.shl
   i32.add
   i32.load
   local.tee $0
   if
    local.get $4
    local.get $2
    i32.const 1
    i32.shl
    i32.add
    local.get $0
    local.get $0
    i32.const 20
    i32.sub
    i32.load offset=16
    i32.const -2
    i32.and
    memory.copy
   end
   local.get $4
  end
 )
 (func $start:std/staticarray~anonymous|0 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 1
  i32.add
 )
 (func $start:std/staticarray~anonymous|1 (param $0 i32) (param $1 i32) (param $2 i32)
  global.get $std/staticarray/maxVal
  local.tee $1
  local.get $0
  local.get $0
  local.get $1
  i32.lt_s
  select
  global.set $std/staticarray/maxVal
 )
 (func $start:std/staticarray~anonymous|2 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 2
  i32.ge_s
 )
 (func $start:std/staticarray~anonymous|3 (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
  local.get $0
  local.get $1
  i32.add
 )
 (func $start:std/staticarray~anonymous|5 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 2
  i32.eq
 )
 (func $~lib/staticarray/StaticArray<i32>#someImpl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.set $3
  loop $for-loop|0
   local.get $2
   local.get $3
   i32.lt_s
   if
    local.get $0
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.get $2
    local.get $0
    local.get $1
    call_indirect (type $1)
    if
     i32.const 1
     return
    end
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|0
   end
  end
  i32.const 0
 )
 (func $start:std/staticarray~anonymous|6 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 4
  i32.eq
 )
 (func $start:std/staticarray~anonymous|7 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 3
  i32.le_s
 )
 (func $~lib/staticarray/StaticArray<i32>#everyImpl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.set $3
  loop $for-loop|0
   local.get $2
   local.get $3
   i32.lt_s
   if
    local.get $0
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.get $2
    local.get $0
    local.get $1
    call_indirect (type $1)
    i32.eqz
    if
     i32.const 0
     return
    end
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|0
   end
  end
  i32.const 1
 )
 (func $start:std/staticarray~anonymous|8 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 3
  i32.gt_s
 )
 (func $~lib/staticarray/StaticArray<i32>#findIndexImpl (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.set $3
  loop $for-loop|0
   local.get $2
   local.get $3
   i32.lt_s
   if
    local.get $0
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.get $2
    local.get $0
    local.get $1
    call_indirect (type $1)
    if
     local.get $2
     return
    end
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|0
   end
  end
  i32.const -1
 )
 (func $~lib/util/sort/insertionSort<i32> (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  local.get $1
  local.get $3
  local.get $2
  local.get $1
  i32.sub
  i32.const 1
  i32.add
  local.tee $4
  local.get $3
  i32.sub
  i32.const 1
  i32.and
  i32.sub
  local.get $4
  i32.const 1
  i32.and
  local.get $3
  select
  i32.add
  local.set $6
  loop $for-loop|0
   local.get $2
   local.get $6
   i32.ge_s
   if
    local.get $0
    local.get $6
    i32.const 2
    i32.shl
    i32.add
    local.tee $4
    i32.load offset=4
    local.tee $5
    local.set $3
    local.get $4
    i32.load
    local.set $4
    i32.const 2
    global.set $~argumentsLength
    local.get $4
    local.get $5
    i32.const 2848
    i32.load
    call_indirect (type $0)
    i32.const 0
    i32.le_s
    if
     local.get $4
     local.set $3
     local.get $5
     local.set $4
    end
    local.get $6
    i32.const 1
    i32.sub
    local.set $5
    loop $while-continue|1
     local.get $1
     local.get $5
     i32.le_s
     if
      block $while-break|1
       local.get $0
       local.get $5
       i32.const 2
       i32.shl
       i32.add
       local.tee $8
       i32.load
       local.set $7
       i32.const 2
       global.set $~argumentsLength
       local.get $7
       local.get $4
       i32.const 2848
       i32.load
       call_indirect (type $0)
       i32.const 0
       i32.le_s
       br_if $while-break|1
       local.get $8
       local.get $7
       i32.store offset=8
       local.get $5
       i32.const 1
       i32.sub
       local.set $5
       br $while-continue|1
      end
     end
    end
    local.get $0
    local.get $5
    i32.const 2
    i32.shl
    i32.add
    local.get $4
    i32.store offset=8
    loop $while-continue|2
     local.get $1
     local.get $5
     i32.le_s
     if
      block $while-break|2
       local.get $0
       local.get $5
       i32.const 2
       i32.shl
       i32.add
       local.tee $7
       i32.load
       local.set $4
       i32.const 2
       global.set $~argumentsLength
       local.get $4
       local.get $3
       i32.const 2848
       i32.load
       call_indirect (type $0)
       i32.const 0
       i32.le_s
       br_if $while-break|2
       local.get $7
       local.get $4
       i32.store offset=4
       local.get $5
       i32.const 1
       i32.sub
       local.set $5
       br $while-continue|2
      end
     end
    end
    local.get $0
    local.get $5
    i32.const 2
    i32.shl
    i32.add
    local.get $3
    i32.store offset=4
    local.get $6
    i32.const 2
    i32.add
    local.set $6
    br $for-loop|0
   end
  end
 )
 (func $~lib/util/sort/extendRunRight<i32> (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $1
  local.get $2
  i32.eq
  if
   local.get $1
   return
  end
  local.get $0
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.get $0
  local.get $1
  i32.const 1
  i32.add
  local.tee $3
  i32.const 2
  i32.shl
  i32.add
  i32.load
  i32.const 2
  global.set $~argumentsLength
  i32.const 2848
  i32.load
  call_indirect (type $0)
  i32.const 0
  i32.gt_s
  if
   loop $while-continue|0
    local.get $2
    local.get $3
    i32.gt_s
    if (result i32)
     local.get $0
     local.get $3
     i32.const 2
     i32.shl
     i32.add
     local.tee $4
     i32.load offset=4
     local.get $4
     i32.load
     i32.const 2
     global.set $~argumentsLength
     i32.const 2848
     i32.load
     call_indirect (type $0)
     i32.const 31
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $while-continue|0
    end
   end
   local.get $3
   local.set $2
   loop $while-continue|1
    local.get $1
    local.get $2
    i32.lt_s
    if
     local.get $0
     local.get $1
     i32.const 2
     i32.shl
     i32.add
     local.tee $4
     i32.load
     local.set $5
     local.get $4
     local.get $0
     local.get $2
     i32.const 2
     i32.shl
     i32.add
     local.tee $4
     i32.load
     i32.store
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     local.get $4
     local.get $5
     i32.store
     local.get $2
     i32.const 1
     i32.sub
     local.set $2
     br $while-continue|1
    end
   end
  else
   loop $while-continue|2
    local.get $2
    local.get $3
    i32.gt_s
    if (result i32)
     local.get $0
     local.get $3
     i32.const 2
     i32.shl
     i32.add
     local.tee $1
     i32.load offset=4
     local.get $1
     i32.load
     i32.const 2
     global.set $~argumentsLength
     i32.const 2848
     i32.load
     call_indirect (type $0)
     i32.const 0
     i32.ge_s
    else
     i32.const 0
    end
    if
     local.get $3
     i32.const 1
     i32.add
     local.set $3
     br $while-continue|2
    end
   end
  end
  local.get $3
 )
 (func $~lib/util/sort/mergeRuns<i32> (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $2
  i32.const 1
  i32.sub
  local.tee $2
  local.get $3
  i32.add
  local.set $6
  local.get $2
  i32.const 1
  i32.add
  local.set $5
  loop $for-loop|0
   local.get $1
   local.get $5
   i32.lt_s
   if
    local.get $4
    local.get $5
    i32.const 1
    i32.sub
    local.tee $5
    i32.const 2
    i32.shl
    local.tee $7
    i32.add
    local.get $0
    local.get $7
    i32.add
    i32.load
    i32.store
    br $for-loop|0
   end
  end
  loop $for-loop|1
   local.get $2
   local.get $3
   i32.lt_s
   if
    local.get $4
    local.get $6
    local.get $2
    i32.sub
    i32.const 2
    i32.shl
    i32.add
    local.get $0
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=4
    i32.store
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|1
   end
  end
  loop $for-loop|2
   local.get $1
   local.get $3
   i32.le_s
   if
    local.get $4
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.set $6
    local.get $4
    local.get $5
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.set $7
    i32.const 2
    global.set $~argumentsLength
    local.get $6
    local.get $7
    i32.const 2848
    i32.load
    call_indirect (type $0)
    i32.const 0
    i32.lt_s
    if
     local.get $0
     local.get $1
     i32.const 2
     i32.shl
     i32.add
     local.get $6
     i32.store
     local.get $2
     i32.const 1
     i32.sub
     local.set $2
    else
     local.get $0
     local.get $1
     i32.const 2
     i32.shl
     i32.add
     local.get $7
     i32.store
     local.get $5
     i32.const 1
     i32.add
     local.set $5
    end
    local.get $1
    i32.const 1
    i32.add
    local.set $1
    br $for-loop|2
   end
  end
 )
 (func $~lib/util/sort/COMPARATOR<i32>~anonymous|0 (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  local.get $1
  i32.sub
 )
 (func $~lib/staticarray/StaticArray<std/staticarray/Ref>~visit (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.add
  local.set $1
  loop $while-continue|0
   local.get $0
   local.get $1
   i32.lt_u
   if
    local.get $0
    i32.load
    local.tee $2
    if
     local.get $2
     call $~lib/rt/itcms/__visit
    end
    local.get $0
    i32.const 4
    i32.add
    local.set $0
    br $while-continue|0
   end
  end
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  block $folding-inner1
   block $folding-inner0
    block $invalid
     block $~lib/staticarray/StaticArray<f32>
      block $~lib/staticarray/StaticArray<f64>
       block $~lib/iterator/Iterable<~lib/string/String>
        block $~lib/array/Array<~lib/string/String>
         block $~lib/staticarray/StaticArray<~lib/string/String>
          block $~lib/iterator/Iterable<i32>
           block $~lib/staticarray/StaticArray<std/staticarray/Ref>
            block $std/staticarray/Ref
             block $~lib/staticarray/StaticArray<i32>
              block $~lib/string/String
               block $~lib/arraybuffer/ArrayBuffer
                block $~lib/object/Object
                 local.get $0
                 i32.const 8
                 i32.sub
                 i32.load
                 br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $folding-inner1 $~lib/staticarray/StaticArray<i32> $std/staticarray/Ref $~lib/staticarray/StaticArray<std/staticarray/Ref> $folding-inner1 $~lib/iterator/Iterable<i32> $~lib/staticarray/StaticArray<~lib/string/String> $~lib/array/Array<~lib/string/String> $~lib/iterator/Iterable<~lib/string/String> $~lib/staticarray/StaticArray<f64> $~lib/staticarray/StaticArray<f32> $folding-inner0 $folding-inner0 $folding-inner0 $folding-inner0 $folding-inner0 $invalid
                end
                return
               end
               return
              end
              return
             end
             return
            end
            return
           end
           local.get $0
           call $~lib/staticarray/StaticArray<std/staticarray/Ref>~visit
           return
          end
          return
         end
         local.get $0
         call $~lib/staticarray/StaticArray<std/staticarray/Ref>~visit
         return
        end
        local.get $0
        i32.load offset=4
        local.tee $1
        local.get $0
        i32.load offset=12
        i32.const 2
        i32.shl
        i32.add
        local.set $2
        loop $while-continue|0
         local.get $1
         local.get $2
         i32.lt_u
         if
          local.get $1
          i32.load
          local.tee $3
          if
           local.get $3
           call $~lib/rt/itcms/__visit
          end
          local.get $1
          i32.const 4
          i32.add
          local.set $1
          br $while-continue|0
         end
        end
        br $folding-inner1
       end
       return
      end
      return
     end
     return
    end
    unreachable
   end
   local.get $0
   i32.load offset=4
   call $~lib/rt/itcms/__visit
   return
  end
  local.get $0
  i32.load
  call $~lib/rt/itcms/__visit
 )
 (func $~start
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 f64)
  (local $15 f32)
  (local $16 i64)
  i32.const 32
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 5
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 28
  i32.load
  i32.const 2
  i32.shr_u
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 6
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 32
  i32.const 4
  call $~lib/staticarray/StaticArray<i32>#__set
  i32.const 32
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 8
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 24
  i32.load
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 9
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 256
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 13
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 252
  i32.load
  i32.const 2
  i32.shr_u
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 14
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 256
  i32.const 4
  call $~lib/staticarray/StaticArray<i32>#__set
  i32.const 256
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 16
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  memory.size
  i32.const 16
  i32.shl
  i32.const 35712
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 436
  i32.const 432
  i32.store
  i32.const 440
  i32.const 432
  i32.store
  i32.const 432
  global.set $~lib/rt/itcms/pinSpace
  i32.const 468
  i32.const 464
  i32.store
  i32.const 472
  i32.const 464
  i32.store
  i32.const 464
  global.set $~lib/rt/itcms/toSpace
  i32.const 548
  i32.const 544
  i32.store
  i32.const 552
  i32.const 544
  i32.store
  i32.const 544
  global.set $~lib/rt/itcms/fromSpace
  i32.const 12
  i32.const 4
  i32.const 288
  call $~lib/rt/__newBuffer
  global.set $std/staticarray/arr3
  global.get $std/staticarray/arr3
  i32.const 0
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 5
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 23
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/staticarray/arr3
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 6
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 24
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/staticarray/arr3
  i32.const 2
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 7
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 25
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/staticarray/arr3
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 26
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  global.get $std/staticarray/arr3
  i32.const 8
  call $~lib/staticarray/StaticArray<i32>#__set
  global.get $std/staticarray/arr3
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 8
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 28
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 12
  i32.const 4
  i32.const 288
  call $~lib/rt/__newBuffer
  global.set $std/staticarray/arr3
  global.get $std/staticarray/arr3
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 6
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 30
   i32.const 1
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  call $~lib/rt/__decrease_sp
  i32.const 8
  i32.const 6
  i32.const 0
  call $~lib/rt/__newBuffer
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 0
  i32.const 5
  call $~lib/rt/itcms/__new
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  i32.eqz
  if
   i32.const 0
   i32.const 0
   call $~lib/rt/itcms/__new
   local.set $1
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  local.get $1
  i32.store
  local.get $0
  local.get $1
  i32.const 1
  call $~lib/rt/itcms/__link
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 0
  i32.const 5
  call $~lib/rt/itcms/__new
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  i32.eqz
  if
   i32.const 0
   i32.const 0
   call $~lib/rt/itcms/__new
   local.set $1
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  i32.const 4
  i32.add
  local.get $1
  i32.store
  local.get $0
  local.get $1
  i32.const 1
  call $~lib/rt/itcms/__link
  local.get $0
  global.set $std/staticarray/arr4
  i32.const 0
  global.set $std/staticarray/arr3
  i32.const 0
  global.set $std/staticarray/arr4
  i32.const 12
  i32.const 4
  call $~lib/rt/itcms/__new
  local.tee $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 43
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  loop $for-loop|0
   local.get $2
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   i32.lt_s
   if
    local.get $0
    local.get $2
    call $~lib/staticarray/StaticArray<i32>#__get
    if
     i32.const 0
     i32.const 192
     i32.const 45
     i32.const 5
     call $~lib/builtins/abort
     unreachable
    end
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|0
   end
  end
  i32.const 6
  i32.const 7
  i32.const 704
  call $~lib/rt/__newArray
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  call $~lib/staticarray/StaticArray.fromArray<i32>
  local.tee $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.get $1
  i32.load offset=12
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 54
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  local.set $2
  loop $for-loop|1
   local.get $2
   local.get $1
   i32.load offset=12
   i32.lt_s
   if
    local.get $0
    local.get $2
    call $~lib/staticarray/StaticArray<i32>#__get
    local.get $1
    local.get $2
    call $~lib/array/Array<i32>#__get
    i32.ne
    if
     i32.const 0
     i32.const 192
     i32.const 56
     i32.const 5
     call $~lib/builtins/abort
     unreachable
    end
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|1
   end
  end
  i32.const 0
  i32.const 7
  i32.const 800
  call $~lib/rt/__newArray
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $~lib/staticarray/StaticArray.fromArray<i32>
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  if
   i32.const 0
   i32.const 192
   i32.const 59
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  i32.const 4
  i32.const 832
  call $~lib/rt/__newBuffer
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  i32.const 4
  i32.const 4
  i32.const 864
  call $~lib/rt/__newBuffer
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=4 align=1
  local.get $1
  local.get $0
  call $~lib/staticarray/StaticArray<i32>#concat<~lib/staticarray/StaticArray<i32>>
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 67
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  i32.const 4
  i32.const 896
  call $~lib/rt/__newBuffer
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=4 align=1
  local.get $1
  local.get $0
  call $~lib/staticarray/StaticArray<i32>#concat<~lib/staticarray/StaticArray<i32>>
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 69
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  i32.const 9
  i32.const 992
  call $~lib/rt/__newBuffer
  local.set $2
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store offset=4 align=1
  i32.const 4
  i32.const 9
  i32.const 1056
  call $~lib/rt/__newBuffer
  local.set $4
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store align=1
  local.get $2
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $6
  local.get $4
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $1
  i32.add
  local.tee $0
  i32.const 268435455
  i32.gt_u
  if
   i32.const 656
   i32.const 128
   i32.const 181
   i32.const 7
   call $~lib/builtins/abort
   unreachable
  end
  local.get $6
  i32.const 2
  i32.shl
  local.set $6
  local.get $0
  i32.const 2
  i32.shl
  i32.const 9
  call $~lib/rt/itcms/__new
  local.set $9
  loop $for-loop|00
   local.get $3
   local.get $6
   i32.lt_u
   if
    local.get $3
    local.get $9
    i32.add
    local.get $2
    local.get $3
    i32.add
    i32.load
    local.tee $0
    i32.store
    local.get $9
    local.get $0
    i32.const 1
    call $~lib/rt/itcms/__link
    local.get $3
    i32.const 4
    i32.add
    local.set $3
    br $for-loop|00
   end
  end
  local.get $6
  local.get $9
  i32.add
  local.set $6
  local.get $1
  i32.const 2
  i32.shl
  local.set $1
  i32.const 0
  local.set $2
  loop $for-loop|11
   local.get $1
   local.get $2
   i32.gt_u
   if
    local.get $2
    local.get $6
    i32.add
    local.get $2
    local.get $4
    i32.add
    i32.load
    local.tee $0
    i32.store
    local.get $9
    local.get $0
    i32.const 1
    call $~lib/rt/itcms/__link
    local.get $2
    i32.const 4
    i32.add
    local.set $2
    br $for-loop|11
   end
  end
  local.get $9
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 74
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 20
  i32.const 9
  i32.const 1264
  call $~lib/rt/__newBuffer
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  i32.const 0
  global.set $~argumentsLength
  local.get $1
  i32.const 0
  call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs
  local.tee $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 81
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  local.set $2
  loop $for-loop|2
   local.get $2
   local.get $1
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   i32.lt_s
   if
    local.get $1
    local.get $2
    call $~lib/staticarray/StaticArray<~lib/string/String>#__get
    local.get $0
    local.get $2
    call $~lib/staticarray/StaticArray<~lib/string/String>#__get
    call $~lib/string/String.__eq
    i32.eqz
    if
     i32.const 0
     i32.const 192
     i32.const 84
     i32.const 5
     call $~lib/builtins/abort
     unreachable
    end
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|2
   end
  end
  local.get $1
  i32.const 1
  i32.const 3
  call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
  local.tee $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 88
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/staticarray/StaticArray<~lib/string/String>#__get
  i32.const 1120
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 89
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/staticarray/StaticArray<~lib/string/String>#__get
  i32.const 1152
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 90
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  global.set $~argumentsLength
  local.get $1
  i32.const 1
  call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 1
  i32.sub
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 93
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 0
  i32.const 50
  call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 96
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  global.set $~argumentsLength
  local.get $1
  i32.const 100
  call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  if
   i32.const 0
   i32.const 192
   i32.const 99
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  global.set $~argumentsLength
  local.get $1
  i32.const -1
  call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs
  local.tee $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 102
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/staticarray/StaticArray<~lib/string/String>#__get
  i32.const 1216
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 103
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const -2
  i32.const -2
  call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  if
   i32.const 0
   i32.const 192
   i32.const 106
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 2
  i32.const -2
  call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
  local.tee $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 109
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 0
  call $~lib/staticarray/StaticArray<~lib/string/String>#__get
  i32.const 1152
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 110
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 20
  i32.const 9
  i32.const 1440
  call $~lib/rt/__newBuffer
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  i32.const 0
  i32.const 10
  i32.const 1488
  call $~lib/rt/__newArray
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=4 align=1
  local.get $1
  local.get $0
  call $~lib/staticarray/StaticArray<~lib/string/String>#concat<~lib/array/Array<~lib/string/String>>
  i32.load offset=12
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 120
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  i32.const 10
  i32.const 1552
  call $~lib/rt/__newArray
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=4 align=1
  local.get $1
  local.get $0
  call $~lib/staticarray/StaticArray<~lib/string/String>#concat<~lib/array/Array<~lib/string/String>>
  i32.load offset=12
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 1
  i32.add
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 124
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 20
  i32.const 9
  i32.const 1584
  call $~lib/rt/__newBuffer
  local.tee $0
  i32.const 1120
  i32.const 0
  call $~lib/staticarray/StaticArray<~lib/string/String>#includes
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 131
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1520
  i32.const 0
  call $~lib/staticarray/StaticArray<~lib/string/String>#includes
  if
   i32.const 0
   i32.const 192
   i32.const 132
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1216
  i32.const 5
  call $~lib/staticarray/StaticArray<~lib/string/String>#includes
  if
   i32.const 0
   i32.const 192
   i32.const 133
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1216
  i32.const -1
  call $~lib/staticarray/StaticArray<~lib/string/String>#includes
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 134
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/staticarray/StaticArray<f64>#includes$102 (result i32)
   i32.const 0
   local.set $2
   i32.const 0
   i32.const 8
   i32.const 12
   i32.const 1632
   call $~lib/rt/__newBuffer
   local.tee $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 3
   i32.shr_u
   local.tee $1
   i32.eqz
   local.get $1
   i32.eqz
   i32.or
   br_if $__inlined_func$~lib/staticarray/StaticArray<f64>#includes$102
   drop
   loop $while-continue|0
    local.get $1
    local.get $2
    i32.gt_s
    if
     i32.const 1
     local.get $0
     local.get $2
     i32.const 3
     i32.shl
     i32.add
     f64.load
     local.tee $14
     local.get $14
     f64.ne
     br_if $__inlined_func$~lib/staticarray/StaticArray<f64>#includes$102
     drop
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $while-continue|0
    end
   end
   i32.const 0
  end
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 136
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/staticarray/StaticArray<f32>#includes$103 (result i32)
   i32.const 0
   local.set $2
   i32.const 0
   i32.const 4
   i32.const 13
   i32.const 1664
   call $~lib/rt/__newBuffer
   local.tee $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   local.tee $1
   i32.eqz
   local.get $1
   i32.eqz
   i32.or
   br_if $__inlined_func$~lib/staticarray/StaticArray<f32>#includes$103
   drop
   loop $while-continue|02
    local.get $1
    local.get $2
    i32.gt_s
    if
     i32.const 1
     local.get $0
     local.get $2
     i32.const 2
     i32.shl
     i32.add
     f32.load
     local.tee $15
     local.get $15
     f32.ne
     br_if $__inlined_func$~lib/staticarray/StaticArray<f32>#includes$103
     drop
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $while-continue|02
    end
   end
   i32.const 0
  end
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 137
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 12
  i32.const 4
  i32.const 1696
  call $~lib/rt/__newBuffer
  local.tee $0
  i32.const 2
  i32.const 0
  call $~lib/staticarray/StaticArray<i32>#indexOf
  if
   i32.const 0
   i32.const 192
   i32.const 143
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 7
  i32.const 0
  call $~lib/staticarray/StaticArray<i32>#indexOf
  i32.const -1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 144
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 9
  i32.const 2
  call $~lib/staticarray/StaticArray<i32>#indexOf
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 145
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const -1
  call $~lib/staticarray/StaticArray<i32>#indexOf
  i32.const -1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 146
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const -3
  call $~lib/staticarray/StaticArray<i32>#indexOf
  if
   i32.const 0
   i32.const 192
   i32.const 147
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 16
  i32.const 4
  i32.const 1728
  call $~lib/rt/__newBuffer
  local.tee $0
  i32.const 2
  i32.const 1
  global.set $~argumentsLength
  i32.const 0
  call $~lib/staticarray/StaticArray<i32>#lastIndexOf@varargs
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 153
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  global.set $~argumentsLength
  local.get $0
  i32.const 7
  i32.const 0
  call $~lib/staticarray/StaticArray<i32>#lastIndexOf@varargs
  i32.const -1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 154
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 3
  call $~lib/staticarray/StaticArray<i32>#lastIndexOf
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 155
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const 2
  call $~lib/staticarray/StaticArray<i32>#lastIndexOf
  if
   i32.const 0
   i32.const 192
   i32.const 156
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const -2
  call $~lib/staticarray/StaticArray<i32>#lastIndexOf
  if
   i32.const 0
   i32.const 192
   i32.const 157
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2
  i32.const -1
  call $~lib/staticarray/StaticArray<i32>#lastIndexOf
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 158
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 12
  i32.const 9
  i32.const 1872
  call $~lib/rt/__newBuffer
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store offset=4 align=1
  local.get $1
  i32.const 1936
  call $~lib/staticarray/StaticArray<~lib/string/String>#join
  i32.const 1968
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 164
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 1904
  call $~lib/staticarray/StaticArray<~lib/string/String>#join
  i32.const 2016
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 165
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 2064
  call $~lib/staticarray/StaticArray<~lib/string/String>#join
  i32.const 2096
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 166
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 2144
  call $~lib/staticarray/StaticArray<~lib/string/String>#join
  i32.const 2176
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 167
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 1936
  call $~lib/staticarray/StaticArray<~lib/string/String>#join
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  local.get $1
  i32.const 1936
  call $~lib/staticarray/StaticArray<~lib/string/String>#join
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 168
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 8
  i32.const 4
  i32.const 2240
  call $~lib/rt/__newBuffer
  local.set $1
  i32.const 2
  global.set $~argumentsLength
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.set $0
  i32.const 1
  local.get $0
  local.get $0
  i32.const 1
  i32.gt_s
  select
  local.set $3
  loop $for-loop|01
   local.get $0
   local.get $3
   i32.gt_s
   if
    local.get $1
    local.get $3
    i32.const 2
    i32.shl
    i32.add
    i32.const 1
    i32.store
    local.get $3
    i32.const 1
    i32.add
    local.set $3
    br $for-loop|01
   end
  end
  local.get $1
  i32.const 0
  call $~lib/staticarray/StaticArray<i32>#__get
  if
   i32.const 0
   i32.const 192
   i32.const 176
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 177
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  local.set $0
  i32.const 12
  i32.const 4
  i32.const 2272
  call $~lib/rt/__newBuffer
  local.tee $2
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $1
  i32.const 1
  i32.gt_u
  if
   local.get $1
   i32.const 1
   i32.shr_u
   local.set $3
   local.get $1
   i32.const 1
   i32.sub
   local.set $4
   loop $while-continue|03
    local.get $0
    local.get $3
    i32.lt_u
    if
     local.get $2
     local.get $0
     i32.const 2
     i32.shl
     i32.add
     local.tee $1
     i32.load
     local.set $6
     local.get $1
     local.get $2
     local.get $4
     local.get $0
     i32.sub
     i32.const 2
     i32.shl
     i32.add
     local.tee $1
     i32.load
     i32.store
     local.get $1
     local.get $6
     i32.store
     local.get $0
     i32.const 1
     i32.add
     local.set $0
     br $while-continue|03
    end
   end
  end
  local.get $2
  i32.const 0
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 185
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 186
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $2
  i32.const 2
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 187
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 20
  i32.const 4
  i32.const 2304
  call $~lib/rt/__newBuffer
  local.set $4
  i32.const 2
  global.set $~argumentsLength
  local.get $4
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $3
  local.set $0
  local.get $4
  i32.const 0
  local.tee $6
  i32.const 2
  i32.shl
  i32.add
  local.get $4
  i32.const 3
  local.get $3
  local.get $3
  i32.const 3
  i32.gt_u
  select
  local.tee $1
  i32.const 2
  i32.shl
  i32.add
  local.get $0
  i32.const 0
  i32.lt_s
  if (result i32)
   local.get $0
   local.get $3
   i32.add
   local.tee $0
   i32.const 0
   local.get $0
   i32.const 0
   i32.gt_s
   select
  else
   local.get $0
   local.get $3
   local.get $0
   local.get $3
   i32.lt_s
   select
  end
  local.get $1
  i32.sub
  local.tee $1
  local.get $3
  local.get $6
  i32.sub
  local.tee $0
  local.get $0
  local.get $1
  i32.gt_s
  select
  i32.const 2
  i32.shl
  memory.copy
  local.get $4
  i32.const 0
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 195
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 5
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 196
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 2
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 197
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 3
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 198
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 4
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 5
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 199
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 12
  i32.const 4
  i32.const 2352
  call $~lib/rt/__newBuffer
  local.set $5
  global.get $~lib/memory/__stack_pointer
  local.get $5
  i32.store align=1
  global.get $~lib/memory/__stack_pointer
  local.get $5
  i32.store offset=4 align=1
  i32.const 0
  local.set $2
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $5
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.tee $6
  i32.const 7
  i32.const 0
  call $~lib/rt/__newArray
  local.set $4
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store align=1
  local.get $4
  i32.load offset=4
  local.set $1
  loop $for-loop|05
   local.get $2
   local.get $6
   i32.lt_s
   if
    local.get $1
    local.get $2
    i32.const 2
    i32.shl
    local.tee $0
    i32.add
    local.get $0
    local.get $5
    i32.add
    i32.load
    local.get $2
    local.get $5
    call $start:std/staticarray~anonymous|0
    i32.store
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|05
   end
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $4
  i32.const 0
  call $~lib/array/Array<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 208
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 1
  call $~lib/array/Array<i32>#__get
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 209
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 2
  call $~lib/array/Array<i32>#__get
  i32.const 4
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 210
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  local.set $2
  local.get $5
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.set $0
  loop $for-loop|003
   local.get $0
   local.get $2
   i32.gt_s
   if
    local.get $5
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.get $2
    global.get $~lib/memory/__stack_pointer
    local.get $5
    i32.store offset=4 align=1
    local.get $5
    i32.const 3
    global.set $~argumentsLength
    i32.const 2
    call_indirect (type $3)
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|003
   end
  end
  global.get $std/staticarray/maxVal
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 216
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/memory/__stack_pointer
  local.get $5
  i32.store offset=4 align=1
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 0
  i32.const 7
  i32.const 0
  call $~lib/rt/__newArray
  local.set $8
  global.get $~lib/memory/__stack_pointer
  local.get $8
  i32.store align=1
  i32.const 0
  local.set $3
  local.get $5
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.set $13
  loop $for-loop|04
   local.get $3
   local.get $13
   i32.lt_s
   if
    local.get $5
    local.get $3
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.tee $9
    local.get $3
    local.get $5
    call $start:std/staticarray~anonymous|2
    if
     local.get $8
     i32.load offset=12
     local.tee $2
     i32.const 1
     i32.add
     local.tee $4
     local.tee $6
     local.get $8
     i32.load offset=8
     local.tee $0
     i32.const 2
     i32.shr_u
     i32.gt_u
     if
      local.get $6
      i32.const 268435455
      i32.gt_u
      if
       i32.const 656
       i32.const 752
       i32.const 30
       i32.const 48
       call $~lib/builtins/abort
       unreachable
      end
      local.get $8
      i32.load
      local.tee $12
      block $__inlined_func$~lib/rt/itcms/__renew$140 (result i32)
       i32.const 1073741820
       local.get $0
       i32.const 1
       i32.shl
       local.tee $0
       local.get $0
       i32.const 1073741820
       i32.ge_u
       select
       local.tee $1
       i32.const 8
       local.get $6
       local.get $6
       i32.const 8
       i32.le_u
       select
       i32.const 2
       i32.shl
       local.tee $0
       local.get $0
       local.get $1
       i32.lt_u
       select
       local.tee $6
       local.get $12
       i32.const 20
       i32.sub
       local.tee $0
       i32.load
       i32.const -4
       i32.and
       i32.const 16
       i32.sub
       i32.le_u
       if
        local.get $0
        local.get $6
        i32.store offset=16
        local.get $12
        br $__inlined_func$~lib/rt/itcms/__renew$140
       end
       local.get $6
       local.get $0
       i32.load offset=12
       call $~lib/rt/itcms/__new
       local.tee $1
       local.get $12
       local.get $6
       local.get $0
       i32.load offset=16
       local.tee $0
       local.get $0
       local.get $6
       i32.gt_u
       select
       memory.copy
       local.get $1
      end
      local.tee $0
      i32.ne
      if
       local.get $8
       local.get $0
       i32.store
       local.get $8
       local.get $0
       i32.store offset=4
       local.get $8
       local.get $0
       i32.const 0
       call $~lib/rt/itcms/__link
      end
      local.get $8
      local.get $6
      i32.store offset=8
     end
     local.get $8
     i32.load offset=4
     local.get $2
     i32.const 2
     i32.shl
     i32.add
     local.get $9
     i32.store
     local.get $8
     local.get $4
     i32.store offset=12
    end
    local.get $3
    i32.const 1
    i32.add
    local.set $3
    br $for-loop|04
   end
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $8
  i32.load offset=12
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 220
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $8
  i32.const 0
  call $~lib/array/Array<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 221
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $8
  i32.const 1
  call $~lib/array/Array<i32>#__get
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 222
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  local.set $2
  i32.const 0
  local.set $3
  local.get $5
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  local.set $0
  loop $for-loop|056
   local.get $0
   local.get $2
   i32.gt_s
   if
    local.get $3
    local.get $5
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.get $2
    local.get $5
    call $start:std/staticarray~anonymous|3
    local.set $3
    local.get $2
    i32.const 1
    i32.add
    local.set $2
    br $for-loop|056
   end
  end
  local.get $3
  i32.const 6
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 226
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 0
  local.set $3
  local.get $5
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 1
  i32.sub
  local.set $2
  loop $for-loop|06
   local.get $2
   i32.const 0
   i32.ge_s
   if
    local.get $3
    local.get $5
    local.get $2
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.get $2
    local.get $5
    call $start:std/staticarray~anonymous|3
    local.set $3
    local.get $2
    i32.const 1
    i32.sub
    local.set $2
    br $for-loop|06
   end
  end
  local.get $3
  i32.const 6
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 230
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  i32.const 6
  call $~lib/staticarray/StaticArray<i32>#someImpl
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 233
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  i32.const 7
  call $~lib/staticarray/StaticArray<i32>#someImpl
  if
   i32.const 0
   i32.const 192
   i32.const 234
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  i32.const 8
  call $~lib/staticarray/StaticArray<i32>#everyImpl
  i32.eqz
  if
   i32.const 0
   i32.const 192
   i32.const 237
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  i32.const 9
  call $~lib/staticarray/StaticArray<i32>#everyImpl
  if
   i32.const 0
   i32.const 192
   i32.const 238
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  i32.const 10
  call $~lib/staticarray/StaticArray<i32>#findIndexImpl
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 241
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  i32.const 11
  call $~lib/staticarray/StaticArray<i32>#findIndexImpl
  i32.const -1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 242
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/staticarray/StaticArray<i32>#findLastIndex$12 (result i32)
   local.get $5
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   i32.const 1
   i32.sub
   local.set $2
   loop $for-loop|017
    local.get $2
    i32.const 0
    i32.ge_s
    if
     local.get $2
     local.get $5
     local.get $2
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.get $2
     global.get $~lib/memory/__stack_pointer
     local.get $5
     i32.store offset=4 align=1
     local.get $5
     i32.const 3
     global.set $~argumentsLength
     i32.const 12
     call_indirect (type $1)
     br_if $__inlined_func$~lib/staticarray/StaticArray<i32>#findLastIndex$12
     drop
     local.get $2
     i32.const 1
     i32.sub
     local.set $2
     br $for-loop|017
    end
   end
   i32.const -1
  end
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 245
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/staticarray/StaticArray<i32>#findLastIndex$13 (result i32)
   local.get $5
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   i32.const 1
   i32.sub
   local.set $2
   loop $for-loop|02
    local.get $2
    i32.const 0
    i32.ge_s
    if
     local.get $2
     local.get $5
     local.get $2
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.get $2
     global.get $~lib/memory/__stack_pointer
     local.get $5
     i32.store align=1
     local.get $5
     i32.const 3
     global.set $~argumentsLength
     i32.const 13
     call_indirect (type $1)
     br_if $__inlined_func$~lib/staticarray/StaticArray<i32>#findLastIndex$13
     drop
     local.get $2
     i32.const 1
     i32.sub
     local.set $2
     br $for-loop|02
    end
   end
   i32.const -1
  end
  i32.const -1
  i32.ne
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
  if
   i32.const 0
   i32.const 192
   i32.const 246
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 16
  i32.const 4
  i32.const 2800
  call $~lib/rt/__newBuffer
  local.set $7
  i32.const 0
  global.set $~argumentsLength
  i32.const 0
  local.set $0
  block $__inlined_func$~lib/util/sort/SORT<i32>$141
   local.get $7
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   local.tee $4
   i32.const 48
   i32.le_u
   if
    local.get $4
    i32.const 1
    i32.le_u
    br_if $__inlined_func$~lib/util/sort/SORT<i32>$141
    block $break|0
     block $case1|0
      local.get $4
      i32.const 3
      i32.ne
      if
       local.get $4
       i32.const 2
       i32.eq
       br_if $case1|0
       br $break|0
      end
      local.get $7
      i32.load
      local.set $4
      local.get $7
      i32.load offset=4
      local.set $1
      i32.const 2
      global.set $~argumentsLength
      local.get $7
      local.get $1
      local.get $4
      local.get $4
      local.get $1
      i32.const 2848
      i32.load
      call_indirect (type $0)
      i32.const 0
      i32.gt_s
      local.tee $0
      select
      i32.store
      local.get $7
      i32.load offset=8
      local.set $6
      i32.const 2
      global.set $~argumentsLength
      local.get $4
      local.get $1
      local.get $0
      select
      local.tee $1
      local.get $6
      i32.const 2848
      i32.load
      call_indirect (type $0)
      i32.const 0
      i32.gt_s
      local.set $0
      local.get $7
      local.get $6
      local.get $1
      local.get $0
      select
      i32.store offset=4
      local.get $7
      local.get $1
      local.get $6
      local.get $0
      select
      i32.store offset=8
     end
     local.get $7
     i32.load
     local.set $6
     local.get $7
     i32.load offset=4
     local.set $1
     i32.const 2
     global.set $~argumentsLength
     local.get $7
     local.get $1
     local.get $6
     local.get $6
     local.get $1
     i32.const 2848
     i32.load
     call_indirect (type $0)
     i32.const 0
     i32.gt_s
     local.tee $0
     select
     i32.store
     local.get $7
     local.get $6
     local.get $1
     local.get $0
     select
     i32.store offset=4
     br $__inlined_func$~lib/util/sort/SORT<i32>$141
    end
    local.get $7
    i32.const 0
    local.get $4
    i32.const 1
    i32.sub
    i32.const 0
    call $~lib/util/sort/insertionSort<i32>
    br $__inlined_func$~lib/util/sort/SORT<i32>$141
   end
   i32.const 33
   local.get $4
   i32.clz
   i32.sub
   local.tee $6
   i32.const 2
   i32.shl
   local.tee $1
   i32.const 1
   i32.shl
   call $~lib/rt/tlsf/__alloc
   local.set $11
   loop $for-loop|13
    local.get $0
    local.get $6
    i32.lt_u
    if
     local.get $11
     local.get $0
     i32.const 2
     i32.shl
     i32.add
     i32.const -1
     i32.store
     local.get $0
     i32.const 1
     i32.add
     local.set $0
     br $for-loop|13
    end
   end
   local.get $4
   i32.const 2
   i32.shl
   call $~lib/rt/tlsf/__alloc
   local.set $5
   local.get $7
   i32.const 0
   local.get $4
   i32.const 1
   i32.sub
   local.tee $10
   call $~lib/util/sort/extendRunRight<i32>
   local.tee $3
   i32.const 1
   i32.add
   local.tee $0
   i32.const 32
   i32.lt_s
   if
    local.get $7
    i32.const 0
    i32.const 31
    local.get $10
    local.get $10
    i32.const 31
    i32.ge_s
    select
    local.tee $3
    local.get $0
    call $~lib/util/sort/insertionSort<i32>
   end
   local.get $1
   local.get $11
   i32.add
   local.set $8
   i32.const 0
   local.set $2
   i32.const 0
   local.set $0
   loop $while-continue|2
    local.get $3
    local.get $10
    i32.lt_s
    if
     local.get $7
     local.get $3
     i32.const 1
     i32.add
     local.tee $4
     local.get $10
     call $~lib/util/sort/extendRunRight<i32>
     local.tee $6
     local.get $4
     i32.sub
     i32.const 1
     i32.add
     local.tee $9
     i32.const 32
     i32.lt_s
     if
      local.get $7
      local.get $4
      local.get $10
      local.get $4
      i32.const 31
      i32.add
      local.tee $1
      local.get $1
      local.get $10
      i32.gt_s
      select
      local.tee $6
      local.get $9
      call $~lib/util/sort/insertionSort<i32>
     end
     local.get $0
     local.get $4
     i32.add
     i64.extend_i32_u
     i64.const 30
     i64.shl
     local.get $10
     i32.const 1
     i32.add
     i64.extend_i32_u
     local.tee $16
     i64.div_u
     local.get $4
     local.get $6
     i32.add
     i32.const 1
     i32.add
     i64.extend_i32_u
     i64.const 30
     i64.shl
     local.get $16
     i64.div_u
     i64.xor
     i32.wrap_i64
     i32.clz
     local.set $1
     loop $for-loop|3
      local.get $1
      local.get $2
      i32.lt_u
      if
       local.get $11
       local.get $2
       i32.const 2
       i32.shl
       local.tee $12
       i32.add
       local.tee $13
       i32.load
       local.tee $9
       i32.const -1
       i32.ne
       if
        local.get $7
        local.get $9
        local.get $8
        local.get $12
        i32.add
        i32.load
        i32.const 1
        i32.add
        local.get $3
        local.get $5
        call $~lib/util/sort/mergeRuns<i32>
        local.get $13
        i32.const -1
        i32.store
        local.get $9
        local.set $0
       end
       local.get $2
       i32.const 1
       i32.sub
       local.set $2
       br $for-loop|3
      end
     end
     local.get $11
     local.get $1
     i32.const 2
     i32.shl
     local.tee $2
     i32.add
     local.get $0
     i32.store
     local.get $2
     local.get $8
     i32.add
     local.get $3
     i32.store
     local.get $4
     local.set $0
     local.get $6
     local.set $3
     local.get $1
     local.set $2
     br $while-continue|2
    end
   end
   loop $for-loop|4
    local.get $2
    if
     local.get $11
     local.get $2
     i32.const 2
     i32.shl
     local.tee $1
     i32.add
     i32.load
     local.tee $0
     i32.const -1
     i32.ne
     if
      local.get $7
      local.get $0
      local.get $1
      local.get $8
      i32.add
      i32.load
      i32.const 1
      i32.add
      local.get $10
      local.get $5
      call $~lib/util/sort/mergeRuns<i32>
     end
     local.get $2
     i32.const 1
     i32.sub
     local.set $2
     br $for-loop|4
    end
   end
   local.get $5
   call $~lib/rt/tlsf/__free
   local.get $11
   call $~lib/rt/tlsf/__free
  end
  local.get $7
  i32.const 0
  call $~lib/staticarray/StaticArray<i32>#__get
  if
   i32.const 0
   i32.const 192
   i32.const 254
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $7
  i32.const 1
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 1
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 255
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $7
  i32.const 2
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 2
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 256
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $7
  i32.const 3
  call $~lib/staticarray/StaticArray<i32>#__get
  i32.const 3
  i32.ne
  if
   i32.const 0
   i32.const 192
   i32.const 257
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 35712
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/rt/itcms/state
  i32.const 0
  i32.gt_s
  if
   loop $while-continue|07
    global.get $~lib/rt/itcms/state
    if
     call $~lib/rt/itcms/step
     drop
     br $while-continue|07
    end
   end
  end
  call $~lib/rt/itcms/step
  drop
  loop $while-continue|1
   global.get $~lib/rt/itcms/state
   if
    call $~lib/rt/itcms/step
    drop
    br $while-continue|1
   end
  end
  global.get $~lib/rt/itcms/total
  i64.extend_i32_u
  i64.const 200
  i64.mul
  i64.const 100
  i64.div_u
  i32.wrap_i64
  i32.const 1024
  i32.add
  global.set $~lib/rt/itcms/threshold
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
  i32.const 2944
  i32.lt_s
  if
   unreachable
  end
 )
)
