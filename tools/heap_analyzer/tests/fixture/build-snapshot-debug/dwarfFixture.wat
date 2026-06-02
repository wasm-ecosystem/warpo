(module
 (type $0 (func (param i32 i32)))
 (type $1 (func (param i32)))
 (type $2 (func (param i32 i32 i32)))
 (type $3 (func (param i32 i32) (result i32)))
 (type $4 (func))
 (type $5 (func (param i32) (result i32)))
 (type $6 (func (result i32)))
 (type $7 (func (param i32 i32 i32) (result i32)))
 (type $8 (func (param i32 i32 i32 i32)))
 (type $9 (func (param i32 i32 i64)))
 (type $10 (func (param i32 i32 i32 i32 f32 f32) (result i32)))
 (type $11 (func (param i32 i32 i32 i32 i32) (result i32)))
 (import "MemoryDump" "dumpMemoryRegion" (func $tools/heap_analyzer/tests/fixture/dwarfFixture/dumpMemoryRegion (param i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 36232))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/globalPlayer (mut i32) (i32.const 0))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/globalTree (mut i32) (i32.const 0))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedBuffer (mut i32) (i32.const 0))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedString (mut i32) (i32.const 0))
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
 (global $~lib/rt/__rtti_base i32 (i32.const 3296))
 (global $~lib/memory/__data_end i32 (i32.const 3464))
 (global $~lib/memory/__heap_base i32 (i32.const 36232))
 (memory $0 1)
 (data $0 (i32.const 12) "L")
 (data $0.1 (i32.const 24) "\02\00\00\00:\00\00\00I\00 \00a\00m\00 \00a\00 \00g\00l\00o\00b\00a\00l\00 \00s\00t\00r\00i\00n\00g\00 \00c\00o\00n\00s\00t\00a\00n\00t\00\00\00,")
 (data $1.1 (i32.const 104) "\01\00\00\00\14\00\00\00\n\00\00\00\14\00\00\00\1e\00\00\00(\00\00\002")
 (data $2 (i32.const 140) ",")
 (data $2.1 (i32.const 152) "\04\00\00\00\10\00\00\00p\00\00\00p\00\00\00\14\00\00\00\05")
 (data $3 (i32.const 188) "\1c")
 (data $3.1 (i32.const 200) "\02\00\00\00\04\00\00\00H\00i")
 (data $4 (i32.const 220) "l")
 (data $4.1 (i32.const 232) "\02\00\00\00V\00\00\00T\00h\00e\00 \00q\00u\00i\00c\00k\00 \00b\00r\00o\00w\00n\00 \00f\00o\00x\00 \00j\00u\00m\00p\00s\00 \00o\00v\00e\00r\00 \00t\00h\00e\00 \00l\00a\00z\00y\00 \00d\00o\00g")
 (data $5 (i32.const 332) "\1c")
 (data $5.1 (i32.const 344) "\02\00\00\00\06\00\00\00 \00\14  ")
 (data $6 (i32.const 364) "\1c")
 (data $6.1 (i32.const 376) "\02")
 (data $7 (i32.const 396) "<")
 (data $7.1 (i32.const 408) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00<")
 (data $8.1 (i32.const 472) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $11 (i32.const 588) "<")
 (data $11.1 (i32.const 600) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $12 (i32.const 652) ",")
 (data $12.1 (i32.const 664) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $14 (i32.const 732) "<")
 (data $14.1 (i32.const 744) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $15 (i32.const 796) ",")
 (data $15.1 (i32.const 808) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00<")
 (data $16.1 (i32.const 856) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s")
 (data $17 (i32.const 908) "<")
 (data $17.1 (i32.const 920) "\02\00\00\00$\00\00\00~\00l\00i\00b\00/\00t\00y\00p\00e\00d\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $18 (i32.const 972) "<")
 (data $18.1 (i32.const 984) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00s\00t\00a\00t\00i\00c\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $19 (i32.const 1036) ",")
 (data $19.1 (i32.const 1048) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00\1c")
 (data $20.1 (i32.const 1096) "\02\00\00\00\n\00\00\00S\00w\00o\00r\00d\00\00\00\1c")
 (data $21.1 (i32.const 1128) "\02\00\00\00\0c\00\00\00S\00h\00i\00e\00l\00d\00\1c")
 (data $22.1 (i32.const 1160) "\02\00\00\00\0c\00\00\00P\00o\00t\00i\00o\00n\00\1c")
 (data $23.1 (i32.const 1192) "\02\00\00\00\0c\00\00\00S\00c\00r\00o\00l\00l\00\1c")
 (data $24.1 (i32.const 1224) "\02\00\00\00\06\00\00\00B\00o\00w")
 (data $25 (i32.const 1244) "\1c")
 (data $25.1 (i32.const 1256) "\02\00\00\00\n\00\00\00A\00l\00i\00c\00e\00\00\00,")
 (data $26.1 (i32.const 1288) "\02\00\00\00\16\00\00\00M\00a\00g\00i\00c\00 \00S\00t\00a\00f\00f")
 (data $27 (i32.const 1324) ",")
 (data $27.1 (i32.const 1336) "\02\00\00\00\1a\00\00\00H\00e\00a\00l\00t\00h\00 \00P\00o\00t\00i\00o\00n\00\00\00,")
 (data $28.1 (i32.const 1384) "\02\00\00\00\1a\00\00\00R\00i\00n\00g\00 \00o\00f\00 \00P\00o\00w\00e\00r\00\00\00\1c")
 (data $29.1 (i32.const 1432) "\02\00\00\00\06\00\00\00B\00o\00b")
 (data $30 (i32.const 1452) "\1c")
 (data $30.1 (i32.const 1464) "\02\00\00\00\0c\00\00\00D\00a\00g\00g\00e\00r\00,")
 (data $31.1 (i32.const 1496) "\02\00\00\00\12\00\00\00L\00o\00c\00k\00 \00p\00i\00c\00k")
 (data $32 (i32.const 1532) ",")
 (data $32.1 (i32.const 1544) "\02\00\00\00\10\00\00\00V\00i\00l\00l\00a\00g\00e\00r")
 (data $33 (i32.const 1580) "L")
 (data $33.1 (i32.const 1592) "\02\00\00\00.\00\00\00W\00e\00l\00c\00o\00m\00e\00 \00t\00o\00 \00o\00u\00r\00 \00v\00i\00l\00l\00a\00g\00e\00!")
 (data $34 (i32.const 1660) ",")
 (data $34.1 (i32.const 1672) "\02\00\00\00\10\00\00\00M\00e\00r\00c\00h\00a\00n\00t")
 (data $35 (i32.const 1708) "L")
 (data $35.1 (i32.const 1720) "\02\00\00\006\00\00\00W\00h\00a\00t\00 \00w\00o\00u\00l\00d\00 \00y\00o\00u\00 \00l\00i\00k\00e\00 \00t\00o\00 \00b\00u\00y\00?")
 (data $36 (i32.const 1788) "\1c")
 (data $36.1 (i32.const 1800) "\02\00\00\00\n\00\00\00G\00u\00a\00r\00d\00\00\00<")
 (data $37.1 (i32.const 1832) "\02\00\00\00*\00\00\00H\00a\00l\00t\00!\00 \00W\00h\00o\00 \00g\00o\00e\00s\00 \00t\00h\00e\00r\00e\00?\00\00\00\1c")
 (data $38.1 (i32.const 1896) "\02\00\00\00\n\00\00\00a\00l\00p\00h\00a\00\00\00\1c")
 (data $39.1 (i32.const 1928) "\02\00\00\00\08\00\00\00b\00e\00t\00a\00\00\00\00\00\1c")
 (data $40.1 (i32.const 1960) "\02\00\00\00\n\00\00\00g\00a\00m\00m\00a\00\00\00\1c")
 (data $41.1 (i32.const 1992) "\02\00\00\00\n\00\00\00d\00e\00l\00t\00a\00\00\00,")
 (data $42.1 (i32.const 2024) "\02\00\00\00\0e\00\00\00e\00p\00s\00i\00l\00o\00n")
 (data $43 (i32.const 2060) ",")
 (data $43.1 (i32.const 2072) "\01\00\00\00\14\00\00\00p\07\00\00\90\07\00\00\b0\07\00\00\d0\07\00\00\f0\07")
 (data $44 (i32.const 2108) "|")
 (data $44.1 (i32.const 2120) "\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y")
 (data $45 (i32.const 2236) "\1c")
 (data $45.1 (i32.const 2248) "\02\00\00\00\0c\00\00\00A\00m\00u\00l\00e\00t\00\1c")
 (data $46.1 (i32.const 2280) "\02\00\00\00\06\00\00\00G\00e\00m")
 (data $47 (i32.const 2300) "\1c")
 (data $47.1 (i32.const 2312) "\02\00\00\00\08\00\00\00R\00u\00n\00e\00\00\00\00\00|")
 (data $48.1 (i32.const 2344) "\02\00\00\00l\00\00\00.\00/\00t\00o\00o\00l\00s\00/\00h\00e\00a\00p\00_\00a\00n\00a\00l\00y\00z\00e\00r\00/\00t\00e\00s\00t\00s\00/\00f\00i\00x\00t\00u\00r\00e\00/\00b\00u\00i\00l\00d\00/\00e\00x\00a\00m\00p\00l\00e\00.\00d\00u\00m\00p\00<")
 (data $49.1 (i32.const 2472) "\02\00\00\00$\00\00\00U\00n\00p\00a\00i\00r\00e\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e")
 (data $50 (i32.const 2524) ",")
 (data $50.1 (i32.const 2536) "\02\00\00\00\1c\00\00\00~\00l\00i\00b\00/\00s\00t\00r\00i\00n\00g\00.\00t\00s\00\1c")
 (data $51.1 (i32.const 2584) "\02\00\00\00\08\00\00\00n\00a\00m\00e\00\00\00\00\00,")
 (data $52.1 (i32.const 2616) "\02\00\00\00\18\00\00\00H\00e\00a\00p\00A\00n\00a\00l\00y\00z\00e\00r\00\00\00\00\00,")
 (data $53.1 (i32.const 2664) "\02\00\00\00\0e\00\00\00v\00e\00r\00s\00i\00o\00n")
 (data $54 (i32.const 2700) "\1c")
 (data $54.1 (i32.const 2712) "\02\00\00\00\n\00\00\001\00.\000\00.\000\00\00\00\1c")
 (data $55.1 (i32.const 2744) "\02\00\00\00\0c\00\00\00a\00u\00t\00h\00o\00r\00\1c")
 (data $56.1 (i32.const 2776) "\02\00\00\00\06\00\00\00d\00e\00v")
 (data $57 (i32.const 2796) "<")
 (data $57.1 (i32.const 2808) "\02\00\00\00*\00\00\00O\00b\00j\00e\00c\00t\00 \00a\00l\00r\00e\00a\00d\00y\00 \00p\00i\00n\00n\00e\00d\00\00\00\\")
 (data $58.1 (i32.const 2872) "\02\00\00\00F\00\00\00I\00 \00a\00m\00 \00p\00i\00n\00n\00e\00d\00 \00a\00n\00d\00 \00c\00a\00n\00n\00o\00t\00 \00b\00e\00 \00c\00o\00l\00l\00e\00c\00t\00e\00d")
 (data $59 (i32.const 2956) ",")
 (data $59.1 (i32.const 2968) "\02\00\00\00\1a\00\00\00E\00p\00h\00e\00m\00e\00r\00a\00l\00 \00K\00e\00y\00\00\00\1c")
 (data $60.1 (i32.const 3016) "\02\00\00\00\n\00\00\00t\00e\00m\00p\001\00\00\00\1c")
 (data $61.1 (i32.const 3048) "\02\00\00\00\n\00\00\00t\00e\00m\00p\002\00\00\00\1c")
 (data $62.1 (i32.const 3080) "\02\00\00\00\n\00\00\00t\00e\00m\00p\003\00\00\00|")
 (data $63.1 (i32.const 3112) "\02\00\00\00b\00\00\00t\00o\00o\00l\00s\00/\00h\00e\00a\00p\00_\00a\00n\00a\00l\00y\00z\00e\00r\00/\00t\00e\00s\00t\00s\00/\00f\00i\00x\00t\00u\00r\00e\00/\00d\00w\00a\00r\00f\00F\00i\00x\00t\00u\00r\00e\00.\00t\00s")
 (data $64 (i32.const 3228) "<")
 (data $64.1 (i32.const 3240) "\02\00\00\00(\00\00\00O\00b\00j\00e\00c\00t\00 \00i\00s\00 \00n\00o\00t\00 \00p\00i\00n\00n\00e\00d")
 (data $65 (i32.const 3296) ")\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\02\t\00\00 ")
 (data $65.1 (i32.const 3336) " \00\00\00\00\00\00\00\02A\00\00 \00\00\00\00\00\00\00A\00\00\00 \00\00\00\01\1a\00\00 \00\00\00\01\t\00\00$\t\00\00\00\00\00\00\02A\00\00 \00\00\00\02A\00\00 \00\00\00\00\00\00\00\08\t\00\00\08A\00\00\10\t\12\00\00\00\00\00 \00\00\00\10A\82\00 \00\00\00\10A\82\00 \00\00\00\00\00\00\00\02A\00\00 \00\00\00\02\1a\00\00\02A\00\00 ")
 (export "dumpMemoryRegion" (func $tools/heap_analyzer/tests/fixture/dwarfFixture/dumpMemoryRegion))
 (export "_start" (func $tools/heap_analyzer/tests/fixture/dwarfFixture/_start))
 (export "__new" (func $~lib/rt/itcms/__new))
 (export "__pin" (func $~lib/rt/itcms/__pin))
 (export "__unpin" (func $~lib/rt/itcms/__unpin))
 (export "__collect" (func $~lib/rt/itcms/__collect))
 (export "__rtti_base" (global $~lib/rt/__rtti_base))
 (export "__data_end" (global $~lib/memory/__data_end))
 (export "__stack_pointer" (global $~lib/memory/__stack_pointer))
 (export "__heap_base" (global $~lib/memory/__heap_base))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/itcms/visitRoots
  (local $0 i32)
  (local $1 i32)
  i32.const 32
  call $~lib/rt/itcms/__visit
  i32.const 160
  call $~lib/rt/itcms/__visit
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/globalPlayer
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/globalTree
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedBuffer
  local.tee $0
  if
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedString
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
     i32.const 480
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
   i32.const 36232
   i32.lt_u
   i32.and
   i32.eqz
   if
    i32.const 0
    i32.const 480
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
   i32.const 480
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
    i32.const 480
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
   i32.const 3296
   i32.load
   i32.gt_u
   if
    i32.const 608
    i32.const 672
    i32.const 22
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2
   i32.shl
   i32.const 3300
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
   i32.const 752
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
   i32.const 752
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
   i32.const 752
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
   i32.const 752
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
   i32.const 752
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
    i32.const 752
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
   i32.const 752
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
   i32.const 752
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
   i32.const 752
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
    i32.const 752
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
     i32.const 752
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
     i32.const 752
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
  i32.const 36240
  i32.const 0
  i32.store
  i32.const 37808
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
    i32.const 36240
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
      i32.const 36240
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
  i32.const 36240
  i32.const 37812
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 36240
  global.set $~lib/rt/tlsf/ROOT
 )
 (func $~lib/rt/itcms/step (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
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
      i32.const 36232
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
     i32.const 480
     i32.const 229
     i32.const 20
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 36232
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
     local.tee $1
     i32.const 36232
     i32.ge_u
     if
      global.get $~lib/rt/tlsf/ROOT
      i32.eqz
      if
       call $~lib/rt/tlsf/initialize
      end
      global.get $~lib/rt/tlsf/ROOT
      local.set $2
      local.get $1
      i32.const 4
      i32.sub
      local.set $0
      local.get $1
      i32.const 15
      i32.and
      i32.const 1
      local.get $1
      select
      if (result i32)
       i32.const 1
      else
       local.get $0
       i32.load
       i32.const 1
       i32.and
      end
      if
       i32.const 0
       i32.const 752
       i32.const 532
       i32.const 3
       call $~lib/builtins/abort
       unreachable
      end
      local.get $0
      local.get $0
      i32.load
      i32.const 1
      i32.or
      i32.store
      local.get $2
      local.get $0
      call $~lib/rt/tlsf/insertBlock
     end
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
   i32.const 752
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
     i32.const 752
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
   i32.const 416
   i32.const 480
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
    local.set $3
    loop $do-loop|0
     local.get $3
     call $~lib/rt/itcms/step
     i32.sub
     local.set $3
     global.get $~lib/rt/itcms/state
     i32.eqz
     if
      global.get $~lib/rt/itcms/total
      i32.const 1
      i32.shl
      i32.const 1024
      i32.add
      global.set $~lib/rt/itcms/threshold
      br $__inlined_func$~lib/rt/itcms/interrupt$69
     end
     local.get $3
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
  local.tee $3
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 416
   i32.const 752
   i32.const 435
   i32.const 29
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 12
  local.get $3
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.get $3
  i32.const 12
  i32.le_u
  select
  local.tee $3
  call $~lib/rt/tlsf/searchBlock
  local.tee $2
  i32.eqz
  if
   local.get $3
   local.tee $2
   i32.const 256
   i32.ge_u
   if (result i32)
    local.get $2
    i32.const 1
    i32.const 27
    local.get $2
    i32.clz
    i32.sub
    i32.shl
    i32.add
    i32.const 1
    i32.sub
    local.get $2
    local.get $2
    i32.const 536870910
    i32.lt_u
    select
   else
    local.get $2
   end
   i32.const 4
   local.get $4
   i32.load offset=1568
   memory.size
   local.tee $5
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
   local.set $2
   local.get $5
   local.get $2
   local.get $2
   local.get $5
   i32.lt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $2
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
   local.get $4
   local.get $5
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
    i32.const 752
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
   i32.const 752
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
  local.set $6
  local.get $3
  i32.const 4
  i32.add
  i32.const 15
  i32.and
  if
   i32.const 0
   i32.const 752
   i32.const 336
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $6
  i32.const -4
  i32.and
  local.get $3
  i32.sub
  local.tee $5
  i32.const 16
  i32.ge_u
  if
   local.get $2
   local.get $3
   local.get $6
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
   local.get $5
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
   local.get $6
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
 (func $~lib/string/String.__concat (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const -2
  i32.and
  local.tee $3
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const -2
  i32.and
  local.tee $4
  i32.add
  local.tee $2
  if (result i32)
   local.get $2
   i32.const 2
   call $~lib/rt/itcms/__new
   local.tee $2
   local.get $0
   local.get $3
   memory.copy
   local.get $2
   local.get $3
   i32.add
   local.get $1
   local.get $4
   memory.copy
   local.get $2
  else
   i32.const 384
  end
 )
 (func $~lib/rt/itcms/__link (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  if
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 480
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
 (func $~lib/arraybuffer/ArrayBufferView#set:buffer (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store
  local.get $0
  local.get $1
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/arraybuffer/ArrayBufferView#constructor (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $1
  i32.const 1073741820
  local.get $2
  i32.shr_u
  i32.gt_u
  if
   i32.const 816
   i32.const 864
   i32.const 20
   i32.const 59
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  local.get $2
  i32.shl
  local.tee $1
  i32.const 1
  call $~lib/rt/itcms/__new
  local.tee $2
  call $~lib/arraybuffer/ArrayBufferView#set:buffer
  local.get $0
  local.get $2
  i32.store offset=4
  local.get $0
  local.get $1
  i32.store offset=8
  local.get $0
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 32
  i32.const 1
  call $~lib/rt/itcms/__new
  local.tee $1
  call $~lib/arraybuffer/ArrayBufferView#set:buffer
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  i32.const 32
  i32.store offset=8
  local.get $0
  i32.const 0
  i32.store offset=12
  local.get $0
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  local.get $1
  call $~lib/arraybuffer/ArrayBufferView#set:buffer
  local.get $0
  local.get $2
  i32.store offset=4
  local.get $0
 )
 (func $~lib/array/ensureCapacity (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  local.tee $3
  local.get $2
  i32.shr_u
  i32.gt_u
  if
   local.get $1
   i32.const 1073741820
   local.get $2
   i32.shr_u
   i32.gt_u
   if
    i32.const 816
    i32.const 1056
    i32.const 30
    i32.const 48
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.load
   local.tee $4
   block $__inlined_func$~lib/rt/itcms/__renew$332 (result i32)
    i32.const 1073741820
    local.get $3
    i32.const 1
    i32.shl
    local.tee $3
    local.get $3
    i32.const 1073741820
    i32.ge_u
    select
    local.tee $3
    i32.const 8
    local.get $1
    local.get $1
    i32.const 8
    i32.le_u
    select
    local.get $2
    i32.shl
    local.tee $1
    local.get $1
    local.get $3
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
     br $__inlined_func$~lib/rt/itcms/__renew$332
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
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  local.get $0
  i32.load offset=12
  local.tee $2
  i32.const 1
  i32.add
  local.tee $3
  i32.const 2
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
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  i32.store offset=8
  local.get $0
  local.get $1
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#constructor (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 f32) (param $5 f32) (result i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  local.get $0
  local.get $1
  i32.store
  i32.const 8
  i32.const 9
  call $~lib/rt/itcms/__new
  local.tee $1
  local.get $4
  f32.store
  local.get $1
  local.get $5
  f32.store offset=4
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $1
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $0
  local.get $2
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
  local.get $0
  local.get $3
  i32.store offset=12
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=4 align=1
  i32.const 16
  i32.const 11
  call $~lib/rt/itcms/__new
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $0
  local.get $1
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
  local.tee $1
  i32.store offset=16
  local.get $0
  local.get $1
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $0
  i32.const 0
  i32.store offset=20
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem (param $0 i32) (param $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.load offset=16
  local.tee $0
  i32.store align=1
  local.get $0
  local.get $1
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#constructor (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i32) (result i32)
  local.get $0
  local.get $1
  i32.store
  i32.const 8
  i32.const 9
  call $~lib/rt/itcms/__new
  local.tee $1
  f32.const 0
  f32.store
  local.get $1
  f32.const 0
  f32.store offset=4
  local.get $0
  local.get $1
  i32.store offset=4
  local.get $0
  local.get $1
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $0
  local.get $2
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
  local.get $0
  local.get $3
  i32.store offset=12
  local.get $0
  local.get $4
  i32.store offset=16
  local.get $0
  local.get $4
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $0
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/buildTree (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 12
  i32.const 13
  call $~lib/rt/itcms/__new
  local.tee $2
  local.get $1
  i32.store
  local.get $2
  i32.const 0
  i32.store offset=4
  local.get $2
  i32.const 0
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $2
  i32.const 0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store align=1
  local.get $0
  i32.const 0
  i32.gt_s
  if
   local.get $2
   local.get $0
   i32.const 1
   i32.sub
   local.tee $0
   local.get $1
   i32.const 1
   i32.shl
   local.tee $1
   call $tools/heap_analyzer/tests/fixture/dwarfFixture/buildTree
   local.tee $3
   i32.store offset=4
   local.get $2
   local.get $3
   i32.const 0
   call $~lib/rt/itcms/__link
   local.get $2
   local.get $0
   local.get $1
   i32.const 1
   i32.add
   call $tools/heap_analyzer/tests/fixture/dwarfFixture/buildTree
   call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $2
 )
 (func $~lib/arraybuffer/ArrayBuffer#constructor (param $0 i32) (result i32)
  local.get $0
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 816
   i32.const 864
   i32.const 50
   i32.const 43
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  call $~lib/rt/itcms/__new
 )
 (func $~lib/set/Set<i32>#add (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  block $__inlined_func$~lib/set/Set<i32>#find$335 (result i32)
   local.get $0
   i32.load
   local.get $1
   i32.const -1028477379
   i32.mul
   i32.const 374761397
   i32.add
   i32.const 17
   i32.rotl
   i32.const 668265263
   i32.mul
   local.tee $2
   i32.const 15
   i32.shr_u
   local.get $2
   i32.xor
   i32.const -2048144777
   i32.mul
   local.tee $2
   i32.const 13
   i32.shr_u
   local.get $2
   i32.xor
   i32.const -1028477379
   i32.mul
   local.tee $2
   i32.const 16
   i32.shr_u
   local.get $2
   i32.xor
   local.tee $8
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   i32.load
   local.set $3
   loop $while-continue|0
    local.get $3
    if
     local.get $3
     local.get $3
     i32.load offset=4
     local.tee $2
     i32.const 1
     i32.and
     if (result i32)
      i32.const 0
     else
      local.get $1
      local.get $3
      i32.load
      i32.eq
     end
     br_if $__inlined_func$~lib/set/Set<i32>#find$335
     drop
     local.get $2
     i32.const -2
     i32.and
     local.set $3
     br $while-continue|0
    end
   end
   i32.const 0
  end
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    local.set $6
    i32.const 16
    call $~lib/rt/__decrease_sp
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $2
    global.get $~lib/memory/__stack_pointer
    local.get $2
    i32.store offset=8 align=1
    local.get $6
    i32.const 1
    i32.add
    local.tee $3
    i32.const 2
    i32.shl
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $7
    global.get $~lib/memory/__stack_pointer
    local.get $7
    i32.store offset=12 align=1
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $2
    global.get $~lib/memory/__stack_pointer
    local.get $2
    i32.store offset=8 align=1
    local.get $3
    i32.const 3
    i32.shl
    i32.const 3
    i32.div_s
    local.tee $9
    i32.const 3
    i32.shl
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $2
    local.get $0
    i32.load offset=8
    local.tee $5
    local.get $0
    i32.load offset=16
    i32.const 3
    i32.shl
    i32.add
    local.set $10
    local.get $2
    local.set $3
    loop $while-continue|00
     local.get $5
     local.get $10
     i32.ne
     if
      local.get $5
      i32.load offset=4
      i32.const 1
      i32.and
      i32.eqz
      if
       local.get $3
       local.get $5
       i32.load
       local.tee $4
       i32.store
       local.get $3
       local.get $7
       local.get $6
       local.get $4
       i32.const -1028477379
       i32.mul
       i32.const 374761397
       i32.add
       i32.const 17
       i32.rotl
       i32.const 668265263
       i32.mul
       local.tee $4
       i32.const 15
       i32.shr_u
       local.get $4
       i32.xor
       i32.const -2048144777
       i32.mul
       local.tee $4
       i32.const 13
       i32.shr_u
       local.get $4
       i32.xor
       i32.const -1028477379
       i32.mul
       local.tee $4
       i32.const 16
       i32.shr_u
       local.get $4
       i32.xor
       i32.and
       i32.const 2
       i32.shl
       i32.add
       local.tee $4
       i32.load
       i32.store offset=4
       local.get $4
       local.get $3
       i32.store
       local.get $3
       i32.const 8
       i32.add
       local.set $3
      end
      local.get $5
      i32.const 8
      i32.add
      local.set $5
      br $while-continue|00
     end
    end
    local.get $0
    local.get $7
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $0
    local.get $6
    i32.store offset=4
    local.get $0
    local.get $2
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
    local.get $0
    local.get $9
    i32.store offset=12
    local.get $0
    local.get $0
    i32.load offset=20
    i32.store offset=16
    global.get $~lib/memory/__stack_pointer
    i32.const 16
    i32.add
    global.set $~lib/memory/__stack_pointer
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 3
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i32.store
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $8
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=4
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#add (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  block $__inlined_func$~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#find$337 (result i32)
   local.get $0
   i32.load
   local.get $1
   i32.const -1028477379
   i32.mul
   i32.const 374761397
   i32.add
   i32.const 17
   i32.rotl
   i32.const 668265263
   i32.mul
   local.tee $2
   i32.const 15
   i32.shr_u
   local.get $2
   i32.xor
   i32.const -2048144777
   i32.mul
   local.tee $2
   i32.const 13
   i32.shr_u
   local.get $2
   i32.xor
   i32.const -1028477379
   i32.mul
   local.tee $2
   i32.const 16
   i32.shr_u
   local.get $2
   i32.xor
   local.tee $8
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   i32.load
   local.set $3
   loop $while-continue|0
    local.get $3
    if
     local.get $3
     local.get $3
     i32.load offset=4
     local.tee $2
     i32.const 1
     i32.and
     if (result i32)
      i32.const 0
     else
      local.get $1
      local.get $3
      i32.load
      i32.eq
     end
     br_if $__inlined_func$~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#find$337
     drop
     local.get $2
     i32.const -2
     i32.and
     local.set $3
     br $while-continue|0
    end
   end
   i32.const 0
  end
  i32.eqz
  if
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    local.set $6
    i32.const 16
    call $~lib/rt/__decrease_sp
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $2
    global.get $~lib/memory/__stack_pointer
    local.get $2
    i32.store offset=8 align=1
    local.get $6
    i32.const 1
    i32.add
    local.tee $3
    i32.const 2
    i32.shl
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $7
    global.get $~lib/memory/__stack_pointer
    local.get $7
    i32.store offset=12 align=1
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $2
    global.get $~lib/memory/__stack_pointer
    local.get $2
    i32.store offset=8 align=1
    local.get $3
    i32.const 3
    i32.shl
    i32.const 3
    i32.div_s
    local.tee $9
    i32.const 3
    i32.shl
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $2
    local.get $0
    i32.load offset=8
    local.tee $5
    local.get $0
    i32.load offset=16
    i32.const 3
    i32.shl
    i32.add
    local.set $10
    local.get $2
    local.set $3
    loop $while-continue|00
     local.get $5
     local.get $10
     i32.ne
     if
      local.get $5
      i32.load offset=4
      i32.const 1
      i32.and
      i32.eqz
      if
       local.get $3
       local.get $5
       i32.load
       local.tee $4
       i32.store
       local.get $3
       local.get $7
       local.get $6
       local.get $4
       i32.const -1028477379
       i32.mul
       i32.const 374761397
       i32.add
       i32.const 17
       i32.rotl
       i32.const 668265263
       i32.mul
       local.tee $4
       i32.const 15
       i32.shr_u
       local.get $4
       i32.xor
       i32.const -2048144777
       i32.mul
       local.tee $4
       i32.const 13
       i32.shr_u
       local.get $4
       i32.xor
       i32.const -1028477379
       i32.mul
       local.tee $4
       i32.const 16
       i32.shr_u
       local.get $4
       i32.xor
       i32.and
       i32.const 2
       i32.shl
       i32.add
       local.tee $4
       i32.load
       i32.store offset=4
       local.get $4
       local.get $3
       i32.store
       local.get $3
       i32.const 8
       i32.add
       local.set $3
      end
      local.get $5
      i32.const 8
      i32.add
      local.set $5
      br $while-continue|00
     end
    end
    local.get $0
    local.get $7
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $0
    local.get $6
    i32.store offset=4
    local.get $0
    local.get $2
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
    local.get $0
    local.get $9
    i32.store offset=12
    local.get $0
    local.get $0
    i32.load offset=20
    i32.store offset=16
    global.get $~lib/memory/__stack_pointer
    i32.const 16
    i32.add
    global.set $~lib/memory/__stack_pointer
   end
   local.get $0
   i32.load offset=8
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $2
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $2
   i32.const 3
   i32.shl
   i32.add
   local.tee $2
   local.get $1
   i32.store
   local.get $0
   local.get $1
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $2
   local.get $0
   i32.load
   local.get $8
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=4
   local.get $0
   local.get $2
   i32.store
  end
 )
 (func $"~lib/map/Map<i32,i32>#set" (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  block $"__inlined_func$~lib/map/Map<i32,i32>#find$339" (result i32)
   local.get $0
   i32.load
   local.get $1
   i32.const -1028477379
   i32.mul
   i32.const 374761397
   i32.add
   i32.const 17
   i32.rotl
   i32.const 668265263
   i32.mul
   local.tee $3
   i32.const 15
   i32.shr_u
   local.get $3
   i32.xor
   i32.const -2048144777
   i32.mul
   local.tee $3
   i32.const 13
   i32.shr_u
   local.get $3
   i32.xor
   i32.const -1028477379
   i32.mul
   local.tee $3
   i32.const 16
   i32.shr_u
   local.get $3
   i32.xor
   local.tee $9
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   i32.load
   local.set $4
   loop $while-continue|0
    local.get $4
    if
     local.get $4
     local.get $4
     i32.load offset=8
     local.tee $3
     i32.const 1
     i32.and
     if (result i32)
      i32.const 0
     else
      local.get $1
      local.get $4
      i32.load
      i32.eq
     end
     br_if $"__inlined_func$~lib/map/Map<i32,i32>#find$339"
     drop
     local.get $3
     i32.const -2
     i32.and
     local.set $4
     br $while-continue|0
    end
   end
   i32.const 0
  end
  local.tee $3
  if
   local.get $3
   local.get $2
   i32.store offset=4
  else
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    local.set $7
    i32.const 16
    call $~lib/rt/__decrease_sp
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $3
    global.get $~lib/memory/__stack_pointer
    local.get $3
    i32.store offset=8 align=1
    local.get $7
    i32.const 1
    i32.add
    local.tee $4
    i32.const 2
    i32.shl
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $8
    global.get $~lib/memory/__stack_pointer
    local.get $8
    i32.store offset=12 align=1
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $3
    global.get $~lib/memory/__stack_pointer
    local.get $3
    i32.store offset=8 align=1
    local.get $4
    i32.const 3
    i32.shl
    i32.const 3
    i32.div_s
    local.tee $10
    i32.const 12
    i32.mul
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $3
    local.get $0
    i32.load offset=8
    local.tee $6
    local.get $0
    i32.load offset=16
    i32.const 12
    i32.mul
    i32.add
    local.set $11
    local.get $3
    local.set $4
    loop $while-continue|00
     local.get $6
     local.get $11
     i32.ne
     if
      local.get $6
      i32.load offset=8
      i32.const 1
      i32.and
      i32.eqz
      if
       local.get $4
       local.get $6
       i32.load
       local.tee $5
       i32.store
       local.get $4
       local.get $6
       i32.load offset=4
       i32.store offset=4
       local.get $4
       local.get $8
       local.get $7
       local.get $5
       i32.const -1028477379
       i32.mul
       i32.const 374761397
       i32.add
       i32.const 17
       i32.rotl
       i32.const 668265263
       i32.mul
       local.tee $5
       i32.const 15
       i32.shr_u
       local.get $5
       i32.xor
       i32.const -2048144777
       i32.mul
       local.tee $5
       i32.const 13
       i32.shr_u
       local.get $5
       i32.xor
       i32.const -1028477379
       i32.mul
       local.tee $5
       i32.const 16
       i32.shr_u
       local.get $5
       i32.xor
       i32.and
       i32.const 2
       i32.shl
       i32.add
       local.tee $5
       i32.load
       i32.store offset=8
       local.get $5
       local.get $4
       i32.store
       local.get $4
       i32.const 12
       i32.add
       local.set $4
      end
      local.get $6
      i32.const 12
      i32.add
      local.set $6
      br $while-continue|00
     end
    end
    local.get $0
    local.get $8
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $0
    local.get $7
    i32.store offset=4
    local.get $0
    local.get $3
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
    local.get $0
    local.get $10
    i32.store offset=12
    local.get $0
    local.get $0
    i32.load offset=20
    i32.store offset=16
    global.get $~lib/memory/__stack_pointer
    i32.const 16
    i32.add
    global.set $~lib/memory/__stack_pointer
   end
   local.get $0
   i32.load offset=8
   local.set $4
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $3
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $4
   local.get $3
   i32.const 12
   i32.mul
   i32.add
   local.tee $3
   local.get $1
   i32.store
   local.get $3
   local.get $2
   i32.store offset=4
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $3
   local.get $0
   i32.load
   local.get $9
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=8
   local.get $0
   local.get $3
   i32.store
  end
 )
 (func $~lib/util/hash/HASH<~lib/string/String> (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $0
  if (result i32)
   local.get $0
   local.tee $1
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const -2
   i32.and
   local.tee $3
   i32.const 16
   i32.ge_u
   if (result i32)
    i32.const 606290984
    local.set $2
    i32.const -2048144777
    local.set $4
    i32.const 1640531535
    local.set $5
    local.get $1
    local.get $3
    i32.add
    i32.const 16
    i32.sub
    local.set $7
    loop $while-continue|0
     local.get $1
     local.get $7
     i32.le_u
     if
      local.get $2
      local.get $1
      i32.load
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $2
      local.get $4
      local.get $1
      i32.load offset=4
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $4
      local.get $6
      local.get $1
      i32.load offset=8
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $6
      local.get $5
      local.get $1
      i32.load offset=12
      i32.const -2048144777
      i32.mul
      i32.add
      i32.const 13
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $5
      local.get $1
      i32.const 16
      i32.add
      local.set $1
      br $while-continue|0
     end
    end
    local.get $3
    local.get $2
    i32.const 1
    i32.rotl
    local.get $4
    i32.const 7
    i32.rotl
    i32.add
    local.get $6
    i32.const 12
    i32.rotl
    i32.add
    local.get $5
    i32.const 18
    i32.rotl
    i32.add
    i32.add
   else
    local.get $3
    i32.const 374761393
    i32.add
   end
   local.set $2
   local.get $0
   local.get $3
   i32.add
   i32.const 4
   i32.sub
   local.set $4
   loop $while-continue|1
    local.get $1
    local.get $4
    i32.le_u
    if
     local.get $2
     local.get $1
     i32.load
     i32.const -1028477379
     i32.mul
     i32.add
     i32.const 17
     i32.rotl
     i32.const 668265263
     i32.mul
     local.set $2
     local.get $1
     i32.const 4
     i32.add
     local.set $1
     br $while-continue|1
    end
   end
   local.get $0
   local.get $3
   i32.add
   local.set $0
   loop $while-continue|2
    local.get $0
    local.get $1
    i32.gt_u
    if
     local.get $2
     local.get $1
     i32.load8_u
     i32.const 374761393
     i32.mul
     i32.add
     i32.const 11
     i32.rotl
     i32.const -1640531535
     i32.mul
     local.set $2
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $while-continue|2
    end
   end
   local.get $2
   local.get $2
   i32.const 15
   i32.shr_u
   i32.xor
   i32.const -2048144777
   i32.mul
   local.tee $0
   i32.const 13
   i32.shr_u
   local.get $0
   i32.xor
   i32.const -1028477379
   i32.mul
   local.tee $0
   i32.const 16
   i32.shr_u
   local.get $0
   i32.xor
  else
   i32.const 0
  end
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
  local.tee $2
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
  block $__inlined_func$~lib/util/string/compareImpl$203 (result i32)
   local.get $0
   local.set $3
   local.get $2
   local.set $0
   loop $while-continue|0
    local.get $0
    local.tee $2
    i32.const 1
    i32.sub
    local.set $0
    local.get $2
    if
     local.get $3
     i32.load16_u
     local.tee $2
     local.get $1
     i32.load16_u
     local.tee $4
     i32.ne
     if
      local.get $2
      local.get $4
      i32.sub
      br $__inlined_func$~lib/util/string/compareImpl$203
     end
     local.get $3
     i32.const 2
     i32.add
     local.set $3
     local.get $1
     i32.const 2
     i32.add
     local.set $1
     br $while-continue|0
    end
   end
   i32.const 0
  end
  i32.eqz
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set" (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  block $"__inlined_func$~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#find$341" (result i32)
   local.get $1
   call $~lib/util/hash/HASH<~lib/string/String>
   local.tee $9
   local.set $3
   local.get $0
   i32.load
   local.get $3
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   i32.load
   local.set $4
   loop $while-continue|0
    local.get $4
    if
     local.get $4
     local.get $4
     i32.load offset=8
     local.tee $3
     i32.const 1
     i32.and
     if (result i32)
      i32.const 0
     else
      local.get $4
      i32.load
      local.get $1
      call $~lib/string/String.__eq
     end
     br_if $"__inlined_func$~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#find$341"
     drop
     local.get $3
     i32.const -2
     i32.and
     local.set $4
     br $while-continue|0
    end
   end
   i32.const 0
  end
  local.tee $3
  if
   local.get $3
   local.get $2
   i32.store offset=4
   local.get $0
   local.get $2
   i32.const 1
   call $~lib/rt/itcms/__link
  else
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    local.set $6
    i32.const 16
    call $~lib/rt/__decrease_sp
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $3
    global.get $~lib/memory/__stack_pointer
    local.get $3
    i32.store offset=8 align=1
    local.get $6
    i32.const 1
    i32.add
    local.tee $4
    i32.const 2
    i32.shl
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $7
    global.get $~lib/memory/__stack_pointer
    local.get $7
    i32.store offset=12 align=1
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $3
    global.get $~lib/memory/__stack_pointer
    local.get $3
    i32.store offset=8 align=1
    local.get $4
    i32.const 3
    i32.shl
    i32.const 3
    i32.div_s
    local.tee $10
    i32.const 12
    i32.mul
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $3
    local.get $0
    i32.load offset=8
    local.tee $5
    local.get $0
    i32.load offset=16
    i32.const 12
    i32.mul
    i32.add
    local.set $11
    local.get $3
    local.set $4
    loop $while-continue|00
     local.get $5
     local.get $11
     i32.ne
     if
      local.get $5
      i32.load offset=8
      i32.const 1
      i32.and
      i32.eqz
      if
       local.get $4
       local.get $5
       i32.load
       local.tee $8
       i32.store
       local.get $4
       local.get $5
       i32.load offset=4
       i32.store offset=4
       local.get $4
       local.get $7
       local.get $8
       call $~lib/util/hash/HASH<~lib/string/String>
       local.get $6
       i32.and
       i32.const 2
       i32.shl
       i32.add
       local.tee $8
       i32.load
       i32.store offset=8
       local.get $8
       local.get $4
       i32.store
       local.get $4
       i32.const 12
       i32.add
       local.set $4
      end
      local.get $5
      i32.const 12
      i32.add
      local.set $5
      br $while-continue|00
     end
    end
    local.get $0
    local.get $7
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $0
    local.get $6
    i32.store offset=4
    local.get $0
    local.get $3
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
    local.get $0
    local.get $10
    i32.store offset=12
    local.get $0
    local.get $0
    i32.load offset=20
    i32.store offset=16
    global.get $~lib/memory/__stack_pointer
    i32.const 16
    i32.add
    global.set $~lib/memory/__stack_pointer
   end
   local.get $0
   i32.load offset=8
   local.set $4
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $3
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $4
   local.get $3
   i32.const 12
   i32.mul
   i32.add
   local.tee $3
   local.get $1
   i32.store
   local.get $0
   local.get $1
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $3
   local.get $2
   i32.store offset=4
   local.get $0
   local.get $2
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $3
   local.get $0
   i32.load
   local.get $9
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=8
   local.get $0
   local.get $3
   i32.store
  end
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set" (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  block $"__inlined_func$~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#find$343" (result i32)
   local.get $0
   i32.load
   local.get $1
   i32.const -1028477379
   i32.mul
   i32.const 374761397
   i32.add
   i32.const 17
   i32.rotl
   i32.const 668265263
   i32.mul
   local.tee $3
   i32.const 15
   i32.shr_u
   local.get $3
   i32.xor
   i32.const -2048144777
   i32.mul
   local.tee $3
   i32.const 13
   i32.shr_u
   local.get $3
   i32.xor
   i32.const -1028477379
   i32.mul
   local.tee $3
   i32.const 16
   i32.shr_u
   local.get $3
   i32.xor
   local.tee $9
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   i32.load
   local.set $4
   loop $while-continue|0
    local.get $4
    if
     local.get $4
     local.get $4
     i32.load offset=8
     local.tee $3
     i32.const 1
     i32.and
     if (result i32)
      i32.const 0
     else
      local.get $1
      local.get $4
      i32.load
      i32.eq
     end
     br_if $"__inlined_func$~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#find$343"
     drop
     local.get $3
     i32.const -2
     i32.and
     local.set $4
     br $while-continue|0
    end
   end
   i32.const 0
  end
  local.tee $3
  if
   local.get $3
   local.get $2
   i32.store offset=4
   local.get $0
   local.get $2
   i32.const 1
   call $~lib/rt/itcms/__link
  else
   local.get $0
   i32.load offset=16
   local.get $0
   i32.load offset=12
   i32.eq
   if
    local.get $0
    i32.load offset=20
    local.get $0
    i32.load offset=12
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $0
     i32.load offset=4
    else
     local.get $0
     i32.load offset=4
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    local.set $7
    i32.const 16
    call $~lib/rt/__decrease_sp
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $3
    global.get $~lib/memory/__stack_pointer
    local.get $3
    i32.store offset=8 align=1
    local.get $7
    i32.const 1
    i32.add
    local.tee $4
    i32.const 2
    i32.shl
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $8
    global.get $~lib/memory/__stack_pointer
    local.get $8
    i32.store offset=12 align=1
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $3
    global.get $~lib/memory/__stack_pointer
    local.get $3
    i32.store offset=8 align=1
    local.get $4
    i32.const 3
    i32.shl
    i32.const 3
    i32.div_s
    local.tee $10
    i32.const 12
    i32.mul
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $3
    local.get $0
    i32.load offset=8
    local.tee $6
    local.get $0
    i32.load offset=16
    i32.const 12
    i32.mul
    i32.add
    local.set $11
    local.get $3
    local.set $4
    loop $while-continue|00
     local.get $6
     local.get $11
     i32.ne
     if
      local.get $6
      i32.load offset=8
      i32.const 1
      i32.and
      i32.eqz
      if
       local.get $4
       local.get $6
       i32.load
       local.tee $5
       i32.store
       local.get $4
       local.get $6
       i32.load offset=4
       i32.store offset=4
       local.get $4
       local.get $8
       local.get $7
       local.get $5
       i32.const -1028477379
       i32.mul
       i32.const 374761397
       i32.add
       i32.const 17
       i32.rotl
       i32.const 668265263
       i32.mul
       local.tee $5
       i32.const 15
       i32.shr_u
       local.get $5
       i32.xor
       i32.const -2048144777
       i32.mul
       local.tee $5
       i32.const 13
       i32.shr_u
       local.get $5
       i32.xor
       i32.const -1028477379
       i32.mul
       local.tee $5
       i32.const 16
       i32.shr_u
       local.get $5
       i32.xor
       i32.and
       i32.const 2
       i32.shl
       i32.add
       local.tee $5
       i32.load
       i32.store offset=8
       local.get $5
       local.get $4
       i32.store
       local.get $4
       i32.const 12
       i32.add
       local.set $4
      end
      local.get $6
      i32.const 12
      i32.add
      local.set $6
      br $while-continue|00
     end
    end
    local.get $0
    local.get $8
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $0
    local.get $7
    i32.store offset=4
    local.get $0
    local.get $3
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
    local.get $0
    local.get $10
    i32.store offset=12
    local.get $0
    local.get $0
    i32.load offset=20
    i32.store offset=16
    global.get $~lib/memory/__stack_pointer
    i32.const 16
    i32.add
    global.set $~lib/memory/__stack_pointer
   end
   local.get $0
   i32.load offset=8
   local.set $4
   local.get $0
   local.get $0
   i32.load offset=16
   local.tee $3
   i32.const 1
   i32.add
   i32.store offset=16
   local.get $4
   local.get $3
   i32.const 12
   i32.mul
   i32.add
   local.tee $3
   local.get $1
   i32.store
   local.get $0
   local.get $1
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $3
   local.get $2
   i32.store offset=4
   local.get $0
   local.get $2
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $0
   local.get $0
   i32.load offset=20
   i32.const 1
   i32.add
   i32.store offset=20
   local.get $3
   local.get $0
   i32.load
   local.get $9
   local.get $0
   i32.load offset=4
   i32.and
   i32.const 2
   i32.shl
   i32.add
   local.tee $0
   i32.load
   i32.store offset=8
   local.get $0
   local.get $3
   i32.store
  end
 )
 (func $~lib/string/String.UTF8.byteLength (result i32)
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 2352
  local.set $0
  i32.const 2348
  i32.load
  i32.const 2352
  i32.add
  local.set $2
  loop $while-continue|0
   local.get $0
   local.get $2
   i32.lt_u
   if
    local.get $0
    i32.load16_u
    local.tee $3
    i32.const 128
    i32.lt_u
    if (result i32)
     local.get $1
     i32.const 1
     i32.add
    else
     local.get $3
     i32.const 2048
     i32.lt_u
     if (result i32)
      local.get $1
      i32.const 2
      i32.add
     else
      local.get $3
      i32.const 64512
      i32.and
      i32.const 55296
      i32.eq
      local.get $0
      i32.const 2
      i32.add
      local.get $2
      i32.lt_u
      i32.and
      if
       local.get $0
       i32.load16_u offset=2
       i32.const 64512
       i32.and
       i32.const 56320
       i32.eq
       if
        local.get $1
        i32.const 4
        i32.add
        local.set $1
        local.get $0
        i32.const 4
        i32.add
        local.set $0
        br $while-continue|0
       end
      end
      local.get $1
      i32.const 3
      i32.add
     end
    end
    local.set $1
    local.get $0
    i32.const 2
    i32.add
    local.set $0
    br $while-continue|0
   end
  end
  local.get $1
 )
 (func $~lib/rt/itcms/__pin (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  if
   local.get $0
   i32.const 20
   i32.sub
   local.tee $1
   i32.load offset=4
   i32.const 3
   i32.and
   i32.const 3
   i32.eq
   if
    i32.const 2816
    i32.const 480
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
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/_start
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
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $17 i32)
  (local $18 i32)
  (local $19 i32)
  (local $20 i32)
  (local $21 i32)
  (local $22 i32)
  (local $23 i32)
  (local $24 i32)
  (local $25 i32)
  i32.const 88
  call $~lib/rt/__decrease_sp
  i32.const 240
  i32.const 352
  call $~lib/string/String.__concat
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  i32.const 240
  call $~lib/string/String.__concat
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  i32.const 352
  call $~lib/string/String.__concat
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store align=1
  local.get $1
  i32.const 240
  call $~lib/string/String.__concat
  local.set $24
  global.get $~lib/memory/__stack_pointer
  local.get $24
  i32.store align=1
  i32.const 12
  i32.const 14
  call $~lib/rt/itcms/__new
  local.set $1
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.store offset=4 align=1
  local.get $1
  i32.const 64
  i32.const 0
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.set $19
  global.get $~lib/memory/__stack_pointer
  local.get $19
  i32.store offset=4 align=1
  loop $for-loop|0
   local.get $0
   i32.const 64
   i32.lt_s
   if
    local.get $0
    local.get $19
    i32.load offset=8
    i32.ge_u
    if
     i32.const 608
     i32.const 928
     i32.const 193
     i32.const 45
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    local.get $19
    i32.load offset=4
    i32.add
    local.get $0
    i32.store8
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
  i32.const 12
  i32.const 16
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=8 align=1
  local.get $0
  i32.const 16
  i32.const 3
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.set $20
  global.get $~lib/memory/__stack_pointer
  local.get $20
  i32.store offset=8 align=1
  i32.const 0
  local.set $0
  loop $for-loop|1
   local.get $0
   i32.const 16
   i32.lt_s
   if
    local.get $0
    local.get $20
    i32.load offset=8
    i32.const 3
    i32.shr_u
    i32.ge_u
    if
     i32.const 608
     i32.const 928
     i32.const 1508
     i32.const 64
     call $~lib/builtins/abort
     unreachable
    end
    local.get $20
    i32.load offset=4
    local.get $0
    i32.const 3
    i32.shl
    i32.add
    local.get $0
    f64.convert_i32_s
    f64.const 1.5
    f64.mul
    f64.store
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|1
   end
  end
  i32.const 12
  i32.const 18
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=12 align=1
  local.get $0
  i32.const 32
  i32.const 2
  call $~lib/arraybuffer/ArrayBufferView#constructor
  local.set $21
  global.get $~lib/memory/__stack_pointer
  local.get $21
  i32.store offset=12 align=1
  i32.const 0
  local.set $0
  loop $for-loop|2
   local.get $0
   i32.const 32
   i32.lt_s
   if
    local.get $0
    local.get $21
    i32.load offset=8
    i32.const 2
    i32.shr_u
    i32.ge_u
    if
     i32.const 608
     i32.const 928
     i32.const 778
     i32.const 64
     call $~lib/builtins/abort
     unreachable
    end
    local.get $21
    i32.load offset=4
    local.get $0
    i32.const 2
    i32.shl
    i32.add
    local.get $0
    i32.const 100
    i32.mul
    i32.store
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|2
   end
  end
  i32.const 0
  i32.const 19
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=16 align=1
  i32.const 40
  i32.const 19
  call $~lib/rt/itcms/__new
  local.set $22
  global.get $~lib/memory/__stack_pointer
  local.get $22
  i32.store offset=16 align=1
  i32.const 0
  local.set $0
  loop $for-loop|3
   local.get $0
   i32.const 10
   i32.lt_s
   if
    local.get $0
    local.get $22
    i32.const 20
    i32.sub
    i32.load offset=16
    i32.const 2
    i32.shr_u
    i32.ge_u
    if
     i32.const 608
     i32.const 992
     i32.const 94
     i32.const 41
     call $~lib/builtins/abort
     unreachable
    end
    local.get $22
    local.get $0
    i32.const 2
    i32.shl
    i32.add
    local.get $0
    i32.const 7
    i32.mul
    i32.store
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|3
   end
  end
  i32.const 16
  i32.const 11
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=20 align=1
  local.get $0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
  local.set $11
  global.get $~lib/memory/__stack_pointer
  local.get $11
  i32.store offset=20 align=1
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1104
  i32.const 10
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $11
  local.get $0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1136
  i32.const 15
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $11
  local.get $0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1168
  i32.const 2
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $11
  local.get $0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1200
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $11
  local.get $0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1232
  i32.const 8
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $11
  local.get $0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  i32.const 24
  i32.const 6
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $0
  i32.const 1
  i32.const 1264
  i32.const 100
  f32.const 10.5
  f32.const 20.299999237060547
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#constructor
  local.set $5
  global.get $~lib/memory/__stack_pointer
  local.get $5
  i32.store offset=32 align=1
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1296
  i32.const 12
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $5
  local.get $0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1344
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $5
  local.get $0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1392
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $5
  local.get $0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  local.get $5
  i32.const 4200
  i32.store offset=20
  i32.const 24
  i32.const 6
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $0
  i32.const 2
  i32.const 1440
  i32.const 85
  f32.const -5
  f32.const 13.699999809265137
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#constructor
  local.set $7
  global.get $~lib/memory/__stack_pointer
  local.get $7
  i32.store offset=56 align=1
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1472
  i32.const 3
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $7
  local.get $0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 1504
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $7
  local.get $0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  local.get $7
  i32.const 1500
  i32.store offset=20
  i32.const 20
  i32.const 20
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $0
  i32.const 100
  i32.const 1552
  i32.const 50
  i32.const 1600
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#constructor
  local.set $2
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store offset=68 align=1
  i32.const 20
  i32.const 20
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $0
  i32.const 101
  i32.const 1680
  i32.const 40
  i32.const 1728
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#constructor
  local.set $3
  global.get $~lib/memory/__stack_pointer
  local.get $3
  i32.store offset=64 align=1
  i32.const 20
  i32.const 20
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $0
  i32.const 102
  i32.const 1808
  i32.const 200
  i32.const 1840
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#constructor
  local.set $10
  global.get $~lib/memory/__stack_pointer
  local.get $10
  i32.store offset=60 align=1
  i32.const 16
  i32.const 21
  call $~lib/rt/itcms/__new
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=24 align=1
  local.get $0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
  local.set $12
  global.get $~lib/memory/__stack_pointer
  local.get $12
  i32.store offset=28 align=1
  local.get $12
  local.get $5
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  local.get $12
  local.get $7
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  local.get $12
  local.get $2
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  local.get $12
  local.get $3
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  local.get $12
  local.get $10
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  i32.const 4
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/buildTree
  local.set $23
  global.get $~lib/memory/__stack_pointer
  local.get $23
  i32.store offset=24 align=1
  local.get $23
  global.set $tools/heap_analyzer/tests/fixture/dwarfFixture/globalTree
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 20
  i32.const 1
  call $~lib/rt/itcms/__new
  local.tee $0
  i32.const 2080
  i32.const 20
  memory.copy
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  i32.const 16
  i32.const 23
  call $~lib/rt/itcms/__new
  local.tee $4
  local.get $0
  i32.store
  local.get $4
  local.get $0
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $4
  local.get $0
  i32.store offset=4
  local.get $4
  i32.const 20
  i32.store offset=8
  local.get $4
  i32.const 5
  i32.store offset=12
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  global.get $~lib/memory/__stack_pointer
  local.get $4
  i32.store offset=36 align=1
  i32.const 12
  call $~lib/rt/__decrease_sp
  block $folding-inner1
   block $folding-inner0
    i32.const 8
    i32.const 25
    call $~lib/rt/itcms/__new
    local.tee $0
    local.get $4
    i32.load offset=12
    i32.eqz
    br_if $folding-inner0
    local.get $4
    i32.load offset=4
    i32.load
    local.tee $1
    i32.eqz
    br_if $folding-inner1
    local.get $1
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $0
    i32.const 0
    i32.store offset=4
    local.get $0
    i32.const 0
    i32.const 0
    call $~lib/rt/itcms/__link
    local.get $0
    local.set $25
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=8 align=1
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=4 align=1
    i32.const 1
    local.set $9
    loop $for-loop|00
     local.get $9
     local.get $4
     i32.load offset=12
     i32.lt_s
     if
      local.get $0
      local.tee $1
      i32.const 8
      i32.const 25
      call $~lib/rt/itcms/__new
      local.tee $0
      local.get $9
      local.get $4
      i32.load offset=12
      i32.ge_u
      br_if $folding-inner0
      local.get $4
      i32.load offset=4
      local.get $9
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.tee $6
      i32.eqz
      br_if $folding-inner1
      local.get $6
      call $~lib/arraybuffer/ArrayBufferView#set:buffer
      local.get $0
      i32.const 0
      i32.store offset=4
      local.get $0
      i32.const 0
      i32.const 0
      call $~lib/rt/itcms/__link
      local.get $0
      i32.store offset=4
      local.get $1
      local.get $0
      i32.const 0
      call $~lib/rt/itcms/__link
      global.get $~lib/memory/__stack_pointer
      local.get $0
      i32.store align=1
      local.get $9
      i32.const 1
      i32.add
      local.set $9
      br $for-loop|00
     end
    end
    global.get $~lib/memory/__stack_pointer
    i32.const 12
    i32.add
    global.set $~lib/memory/__stack_pointer
    global.get $~lib/memory/__stack_pointer
    local.get $25
    i32.store offset=36 align=1
    i32.const 24
    i32.const 26
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=40 align=1
    local.get $0
    i32.const 32
    call $byn$mgfn-shared$~lib/set/Set<i32>#constructor
    local.set $14
    global.get $~lib/memory/__stack_pointer
    local.get $14
    i32.store offset=40 align=1
    local.get $14
    i32.const 2
    call $~lib/set/Set<i32>#add
    local.get $14
    i32.const 3
    call $~lib/set/Set<i32>#add
    local.get $14
    i32.const 5
    call $~lib/set/Set<i32>#add
    i32.const 24
    i32.const 27
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=44 align=1
    local.get $0
    i32.const 32
    call $byn$mgfn-shared$~lib/set/Set<i32>#constructor
    local.set $15
    global.get $~lib/memory/__stack_pointer
    local.get $15
    i32.store offset=44 align=1
    i32.const 8
    i32.const 10
    call $~lib/rt/itcms/__new
    i32.const 2256
    i32.const 3
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=48 align=1
    local.get $15
    local.get $0
    call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#add
    i32.const 8
    i32.const 10
    call $~lib/rt/itcms/__new
    i32.const 2288
    i32.const 1
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=48 align=1
    local.get $15
    local.get $0
    call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#add
    i32.const 8
    i32.const 10
    call $~lib/rt/itcms/__new
    i32.const 2320
    i32.const 2
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=48 align=1
    local.get $15
    local.get $0
    call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#add
    i32.const 24
    i32.const 28
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=48 align=1
    local.get $0
    i32.const 48
    call $byn$mgfn-shared$~lib/set/Set<i32>#constructor
    local.set $16
    global.get $~lib/memory/__stack_pointer
    local.get $16
    i32.store offset=48 align=1
    local.get $16
    i32.const 1
    i32.const 4200
    call $"~lib/map/Map<i32,i32>#set"
    local.get $16
    i32.const 2
    i32.const 1500
    call $"~lib/map/Map<i32,i32>#set"
    local.get $16
    i32.const 3
    i32.const 800
    call $"~lib/map/Map<i32,i32>#set"
    i32.const 24
    i32.const 31
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=52 align=1
    local.get $0
    i32.const 48
    call $byn$mgfn-shared$~lib/set/Set<i32>#constructor
    local.set $4
    global.get $~lib/memory/__stack_pointer
    local.get $4
    i32.store offset=52 align=1
    local.get $4
    i32.const 1264
    local.get $5
    call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set"
    local.get $4
    i32.const 1440
    local.get $7
    call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set"
    i32.const 24
    i32.const 33
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=56 align=1
    local.get $0
    i32.const 48
    call $byn$mgfn-shared$~lib/set/Set<i32>#constructor
    local.set $17
    global.get $~lib/memory/__stack_pointer
    local.get $17
    i32.store offset=56 align=1
    i32.const 8
    i32.const 9
    call $~lib/rt/itcms/__new
    local.tee $0
    f32.const 10
    f32.store
    local.get $0
    f32.const 20
    f32.store offset=4
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=72 align=1
    local.get $17
    local.get $2
    local.get $0
    call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set"
    i32.const 8
    i32.const 9
    call $~lib/rt/itcms/__new
    local.tee $0
    f32.const 30
    f32.store
    local.get $0
    f32.const 40
    f32.store offset=4
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=68 align=1
    local.get $17
    local.get $3
    local.get $0
    call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set"
    i32.const 8
    i32.const 9
    call $~lib/rt/itcms/__new
    local.tee $0
    f32.const 50
    f32.store
    local.get $0
    f32.const 60
    f32.store offset=4
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=64 align=1
    local.get $17
    local.get $10
    local.get $0
    call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set"
    call $~lib/string/String.UTF8.byteLength
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $1
    i32.const 2352
    local.set $3
    i32.const 2348
    i32.load
    i32.const -2
    i32.and
    i32.const 2352
    i32.add
    local.set $10
    local.get $1
    local.set $0
    loop $while-continue|0
     local.get $3
     local.get $10
     i32.lt_u
     if
      local.get $3
      i32.load16_u
      local.tee $2
      i32.const 128
      i32.lt_u
      if (result i32)
       local.get $0
       local.get $2
       i32.store8
       local.get $0
       i32.const 1
       i32.add
      else
       local.get $2
       i32.const 2048
       i32.lt_u
       if (result i32)
        local.get $0
        local.get $2
        i32.const 6
        i32.shr_u
        i32.const 192
        i32.or
        local.get $2
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.const 8
        i32.shl
        i32.or
        i32.store16
        local.get $0
        i32.const 2
        i32.add
       else
        local.get $2
        i32.const 56320
        i32.lt_u
        local.get $3
        i32.const 2
        i32.add
        local.get $10
        i32.lt_u
        i32.and
        local.get $2
        i32.const 63488
        i32.and
        i32.const 55296
        i32.eq
        i32.and
        if
         local.get $3
         i32.load16_u offset=2
         local.tee $6
         i32.const 64512
         i32.and
         i32.const 56320
         i32.eq
         if
          local.get $0
          local.get $2
          i32.const 1023
          i32.and
          i32.const 10
          i32.shl
          i32.const 65536
          i32.add
          local.get $6
          i32.const 1023
          i32.and
          i32.or
          local.tee $6
          i32.const 18
          i32.shr_u
          i32.const 240
          i32.or
          local.get $6
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.const 24
          i32.shl
          local.get $6
          i32.const 6
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.const 16
          i32.shl
          i32.or
          local.get $6
          i32.const 12
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          i32.const 8
          i32.shl
          i32.or
          i32.or
          i32.store
          local.get $0
          i32.const 4
          i32.add
          local.set $0
          local.get $3
          i32.const 4
          i32.add
          local.set $3
          br $while-continue|0
         end
        end
        local.get $0
        local.get $2
        i32.const 12
        i32.shr_u
        i32.const 224
        i32.or
        local.get $2
        i32.const 6
        i32.shr_u
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.const 8
        i32.shl
        i32.or
        i32.store16
        local.get $0
        local.get $2
        i32.const 63
        i32.and
        i32.const 128
        i32.or
        i32.store8 offset=2
        local.get $0
        i32.const 3
        i32.add
       end
      end
      local.set $0
      local.get $3
      i32.const 2
      i32.add
      local.set $3
      br $while-continue|0
     end
    end
    local.get $1
    call $~lib/string/String.UTF8.byteLength
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/dumpMemoryRegion
    i32.const 16
    i32.const 36
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=60 align=1
    local.get $0
    call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
    local.set $18
    global.get $~lib/memory/__stack_pointer
    local.get $18
    i32.store offset=60 align=1
    i32.const 8
    i32.const 35
    call $~lib/rt/itcms/__new
    local.tee $0
    i32.const 2592
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $0
    i32.const 2624
    i32.store offset=4
    local.get $0
    i32.const 2624
    i32.const 0
    call $~lib/rt/itcms/__link
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=64 align=1
    local.get $18
    local.get $0
    call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
    i32.const 8
    i32.const 35
    call $~lib/rt/itcms/__new
    local.tee $0
    i32.const 2672
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $0
    i32.const 2720
    i32.store offset=4
    local.get $0
    i32.const 2720
    i32.const 0
    call $~lib/rt/itcms/__link
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=64 align=1
    local.get $18
    local.get $0
    call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
    i32.const 8
    i32.const 35
    call $~lib/rt/itcms/__new
    local.tee $0
    i32.const 2752
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $0
    i32.const 2784
    i32.store offset=4
    local.get $0
    i32.const 2784
    i32.const 0
    call $~lib/rt/itcms/__link
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=64 align=1
    local.get $18
    local.get $0
    call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=64 align=1
    i32.const 256
    call $~lib/arraybuffer/ArrayBuffer#constructor
    local.set $2
    global.get $~lib/memory/__stack_pointer
    local.get $2
    i32.store offset=64 align=1
    i32.const 0
    i32.const 1
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=68 align=1
    i32.const 128
    call $~lib/arraybuffer/ArrayBuffer#constructor
    call $~lib/rt/itcms/__pin
    global.set $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedBuffer
    i32.const 2880
    call $~lib/rt/itcms/__pin
    global.set $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedString
    local.get $5
    global.set $tools/heap_analyzer/tests/fixture/dwarfFixture/globalPlayer
    i32.const 8
    i32.const 9
    call $~lib/rt/itcms/__new
    local.tee $1
    f32.const 99
    f32.store
    local.get $1
    f32.const -99
    f32.store offset=4
    global.get $~lib/memory/__stack_pointer
    local.get $1
    i32.store offset=68 align=1
    i32.const 8
    i32.const 10
    call $~lib/rt/itcms/__new
    i32.const 2976
    i32.const 0
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
    local.set $3
    global.get $~lib/memory/__stack_pointer
    local.get $3
    i32.store offset=32 align=1
    i32.const 16
    i32.const 23
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=72 align=1
    local.get $0
    call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
    local.set $5
    global.get $~lib/memory/__stack_pointer
    local.get $5
    i32.store offset=72 align=1
    local.get $5
    i32.const 3024
    call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
    local.get $5
    i32.const 3056
    call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
    local.get $5
    i32.const 3088
    call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
    i32.const 16
    i32.const 38
    call $~lib/rt/itcms/__new
    local.set $8
    global.get $~lib/memory/__stack_pointer
    local.get $8
    i32.store offset=76 align=1
    local.get $8
    i32.const 8192
    i32.const 1
    call $~lib/rt/itcms/__new
    local.tee $0
    call $~lib/arraybuffer/ArrayBufferView#set:buffer
    local.get $8
    local.get $0
    i32.store offset=4
    local.get $8
    i32.const 8192
    i32.store offset=8
    local.get $8
    i32.const 1024
    i32.store offset=12
    global.get $~lib/memory/__stack_pointer
    local.get $8
    i32.store offset=76 align=1
    i32.const 0
    local.set $0
    loop $for-loop|4
     local.get $0
     i32.const 1024
     i32.lt_s
     if
      local.get $0
      local.get $8
      i32.load offset=12
      i32.ge_u
      if
       local.get $0
       i32.const 0
       i32.lt_s
       if
        i32.const 608
        i32.const 1056
        i32.const 141
        i32.const 22
        call $~lib/builtins/abort
        unreachable
       end
       local.get $8
       local.get $0
       i32.const 1
       i32.add
       local.tee $6
       i32.const 3
       call $~lib/array/ensureCapacity
       local.get $8
       local.get $6
       i32.store offset=12
      end
      local.get $8
      i32.load offset=4
      local.get $0
      i32.const 3
      i32.shl
      i32.add
      local.get $0
      f64.convert_i32_s
      f64.sqrt
      f64.store
      local.get $0
      i32.const 1
      i32.add
      local.set $0
      br $for-loop|4
     end
    end
    i32.const 16
    i32.const 39
    call $~lib/rt/itcms/__new
    local.set $0
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.store offset=80 align=1
    local.get $0
    call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
    local.set $9
    global.get $~lib/memory/__stack_pointer
    local.get $9
    i32.store offset=80 align=1
    i32.const 0
    local.set $0
    loop $for-loop|5
     local.get $0
     i32.const 4
     i32.lt_s
     if
      i32.const 16
      i32.const 4
      call $~lib/rt/itcms/__new
      local.set $6
      global.get $~lib/memory/__stack_pointer
      local.get $6
      i32.store offset=84 align=1
      local.get $6
      call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
      local.set $13
      global.get $~lib/memory/__stack_pointer
      local.get $13
      i32.store offset=84 align=1
      i32.const 0
      local.set $7
      loop $for-loop|6
       local.get $7
       i32.const 4
       i32.lt_s
       if
        local.get $13
        local.get $13
        i32.load offset=12
        local.tee $10
        i32.const 1
        i32.add
        local.tee $6
        i32.const 2
        call $~lib/array/ensureCapacity
        local.get $13
        i32.load offset=4
        local.get $10
        i32.const 2
        i32.shl
        i32.add
        local.get $0
        i32.const 2
        i32.shl
        local.get $7
        i32.add
        i32.store
        local.get $13
        local.get $6
        i32.store offset=12
        local.get $7
        i32.const 1
        i32.add
        local.set $7
        br $for-loop|6
       end
      end
      local.get $9
      local.get $13
      call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
      local.get $0
      i32.const 1
      i32.add
      local.set $0
      br $for-loop|5
     end
    end
    i32.const 204
    i32.load
    i32.const 1
    i32.shr_u
    i32.eqz
    if
     i32.const 0
     i32.const 3120
     i32.const 297
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    i32.const 236
    i32.load
    i32.const 1
    i32.shr_u
    i32.eqz
    if
     i32.const 0
     i32.const 3120
     i32.const 298
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $24
    i32.const 20
    i32.sub
    i32.load offset=16
    i32.const 1
    i32.shr_u
    i32.eqz
    if
     i32.const 0
     i32.const 3120
     i32.const 299
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $19
    i32.load offset=8
    i32.const 64
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 300
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $20
    i32.load offset=8
    i32.const 3
    i32.shr_u
    i32.const 16
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 301
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $21
    i32.load offset=8
    i32.const 2
    i32.shr_u
    i32.const 32
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 302
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $22
    i32.const 20
    i32.sub
    i32.load offset=16
    i32.const 2
    i32.shr_u
    i32.const 10
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 303
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $11
    i32.load offset=12
    i32.const 5
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 304
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $12
    i32.load offset=12
    i32.const 5
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 305
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $23
    i32.load
    i32.const 1
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 306
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $25
    i32.load
    i32.const 1904
    call $~lib/string/String.__eq
    i32.eqz
    if
     i32.const 0
     i32.const 3120
     i32.const 307
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $18
    i32.load offset=12
    i32.const 3
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 308
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $2
    i32.const 20
    i32.sub
    i32.load offset=16
    i32.const 256
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 309
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $1
    f32.load
    f32.const 99
    f32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 310
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $3
    i32.load offset=4
    if
     i32.const 0
     i32.const 3120
     i32.const 311
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $5
    i32.load offset=12
    i32.const 3
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 312
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $8
    i32.load offset=12
    i32.const 1024
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 313
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $9
    i32.load offset=12
    i32.const 4
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 314
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    i32.const 28
    i32.load
    i32.const 1
    i32.shr_u
    i32.eqz
    if
     i32.const 0
     i32.const 3120
     i32.const 315
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    i32.const 172
    i32.load
    i32.const 5
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 316
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $14
    i32.load offset=20
    i32.const 3
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 317
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $15
    i32.load offset=20
    i32.const 3
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 318
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $16
    i32.load offset=20
    i32.const 3
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 319
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $4
    i32.load offset=20
    i32.const 2
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 320
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $17
    i32.load offset=20
    i32.const 3
    i32.ne
    if
     i32.const 0
     i32.const 3120
     i32.const 321
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    global.get $~lib/memory/__stack_pointer
    i32.const 88
    i32.add
    global.set $~lib/memory/__stack_pointer
    return
   end
   i32.const 608
   i32.const 1056
   i32.const 123
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 2128
  i32.const 1056
  i32.const 127
  i32.const 40
  call $~lib/builtins/abort
  unreachable
 )
 (func $~lib/rt/itcms/__unpin (param $0 i32)
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
    i32.const 3248
    i32.const 480
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
 )
 (func $~lib/rt/itcms/__collect
  global.get $~lib/rt/itcms/state
  i32.const 0
  i32.gt_s
  if
   loop $while-continue|0
    global.get $~lib/rt/itcms/state
    if
     call $~lib/rt/itcms/step
     drop
     br $while-continue|0
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
 (func $~lib/rt/__visit_members (param $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i64)
  (local $4 i32)
  block $folding-inner6
   block $folding-inner5
    block $folding-inner4
     block $folding-inner3
      block $folding-inner2
       block $folding-inner0
        block $invalid
         block $~lib/iterator/Iterable<~lib/array/Array<i32>>
          block $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>"
           block $~lib/tuple/SmallTuple
            block $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>
             block $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity
              local.get $0
              i32.const 8
              i32.sub
              i32.load
              br_table $~lib/iterator/Iterable<~lib/array/Array<i32>> $~lib/iterator/Iterable<~lib/array/Array<i32>> $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner2 $folding-inner2 $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner3 $folding-inner6 $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner2 $folding-inner0 $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner6 $folding-inner2 $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner2 $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner2 $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner3 $folding-inner0 $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner0 $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner4 $folding-inner5 $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item> $folding-inner5 $~lib/tuple/SmallTuple $~lib/iterator/Iterable<~lib/array/Array<i32>> $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>" $~lib/iterator/Iterable<~lib/array/Array<i32>> $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>" $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner4 $folding-inner0 $~lib/iterator/Iterable<~lib/array/Array<i32>> $folding-inner2 $folding-inner0 $~lib/iterator/Iterable<~lib/array/Array<i32>> $invalid
             end
             local.get $0
             i32.load offset=4
             call $~lib/rt/itcms/__visit
             return
            end
            local.get $0
            i32.load
            call $~lib/rt/itcms/__visit
            local.get $0
            i32.load offset=8
            local.tee $2
            local.tee $1
            local.get $0
            i32.load offset=16
            i32.const 3
            i32.shl
            i32.add
            local.set $0
            loop $while-continue|0
             local.get $0
             local.get $1
             i32.gt_u
             if
              local.get $1
              i32.load offset=4
              i32.const 1
              i32.and
              i32.eqz
              if
               local.get $1
               i32.load
               call $~lib/rt/itcms/__visit
              end
              local.get $1
              i32.const 8
              i32.add
              local.set $1
              br $while-continue|0
             end
            end
            local.get $2
            call $~lib/rt/itcms/__visit
            return
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
           local.set $3
           loop $while-continue|00
            local.get $3
            i64.const 0
            i64.ne
            if
             local.get $0
             local.get $3
             i64.ctz
             i32.wrap_i64
             i32.const 2
             i32.shl
             i32.add
             i32.load
             call $~lib/rt/itcms/__visit
             local.get $3
             local.get $3
             i64.const 1
             i64.sub
             i64.and
             local.set $3
             br $while-continue|00
            end
           end
           return
          end
          local.get $0
          i32.load
          call $~lib/rt/itcms/__visit
          local.get $0
          i32.load offset=8
          local.tee $2
          local.tee $1
          local.get $0
          i32.load offset=16
          i32.const 12
          i32.mul
          i32.add
          local.set $0
          loop $while-continue|01
           local.get $0
           local.get $1
           i32.gt_u
           if
            local.get $1
            i32.load offset=8
            i32.const 1
            i32.and
            i32.eqz
            if
             local.get $1
             i32.load
             call $~lib/rt/itcms/__visit
             local.get $1
             i32.load offset=4
             call $~lib/rt/itcms/__visit
            end
            local.get $1
            i32.const 12
            i32.add
            local.set $1
            br $while-continue|01
           end
          end
          local.get $2
          call $~lib/rt/itcms/__visit
          return
         end
         return
        end
        unreachable
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
       loop $while-continue|012
        local.get $1
        local.get $2
        i32.lt_u
        if
         local.get $1
         i32.load
         local.tee $4
         if
          local.get $4
          call $~lib/rt/itcms/__visit
         end
         local.get $1
         i32.const 4
         i32.add
         local.set $1
         br $while-continue|012
        end
       end
       br $folding-inner2
      end
      local.get $0
      i32.load
      call $~lib/rt/itcms/__visit
      return
     end
     local.get $0
     i32.load offset=4
     call $~lib/rt/itcms/__visit
     local.get $0
     i32.load offset=8
     call $~lib/rt/itcms/__visit
     local.get $0
     i32.load offset=16
     call $~lib/rt/itcms/__visit
     return
    end
    local.get $0
    i32.load
    call $~lib/rt/itcms/__visit
    local.get $0
    i32.load offset=4
    call $~lib/rt/itcms/__visit
    return
   end
   local.get $0
   i32.load
   call $~lib/rt/itcms/__visit
   local.get $0
   i32.load offset=8
   call $~lib/rt/itcms/__visit
   return
  end
  local.get $0
  i32.load offset=4
  call $~lib/rt/itcms/__visit
  local.get $0
  i32.load offset=8
  call $~lib/rt/itcms/__visit
 )
 (func $~start
  memory.size
  i32.const 16
  i32.shl
  i32.const 36232
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 532
  i32.const 528
  i32.store
  i32.const 536
  i32.const 528
  i32.store
  i32.const 528
  global.set $~lib/rt/itcms/pinSpace
  i32.const 564
  i32.const 560
  i32.store
  i32.const 568
  i32.const 560
  i32.store
  i32.const 560
  global.set $~lib/rt/itcms/toSpace
  i32.const 708
  i32.const 704
  i32.store
  i32.const 712
  i32.const 704
  i32.store
  i32.const 704
  global.set $~lib/rt/itcms/fromSpace
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
  i32.const 3464
  i32.lt_s
  if
   unreachable
  end
 )
 (func $byn$mgfn-shared$~lib/set/Set<i32>#constructor (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  local.set $2
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store offset=4 align=1
  local.get $0
  i32.const 16
  call $~lib/arraybuffer/ArrayBuffer#constructor
  call $~lib/arraybuffer/ArrayBufferView#set:buffer
  local.get $0
  i32.const 3
  i32.store offset=4
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  local.set $2
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store offset=4 align=1
  local.get $0
  local.get $1
  call $~lib/arraybuffer/ArrayBuffer#constructor
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
  local.get $0
  i32.const 4
  i32.store offset=12
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
)
