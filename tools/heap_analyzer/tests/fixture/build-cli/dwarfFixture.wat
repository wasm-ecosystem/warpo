(module
 (type $0 (func (param i32 i32)))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32) (result i32)))
 (type $4 (func (result i32)))
 (type $5 (func (param i32)))
 (type $6 (func (param i32 i32 i32)))
 (type $7 (func))
 (type $8 (func (param i32 i32 i32 i32)))
 (type $9 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $10 (func (param i32 i32 f64)))
 (type $11 (func (param i32 f32)))
 (type $12 (func (param i32 i32 i32 i32 f32 f32) (result i32)))
 (type $13 (func (param i32 i32 i64) (result i32)))
 (type $14 (func (param i32 f32 f32) (result i32)))
 (type $15 (func (param i32 i32 f32 f32) (result i32)))
 (type $16 (func (param i32 i32 i32 i32) (result i32)))
 (type $17 (func (param f64) (result f64)))
 (type $18 (func (param i32) (result f32)))
 (import "MemoryDump" "dumpMemoryRegion" (func $tools/heap_analyzer/tests/fixture/dwarfFixture/dumpMemoryRegion (param i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/GLOBAL_STRING i32 (i32.const 32))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/GLOBAL_ARRAY i32 (i32.const 160))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/globalPlayer (mut i32) (i32.const 0))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/globalTree (mut i32) (i32.const 0))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedBuffer (mut i32) (i32.const 0))
 (global $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedString (mut i32) (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
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
 (global $~lib/native/ASC_LOW_MEMORY_LIMIT i32 (i32.const 0))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/rt/__rtti_base i32 (i32.const 3296))
 (global $~lib/memory/__data_end i32 (i32.const 3464))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 36232))
 (global $~lib/memory/__heap_base i32 (i32.const 36232))
 (memory $0 1)
 (data $0 (i32.const 12) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00:\00\00\00I\00 \00a\00m\00 \00a\00 \00g\00l\00o\00b\00a\00l\00 \00s\00t\00r\00i\00n\00g\00 \00c\00o\00n\00s\00t\00a\00n\00t\00\00\00")
 (data $1 (i32.const 92) ",\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\14\00\00\00\n\00\00\00\14\00\00\00\1e\00\00\00(\00\00\002\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 140) ",\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\10\00\00\00p\00\00\00p\00\00\00\14\00\00\00\05\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 188) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00H\00i\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 220) "l\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00V\00\00\00T\00h\00e\00 \00q\00u\00i\00c\00k\00 \00b\00r\00o\00w\00n\00 \00f\00o\00x\00 \00j\00u\00m\00p\00s\00 \00o\00v\00e\00r\00 \00t\00h\00e\00 \00l\00a\00z\00y\00 \00d\00o\00g\00\00\00\00\00\00\00")
 (data $5 (i32.const 332) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00 \00\14  \00\00\00\00\00\00\00")
 (data $6 (i32.const 364) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $7 (i32.const 396) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $8 (i32.const 460) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 528) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $10 (i32.const 560) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $11 (i32.const 588) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $12 (i32.const 652) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $13 (i32.const 704) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $14 (i32.const 732) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $15 (i32.const 796) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00")
 (data $16 (i32.const 844) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s\00\00\00\00\00\00\00")
 (data $17 (i32.const 908) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00~\00l\00i\00b\00/\00t\00y\00p\00e\00d\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $18 (i32.const 972) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00s\00t\00a\00t\00i\00c\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00\00\00\00\00")
 (data $19 (i32.const 1036) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00")
 (data $20 (i32.const 1084) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00S\00w\00o\00r\00d\00\00\00")
 (data $21 (i32.const 1116) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00S\00h\00i\00e\00l\00d\00")
 (data $22 (i32.const 1148) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00P\00o\00t\00i\00o\00n\00")
 (data $23 (i32.const 1180) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00S\00c\00r\00o\00l\00l\00")
 (data $24 (i32.const 1212) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00B\00o\00w\00\00\00\00\00\00\00")
 (data $25 (i32.const 1244) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00A\00l\00i\00c\00e\00\00\00")
 (data $26 (i32.const 1276) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00M\00a\00g\00i\00c\00 \00S\00t\00a\00f\00f\00\00\00\00\00\00\00")
 (data $27 (i32.const 1324) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00H\00e\00a\00l\00t\00h\00 \00P\00o\00t\00i\00o\00n\00\00\00")
 (data $28 (i32.const 1372) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00R\00i\00n\00g\00 \00o\00f\00 \00P\00o\00w\00e\00r\00\00\00")
 (data $29 (i32.const 1420) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00B\00o\00b\00\00\00\00\00\00\00")
 (data $30 (i32.const 1452) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00D\00a\00g\00g\00e\00r\00")
 (data $31 (i32.const 1484) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00L\00o\00c\00k\00 \00p\00i\00c\00k\00\00\00\00\00\00\00\00\00\00\00")
 (data $32 (i32.const 1532) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00V\00i\00l\00l\00a\00g\00e\00r\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $33 (i32.const 1580) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00.\00\00\00W\00e\00l\00c\00o\00m\00e\00 \00t\00o\00 \00o\00u\00r\00 \00v\00i\00l\00l\00a\00g\00e\00!\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $34 (i32.const 1660) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00M\00e\00r\00c\00h\00a\00n\00t\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $35 (i32.const 1708) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\006\00\00\00W\00h\00a\00t\00 \00w\00o\00u\00l\00d\00 \00y\00o\00u\00 \00l\00i\00k\00e\00 \00t\00o\00 \00b\00u\00y\00?\00\00\00\00\00\00\00")
 (data $36 (i32.const 1788) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00G\00u\00a\00r\00d\00\00\00")
 (data $37 (i32.const 1820) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00*\00\00\00H\00a\00l\00t\00!\00 \00W\00h\00o\00 \00g\00o\00e\00s\00 \00t\00h\00e\00r\00e\00?\00\00\00")
 (data $38 (i32.const 1884) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00a\00l\00p\00h\00a\00\00\00")
 (data $39 (i32.const 1916) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00b\00e\00t\00a\00\00\00\00\00")
 (data $40 (i32.const 1948) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00g\00a\00m\00m\00a\00\00\00")
 (data $41 (i32.const 1980) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00d\00e\00l\00t\00a\00\00\00")
 (data $42 (i32.const 2012) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00e\00p\00s\00i\00l\00o\00n\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $43 (i32.const 2060) ",\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\14\00\00\00p\07\00\00\90\07\00\00\b0\07\00\00\d0\07\00\00\f0\07\00\00\00\00\00\00\00\00\00\00")
 (data $44 (i32.const 2108) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $45 (i32.const 2236) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00A\00m\00u\00l\00e\00t\00")
 (data $46 (i32.const 2268) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00G\00e\00m\00\00\00\00\00\00\00")
 (data $47 (i32.const 2300) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00R\00u\00n\00e\00\00\00\00\00")
 (data $48 (i32.const 2332) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00l\00\00\00.\00/\00t\00o\00o\00l\00s\00/\00h\00e\00a\00p\00_\00a\00n\00a\00l\00y\00z\00e\00r\00/\00t\00e\00s\00t\00s\00/\00f\00i\00x\00t\00u\00r\00e\00/\00b\00u\00i\00l\00d\00/\00e\00x\00a\00m\00p\00l\00e\00.\00d\00u\00m\00p\00")
 (data $49 (i32.const 2460) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00U\00n\00p\00a\00i\00r\00e\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00\00\00\00\00\00\00\00\00")
 (data $50 (i32.const 2524) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00~\00l\00i\00b\00/\00s\00t\00r\00i\00n\00g\00.\00t\00s\00")
 (data $51 (i32.const 2572) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00n\00a\00m\00e\00\00\00\00\00")
 (data $52 (i32.const 2604) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\18\00\00\00H\00e\00a\00p\00A\00n\00a\00l\00y\00z\00e\00r\00\00\00\00\00")
 (data $53 (i32.const 2652) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00v\00e\00r\00s\00i\00o\00n\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $54 (i32.const 2700) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\001\00.\000\00.\000\00\00\00")
 (data $55 (i32.const 2732) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00a\00u\00t\00h\00o\00r\00")
 (data $56 (i32.const 2764) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00d\00e\00v\00\00\00\00\00\00\00")
 (data $57 (i32.const 2796) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00*\00\00\00O\00b\00j\00e\00c\00t\00 \00a\00l\00r\00e\00a\00d\00y\00 \00p\00i\00n\00n\00e\00d\00\00\00")
 (data $58 (i32.const 2860) "\\\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00F\00\00\00I\00 \00a\00m\00 \00p\00i\00n\00n\00e\00d\00 \00a\00n\00d\00 \00c\00a\00n\00n\00o\00t\00 \00b\00e\00 \00c\00o\00l\00l\00e\00c\00t\00e\00d\00\00\00\00\00\00\00")
 (data $59 (i32.const 2956) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00E\00p\00h\00e\00m\00e\00r\00a\00l\00 \00K\00e\00y\00\00\00")
 (data $60 (i32.const 3004) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00t\00e\00m\00p\001\00\00\00")
 (data $61 (i32.const 3036) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00t\00e\00m\00p\002\00\00\00")
 (data $62 (i32.const 3068) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00t\00e\00m\00p\003\00\00\00")
 (data $63 (i32.const 3100) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00b\00\00\00t\00o\00o\00l\00s\00/\00h\00e\00a\00p\00_\00a\00n\00a\00l\00y\00z\00e\00r\00/\00t\00e\00s\00t\00s\00/\00f\00i\00x\00t\00u\00r\00e\00/\00d\00w\00a\00r\00f\00F\00i\00x\00t\00u\00r\00e\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (data $64 (i32.const 3228) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00O\00b\00j\00e\00c\00t\00 \00i\00s\00 \00n\00o\00t\00 \00p\00i\00n\00n\00e\00d\00\00\00\00\00")
 (data $65 (i32.const 3296) ")\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\02\t\00\00 \00\00\00\00\00\00\00\00\00\00\00\00\00\00\00 \00\00\00\00\00\00\00\02A\00\00 \00\00\00\00\00\00\00A\00\00\00 \00\00\00\01\1a\00\00 \00\00\00\01\t\00\00$\t\00\00\00\00\00\00\02A\00\00 \00\00\00\02A\00\00 \00\00\00\00\00\00\00\08\t\00\00\08A\00\00\10\t\12\00\00\00\00\00 \00\00\00\10A\82\00 \00\00\00\10A\82\00 \00\00\00\00\00\00\00\02A\00\00 \00\00\00\02\1a\00\00\02A\00\00 \00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
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
 (func $~lib/rt/common/OBJECT#get:rtSize (param $this i32) (result i32)
  local.get $this
  i32.load offset=16
 )
 (func $~lib/string/String#get:length (param $this i32) (result i32)
  local.get $this
  i32.const 20
  i32.sub
  call $~lib/rt/common/OBJECT#get:rtSize
  i32.const 1
  i32.shr_u
  return
 )
 (func $~lib/rt/itcms/Object#set:nextWithColor (param $this i32) (param $nextWithColor i32)
  local.get $this
  local.get $nextWithColor
  i32.store offset=4
 )
 (func $~lib/rt/itcms/Object#set:prev (param $this i32) (param $prev i32)
  local.get $this
  local.get $prev
  i32.store offset=8
 )
 (func $~lib/rt/itcms/initLazy (param $space i32) (result i32)
  local.get $space
  local.get $space
  call $~lib/rt/itcms/Object#set:nextWithColor
  local.get $space
  local.get $space
  call $~lib/rt/itcms/Object#set:prev
  local.get $space
  return
 )
 (func $~lib/rt/itcms/Object#get:nextWithColor (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/rt/itcms/Object#get:next (param $this i32) (result i32)
  local.get $this
  call $~lib/rt/itcms/Object#get:nextWithColor
  i32.const 3
  i32.const -1
  i32.xor
  i32.and
  return
 )
 (func $~lib/rt/itcms/Object#get:color (param $this i32) (result i32)
  local.get $this
  call $~lib/rt/itcms/Object#get:nextWithColor
  i32.const 3
  i32.and
  return
 )
 (func $~lib/rt/itcms/visitRoots (param $cookie i32)
  (local $pn i32)
  (local $iter i32)
  local.get $cookie
  call $~lib/rt/__visit_globals
  global.get $~lib/rt/itcms/pinSpace
  local.set $pn
  local.get $pn
  call $~lib/rt/itcms/Object#get:next
  local.set $iter
  block $while-break|0
   loop $while-continue|0
    local.get $iter
    local.get $pn
    i32.ne
    if
     i32.const 1
     drop
     local.get $iter
     call $~lib/rt/itcms/Object#get:color
     i32.const 3
     i32.eq
     i32.eqz
     if
      i32.const 0
      i32.const 480
      i32.const 159
      i32.const 16
      call $~lib/builtins/abort
      unreachable
     end
     local.get $iter
     i32.const 20
     i32.add
     local.get $cookie
     call $~lib/rt/__visit_members
     local.get $iter
     call $~lib/rt/itcms/Object#get:next
     local.set $iter
     br $while-continue|0
    end
   end
  end
 )
 (func $~lib/rt/itcms/Object#set:color (param $this i32) (param $color i32)
  local.get $this
  local.get $this
  call $~lib/rt/itcms/Object#get:nextWithColor
  i32.const 3
  i32.const -1
  i32.xor
  i32.and
  local.get $color
  i32.or
  call $~lib/rt/itcms/Object#set:nextWithColor
 )
 (func $~lib/rt/itcms/Object#get:prev (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $~lib/rt/itcms/Object#set:next (param $this i32) (param $obj i32)
  local.get $this
  local.get $obj
  local.get $this
  call $~lib/rt/itcms/Object#get:nextWithColor
  i32.const 3
  i32.and
  i32.or
  call $~lib/rt/itcms/Object#set:nextWithColor
 )
 (func $~lib/rt/itcms/Object#unlink (param $this i32)
  (local $next i32)
  (local $prev i32)
  local.get $this
  call $~lib/rt/itcms/Object#get:next
  local.set $next
  local.get $next
  i32.const 0
  i32.eq
  if
   i32.const 1
   drop
   local.get $this
   call $~lib/rt/itcms/Object#get:prev
   i32.const 0
   i32.eq
   if (result i32)
    local.get $this
    global.get $~lib/memory/__heap_base
    i32.lt_u
   else
    i32.const 0
   end
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
  local.get $this
  call $~lib/rt/itcms/Object#get:prev
  local.set $prev
  i32.const 1
  drop
  local.get $prev
  i32.eqz
  if
   i32.const 0
   i32.const 480
   i32.const 131
   i32.const 16
   call $~lib/builtins/abort
   unreachable
  end
  local.get $next
  local.get $prev
  call $~lib/rt/itcms/Object#set:prev
  local.get $prev
  local.get $next
  call $~lib/rt/itcms/Object#set:next
 )
 (func $~lib/rt/itcms/Object#get:rtId (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/shared/typeinfo/Typeinfo#get:flags (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/rt/__typeinfo (param $id i32) (result i32)
  (local $ptr i32)
  global.get $~lib/rt/__rtti_base
  local.set $ptr
  local.get $id
  local.get $ptr
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
  local.get $ptr
  i32.const 4
  i32.add
  local.get $id
  i32.const 4
  i32.mul
  i32.add
  call $~lib/shared/typeinfo/Typeinfo#get:flags
  return
 )
 (func $~lib/rt/itcms/Object#get:isPointerfree (param $this i32) (result i32)
  (local $rtId i32)
  local.get $this
  call $~lib/rt/itcms/Object#get:rtId
  local.set $rtId
  local.get $rtId
  i32.const 2
  i32.le_u
  if (result i32)
   i32.const 1
  else
   local.get $rtId
   call $~lib/rt/__typeinfo
   i32.const 32
   i32.and
   i32.const 0
   i32.ne
  end
  return
 )
 (func $~lib/rt/itcms/Object#linkTo (param $this i32) (param $list i32) (param $withColor i32)
  (local $prev i32)
  local.get $list
  call $~lib/rt/itcms/Object#get:prev
  local.set $prev
  local.get $this
  local.get $list
  local.get $withColor
  i32.or
  call $~lib/rt/itcms/Object#set:nextWithColor
  local.get $this
  local.get $prev
  call $~lib/rt/itcms/Object#set:prev
  local.get $prev
  local.get $this
  call $~lib/rt/itcms/Object#set:next
  local.get $list
  local.get $this
  call $~lib/rt/itcms/Object#set:prev
 )
 (func $~lib/rt/itcms/Object#makeGray (param $this i32)
  (local $1 i32)
  local.get $this
  global.get $~lib/rt/itcms/iter
  i32.eq
  if
   local.get $this
   call $~lib/rt/itcms/Object#get:prev
   local.tee $1
   i32.eqz
   if (result i32)
    i32.const 0
    i32.const 480
    i32.const 147
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   else
    local.get $1
   end
   global.set $~lib/rt/itcms/iter
  end
  local.get $this
  call $~lib/rt/itcms/Object#unlink
  local.get $this
  global.get $~lib/rt/itcms/toSpace
  local.get $this
  call $~lib/rt/itcms/Object#get:isPointerfree
  if (result i32)
   global.get $~lib/rt/itcms/white
   i32.eqz
  else
   i32.const 2
  end
  call $~lib/rt/itcms/Object#linkTo
 )
 (func $~lib/rt/itcms/__visit (param $ptr i32) (param $cookie i32)
  (local $obj i32)
  local.get $ptr
  i32.eqz
  if
   return
  end
  local.get $ptr
  i32.const 20
  i32.sub
  local.set $obj
  local.get $obj
  call $~lib/rt/itcms/Object#get:color
  global.get $~lib/rt/itcms/white
  i32.eq
  if
   local.get $obj
   call $~lib/rt/itcms/Object#makeGray
   global.get $~lib/rt/itcms/visitCount
   i32.const 1
   i32.add
   global.set $~lib/rt/itcms/visitCount
  end
 )
 (func $~lib/rt/itcms/visitStack (param $cookie i32)
  (local $ptr i32)
  global.get $~lib/memory/__stack_pointer
  local.set $ptr
  block $while-break|0
   loop $while-continue|0
    local.get $ptr
    global.get $~lib/memory/__heap_base
    i32.lt_u
    if
     local.get $ptr
     i32.load
     local.get $cookie
     call $~lib/rt/itcms/__visit
     local.get $ptr
     i32.const 4
     i32.add
     local.set $ptr
     br $while-continue|0
    end
   end
  end
 )
 (func $~lib/rt/common/BLOCK#get:mmInfo (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/rt/itcms/Object#get:size (param $this i32) (result i32)
  i32.const 4
  local.get $this
  call $~lib/rt/common/BLOCK#get:mmInfo
  i32.const 3
  i32.const -1
  i32.xor
  i32.and
  i32.add
  return
 )
 (func $~lib/rt/tlsf/Root#set:flMap (param $this i32) (param $flMap i32)
  local.get $this
  local.get $flMap
  i32.store
 )
 (func $~lib/rt/tlsf/SETTAIL (param $root i32) (param $tail i32)
  local.get $root
  local.get $tail
  i32.store offset=1568
 )
 (func $~lib/rt/tlsf/SETSL (param $root i32) (param $fl i32) (param $slMap i32)
  local.get $root
  local.get $fl
  i32.const 2
  i32.shl
  i32.add
  local.get $slMap
  i32.store offset=4
 )
 (func $~lib/rt/tlsf/SETHEAD (param $root i32) (param $fl i32) (param $sl i32) (param $head i32)
  local.get $root
  local.get $fl
  i32.const 4
  i32.shl
  local.get $sl
  i32.add
  i32.const 2
  i32.shl
  i32.add
  local.get $head
  i32.store offset=96
 )
 (func $~lib/rt/tlsf/GETTAIL (param $root i32) (result i32)
  local.get $root
  i32.load offset=1568
  return
 )
 (func $~lib/rt/common/BLOCK#set:mmInfo (param $this i32) (param $mmInfo i32)
  local.get $this
  local.get $mmInfo
  i32.store
 )
 (func $~lib/rt/tlsf/Block#set:prev (param $this i32) (param $prev i32)
  local.get $this
  local.get $prev
  i32.store offset=4
 )
 (func $~lib/rt/tlsf/Block#set:next (param $this i32) (param $next i32)
  local.get $this
  local.get $next
  i32.store offset=8
 )
 (func $~lib/rt/tlsf/GETRIGHT (param $block i32) (result i32)
  local.get $block
  i32.const 4
  i32.add
  local.get $block
  call $~lib/rt/common/BLOCK#get:mmInfo
  i32.const 3
  i32.const -1
  i32.xor
  i32.and
  i32.add
  return
 )
 (func $~lib/rt/tlsf/Block#get:prev (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/rt/tlsf/Block#get:next (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $~lib/rt/tlsf/GETHEAD (param $root i32) (param $fl i32) (param $sl i32) (result i32)
  local.get $root
  local.get $fl
  i32.const 4
  i32.shl
  local.get $sl
  i32.add
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=96
  return
 )
 (func $~lib/rt/tlsf/GETSL (param $root i32) (param $fl i32) (result i32)
  local.get $root
  local.get $fl
  i32.const 2
  i32.shl
  i32.add
  i32.load offset=4
  return
 )
 (func $~lib/rt/tlsf/Root#get:flMap (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/rt/tlsf/removeBlock (param $root i32) (param $block i32)
  (local $blockInfo i32)
  (local $size i32)
  (local $fl i32)
  (local $sl i32)
  (local $6 i32)
  (local $7 i32)
  (local $boundedSize i32)
  (local $prev i32)
  (local $next i32)
  (local $slMap i32)
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
  local.get $block
  call $~lib/rt/common/BLOCK#get:mmInfo
  local.set $blockInfo
  i32.const 1
  drop
  local.get $blockInfo
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
  local.get $blockInfo
  i32.const 3
  i32.const -1
  i32.xor
  i32.and
  local.set $size
  i32.const 1
  drop
  local.get $size
  i32.const 12
  i32.ge_u
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 247
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $size
  i32.const 256
  i32.lt_u
  if
   i32.const 0
   local.set $fl
   local.get $size
   i32.const 4
   i32.shr_u
   local.set $sl
  else
   local.get $size
   local.tee $6
   i32.const 1073741820
   local.tee $7
   local.get $6
   local.get $7
   i32.lt_u
   select
   local.set $boundedSize
   i32.const 31
   local.get $boundedSize
   i32.clz
   i32.sub
   local.set $fl
   local.get $boundedSize
   local.get $fl
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 1
   i32.const 4
   i32.shl
   i32.xor
   local.set $sl
   local.get $fl
   i32.const 8
   i32.const 1
   i32.sub
   i32.sub
   local.set $fl
  end
  i32.const 1
  drop
  local.get $fl
  i32.const 23
  i32.lt_u
  if (result i32)
   local.get $sl
   i32.const 16
   i32.lt_u
  else
   i32.const 0
  end
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 261
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $block
  call $~lib/rt/tlsf/Block#get:prev
  local.set $prev
  local.get $block
  call $~lib/rt/tlsf/Block#get:next
  local.set $next
  local.get $prev
  if
   local.get $prev
   local.get $next
   call $~lib/rt/tlsf/Block#set:next
  end
  local.get $next
  if
   local.get $next
   local.get $prev
   call $~lib/rt/tlsf/Block#set:prev
  end
  local.get $block
  block $__inlined_func$~lib/rt/tlsf/GETHEAD$1 (result i32)
   local.get $root
   local.set $12
   local.get $fl
   local.set $13
   local.get $sl
   local.set $14
   local.get $12
   local.get $13
   i32.const 4
   i32.shl
   local.get $14
   i32.add
   i32.const 2
   i32.shl
   i32.add
   i32.load offset=96
   br $__inlined_func$~lib/rt/tlsf/GETHEAD$1
  end
  i32.eq
  if
   block $__inlined_func$~lib/rt/tlsf/SETHEAD$2
    local.get $root
    local.set $15
    local.get $fl
    local.set $16
    local.get $sl
    local.set $17
    local.get $next
    local.set $18
    local.get $15
    local.get $16
    i32.const 4
    i32.shl
    local.get $17
    i32.add
    i32.const 2
    i32.shl
    i32.add
    local.get $18
    i32.store offset=96
   end
   local.get $next
   i32.eqz
   if
    block $__inlined_func$~lib/rt/tlsf/GETSL$3 (result i32)
     local.get $root
     local.set $19
     local.get $fl
     local.set $20
     local.get $19
     local.get $20
     i32.const 2
     i32.shl
     i32.add
     i32.load offset=4
     br $__inlined_func$~lib/rt/tlsf/GETSL$3
    end
    local.set $slMap
    block $__inlined_func$~lib/rt/tlsf/SETSL$4
     local.get $root
     local.set $21
     local.get $fl
     local.set $22
     local.get $slMap
     i32.const 1
     local.get $sl
     i32.shl
     i32.const -1
     i32.xor
     i32.and
     local.tee $slMap
     local.set $23
     local.get $21
     local.get $22
     i32.const 2
     i32.shl
     i32.add
     local.get $23
     i32.store offset=4
    end
    local.get $slMap
    i32.eqz
    if
     local.get $root
     local.get $root
     call $~lib/rt/tlsf/Root#get:flMap
     i32.const 1
     local.get $fl
     i32.shl
     i32.const -1
     i32.xor
     i32.and
     call $~lib/rt/tlsf/Root#set:flMap
    end
   end
  end
 )
 (func $~lib/rt/tlsf/GETFREELEFT (param $block i32) (result i32)
  local.get $block
  i32.const 4
  i32.sub
  i32.load
  return
 )
 (func $~lib/rt/tlsf/insertBlock (param $root i32) (param $block i32)
  (local $blockInfo i32)
  (local $right i32)
  (local $rightInfo i32)
  (local $left i32)
  (local $leftInfo i32)
  (local $size i32)
  (local $fl i32)
  (local $sl i32)
  (local $10 i32)
  (local $11 i32)
  (local $boundedSize i32)
  (local $head i32)
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
  (local $26 i32)
  (local $27 i32)
  (local $28 i32)
  i32.const 1
  drop
  local.get $block
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 178
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $block
  call $~lib/rt/common/BLOCK#get:mmInfo
  local.set $blockInfo
  i32.const 1
  drop
  local.get $blockInfo
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
  block $__inlined_func$~lib/rt/tlsf/GETRIGHT$1 (result i32)
   local.get $block
   local.set $14
   local.get $14
   i32.const 4
   i32.add
   local.get $14
   call $~lib/rt/common/BLOCK#get:mmInfo
   i32.const 3
   i32.const -1
   i32.xor
   i32.and
   i32.add
   br $__inlined_func$~lib/rt/tlsf/GETRIGHT$1
  end
  local.set $right
  local.get $right
  call $~lib/rt/common/BLOCK#get:mmInfo
  local.set $rightInfo
  local.get $rightInfo
  i32.const 1
  i32.and
  if
   local.get $root
   local.get $right
   call $~lib/rt/tlsf/removeBlock
   local.get $block
   local.get $blockInfo
   i32.const 4
   i32.add
   local.get $rightInfo
   i32.const 3
   i32.const -1
   i32.xor
   i32.and
   i32.add
   local.tee $blockInfo
   call $~lib/rt/common/BLOCK#set:mmInfo
   block $__inlined_func$~lib/rt/tlsf/GETRIGHT$2 (result i32)
    local.get $block
    local.set $15
    local.get $15
    i32.const 4
    i32.add
    local.get $15
    call $~lib/rt/common/BLOCK#get:mmInfo
    i32.const 3
    i32.const -1
    i32.xor
    i32.and
    i32.add
    br $__inlined_func$~lib/rt/tlsf/GETRIGHT$2
   end
   local.set $right
   local.get $right
   call $~lib/rt/common/BLOCK#get:mmInfo
   local.set $rightInfo
  end
  local.get $blockInfo
  i32.const 2
  i32.and
  if
   block $__inlined_func$~lib/rt/tlsf/GETFREELEFT$3 (result i32)
    local.get $block
    local.set $16
    local.get $16
    i32.const 4
    i32.sub
    i32.load
    br $__inlined_func$~lib/rt/tlsf/GETFREELEFT$3
   end
   local.set $left
   local.get $left
   call $~lib/rt/common/BLOCK#get:mmInfo
   local.set $leftInfo
   i32.const 1
   drop
   local.get $leftInfo
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
   local.get $root
   local.get $left
   call $~lib/rt/tlsf/removeBlock
   local.get $left
   local.set $block
   local.get $block
   local.get $leftInfo
   i32.const 4
   i32.add
   local.get $blockInfo
   i32.const 3
   i32.const -1
   i32.xor
   i32.and
   i32.add
   local.tee $blockInfo
   call $~lib/rt/common/BLOCK#set:mmInfo
  end
  local.get $right
  local.get $rightInfo
  i32.const 2
  i32.or
  call $~lib/rt/common/BLOCK#set:mmInfo
  local.get $blockInfo
  i32.const 3
  i32.const -1
  i32.xor
  i32.and
  local.set $size
  i32.const 1
  drop
  local.get $size
  i32.const 12
  i32.ge_u
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 210
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 1
  drop
  local.get $block
  i32.const 4
  i32.add
  local.get $size
  i32.add
  local.get $right
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 211
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $right
  i32.const 4
  i32.sub
  local.get $block
  i32.store
  local.get $size
  i32.const 256
  i32.lt_u
  if
   i32.const 0
   local.set $fl
   local.get $size
   i32.const 4
   i32.shr_u
   local.set $sl
  else
   local.get $size
   local.tee $10
   i32.const 1073741820
   local.tee $11
   local.get $10
   local.get $11
   i32.lt_u
   select
   local.set $boundedSize
   i32.const 31
   local.get $boundedSize
   i32.clz
   i32.sub
   local.set $fl
   local.get $boundedSize
   local.get $fl
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 1
   i32.const 4
   i32.shl
   i32.xor
   local.set $sl
   local.get $fl
   i32.const 8
   i32.const 1
   i32.sub
   i32.sub
   local.set $fl
  end
  i32.const 1
  drop
  local.get $fl
  i32.const 23
  i32.lt_u
  if (result i32)
   local.get $sl
   i32.const 16
   i32.lt_u
  else
   i32.const 0
  end
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 228
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/rt/tlsf/GETHEAD$4 (result i32)
   local.get $root
   local.set $17
   local.get $fl
   local.set $18
   local.get $sl
   local.set $19
   local.get $17
   local.get $18
   i32.const 4
   i32.shl
   local.get $19
   i32.add
   i32.const 2
   i32.shl
   i32.add
   i32.load offset=96
   br $__inlined_func$~lib/rt/tlsf/GETHEAD$4
  end
  local.set $head
  local.get $block
  i32.const 0
  call $~lib/rt/tlsf/Block#set:prev
  local.get $block
  local.get $head
  call $~lib/rt/tlsf/Block#set:next
  local.get $head
  if
   local.get $head
   local.get $block
   call $~lib/rt/tlsf/Block#set:prev
  end
  block $__inlined_func$~lib/rt/tlsf/SETHEAD$5
   local.get $root
   local.set $20
   local.get $fl
   local.set $21
   local.get $sl
   local.set $22
   local.get $block
   local.set $23
   local.get $20
   local.get $21
   i32.const 4
   i32.shl
   local.get $22
   i32.add
   i32.const 2
   i32.shl
   i32.add
   local.get $23
   i32.store offset=96
  end
  local.get $root
  local.get $root
  call $~lib/rt/tlsf/Root#get:flMap
  i32.const 1
  local.get $fl
  i32.shl
  i32.or
  call $~lib/rt/tlsf/Root#set:flMap
  block $__inlined_func$~lib/rt/tlsf/SETSL$7
   local.get $root
   local.set $26
   local.get $fl
   local.set $27
   block $__inlined_func$~lib/rt/tlsf/GETSL$6 (result i32)
    local.get $root
    local.set $24
    local.get $fl
    local.set $25
    local.get $24
    local.get $25
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=4
    br $__inlined_func$~lib/rt/tlsf/GETSL$6
   end
   i32.const 1
   local.get $sl
   i32.shl
   i32.or
   local.set $28
   local.get $26
   local.get $27
   i32.const 2
   i32.shl
   i32.add
   local.get $28
   i32.store offset=4
  end
 )
 (func $~lib/rt/tlsf/addMemory (param $root i32) (param $start i32) (param $endU64 i64) (result i32)
  (local $end i32)
  (local $tail i32)
  (local $tailInfo i32)
  (local $size i32)
  (local $leftSize i32)
  (local $left i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  local.get $endU64
  i32.wrap_i64
  local.set $end
  i32.const 1
  drop
  local.get $start
  i64.extend_i32_u
  local.get $endU64
  i64.le_u
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 357
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $start
  i32.const 4
  i32.add
  i32.const 15
  i32.add
  i32.const 15
  i32.const -1
  i32.xor
  i32.and
  i32.const 4
  i32.sub
  local.set $start
  local.get $end
  i32.const 15
  i32.const -1
  i32.xor
  i32.and
  local.set $end
  block $__inlined_func$~lib/rt/tlsf/GETTAIL$1 (result i32)
   local.get $root
   local.set $9
   local.get $9
   i32.load offset=1568
   br $__inlined_func$~lib/rt/tlsf/GETTAIL$1
  end
  local.set $tail
  i32.const 0
  local.set $tailInfo
  local.get $tail
  if
   i32.const 1
   drop
   local.get $start
   local.get $tail
   i32.const 4
   i32.add
   i32.ge_u
   i32.eqz
   if
    i32.const 0
    i32.const 752
    i32.const 365
    i32.const 16
    call $~lib/builtins/abort
    unreachable
   end
   local.get $start
   i32.const 16
   i32.sub
   local.get $tail
   i32.eq
   if
    local.get $start
    i32.const 16
    i32.sub
    local.set $start
    local.get $tail
    call $~lib/rt/common/BLOCK#get:mmInfo
    local.set $tailInfo
   else
    nop
   end
  else
   i32.const 1
   drop
   local.get $start
   local.get $root
   i32.const 1572
   i32.add
   i32.ge_u
   i32.eqz
   if
    i32.const 0
    i32.const 752
    i32.const 378
    i32.const 5
    call $~lib/builtins/abort
    unreachable
   end
  end
  local.get $end
  local.get $start
  i32.sub
  local.set $size
  local.get $size
  i32.const 4
  i32.const 12
  i32.add
  i32.const 4
  i32.add
  i32.lt_u
  if
   i32.const 0
   return
  end
  local.get $size
  i32.const 2
  i32.const 4
  i32.mul
  i32.sub
  local.set $leftSize
  local.get $start
  local.set $left
  local.get $left
  local.get $leftSize
  i32.const 1
  i32.or
  local.get $tailInfo
  i32.const 2
  i32.and
  i32.or
  call $~lib/rt/common/BLOCK#set:mmInfo
  local.get $left
  i32.const 0
  call $~lib/rt/tlsf/Block#set:prev
  local.get $left
  i32.const 0
  call $~lib/rt/tlsf/Block#set:next
  local.get $start
  i32.const 4
  i32.add
  local.get $leftSize
  i32.add
  local.set $tail
  local.get $tail
  i32.const 0
  i32.const 2
  i32.or
  call $~lib/rt/common/BLOCK#set:mmInfo
  block $__inlined_func$~lib/rt/tlsf/SETTAIL$2
   local.get $root
   local.set $10
   local.get $tail
   local.set $11
   local.get $10
   local.get $11
   i32.store offset=1568
  end
  local.get $root
  local.get $left
  call $~lib/rt/tlsf/insertBlock
  i32.const 1
  return
 )
 (func $~lib/rt/tlsf/initialize
  (local $rootOffset i32)
  (local $pagesBefore i32)
  (local $pagesNeeded i32)
  (local $root i32)
  (local $fl i32)
  (local $sl i32)
  (local $memStart i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 i32)
  (local $15 i32)
  global.get $~lib/memory/__heap_base
  i32.const 15
  i32.add
  i32.const 15
  i32.const -1
  i32.xor
  i32.and
  local.set $rootOffset
  memory.size
  local.set $pagesBefore
  local.get $rootOffset
  i32.const 1572
  i32.add
  i32.const 65535
  i32.add
  i32.const 65535
  i32.const -1
  i32.xor
  i32.and
  i32.const 16
  i32.shr_u
  local.set $pagesNeeded
  local.get $pagesNeeded
  local.get $pagesBefore
  i32.gt_s
  if (result i32)
   local.get $pagesNeeded
   local.get $pagesBefore
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
  local.get $rootOffset
  local.set $root
  local.get $root
  i32.const 0
  call $~lib/rt/tlsf/Root#set:flMap
  block $__inlined_func$~lib/rt/tlsf/SETTAIL$1
   local.get $root
   local.set $7
   i32.const 0
   local.set $8
   local.get $7
   local.get $8
   i32.store offset=1568
  end
  i32.const 0
  local.set $fl
  loop $for-loop|0
   local.get $fl
   i32.const 23
   i32.lt_u
   if
    block $__inlined_func$~lib/rt/tlsf/SETSL$2
     local.get $root
     local.set $9
     local.get $fl
     local.set $10
     i32.const 0
     local.set $11
     local.get $9
     local.get $10
     i32.const 2
     i32.shl
     i32.add
     local.get $11
     i32.store offset=4
    end
    i32.const 0
    local.set $sl
    loop $for-loop|1
     local.get $sl
     i32.const 16
     i32.lt_u
     if
      block $__inlined_func$~lib/rt/tlsf/SETHEAD$3
       local.get $root
       local.set $12
       local.get $fl
       local.set $13
       local.get $sl
       local.set $14
       i32.const 0
       local.set $15
       local.get $12
       local.get $13
       i32.const 4
       i32.shl
       local.get $14
       i32.add
       i32.const 2
       i32.shl
       i32.add
       local.get $15
       i32.store offset=96
      end
      local.get $sl
      i32.const 1
      i32.add
      local.set $sl
      br $for-loop|1
     end
    end
    local.get $fl
    i32.const 1
    i32.add
    local.set $fl
    br $for-loop|0
   end
  end
  local.get $rootOffset
  i32.const 1572
  i32.add
  local.set $memStart
  i32.const 0
  drop
  local.get $root
  local.get $memStart
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  drop
  local.get $root
  global.set $~lib/rt/tlsf/ROOT
 )
 (func $~lib/rt/tlsf/checkUsedBlock (param $ptr i32) (result i32)
  (local $block i32)
  local.get $ptr
  i32.const 4
  i32.sub
  local.set $block
  local.get $ptr
  i32.const 0
  i32.ne
  if (result i32)
   local.get $ptr
   i32.const 15
   i32.and
   i32.eqz
  else
   i32.const 0
  end
  if (result i32)
   local.get $block
   call $~lib/rt/common/BLOCK#get:mmInfo
   i32.const 1
   i32.and
   i32.eqz
  else
   i32.const 0
  end
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 532
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $block
  return
 )
 (func $~lib/rt/tlsf/freeBlock (param $root i32) (param $block i32)
  local.get $block
  local.get $block
  call $~lib/rt/common/BLOCK#get:mmInfo
  i32.const 1
  i32.or
  call $~lib/rt/common/BLOCK#set:mmInfo
  local.get $root
  local.get $block
  call $~lib/rt/tlsf/insertBlock
 )
 (func $~lib/rt/tlsf/__free (param $ptr i32)
  local.get $ptr
  global.get $~lib/memory/__heap_base
  i32.lt_u
  if
   return
  end
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   call $~lib/rt/tlsf/initialize
  end
  global.get $~lib/rt/tlsf/ROOT
  local.get $ptr
  call $~lib/rt/tlsf/checkUsedBlock
  call $~lib/rt/tlsf/freeBlock
 )
 (func $~lib/rt/itcms/free (param $obj i32)
  local.get $obj
  global.get $~lib/memory/__heap_base
  i32.lt_u
  if
   local.get $obj
   i32.const 0
   call $~lib/rt/itcms/Object#set:nextWithColor
   local.get $obj
   i32.const 0
   call $~lib/rt/itcms/Object#set:prev
  else
   i32.const 0
   drop
   global.get $~lib/rt/itcms/total
   local.get $obj
   call $~lib/rt/itcms/Object#get:size
   i32.sub
   global.set $~lib/rt/itcms/total
   i32.const 0
   drop
   local.get $obj
   i32.const 4
   i32.add
   call $~lib/rt/tlsf/__free
  end
 )
 (func $~lib/rt/itcms/step (result i32)
  (local $obj i32)
  (local $1 i32)
  (local $black i32)
  (local $from i32)
  block $break|0
   block $case2|0
    block $case1|0
     block $case0|0
      global.get $~lib/rt/itcms/state
      local.set $1
      local.get $1
      i32.const 0
      i32.eq
      br_if $case0|0
      local.get $1
      i32.const 1
      i32.eq
      br_if $case1|0
      local.get $1
      i32.const 2
      i32.eq
      br_if $case2|0
      br $break|0
     end
     i32.const 1
     global.set $~lib/rt/itcms/state
     i32.const 0
     global.set $~lib/rt/itcms/visitCount
     i32.const 0
     call $~lib/rt/itcms/visitRoots
     global.get $~lib/rt/itcms/toSpace
     global.set $~lib/rt/itcms/iter
     global.get $~lib/rt/itcms/visitCount
     i32.const 1
     i32.mul
     return
    end
    global.get $~lib/rt/itcms/white
    i32.eqz
    local.set $black
    global.get $~lib/rt/itcms/iter
    call $~lib/rt/itcms/Object#get:next
    local.set $obj
    block $while-break|1
     loop $while-continue|1
      local.get $obj
      global.get $~lib/rt/itcms/toSpace
      i32.ne
      if
       local.get $obj
       global.set $~lib/rt/itcms/iter
       local.get $obj
       call $~lib/rt/itcms/Object#get:color
       local.get $black
       i32.ne
       if
        local.get $obj
        local.get $black
        call $~lib/rt/itcms/Object#set:color
        i32.const 0
        global.set $~lib/rt/itcms/visitCount
        local.get $obj
        i32.const 20
        i32.add
        i32.const 0
        call $~lib/rt/__visit_members
        global.get $~lib/rt/itcms/visitCount
        i32.const 1
        i32.mul
        return
       end
       local.get $obj
       call $~lib/rt/itcms/Object#get:next
       local.set $obj
       br $while-continue|1
      end
     end
    end
    i32.const 0
    global.set $~lib/rt/itcms/visitCount
    i32.const 0
    call $~lib/rt/itcms/visitRoots
    global.get $~lib/rt/itcms/iter
    call $~lib/rt/itcms/Object#get:next
    local.set $obj
    local.get $obj
    global.get $~lib/rt/itcms/toSpace
    i32.eq
    if
     i32.const 0
     call $~lib/rt/itcms/visitStack
     global.get $~lib/rt/itcms/iter
     call $~lib/rt/itcms/Object#get:next
     local.set $obj
     block $while-break|2
      loop $while-continue|2
       local.get $obj
       global.get $~lib/rt/itcms/toSpace
       i32.ne
       if
        local.get $obj
        call $~lib/rt/itcms/Object#get:color
        local.get $black
        i32.ne
        if
         local.get $obj
         local.get $black
         call $~lib/rt/itcms/Object#set:color
         local.get $obj
         i32.const 20
         i32.add
         i32.const 0
         call $~lib/rt/__visit_members
        end
        local.get $obj
        call $~lib/rt/itcms/Object#get:next
        local.set $obj
        br $while-continue|2
       end
      end
     end
     global.get $~lib/rt/itcms/fromSpace
     local.set $from
     global.get $~lib/rt/itcms/toSpace
     global.set $~lib/rt/itcms/fromSpace
     local.get $from
     global.set $~lib/rt/itcms/toSpace
     local.get $black
     global.set $~lib/rt/itcms/white
     local.get $from
     call $~lib/rt/itcms/Object#get:next
     global.set $~lib/rt/itcms/iter
     i32.const 2
     global.set $~lib/rt/itcms/state
    end
    global.get $~lib/rt/itcms/visitCount
    i32.const 1
    i32.mul
    return
   end
   global.get $~lib/rt/itcms/iter
   local.set $obj
   local.get $obj
   global.get $~lib/rt/itcms/toSpace
   i32.ne
   if
    local.get $obj
    call $~lib/rt/itcms/Object#get:next
    global.set $~lib/rt/itcms/iter
    i32.const 1
    drop
    local.get $obj
    call $~lib/rt/itcms/Object#get:color
    global.get $~lib/rt/itcms/white
    i32.eqz
    i32.eq
    i32.eqz
    if
     i32.const 0
     i32.const 480
     i32.const 229
     i32.const 20
     call $~lib/builtins/abort
     unreachable
    end
    local.get $obj
    call $~lib/rt/itcms/free
    i32.const 10
    return
   end
   global.get $~lib/rt/itcms/toSpace
   global.get $~lib/rt/itcms/toSpace
   call $~lib/rt/itcms/Object#set:nextWithColor
   global.get $~lib/rt/itcms/toSpace
   global.get $~lib/rt/itcms/toSpace
   call $~lib/rt/itcms/Object#set:prev
   i32.const 0
   global.set $~lib/rt/itcms/state
   br $break|0
  end
  i32.const 0
  return
 )
 (func $~lib/rt/itcms/interrupt
  (local $budget i32)
  i32.const 0
  drop
  i32.const 1024
  i32.const 200
  i32.mul
  i32.const 100
  i32.div_u
  local.set $budget
  loop $do-loop|0
   local.get $budget
   call $~lib/rt/itcms/step
   i32.sub
   local.set $budget
   global.get $~lib/rt/itcms/state
   i32.const 0
   i32.eq
   if
    i32.const 0
    drop
    i32.const 200
    i32.const 100
    i32.rem_u
    i32.const 0
    i32.eq
    drop
    global.get $~lib/rt/itcms/total
    i32.const 200
    i32.const 100
    i32.div_u
    i32.mul
    i32.const 1024
    i32.add
    global.set $~lib/rt/itcms/threshold
    return
   end
   local.get $budget
   i32.const 0
   i32.gt_s
   br_if $do-loop|0
  end
  i32.const 0
  drop
  global.get $~lib/rt/itcms/total
  i32.const 1024
  global.get $~lib/rt/itcms/total
  global.get $~lib/rt/itcms/threshold
  i32.sub
  i32.const 1024
  i32.lt_u
  i32.mul
  i32.add
  global.set $~lib/rt/itcms/threshold
 )
 (func $~lib/rt/tlsf/computeSize (param $size i32) (result i32)
  local.get $size
  i32.const 12
  i32.le_u
  if (result i32)
   i32.const 12
  else
   local.get $size
   i32.const 4
   i32.add
   i32.const 15
   i32.add
   i32.const 15
   i32.const -1
   i32.xor
   i32.and
   i32.const 4
   i32.sub
  end
  return
 )
 (func $~lib/rt/tlsf/prepareSize (param $size i32) (result i32)
  local.get $size
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
  local.get $size
  call $~lib/rt/tlsf/computeSize
  return
 )
 (func $~lib/rt/tlsf/roundSize (param $size i32) (result i32)
  local.get $size
  i32.const 536870910
  i32.lt_u
  if (result i32)
   local.get $size
   i32.const 1
   i32.const 27
   local.get $size
   i32.clz
   i32.sub
   i32.shl
   i32.add
   i32.const 1
   i32.sub
  else
   local.get $size
  end
  return
 )
 (func $~lib/rt/tlsf/searchBlock (param $root i32) (param $size i32) (result i32)
  (local $fl i32)
  (local $sl i32)
  (local $requestSize i32)
  (local $slMap i32)
  (local $head i32)
  (local $flMap i32)
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
  local.get $size
  i32.const 256
  i32.lt_u
  if
   i32.const 0
   local.set $fl
   local.get $size
   i32.const 4
   i32.shr_u
   local.set $sl
  else
   local.get $size
   call $~lib/rt/tlsf/roundSize
   local.set $requestSize
   i32.const 4
   i32.const 8
   i32.mul
   i32.const 1
   i32.sub
   local.get $requestSize
   i32.clz
   i32.sub
   local.set $fl
   local.get $requestSize
   local.get $fl
   i32.const 4
   i32.sub
   i32.shr_u
   i32.const 1
   i32.const 4
   i32.shl
   i32.xor
   local.set $sl
   local.get $fl
   i32.const 8
   i32.const 1
   i32.sub
   i32.sub
   local.set $fl
  end
  i32.const 1
  drop
  local.get $fl
  i32.const 23
  i32.lt_u
  if (result i32)
   local.get $sl
   i32.const 16
   i32.lt_u
  else
   i32.const 0
  end
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 309
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  block $__inlined_func$~lib/rt/tlsf/GETSL$1 (result i32)
   local.get $root
   local.set $8
   local.get $fl
   local.set $9
   local.get $8
   local.get $9
   i32.const 2
   i32.shl
   i32.add
   i32.load offset=4
   br $__inlined_func$~lib/rt/tlsf/GETSL$1
  end
  i32.const 0
  i32.const -1
  i32.xor
  local.get $sl
  i32.shl
  i32.and
  local.set $slMap
  i32.const 0
  local.set $head
  local.get $slMap
  i32.eqz
  if
   local.get $root
   call $~lib/rt/tlsf/Root#get:flMap
   i32.const 0
   i32.const -1
   i32.xor
   local.get $fl
   i32.const 1
   i32.add
   i32.shl
   i32.and
   local.set $flMap
   local.get $flMap
   i32.eqz
   if
    i32.const 0
    local.set $head
   else
    local.get $flMap
    i32.ctz
    local.set $fl
    block $__inlined_func$~lib/rt/tlsf/GETSL$2 (result i32)
     local.get $root
     local.set $10
     local.get $fl
     local.set $11
     local.get $10
     local.get $11
     i32.const 2
     i32.shl
     i32.add
     i32.load offset=4
     br $__inlined_func$~lib/rt/tlsf/GETSL$2
    end
    local.set $slMap
    i32.const 1
    drop
    local.get $slMap
    i32.eqz
    if
     i32.const 0
     i32.const 752
     i32.const 322
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    block $__inlined_func$~lib/rt/tlsf/GETHEAD$3 (result i32)
     local.get $root
     local.set $12
     local.get $fl
     local.set $13
     local.get $slMap
     i32.ctz
     local.set $14
     local.get $12
     local.get $13
     i32.const 4
     i32.shl
     local.get $14
     i32.add
     i32.const 2
     i32.shl
     i32.add
     i32.load offset=96
     br $__inlined_func$~lib/rt/tlsf/GETHEAD$3
    end
    local.set $head
   end
  else
   block $__inlined_func$~lib/rt/tlsf/GETHEAD$4 (result i32)
    local.get $root
    local.set $15
    local.get $fl
    local.set $16
    local.get $slMap
    i32.ctz
    local.set $17
    local.get $15
    local.get $16
    i32.const 4
    i32.shl
    local.get $17
    i32.add
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=96
    br $__inlined_func$~lib/rt/tlsf/GETHEAD$4
   end
   local.set $head
  end
  local.get $head
  return
 )
 (func $~lib/rt/tlsf/growMemory (param $root i32) (param $size i32)
  (local $pagesBefore i32)
  (local $pagesNeeded i32)
  (local $4 i32)
  (local $5 i32)
  (local $pagesWanted i32)
  (local $pagesAfter i32)
  (local $8 i32)
  i32.const 0
  drop
  local.get $size
  i32.const 256
  i32.ge_u
  if
   local.get $size
   call $~lib/rt/tlsf/roundSize
   local.set $size
  end
  memory.size
  local.set $pagesBefore
  local.get $size
  i32.const 4
  local.get $pagesBefore
  i32.const 16
  i32.shl
  i32.const 4
  i32.sub
  block $__inlined_func$~lib/rt/tlsf/GETTAIL$1 (result i32)
   local.get $root
   local.set $8
   local.get $8
   i32.load offset=1568
   br $__inlined_func$~lib/rt/tlsf/GETTAIL$1
  end
  i32.ne
  i32.shl
  i32.add
  local.set $size
  local.get $size
  i32.const 65535
  i32.add
  i32.const 65535
  i32.const -1
  i32.xor
  i32.and
  i32.const 16
  i32.shr_u
  local.set $pagesNeeded
  local.get $pagesBefore
  local.tee $4
  local.get $pagesNeeded
  local.tee $5
  local.get $4
  local.get $5
  i32.gt_s
  select
  local.set $pagesWanted
  local.get $pagesWanted
  memory.grow
  i32.const 0
  i32.lt_s
  if
   local.get $pagesNeeded
   memory.grow
   i32.const 0
   i32.lt_s
   if
    unreachable
   end
  end
  memory.size
  local.set $pagesAfter
  local.get $root
  local.get $pagesBefore
  i32.const 16
  i32.shl
  local.get $pagesAfter
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  drop
 )
 (func $~lib/rt/tlsf/prepareBlock (param $root i32) (param $block i32) (param $size i32)
  (local $blockInfo i32)
  (local $remaining i32)
  (local $spare i32)
  (local $6 i32)
  (local $7 i32)
  local.get $block
  call $~lib/rt/common/BLOCK#get:mmInfo
  local.set $blockInfo
  i32.const 1
  drop
  local.get $size
  i32.const 4
  i32.add
  i32.const 15
  i32.and
  i32.eqz
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 336
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $blockInfo
  i32.const 3
  i32.const -1
  i32.xor
  i32.and
  local.get $size
  i32.sub
  local.set $remaining
  local.get $remaining
  i32.const 4
  i32.const 12
  i32.add
  i32.ge_u
  if
   local.get $block
   local.get $size
   local.get $blockInfo
   i32.const 2
   i32.and
   i32.or
   call $~lib/rt/common/BLOCK#set:mmInfo
   local.get $block
   i32.const 4
   i32.add
   local.get $size
   i32.add
   local.set $spare
   local.get $spare
   local.get $remaining
   i32.const 4
   i32.sub
   i32.const 1
   i32.or
   call $~lib/rt/common/BLOCK#set:mmInfo
   local.get $root
   local.get $spare
   call $~lib/rt/tlsf/insertBlock
  else
   local.get $block
   local.get $blockInfo
   i32.const 1
   i32.const -1
   i32.xor
   i32.and
   call $~lib/rt/common/BLOCK#set:mmInfo
   block $__inlined_func$~lib/rt/tlsf/GETRIGHT$1 (result i32)
    local.get $block
    local.set $7
    local.get $7
    i32.const 4
    i32.add
    local.get $7
    call $~lib/rt/common/BLOCK#get:mmInfo
    i32.const 3
    i32.const -1
    i32.xor
    i32.and
    i32.add
    br $__inlined_func$~lib/rt/tlsf/GETRIGHT$1
   end
   local.set $6
   local.get $6
   local.get $6
   call $~lib/rt/common/BLOCK#get:mmInfo
   i32.const 2
   i32.const -1
   i32.xor
   i32.and
   call $~lib/rt/common/BLOCK#set:mmInfo
  end
 )
 (func $~lib/rt/tlsf/allocateBlock (param $root i32) (param $size i32) (result i32)
  (local $payloadSize i32)
  (local $block i32)
  local.get $size
  call $~lib/rt/tlsf/prepareSize
  local.set $payloadSize
  local.get $root
  local.get $payloadSize
  call $~lib/rt/tlsf/searchBlock
  local.set $block
  local.get $block
  i32.eqz
  if
   local.get $root
   local.get $payloadSize
   call $~lib/rt/tlsf/growMemory
   local.get $root
   local.get $payloadSize
   call $~lib/rt/tlsf/searchBlock
   local.set $block
   i32.const 1
   drop
   local.get $block
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
  i32.const 1
  drop
  local.get $block
  call $~lib/rt/common/BLOCK#get:mmInfo
  i32.const 3
  i32.const -1
  i32.xor
  i32.and
  local.get $payloadSize
  i32.ge_u
  i32.eqz
  if
   i32.const 0
   i32.const 752
   i32.const 474
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $root
  local.get $block
  call $~lib/rt/tlsf/removeBlock
  local.get $root
  local.get $block
  local.get $payloadSize
  call $~lib/rt/tlsf/prepareBlock
  local.get $block
  return
 )
 (func $~lib/rt/tlsf/__alloc (param $size i32) (result i32)
  global.get $~lib/rt/tlsf/ROOT
  i32.eqz
  if
   call $~lib/rt/tlsf/initialize
  end
  global.get $~lib/rt/tlsf/ROOT
  local.get $size
  call $~lib/rt/tlsf/allocateBlock
  i32.const 4
  i32.add
  return
 )
 (func $~lib/rt/itcms/Object#set:rtId (param $this i32) (param $rtId i32)
  local.get $this
  local.get $rtId
  i32.store offset=12
 )
 (func $~lib/rt/itcms/Object#set:rtSize (param $this i32) (param $rtSize i32)
  local.get $this
  local.get $rtSize
  i32.store offset=16
 )
 (func $~lib/rt/itcms/__new (param $size i32) (param $id i32) (result i32)
  (local $obj i32)
  (local $ptr i32)
  local.get $size
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
   call $~lib/rt/itcms/interrupt
  end
  i32.const 16
  local.get $size
  i32.add
  call $~lib/rt/tlsf/__alloc
  i32.const 4
  i32.sub
  local.set $obj
  local.get $obj
  local.get $id
  call $~lib/rt/itcms/Object#set:rtId
  local.get $obj
  local.get $size
  call $~lib/rt/itcms/Object#set:rtSize
  local.get $obj
  global.get $~lib/rt/itcms/fromSpace
  global.get $~lib/rt/itcms/white
  call $~lib/rt/itcms/Object#linkTo
  global.get $~lib/rt/itcms/total
  local.get $obj
  call $~lib/rt/itcms/Object#get:size
  i32.add
  global.set $~lib/rt/itcms/total
  local.get $obj
  i32.const 20
  i32.add
  local.set $ptr
  local.get $ptr
  i32.const 0
  local.get $size
  memory.fill
  local.get $ptr
  return
 )
 (func $~lib/string/String#concat (param $this i32) (param $other i32) (result i32)
  (local $thisSize i32)
  (local $otherSize i32)
  (local $outSize i32)
  (local $out i32)
  (local $6 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/string/String#get:length
  i32.const 1
  i32.shl
  local.set $thisSize
  local.get $other
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/string/String#get:length
  i32.const 1
  i32.shl
  local.set $otherSize
  local.get $thisSize
  local.get $otherSize
  i32.add
  local.set $outSize
  local.get $outSize
  i32.const 0
  i32.eq
  if
   i32.const 384
   local.set $6
   i32.const 4
   call $~lib/rt/__increase_sp
   local.get $6
   return
  end
  local.get $outSize
  i32.const 2
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $out
  local.get $out
  local.get $this
  local.get $thisSize
  memory.copy
  local.get $out
  local.get $thisSize
  i32.add
  local.get $other
  local.get $otherSize
  memory.copy
  local.get $out
  local.set $6
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $6
  return
  local.set $6
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $~lib/string/String.__concat (param $left i32) (param $right i32) (result i32)
  (local $2 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  local.get $left
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $right
  i32.const 4
  call $~lib/rt/__tmptostack
  call $~lib/string/String#concat
  local.set $2
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $2
  return
 )
 (func $~lib/rt/itcms/__link (param $parentPtr i32) (param $childPtr i32) (param $expectMultiple i32)
  (local $child i32)
  (local $parent i32)
  (local $parentColor i32)
  local.get $childPtr
  i32.eqz
  if
   return
  end
  i32.const 1
  drop
  local.get $parentPtr
  i32.eqz
  if
   i32.const 0
   i32.const 480
   i32.const 296
   i32.const 14
   call $~lib/builtins/abort
   unreachable
  end
  local.get $childPtr
  i32.const 20
  i32.sub
  local.set $child
  local.get $child
  call $~lib/rt/itcms/Object#get:color
  global.get $~lib/rt/itcms/white
  i32.eq
  if
   local.get $parentPtr
   i32.const 20
   i32.sub
   local.set $parent
   local.get $parent
   call $~lib/rt/itcms/Object#get:color
   local.set $parentColor
   local.get $parentColor
   global.get $~lib/rt/itcms/white
   i32.eqz
   i32.eq
   if
    local.get $expectMultiple
    if
     local.get $parent
     call $~lib/rt/itcms/Object#makeGray
    else
     local.get $child
     call $~lib/rt/itcms/Object#makeGray
    end
   else
    local.get $parentColor
    i32.const 3
    i32.eq
    if (result i32)
     global.get $~lib/rt/itcms/state
     i32.const 1
     i32.eq
    else
     i32.const 0
    end
    if
     local.get $child
     call $~lib/rt/itcms/Object#makeGray
    end
   end
  end
 )
 (func $~lib/arraybuffer/ArrayBufferView#set:buffer (param $this i32) (param $buffer i32)
  local.get $this
  local.get $buffer
  i32.store
  local.get $this
  local.get $buffer
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/arraybuffer/ArrayBufferView#set:dataStart (param $this i32) (param $dataStart i32)
  local.get $this
  local.get $dataStart
  i32.store offset=4
 )
 (func $~lib/arraybuffer/ArrayBufferView#set:byteLength (param $this i32) (param $byteLength i32)
  local.get $this
  local.get $byteLength
  i32.store offset=8
 )
 (func $~lib/arraybuffer/ArrayBufferView#constructor (param $this i32) (param $length i32) (param $alignLog2 i32) (result i32)
  (local $buffer i32)
  (local $4 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $length
  i32.const 1073741820
  local.get $alignLog2
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
  local.get $length
  local.get $alignLog2
  i32.shl
  local.tee $length
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#set:buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  call $~lib/arraybuffer/ArrayBufferView#set:dataStart
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $length
  call $~lib/arraybuffer/ArrayBufferView#set:byteLength
  local.get $this
  local.set $4
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $~lib/typedarray/Uint8Array#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $length
  i32.const 0
  call $~lib/arraybuffer/ArrayBufferView#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $this
  local.get $this
  local.set $2
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $2
 )
 (func $~lib/arraybuffer/ArrayBufferView#get:byteLength (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $~lib/arraybuffer/ArrayBufferView#get:dataStart (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/typedarray/Uint8Array#__set (param $this i32) (param $index i32) (param $value i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $index
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:byteLength
  i32.ge_u
  if
   i32.const 608
   i32.const 928
   i32.const 193
   i32.const 45
   call $~lib/builtins/abort
   unreachable
  end
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:dataStart
  local.get $index
  i32.add
  local.get $value
  i32.store8
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/typedarray/Float64Array#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $length
  i32.const 3
  call $~lib/arraybuffer/ArrayBufferView#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $this
  local.get $this
  local.set $2
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $2
 )
 (func $~lib/typedarray/Float64Array#__set (param $this i32) (param $index i32) (param $value f64)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $index
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:byteLength
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
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:dataStart
  local.get $index
  i32.const 3
  i32.shl
  i32.add
  local.get $value
  f64.store
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/typedarray/Int32Array#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $length
  i32.const 2
  call $~lib/arraybuffer/ArrayBufferView#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $this
  local.get $this
  local.set $2
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $2
 )
 (func $~lib/typedarray/Int32Array#__set (param $this i32) (param $index i32) (param $value i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $index
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:byteLength
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
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:dataStart
  local.get $index
  i32.const 2
  i32.shl
  i32.add
  local.get $value
  i32.store
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/staticarray/StaticArray<i32>#constructor (param $this i32) (param $length i32) (result i32)
  (local $outSize i32)
  (local $out i32)
  (local $4 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $length
  i32.const 1073741820
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   i32.const 816
   i32.const 992
   i32.const 52
   i32.const 62
   call $~lib/builtins/abort
   unreachable
  end
  local.get $length
  i32.const 2
  i32.shl
  local.set $outSize
  local.get $outSize
  i32.const 19
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $out
  local.get $out
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
  return
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $~lib/staticarray/StaticArray<i32>#get:length (param $this i32) (result i32)
  local.get $this
  i32.const 20
  i32.sub
  call $~lib/rt/common/OBJECT#get:rtSize
  i32.const 2
  i32.shr_u
  return
 )
 (func $~lib/staticarray/StaticArray<i32>#__uset (param $this i32) (param $index i32) (param $value i32)
  local.get $this
  local.get $index
  i32.const 2
  i32.shl
  i32.add
  local.get $value
  i32.store
  i32.const 0
  drop
 )
 (func $~lib/staticarray/StaticArray<i32>#__set (param $this i32) (param $index i32) (param $value i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $index
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/staticarray/StaticArray<i32>#get:length
  i32.ge_u
  if
   i32.const 608
   i32.const 992
   i32.const 94
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $index
  local.get $value
  call $~lib/staticarray/StaticArray<i32>#__uset
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:buffer (param $this i32) (param $buffer i32)
  local.get $this
  local.get $buffer
  i32.store
  local.get $this
  local.get $buffer
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:dataStart (param $this i32) (param $dataStart i32)
  local.get $this
  local.get $dataStart
  i32.store offset=4
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:byteLength (param $this i32) (param $byteLength i32)
  local.get $this
  local.get $byteLength
  i32.store offset=8
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:length_ (param $this i32) (param $length_ i32)
  local.get $this
  local.get $length_
  i32.store offset=12
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (local $6 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $length
  i32.const 1073741820
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   i32.const 816
   i32.const 1056
   i32.const 81
   i32.const 62
   call $~lib/builtins/abort
   unreachable
  end
  local.get $length
  local.tee $2
  i32.const 8
  local.tee $3
  local.get $2
  local.get $3
  i32.gt_u
  select
  i32.const 2
  i32.shl
  local.set $bufferSize
  local.get $bufferSize
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:dataStart
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $bufferSize
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:byteLength
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $length
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:length_
  local.get $this
  local.set $6
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#set:name (param $this i32) (param $name i32)
  local.get $this
  local.get $name
  i32.store
  local.get $this
  local.get $name
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#set:weight (param $this i32) (param $weight i32)
  local.get $this
  local.get $weight
  i32.store offset=4
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor (param $this i32) (param $name i32) (param $weight i32) (result i32)
  (local $3 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $name
  i32.const 4
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#set:name
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $weight
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#set:weight
  local.get $this
  local.set $3
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:length_ (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/arraybuffer/ArrayBufferView#get:buffer (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/rt/itcms/Object#get:rtSize (param $this i32) (result i32)
  local.get $this
  i32.load offset=16
 )
 (func $~lib/rt/itcms/__renew (param $oldPtr i32) (param $size i32) (result i32)
  (local $oldObj i32)
  (local $newPtr i32)
  (local $4 i32)
  (local $5 i32)
  local.get $oldPtr
  i32.const 20
  i32.sub
  local.set $oldObj
  local.get $size
  local.get $oldObj
  call $~lib/rt/common/BLOCK#get:mmInfo
  i32.const 3
  i32.const -1
  i32.xor
  i32.and
  i32.const 16
  i32.sub
  i32.le_u
  if
   local.get $oldObj
   local.get $size
   call $~lib/rt/itcms/Object#set:rtSize
   local.get $oldPtr
   return
  end
  local.get $size
  local.get $oldObj
  call $~lib/rt/itcms/Object#get:rtId
  call $~lib/rt/itcms/__new
  local.set $newPtr
  local.get $newPtr
  local.get $oldPtr
  local.get $size
  local.tee $4
  local.get $oldObj
  call $~lib/rt/itcms/Object#get:rtSize
  local.tee $5
  local.get $4
  local.get $5
  i32.lt_u
  select
  memory.copy
  local.get $newPtr
  return
 )
 (func $~lib/array/ensureCapacity (param $array i32) (param $newSize i32) (param $alignLog2 i32) (param $canGrow i32)
  (local $oldCapacity i32)
  (local $oldData i32)
  (local $6 i32)
  (local $7 i32)
  (local $newCapacity i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $newData i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $array
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:byteLength
  local.set $oldCapacity
  local.get $newSize
  local.get $oldCapacity
  local.get $alignLog2
  i32.shr_u
  i32.gt_u
  if
   local.get $newSize
   i32.const 1073741820
   local.get $alignLog2
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
   local.get $array
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/arraybuffer/ArrayBufferView#get:buffer
   local.set $oldData
   local.get $newSize
   local.tee $6
   i32.const 8
   local.tee $7
   local.get $6
   local.get $7
   i32.gt_u
   select
   local.get $alignLog2
   i32.shl
   local.set $newCapacity
   local.get $canGrow
   if
    local.get $oldCapacity
    i32.const 1
    i32.shl
    local.tee $9
    i32.const 1073741820
    local.tee $10
    local.get $9
    local.get $10
    i32.lt_u
    select
    local.tee $11
    local.get $newCapacity
    local.tee $12
    local.get $11
    local.get $12
    i32.gt_u
    select
    local.set $newCapacity
   end
   local.get $oldData
   local.get $newCapacity
   call $~lib/rt/itcms/__renew
   local.set $newData
   local.get $newData
   local.get $oldData
   i32.ne
   if
    local.get $array
    local.get $newData
    i32.store
    local.get $array
    local.get $newData
    i32.store offset=4
    local.get $array
    local.get $newData
    i32.const 0
    call $~lib/rt/itcms/__link
   end
   local.get $array
   local.get $newCapacity
   i32.store offset=8
  end
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:dataStart (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push (param $this i32) (param $value i32) (result i32)
  (local $oldLen i32)
  (local $len i32)
  (local $4 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:length_
  local.set $oldLen
  local.get $oldLen
  i32.const 1
  i32.add
  local.set $len
  local.get $this
  local.get $len
  i32.const 2
  i32.const 1
  call $~lib/array/ensureCapacity
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:dataStart
  local.get $oldLen
  i32.const 2
  i32.shl
  i32.add
  local.get $value
  i32.store
  local.get $this
  local.get $value
  i32.const 1
  call $~lib/rt/itcms/__link
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $len
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:length_
  local.get $len
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
  return
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity#set:id (param $this i32) (param $id i32)
  local.get $this
  local.get $id
  i32.store
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#set:x (param $this i32) (param $x f32)
  local.get $this
  local.get $x
  f32.store
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#set:y (param $this i32) (param $y f32)
  local.get $this
  local.get $y
  f32.store offset=4
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#constructor (param $this i32) (param $x f32) (param $y f32) (result i32)
  (local $3 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $x
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#set:x
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $y
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#set:y
  local.get $this
  local.set $3
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity#set:position (param $this i32) (param $position i32)
  local.get $this
  local.get $position
  i32.store offset=4
  local.get $this
  local.get $position
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity#constructor (param $this i32) (param $id i32) (param $x f32) (param $y f32) (result i32)
  (local $4 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $id
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity#set:id
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 9
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $x
  local.get $y
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity#set:position
  local.get $this
  local.set $4
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name (param $this i32) (param $name i32)
  local.get $this
  local.get $name
  i32.store offset=8
  local.get $this
  local.get $name
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:hp (param $this i32) (param $hp i32)
  local.get $this
  local.get $hp
  i32.store offset=12
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#constructor (param $this i32) (param $id i32) (param $name i32) (param $hp i32) (param $x f32) (param $y f32) (result i32)
  (local $6 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $id
  local.get $x
  local.get $y
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $this
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $name
  i32.const 8
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:name
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $hp
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#set:hp
  local.get $this
  local.set $6
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#set:inventory (param $this i32) (param $inventory i32)
  local.get $this
  local.get $inventory
  i32.store offset=16
  local.get $this
  local.get $inventory
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#set:score (param $this i32) (param $score i32)
  local.get $this
  local.get $score
  i32.store offset=20
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#constructor (param $this i32) (param $id i32) (param $name i32) (param $hp i32) (param $x f32) (param $y f32) (result i32)
  (local $6 i32)
  i32.const 16
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $id
  local.get $name
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $hp
  local.get $x
  local.get $y
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $this
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  i32.const 16
  i32.const 11
  call $~lib/rt/itcms/__new
  i32.const 12
  call $~lib/rt/__tmptostack
  i32.const 0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
  i32.const 8
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#set:inventory
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  i32.const 0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#set:score
  local.get $this
  local.set $6
  i32.const 16
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#get:inventory (param $this i32) (result i32)
  local.get $this
  i32.load offset=16
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem (param $this i32) (param $item i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#get:inventory
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $item
  i32.const 4
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  drop
  i32.const 12
  call $~lib/rt/__increase_sp
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#set:dialogue (param $this i32) (param $dialogue i32)
  local.get $this
  local.get $dialogue
  i32.store offset=16
  local.get $this
  local.get $dialogue
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#constructor (param $this i32) (param $id i32) (param $name i32) (param $hp i32) (param $dialogue i32) (result i32)
  (local $5 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $id
  local.get $name
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $hp
  f32.const 0
  f32.const 0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $this
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $dialogue
  i32.const 8
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#set:dialogue
  local.get $this
  local.set $5
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $5
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#set:buffer (param $this i32) (param $buffer i32)
  local.get $this
  local.get $buffer
  i32.store
  local.get $this
  local.get $buffer
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#set:dataStart (param $this i32) (param $dataStart i32)
  local.get $this
  local.get $dataStart
  i32.store offset=4
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#set:byteLength (param $this i32) (param $byteLength i32)
  local.get $this
  local.get $byteLength
  i32.store offset=8
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#set:length_ (param $this i32) (param $length_ i32)
  local.get $this
  local.get $length_
  i32.store offset=12
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (local $6 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $length
  i32.const 1073741820
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   i32.const 816
   i32.const 1056
   i32.const 81
   i32.const 62
   call $~lib/builtins/abort
   unreachable
  end
  local.get $length
  local.tee $2
  i32.const 8
  local.tee $3
  local.get $2
  local.get $3
  i32.gt_u
  select
  i32.const 2
  i32.shl
  local.set $bufferSize
  local.get $bufferSize
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#set:buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#set:dataStart
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $bufferSize
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#set:byteLength
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $length
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#set:length_
  local.get $this
  local.set $6
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:length_ (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:dataStart (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#push (param $this i32) (param $value i32) (result i32)
  (local $oldLen i32)
  (local $len i32)
  (local $4 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:length_
  local.set $oldLen
  local.get $oldLen
  i32.const 1
  i32.add
  local.set $len
  local.get $this
  local.get $len
  i32.const 2
  i32.const 1
  call $~lib/array/ensureCapacity
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:dataStart
  local.get $oldLen
  i32.const 2
  i32.shl
  i32.add
  local.get $value
  i32.store
  local.get $this
  local.get $value
  i32.const 1
  call $~lib/rt/itcms/__link
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $len
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#set:length_
  local.get $len
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
  return
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#set:value (param $this i32) (param $value i32)
  local.get $this
  local.get $value
  i32.store
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#set:left (param $this i32) (param $left i32)
  local.get $this
  local.get $left
  i32.store offset=4
  local.get $this
  local.get $left
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#set:right (param $this i32) (param $right i32)
  local.get $this
  local.get $right
  i32.store offset=8
  local.get $this
  local.get $right
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#constructor (param $this i32) (param $value i32) (result i32)
  (local $2 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $value
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#set:value
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#set:left
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#set:right
  local.get $this
  local.set $2
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $2
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/buildTree (param $depth i32) (param $startVal i32) (result i32)
  (local $node i32)
  (local $3 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  i32.const 12
  i32.const 13
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $startVal
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $node
  local.get $depth
  i32.const 0
  i32.gt_s
  if
   local.get $node
   i32.const 4
   call $~lib/rt/__tmptostack
   local.get $depth
   i32.const 1
   i32.sub
   local.get $startVal
   i32.const 2
   i32.mul
   call $tools/heap_analyzer/tests/fixture/dwarfFixture/buildTree
   i32.const 8
   call $~lib/rt/__tmptostack
   call $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#set:left
   local.get $node
   i32.const 4
   call $~lib/rt/__tmptostack
   local.get $depth
   i32.const 1
   i32.sub
   local.get $startVal
   i32.const 2
   i32.mul
   i32.const 1
   i32.add
   call $tools/heap_analyzer/tests/fixture/dwarfFixture/buildTree
   i32.const 8
   call $~lib/rt/__tmptostack
   call $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#set:right
  end
  local.get $node
  local.set $3
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $3
  return
  local.set $3
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/rt/__newBuffer (param $size i32) (param $id i32) (param $data i32) (result i32)
  (local $buffer i32)
  local.get $size
  local.get $id
  call $~lib/rt/itcms/__new
  local.set $buffer
  local.get $data
  if
   local.get $buffer
   local.get $data
   local.get $size
   memory.copy
  end
  local.get $buffer
  return
 )
 (func $~lib/rt/__newArray (param $length i32) (param $alignLog2 i32) (param $id i32) (param $data i32) (result i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (local $array i32)
  (local $7 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $length
  local.get $alignLog2
  i32.shl
  local.set $bufferSize
  local.get $bufferSize
  i32.const 1
  local.get $data
  call $~lib/rt/__newBuffer
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  i32.const 16
  local.get $id
  call $~lib/rt/itcms/__new
  local.set $array
  local.get $array
  local.get $buffer
  i32.store
  local.get $array
  local.get $buffer
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $array
  local.get $buffer
  i32.store offset=4
  local.get $array
  local.get $bufferSize
  i32.store offset=8
  local.get $array
  local.get $length
  i32.store offset=12
  local.get $array
  local.set $7
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $7
  return
  local.set $7
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $7
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#set:data (param $this i32) (param $data i32)
  local.get $this
  local.get $data
  i32.store
  local.get $this
  local.get $data
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#set:next (param $this i32) (param $next i32)
  local.get $this
  local.get $next
  i32.store offset=4
  local.get $this
  local.get $next
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#constructor (param $this i32) (param $data i32) (result i32)
  (local $2 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $data
  i32.const 4
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#set:data
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#set:next
  local.get $this
  local.set $2
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $2
 )
 (func $~lib/array/Array<~lib/string/String>#get:length_ (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/array/Array<~lib/string/String>#get:dataStart (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/array/Array<~lib/string/String>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (local $3 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $index
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#get:length_
  i32.ge_u
  if
   i32.const 608
   i32.const 1056
   i32.const 123
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#get:dataStart
  local.get $index
  i32.const 2
  i32.shl
  i32.add
  i32.load
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $value
  i32.const 1
  drop
  i32.const 0
  i32.eqz
  drop
  local.get $value
  i32.eqz
  if
   i32.const 2128
   i32.const 1056
   i32.const 127
   i32.const 40
   call $~lib/builtins/abort
   unreachable
  end
  local.get $value
  local.set $3
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $3
  return
  local.set $3
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/array/Array<~lib/string/String>#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#get:length_
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/buildLinkedList (param $items i32) (result i32)
  (local $head i32)
  (local $current i32)
  (local $i i32)
  (local $node i32)
  (local $5 i32)
  i32.const 20
  call $~lib/rt/__decrease_sp
  i32.const 8
  i32.const 25
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $items
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 0
  call $~lib/array/Array<~lib/string/String>#__get
  i32.const 4
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $head
  local.get $head
  i32.const 4
  call $~lib/rt/__localtostack
  local.set $current
  i32.const 1
  local.set $i
  loop $for-loop|0
   local.get $i
   local.get $items
   i32.const 8
   call $~lib/rt/__tmptostack
   call $~lib/array/Array<~lib/string/String>#get:length
   i32.lt_s
   if
    i32.const 8
    i32.const 25
    call $~lib/rt/itcms/__new
    i32.const 8
    call $~lib/rt/__tmptostack
    local.get $items
    i32.const 16
    call $~lib/rt/__tmptostack
    local.get $i
    call $~lib/array/Array<~lib/string/String>#__get
    i32.const 12
    call $~lib/rt/__tmptostack
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#constructor
    i32.const 8
    call $~lib/rt/__localtostack
    local.set $node
    local.get $current
    i32.const 12
    call $~lib/rt/__tmptostack
    local.get $node
    i32.const 16
    call $~lib/rt/__tmptostack
    call $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#set:next
    local.get $node
    i32.const 4
    call $~lib/rt/__localtostack
    local.set $current
    local.get $i
    i32.const 1
    i32.add
    local.set $i
    br $for-loop|0
   end
  end
  local.get $head
  local.set $5
  i32.const 20
  call $~lib/rt/__increase_sp
  local.get $5
  return
  local.set $5
  i32.const 20
  call $~lib/rt/__increase_sp
  local.get $5
 )
 (func $~lib/arraybuffer/ArrayBuffer#constructor (param $this i32) (param $length i32) (result i32)
  (local $buffer i32)
  (local $3 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $length
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
  local.get $length
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  local.get $buffer
  local.set $3
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $3
  return
  local.set $3
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/set/Set<i32>#set:buckets (param $this i32) (param $buckets i32)
  local.get $this
  local.get $buckets
  i32.store
  local.get $this
  local.get $buckets
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/set/Set<i32>#set:bucketsMask (param $this i32) (param $bucketsMask i32)
  local.get $this
  local.get $bucketsMask
  i32.store offset=4
 )
 (func $~lib/set/ENTRY_ALIGN<i32> (result i32)
  i32.const 3
  return
 )
 (func $~lib/set/ENTRY_SIZE<i32> (result i32)
  (local $align i32)
  (local $size i32)
  block $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$1 (result i32)
   i32.const 3
   br $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$1
  end
  local.set $align
  i32.const 8
  local.get $align
  i32.add
  local.get $align
  i32.const -1
  i32.xor
  i32.and
  local.set $size
  local.get $size
  return
 )
 (func $~lib/set/Set<i32>#set:entries (param $this i32) (param $entries i32)
  local.get $this
  local.get $entries
  i32.store offset=8
  local.get $this
  local.get $entries
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/set/Set<i32>#set:entriesCapacity (param $this i32) (param $entriesCapacity i32)
  local.get $this
  local.get $entriesCapacity
  i32.store offset=12
 )
 (func $~lib/set/Set<i32>#constructor (param $this i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#set:buckets
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 1
  i32.sub
  call $~lib/set/Set<i32>#set:bucketsMask
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  block $__inlined_func$~lib/set/ENTRY_SIZE<i32>$1 (result i32)
   i32.const 0
   local.set $1
   i32.const 0
   local.set $2
   block $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$1 (result i32)
    i32.const 3
    br $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$1
   end
   local.set $1
   i32.const 8
   local.get $1
   i32.add
   local.get $1
   i32.const -1
   i32.xor
   i32.and
   local.set $2
   local.get $2
   br $__inlined_func$~lib/set/ENTRY_SIZE<i32>$1
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#set:entries
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  call $~lib/set/Set<i32>#set:entriesCapacity
  local.get $this
  local.set $3
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/util/hash/hash32 (param $key i32) (param $len i32) (result i32)
  (local $h i32)
  i32.const 0
  i32.const 374761393
  i32.add
  local.get $len
  i32.add
  local.set $h
  local.get $h
  local.get $key
  i32.const -1028477379
  i32.mul
  i32.add
  local.set $h
  local.get $h
  i32.const 17
  i32.rotl
  i32.const 668265263
  i32.mul
  local.set $h
  local.get $h
  local.get $h
  i32.const 15
  i32.shr_u
  i32.xor
  local.set $h
  local.get $h
  i32.const -2048144777
  i32.mul
  local.set $h
  local.get $h
  local.get $h
  i32.const 13
  i32.shr_u
  i32.xor
  local.set $h
  local.get $h
  i32.const -1028477379
  i32.mul
  local.set $h
  local.get $h
  local.get $h
  i32.const 16
  i32.shr_u
  i32.xor
  local.set $h
  local.get $h
  return
 )
 (func $~lib/util/hash/HASH<i32> (param $key i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 0
  drop
  i32.const 0
  drop
  i32.const 0
  drop
  i32.const 4
  i32.const 4
  i32.le_u
  drop
  block $__inlined_func$~lib/util/hash/hash32$1 (result i32)
   local.get $key
   local.set $1
   i32.const 4
   local.set $2
   i32.const 0
   local.set $3
   i32.const 0
   i32.const 374761393
   i32.add
   local.get $2
   i32.add
   local.set $3
   local.get $3
   local.get $1
   i32.const -1028477379
   i32.mul
   i32.add
   local.set $3
   local.get $3
   i32.const 17
   i32.rotl
   i32.const 668265263
   i32.mul
   local.set $3
   local.get $3
   local.get $3
   i32.const 15
   i32.shr_u
   i32.xor
   local.set $3
   local.get $3
   i32.const -2048144777
   i32.mul
   local.set $3
   local.get $3
   local.get $3
   i32.const 13
   i32.shr_u
   i32.xor
   local.set $3
   local.get $3
   i32.const -1028477379
   i32.mul
   local.set $3
   local.get $3
   local.get $3
   i32.const 16
   i32.shr_u
   i32.xor
   local.set $3
   local.get $3
   br $__inlined_func$~lib/util/hash/hash32$1
  end
  return
 )
 (func $~lib/set/Set<i32>#get:buckets (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/set/Set<i32>#get:bucketsMask (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/set/SetEntry<i32>#get:taggedNext (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/set/SetEntry<i32>#get:key (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/set/Set<i32>#find (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
  (local $entry i32)
  (local $taggedNext i32)
  (local $5 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#get:buckets
  local.get $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#get:bucketsMask
  i32.and
  i32.const 4
  i32.mul
  i32.add
  i32.load
  local.set $entry
  block $while-break|0
   loop $while-continue|0
    local.get $entry
    if
     local.get $entry
     call $~lib/set/SetEntry<i32>#get:taggedNext
     local.set $taggedNext
     local.get $taggedNext
     i32.const 1
     i32.and
     i32.eqz
     if (result i32)
      local.get $entry
      call $~lib/set/SetEntry<i32>#get:key
      local.get $key
      i32.eq
     else
      i32.const 0
     end
     if
      local.get $entry
      local.set $5
      i32.const 4
      call $~lib/rt/__increase_sp
      local.get $5
      return
     end
     local.get $taggedNext
     i32.const 1
     i32.const -1
     i32.xor
     i32.and
     local.set $entry
     br $while-continue|0
    end
   end
  end
  i32.const 0
  local.set $5
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $5
  return
  local.set $5
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $5
 )
 (func $~lib/set/Set<i32>#get:entriesOffset (param $this i32) (result i32)
  local.get $this
  i32.load offset=16
 )
 (func $~lib/set/Set<i32>#get:entriesCapacity (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/set/Set<i32>#get:entriesCount (param $this i32) (result i32)
  local.get $this
  i32.load offset=20
 )
 (func $~lib/set/Set<i32>#get:entries (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $~lib/set/SetEntry<i32>#set:key (param $this i32) (param $key i32)
  local.get $this
  local.get $key
  i32.store
 )
 (func $~lib/set/SetEntry<i32>#set:taggedNext (param $this i32) (param $taggedNext i32)
  local.get $this
  local.get $taggedNext
  i32.store offset=4
 )
 (func $~lib/set/Set<i32>#set:entriesOffset (param $this i32) (param $entriesOffset i32)
  local.get $this
  local.get $entriesOffset
  i32.store offset=16
 )
 (func $~lib/set/Set<i32>#rehash (param $this i32) (param $newBucketsMask i32)
  (local $newBucketsCapacity i32)
  (local $newBuckets i32)
  (local $newEntriesCapacity i32)
  (local $newEntries i32)
  (local $oldPtr i32)
  (local $oldEnd i32)
  (local $newPtr i32)
  (local $oldEntry i32)
  (local $newEntry i32)
  (local $oldEntryKey i32)
  (local $newBucketIndex i32)
  (local $newBucketPtrBase i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $17 i32)
  (local $18 i32)
  (local $19 i32)
  (local $20 i32)
  (local $21 i32)
  i32.const 16
  call $~lib/rt/__decrease_sp
  local.get $newBucketsMask
  i32.const 1
  i32.add
  local.set $newBucketsCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $newBucketsCapacity
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $newBuckets
  local.get $newBucketsCapacity
  i32.const 8
  i32.mul
  i32.const 3
  i32.div_s
  local.set $newEntriesCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  block $__inlined_func$~lib/set/ENTRY_SIZE<i32>$1 (result i32)
   i32.const 0
   local.set $14
   i32.const 0
   local.set $15
   block $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$1 (result i32)
    i32.const 3
    br $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$1
   end
   local.set $14
   i32.const 8
   local.get $14
   i32.add
   local.get $14
   i32.const -1
   i32.xor
   i32.and
   local.set $15
   local.get $15
   br $__inlined_func$~lib/set/ENTRY_SIZE<i32>$1
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__localtostack
  local.set $newEntries
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#get:entries
  local.set $oldPtr
  local.get $oldPtr
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#get:entriesOffset
  block $__inlined_func$~lib/set/ENTRY_SIZE<i32>$2 (result i32)
   i32.const 0
   local.set $16
   i32.const 0
   local.set $17
   block $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$10 (result i32)
    i32.const 3
    br $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$10
   end
   local.set $16
   i32.const 8
   local.get $16
   i32.add
   local.get $16
   i32.const -1
   i32.xor
   i32.and
   local.set $17
   local.get $17
   br $__inlined_func$~lib/set/ENTRY_SIZE<i32>$2
  end
  i32.mul
  i32.add
  local.set $oldEnd
  local.get $newEntries
  local.set $newPtr
  block $while-break|0
   loop $while-continue|0
    local.get $oldPtr
    local.get $oldEnd
    i32.ne
    if
     local.get $oldPtr
     local.set $oldEntry
     local.get $oldEntry
     call $~lib/set/SetEntry<i32>#get:taggedNext
     i32.const 1
     i32.and
     i32.eqz
     if
      local.get $newPtr
      local.set $newEntry
      local.get $oldEntry
      call $~lib/set/SetEntry<i32>#get:key
      local.set $oldEntryKey
      local.get $newEntry
      local.get $oldEntryKey
      call $~lib/set/SetEntry<i32>#set:key
      local.get $oldEntryKey
      call $~lib/util/hash/HASH<i32>
      local.get $newBucketsMask
      i32.and
      local.set $newBucketIndex
      local.get $newBuckets
      local.get $newBucketIndex
      i32.const 4
      i32.mul
      i32.add
      local.set $newBucketPtrBase
      local.get $newEntry
      local.get $newBucketPtrBase
      i32.load
      call $~lib/set/SetEntry<i32>#set:taggedNext
      local.get $newBucketPtrBase
      local.get $newPtr
      i32.store
      local.get $newPtr
      block $__inlined_func$~lib/set/ENTRY_SIZE<i32>$3 (result i32)
       i32.const 0
       local.set $18
       i32.const 0
       local.set $19
       block $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$11 (result i32)
        i32.const 3
        br $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$11
       end
       local.set $18
       i32.const 8
       local.get $18
       i32.add
       local.get $18
       i32.const -1
       i32.xor
       i32.and
       local.set $19
       local.get $19
       br $__inlined_func$~lib/set/ENTRY_SIZE<i32>$3
      end
      i32.add
      local.set $newPtr
     end
     local.get $oldPtr
     block $__inlined_func$~lib/set/ENTRY_SIZE<i32>$4 (result i32)
      i32.const 0
      local.set $20
      i32.const 0
      local.set $21
      block $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$12 (result i32)
       i32.const 3
       br $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$12
      end
      local.set $20
      i32.const 8
      local.get $20
      i32.add
      local.get $20
      i32.const -1
      i32.xor
      i32.and
      local.set $21
      local.get $21
      br $__inlined_func$~lib/set/ENTRY_SIZE<i32>$4
     end
     i32.add
     local.set $oldPtr
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $newBuckets
  i32.const 12
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#set:buckets
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $newBucketsMask
  call $~lib/set/Set<i32>#set:bucketsMask
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $newEntries
  i32.const 12
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#set:entries
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  call $~lib/set/Set<i32>#set:entriesCapacity
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#get:entriesCount
  call $~lib/set/Set<i32>#set:entriesOffset
  i32.const 16
  call $~lib/rt/__increase_sp
 )
 (func $~lib/set/Set<i32>#set:entriesCount (param $this i32) (param $entriesCount i32)
  local.get $this
  local.get $entriesCount
  i32.store offset=20
 )
 (func $~lib/set/Set<i32>#add (param $this i32) (param $key i32) (result i32)
  (local $hashCode i32)
  (local $entry i32)
  (local $4 i32)
  (local $bucketPtrBase i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  local.get $key
  call $~lib/util/hash/HASH<i32>
  local.set $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $key
  local.get $hashCode
  call $~lib/set/Set<i32>#find
  local.set $entry
  local.get $entry
  i32.eqz
  if
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<i32>#get:entriesOffset
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<i32>#get:entriesCapacity
   i32.eq
   if
    local.get $this
    i32.const 0
    call $~lib/rt/__tmptostack
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $~lib/set/Set<i32>#get:entriesCount
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $~lib/set/Set<i32>#get:entriesCapacity
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $~lib/set/Set<i32>#get:bucketsMask
    else
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $~lib/set/Set<i32>#get:bucketsMask
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<i32>#rehash
   end
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<i32>#get:entries
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<i32>#get:entriesOffset
   local.tee $4
   i32.const 1
   i32.add
   call $~lib/set/Set<i32>#set:entriesOffset
   local.get $4
   block $__inlined_func$~lib/set/ENTRY_SIZE<i32>$1 (result i32)
    i32.const 0
    local.set $6
    i32.const 0
    local.set $7
    block $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$1 (result i32)
     i32.const 3
     br $__inlined_func$~lib/set/ENTRY_ALIGN<i32>$1
    end
    local.set $6
    i32.const 8
    local.get $6
    i32.add
    local.get $6
    i32.const -1
    i32.xor
    i32.and
    local.set $7
    local.get $7
    br $__inlined_func$~lib/set/ENTRY_SIZE<i32>$1
   end
   i32.mul
   i32.add
   local.set $entry
   local.get $entry
   local.get $key
   call $~lib/set/SetEntry<i32>#set:key
   i32.const 0
   drop
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<i32>#get:entriesCount
   i32.const 1
   i32.add
   call $~lib/set/Set<i32>#set:entriesCount
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<i32>#get:buckets
   local.get $hashCode
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<i32>#get:bucketsMask
   i32.and
   i32.const 4
   i32.mul
   i32.add
   local.set $bucketPtrBase
   local.get $entry
   local.get $bucketPtrBase
   i32.load
   call $~lib/set/SetEntry<i32>#set:taggedNext
   local.get $bucketPtrBase
   local.get $entry
   i32.store
  end
  local.get $this
  local.set $8
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $8
  return
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:buckets (param $this i32) (param $buckets i32)
  local.get $this
  local.get $buckets
  i32.store
  local.get $this
  local.get $buckets
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:bucketsMask (param $this i32) (param $bucketsMask i32)
  local.get $this
  local.get $bucketsMask
  i32.store offset=4
 )
 (func $~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item> (result i32)
  i32.const 3
  return
 )
 (func $~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item> (result i32)
  (local $align i32)
  (local $size i32)
  block $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1 (result i32)
   i32.const 3
   br $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1
  end
  local.set $align
  i32.const 8
  local.get $align
  i32.add
  local.get $align
  i32.const -1
  i32.xor
  i32.and
  local.set $size
  local.get $size
  return
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entries (param $this i32) (param $entries i32)
  local.get $this
  local.get $entries
  i32.store offset=8
  local.get $this
  local.get $entries
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entriesCapacity (param $this i32) (param $entriesCapacity i32)
  local.get $this
  local.get $entriesCapacity
  i32.store offset=12
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor (param $this i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:buckets
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 1
  i32.sub
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:bucketsMask
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  block $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1 (result i32)
   i32.const 0
   local.set $1
   i32.const 0
   local.set $2
   block $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1 (result i32)
    i32.const 3
    br $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1
   end
   local.set $1
   i32.const 8
   local.get $1
   i32.add
   local.get $1
   i32.const -1
   i32.xor
   i32.and
   local.set $2
   local.get $2
   br $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entries
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entriesCapacity
  local.get $this
  local.set $3
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/util/hash/HASH<tools/heap_analyzer/tests/fixture/dwarfFixture/Item> (param $key i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 0
  drop
  i32.const 1
  drop
  i32.const 4
  i32.const 4
  i32.eq
  drop
  block $__inlined_func$~lib/util/hash/hash32$1 (result i32)
   local.get $key
   local.set $1
   i32.const 4
   local.set $2
   i32.const 0
   local.set $3
   i32.const 0
   i32.const 374761393
   i32.add
   local.get $2
   i32.add
   local.set $3
   local.get $3
   local.get $1
   i32.const -1028477379
   i32.mul
   i32.add
   local.set $3
   local.get $3
   i32.const 17
   i32.rotl
   i32.const 668265263
   i32.mul
   local.set $3
   local.get $3
   local.get $3
   i32.const 15
   i32.shr_u
   i32.xor
   local.set $3
   local.get $3
   i32.const -2048144777
   i32.mul
   local.set $3
   local.get $3
   local.get $3
   i32.const 13
   i32.shr_u
   i32.xor
   local.set $3
   local.get $3
   i32.const -1028477379
   i32.mul
   local.set $3
   local.get $3
   local.get $3
   i32.const 16
   i32.shr_u
   i32.xor
   local.set $3
   local.get $3
   br $__inlined_func$~lib/util/hash/hash32$1
  end
  return
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:buckets (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:bucketsMask (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:taggedNext (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:key (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#find (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
  (local $entry i32)
  (local $taggedNext i32)
  (local $5 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:buckets
  local.get $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:bucketsMask
  i32.and
  i32.const 4
  i32.mul
  i32.add
  i32.load
  local.set $entry
  block $while-break|0
   loop $while-continue|0
    local.get $entry
    if
     local.get $entry
     call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:taggedNext
     local.set $taggedNext
     local.get $taggedNext
     i32.const 1
     i32.and
     i32.eqz
     if (result i32)
      local.get $entry
      call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:key
      local.get $key
      i32.eq
     else
      i32.const 0
     end
     if
      local.get $entry
      local.set $5
      i32.const 4
      call $~lib/rt/__increase_sp
      local.get $5
      return
     end
     local.get $taggedNext
     i32.const 1
     i32.const -1
     i32.xor
     i32.and
     local.set $entry
     br $while-continue|0
    end
   end
  end
  i32.const 0
  local.set $5
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $5
  return
  local.set $5
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $5
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesOffset (param $this i32) (result i32)
  local.get $this
  i32.load offset=16
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesCapacity (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesCount (param $this i32) (result i32)
  local.get $this
  i32.load offset=20
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entries (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:key (param $this i32) (param $key i32)
  local.get $this
  local.get $key
  i32.store
 )
 (func $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:taggedNext (param $this i32) (param $taggedNext i32)
  local.get $this
  local.get $taggedNext
  i32.store offset=4
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entriesOffset (param $this i32) (param $entriesOffset i32)
  local.get $this
  local.get $entriesOffset
  i32.store offset=16
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#rehash (param $this i32) (param $newBucketsMask i32)
  (local $newBucketsCapacity i32)
  (local $newBuckets i32)
  (local $newEntriesCapacity i32)
  (local $newEntries i32)
  (local $oldPtr i32)
  (local $oldEnd i32)
  (local $newPtr i32)
  (local $oldEntry i32)
  (local $newEntry i32)
  (local $oldEntryKey i32)
  (local $newBucketIndex i32)
  (local $newBucketPtrBase i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $17 i32)
  (local $18 i32)
  (local $19 i32)
  (local $20 i32)
  (local $21 i32)
  i32.const 20
  call $~lib/rt/__decrease_sp
  local.get $newBucketsMask
  i32.const 1
  i32.add
  local.set $newBucketsCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $newBucketsCapacity
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $newBuckets
  local.get $newBucketsCapacity
  i32.const 8
  i32.mul
  i32.const 3
  i32.div_s
  local.set $newEntriesCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  block $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1 (result i32)
   i32.const 0
   local.set $14
   i32.const 0
   local.set $15
   block $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1 (result i32)
    i32.const 3
    br $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1
   end
   local.set $14
   i32.const 8
   local.get $14
   i32.add
   local.get $14
   i32.const -1
   i32.xor
   i32.and
   local.set $15
   local.get $15
   br $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__localtostack
  local.set $newEntries
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entries
  local.set $oldPtr
  local.get $oldPtr
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesOffset
  block $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$2 (result i32)
   i32.const 0
   local.set $16
   i32.const 0
   local.set $17
   block $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$10 (result i32)
    i32.const 3
    br $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$10
   end
   local.set $16
   i32.const 8
   local.get $16
   i32.add
   local.get $16
   i32.const -1
   i32.xor
   i32.and
   local.set $17
   local.get $17
   br $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$2
  end
  i32.mul
  i32.add
  local.set $oldEnd
  local.get $newEntries
  local.set $newPtr
  block $while-break|0
   loop $while-continue|0
    local.get $oldPtr
    local.get $oldEnd
    i32.ne
    if
     local.get $oldPtr
     local.set $oldEntry
     local.get $oldEntry
     call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:taggedNext
     i32.const 1
     i32.and
     i32.eqz
     if
      local.get $newPtr
      local.set $newEntry
      local.get $oldEntry
      call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:key
      i32.const 8
      call $~lib/rt/__localtostack
      local.set $oldEntryKey
      local.get $newEntry
      local.get $oldEntryKey
      i32.const 12
      call $~lib/rt/__tmptostack
      call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:key
      local.get $oldEntryKey
      i32.const 12
      call $~lib/rt/__tmptostack
      call $~lib/util/hash/HASH<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>
      local.get $newBucketsMask
      i32.and
      local.set $newBucketIndex
      local.get $newBuckets
      local.get $newBucketIndex
      i32.const 4
      i32.mul
      i32.add
      local.set $newBucketPtrBase
      local.get $newEntry
      local.get $newBucketPtrBase
      i32.load
      call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:taggedNext
      local.get $newBucketPtrBase
      local.get $newPtr
      i32.store
      local.get $newPtr
      block $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$3 (result i32)
       i32.const 0
       local.set $18
       i32.const 0
       local.set $19
       block $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$11 (result i32)
        i32.const 3
        br $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$11
       end
       local.set $18
       i32.const 8
       local.get $18
       i32.add
       local.get $18
       i32.const -1
       i32.xor
       i32.and
       local.set $19
       local.get $19
       br $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$3
      end
      i32.add
      local.set $newPtr
     end
     local.get $oldPtr
     block $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$4 (result i32)
      i32.const 0
      local.set $20
      i32.const 0
      local.set $21
      block $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$12 (result i32)
       i32.const 3
       br $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$12
      end
      local.set $20
      i32.const 8
      local.get $20
      i32.add
      local.get $20
      i32.const -1
      i32.xor
      i32.and
      local.set $21
      local.get $21
      br $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$4
     end
     i32.add
     local.set $oldPtr
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newBuckets
  i32.const 16
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:buckets
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newBucketsMask
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:bucketsMask
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newEntries
  i32.const 16
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entries
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entriesCapacity
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $this
  i32.const 16
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesCount
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entriesOffset
  i32.const 20
  call $~lib/rt/__increase_sp
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entriesCount (param $this i32) (param $entriesCount i32)
  local.get $this
  local.get $entriesCount
  i32.store offset=20
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#add (param $this i32) (param $key i32) (result i32)
  (local $hashCode i32)
  (local $entry i32)
  (local $4 i32)
  (local $bucketPtrBase i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  local.get $key
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/util/hash/HASH<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>
  local.set $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $key
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $hashCode
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#find
  local.set $entry
  local.get $entry
  i32.eqz
  if
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesOffset
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesCapacity
   i32.eq
   if
    local.get $this
    i32.const 0
    call $~lib/rt/__tmptostack
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesCount
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesCapacity
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:bucketsMask
    else
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:bucketsMask
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#rehash
   end
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entries
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesOffset
   local.tee $4
   i32.const 1
   i32.add
   call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entriesOffset
   local.get $4
   block $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1 (result i32)
    i32.const 0
    local.set $6
    i32.const 0
    local.set $7
    block $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1 (result i32)
     i32.const 3
     br $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1
    end
    local.set $6
    i32.const 8
    local.get $6
    i32.add
    local.get $6
    i32.const -1
    i32.xor
    i32.and
    local.set $7
    local.get $7
    br $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1
   end
   i32.mul
   i32.add
   local.set $entry
   local.get $entry
   local.get $key
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:key
   i32.const 1
   drop
   local.get $this
   local.get $key
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesCount
   i32.const 1
   i32.add
   call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:entriesCount
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:buckets
   local.get $hashCode
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:bucketsMask
   i32.and
   i32.const 4
   i32.mul
   i32.add
   local.set $bucketPtrBase
   local.get $entry
   local.get $bucketPtrBase
   i32.load
   call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#set:taggedNext
   local.get $bucketPtrBase
   local.get $entry
   i32.store
  end
  local.get $this
  local.set $8
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $8
  return
 )
 (func $"~lib/map/Map<i32,i32>#set:buckets" (param $this i32) (param $buckets i32)
  local.get $this
  local.get $buckets
  i32.store
  local.get $this
  local.get $buckets
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $"~lib/map/Map<i32,i32>#set:bucketsMask" (param $this i32) (param $bucketsMask i32)
  local.get $this
  local.get $bucketsMask
  i32.store offset=4
 )
 (func $"~lib/map/ENTRY_ALIGN<i32,i32>" (result i32)
  i32.const 3
  return
 )
 (func $"~lib/map/ENTRY_SIZE<i32,i32>" (result i32)
  (local $align i32)
  (local $size i32)
  block $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$1" (result i32)
   i32.const 3
   br $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$1"
  end
  local.set $align
  i32.const 12
  local.get $align
  i32.add
  local.get $align
  i32.const -1
  i32.xor
  i32.and
  local.set $size
  local.get $size
  return
 )
 (func $"~lib/map/Map<i32,i32>#set:entries" (param $this i32) (param $entries i32)
  local.get $this
  local.get $entries
  i32.store offset=8
  local.get $this
  local.get $entries
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $"~lib/map/Map<i32,i32>#set:entriesCapacity" (param $this i32) (param $entriesCapacity i32)
  local.get $this
  local.get $entriesCapacity
  i32.store offset=12
 )
 (func $"~lib/map/Map<i32,i32>#constructor" (param $this i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#set:buckets"
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 1
  i32.sub
  call $"~lib/map/Map<i32,i32>#set:bucketsMask"
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  block $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$1" (result i32)
   i32.const 0
   local.set $1
   i32.const 0
   local.set $2
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$1" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$1"
   end
   local.set $1
   i32.const 12
   local.get $1
   i32.add
   local.get $1
   i32.const -1
   i32.xor
   i32.and
   local.set $2
   local.get $2
   br $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$1"
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#set:entries"
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  call $"~lib/map/Map<i32,i32>#set:entriesCapacity"
  local.get $this
  local.set $3
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $"~lib/map/Map<i32,i32>#get:buckets" (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $"~lib/map/Map<i32,i32>#get:bucketsMask" (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $"~lib/map/MapEntry<i32,i32>#get:taggedNext" (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $"~lib/map/MapEntry<i32,i32>#get:key" (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $"~lib/map/Map<i32,i32>#find" (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
  (local $entry i32)
  (local $taggedNext i32)
  (local $5 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#get:buckets"
  local.get $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#get:bucketsMask"
  i32.and
  i32.const 4
  i32.mul
  i32.add
  i32.load
  local.set $entry
  block $while-break|0
   loop $while-continue|0
    local.get $entry
    if
     local.get $entry
     call $"~lib/map/MapEntry<i32,i32>#get:taggedNext"
     local.set $taggedNext
     local.get $taggedNext
     i32.const 1
     i32.and
     i32.eqz
     if (result i32)
      local.get $entry
      call $"~lib/map/MapEntry<i32,i32>#get:key"
      local.get $key
      i32.eq
     else
      i32.const 0
     end
     if
      local.get $entry
      local.set $5
      i32.const 4
      call $~lib/rt/__increase_sp
      local.get $5
      return
     end
     local.get $taggedNext
     i32.const 1
     i32.const -1
     i32.xor
     i32.and
     local.set $entry
     br $while-continue|0
    end
   end
  end
  i32.const 0
  local.set $5
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $5
  return
  local.set $5
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $5
 )
 (func $"~lib/map/MapEntry<i32,i32>#set:value" (param $this i32) (param $value i32)
  local.get $this
  local.get $value
  i32.store offset=4
 )
 (func $"~lib/map/Map<i32,i32>#get:entriesOffset" (param $this i32) (result i32)
  local.get $this
  i32.load offset=16
 )
 (func $"~lib/map/Map<i32,i32>#get:entriesCapacity" (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $"~lib/map/Map<i32,i32>#get:entriesCount" (param $this i32) (result i32)
  local.get $this
  i32.load offset=20
 )
 (func $"~lib/map/Map<i32,i32>#get:entries" (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $"~lib/map/MapEntry<i32,i32>#set:key" (param $this i32) (param $key i32)
  local.get $this
  local.get $key
  i32.store
 )
 (func $"~lib/map/MapEntry<i32,i32>#get:value" (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $"~lib/map/MapEntry<i32,i32>#set:taggedNext" (param $this i32) (param $taggedNext i32)
  local.get $this
  local.get $taggedNext
  i32.store offset=8
 )
 (func $"~lib/map/Map<i32,i32>#set:entriesOffset" (param $this i32) (param $entriesOffset i32)
  local.get $this
  local.get $entriesOffset
  i32.store offset=16
 )
 (func $"~lib/map/Map<i32,i32>#rehash" (param $this i32) (param $newBucketsMask i32)
  (local $newBucketsCapacity i32)
  (local $newBuckets i32)
  (local $newEntriesCapacity i32)
  (local $newEntries i32)
  (local $oldPtr i32)
  (local $oldEnd i32)
  (local $newPtr i32)
  (local $oldEntry i32)
  (local $newEntry i32)
  (local $oldEntryKey i32)
  (local $newBucketIndex i32)
  (local $newBucketPtrBase i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $17 i32)
  (local $18 i32)
  (local $19 i32)
  (local $20 i32)
  (local $21 i32)
  i32.const 16
  call $~lib/rt/__decrease_sp
  local.get $newBucketsMask
  i32.const 1
  i32.add
  local.set $newBucketsCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $newBucketsCapacity
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $newBuckets
  local.get $newBucketsCapacity
  i32.const 8
  i32.mul
  i32.const 3
  i32.div_s
  local.set $newEntriesCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  block $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$1" (result i32)
   i32.const 0
   local.set $14
   i32.const 0
   local.set $15
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$1" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$1"
   end
   local.set $14
   i32.const 12
   local.get $14
   i32.add
   local.get $14
   i32.const -1
   i32.xor
   i32.and
   local.set $15
   local.get $15
   br $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$1"
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__localtostack
  local.set $newEntries
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#get:entries"
  local.set $oldPtr
  local.get $oldPtr
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#get:entriesOffset"
  block $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$2" (result i32)
   i32.const 0
   local.set $16
   i32.const 0
   local.set $17
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$10" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$10"
   end
   local.set $16
   i32.const 12
   local.get $16
   i32.add
   local.get $16
   i32.const -1
   i32.xor
   i32.and
   local.set $17
   local.get $17
   br $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$2"
  end
  i32.mul
  i32.add
  local.set $oldEnd
  local.get $newEntries
  local.set $newPtr
  block $while-break|0
   loop $while-continue|0
    local.get $oldPtr
    local.get $oldEnd
    i32.ne
    if
     local.get $oldPtr
     local.set $oldEntry
     local.get $oldEntry
     call $"~lib/map/MapEntry<i32,i32>#get:taggedNext"
     i32.const 1
     i32.and
     i32.eqz
     if
      local.get $newPtr
      local.set $newEntry
      local.get $oldEntry
      call $"~lib/map/MapEntry<i32,i32>#get:key"
      local.set $oldEntryKey
      local.get $newEntry
      local.get $oldEntryKey
      call $"~lib/map/MapEntry<i32,i32>#set:key"
      local.get $newEntry
      local.get $oldEntry
      call $"~lib/map/MapEntry<i32,i32>#get:value"
      call $"~lib/map/MapEntry<i32,i32>#set:value"
      local.get $oldEntryKey
      call $~lib/util/hash/HASH<i32>
      local.get $newBucketsMask
      i32.and
      local.set $newBucketIndex
      local.get $newBuckets
      local.get $newBucketIndex
      i32.const 4
      i32.mul
      i32.add
      local.set $newBucketPtrBase
      local.get $newEntry
      local.get $newBucketPtrBase
      i32.load
      call $"~lib/map/MapEntry<i32,i32>#set:taggedNext"
      local.get $newBucketPtrBase
      local.get $newPtr
      i32.store
      local.get $newPtr
      block $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$3" (result i32)
       i32.const 0
       local.set $18
       i32.const 0
       local.set $19
       block $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$11" (result i32)
        i32.const 3
        br $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$11"
       end
       local.set $18
       i32.const 12
       local.get $18
       i32.add
       local.get $18
       i32.const -1
       i32.xor
       i32.and
       local.set $19
       local.get $19
       br $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$3"
      end
      i32.add
      local.set $newPtr
     end
     local.get $oldPtr
     block $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$4" (result i32)
      i32.const 0
      local.set $20
      i32.const 0
      local.set $21
      block $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$12" (result i32)
       i32.const 3
       br $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$12"
      end
      local.set $20
      i32.const 12
      local.get $20
      i32.add
      local.get $20
      i32.const -1
      i32.xor
      i32.and
      local.set $21
      local.get $21
      br $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$4"
     end
     i32.add
     local.set $oldPtr
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $newBuckets
  i32.const 12
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#set:buckets"
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $newBucketsMask
  call $"~lib/map/Map<i32,i32>#set:bucketsMask"
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $newEntries
  i32.const 12
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#set:entries"
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  call $"~lib/map/Map<i32,i32>#set:entriesCapacity"
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#get:entriesCount"
  call $"~lib/map/Map<i32,i32>#set:entriesOffset"
  i32.const 16
  call $~lib/rt/__increase_sp
 )
 (func $"~lib/map/Map<i32,i32>#set:entriesCount" (param $this i32) (param $entriesCount i32)
  local.get $this
  local.get $entriesCount
  i32.store offset=20
 )
 (func $"~lib/map/Map<i32,i32>#set" (param $this i32) (param $key i32) (param $value i32) (result i32)
  (local $hashCode i32)
  (local $entry i32)
  (local $entries i32)
  (local $6 i32)
  (local $bucketPtrBase i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  local.get $key
  call $~lib/util/hash/HASH<i32>
  local.set $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $key
  local.get $hashCode
  call $"~lib/map/Map<i32,i32>#find"
  local.set $entry
  local.get $entry
  if
   local.get $entry
   local.get $value
   call $"~lib/map/MapEntry<i32,i32>#set:value"
   i32.const 0
   drop
  else
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<i32,i32>#get:entriesOffset"
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<i32,i32>#get:entriesCapacity"
   i32.eq
   if
    local.get $this
    i32.const 0
    call $~lib/rt/__tmptostack
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $"~lib/map/Map<i32,i32>#get:entriesCount"
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $"~lib/map/Map<i32,i32>#get:entriesCapacity"
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $"~lib/map/Map<i32,i32>#get:bucketsMask"
    else
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $"~lib/map/Map<i32,i32>#get:bucketsMask"
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $"~lib/map/Map<i32,i32>#rehash"
   end
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<i32,i32>#get:entries"
   i32.const 0
   call $~lib/rt/__localtostack
   local.set $entries
   local.get $entries
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 8
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<i32,i32>#get:entriesOffset"
   local.tee $6
   i32.const 1
   i32.add
   call $"~lib/map/Map<i32,i32>#set:entriesOffset"
   local.get $6
   block $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$1" (result i32)
    i32.const 0
    local.set $8
    i32.const 0
    local.set $9
    block $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$1" (result i32)
     i32.const 3
     br $"__inlined_func$~lib/map/ENTRY_ALIGN<i32,i32>$1"
    end
    local.set $8
    i32.const 12
    local.get $8
    i32.add
    local.get $8
    i32.const -1
    i32.xor
    i32.and
    local.set $9
    local.get $9
    br $"__inlined_func$~lib/map/ENTRY_SIZE<i32,i32>$1"
   end
   i32.mul
   i32.add
   local.set $entry
   local.get $entry
   local.get $key
   call $"~lib/map/MapEntry<i32,i32>#set:key"
   i32.const 0
   drop
   local.get $entry
   local.get $value
   call $"~lib/map/MapEntry<i32,i32>#set:value"
   i32.const 0
   drop
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 8
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<i32,i32>#get:entriesCount"
   i32.const 1
   i32.add
   call $"~lib/map/Map<i32,i32>#set:entriesCount"
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<i32,i32>#get:buckets"
   local.get $hashCode
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<i32,i32>#get:bucketsMask"
   i32.and
   i32.const 4
   i32.mul
   i32.add
   local.set $bucketPtrBase
   local.get $entry
   local.get $bucketPtrBase
   i32.load
   call $"~lib/map/MapEntry<i32,i32>#set:taggedNext"
   local.get $bucketPtrBase
   local.get $entry
   i32.store
  end
  local.get $this
  local.set $10
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $10
  return
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:buckets" (param $this i32) (param $buckets i32)
  local.get $this
  local.get $buckets
  i32.store
  local.get $this
  local.get $buckets
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:bucketsMask" (param $this i32) (param $bucketsMask i32)
  local.get $this
  local.get $bucketsMask
  i32.store offset=4
 )
 (func $"~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>" (result i32)
  i32.const 3
  return
 )
 (func $"~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>" (result i32)
  (local $align i32)
  (local $size i32)
  block $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1" (result i32)
   i32.const 3
   br $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1"
  end
  local.set $align
  i32.const 12
  local.get $align
  i32.add
  local.get $align
  i32.const -1
  i32.xor
  i32.and
  local.set $size
  local.get $size
  return
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entries" (param $this i32) (param $entries i32)
  local.get $this
  local.get $entries
  i32.store offset=8
  local.get $this
  local.get $entries
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entriesCapacity" (param $this i32) (param $entriesCapacity i32)
  local.get $this
  local.get $entriesCapacity
  i32.store offset=12
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#constructor" (param $this i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:buckets"
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 1
  i32.sub
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:bucketsMask"
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  block $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1" (result i32)
   i32.const 0
   local.set $1
   i32.const 0
   local.set $2
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1"
   end
   local.set $1
   i32.const 12
   local.get $1
   i32.add
   local.get $1
   i32.const -1
   i32.xor
   i32.and
   local.set $2
   local.get $2
   br $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1"
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entries"
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entriesCapacity"
  local.get $this
  local.set $3
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/util/hash/mix (param $h i32) (param $key i32) (result i32)
  local.get $h
  local.get $key
  i32.const -2048144777
  i32.mul
  i32.add
  i32.const 13
  i32.rotl
  i32.const -1640531535
  i32.mul
  return
 )
 (func $~lib/util/hash/hashStr (param $key i32) (result i32)
  (local $h i32)
  (local $len i32)
  (local $pos i32)
  (local $s1 i32)
  (local $s2 i32)
  (local $s3 i32)
  (local $s4 i32)
  (local $end i32)
  (local $end|9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $13 i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $17 i32)
  (local $18 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $key
  i32.const 0
  i32.eq
  if
   i32.const 0
   local.set $18
   i32.const 4
   call $~lib/rt/__increase_sp
   local.get $18
   return
  end
  local.get $key
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/string/String#get:length
  i32.const 1
  i32.shl
  local.set $h
  local.get $h
  local.set $len
  local.get $key
  local.set $pos
  local.get $len
  i32.const 16
  i32.ge_u
  if
   i32.const 0
   i32.const -1640531535
   i32.add
   i32.const -2048144777
   i32.add
   local.set $s1
   i32.const 0
   i32.const -2048144777
   i32.add
   local.set $s2
   i32.const 0
   local.set $s3
   i32.const 0
   i32.const -1640531535
   i32.sub
   local.set $s4
   local.get $len
   local.get $pos
   i32.add
   i32.const 16
   i32.sub
   local.set $end
   block $while-break|0
    loop $while-continue|0
     local.get $pos
     local.get $end
     i32.le_u
     if
      block $__inlined_func$~lib/util/hash/mix$1 (result i32)
       local.get $s1
       local.set $10
       local.get $pos
       i32.load
       local.set $11
       local.get $10
       local.get $11
       i32.const -2048144777
       i32.mul
       i32.add
       i32.const 13
       i32.rotl
       i32.const -1640531535
       i32.mul
       br $__inlined_func$~lib/util/hash/mix$1
      end
      local.set $s1
      block $__inlined_func$~lib/util/hash/mix$2 (result i32)
       local.get $s2
       local.set $12
       local.get $pos
       i32.load offset=4
       local.set $13
       local.get $12
       local.get $13
       i32.const -2048144777
       i32.mul
       i32.add
       i32.const 13
       i32.rotl
       i32.const -1640531535
       i32.mul
       br $__inlined_func$~lib/util/hash/mix$2
      end
      local.set $s2
      block $__inlined_func$~lib/util/hash/mix$3 (result i32)
       local.get $s3
       local.set $14
       local.get $pos
       i32.load offset=8
       local.set $15
       local.get $14
       local.get $15
       i32.const -2048144777
       i32.mul
       i32.add
       i32.const 13
       i32.rotl
       i32.const -1640531535
       i32.mul
       br $__inlined_func$~lib/util/hash/mix$3
      end
      local.set $s3
      block $__inlined_func$~lib/util/hash/mix$4 (result i32)
       local.get $s4
       local.set $16
       local.get $pos
       i32.load offset=12
       local.set $17
       local.get $16
       local.get $17
       i32.const -2048144777
       i32.mul
       i32.add
       i32.const 13
       i32.rotl
       i32.const -1640531535
       i32.mul
       br $__inlined_func$~lib/util/hash/mix$4
      end
      local.set $s4
      local.get $pos
      i32.const 16
      i32.add
      local.set $pos
      br $while-continue|0
     end
    end
   end
   local.get $h
   local.get $s1
   i32.const 1
   i32.rotl
   local.get $s2
   i32.const 7
   i32.rotl
   i32.add
   local.get $s3
   i32.const 12
   i32.rotl
   i32.add
   local.get $s4
   i32.const 18
   i32.rotl
   i32.add
   i32.add
   local.set $h
  else
   local.get $h
   i32.const 0
   i32.const 374761393
   i32.add
   i32.add
   local.set $h
  end
  local.get $key
  local.get $len
  i32.add
  i32.const 4
  i32.sub
  local.set $end|9
  block $while-break|1
   loop $while-continue|1
    local.get $pos
    local.get $end|9
    i32.le_u
    if
     local.get $h
     local.get $pos
     i32.load
     i32.const -1028477379
     i32.mul
     i32.add
     local.set $h
     local.get $h
     i32.const 17
     i32.rotl
     i32.const 668265263
     i32.mul
     local.set $h
     local.get $pos
     i32.const 4
     i32.add
     local.set $pos
     br $while-continue|1
    end
   end
  end
  local.get $key
  local.get $len
  i32.add
  local.set $end|9
  block $while-break|2
   loop $while-continue|2
    local.get $pos
    local.get $end|9
    i32.lt_u
    if
     local.get $h
     local.get $pos
     i32.load8_u
     i32.const 374761393
     i32.mul
     i32.add
     local.set $h
     local.get $h
     i32.const 11
     i32.rotl
     i32.const -1640531535
     i32.mul
     local.set $h
     local.get $pos
     i32.const 1
     i32.add
     local.set $pos
     br $while-continue|2
    end
   end
  end
  local.get $h
  local.get $h
  i32.const 15
  i32.shr_u
  i32.xor
  local.set $h
  local.get $h
  i32.const -2048144777
  i32.mul
  local.set $h
  local.get $h
  local.get $h
  i32.const 13
  i32.shr_u
  i32.xor
  local.set $h
  local.get $h
  i32.const -1028477379
  i32.mul
  local.set $h
  local.get $h
  local.get $h
  i32.const 16
  i32.shr_u
  i32.xor
  local.set $h
  local.get $h
  local.set $18
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $18
  return
 )
 (func $~lib/util/hash/HASH<~lib/string/String> (param $key i32) (result i32)
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
  i32.const 8
  call $~lib/rt/__decrease_sp
  i32.const 1
  drop
  block $__inlined_func$~lib/util/hash/hashStr$1 (result i32)
   local.get $key
   i32.const 0
   call $~lib/rt/__tmptostack
   local.set $1
   i32.const 0
   local.set $2
   i32.const 0
   local.set $3
   i32.const 0
   local.set $4
   i32.const 0
   local.set $5
   i32.const 0
   local.set $6
   i32.const 0
   local.set $7
   i32.const 0
   local.set $8
   i32.const 0
   local.set $9
   i32.const 0
   local.set $10
   i32.const 0
   local.set $11
   i32.const 0
   local.set $12
   i32.const 0
   local.set $13
   i32.const 0
   local.set $14
   i32.const 0
   local.set $15
   i32.const 0
   local.set $16
   i32.const 0
   local.set $17
   i32.const 0
   local.set $18
   local.get $1
   i32.const 0
   i32.eq
   if
    i32.const 0
    br $__inlined_func$~lib/util/hash/hashStr$1
   end
   local.get $1
   i32.const 4
   call $~lib/rt/__tmptostack
   call $~lib/string/String#get:length
   i32.const 1
   i32.shl
   local.set $2
   local.get $2
   local.set $3
   local.get $1
   local.set $4
   local.get $3
   i32.const 16
   i32.ge_u
   if
    i32.const 0
    i32.const -1640531535
    i32.add
    i32.const -2048144777
    i32.add
    local.set $5
    i32.const 0
    i32.const -2048144777
    i32.add
    local.set $6
    i32.const 0
    local.set $7
    i32.const 0
    i32.const -1640531535
    i32.sub
    local.set $8
    local.get $3
    local.get $4
    i32.add
    i32.const 16
    i32.sub
    local.set $9
    block $while-break|0
     loop $while-continue|0
      local.get $4
      local.get $9
      i32.le_u
      if
       block $__inlined_func$~lib/util/hash/mix$1 (result i32)
        local.get $5
        local.set $11
        local.get $4
        i32.load
        local.set $12
        local.get $11
        local.get $12
        i32.const -2048144777
        i32.mul
        i32.add
        i32.const 13
        i32.rotl
        i32.const -1640531535
        i32.mul
        br $__inlined_func$~lib/util/hash/mix$1
       end
       local.set $5
       block $__inlined_func$~lib/util/hash/mix$2 (result i32)
        local.get $6
        local.set $13
        local.get $4
        i32.load offset=4
        local.set $14
        local.get $13
        local.get $14
        i32.const -2048144777
        i32.mul
        i32.add
        i32.const 13
        i32.rotl
        i32.const -1640531535
        i32.mul
        br $__inlined_func$~lib/util/hash/mix$2
       end
       local.set $6
       block $__inlined_func$~lib/util/hash/mix$3 (result i32)
        local.get $7
        local.set $15
        local.get $4
        i32.load offset=8
        local.set $16
        local.get $15
        local.get $16
        i32.const -2048144777
        i32.mul
        i32.add
        i32.const 13
        i32.rotl
        i32.const -1640531535
        i32.mul
        br $__inlined_func$~lib/util/hash/mix$3
       end
       local.set $7
       block $__inlined_func$~lib/util/hash/mix$4 (result i32)
        local.get $8
        local.set $17
        local.get $4
        i32.load offset=12
        local.set $18
        local.get $17
        local.get $18
        i32.const -2048144777
        i32.mul
        i32.add
        i32.const 13
        i32.rotl
        i32.const -1640531535
        i32.mul
        br $__inlined_func$~lib/util/hash/mix$4
       end
       local.set $8
       local.get $4
       i32.const 16
       i32.add
       local.set $4
       br $while-continue|0
      end
     end
    end
    local.get $2
    local.get $5
    i32.const 1
    i32.rotl
    local.get $6
    i32.const 7
    i32.rotl
    i32.add
    local.get $7
    i32.const 12
    i32.rotl
    i32.add
    local.get $8
    i32.const 18
    i32.rotl
    i32.add
    i32.add
    local.set $2
   else
    local.get $2
    i32.const 0
    i32.const 374761393
    i32.add
    i32.add
    local.set $2
   end
   local.get $1
   local.get $3
   i32.add
   i32.const 4
   i32.sub
   local.set $10
   block $while-break|1
    loop $while-continue|1
     local.get $4
     local.get $10
     i32.le_u
     if
      local.get $2
      local.get $4
      i32.load
      i32.const -1028477379
      i32.mul
      i32.add
      local.set $2
      local.get $2
      i32.const 17
      i32.rotl
      i32.const 668265263
      i32.mul
      local.set $2
      local.get $4
      i32.const 4
      i32.add
      local.set $4
      br $while-continue|1
     end
    end
   end
   local.get $1
   local.get $3
   i32.add
   local.set $10
   block $while-break|2
    loop $while-continue|2
     local.get $4
     local.get $10
     i32.lt_u
     if
      local.get $2
      local.get $4
      i32.load8_u
      i32.const 374761393
      i32.mul
      i32.add
      local.set $2
      local.get $2
      i32.const 11
      i32.rotl
      i32.const -1640531535
      i32.mul
      local.set $2
      local.get $4
      i32.const 1
      i32.add
      local.set $4
      br $while-continue|2
     end
    end
   end
   local.get $2
   local.get $2
   i32.const 15
   i32.shr_u
   i32.xor
   local.set $2
   local.get $2
   i32.const -2048144777
   i32.mul
   local.set $2
   local.get $2
   local.get $2
   i32.const 13
   i32.shr_u
   i32.xor
   local.set $2
   local.get $2
   i32.const -1028477379
   i32.mul
   local.set $2
   local.get $2
   local.get $2
   i32.const 16
   i32.shr_u
   i32.xor
   local.set $2
   local.get $2
   br $__inlined_func$~lib/util/hash/hashStr$1
  end
  local.set $19
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $19
  return
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:buckets" (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:bucketsMask" (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:taggedNext" (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:key" (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/util/string/compareImpl (param $str1 i32) (param $index1 i32) (param $str2 i32) (param $index2 i32) (param $len i32) (result i32)
  (local $ptr1 i32)
  (local $ptr2 i32)
  (local $7 i32)
  (local $a i32)
  (local $b i32)
  local.get $str1
  local.get $index1
  i32.const 1
  i32.shl
  i32.add
  local.set $ptr1
  local.get $str2
  local.get $index2
  i32.const 1
  i32.shl
  i32.add
  local.set $ptr2
  i32.const 0
  i32.const 2
  i32.lt_s
  drop
  local.get $len
  i32.const 4
  i32.ge_u
  if (result i32)
   local.get $ptr1
   i32.const 7
   i32.and
   local.get $ptr2
   i32.const 7
   i32.and
   i32.or
   i32.eqz
  else
   i32.const 0
  end
  if
   block $do-break|0
    loop $do-loop|0
     local.get $ptr1
     i64.load
     local.get $ptr2
     i64.load
     i64.ne
     if
      br $do-break|0
     end
     local.get $ptr1
     i32.const 8
     i32.add
     local.set $ptr1
     local.get $ptr2
     i32.const 8
     i32.add
     local.set $ptr2
     local.get $len
     i32.const 4
     i32.sub
     local.set $len
     local.get $len
     i32.const 4
     i32.ge_u
     br_if $do-loop|0
    end
   end
  end
  block $while-break|1
   loop $while-continue|1
    local.get $len
    local.tee $7
    i32.const 1
    i32.sub
    local.set $len
    local.get $7
    if
     local.get $ptr1
     i32.load16_u
     local.set $a
     local.get $ptr2
     i32.load16_u
     local.set $b
     local.get $a
     local.get $b
     i32.ne
     if
      local.get $a
      local.get $b
      i32.sub
      return
     end
     local.get $ptr1
     i32.const 2
     i32.add
     local.set $ptr1
     local.get $ptr2
     i32.const 2
     i32.add
     local.set $ptr2
     br $while-continue|1
    end
   end
  end
  i32.const 0
  return
 )
 (func $~lib/string/String.__eq (param $left i32) (param $right i32) (result i32)
  (local $leftLength i32)
  (local $3 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  local.get $left
  local.get $right
  i32.eq
  if
   i32.const 1
   local.set $3
   i32.const 8
   call $~lib/rt/__increase_sp
   local.get $3
   return
  end
  local.get $left
  i32.const 0
  i32.eq
  if (result i32)
   i32.const 1
  else
   local.get $right
   i32.const 0
   i32.eq
  end
  if
   i32.const 0
   local.set $3
   i32.const 8
   call $~lib/rt/__increase_sp
   local.get $3
   return
  end
  local.get $left
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/string/String#get:length
  local.set $leftLength
  local.get $leftLength
  local.get $right
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/string/String#get:length
  i32.ne
  if
   i32.const 0
   local.set $3
   i32.const 8
   call $~lib/rt/__increase_sp
   local.get $3
   return
  end
  local.get $left
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  local.get $right
  i32.const 4
  call $~lib/rt/__tmptostack
  i32.const 0
  local.get $leftLength
  call $~lib/util/string/compareImpl
  i32.eqz
  local.set $3
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $3
  return
  local.set $3
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#find" (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
  (local $entry i32)
  (local $taggedNext i32)
  (local $5 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:buckets"
  local.get $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:bucketsMask"
  i32.and
  i32.const 4
  i32.mul
  i32.add
  i32.load
  local.set $entry
  block $while-break|0
   loop $while-continue|0
    local.get $entry
    if
     local.get $entry
     call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:taggedNext"
     local.set $taggedNext
     local.get $taggedNext
     i32.const 1
     i32.and
     i32.eqz
     if (result i32)
      local.get $entry
      call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:key"
      i32.const 0
      call $~lib/rt/__tmptostack
      local.get $key
      i32.const 4
      call $~lib/rt/__tmptostack
      call $~lib/string/String.__eq
     else
      i32.const 0
     end
     if
      local.get $entry
      local.set $5
      i32.const 8
      call $~lib/rt/__increase_sp
      local.get $5
      return
     end
     local.get $taggedNext
     i32.const 1
     i32.const -1
     i32.xor
     i32.and
     local.set $entry
     br $while-continue|0
    end
   end
  end
  i32.const 0
  local.set $5
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $5
  return
  local.set $5
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $5
 )
 (func $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:value" (param $this i32) (param $value i32)
  local.get $this
  local.get $value
  i32.store offset=4
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesOffset" (param $this i32) (result i32)
  local.get $this
  i32.load offset=16
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesCapacity" (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesCount" (param $this i32) (result i32)
  local.get $this
  i32.load offset=20
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entries" (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:key" (param $this i32) (param $key i32)
  local.get $this
  local.get $key
  i32.store
 )
 (func $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:value" (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:taggedNext" (param $this i32) (param $taggedNext i32)
  local.get $this
  local.get $taggedNext
  i32.store offset=8
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entriesOffset" (param $this i32) (param $entriesOffset i32)
  local.get $this
  local.get $entriesOffset
  i32.store offset=16
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#rehash" (param $this i32) (param $newBucketsMask i32)
  (local $newBucketsCapacity i32)
  (local $newBuckets i32)
  (local $newEntriesCapacity i32)
  (local $newEntries i32)
  (local $oldPtr i32)
  (local $oldEnd i32)
  (local $newPtr i32)
  (local $oldEntry i32)
  (local $newEntry i32)
  (local $oldEntryKey i32)
  (local $newBucketIndex i32)
  (local $newBucketPtrBase i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $17 i32)
  (local $18 i32)
  (local $19 i32)
  (local $20 i32)
  (local $21 i32)
  i32.const 20
  call $~lib/rt/__decrease_sp
  local.get $newBucketsMask
  i32.const 1
  i32.add
  local.set $newBucketsCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $newBucketsCapacity
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $newBuckets
  local.get $newBucketsCapacity
  i32.const 8
  i32.mul
  i32.const 3
  i32.div_s
  local.set $newEntriesCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  block $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1" (result i32)
   i32.const 0
   local.set $14
   i32.const 0
   local.set $15
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1"
   end
   local.set $14
   i32.const 12
   local.get $14
   i32.add
   local.get $14
   i32.const -1
   i32.xor
   i32.and
   local.set $15
   local.get $15
   br $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1"
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__localtostack
  local.set $newEntries
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entries"
  local.set $oldPtr
  local.get $oldPtr
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesOffset"
  block $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$2" (result i32)
   i32.const 0
   local.set $16
   i32.const 0
   local.set $17
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$10" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$10"
   end
   local.set $16
   i32.const 12
   local.get $16
   i32.add
   local.get $16
   i32.const -1
   i32.xor
   i32.and
   local.set $17
   local.get $17
   br $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$2"
  end
  i32.mul
  i32.add
  local.set $oldEnd
  local.get $newEntries
  local.set $newPtr
  block $while-break|0
   loop $while-continue|0
    local.get $oldPtr
    local.get $oldEnd
    i32.ne
    if
     local.get $oldPtr
     local.set $oldEntry
     local.get $oldEntry
     call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:taggedNext"
     i32.const 1
     i32.and
     i32.eqz
     if
      local.get $newPtr
      local.set $newEntry
      local.get $oldEntry
      call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:key"
      i32.const 8
      call $~lib/rt/__localtostack
      local.set $oldEntryKey
      local.get $newEntry
      local.get $oldEntryKey
      i32.const 12
      call $~lib/rt/__tmptostack
      call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:key"
      local.get $newEntry
      local.get $oldEntry
      call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:value"
      i32.const 12
      call $~lib/rt/__tmptostack
      call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:value"
      local.get $oldEntryKey
      i32.const 12
      call $~lib/rt/__tmptostack
      call $~lib/util/hash/HASH<~lib/string/String>
      local.get $newBucketsMask
      i32.and
      local.set $newBucketIndex
      local.get $newBuckets
      local.get $newBucketIndex
      i32.const 4
      i32.mul
      i32.add
      local.set $newBucketPtrBase
      local.get $newEntry
      local.get $newBucketPtrBase
      i32.load
      call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:taggedNext"
      local.get $newBucketPtrBase
      local.get $newPtr
      i32.store
      local.get $newPtr
      block $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$3" (result i32)
       i32.const 0
       local.set $18
       i32.const 0
       local.set $19
       block $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$11" (result i32)
        i32.const 3
        br $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$11"
       end
       local.set $18
       i32.const 12
       local.get $18
       i32.add
       local.get $18
       i32.const -1
       i32.xor
       i32.and
       local.set $19
       local.get $19
       br $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$3"
      end
      i32.add
      local.set $newPtr
     end
     local.get $oldPtr
     block $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$4" (result i32)
      i32.const 0
      local.set $20
      i32.const 0
      local.set $21
      block $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$12" (result i32)
       i32.const 3
       br $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$12"
      end
      local.set $20
      i32.const 12
      local.get $20
      i32.add
      local.get $20
      i32.const -1
      i32.xor
      i32.and
      local.set $21
      local.get $21
      br $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$4"
     end
     i32.add
     local.set $oldPtr
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newBuckets
  i32.const 16
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:buckets"
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newBucketsMask
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:bucketsMask"
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newEntries
  i32.const 16
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entries"
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entriesCapacity"
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $this
  i32.const 16
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesCount"
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entriesOffset"
  i32.const 20
  call $~lib/rt/__increase_sp
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entriesCount" (param $this i32) (param $entriesCount i32)
  local.get $this
  local.get $entriesCount
  i32.store offset=20
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set" (param $this i32) (param $key i32) (param $value i32) (result i32)
  (local $hashCode i32)
  (local $entry i32)
  (local $entries i32)
  (local $6 i32)
  (local $bucketPtrBase i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  local.get $key
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/util/hash/HASH<~lib/string/String>
  local.set $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $key
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $hashCode
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#find"
  local.set $entry
  local.get $entry
  if
   local.get $entry
   local.get $value
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:value"
   i32.const 1
   drop
   local.get $this
   local.get $value
   i32.const 1
   call $~lib/rt/itcms/__link
  else
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesOffset"
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesCapacity"
   i32.eq
   if
    local.get $this
    i32.const 0
    call $~lib/rt/__tmptostack
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesCount"
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesCapacity"
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:bucketsMask"
    else
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:bucketsMask"
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#rehash"
   end
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entries"
   i32.const 0
   call $~lib/rt/__localtostack
   local.set $entries
   local.get $entries
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 8
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesOffset"
   local.tee $6
   i32.const 1
   i32.add
   call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entriesOffset"
   local.get $6
   block $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1" (result i32)
    i32.const 0
    local.set $8
    i32.const 0
    local.set $9
    block $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1" (result i32)
     i32.const 3
     br $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1"
    end
    local.set $8
    i32.const 12
    local.get $8
    i32.add
    local.get $8
    i32.const -1
    i32.xor
    i32.and
    local.set $9
    local.get $9
    br $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1"
   end
   i32.mul
   i32.add
   local.set $entry
   local.get $entry
   local.get $key
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:key"
   i32.const 1
   drop
   local.get $this
   local.get $key
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $entry
   local.get $value
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:value"
   i32.const 1
   drop
   local.get $this
   local.get $value
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 8
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesCount"
   i32.const 1
   i32.add
   call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:entriesCount"
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:buckets"
   local.get $hashCode
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:bucketsMask"
   i32.and
   i32.const 4
   i32.mul
   i32.add
   local.set $bucketPtrBase
   local.get $entry
   local.get $bucketPtrBase
   i32.load
   call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set:taggedNext"
   local.get $bucketPtrBase
   local.get $entry
   i32.store
  end
  local.get $this
  local.set $10
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $10
  return
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:buckets" (param $this i32) (param $buckets i32)
  local.get $this
  local.get $buckets
  i32.store
  local.get $this
  local.get $buckets
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:bucketsMask" (param $this i32) (param $bucketsMask i32)
  local.get $this
  local.get $bucketsMask
  i32.store offset=4
 )
 (func $"~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>" (result i32)
  i32.const 3
  return
 )
 (func $"~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>" (result i32)
  (local $align i32)
  (local $size i32)
  block $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1" (result i32)
   i32.const 3
   br $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1"
  end
  local.set $align
  i32.const 12
  local.get $align
  i32.add
  local.get $align
  i32.const -1
  i32.xor
  i32.and
  local.set $size
  local.get $size
  return
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entries" (param $this i32) (param $entries i32)
  local.get $this
  local.get $entries
  i32.store offset=8
  local.get $this
  local.get $entries
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entriesCapacity" (param $this i32) (param $entriesCapacity i32)
  local.get $this
  local.get $entriesCapacity
  i32.store offset=12
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#constructor" (param $this i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:buckets"
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  i32.const 1
  i32.sub
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:bucketsMask"
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 4
  block $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1" (result i32)
   i32.const 0
   local.set $1
   i32.const 0
   local.set $2
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1"
   end
   local.set $1
   i32.const 12
   local.get $1
   i32.add
   local.get $1
   i32.const -1
   i32.xor
   i32.and
   local.set $2
   local.get $2
   br $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1"
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entries"
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 4
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entriesCapacity"
  local.get $this
  local.set $3
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/util/hash/HASH<tools/heap_analyzer/tests/fixture/dwarfFixture/Character> (param $key i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  i32.const 0
  drop
  i32.const 1
  drop
  i32.const 4
  i32.const 4
  i32.eq
  drop
  block $__inlined_func$~lib/util/hash/hash32$1 (result i32)
   local.get $key
   local.set $1
   i32.const 4
   local.set $2
   i32.const 0
   local.set $3
   i32.const 0
   i32.const 374761393
   i32.add
   local.get $2
   i32.add
   local.set $3
   local.get $3
   local.get $1
   i32.const -1028477379
   i32.mul
   i32.add
   local.set $3
   local.get $3
   i32.const 17
   i32.rotl
   i32.const 668265263
   i32.mul
   local.set $3
   local.get $3
   local.get $3
   i32.const 15
   i32.shr_u
   i32.xor
   local.set $3
   local.get $3
   i32.const -2048144777
   i32.mul
   local.set $3
   local.get $3
   local.get $3
   i32.const 13
   i32.shr_u
   i32.xor
   local.set $3
   local.get $3
   i32.const -1028477379
   i32.mul
   local.set $3
   local.get $3
   local.get $3
   i32.const 16
   i32.shr_u
   i32.xor
   local.set $3
   local.get $3
   br $__inlined_func$~lib/util/hash/hash32$1
  end
  return
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:buckets" (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:bucketsMask" (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:taggedNext" (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:key" (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#find" (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
  (local $entry i32)
  (local $taggedNext i32)
  (local $5 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:buckets"
  local.get $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:bucketsMask"
  i32.and
  i32.const 4
  i32.mul
  i32.add
  i32.load
  local.set $entry
  block $while-break|0
   loop $while-continue|0
    local.get $entry
    if
     local.get $entry
     call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:taggedNext"
     local.set $taggedNext
     local.get $taggedNext
     i32.const 1
     i32.and
     i32.eqz
     if (result i32)
      local.get $entry
      call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:key"
      local.get $key
      i32.eq
     else
      i32.const 0
     end
     if
      local.get $entry
      local.set $5
      i32.const 4
      call $~lib/rt/__increase_sp
      local.get $5
      return
     end
     local.get $taggedNext
     i32.const 1
     i32.const -1
     i32.xor
     i32.and
     local.set $entry
     br $while-continue|0
    end
   end
  end
  i32.const 0
  local.set $5
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $5
  return
  local.set $5
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $5
 )
 (func $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:value" (param $this i32) (param $value i32)
  local.get $this
  local.get $value
  i32.store offset=4
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesOffset" (param $this i32) (result i32)
  local.get $this
  i32.load offset=16
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesCapacity" (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesCount" (param $this i32) (result i32)
  local.get $this
  i32.load offset=20
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entries" (param $this i32) (result i32)
  local.get $this
  i32.load offset=8
 )
 (func $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:key" (param $this i32) (param $key i32)
  local.get $this
  local.get $key
  i32.store
 )
 (func $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:value" (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:taggedNext" (param $this i32) (param $taggedNext i32)
  local.get $this
  local.get $taggedNext
  i32.store offset=8
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entriesOffset" (param $this i32) (param $entriesOffset i32)
  local.get $this
  local.get $entriesOffset
  i32.store offset=16
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#rehash" (param $this i32) (param $newBucketsMask i32)
  (local $newBucketsCapacity i32)
  (local $newBuckets i32)
  (local $newEntriesCapacity i32)
  (local $newEntries i32)
  (local $oldPtr i32)
  (local $oldEnd i32)
  (local $newPtr i32)
  (local $oldEntry i32)
  (local $newEntry i32)
  (local $oldEntryKey i32)
  (local $newBucketIndex i32)
  (local $newBucketPtrBase i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $17 i32)
  (local $18 i32)
  (local $19 i32)
  (local $20 i32)
  (local $21 i32)
  i32.const 20
  call $~lib/rt/__decrease_sp
  local.get $newBucketsMask
  i32.const 1
  i32.add
  local.set $newBucketsCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $newBucketsCapacity
  i32.const 4
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $newBuckets
  local.get $newBucketsCapacity
  i32.const 8
  i32.mul
  i32.const 3
  i32.div_s
  local.set $newEntriesCapacity
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  block $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1" (result i32)
   i32.const 0
   local.set $14
   i32.const 0
   local.set $15
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1"
   end
   local.set $14
   i32.const 12
   local.get $14
   i32.add
   local.get $14
   i32.const -1
   i32.xor
   i32.and
   local.set $15
   local.get $15
   br $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1"
  end
  i32.mul
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 4
  call $~lib/rt/__localtostack
  local.set $newEntries
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entries"
  local.set $oldPtr
  local.get $oldPtr
  local.get $this
  i32.const 8
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesOffset"
  block $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$2" (result i32)
   i32.const 0
   local.set $16
   i32.const 0
   local.set $17
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$10" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$10"
   end
   local.set $16
   i32.const 12
   local.get $16
   i32.add
   local.get $16
   i32.const -1
   i32.xor
   i32.and
   local.set $17
   local.get $17
   br $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$2"
  end
  i32.mul
  i32.add
  local.set $oldEnd
  local.get $newEntries
  local.set $newPtr
  block $while-break|0
   loop $while-continue|0
    local.get $oldPtr
    local.get $oldEnd
    i32.ne
    if
     local.get $oldPtr
     local.set $oldEntry
     local.get $oldEntry
     call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:taggedNext"
     i32.const 1
     i32.and
     i32.eqz
     if
      local.get $newPtr
      local.set $newEntry
      local.get $oldEntry
      call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:key"
      i32.const 8
      call $~lib/rt/__localtostack
      local.set $oldEntryKey
      local.get $newEntry
      local.get $oldEntryKey
      i32.const 12
      call $~lib/rt/__tmptostack
      call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:key"
      local.get $newEntry
      local.get $oldEntry
      call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:value"
      i32.const 12
      call $~lib/rt/__tmptostack
      call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:value"
      local.get $oldEntryKey
      i32.const 12
      call $~lib/rt/__tmptostack
      call $~lib/util/hash/HASH<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>
      local.get $newBucketsMask
      i32.and
      local.set $newBucketIndex
      local.get $newBuckets
      local.get $newBucketIndex
      i32.const 4
      i32.mul
      i32.add
      local.set $newBucketPtrBase
      local.get $newEntry
      local.get $newBucketPtrBase
      i32.load
      call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:taggedNext"
      local.get $newBucketPtrBase
      local.get $newPtr
      i32.store
      local.get $newPtr
      block $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$3" (result i32)
       i32.const 0
       local.set $18
       i32.const 0
       local.set $19
       block $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$11" (result i32)
        i32.const 3
        br $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$11"
       end
       local.set $18
       i32.const 12
       local.get $18
       i32.add
       local.get $18
       i32.const -1
       i32.xor
       i32.and
       local.set $19
       local.get $19
       br $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$3"
      end
      i32.add
      local.set $newPtr
     end
     local.get $oldPtr
     block $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$4" (result i32)
      i32.const 0
      local.set $20
      i32.const 0
      local.set $21
      block $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$12" (result i32)
       i32.const 3
       br $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$12"
      end
      local.set $20
      i32.const 12
      local.get $20
      i32.add
      local.get $20
      i32.const -1
      i32.xor
      i32.and
      local.set $21
      local.get $21
      br $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$4"
     end
     i32.add
     local.set $oldPtr
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newBuckets
  i32.const 16
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:buckets"
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newBucketsMask
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:bucketsMask"
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newEntries
  i32.const 16
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entries"
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $newEntriesCapacity
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entriesCapacity"
  local.get $this
  i32.const 12
  call $~lib/rt/__tmptostack
  local.get $this
  i32.const 16
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesCount"
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entriesOffset"
  i32.const 20
  call $~lib/rt/__increase_sp
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entriesCount" (param $this i32) (param $entriesCount i32)
  local.get $this
  local.get $entriesCount
  i32.store offset=20
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set" (param $this i32) (param $key i32) (param $value i32) (result i32)
  (local $hashCode i32)
  (local $entry i32)
  (local $entries i32)
  (local $6 i32)
  (local $bucketPtrBase i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  local.get $key
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/util/hash/HASH<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>
  local.set $hashCode
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $key
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $hashCode
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#find"
  local.set $entry
  local.get $entry
  if
   local.get $entry
   local.get $value
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:value"
   i32.const 1
   drop
   local.get $this
   local.get $value
   i32.const 1
   call $~lib/rt/itcms/__link
  else
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesOffset"
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesCapacity"
   i32.eq
   if
    local.get $this
    i32.const 0
    call $~lib/rt/__tmptostack
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesCount"
    local.get $this
    i32.const 4
    call $~lib/rt/__tmptostack
    call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesCapacity"
    i32.const 3
    i32.mul
    i32.const 4
    i32.div_s
    i32.lt_s
    if (result i32)
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:bucketsMask"
    else
     local.get $this
     i32.const 4
     call $~lib/rt/__tmptostack
     call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:bucketsMask"
     i32.const 1
     i32.shl
     i32.const 1
     i32.or
    end
    call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#rehash"
   end
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entries"
   i32.const 0
   call $~lib/rt/__localtostack
   local.set $entries
   local.get $entries
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 8
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesOffset"
   local.tee $6
   i32.const 1
   i32.add
   call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entriesOffset"
   local.get $6
   block $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1" (result i32)
    i32.const 0
    local.set $8
    i32.const 0
    local.set $9
    block $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1" (result i32)
     i32.const 3
     br $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1"
    end
    local.set $8
    i32.const 12
    local.get $8
    i32.add
    local.get $8
    i32.const -1
    i32.xor
    i32.and
    local.set $9
    local.get $9
    br $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1"
   end
   i32.mul
   i32.add
   local.set $entry
   local.get $entry
   local.get $key
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:key"
   i32.const 1
   drop
   local.get $this
   local.get $key
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $entry
   local.get $value
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:value"
   i32.const 1
   drop
   local.get $this
   local.get $value
   i32.const 1
   call $~lib/rt/itcms/__link
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   local.get $this
   i32.const 8
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesCount"
   i32.const 1
   i32.add
   call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:entriesCount"
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:buckets"
   local.get $hashCode
   local.get $this
   i32.const 4
   call $~lib/rt/__tmptostack
   call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:bucketsMask"
   i32.and
   i32.const 4
   i32.mul
   i32.add
   local.set $bucketPtrBase
   local.get $entry
   local.get $bucketPtrBase
   i32.load
   call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set:taggedNext"
   local.get $bucketPtrBase
   local.get $entry
   i32.store
  end
  local.get $this
  local.set $10
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $10
  return
 )
 (func $~lib/string/String.UTF8.byteLength (param $str i32) (param $nullTerminated i32) (result i32)
  (local $strOff i32)
  (local $strEnd i32)
  (local $bufLen i32)
  (local $c1 i32)
  local.get $str
  local.set $strOff
  local.get $strOff
  local.get $str
  i32.const 20
  i32.sub
  call $~lib/rt/common/OBJECT#get:rtSize
  i32.add
  local.set $strEnd
  local.get $nullTerminated
  i32.const 0
  i32.ne
  local.set $bufLen
  block $while-break|0
   loop $while-continue|0
    local.get $strOff
    local.get $strEnd
    i32.lt_u
    if
     local.get $strOff
     i32.load16_u
     local.set $c1
     local.get $c1
     i32.const 128
     i32.lt_u
     if
      local.get $nullTerminated
      local.get $c1
      i32.eqz
      i32.and
      if
       br $while-break|0
      end
      local.get $bufLen
      i32.const 1
      i32.add
      local.set $bufLen
     else
      local.get $c1
      i32.const 2048
      i32.lt_u
      if
       local.get $bufLen
       i32.const 2
       i32.add
       local.set $bufLen
      else
       local.get $c1
       i32.const 64512
       i32.and
       i32.const 55296
       i32.eq
       if (result i32)
        local.get $strOff
        i32.const 2
        i32.add
        local.get $strEnd
        i32.lt_u
       else
        i32.const 0
       end
       if
        local.get $strOff
        i32.load16_u offset=2
        i32.const 64512
        i32.and
        i32.const 56320
        i32.eq
        if
         local.get $bufLen
         i32.const 4
         i32.add
         local.set $bufLen
         local.get $strOff
         i32.const 4
         i32.add
         local.set $strOff
         br $while-continue|0
        end
       end
       local.get $bufLen
       i32.const 3
       i32.add
       local.set $bufLen
      end
     end
     local.get $strOff
     i32.const 2
     i32.add
     local.set $strOff
     br $while-continue|0
    end
   end
  end
  local.get $bufLen
  return
 )
 (func $~lib/string/String.UTF8.encodeUnsafe (param $str i32) (param $len i32) (param $buf i32) (param $nullTerminated i32) (param $errorMode i32) (result i32)
  (local $strEnd i32)
  (local $bufOff i32)
  (local $c1 i32)
  (local $b0 i32)
  (local $b1 i32)
  (local $c2 i32)
  (local $b0|11 i32)
  (local $b1|12 i32)
  (local $b2 i32)
  (local $b3 i32)
  (local $b0|15 i32)
  (local $b1|16 i32)
  (local $b2|17 i32)
  (local $18 i32)
  local.get $str
  local.get $len
  i32.const 1
  i32.shl
  i32.add
  local.set $strEnd
  local.get $buf
  local.set $bufOff
  block $while-break|0
   loop $while-continue|0
    local.get $str
    local.get $strEnd
    i32.lt_u
    if
     local.get $str
     i32.load16_u
     local.set $c1
     local.get $c1
     i32.const 128
     i32.lt_u
     if
      local.get $bufOff
      local.get $c1
      i32.store8
      local.get $bufOff
      i32.const 1
      i32.add
      local.set $bufOff
      local.get $nullTerminated
      local.get $c1
      i32.eqz
      i32.and
      if
       local.get $bufOff
       local.get $buf
       i32.sub
       return
      end
     else
      local.get $c1
      i32.const 2048
      i32.lt_u
      if
       local.get $c1
       i32.const 6
       i32.shr_u
       i32.const 192
       i32.or
       local.set $b0
       local.get $c1
       i32.const 63
       i32.and
       i32.const 128
       i32.or
       local.set $b1
       local.get $bufOff
       local.get $b1
       i32.const 8
       i32.shl
       local.get $b0
       i32.or
       i32.store16
       local.get $bufOff
       i32.const 2
       i32.add
       local.set $bufOff
      else
       local.get $c1
       i32.const 63488
       i32.and
       i32.const 55296
       i32.eq
       if
        local.get $c1
        i32.const 56320
        i32.lt_u
        if (result i32)
         local.get $str
         i32.const 2
         i32.add
         local.get $strEnd
         i32.lt_u
        else
         i32.const 0
        end
        if
         local.get $str
         i32.load16_u offset=2
         local.set $c2
         local.get $c2
         i32.const 64512
         i32.and
         i32.const 56320
         i32.eq
         if
          i32.const 65536
          local.get $c1
          i32.const 1023
          i32.and
          i32.const 10
          i32.shl
          i32.add
          local.get $c2
          i32.const 1023
          i32.and
          i32.or
          local.set $c1
          local.get $c1
          i32.const 18
          i32.shr_u
          i32.const 240
          i32.or
          local.set $b0|11
          local.get $c1
          i32.const 12
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          local.set $b1|12
          local.get $c1
          i32.const 6
          i32.shr_u
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          local.set $b2
          local.get $c1
          i32.const 63
          i32.and
          i32.const 128
          i32.or
          local.set $b3
          local.get $bufOff
          local.get $b3
          i32.const 24
          i32.shl
          local.get $b2
          i32.const 16
          i32.shl
          i32.or
          local.get $b1|12
          i32.const 8
          i32.shl
          i32.or
          local.get $b0|11
          i32.or
          i32.store
          local.get $bufOff
          i32.const 4
          i32.add
          local.set $bufOff
          local.get $str
          i32.const 4
          i32.add
          local.set $str
          br $while-continue|0
         end
        end
        local.get $errorMode
        i32.const 0
        i32.ne
        if
         local.get $errorMode
         i32.const 2
         i32.eq
         if
          i32.const 2480
          i32.const 2544
          i32.const 785
          i32.const 49
          call $~lib/builtins/abort
          unreachable
         end
         i32.const 65533
         local.set $c1
        end
       end
       local.get $c1
       i32.const 12
       i32.shr_u
       i32.const 224
       i32.or
       local.set $b0|15
       local.get $c1
       i32.const 6
       i32.shr_u
       i32.const 63
       i32.and
       i32.const 128
       i32.or
       local.set $b1|16
       local.get $c1
       i32.const 63
       i32.and
       i32.const 128
       i32.or
       local.set $b2|17
       local.get $bufOff
       local.get $b1|16
       i32.const 8
       i32.shl
       local.get $b0|15
       i32.or
       i32.store16
       local.get $bufOff
       local.get $b2|17
       i32.store8 offset=2
       local.get $bufOff
       i32.const 3
       i32.add
       local.set $bufOff
      end
     end
     local.get $str
     i32.const 2
     i32.add
     local.set $str
     br $while-continue|0
    end
   end
  end
  local.get $nullTerminated
  if
   local.get $bufOff
   local.tee $18
   i32.const 1
   i32.add
   local.set $bufOff
   local.get $18
   i32.const 0
   i32.store8
  end
  local.get $bufOff
  local.get $buf
  i32.sub
  return
 )
 (func $~lib/string/String.UTF8.encode (param $str i32) (param $nullTerminated i32) (param $errorMode i32) (result i32)
  (local $buf i32)
  (local $4 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  local.get $str
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $nullTerminated
  call $~lib/string/String.UTF8.byteLength
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buf
  local.get $str
  local.get $str
  i32.const 4
  call $~lib/rt/__tmptostack
  call $~lib/string/String#get:length
  local.get $buf
  local.get $nullTerminated
  local.get $errorMode
  call $~lib/string/String.UTF8.encodeUnsafe
  drop
  local.get $buf
  local.set $4
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $4
  return
  local.set $4
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $~lib/string/String.UTF8.encode@varargs (param $str i32) (param $nullTerminated i32) (param $errorMode i32) (result i32)
  (local $3 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  block $2of2
   block $1of2
    block $0of2
     block $outOfRange
      global.get $~argumentsLength
      i32.const 1
      i32.sub
      br_table $0of2 $1of2 $2of2 $outOfRange
     end
     unreachable
    end
    i32.const 0
    local.set $nullTerminated
   end
   i32.const 0
   local.set $errorMode
  end
  local.get $str
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $nullTerminated
  local.get $errorMode
  call $~lib/string/String.UTF8.encode
  local.set $3
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#set:buffer (param $this i32) (param $buffer i32)
  local.get $this
  local.get $buffer
  i32.store
  local.get $this
  local.get $buffer
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#set:dataStart (param $this i32) (param $dataStart i32)
  local.get $this
  local.get $dataStart
  i32.store offset=4
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#set:byteLength (param $this i32) (param $byteLength i32)
  local.get $this
  local.get $byteLength
  i32.store offset=8
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#set:length_ (param $this i32) (param $length_ i32)
  local.get $this
  local.get $length_
  i32.store offset=12
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (local $6 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $length
  i32.const 1073741820
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   i32.const 816
   i32.const 1056
   i32.const 81
   i32.const 62
   call $~lib/builtins/abort
   unreachable
  end
  local.get $length
  local.tee $2
  i32.const 8
  local.tee $3
  local.get $2
  local.get $3
  i32.gt_u
  select
  i32.const 2
  i32.shl
  local.set $bufferSize
  local.get $bufferSize
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#set:buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#set:dataStart
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $bufferSize
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#set:byteLength
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $length
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#set:length_
  local.get $this
  local.set $6
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair#set:key (param $this i32) (param $key i32)
  local.get $this
  local.get $key
  i32.store
  local.get $this
  local.get $key
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair#set:value (param $this i32) (param $value i32)
  local.get $this
  local.get $value
  i32.store offset=4
  local.get $this
  local.get $value
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair#constructor (param $this i32) (param $key i32) (param $value i32) (result i32)
  (local $3 i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  nop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $key
  i32.const 4
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair#set:key
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $value
  i32.const 4
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair#set:value
  local.get $this
  local.set $3
  i32.const 8
  call $~lib/rt/__increase_sp
  local.get $3
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:length_ (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:dataStart (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#push (param $this i32) (param $value i32) (result i32)
  (local $oldLen i32)
  (local $len i32)
  (local $4 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:length_
  local.set $oldLen
  local.get $oldLen
  i32.const 1
  i32.add
  local.set $len
  local.get $this
  local.get $len
  i32.const 2
  i32.const 1
  call $~lib/array/ensureCapacity
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:dataStart
  local.get $oldLen
  i32.const 2
  i32.shl
  i32.add
  local.get $value
  i32.store
  local.get $this
  local.get $value
  i32.const 1
  call $~lib/rt/itcms/__link
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $len
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#set:length_
  local.get $len
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
  return
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $~lib/rt/itcms/__pin (param $ptr i32) (result i32)
  (local $obj i32)
  local.get $ptr
  if
   local.get $ptr
   i32.const 20
   i32.sub
   local.set $obj
   local.get $obj
   call $~lib/rt/itcms/Object#get:color
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
   local.get $obj
   call $~lib/rt/itcms/Object#unlink
   local.get $obj
   global.get $~lib/rt/itcms/pinSpace
   i32.const 3
   call $~lib/rt/itcms/Object#linkTo
  end
  local.get $ptr
  return
 )
 (func $~lib/array/Array<~lib/string/String>#set:buffer (param $this i32) (param $buffer i32)
  local.get $this
  local.get $buffer
  i32.store
  local.get $this
  local.get $buffer
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/array/Array<~lib/string/String>#set:dataStart (param $this i32) (param $dataStart i32)
  local.get $this
  local.get $dataStart
  i32.store offset=4
 )
 (func $~lib/array/Array<~lib/string/String>#set:byteLength (param $this i32) (param $byteLength i32)
  local.get $this
  local.get $byteLength
  i32.store offset=8
 )
 (func $~lib/array/Array<~lib/string/String>#set:length_ (param $this i32) (param $length_ i32)
  local.get $this
  local.get $length_
  i32.store offset=12
 )
 (func $~lib/array/Array<~lib/string/String>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (local $6 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $length
  i32.const 1073741820
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   i32.const 816
   i32.const 1056
   i32.const 81
   i32.const 62
   call $~lib/builtins/abort
   unreachable
  end
  local.get $length
  local.tee $2
  i32.const 8
  local.tee $3
  local.get $2
  local.get $3
  i32.gt_u
  select
  i32.const 2
  i32.shl
  local.set $bufferSize
  local.get $bufferSize
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#set:buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  call $~lib/array/Array<~lib/string/String>#set:dataStart
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $bufferSize
  call $~lib/array/Array<~lib/string/String>#set:byteLength
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $length
  call $~lib/array/Array<~lib/string/String>#set:length_
  local.get $this
  local.set $6
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $~lib/array/Array<~lib/string/String>#push (param $this i32) (param $value i32) (result i32)
  (local $oldLen i32)
  (local $len i32)
  (local $4 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#get:length_
  local.set $oldLen
  local.get $oldLen
  i32.const 1
  i32.add
  local.set $len
  local.get $this
  local.get $len
  i32.const 2
  i32.const 1
  call $~lib/array/ensureCapacity
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#get:dataStart
  local.get $oldLen
  i32.const 2
  i32.shl
  i32.add
  local.get $value
  i32.store
  local.get $this
  local.get $value
  i32.const 1
  call $~lib/rt/itcms/__link
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $len
  call $~lib/array/Array<~lib/string/String>#set:length_
  local.get $len
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
  return
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $~lib/array/Array<f64>#set:buffer (param $this i32) (param $buffer i32)
  local.get $this
  local.get $buffer
  i32.store
  local.get $this
  local.get $buffer
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/array/Array<f64>#set:dataStart (param $this i32) (param $dataStart i32)
  local.get $this
  local.get $dataStart
  i32.store offset=4
 )
 (func $~lib/array/Array<f64>#set:byteLength (param $this i32) (param $byteLength i32)
  local.get $this
  local.get $byteLength
  i32.store offset=8
 )
 (func $~lib/array/Array<f64>#set:length_ (param $this i32) (param $length_ i32)
  local.get $this
  local.get $length_
  i32.store offset=12
 )
 (func $~lib/array/Array<f64>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (local $6 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $length
  i32.const 1073741820
  i32.const 3
  i32.shr_u
  i32.gt_u
  if
   i32.const 816
   i32.const 1056
   i32.const 81
   i32.const 62
   call $~lib/builtins/abort
   unreachable
  end
  local.get $length
  local.tee $2
  i32.const 8
  local.tee $3
  local.get $2
  local.get $3
  i32.gt_u
  select
  i32.const 3
  i32.shl
  local.set $bufferSize
  local.get $bufferSize
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<f64>#set:buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  call $~lib/array/Array<f64>#set:dataStart
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $bufferSize
  call $~lib/array/Array<f64>#set:byteLength
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $length
  call $~lib/array/Array<f64>#set:length_
  local.get $this
  local.set $6
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $~lib/math/NativeMath.sqrt (param $x f64) (result f64)
  local.get $x
  f64.sqrt
  return
 )
 (func $~lib/array/Array<f64>#get:length_ (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/array/Array<f64>#get:dataStart (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/array/Array<f64>#__set (param $this i32) (param $index i32) (param $value f64)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $index
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<f64>#get:length_
  i32.ge_u
  if
   local.get $index
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
   local.get $this
   local.get $index
   i32.const 1
   i32.add
   i32.const 3
   i32.const 1
   call $~lib/array/ensureCapacity
   local.get $this
   i32.const 0
   call $~lib/rt/__tmptostack
   local.get $index
   i32.const 1
   i32.add
   call $~lib/array/Array<f64>#set:length_
  end
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<f64>#get:dataStart
  local.get $index
  i32.const 3
  i32.shl
  i32.add
  local.get $value
  f64.store
  i32.const 0
  drop
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#set:buffer (param $this i32) (param $buffer i32)
  local.get $this
  local.get $buffer
  i32.store
  local.get $this
  local.get $buffer
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#set:dataStart (param $this i32) (param $dataStart i32)
  local.get $this
  local.get $dataStart
  i32.store offset=4
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#set:byteLength (param $this i32) (param $byteLength i32)
  local.get $this
  local.get $byteLength
  i32.store offset=8
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#set:length_ (param $this i32) (param $length_ i32)
  local.get $this
  local.get $length_
  i32.store offset=12
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (local $6 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $length
  i32.const 1073741820
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   i32.const 816
   i32.const 1056
   i32.const 81
   i32.const 62
   call $~lib/builtins/abort
   unreachable
  end
  local.get $length
  local.tee $2
  i32.const 8
  local.tee $3
  local.get $2
  local.get $3
  i32.gt_u
  select
  i32.const 2
  i32.shl
  local.set $bufferSize
  local.get $bufferSize
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/array/Array<i32>>#set:buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  call $~lib/array/Array<~lib/array/Array<i32>>#set:dataStart
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $bufferSize
  call $~lib/array/Array<~lib/array/Array<i32>>#set:byteLength
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $length
  call $~lib/array/Array<~lib/array/Array<i32>>#set:length_
  local.get $this
  local.set $6
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $~lib/array/Array<i32>#set:buffer (param $this i32) (param $buffer i32)
  local.get $this
  local.get $buffer
  i32.store
  local.get $this
  local.get $buffer
  i32.const 0
  call $~lib/rt/itcms/__link
 )
 (func $~lib/array/Array<i32>#set:dataStart (param $this i32) (param $dataStart i32)
  local.get $this
  local.get $dataStart
  i32.store offset=4
 )
 (func $~lib/array/Array<i32>#set:byteLength (param $this i32) (param $byteLength i32)
  local.get $this
  local.get $byteLength
  i32.store offset=8
 )
 (func $~lib/array/Array<i32>#set:length_ (param $this i32) (param $length_ i32)
  local.get $this
  local.get $length_
  i32.store offset=12
 )
 (func $~lib/array/Array<i32>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (local $6 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  nop
  local.get $length
  i32.const 1073741820
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   i32.const 816
   i32.const 1056
   i32.const 81
   i32.const 62
   call $~lib/builtins/abort
   unreachable
  end
  local.get $length
  local.tee $2
  i32.const 8
  local.tee $3
  local.get $2
  local.get $3
  i32.gt_u
  select
  i32.const 2
  i32.shl
  local.set $bufferSize
  local.get $bufferSize
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  i32.const 8
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<i32>#set:buffer
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $buffer
  call $~lib/array/Array<i32>#set:dataStart
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $bufferSize
  call $~lib/array/Array<i32>#set:byteLength
  local.get $this
  i32.const 4
  call $~lib/rt/__tmptostack
  local.get $length
  call $~lib/array/Array<i32>#set:length_
  local.get $this
  local.set $6
  i32.const 12
  call $~lib/rt/__increase_sp
  local.get $6
 )
 (func $~lib/array/Array<i32>#get:length_ (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/array/Array<i32>#get:dataStart (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/array/Array<i32>#push (param $this i32) (param $value i32) (result i32)
  (local $oldLen i32)
  (local $len i32)
  (local $4 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<i32>#get:length_
  local.set $oldLen
  local.get $oldLen
  i32.const 1
  i32.add
  local.set $len
  local.get $this
  local.get $len
  i32.const 2
  i32.const 1
  call $~lib/array/ensureCapacity
  i32.const 0
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<i32>#get:dataStart
  local.get $oldLen
  i32.const 2
  i32.shl
  i32.add
  local.get $value
  i32.store
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $len
  call $~lib/array/Array<i32>#set:length_
  local.get $len
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
  return
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#get:length_ (param $this i32) (result i32)
  local.get $this
  i32.load offset=12
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#get:dataStart (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#push (param $this i32) (param $value i32) (result i32)
  (local $oldLen i32)
  (local $len i32)
  (local $4 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/array/Array<i32>>#get:length_
  local.set $oldLen
  local.get $oldLen
  i32.const 1
  i32.add
  local.set $len
  local.get $this
  local.get $len
  i32.const 2
  i32.const 1
  call $~lib/array/ensureCapacity
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/array/Array<i32>>#get:dataStart
  local.get $oldLen
  i32.const 2
  i32.shl
  i32.add
  local.get $value
  i32.store
  local.get $this
  local.get $value
  i32.const 1
  call $~lib/rt/itcms/__link
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  local.get $len
  call $~lib/array/Array<~lib/array/Array<i32>>#set:length_
  local.get $len
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
  return
  local.set $4
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $4
 )
 (func $~lib/typedarray/Uint8Array#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:byteLength
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $~lib/typedarray/Float64Array#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:byteLength
  i32.const 3
  i32.shr_u
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $~lib/typedarray/Int32Array#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBufferView#get:byteLength
  i32.const 2
  i32.shr_u
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:length_
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:length_
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#get:value (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#get:data (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:length_
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $~lib/arraybuffer/ArrayBuffer#get:byteLength (param $this i32) (result i32)
  local.get $this
  i32.const 20
  i32.sub
  call $~lib/rt/common/OBJECT#get:rtSize
  return
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#get:x (param $this i32) (result f32)
  local.get $this
  f32.load
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#get:weight (param $this i32) (result i32)
  local.get $this
  i32.load offset=4
 )
 (func $~lib/array/Array<f64>#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<f64>#get:length_
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/array/Array<i32>>#get:length_
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $~lib/array/Array<i32>#get:length (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<i32>#get:length_
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $~lib/set/Set<i32>#get:size (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#get:entriesCount
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:size (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesCount
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $"~lib/map/Map<i32,i32>#get:size" (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#get:entriesCount"
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:size" (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesCount"
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:size" (param $this i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesCount"
  local.set $1
  i32.const 4
  call $~lib/rt/__increase_sp
  local.get $1
  return
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/_start
  (local $longStr i32)
  (local $u8arr i32)
  (local $i i32)
  (local $f64arr i32)
  (local $i|4 i32)
  (local $i32arr i32)
  (local $i|6 i32)
  (local $staticArr i32)
  (local $i|8 i32)
  (local $items i32)
  (local $player1 i32)
  (local $player2 i32)
  (local $npc1 i32)
  (local $npc2 i32)
  (local $npc3 i32)
  (local $characters i32)
  (local $tree i32)
  (local $17 i32)
  (local $list i32)
  (local $primeSet i32)
  (local $itemSet i32)
  (local $scoreMap i32)
  (local $playerMap i32)
  (local $entityPositions i32)
  (local $encodedPath i32)
  (local $kvPairs i32)
  (local $rawBuf i32)
  (local $localOnly1 i32)
  (local $localOnly2 i32)
  (local $localOnlyArr i32)
  (local $bigArray i32)
  (local $i|31 i32)
  (local $matrix i32)
  (local $row i32)
  (local $r i32)
  (local $col i32)
  (local $36 f64)
  i32.const 120
  call $~lib/rt/__decrease_sp
  i32.const 240
  i32.const 352
  call $~lib/string/String.__concat
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 240
  call $~lib/string/String.__concat
  i32.const 4
  call $~lib/rt/__tmptostack
  i32.const 352
  call $~lib/string/String.__concat
  i32.const 0
  call $~lib/rt/__tmptostack
  i32.const 240
  call $~lib/string/String.__concat
  i32.const 0
  call $~lib/rt/__localtostack
  local.set $longStr
  i32.const 12
  i32.const 14
  call $~lib/rt/itcms/__new
  i32.const 4
  call $~lib/rt/__tmptostack
  i32.const 64
  call $~lib/typedarray/Uint8Array#constructor
  i32.const 4
  call $~lib/rt/__localtostack
  local.set $u8arr
  i32.const 0
  local.set $i
  loop $for-loop|0
   local.get $i
   i32.const 64
   i32.lt_s
   if
    local.get $u8arr
    i32.const 8
    call $~lib/rt/__tmptostack
    local.get $i
    local.get $i
    i32.const 255
    i32.and
    call $~lib/typedarray/Uint8Array#__set
    local.get $i
    i32.const 1
    i32.add
    local.set $i
    br $for-loop|0
   end
  end
  i32.const 12
  i32.const 16
  call $~lib/rt/itcms/__new
  i32.const 8
  call $~lib/rt/__tmptostack
  i32.const 16
  call $~lib/typedarray/Float64Array#constructor
  i32.const 8
  call $~lib/rt/__localtostack
  local.set $f64arr
  i32.const 0
  local.set $i|4
  loop $for-loop|1
   local.get $i|4
   i32.const 16
   i32.lt_s
   if
    local.get $f64arr
    i32.const 12
    call $~lib/rt/__tmptostack
    local.get $i|4
    local.get $i|4
    f64.convert_i32_s
    f64.const 1.5
    f64.mul
    call $~lib/typedarray/Float64Array#__set
    local.get $i|4
    i32.const 1
    i32.add
    local.set $i|4
    br $for-loop|1
   end
  end
  i32.const 12
  i32.const 18
  call $~lib/rt/itcms/__new
  i32.const 12
  call $~lib/rt/__tmptostack
  i32.const 32
  call $~lib/typedarray/Int32Array#constructor
  i32.const 12
  call $~lib/rt/__localtostack
  local.set $i32arr
  i32.const 0
  local.set $i|6
  loop $for-loop|2
   local.get $i|6
   i32.const 32
   i32.lt_s
   if
    local.get $i32arr
    i32.const 16
    call $~lib/rt/__tmptostack
    local.get $i|6
    local.get $i|6
    i32.const 100
    i32.mul
    call $~lib/typedarray/Int32Array#__set
    local.get $i|6
    i32.const 1
    i32.add
    local.set $i|6
    br $for-loop|2
   end
  end
  i32.const 0
  i32.const 19
  call $~lib/rt/itcms/__new
  i32.const 16
  call $~lib/rt/__tmptostack
  i32.const 10
  call $~lib/staticarray/StaticArray<i32>#constructor
  i32.const 16
  call $~lib/rt/__localtostack
  local.set $staticArr
  i32.const 0
  local.set $i|8
  loop $for-loop|3
   local.get $i|8
   i32.const 10
   i32.lt_s
   if
    local.get $staticArr
    i32.const 20
    call $~lib/rt/__tmptostack
    local.get $i|8
    local.get $i|8
    i32.const 7
    i32.mul
    call $~lib/staticarray/StaticArray<i32>#__set
    local.get $i|8
    i32.const 1
    i32.add
    local.set $i|8
    br $for-loop|3
   end
  end
  i32.const 16
  i32.const 11
  call $~lib/rt/itcms/__new
  i32.const 20
  call $~lib/rt/__tmptostack
  i32.const 0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
  i32.const 20
  call $~lib/rt/__localtostack
  local.set $items
  local.get $items
  i32.const 24
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 32
  call $~lib/rt/__tmptostack
  i32.const 1104
  i32.const 10
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 28
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  drop
  local.get $items
  i32.const 24
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 32
  call $~lib/rt/__tmptostack
  i32.const 1136
  i32.const 15
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 28
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  drop
  local.get $items
  i32.const 24
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 32
  call $~lib/rt/__tmptostack
  i32.const 1168
  i32.const 2
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 28
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  drop
  local.get $items
  i32.const 24
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 32
  call $~lib/rt/__tmptostack
  i32.const 1200
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 28
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  drop
  local.get $items
  i32.const 24
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 32
  call $~lib/rt/__tmptostack
  i32.const 1232
  i32.const 8
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 28
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#push
  drop
  i32.const 24
  i32.const 6
  call $~lib/rt/itcms/__new
  i32.const 24
  call $~lib/rt/__tmptostack
  i32.const 1
  i32.const 1264
  i32.const 100
  f32.const 10.5
  f32.const 20.299999237060547
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#constructor
  i32.const 24
  call $~lib/rt/__localtostack
  local.set $player1
  local.get $player1
  i32.const 28
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 36
  call $~lib/rt/__tmptostack
  i32.const 1296
  i32.const 12
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 32
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  local.get $player1
  i32.const 28
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 36
  call $~lib/rt/__tmptostack
  i32.const 1344
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 32
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  local.get $player1
  i32.const 28
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 36
  call $~lib/rt/__tmptostack
  i32.const 1392
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 32
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  local.get $player1
  i32.const 28
  call $~lib/rt/__tmptostack
  i32.const 4200
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#set:score
  i32.const 24
  i32.const 6
  call $~lib/rt/itcms/__new
  i32.const 28
  call $~lib/rt/__tmptostack
  i32.const 2
  i32.const 1440
  i32.const 85
  f32.const -5
  f32.const 13.699999809265137
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#constructor
  i32.const 28
  call $~lib/rt/__localtostack
  local.set $player2
  local.get $player2
  i32.const 32
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 40
  call $~lib/rt/__tmptostack
  i32.const 1472
  i32.const 3
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 36
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  local.get $player2
  i32.const 32
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 40
  call $~lib/rt/__tmptostack
  i32.const 1504
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 36
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#addItem
  local.get $player2
  i32.const 32
  call $~lib/rt/__tmptostack
  i32.const 1500
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player#set:score
  i32.const 20
  i32.const 20
  call $~lib/rt/itcms/__new
  i32.const 32
  call $~lib/rt/__tmptostack
  i32.const 100
  i32.const 1552
  i32.const 50
  i32.const 1600
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#constructor
  i32.const 32
  call $~lib/rt/__localtostack
  local.set $npc1
  i32.const 20
  i32.const 20
  call $~lib/rt/itcms/__new
  i32.const 36
  call $~lib/rt/__tmptostack
  i32.const 101
  i32.const 1680
  i32.const 40
  i32.const 1728
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#constructor
  i32.const 36
  call $~lib/rt/__localtostack
  local.set $npc2
  i32.const 20
  i32.const 20
  call $~lib/rt/itcms/__new
  i32.const 40
  call $~lib/rt/__tmptostack
  i32.const 102
  i32.const 1808
  i32.const 200
  i32.const 1840
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC#constructor
  i32.const 40
  call $~lib/rt/__localtostack
  local.set $npc3
  i32.const 16
  i32.const 21
  call $~lib/rt/itcms/__new
  i32.const 44
  call $~lib/rt/__tmptostack
  i32.const 0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#constructor
  i32.const 44
  call $~lib/rt/__localtostack
  local.set $characters
  local.get $characters
  i32.const 48
  call $~lib/rt/__tmptostack
  local.get $player1
  i32.const 52
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#push
  drop
  local.get $characters
  i32.const 48
  call $~lib/rt/__tmptostack
  local.get $player2
  i32.const 52
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#push
  drop
  local.get $characters
  i32.const 48
  call $~lib/rt/__tmptostack
  local.get $npc1
  i32.const 52
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#push
  drop
  local.get $characters
  i32.const 48
  call $~lib/rt/__tmptostack
  local.get $npc2
  i32.const 52
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#push
  drop
  local.get $characters
  i32.const 48
  call $~lib/rt/__tmptostack
  local.get $npc3
  i32.const 52
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#push
  drop
  i32.const 4
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/buildTree
  i32.const 48
  call $~lib/rt/__localtostack
  local.set $tree
  local.get $tree
  global.set $tools/heap_analyzer/tests/fixture/dwarfFixture/globalTree
  i32.const 5
  i32.const 2
  i32.const 23
  i32.const 2080
  call $~lib/rt/__newArray
  i32.const 52
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/buildLinkedList
  i32.const 52
  call $~lib/rt/__localtostack
  local.set $list
  i32.const 24
  i32.const 26
  call $~lib/rt/itcms/__new
  i32.const 56
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#constructor
  i32.const 56
  call $~lib/rt/__localtostack
  local.set $primeSet
  local.get $primeSet
  i32.const 60
  call $~lib/rt/__tmptostack
  i32.const 2
  call $~lib/set/Set<i32>#add
  drop
  local.get $primeSet
  i32.const 60
  call $~lib/rt/__tmptostack
  i32.const 3
  call $~lib/set/Set<i32>#add
  drop
  local.get $primeSet
  i32.const 60
  call $~lib/rt/__tmptostack
  i32.const 5
  call $~lib/set/Set<i32>#add
  drop
  i32.const 24
  i32.const 27
  call $~lib/rt/itcms/__new
  i32.const 60
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#constructor
  i32.const 60
  call $~lib/rt/__localtostack
  local.set $itemSet
  local.get $itemSet
  i32.const 64
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 72
  call $~lib/rt/__tmptostack
  i32.const 2256
  i32.const 3
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 68
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#add
  drop
  local.get $itemSet
  i32.const 64
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 72
  call $~lib/rt/__tmptostack
  i32.const 2288
  i32.const 1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 68
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#add
  drop
  local.get $itemSet
  i32.const 64
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 72
  call $~lib/rt/__tmptostack
  i32.const 2320
  i32.const 2
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 68
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#add
  drop
  i32.const 24
  i32.const 28
  call $~lib/rt/itcms/__new
  i32.const 64
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#constructor"
  i32.const 64
  call $~lib/rt/__localtostack
  local.set $scoreMap
  local.get $scoreMap
  i32.const 68
  call $~lib/rt/__tmptostack
  i32.const 1
  i32.const 4200
  call $"~lib/map/Map<i32,i32>#set"
  drop
  local.get $scoreMap
  i32.const 68
  call $~lib/rt/__tmptostack
  i32.const 2
  i32.const 1500
  call $"~lib/map/Map<i32,i32>#set"
  drop
  local.get $scoreMap
  i32.const 68
  call $~lib/rt/__tmptostack
  i32.const 3
  i32.const 800
  call $"~lib/map/Map<i32,i32>#set"
  drop
  i32.const 24
  i32.const 31
  call $~lib/rt/itcms/__new
  i32.const 68
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#constructor"
  i32.const 68
  call $~lib/rt/__localtostack
  local.set $playerMap
  local.get $playerMap
  i32.const 72
  call $~lib/rt/__tmptostack
  i32.const 1264
  local.get $player1
  i32.const 76
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set"
  drop
  local.get $playerMap
  i32.const 72
  call $~lib/rt/__tmptostack
  i32.const 1440
  local.get $player2
  i32.const 76
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#set"
  drop
  i32.const 24
  i32.const 33
  call $~lib/rt/itcms/__new
  i32.const 72
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#constructor"
  i32.const 72
  call $~lib/rt/__localtostack
  local.set $entityPositions
  local.get $entityPositions
  i32.const 76
  call $~lib/rt/__tmptostack
  local.get $npc1
  i32.const 80
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 9
  call $~lib/rt/itcms/__new
  i32.const 88
  call $~lib/rt/__tmptostack
  f32.const 10
  f32.const 20
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#constructor
  i32.const 84
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set"
  drop
  local.get $entityPositions
  i32.const 76
  call $~lib/rt/__tmptostack
  local.get $npc2
  i32.const 80
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 9
  call $~lib/rt/itcms/__new
  i32.const 88
  call $~lib/rt/__tmptostack
  f32.const 30
  f32.const 40
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#constructor
  i32.const 84
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set"
  drop
  local.get $entityPositions
  i32.const 76
  call $~lib/rt/__tmptostack
  local.get $npc3
  i32.const 80
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 9
  call $~lib/rt/itcms/__new
  i32.const 88
  call $~lib/rt/__tmptostack
  f32.const 50
  f32.const 60
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#constructor
  i32.const 84
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#set"
  drop
  i32.const 2352
  i32.const 0
  i32.const 1
  global.set $~argumentsLength
  i32.const 0
  call $~lib/string/String.UTF8.encode@varargs
  i32.const 76
  call $~lib/rt/__localtostack
  local.set $encodedPath
  local.get $encodedPath
  i32.const 2352
  i32.const 0
  call $~lib/string/String.UTF8.byteLength
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/dumpMemoryRegion
  i32.const 16
  i32.const 36
  call $~lib/rt/itcms/__new
  i32.const 80
  call $~lib/rt/__tmptostack
  i32.const 0
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#constructor
  i32.const 80
  call $~lib/rt/__localtostack
  local.set $kvPairs
  local.get $kvPairs
  i32.const 84
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 35
  call $~lib/rt/itcms/__new
  i32.const 92
  call $~lib/rt/__tmptostack
  i32.const 2592
  i32.const 2624
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair#constructor
  i32.const 88
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#push
  drop
  local.get $kvPairs
  i32.const 84
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 35
  call $~lib/rt/itcms/__new
  i32.const 92
  call $~lib/rt/__tmptostack
  i32.const 2672
  i32.const 2720
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair#constructor
  i32.const 88
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#push
  drop
  local.get $kvPairs
  i32.const 84
  call $~lib/rt/__tmptostack
  i32.const 8
  i32.const 35
  call $~lib/rt/itcms/__new
  i32.const 92
  call $~lib/rt/__tmptostack
  i32.const 2752
  i32.const 2784
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair#constructor
  i32.const 88
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#push
  drop
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 84
  call $~lib/rt/__tmptostack
  i32.const 256
  call $~lib/arraybuffer/ArrayBuffer#constructor
  i32.const 84
  call $~lib/rt/__localtostack
  local.set $rawBuf
  i32.const 0
  i32.const 1
  call $~lib/rt/itcms/__new
  i32.const 88
  call $~lib/rt/__tmptostack
  i32.const 128
  call $~lib/arraybuffer/ArrayBuffer#constructor
  call $~lib/rt/itcms/__pin
  global.set $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedBuffer
  i32.const 2880
  call $~lib/rt/itcms/__pin
  global.set $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedString
  local.get $player1
  global.set $tools/heap_analyzer/tests/fixture/dwarfFixture/globalPlayer
  i32.const 8
  i32.const 9
  call $~lib/rt/itcms/__new
  i32.const 88
  call $~lib/rt/__tmptostack
  f32.const 99
  f32.const -99
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#constructor
  i32.const 88
  call $~lib/rt/__localtostack
  local.set $localOnly1
  i32.const 8
  i32.const 10
  call $~lib/rt/itcms/__new
  i32.const 92
  call $~lib/rt/__tmptostack
  i32.const 2976
  i32.const 0
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#constructor
  i32.const 92
  call $~lib/rt/__localtostack
  local.set $localOnly2
  i32.const 16
  i32.const 23
  call $~lib/rt/itcms/__new
  i32.const 96
  call $~lib/rt/__tmptostack
  i32.const 0
  call $~lib/array/Array<~lib/string/String>#constructor
  i32.const 96
  call $~lib/rt/__localtostack
  local.set $localOnlyArr
  local.get $localOnlyArr
  i32.const 100
  call $~lib/rt/__tmptostack
  i32.const 3024
  call $~lib/array/Array<~lib/string/String>#push
  drop
  local.get $localOnlyArr
  i32.const 100
  call $~lib/rt/__tmptostack
  i32.const 3056
  call $~lib/array/Array<~lib/string/String>#push
  drop
  local.get $localOnlyArr
  i32.const 100
  call $~lib/rt/__tmptostack
  i32.const 3088
  call $~lib/array/Array<~lib/string/String>#push
  drop
  i32.const 16
  i32.const 38
  call $~lib/rt/itcms/__new
  i32.const 100
  call $~lib/rt/__tmptostack
  i32.const 1024
  call $~lib/array/Array<f64>#constructor
  i32.const 100
  call $~lib/rt/__localtostack
  local.set $bigArray
  i32.const 0
  local.set $i|31
  loop $for-loop|4
   local.get $i|31
   i32.const 1024
   i32.lt_s
   if
    local.get $bigArray
    i32.const 104
    call $~lib/rt/__tmptostack
    local.get $i|31
    block $__inlined_func$~lib/math/NativeMath.sqrt$1 (result f64)
     local.get $i|31
     f64.convert_i32_s
     local.set $36
     local.get $36
     f64.sqrt
     br $__inlined_func$~lib/math/NativeMath.sqrt$1
    end
    call $~lib/array/Array<f64>#__set
    local.get $i|31
    i32.const 1
    i32.add
    local.set $i|31
    br $for-loop|4
   end
  end
  i32.const 16
  i32.const 39
  call $~lib/rt/itcms/__new
  i32.const 104
  call $~lib/rt/__tmptostack
  i32.const 0
  call $~lib/array/Array<~lib/array/Array<i32>>#constructor
  i32.const 104
  call $~lib/rt/__localtostack
  local.set $matrix
  i32.const 0
  local.set $row
  loop $for-loop|5
   local.get $row
   i32.const 4
   i32.lt_s
   if
    i32.const 16
    i32.const 4
    call $~lib/rt/itcms/__new
    i32.const 108
    call $~lib/rt/__tmptostack
    i32.const 0
    call $~lib/array/Array<i32>#constructor
    i32.const 108
    call $~lib/rt/__localtostack
    local.set $r
    i32.const 0
    local.set $col
    loop $for-loop|6
     local.get $col
     i32.const 4
     i32.lt_s
     if
      local.get $r
      i32.const 112
      call $~lib/rt/__tmptostack
      local.get $row
      i32.const 4
      i32.mul
      local.get $col
      i32.add
      call $~lib/array/Array<i32>#push
      drop
      local.get $col
      i32.const 1
      i32.add
      local.set $col
      br $for-loop|6
     end
    end
    local.get $matrix
    i32.const 112
    call $~lib/rt/__tmptostack
    local.get $r
    i32.const 116
    call $~lib/rt/__tmptostack
    call $~lib/array/Array<~lib/array/Array<i32>>#push
    drop
    local.get $row
    i32.const 1
    i32.add
    local.set $row
    br $for-loop|5
   end
  end
  i32.const 208
  call $~lib/string/String#get:length
  i32.const 0
  i32.gt_s
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 297
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 240
  call $~lib/string/String#get:length
  i32.const 0
  i32.gt_s
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 298
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $longStr
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/string/String#get:length
  i32.const 0
  i32.gt_s
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 299
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $u8arr
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/typedarray/Uint8Array#get:length
  i32.const 64
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 300
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $f64arr
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/typedarray/Float64Array#get:length
  i32.const 16
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 301
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $i32arr
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/typedarray/Int32Array#get:length
  i32.const 32
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 302
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $staticArr
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/staticarray/StaticArray<i32>#get:length
  i32.const 10
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 303
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $items
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:length
  i32.const 5
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 304
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $characters
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:length
  i32.const 5
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 305
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $tree
  i32.const 112
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode#get:value
  i32.const 1
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 306
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $list
  i32.const 116
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode#get:data
  i32.const 112
  call $~lib/rt/__tmptostack
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
  local.get $kvPairs
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:length
  i32.const 3
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 308
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $rawBuf
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/arraybuffer/ArrayBuffer#get:byteLength
  i32.const 256
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 309
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $localOnly1
  i32.const 112
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2#get:x
  f32.const 99
  f32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 310
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $localOnly2
  i32.const 112
  call $~lib/rt/__tmptostack
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item#get:weight
  i32.const 0
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 311
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $localOnlyArr
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#get:length
  i32.const 3
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 312
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $bigArray
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<f64>#get:length
  i32.const 1024
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 313
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $matrix
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/array/Array<i32>>#get:length
  i32.const 4
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 314
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/GLOBAL_STRING
  call $~lib/string/String#get:length
  i32.const 0
  i32.gt_s
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 315
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/GLOBAL_ARRAY
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<i32>#get:length
  i32.const 5
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 316
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $primeSet
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#get:size
  i32.const 3
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 317
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $itemSet
  i32.const 112
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:size
  i32.const 3
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 318
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $scoreMap
  i32.const 112
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#get:size"
  i32.const 3
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 319
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $playerMap
  i32.const 112
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:size"
  i32.const 2
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 320
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $entityPositions
  i32.const 112
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:size"
  i32.const 3
  i32.eq
  i32.eqz
  if
   i32.const 0
   i32.const 3120
   i32.const 321
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 120
  call $~lib/rt/__increase_sp
 )
 (func $~lib/rt/itcms/__unpin (param $ptr i32)
  (local $obj i32)
  local.get $ptr
  i32.eqz
  if
   return
  end
  local.get $ptr
  i32.const 20
  i32.sub
  local.set $obj
  local.get $obj
  call $~lib/rt/itcms/Object#get:color
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
   local.get $obj
   call $~lib/rt/itcms/Object#makeGray
  else
   local.get $obj
   call $~lib/rt/itcms/Object#unlink
   local.get $obj
   global.get $~lib/rt/itcms/fromSpace
   global.get $~lib/rt/itcms/white
   call $~lib/rt/itcms/Object#linkTo
  end
 )
 (func $~lib/rt/itcms/__collect
  i32.const 0
  drop
  global.get $~lib/rt/itcms/state
  i32.const 0
  i32.gt_s
  if
   loop $while-continue|0
    global.get $~lib/rt/itcms/state
    i32.const 0
    i32.ne
    if
     call $~lib/rt/itcms/step
     drop
     br $while-continue|0
    end
   end
  end
  call $~lib/rt/itcms/step
  drop
  block $while-break|1
   loop $while-continue|1
    global.get $~lib/rt/itcms/state
    i32.const 0
    i32.ne
    if
     call $~lib/rt/itcms/step
     drop
     br $while-continue|1
    end
   end
  end
  global.get $~lib/rt/itcms/total
  i64.extend_i32_u
  i32.const 200
  i64.extend_i32_u
  i64.mul
  i64.const 100
  i64.div_u
  i32.wrap_i64
  i32.const 1024
  i32.add
  global.set $~lib/rt/itcms/threshold
  i32.const 0
  drop
 )
 (func $~lib/rt/__visit_globals (param $0 i32)
  (local $1 i32)
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/GLOBAL_STRING
  local.tee $1
  if
   local.get $1
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/GLOBAL_ARRAY
  local.tee $1
  if
   local.get $1
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/globalPlayer
  local.tee $1
  if
   local.get $1
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/globalTree
  local.tee $1
  if
   local.get $1
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedBuffer
  local.tee $1
  if
   local.get $1
   local.get $0
   call $~lib/rt/itcms/__visit
  end
  global.get $tools/heap_analyzer/tests/fixture/dwarfFixture/pinnedString
  local.tee $1
  if
   local.get $1
   local.get $0
   call $~lib/rt/itcms/__visit
  end
 )
 (func $~lib/arraybuffer/ArrayBufferView~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  i32.load
  local.get $1
  call $~lib/rt/itcms/__visit
 )
 (func $~lib/object/Object~visit (param $0 i32) (param $1 i32)
  nop
 )
 (func $~lib/array/Array<i32>#get:buffer (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/array/Array<i32>#__visit (param $this i32) (param $cookie i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 0
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<i32>#get:buffer
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<i32>~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/array/Array<i32>#__visit
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Player~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character~visit
  local.get $0
  i32.load offset=16
  local.get $1
  call $~lib/rt/itcms/__visit
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Character~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity~visit
  local.get $0
  i32.load offset=8
  local.get $1
  call $~lib/rt/itcms/__visit
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  i32.load offset=4
  local.get $1
  call $~lib/rt/itcms/__visit
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/Item~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  i32.load
  local.get $1
  call $~lib/rt/itcms/__visit
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:buffer (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#__visit (param $this i32) (param $cookie i32)
  (local $cur i32)
  (local $end i32)
  (local $val i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:dataStart
  local.set $cur
  local.get $cur
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:length_
  i32.const 2
  i32.shl
  i32.add
  local.set $end
  block $while-break|0
   loop $while-continue|0
    local.get $cur
    local.get $end
    i32.lt_u
    if
     local.get $cur
     i32.load
     local.set $val
     local.get $val
     if
      local.get $val
      local.get $cookie
      call $~lib/rt/itcms/__visit
     end
     local.get $cur
     i32.const 4
     i32.add
     local.set $cur
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:buffer
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#__visit
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  i32.load offset=4
  local.get $1
  call $~lib/rt/itcms/__visit
  local.get $0
  i32.load offset=8
  local.get $1
  call $~lib/rt/itcms/__visit
 )
 (func $~lib/typedarray/Uint8Array~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/arraybuffer/ArrayBufferView~visit
 )
 (func $~lib/typedarray/Float64Array~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/arraybuffer/ArrayBufferView~visit
 )
 (func $~lib/typedarray/Int32Array~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/arraybuffer/ArrayBufferView~visit
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character~visit
  local.get $0
  i32.load offset=16
  local.get $1
  call $~lib/rt/itcms/__visit
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:buffer (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#__visit (param $this i32) (param $cookie i32)
  (local $cur i32)
  (local $end i32)
  (local $val i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:dataStart
  local.set $cur
  local.get $cur
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:length_
  i32.const 2
  i32.shl
  i32.add
  local.set $end
  block $while-break|0
   loop $while-continue|0
    local.get $cur
    local.get $end
    i32.lt_u
    if
     local.get $cur
     i32.load
     local.set $val
     local.get $val
     if
      local.get $val
      local.get $cookie
      call $~lib/rt/itcms/__visit
     end
     local.get $cur
     i32.const 4
     i32.add
     local.set $cur
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#get:buffer
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>#__visit
 )
 (func $~lib/array/Array<~lib/string/String>#get:buffer (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/array/Array<~lib/string/String>#__visit (param $this i32) (param $cookie i32)
  (local $cur i32)
  (local $end i32)
  (local $val i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#get:dataStart
  local.set $cur
  local.get $cur
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#get:length_
  i32.const 2
  i32.shl
  i32.add
  local.set $end
  block $while-break|0
   loop $while-continue|0
    local.get $cur
    local.get $end
    i32.lt_u
    if
     local.get $cur
     i32.load
     local.set $val
     local.get $val
     if
      local.get $val
      local.get $cookie
      call $~lib/rt/itcms/__visit
     end
     local.get $cur
     i32.const 4
     i32.add
     local.set $cur
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/string/String>#get:buffer
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<~lib/string/String>~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/array/Array<~lib/string/String>#__visit
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  i32.load
  local.get $1
  call $~lib/rt/itcms/__visit
  local.get $0
  i32.load offset=4
  local.get $1
  call $~lib/rt/itcms/__visit
 )
 (func $~lib/set/Set<i32>#__visit (param $this i32) (param $cookie i32)
  (local $entries i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#get:buckets
  local.get $cookie
  call $~lib/rt/itcms/__visit
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<i32>#get:entries
  local.set $entries
  i32.const 0
  drop
  local.get $entries
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/set/Set<i32>~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/set/Set<i32>#__visit
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#__visit (param $this i32) (param $cookie i32)
  (local $entries i32)
  (local $cur i32)
  (local $end i32)
  (local $entry i32)
  (local $val i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:buckets
  local.get $cookie
  call $~lib/rt/itcms/__visit
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entries
  local.set $entries
  i32.const 1
  drop
  local.get $entries
  local.set $cur
  local.get $cur
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:entriesOffset
  block $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1 (result i32)
   i32.const 0
   local.set $7
   i32.const 0
   local.set $8
   block $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1 (result i32)
    i32.const 3
    br $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1
   end
   local.set $7
   i32.const 8
   local.get $7
   i32.add
   local.get $7
   i32.const -1
   i32.xor
   i32.and
   local.set $8
   local.get $8
   br $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$1
  end
  i32.mul
  i32.add
  local.set $end
  block $while-break|0
   loop $while-continue|0
    local.get $cur
    local.get $end
    i32.lt_u
    if
     local.get $cur
     local.set $entry
     local.get $entry
     call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:taggedNext
     i32.const 1
     i32.and
     i32.eqz
     if
      local.get $entry
      call $~lib/set/SetEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#get:key
      local.set $val
      i32.const 0
      drop
      local.get $val
      local.get $cookie
      call $~lib/rt/itcms/__visit
     end
     local.get $cur
     block $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$2 (result i32)
      i32.const 0
      local.set $9
      i32.const 0
      local.set $10
      block $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$10 (result i32)
       i32.const 3
       br $__inlined_func$~lib/set/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$10
      end
      local.set $9
      i32.const 8
      local.get $9
      i32.add
      local.get $9
      i32.const -1
      i32.xor
      i32.and
      local.set $10
      local.get $10
      br $__inlined_func$~lib/set/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>$2
     end
     i32.add
     local.set $cur
     br $while-continue|0
    end
   end
  end
  local.get $entries
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>#__visit
 )
 (func $"~lib/map/Map<i32,i32>#__visit" (param $this i32) (param $cookie i32)
  (local $entries i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#get:buckets"
  local.get $cookie
  call $~lib/rt/itcms/__visit
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<i32,i32>#get:entries"
  local.set $entries
  i32.const 0
  drop
  local.get $entries
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $"~lib/map/Map<i32,i32>~visit" (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $"~lib/map/Map<i32,i32>#__visit"
 )
 (func $~lib/tuple/SmallTuple#__visit (param $this i32) (param $cookie i32)
  (local $rtSize i32)
  (local $elemntCount i32)
  (local $bitmap i64)
  (local $i i32)
  (local $elementPtr i32)
  local.get $this
  i32.const 20
  i32.sub
  call $~lib/rt/common/OBJECT#get:rtSize
  local.set $rtSize
  local.get $rtSize
  i32.const 8
  i32.sub
  i32.const 2
  i32.shr_u
  local.set $elemntCount
  local.get $this
  local.get $rtSize
  i32.add
  i32.const 8
  i32.sub
  i64.load
  local.set $bitmap
  i32.const 0
  local.set $i
  loop $for-loop|0
   local.get $i
   local.get $elemntCount
   i32.lt_u
   if
    local.get $bitmap
    i64.const 1
    local.get $i
    i64.extend_i32_u
    i64.shl
    i64.and
    i64.const 0
    i64.ne
    if
     local.get $this
     local.get $i
     i32.const 2
     i32.shl
     i32.add
     local.set $elementPtr
     local.get $elementPtr
     i32.load
     local.get $cookie
     call $~lib/rt/itcms/__visit
    end
    local.get $i
    i32.const 1
    i32.add
    local.set $i
    br $for-loop|0
   end
  end
 )
 (func $~lib/tuple/SmallTuple~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/tuple/SmallTuple#__visit
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#__visit" (param $this i32) (param $cookie i32)
  (local $entries i32)
  (local $cur i32)
  (local $end i32)
  (local $entry i32)
  (local $val i32)
  (local $val|7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:buckets"
  local.get $cookie
  call $~lib/rt/itcms/__visit
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entries"
  local.set $entries
  i32.const 1
  drop
  local.get $entries
  local.set $cur
  local.get $cur
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:entriesOffset"
  block $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1" (result i32)
   i32.const 0
   local.set $8
   i32.const 0
   local.set $9
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1"
   end
   local.set $8
   i32.const 12
   local.get $8
   i32.add
   local.get $8
   i32.const -1
   i32.xor
   i32.and
   local.set $9
   local.get $9
   br $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$1"
  end
  i32.mul
  i32.add
  local.set $end
  block $while-break|0
   loop $while-continue|0
    local.get $cur
    local.get $end
    i32.lt_u
    if
     local.get $cur
     local.set $entry
     local.get $entry
     call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:taggedNext"
     i32.const 1
     i32.and
     i32.eqz
     if
      i32.const 1
      drop
      local.get $entry
      call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:key"
      local.set $val
      i32.const 0
      drop
      local.get $val
      local.get $cookie
      call $~lib/rt/itcms/__visit
      i32.const 1
      drop
      local.get $entry
      call $"~lib/map/MapEntry<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#get:value"
      local.set $val|7
      i32.const 0
      drop
      local.get $val|7
      local.get $cookie
      call $~lib/rt/itcms/__visit
     end
     local.get $cur
     block $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$2" (result i32)
      i32.const 0
      local.set $10
      i32.const 0
      local.set $11
      block $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$10" (result i32)
       i32.const 3
       br $"__inlined_func$~lib/map/ENTRY_ALIGN<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$10"
      end
      local.set $10
      i32.const 12
      local.get $10
      i32.add
      local.get $10
      i32.const -1
      i32.xor
      i32.and
      local.set $11
      local.get $11
      br $"__inlined_func$~lib/map/ENTRY_SIZE<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>$2"
     end
     i32.add
     local.set $cur
     br $while-continue|0
    end
   end
  end
  local.get $entries
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>~visit" (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>#__visit"
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#__visit" (param $this i32) (param $cookie i32)
  (local $entries i32)
  (local $cur i32)
  (local $end i32)
  (local $entry i32)
  (local $val i32)
  (local $val|7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:buckets"
  local.get $cookie
  call $~lib/rt/itcms/__visit
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entries"
  local.set $entries
  i32.const 1
  drop
  local.get $entries
  local.set $cur
  local.get $cur
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:entriesOffset"
  block $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1" (result i32)
   i32.const 0
   local.set $8
   i32.const 0
   local.set $9
   block $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1" (result i32)
    i32.const 3
    br $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1"
   end
   local.set $8
   i32.const 12
   local.get $8
   i32.add
   local.get $8
   i32.const -1
   i32.xor
   i32.and
   local.set $9
   local.get $9
   br $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$1"
  end
  i32.mul
  i32.add
  local.set $end
  block $while-break|0
   loop $while-continue|0
    local.get $cur
    local.get $end
    i32.lt_u
    if
     local.get $cur
     local.set $entry
     local.get $entry
     call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:taggedNext"
     i32.const 1
     i32.and
     i32.eqz
     if
      i32.const 1
      drop
      local.get $entry
      call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:key"
      local.set $val
      i32.const 0
      drop
      local.get $val
      local.get $cookie
      call $~lib/rt/itcms/__visit
      i32.const 1
      drop
      local.get $entry
      call $"~lib/map/MapEntry<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#get:value"
      local.set $val|7
      i32.const 0
      drop
      local.get $val|7
      local.get $cookie
      call $~lib/rt/itcms/__visit
     end
     local.get $cur
     block $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$2" (result i32)
      i32.const 0
      local.set $10
      i32.const 0
      local.set $11
      block $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$10" (result i32)
       i32.const 3
       br $"__inlined_func$~lib/map/ENTRY_ALIGN<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$10"
      end
      local.set $10
      i32.const 12
      local.get $10
      i32.add
      local.get $10
      i32.const -1
      i32.xor
      i32.and
      local.set $11
      local.get $11
      br $"__inlined_func$~lib/map/ENTRY_SIZE<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>$2"
     end
     i32.add
     local.set $cur
     br $while-continue|0
    end
   end
  end
  local.get $entries
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>~visit" (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>#__visit"
 )
 (func $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  i32.load
  local.get $1
  call $~lib/rt/itcms/__visit
  local.get $0
  i32.load offset=4
  local.get $1
  call $~lib/rt/itcms/__visit
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:buffer (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#__visit (param $this i32) (param $cookie i32)
  (local $cur i32)
  (local $end i32)
  (local $val i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:dataStart
  local.set $cur
  local.get $cur
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:length_
  i32.const 2
  i32.shl
  i32.add
  local.set $end
  block $while-break|0
   loop $while-continue|0
    local.get $cur
    local.get $end
    i32.lt_u
    if
     local.get $cur
     i32.load
     local.set $val
     local.get $val
     if
      local.get $val
      local.get $cookie
      call $~lib/rt/itcms/__visit
     end
     local.get $cur
     i32.const 4
     i32.add
     local.set $cur
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#get:buffer
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>#__visit
 )
 (func $~lib/array/Array<f64>#get:buffer (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/array/Array<f64>#__visit (param $this i32) (param $cookie i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 0
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<f64>#get:buffer
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<f64>~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/array/Array<f64>#__visit
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#get:buffer (param $this i32) (result i32)
  local.get $this
  i32.load
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#__visit (param $this i32) (param $cookie i32)
  (local $cur i32)
  (local $end i32)
  (local $val i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  i32.const 1
  drop
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/array/Array<i32>>#get:dataStart
  local.set $cur
  local.get $cur
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/array/Array<i32>>#get:length_
  i32.const 2
  i32.shl
  i32.add
  local.set $end
  block $while-break|0
   loop $while-continue|0
    local.get $cur
    local.get $end
    i32.lt_u
    if
     local.get $cur
     i32.load
     local.set $val
     local.get $val
     if
      local.get $val
      local.get $cookie
      call $~lib/rt/itcms/__visit
     end
     local.get $cur
     i32.const 4
     i32.add
     local.set $cur
     br $while-continue|0
    end
   end
  end
  local.get $this
  i32.const 0
  call $~lib/rt/__tmptostack
  call $~lib/array/Array<~lib/array/Array<i32>>#get:buffer
  local.get $cookie
  call $~lib/rt/itcms/__visit
  i32.const 4
  call $~lib/rt/__increase_sp
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>~visit (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/object/Object~visit
  local.get $0
  local.get $1
  call $~lib/array/Array<~lib/array/Array<i32>>#__visit
 )
 (func $~lib/rt/__visit_members (param $0 i32) (param $1 i32)
  block $invalid
   block $~lib/iterator/Iterable<~lib/array/Array<i32>>
    block $~lib/array/Array<~lib/array/Array<i32>>
     block $~lib/array/Array<f64>
      block $~lib/iterator/Iterable<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>
       block $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>
        block $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair
         block $"~lib/iterator/Iterable<[tools/heap_analyzer/tests/fixture/dwarfFixture/Character, tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2]>"
          block $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>"
           block $"~lib/iterator/Iterable<[~lib/string/String, tools/heap_analyzer/tests/fixture/dwarfFixture/Player]>"
            block $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>"
             block $"~lib/iterator/Iterable<[i32, i32]>"
              block $~lib/tuple/SmallTuple
               block $"~lib/map/Map<i32,i32>"
                block $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>
                 block $~lib/set/Set<i32>
                  block $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode
                   block $~lib/iterator/Iterable<~lib/string/String>
                    block $~lib/array/Array<~lib/string/String>
                     block $~lib/iterator/Iterable<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>
                      block $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>
                       block $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC
                        block $~lib/staticarray/StaticArray<i32>
                         block $~lib/typedarray/Int32Array
                          block $~lib/iterator/Iterable<f64>
                           block $~lib/typedarray/Float64Array
                            block $~lib/iterator/Iterable<u8>
                             block $~lib/typedarray/Uint8Array
                              block $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode
                               block $~lib/iterator/Iterable<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>
                                block $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>
                                 block $tools/heap_analyzer/tests/fixture/dwarfFixture/Item
                                  block $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2
                                   block $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity
                                    block $tools/heap_analyzer/tests/fixture/dwarfFixture/Character
                                     block $tools/heap_analyzer/tests/fixture/dwarfFixture/Player
                                      block $~lib/iterator/Iterable<i32>
                                       block $~lib/array/Array<i32>
                                        block $~lib/arraybuffer/ArrayBufferView
                                         block $~lib/string/String
                                          block $~lib/arraybuffer/ArrayBuffer
                                           block $~lib/object/Object
                                            local.get $0
                                            i32.const 8
                                            i32.sub
                                            i32.load
                                            br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $~lib/array/Array<i32> $~lib/iterator/Iterable<i32> $tools/heap_analyzer/tests/fixture/dwarfFixture/Player $tools/heap_analyzer/tests/fixture/dwarfFixture/Character $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity $tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2 $tools/heap_analyzer/tests/fixture/dwarfFixture/Item $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item> $~lib/iterator/Iterable<tools/heap_analyzer/tests/fixture/dwarfFixture/Item> $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode $~lib/typedarray/Uint8Array $~lib/iterator/Iterable<u8> $~lib/typedarray/Float64Array $~lib/iterator/Iterable<f64> $~lib/typedarray/Int32Array $~lib/staticarray/StaticArray<i32> $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character> $~lib/iterator/Iterable<tools/heap_analyzer/tests/fixture/dwarfFixture/Character> $~lib/array/Array<~lib/string/String> $~lib/iterator/Iterable<~lib/string/String> $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode $~lib/set/Set<i32> $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item> $"~lib/map/Map<i32,i32>" $~lib/tuple/SmallTuple $"~lib/iterator/Iterable<[i32, i32]>" $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>" $"~lib/iterator/Iterable<[~lib/string/String, tools/heap_analyzer/tests/fixture/dwarfFixture/Player]>" $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>" $"~lib/iterator/Iterable<[tools/heap_analyzer/tests/fixture/dwarfFixture/Character, tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2]>" $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair> $~lib/iterator/Iterable<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair> $~lib/array/Array<f64> $~lib/array/Array<~lib/array/Array<i32>> $~lib/iterator/Iterable<~lib/array/Array<i32>> $invalid
                                           end
                                           return
                                          end
                                          return
                                         end
                                         return
                                        end
                                        local.get $0
                                        local.get $1
                                        call $~lib/arraybuffer/ArrayBufferView~visit
                                        return
                                       end
                                       local.get $0
                                       local.get $1
                                       call $~lib/array/Array<i32>~visit
                                       return
                                      end
                                      return
                                     end
                                     local.get $0
                                     local.get $1
                                     call $tools/heap_analyzer/tests/fixture/dwarfFixture/Player~visit
                                     return
                                    end
                                    local.get $0
                                    local.get $1
                                    call $tools/heap_analyzer/tests/fixture/dwarfFixture/Character~visit
                                    return
                                   end
                                   local.get $0
                                   local.get $1
                                   call $tools/heap_analyzer/tests/fixture/dwarfFixture/Entity~visit
                                   return
                                  end
                                  return
                                 end
                                 local.get $0
                                 local.get $1
                                 call $tools/heap_analyzer/tests/fixture/dwarfFixture/Item~visit
                                 return
                                end
                                local.get $0
                                local.get $1
                                call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>~visit
                                return
                               end
                               return
                              end
                              local.get $0
                              local.get $1
                              call $tools/heap_analyzer/tests/fixture/dwarfFixture/TreeNode~visit
                              return
                             end
                             local.get $0
                             local.get $1
                             call $~lib/typedarray/Uint8Array~visit
                             return
                            end
                            return
                           end
                           local.get $0
                           local.get $1
                           call $~lib/typedarray/Float64Array~visit
                           return
                          end
                          return
                         end
                         local.get $0
                         local.get $1
                         call $~lib/typedarray/Int32Array~visit
                         return
                        end
                        return
                       end
                       local.get $0
                       local.get $1
                       call $tools/heap_analyzer/tests/fixture/dwarfFixture/NPC~visit
                       return
                      end
                      local.get $0
                      local.get $1
                      call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/Character>~visit
                      return
                     end
                     return
                    end
                    local.get $0
                    local.get $1
                    call $~lib/array/Array<~lib/string/String>~visit
                    return
                   end
                   return
                  end
                  local.get $0
                  local.get $1
                  call $tools/heap_analyzer/tests/fixture/dwarfFixture/ListNode~visit
                  return
                 end
                 local.get $0
                 local.get $1
                 call $~lib/set/Set<i32>~visit
                 return
                end
                local.get $0
                local.get $1
                call $~lib/set/Set<tools/heap_analyzer/tests/fixture/dwarfFixture/Item>~visit
                return
               end
               local.get $0
               local.get $1
               call $"~lib/map/Map<i32,i32>~visit"
               return
              end
              local.get $0
              local.get $1
              call $~lib/tuple/SmallTuple~visit
              return
             end
             return
            end
            local.get $0
            local.get $1
            call $"~lib/map/Map<~lib/string/String,tools/heap_analyzer/tests/fixture/dwarfFixture/Player>~visit"
            return
           end
           return
          end
          local.get $0
          local.get $1
          call $"~lib/map/Map<tools/heap_analyzer/tests/fixture/dwarfFixture/Character,tools/heap_analyzer/tests/fixture/dwarfFixture/Vector2>~visit"
          return
         end
         return
        end
        local.get $0
        local.get $1
        call $tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair~visit
        return
       end
       local.get $0
       local.get $1
       call $~lib/array/Array<tools/heap_analyzer/tests/fixture/dwarfFixture/KVPair>~visit
       return
      end
      return
     end
     local.get $0
     local.get $1
     call $~lib/array/Array<f64>~visit
     return
    end
    local.get $0
    local.get $1
    call $~lib/array/Array<~lib/array/Array<i32>>~visit
    return
   end
   return
  end
  unreachable
 )
 (func $~start
  memory.size
  i32.const 16
  i32.shl
  global.get $~lib/memory/__heap_base
  i32.sub
  i32.const 1
  i32.shr_u
  global.set $~lib/rt/itcms/threshold
  i32.const 528
  call $~lib/rt/itcms/initLazy
  global.set $~lib/rt/itcms/pinSpace
  i32.const 560
  call $~lib/rt/itcms/initLazy
  global.set $~lib/rt/itcms/toSpace
  i32.const 704
  call $~lib/rt/itcms/initLazy
  global.set $~lib/rt/itcms/fromSpace
 )
 (func $~lib/rt/__localtostack (param $0 i32) (param $1 i32) (result i32)
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.add
  local.get $0
  i32.store align=1
  local.get $0
 )
 (func $~lib/rt/__tmptostack (param $0 i32) (param $1 i32) (result i32)
  global.get $~lib/memory/__stack_pointer
  local.get $1
  i32.add
  local.get $0
  i32.store align=1
  local.get $0
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
  global.get $~lib/memory/__data_end
  i32.lt_s
  if
   unreachable
  end
 )
 (func $~lib/rt/__increase_sp (param $0 i32)
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
)
