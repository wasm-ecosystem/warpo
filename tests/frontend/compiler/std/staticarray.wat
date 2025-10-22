(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32) (result i32)))
 (type $4 (func (param i32 i32 i32 i32) (result i32)))
 (type $5 (func (param i32 i32 i32)))
 (type $6 (func (param i32)))
 (type $7 (func))
 (type $8 (func (param i32 i32 i32 i32)))
 (type $9 (func (result i32)))
 (type $10 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $11 (func (param i32 i32 i32 i32 i32)))
 (type $12 (func (param i32 i32 i64) (result i32)))
 (type $13 (func (param i32 f64 i32) (result i32)))
 (type $14 (func (param i32 f32 i32) (result i32)))
 (type $15 (func (param i32 i32 i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $std/staticarray/arr1 i32 (i32.const 32))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Minimal i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $std/staticarray/arr2 i32 (i32.const 256))
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
 (global $std/staticarray/arr3 (mut i32) (i32.const 0))
 (global $std/staticarray/arr4 (mut i32) (i32.const 0))
 (global $~lib/native/ASC_RUNTIME i32 (i32.const 2))
 (global $~lib/builtins/i32.MAX_VALUE i32 (i32.const 2147483647))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $std/staticarray/maxVal (mut i32) (i32.const 0))
 (global $~lib/builtins/u32.MAX_VALUE i32 (i32.const -1))
 (global $~lib/rt/__rtti_base i32 (i32.const 2864))
 (global $~lib/memory/__data_end i32 (i32.const 2936))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 35704))
 (global $~lib/memory/__heap_base i32 (i32.const 35704))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00")
 (data $1 (i32.const 44) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 108) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00s\00t\00a\00t\00i\00c\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00\00\00\00\00")
 (data $3 (i32.const 172) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00s\00t\00d\00/\00s\00t\00a\00t\00i\00c\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 236) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00")
 (data $5 (i32.const 268) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\0c\00\00\00\05\00\00\00\06\00\00\00\07\00\00\00")
 (data $6 (i32.const 300) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $7 (i32.const 364) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 432) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 464) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $10 (i32.const 492) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $11 (i32.const 544) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $12 (i32.const 572) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $13 (i32.const 636) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00")
 (data $14 (i32.const 684) ",\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\18\00\00\00\00\00\00\00\01\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00\05\00\00\00\00\00\00\00")
 (data $15 (i32.const 732) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00")
 (data $16 (i32.const 780) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $17 (i32.const 812) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\02\00\00\00\00\00\00\00")
 (data $18 (i32.const 844) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\04\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $19 (i32.const 876) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $20 (i32.const 908) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\001\00\00\00\00\00\00\00\00\00\00\00")
 (data $21 (i32.const 940) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\002\00\00\00\00\00\00\00\00\00\00\00")
 (data $22 (i32.const 972) "\1c\00\00\00\00\00\00\00\00\00\00\00\08\00\00\00\08\00\00\00\a0\03\00\00\c0\03\00\00\00\00\00\00")
 (data $23 (i32.const 1004) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\003\00\00\00\00\00\00\00\00\00\00\00")
 (data $24 (i32.const 1036) "\1c\00\00\00\00\00\00\00\00\00\00\00\08\00\00\00\04\00\00\00\00\04\00\00\00\00\00\00\00\00\00\00")
 (data $25 (i32.const 1068) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00a\00n\00t\00\00\00\00\00\00\00")
 (data $26 (i32.const 1100) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00b\00i\00s\00o\00n\00\00\00")
 (data $27 (i32.const 1132) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00c\00a\00m\00e\00l\00\00\00")
 (data $28 (i32.const 1164) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00d\00u\00c\00k\00\00\00\00\00")
 (data $29 (i32.const 1196) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00e\00l\00e\00p\00h\00a\00n\00t\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $30 (i32.const 1244) ",\00\00\00\00\00\00\00\00\00\00\00\08\00\00\00\14\00\00\00@\04\00\00`\04\00\00\80\04\00\00\a0\04\00\00\c0\04\00\00\00\00\00\00\00\00\00\00")
 (data $31 (i32.const 1292) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $32 (i32.const 1420) ",\00\00\00\00\00\00\00\00\00\00\00\08\00\00\00\14\00\00\00@\04\00\00`\04\00\00\80\04\00\00\a0\04\00\00\c0\04\00\00\00\00\00\00\00\00\00\00")
 (data $33 (i32.const 1468) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $34 (i32.const 1500) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00f\00o\00o\00\00\00\00\00\00\00")
 (data $35 (i32.const 1532) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\04\00\00\00\f0\05\00\00\00\00\00\00\00\00\00\00")
 (data $36 (i32.const 1564) ",\00\00\00\00\00\00\00\00\00\00\00\08\00\00\00\14\00\00\00@\04\00\00`\04\00\00\80\04\00\00\a0\04\00\00\c0\04\00\00\00\00\00\00\00\00\00\00")
 (data $37 (i32.const 1612) "\1c\00\00\00\00\00\00\00\00\00\00\00\n\00\00\00\08\00\00\00\00\00\00\00\00\00\f8\7f\00\00\00\00")
 (data $38 (i32.const 1644) "\1c\00\00\00\00\00\00\00\00\00\00\00\0b\00\00\00\04\00\00\00\00\00\c0\7f\00\00\00\00\00\00\00\00")
 (data $39 (i32.const 1676) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\0c\00\00\00\02\00\00\00\t\00\00\00\t\00\00\00")
 (data $40 (i32.const 1708) ",\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\10\00\00\00\02\00\00\00\05\00\00\00\t\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $41 (i32.const 1756) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00F\00i\00r\00e\00\00\00\00\00")
 (data $42 (i32.const 1788) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00A\00i\00r\00\00\00\00\00\00\00")
 (data $43 (i32.const 1820) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00W\00a\00t\00e\00r\00\00\00")
 (data $44 (i32.const 1852) "\1c\00\00\00\00\00\00\00\00\00\00\00\08\00\00\00\0c\00\00\00\f0\06\00\00\10\07\00\000\07\00\00")
 (data $45 (i32.const 1884) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $46 (i32.const 1916) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00,\00\00\00\00\00\00\00\00\00\00\00")
 (data $47 (i32.const 1948) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00F\00i\00r\00e\00,\00A\00i\00r\00,\00W\00a\00t\00e\00r\00")
 (data $48 (i32.const 1996) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\18\00\00\00F\00i\00r\00e\00A\00i\00r\00W\00a\00t\00e\00r\00\00\00\00\00")
 (data $49 (i32.const 2044) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00-\00\00\00\00\00\00\00\00\00\00\00")
 (data $50 (i32.const 2076) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00F\00i\00r\00e\00-\00A\00i\00r\00-\00W\00a\00t\00e\00r\00")
 (data $51 (i32.const 2124) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00 \00+\00 \00\00\00\00\00\00\00")
 (data $52 (i32.const 2156) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00F\00i\00r\00e\00 \00+\00 \00A\00i\00r\00 \00+\00 \00W\00a\00t\00e\00r\00\00\00\00\00\00\00\00\00")
 (data $53 (i32.const 2220) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $54 (i32.const 2252) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00")
 (data $55 (i32.const 2284) ",\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\14\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00\04\00\00\00\05\00\00\00\00\00\00\00\00\00\00\00")
 (data $56 (i32.const 2332) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\0c\00\00\00\01\00\00\00\02\00\00\00\03\00\00\00")
 (data $57 (i32.const 2364) "\1c\00\00\00\00\00\00\00\00\00\00\00\0c\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $58 (i32.const 2396) "\1c\00\00\00\00\00\00\00\00\00\00\00\r\00\00\00\08\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00")
 (data $59 (i32.const 2428) "\1c\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\08\00\00\00\03\00\00\00\00\00\00\00\00\00\00\00")
 (data $60 (i32.const 2460) "\1c\00\00\00\00\00\00\00\00\00\00\00\0f\00\00\00\08\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00")
 (data $61 (i32.const 2492) "\1c\00\00\00\00\00\00\00\00\00\00\00\0f\00\00\00\08\00\00\00\05\00\00\00\00\00\00\00\00\00\00\00")
 (data $62 (i32.const 2524) "\1c\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\08\00\00\00\06\00\00\00\00\00\00\00\00\00\00\00")
 (data $63 (i32.const 2556) "\1c\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\08\00\00\00\07\00\00\00\00\00\00\00\00\00\00\00")
 (data $64 (i32.const 2588) "\1c\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\08\00\00\00\08\00\00\00\00\00\00\00\00\00\00\00")
 (data $65 (i32.const 2620) "\1c\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\08\00\00\00\t\00\00\00\00\00\00\00\00\00\00\00")
 (data $66 (i32.const 2652) "\1c\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\08\00\00\00\n\00\00\00\00\00\00\00\00\00\00\00")
 (data $67 (i32.const 2684) "\1c\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\08\00\00\00\0b\00\00\00\00\00\00\00\00\00\00\00")
 (data $68 (i32.const 2716) "\1c\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\08\00\00\00\0c\00\00\00\00\00\00\00\00\00\00\00")
 (data $69 (i32.const 2748) "\1c\00\00\00\00\00\00\00\00\00\00\00\0e\00\00\00\08\00\00\00\r\00\00\00\00\00\00\00\00\00\00\00")
 (data $70 (i32.const 2780) ",\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\10\00\00\00\00\00\00\00\03\00\00\00\02\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $71 (i32.const 2828) "\1c\00\00\00\00\00\00\00\00\00\00\00\10\00\00\00\08\00\00\00\0e\00\00\00\00\00\00\00\00\00\00\00")
 (data $72 (i32.const 2864) "\11\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00$\t\00\00 \00\00\00\04A\00\00\02\t\00\00\04A\00\00\02A\00\00$\1a\00\00$\19\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 15 15 funcref)
 (elem $0 (i32.const 1) $start:std/staticarray~anonymous|0 $start:std/staticarray~anonymous|1 $start:std/staticarray~anonymous|2 $start:std/staticarray~anonymous|3 $start:std/staticarray~anonymous|4 $start:std/staticarray~anonymous|5 $start:std/staticarray~anonymous|6 $start:std/staticarray~anonymous|7 $start:std/staticarray~anonymous|8 $start:std/staticarray~anonymous|9 $start:std/staticarray~anonymous|10 $start:std/staticarray~anonymous|11 $start:std/staticarray~anonymous|12 $~lib/util/sort/COMPARATOR<i32>~anonymous|0)
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/common/OBJECT#get:rtSize (param $this i32) (result i32)
  (i32.load offset=16
   (local.get $this)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#get:length (param $this i32) (result i32)
  (return
   (i32.shr_u
    (call $~lib/rt/common/OBJECT#get:rtSize
     (i32.sub
      (local.get $this)
      (i32.const 20)
     )
    )
    (i32.const 2)
   )
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 64)
     (i32.const 128)
     (i32.const 78)
     (i32.const 41)
    )
    (unreachable)
   )
  )
  (local.set $value
   (i32.load
    (i32.add
     (local.get $this)
     (i32.shl
      (local.get $index)
      (i32.const 2)
     )
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (return
   (local.get $value)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#__uset (param $this i32) (param $index i32) (param $value i32)
  (i32.store
   (i32.add
    (local.get $this)
    (i32.shl
     (local.get $index)
     (i32.const 2)
    )
   )
   (local.get $value)
  )
  (drop
   (i32.const 0)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#__set (param $this i32) (param $index i32) (param $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 64)
     (i32.const 128)
     (i32.const 93)
     (i32.const 41)
    )
    (unreachable)
   )
  )
  (call $~lib/staticarray/StaticArray<i32>#__uset
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $index)
   (local.get $value)
  )
 )
 (func $~lib/rt/common/OBJECT#get:rtId (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/rt/itcms/Object#set:nextWithColor (param $this i32) (param $nextWithColor i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $nextWithColor)
  )
 )
 (func $~lib/rt/itcms/Object#set:prev (param $this i32) (param $prev i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $prev)
  )
 )
 (func $~lib/rt/itcms/initLazy (param $space i32) (result i32)
  (call $~lib/rt/itcms/Object#set:nextWithColor
   (local.get $space)
   (local.get $space)
  )
  (call $~lib/rt/itcms/Object#set:prev
   (local.get $space)
   (local.get $space)
  )
  (return
   (local.get $space)
  )
 )
 (func $~lib/rt/itcms/Object#get:nextWithColor (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/rt/itcms/Object#get:next (param $this i32) (result i32)
  (return
   (i32.and
    (call $~lib/rt/itcms/Object#get:nextWithColor
     (local.get $this)
    )
    (i32.xor
     (i32.const 3)
     (i32.const -1)
    )
   )
  )
 )
 (func $~lib/rt/itcms/Object#get:color (param $this i32) (result i32)
  (return
   (i32.and
    (call $~lib/rt/itcms/Object#get:nextWithColor
     (local.get $this)
    )
    (i32.const 3)
   )
  )
 )
 (func $~lib/rt/itcms/visitRoots (param $cookie i32)
  (local $pn i32)
  (local $iter i32)
  (call $~lib/rt/__visit_globals
   (local.get $cookie)
  )
  (local.set $pn
   (global.get $~lib/rt/itcms/pinSpace)
  )
  (local.set $iter
   (call $~lib/rt/itcms/Object#get:next
    (local.get $pn)
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.ne
      (local.get $iter)
      (local.get $pn)
     )
     (then
      (drop
       (i32.const 1)
      )
      (if
       (i32.eqz
        (i32.eq
         (call $~lib/rt/itcms/Object#get:color
          (local.get $iter)
         )
         (i32.const 3)
        )
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 0)
         (i32.const 384)
         (i32.const 160)
         (i32.const 16)
        )
        (unreachable)
       )
      )
      (call $~lib/rt/__visit_members
       (i32.add
        (local.get $iter)
        (i32.const 20)
       )
       (local.get $cookie)
      )
      (local.set $iter
       (call $~lib/rt/itcms/Object#get:next
        (local.get $iter)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
 )
 (func $~lib/rt/itcms/Object#set:color (param $this i32) (param $color i32)
  (call $~lib/rt/itcms/Object#set:nextWithColor
   (local.get $this)
   (i32.or
    (i32.and
     (call $~lib/rt/itcms/Object#get:nextWithColor
      (local.get $this)
     )
     (i32.xor
      (i32.const 3)
      (i32.const -1)
     )
    )
    (local.get $color)
   )
  )
 )
 (func $~lib/rt/itcms/Object#get:prev (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $~lib/rt/itcms/Object#set:next (param $this i32) (param $obj i32)
  (call $~lib/rt/itcms/Object#set:nextWithColor
   (local.get $this)
   (i32.or
    (local.get $obj)
    (i32.and
     (call $~lib/rt/itcms/Object#get:nextWithColor
      (local.get $this)
     )
     (i32.const 3)
    )
   )
  )
 )
 (func $~lib/rt/itcms/Object#unlink (param $this i32)
  (local $next i32)
  (local $prev i32)
  (local.set $next
   (call $~lib/rt/itcms/Object#get:next
    (local.get $this)
   )
  )
  (if
   (i32.eq
    (local.get $next)
    (i32.const 0)
   )
   (then
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (if (result i32)
       (i32.eq
        (call $~lib/rt/itcms/Object#get:prev
         (local.get $this)
        )
        (i32.const 0)
       )
       (then
        (i32.lt_u
         (local.get $this)
         (global.get $~lib/memory/__heap_base)
        )
       )
       (else
        (i32.const 0)
       )
      )
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 384)
       (i32.const 128)
       (i32.const 18)
      )
      (unreachable)
     )
    )
    (return)
   )
  )
  (local.set $prev
   (call $~lib/rt/itcms/Object#get:prev
    (local.get $this)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (local.get $prev)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 384)
     (i32.const 132)
     (i32.const 16)
    )
    (unreachable)
   )
  )
  (call $~lib/rt/itcms/Object#set:prev
   (local.get $next)
   (local.get $prev)
  )
  (call $~lib/rt/itcms/Object#set:next
   (local.get $prev)
   (local.get $next)
  )
 )
 (func $~lib/rt/itcms/Object#get:rtId (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/shared/typeinfo/Typeinfo#get:flags (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/rt/__typeinfo (param $id i32) (result i32)
  (local $ptr i32)
  (local.set $ptr
   (global.get $~lib/rt/__rtti_base)
  )
  (if
   (i32.gt_u
    (local.get $id)
    (i32.load
     (local.get $ptr)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 64)
     (i32.const 512)
     (i32.const 21)
     (i32.const 28)
    )
    (unreachable)
   )
  )
  (return
   (call $~lib/shared/typeinfo/Typeinfo#get:flags
    (i32.add
     (i32.add
      (local.get $ptr)
      (i32.const 4)
     )
     (i32.mul
      (local.get $id)
      (i32.const 4)
     )
    )
   )
  )
 )
 (func $~lib/rt/itcms/Object#get:isPointerfree (param $this i32) (result i32)
  (local $rtId i32)
  (local.set $rtId
   (call $~lib/rt/itcms/Object#get:rtId
    (local.get $this)
   )
  )
  (return
   (if (result i32)
    (i32.le_u
     (local.get $rtId)
     (i32.const 2)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.ne
      (i32.and
       (call $~lib/rt/__typeinfo
        (local.get $rtId)
       )
       (i32.const 32)
      )
      (i32.const 0)
     )
    )
   )
  )
 )
 (func $~lib/rt/itcms/Object#linkTo (param $this i32) (param $list i32) (param $withColor i32)
  (local $prev i32)
  (local.set $prev
   (call $~lib/rt/itcms/Object#get:prev
    (local.get $list)
   )
  )
  (call $~lib/rt/itcms/Object#set:nextWithColor
   (local.get $this)
   (i32.or
    (local.get $list)
    (local.get $withColor)
   )
  )
  (call $~lib/rt/itcms/Object#set:prev
   (local.get $this)
   (local.get $prev)
  )
  (call $~lib/rt/itcms/Object#set:next
   (local.get $prev)
   (local.get $this)
  )
  (call $~lib/rt/itcms/Object#set:prev
   (local.get $list)
   (local.get $this)
  )
 )
 (func $~lib/rt/itcms/Object#makeGray (param $this i32)
  (local $1 i32)
  (if
   (i32.eq
    (local.get $this)
    (global.get $~lib/rt/itcms/iter)
   )
   (then
    (global.set $~lib/rt/itcms/iter
     (if (result i32)
      (i32.eqz
       (local.tee $1
        (call $~lib/rt/itcms/Object#get:prev
         (local.get $this)
        )
       )
      )
      (then
       (call $~lib/builtins/abort
        (i32.const 0)
        (i32.const 384)
        (i32.const 148)
        (i32.const 30)
       )
       (unreachable)
      )
      (else
       (local.get $1)
      )
     )
    )
   )
  )
  (call $~lib/rt/itcms/Object#unlink
   (local.get $this)
  )
  (call $~lib/rt/itcms/Object#linkTo
   (local.get $this)
   (global.get $~lib/rt/itcms/toSpace)
   (if (result i32)
    (call $~lib/rt/itcms/Object#get:isPointerfree
     (local.get $this)
    )
    (then
     (i32.eqz
      (global.get $~lib/rt/itcms/white)
     )
    )
    (else
     (i32.const 2)
    )
   )
  )
 )
 (func $~lib/rt/itcms/__visit (param $ptr i32) (param $cookie i32)
  (local $obj i32)
  (if
   (i32.eqz
    (local.get $ptr)
   )
   (then
    (return)
   )
  )
  (local.set $obj
   (i32.sub
    (local.get $ptr)
    (i32.const 20)
   )
  )
  (drop
   (i32.const 0)
  )
  (if
   (i32.eq
    (call $~lib/rt/itcms/Object#get:color
     (local.get $obj)
    )
    (global.get $~lib/rt/itcms/white)
   )
   (then
    (call $~lib/rt/itcms/Object#makeGray
     (local.get $obj)
    )
    (global.set $~lib/rt/itcms/visitCount
     (i32.add
      (global.get $~lib/rt/itcms/visitCount)
      (i32.const 1)
     )
    )
   )
  )
 )
 (func $~lib/rt/itcms/visitStack (param $cookie i32)
  (local $ptr i32)
  (local.set $ptr
   (global.get $~lib/memory/__stack_pointer)
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.lt_u
      (local.get $ptr)
      (global.get $~lib/memory/__heap_base)
     )
     (then
      (call $~lib/rt/itcms/__visit
       (i32.load
        (local.get $ptr)
       )
       (local.get $cookie)
      )
      (local.set $ptr
       (i32.add
        (local.get $ptr)
        (i32.const 4)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
 )
 (func $~lib/rt/common/BLOCK#get:mmInfo (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/rt/itcms/Object#get:size (param $this i32) (result i32)
  (return
   (i32.add
    (i32.const 4)
    (i32.and
     (call $~lib/rt/common/BLOCK#get:mmInfo
      (local.get $this)
     )
     (i32.xor
      (i32.const 3)
      (i32.const -1)
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/Root#set:flMap (param $this i32) (param $flMap i32)
  (i32.store
   (local.get $this)
   (local.get $flMap)
  )
 )
 (func $~lib/rt/common/BLOCK#set:mmInfo (param $this i32) (param $mmInfo i32)
  (i32.store
   (local.get $this)
   (local.get $mmInfo)
  )
 )
 (func $~lib/rt/tlsf/Block#set:prev (param $this i32) (param $prev i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $prev)
  )
 )
 (func $~lib/rt/tlsf/Block#set:next (param $this i32) (param $next i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $next)
  )
 )
 (func $~lib/rt/tlsf/Block#get:prev (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/rt/tlsf/Block#get:next (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $~lib/rt/tlsf/Root#get:flMap (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
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
  (local $root|11 i32)
  (local $fl|12 i32)
  (local $sl|13 i32)
  (local $root|14 i32)
  (local $fl|15 i32)
  (local $sl|16 i32)
  (local $head i32)
  (local $root|18 i32)
  (local $fl|19 i32)
  (local $slMap i32)
  (local $root|21 i32)
  (local $fl|22 i32)
  (local $slMap|23 i32)
  (local.set $blockInfo
   (call $~lib/rt/common/BLOCK#get:mmInfo
    (local.get $block)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.and
     (local.get $blockInfo)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 268)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $size
   (i32.and
    (local.get $blockInfo)
    (i32.xor
     (i32.const 3)
     (i32.const -1)
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.ge_u
     (local.get $size)
     (i32.const 12)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 270)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (if
   (i32.lt_u
    (local.get $size)
    (i32.const 256)
   )
   (then
    (local.set $fl
     (i32.const 0)
    )
    (local.set $sl
     (i32.shr_u
      (local.get $size)
      (i32.const 4)
     )
    )
   )
   (else
    (local.set $boundedSize
     (select
      (local.tee $6
       (local.get $size)
      )
      (local.tee $7
       (i32.const 1073741820)
      )
      (i32.lt_u
       (local.get $6)
       (local.get $7)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (i32.const 31)
      (i32.clz
       (local.get $boundedSize)
      )
     )
    )
    (local.set $sl
     (i32.xor
      (i32.shr_u
       (local.get $boundedSize)
       (i32.sub
        (local.get $fl)
        (i32.const 4)
       )
      )
      (i32.shl
       (i32.const 1)
       (i32.const 4)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (local.get $fl)
      (i32.sub
       (i32.const 8)
       (i32.const 1)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.lt_u
      (local.get $fl)
      (i32.const 23)
     )
     (then
      (i32.lt_u
       (local.get $sl)
       (i32.const 16)
      )
     )
     (else
      (i32.const 0)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 284)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $prev
   (call $~lib/rt/tlsf/Block#get:prev
    (local.get $block)
   )
  )
  (local.set $next
   (call $~lib/rt/tlsf/Block#get:next
    (local.get $block)
   )
  )
  (if
   (local.get $prev)
   (then
    (call $~lib/rt/tlsf/Block#set:next
     (local.get $prev)
     (local.get $next)
    )
   )
  )
  (if
   (local.get $next)
   (then
    (call $~lib/rt/tlsf/Block#set:prev
     (local.get $next)
     (local.get $prev)
    )
   )
  )
  (if
   (i32.eq
    (local.get $block)
    (block $~lib/rt/tlsf/GETHEAD|inlined.0 (result i32)
     (local.set $root|11
      (local.get $root)
     )
     (local.set $fl|12
      (local.get $fl)
     )
     (local.set $sl|13
      (local.get $sl)
     )
     (br $~lib/rt/tlsf/GETHEAD|inlined.0
      (i32.load offset=96
       (i32.add
        (local.get $root|11)
        (i32.shl
         (i32.add
          (i32.shl
           (local.get $fl|12)
           (i32.const 4)
          )
          (local.get $sl|13)
         )
         (i32.const 2)
        )
       )
      )
     )
    )
   )
   (then
    (block $~lib/rt/tlsf/SETHEAD|inlined.1
     (local.set $root|14
      (local.get $root)
     )
     (local.set $fl|15
      (local.get $fl)
     )
     (local.set $sl|16
      (local.get $sl)
     )
     (local.set $head
      (local.get $next)
     )
     (i32.store offset=96
      (i32.add
       (local.get $root|14)
       (i32.shl
        (i32.add
         (i32.shl
          (local.get $fl|15)
          (i32.const 4)
         )
         (local.get $sl|16)
        )
        (i32.const 2)
       )
      )
      (local.get $head)
     )
    )
    (if
     (i32.eqz
      (local.get $next)
     )
     (then
      (local.set $slMap
       (block $~lib/rt/tlsf/GETSL|inlined.0 (result i32)
        (local.set $root|18
         (local.get $root)
        )
        (local.set $fl|19
         (local.get $fl)
        )
        (br $~lib/rt/tlsf/GETSL|inlined.0
         (i32.load offset=4
          (i32.add
           (local.get $root|18)
           (i32.shl
            (local.get $fl|19)
            (i32.const 2)
           )
          )
         )
        )
       )
      )
      (block $~lib/rt/tlsf/SETSL|inlined.1
       (local.set $root|21
        (local.get $root)
       )
       (local.set $fl|22
        (local.get $fl)
       )
       (local.set $slMap|23
        (local.tee $slMap
         (i32.and
          (local.get $slMap)
          (i32.xor
           (i32.shl
            (i32.const 1)
            (local.get $sl)
           )
           (i32.const -1)
          )
         )
        )
       )
       (i32.store offset=4
        (i32.add
         (local.get $root|21)
         (i32.shl
          (local.get $fl|22)
          (i32.const 2)
         )
        )
        (local.get $slMap|23)
       )
      )
      (if
       (i32.eqz
        (local.get $slMap)
       )
       (then
        (call $~lib/rt/tlsf/Root#set:flMap
         (local.get $root)
         (i32.and
          (call $~lib/rt/tlsf/Root#get:flMap
           (local.get $root)
          )
          (i32.xor
           (i32.shl
            (i32.const 1)
            (local.get $fl)
           )
           (i32.const -1)
          )
         )
        )
       )
      )
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/insertBlock (param $root i32) (param $block i32)
  (local $blockInfo i32)
  (local $block|3 i32)
  (local $right i32)
  (local $rightInfo i32)
  (local $block|6 i32)
  (local $block|7 i32)
  (local $left i32)
  (local $leftInfo i32)
  (local $size i32)
  (local $fl i32)
  (local $sl i32)
  (local $13 i32)
  (local $14 i32)
  (local $boundedSize i32)
  (local $root|16 i32)
  (local $fl|17 i32)
  (local $sl|18 i32)
  (local $head i32)
  (local $root|20 i32)
  (local $fl|21 i32)
  (local $sl|22 i32)
  (local $head|23 i32)
  (local $root|24 i32)
  (local $fl|25 i32)
  (local $root|26 i32)
  (local $fl|27 i32)
  (local $slMap i32)
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (local.get $block)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 201)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $blockInfo
   (call $~lib/rt/common/BLOCK#get:mmInfo
    (local.get $block)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.and
     (local.get $blockInfo)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 203)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $right
   (block $~lib/rt/tlsf/GETRIGHT|inlined.0 (result i32)
    (local.set $block|3
     (local.get $block)
    )
    (br $~lib/rt/tlsf/GETRIGHT|inlined.0
     (i32.add
      (i32.add
       (local.get $block|3)
       (i32.const 4)
      )
      (i32.and
       (call $~lib/rt/common/BLOCK#get:mmInfo
        (local.get $block|3)
       )
       (i32.xor
        (i32.const 3)
        (i32.const -1)
       )
      )
     )
    )
   )
  )
  (local.set $rightInfo
   (call $~lib/rt/common/BLOCK#get:mmInfo
    (local.get $right)
   )
  )
  (if
   (i32.and
    (local.get $rightInfo)
    (i32.const 1)
   )
   (then
    (call $~lib/rt/tlsf/removeBlock
     (local.get $root)
     (local.get $right)
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $block)
     (local.tee $blockInfo
      (i32.add
       (i32.add
        (local.get $blockInfo)
        (i32.const 4)
       )
       (i32.and
        (local.get $rightInfo)
        (i32.xor
         (i32.const 3)
         (i32.const -1)
        )
       )
      )
     )
    )
    (local.set $right
     (block $~lib/rt/tlsf/GETRIGHT|inlined.1 (result i32)
      (local.set $block|6
       (local.get $block)
      )
      (br $~lib/rt/tlsf/GETRIGHT|inlined.1
       (i32.add
        (i32.add
         (local.get $block|6)
         (i32.const 4)
        )
        (i32.and
         (call $~lib/rt/common/BLOCK#get:mmInfo
          (local.get $block|6)
         )
         (i32.xor
          (i32.const 3)
          (i32.const -1)
         )
        )
       )
      )
     )
    )
    (local.set $rightInfo
     (call $~lib/rt/common/BLOCK#get:mmInfo
      (local.get $right)
     )
    )
   )
  )
  (if
   (i32.and
    (local.get $blockInfo)
    (i32.const 2)
   )
   (then
    (local.set $left
     (block $~lib/rt/tlsf/GETFREELEFT|inlined.0 (result i32)
      (local.set $block|7
       (local.get $block)
      )
      (br $~lib/rt/tlsf/GETFREELEFT|inlined.0
       (i32.load
        (i32.sub
         (local.get $block|7)
         (i32.const 4)
        )
       )
      )
     )
    )
    (local.set $leftInfo
     (call $~lib/rt/common/BLOCK#get:mmInfo
      (local.get $left)
     )
    )
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (i32.and
       (local.get $leftInfo)
       (i32.const 1)
      )
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 592)
       (i32.const 221)
       (i32.const 16)
      )
      (unreachable)
     )
    )
    (call $~lib/rt/tlsf/removeBlock
     (local.get $root)
     (local.get $left)
    )
    (local.set $block
     (local.get $left)
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $block)
     (local.tee $blockInfo
      (i32.add
       (i32.add
        (local.get $leftInfo)
        (i32.const 4)
       )
       (i32.and
        (local.get $blockInfo)
        (i32.xor
         (i32.const 3)
         (i32.const -1)
        )
       )
      )
     )
    )
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $right)
   (i32.or
    (local.get $rightInfo)
    (i32.const 2)
   )
  )
  (local.set $size
   (i32.and
    (local.get $blockInfo)
    (i32.xor
     (i32.const 3)
     (i32.const -1)
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.ge_u
     (local.get $size)
     (i32.const 12)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 233)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.eq
     (i32.add
      (i32.add
       (local.get $block)
       (i32.const 4)
      )
      (local.get $size)
     )
     (local.get $right)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 234)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (i32.store
   (i32.sub
    (local.get $right)
    (i32.const 4)
   )
   (local.get $block)
  )
  (if
   (i32.lt_u
    (local.get $size)
    (i32.const 256)
   )
   (then
    (local.set $fl
     (i32.const 0)
    )
    (local.set $sl
     (i32.shr_u
      (local.get $size)
      (i32.const 4)
     )
    )
   )
   (else
    (local.set $boundedSize
     (select
      (local.tee $13
       (local.get $size)
      )
      (local.tee $14
       (i32.const 1073741820)
      )
      (i32.lt_u
       (local.get $13)
       (local.get $14)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (i32.const 31)
      (i32.clz
       (local.get $boundedSize)
      )
     )
    )
    (local.set $sl
     (i32.xor
      (i32.shr_u
       (local.get $boundedSize)
       (i32.sub
        (local.get $fl)
        (i32.const 4)
       )
      )
      (i32.shl
       (i32.const 1)
       (i32.const 4)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (local.get $fl)
      (i32.sub
       (i32.const 8)
       (i32.const 1)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.lt_u
      (local.get $fl)
      (i32.const 23)
     )
     (then
      (i32.lt_u
       (local.get $sl)
       (i32.const 16)
      )
     )
     (else
      (i32.const 0)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 251)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $head
   (block $~lib/rt/tlsf/GETHEAD|inlined.1 (result i32)
    (local.set $root|16
     (local.get $root)
    )
    (local.set $fl|17
     (local.get $fl)
    )
    (local.set $sl|18
     (local.get $sl)
    )
    (br $~lib/rt/tlsf/GETHEAD|inlined.1
     (i32.load offset=96
      (i32.add
       (local.get $root|16)
       (i32.shl
        (i32.add
         (i32.shl
          (local.get $fl|17)
          (i32.const 4)
         )
         (local.get $sl|18)
        )
        (i32.const 2)
       )
      )
     )
    )
   )
  )
  (call $~lib/rt/tlsf/Block#set:prev
   (local.get $block)
   (i32.const 0)
  )
  (call $~lib/rt/tlsf/Block#set:next
   (local.get $block)
   (local.get $head)
  )
  (if
   (local.get $head)
   (then
    (call $~lib/rt/tlsf/Block#set:prev
     (local.get $head)
     (local.get $block)
    )
   )
  )
  (block $~lib/rt/tlsf/SETHEAD|inlined.2
   (local.set $root|20
    (local.get $root)
   )
   (local.set $fl|21
    (local.get $fl)
   )
   (local.set $sl|22
    (local.get $sl)
   )
   (local.set $head|23
    (local.get $block)
   )
   (i32.store offset=96
    (i32.add
     (local.get $root|20)
     (i32.shl
      (i32.add
       (i32.shl
        (local.get $fl|21)
        (i32.const 4)
       )
       (local.get $sl|22)
      )
      (i32.const 2)
     )
    )
    (local.get $head|23)
   )
  )
  (call $~lib/rt/tlsf/Root#set:flMap
   (local.get $root)
   (i32.or
    (call $~lib/rt/tlsf/Root#get:flMap
     (local.get $root)
    )
    (i32.shl
     (i32.const 1)
     (local.get $fl)
    )
   )
  )
  (block $~lib/rt/tlsf/SETSL|inlined.2
   (local.set $root|26
    (local.get $root)
   )
   (local.set $fl|27
    (local.get $fl)
   )
   (local.set $slMap
    (i32.or
     (block $~lib/rt/tlsf/GETSL|inlined.1 (result i32)
      (local.set $root|24
       (local.get $root)
      )
      (local.set $fl|25
       (local.get $fl)
      )
      (br $~lib/rt/tlsf/GETSL|inlined.1
       (i32.load offset=4
        (i32.add
         (local.get $root|24)
         (i32.shl
          (local.get $fl|25)
          (i32.const 2)
         )
        )
       )
      )
     )
     (i32.shl
      (i32.const 1)
      (local.get $sl)
     )
    )
   )
   (i32.store offset=4
    (i32.add
     (local.get $root|26)
     (i32.shl
      (local.get $fl|27)
      (i32.const 2)
     )
    )
    (local.get $slMap)
   )
  )
 )
 (func $~lib/rt/tlsf/addMemory (param $root i32) (param $start i32) (param $endU64 i64) (result i32)
  (local $end i32)
  (local $root|4 i32)
  (local $tail i32)
  (local $tailInfo i32)
  (local $size i32)
  (local $leftSize i32)
  (local $left i32)
  (local $root|10 i32)
  (local $tail|11 i32)
  (local.set $end
   (i32.wrap_i64
    (local.get $endU64)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i64.le_u
     (i64.extend_i32_u
      (local.get $start)
     )
     (local.get $endU64)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 382)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $start
   (i32.sub
    (i32.and
     (i32.add
      (i32.add
       (local.get $start)
       (i32.const 4)
      )
      (i32.const 15)
     )
     (i32.xor
      (i32.const 15)
      (i32.const -1)
     )
    )
    (i32.const 4)
   )
  )
  (local.set $end
   (i32.and
    (local.get $end)
    (i32.xor
     (i32.const 15)
     (i32.const -1)
    )
   )
  )
  (local.set $tail
   (block $~lib/rt/tlsf/GETTAIL|inlined.0 (result i32)
    (local.set $root|4
     (local.get $root)
    )
    (br $~lib/rt/tlsf/GETTAIL|inlined.0
     (i32.load offset=1568
      (local.get $root|4)
     )
    )
   )
  )
  (local.set $tailInfo
   (i32.const 0)
  )
  (if
   (local.get $tail)
   (then
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (i32.ge_u
       (local.get $start)
       (i32.add
        (local.get $tail)
        (i32.const 4)
       )
      )
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 592)
       (i32.const 389)
       (i32.const 16)
      )
      (unreachable)
     )
    )
    (if
     (i32.eq
      (i32.sub
       (local.get $start)
       (i32.const 16)
      )
      (local.get $tail)
     )
     (then
      (local.set $start
       (i32.sub
        (local.get $start)
        (i32.const 16)
       )
      )
      (local.set $tailInfo
       (call $~lib/rt/common/BLOCK#get:mmInfo
        (local.get $tail)
       )
      )
     )
     (else
      (nop)
     )
    )
   )
   (else
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (i32.ge_u
       (local.get $start)
       (i32.add
        (local.get $root)
        (i32.const 1572)
       )
      )
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 592)
       (i32.const 402)
       (i32.const 5)
      )
      (unreachable)
     )
    )
   )
  )
  (local.set $size
   (i32.sub
    (local.get $end)
    (local.get $start)
   )
  )
  (if
   (i32.lt_u
    (local.get $size)
    (i32.add
     (i32.add
      (i32.const 4)
      (i32.const 12)
     )
     (i32.const 4)
    )
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (local.set $leftSize
   (i32.sub
    (local.get $size)
    (i32.mul
     (i32.const 2)
     (i32.const 4)
    )
   )
  )
  (local.set $left
   (local.get $start)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $left)
   (i32.or
    (i32.or
     (local.get $leftSize)
     (i32.const 1)
    )
    (i32.and
     (local.get $tailInfo)
     (i32.const 2)
    )
   )
  )
  (call $~lib/rt/tlsf/Block#set:prev
   (local.get $left)
   (i32.const 0)
  )
  (call $~lib/rt/tlsf/Block#set:next
   (local.get $left)
   (i32.const 0)
  )
  (local.set $tail
   (i32.add
    (i32.add
     (local.get $start)
     (i32.const 4)
    )
    (local.get $leftSize)
   )
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $tail)
   (i32.or
    (i32.const 0)
    (i32.const 2)
   )
  )
  (block $~lib/rt/tlsf/SETTAIL|inlined.1
   (local.set $root|10
    (local.get $root)
   )
   (local.set $tail|11
    (local.get $tail)
   )
   (i32.store offset=1568
    (local.get $root|10)
    (local.get $tail|11)
   )
  )
  (call $~lib/rt/tlsf/insertBlock
   (local.get $root)
   (local.get $left)
  )
  (return
   (i32.const 1)
  )
 )
 (func $~lib/rt/tlsf/initialize
  (local $rootOffset i32)
  (local $pagesBefore i32)
  (local $pagesNeeded i32)
  (local $root i32)
  (local $root|4 i32)
  (local $tail i32)
  (local $fl i32)
  (local $root|7 i32)
  (local $fl|8 i32)
  (local $slMap i32)
  (local $sl i32)
  (local $root|11 i32)
  (local $fl|12 i32)
  (local $sl|13 i32)
  (local $head i32)
  (local $memStart i32)
  (drop
   (i32.const 0)
  )
  (local.set $rootOffset
   (i32.and
    (i32.add
     (global.get $~lib/memory/__heap_base)
     (i32.const 15)
    )
    (i32.xor
     (i32.const 15)
     (i32.const -1)
    )
   )
  )
  (local.set $pagesBefore
   (memory.size)
  )
  (local.set $pagesNeeded
   (i32.shr_u
    (i32.and
     (i32.add
      (i32.add
       (local.get $rootOffset)
       (i32.const 1572)
      )
      (i32.const 65535)
     )
     (i32.xor
      (i32.const 65535)
      (i32.const -1)
     )
    )
    (i32.const 16)
   )
  )
  (if
   (if (result i32)
    (i32.gt_s
     (local.get $pagesNeeded)
     (local.get $pagesBefore)
    )
    (then
     (i32.lt_s
      (memory.grow
       (i32.sub
        (local.get $pagesNeeded)
        (local.get $pagesBefore)
       )
      )
      (i32.const 0)
     )
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (unreachable)
   )
  )
  (local.set $root
   (local.get $rootOffset)
  )
  (call $~lib/rt/tlsf/Root#set:flMap
   (local.get $root)
   (i32.const 0)
  )
  (block $~lib/rt/tlsf/SETTAIL|inlined.0
   (local.set $root|4
    (local.get $root)
   )
   (local.set $tail
    (i32.const 0)
   )
   (i32.store offset=1568
    (local.get $root|4)
    (local.get $tail)
   )
  )
  (local.set $fl
   (i32.const 0)
  )
  (loop $for-loop|0
   (if
    (i32.lt_u
     (local.get $fl)
     (i32.const 23)
    )
    (then
     (block $~lib/rt/tlsf/SETSL|inlined.0
      (local.set $root|7
       (local.get $root)
      )
      (local.set $fl|8
       (local.get $fl)
      )
      (local.set $slMap
       (i32.const 0)
      )
      (i32.store offset=4
       (i32.add
        (local.get $root|7)
        (i32.shl
         (local.get $fl|8)
         (i32.const 2)
        )
       )
       (local.get $slMap)
      )
     )
     (local.set $sl
      (i32.const 0)
     )
     (loop $for-loop|1
      (if
       (i32.lt_u
        (local.get $sl)
        (i32.const 16)
       )
       (then
        (block $~lib/rt/tlsf/SETHEAD|inlined.0
         (local.set $root|11
          (local.get $root)
         )
         (local.set $fl|12
          (local.get $fl)
         )
         (local.set $sl|13
          (local.get $sl)
         )
         (local.set $head
          (i32.const 0)
         )
         (i32.store offset=96
          (i32.add
           (local.get $root|11)
           (i32.shl
            (i32.add
             (i32.shl
              (local.get $fl|12)
              (i32.const 4)
             )
             (local.get $sl|13)
            )
            (i32.const 2)
           )
          )
          (local.get $head)
         )
        )
        (local.set $sl
         (i32.add
          (local.get $sl)
          (i32.const 1)
         )
        )
        (br $for-loop|1)
       )
      )
     )
     (local.set $fl
      (i32.add
       (local.get $fl)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (local.set $memStart
   (i32.add
    (local.get $rootOffset)
    (i32.const 1572)
   )
  )
  (drop
   (i32.const 0)
  )
  (drop
   (call $~lib/rt/tlsf/addMemory
    (local.get $root)
    (local.get $memStart)
    (i64.shl
     (i64.extend_i32_s
      (memory.size)
     )
     (i64.const 16)
    )
   )
  )
  (global.set $~lib/rt/tlsf/ROOT
   (local.get $root)
  )
 )
 (func $~lib/rt/tlsf/checkUsedBlock (param $ptr i32) (result i32)
  (local $block i32)
  (local.set $block
   (i32.sub
    (local.get $ptr)
    (i32.const 4)
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (if (result i32)
      (i32.ne
       (local.get $ptr)
       (i32.const 0)
      )
      (then
       (i32.eqz
        (i32.and
         (local.get $ptr)
         (i32.const 15)
        )
       )
      )
      (else
       (i32.const 0)
      )
     )
     (then
      (i32.eqz
       (i32.and
        (call $~lib/rt/common/BLOCK#get:mmInfo
         (local.get $block)
        )
        (i32.const 1)
       )
      )
     )
     (else
      (i32.const 0)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 562)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (return
   (local.get $block)
  )
 )
 (func $~lib/rt/tlsf/freeBlock (param $root i32) (param $block i32)
  (drop
   (i32.const 0)
  )
  (call $~lib/rt/common/BLOCK#set:mmInfo
   (local.get $block)
   (i32.or
    (call $~lib/rt/common/BLOCK#get:mmInfo
     (local.get $block)
    )
    (i32.const 1)
   )
  )
  (call $~lib/rt/tlsf/insertBlock
   (local.get $root)
   (local.get $block)
  )
 )
 (func $~lib/rt/tlsf/__free (param $ptr i32)
  (if
   (i32.lt_u
    (local.get $ptr)
    (global.get $~lib/memory/__heap_base)
   )
   (then
    (return)
   )
  )
  (if
   (i32.eqz
    (global.get $~lib/rt/tlsf/ROOT)
   )
   (then
    (call $~lib/rt/tlsf/initialize)
   )
  )
  (call $~lib/rt/tlsf/freeBlock
   (global.get $~lib/rt/tlsf/ROOT)
   (call $~lib/rt/tlsf/checkUsedBlock
    (local.get $ptr)
   )
  )
 )
 (func $~lib/rt/itcms/free (param $obj i32)
  (if
   (i32.lt_u
    (local.get $obj)
    (global.get $~lib/memory/__heap_base)
   )
   (then
    (call $~lib/rt/itcms/Object#set:nextWithColor
     (local.get $obj)
     (i32.const 0)
    )
    (call $~lib/rt/itcms/Object#set:prev
     (local.get $obj)
     (i32.const 0)
    )
   )
   (else
    (drop
     (i32.const 0)
    )
    (global.set $~lib/rt/itcms/total
     (i32.sub
      (global.get $~lib/rt/itcms/total)
      (call $~lib/rt/itcms/Object#get:size
       (local.get $obj)
      )
     )
    )
    (drop
     (i32.const 0)
    )
    (call $~lib/rt/tlsf/__free
     (i32.add
      (local.get $obj)
      (i32.const 4)
     )
    )
   )
  )
 )
 (func $~lib/rt/itcms/step (result i32)
  (local $obj i32)
  (local $1 i32)
  (local $black i32)
  (local $from i32)
  (block $break|0
   (block $case2|0
    (block $case1|0
     (block $case0|0
      (local.set $1
       (global.get $~lib/rt/itcms/state)
      )
      (br_if $case0|0
       (i32.eq
        (local.get $1)
        (i32.const 0)
       )
      )
      (br_if $case1|0
       (i32.eq
        (local.get $1)
        (i32.const 1)
       )
      )
      (br_if $case2|0
       (i32.eq
        (local.get $1)
        (i32.const 2)
       )
      )
      (br $break|0)
     )
     (block
      (global.set $~lib/rt/itcms/state
       (i32.const 1)
      )
      (global.set $~lib/rt/itcms/visitCount
       (i32.const 0)
      )
      (call $~lib/rt/itcms/visitRoots
       (i32.const 0)
      )
      (global.set $~lib/rt/itcms/iter
       (global.get $~lib/rt/itcms/toSpace)
      )
      (return
       (i32.mul
        (global.get $~lib/rt/itcms/visitCount)
        (i32.const 1)
       )
      )
     )
    )
    (block
     (local.set $black
      (i32.eqz
       (global.get $~lib/rt/itcms/white)
      )
     )
     (local.set $obj
      (call $~lib/rt/itcms/Object#get:next
       (global.get $~lib/rt/itcms/iter)
      )
     )
     (block $while-break|1
      (loop $while-continue|1
       (if
        (i32.ne
         (local.get $obj)
         (global.get $~lib/rt/itcms/toSpace)
        )
        (then
         (global.set $~lib/rt/itcms/iter
          (local.get $obj)
         )
         (if
          (i32.ne
           (call $~lib/rt/itcms/Object#get:color
            (local.get $obj)
           )
           (local.get $black)
          )
          (then
           (call $~lib/rt/itcms/Object#set:color
            (local.get $obj)
            (local.get $black)
           )
           (global.set $~lib/rt/itcms/visitCount
            (i32.const 0)
           )
           (call $~lib/rt/__visit_members
            (i32.add
             (local.get $obj)
             (i32.const 20)
            )
            (i32.const 0)
           )
           (return
            (i32.mul
             (global.get $~lib/rt/itcms/visitCount)
             (i32.const 1)
            )
           )
          )
         )
         (local.set $obj
          (call $~lib/rt/itcms/Object#get:next
           (local.get $obj)
          )
         )
         (br $while-continue|1)
        )
       )
      )
     )
     (global.set $~lib/rt/itcms/visitCount
      (i32.const 0)
     )
     (call $~lib/rt/itcms/visitRoots
      (i32.const 0)
     )
     (local.set $obj
      (call $~lib/rt/itcms/Object#get:next
       (global.get $~lib/rt/itcms/iter)
      )
     )
     (if
      (i32.eq
       (local.get $obj)
       (global.get $~lib/rt/itcms/toSpace)
      )
      (then
       (call $~lib/rt/itcms/visitStack
        (i32.const 0)
       )
       (local.set $obj
        (call $~lib/rt/itcms/Object#get:next
         (global.get $~lib/rt/itcms/iter)
        )
       )
       (block $while-break|2
        (loop $while-continue|2
         (if
          (i32.ne
           (local.get $obj)
           (global.get $~lib/rt/itcms/toSpace)
          )
          (then
           (if
            (i32.ne
             (call $~lib/rt/itcms/Object#get:color
              (local.get $obj)
             )
             (local.get $black)
            )
            (then
             (call $~lib/rt/itcms/Object#set:color
              (local.get $obj)
              (local.get $black)
             )
             (call $~lib/rt/__visit_members
              (i32.add
               (local.get $obj)
               (i32.const 20)
              )
              (i32.const 0)
             )
            )
           )
           (local.set $obj
            (call $~lib/rt/itcms/Object#get:next
             (local.get $obj)
            )
           )
           (br $while-continue|2)
          )
         )
        )
       )
       (local.set $from
        (global.get $~lib/rt/itcms/fromSpace)
       )
       (global.set $~lib/rt/itcms/fromSpace
        (global.get $~lib/rt/itcms/toSpace)
       )
       (global.set $~lib/rt/itcms/toSpace
        (local.get $from)
       )
       (global.set $~lib/rt/itcms/white
        (local.get $black)
       )
       (global.set $~lib/rt/itcms/iter
        (call $~lib/rt/itcms/Object#get:next
         (local.get $from)
        )
       )
       (global.set $~lib/rt/itcms/state
        (i32.const 2)
       )
      )
     )
     (return
      (i32.mul
       (global.get $~lib/rt/itcms/visitCount)
       (i32.const 1)
      )
     )
    )
   )
   (block
    (local.set $obj
     (global.get $~lib/rt/itcms/iter)
    )
    (if
     (i32.ne
      (local.get $obj)
      (global.get $~lib/rt/itcms/toSpace)
     )
     (then
      (global.set $~lib/rt/itcms/iter
       (call $~lib/rt/itcms/Object#get:next
        (local.get $obj)
       )
      )
      (drop
       (i32.const 1)
      )
      (if
       (i32.eqz
        (i32.eq
         (call $~lib/rt/itcms/Object#get:color
          (local.get $obj)
         )
         (i32.eqz
          (global.get $~lib/rt/itcms/white)
         )
        )
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 0)
         (i32.const 384)
         (i32.const 229)
         (i32.const 20)
        )
        (unreachable)
       )
      )
      (call $~lib/rt/itcms/free
       (local.get $obj)
      )
      (return
       (i32.const 10)
      )
     )
    )
    (call $~lib/rt/itcms/Object#set:nextWithColor
     (global.get $~lib/rt/itcms/toSpace)
     (global.get $~lib/rt/itcms/toSpace)
    )
    (call $~lib/rt/itcms/Object#set:prev
     (global.get $~lib/rt/itcms/toSpace)
     (global.get $~lib/rt/itcms/toSpace)
    )
    (global.set $~lib/rt/itcms/state
     (i32.const 0)
    )
    (br $break|0)
   )
  )
  (return
   (i32.const 0)
  )
 )
 (func $~lib/rt/itcms/interrupt
  (local $budget i32)
  (drop
   (i32.const 0)
  )
  (drop
   (i32.const 0)
  )
  (local.set $budget
   (i32.div_u
    (i32.mul
     (i32.const 1024)
     (i32.const 200)
    )
    (i32.const 100)
   )
  )
  (loop $do-loop|0
   (local.set $budget
    (i32.sub
     (local.get $budget)
     (call $~lib/rt/itcms/step)
    )
   )
   (if
    (i32.eq
     (global.get $~lib/rt/itcms/state)
     (i32.const 0)
    )
    (then
     (drop
      (i32.const 0)
     )
     (global.set $~lib/rt/itcms/threshold
      (i32.add
       (i32.wrap_i64
        (i64.div_u
         (i64.mul
          (i64.extend_i32_u
           (global.get $~lib/rt/itcms/total)
          )
          (i64.extend_i32_u
           (i32.const 200)
          )
         )
         (i64.const 100)
        )
       )
       (i32.const 1024)
      )
     )
     (drop
      (i32.const 0)
     )
     (return)
    )
   )
   (br_if $do-loop|0
    (i32.gt_s
     (local.get $budget)
     (i32.const 0)
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (global.set $~lib/rt/itcms/threshold
   (i32.add
    (global.get $~lib/rt/itcms/total)
    (i32.mul
     (i32.const 1024)
     (i32.lt_u
      (i32.sub
       (global.get $~lib/rt/itcms/total)
       (global.get $~lib/rt/itcms/threshold)
      )
      (i32.const 1024)
     )
    )
   )
  )
  (drop
   (i32.const 0)
  )
 )
 (func $~lib/rt/tlsf/computeSize (param $size i32) (result i32)
  (return
   (if (result i32)
    (i32.le_u
     (local.get $size)
     (i32.const 12)
    )
    (then
     (i32.const 12)
    )
    (else
     (i32.sub
      (i32.and
       (i32.add
        (i32.add
         (local.get $size)
         (i32.const 4)
        )
        (i32.const 15)
       )
       (i32.xor
        (i32.const 15)
        (i32.const -1)
       )
      )
      (i32.const 4)
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/prepareSize (param $size i32) (result i32)
  (if
   (i32.gt_u
    (local.get $size)
    (i32.const 1073741820)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 320)
     (i32.const 592)
     (i32.const 461)
     (i32.const 29)
    )
    (unreachable)
   )
  )
  (return
   (call $~lib/rt/tlsf/computeSize
    (local.get $size)
   )
  )
 )
 (func $~lib/rt/tlsf/roundSize (param $size i32) (result i32)
  (return
   (if (result i32)
    (i32.lt_u
     (local.get $size)
     (i32.const 536870910)
    )
    (then
     (i32.sub
      (i32.add
       (local.get $size)
       (i32.shl
        (i32.const 1)
        (i32.sub
         (i32.const 27)
         (i32.clz
          (local.get $size)
         )
        )
       )
      )
      (i32.const 1)
     )
    )
    (else
     (local.get $size)
    )
   )
  )
 )
 (func $~lib/rt/tlsf/searchBlock (param $root i32) (param $size i32) (result i32)
  (local $fl i32)
  (local $sl i32)
  (local $requestSize i32)
  (local $root|5 i32)
  (local $fl|6 i32)
  (local $slMap i32)
  (local $head i32)
  (local $flMap i32)
  (local $root|10 i32)
  (local $fl|11 i32)
  (local $root|12 i32)
  (local $fl|13 i32)
  (local $sl|14 i32)
  (local $root|15 i32)
  (local $fl|16 i32)
  (local $sl|17 i32)
  (if
   (i32.lt_u
    (local.get $size)
    (i32.const 256)
   )
   (then
    (local.set $fl
     (i32.const 0)
    )
    (local.set $sl
     (i32.shr_u
      (local.get $size)
      (i32.const 4)
     )
    )
   )
   (else
    (local.set $requestSize
     (call $~lib/rt/tlsf/roundSize
      (local.get $size)
     )
    )
    (local.set $fl
     (i32.sub
      (i32.sub
       (i32.mul
        (i32.const 4)
        (i32.const 8)
       )
       (i32.const 1)
      )
      (i32.clz
       (local.get $requestSize)
      )
     )
    )
    (local.set $sl
     (i32.xor
      (i32.shr_u
       (local.get $requestSize)
       (i32.sub
        (local.get $fl)
        (i32.const 4)
       )
      )
      (i32.shl
       (i32.const 1)
       (i32.const 4)
      )
     )
    )
    (local.set $fl
     (i32.sub
      (local.get $fl)
      (i32.sub
       (i32.const 8)
       (i32.const 1)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.lt_u
      (local.get $fl)
      (i32.const 23)
     )
     (then
      (i32.lt_u
       (local.get $sl)
       (i32.const 16)
      )
     )
     (else
      (i32.const 0)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 334)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $slMap
   (i32.and
    (block $~lib/rt/tlsf/GETSL|inlined.2 (result i32)
     (local.set $root|5
      (local.get $root)
     )
     (local.set $fl|6
      (local.get $fl)
     )
     (br $~lib/rt/tlsf/GETSL|inlined.2
      (i32.load offset=4
       (i32.add
        (local.get $root|5)
        (i32.shl
         (local.get $fl|6)
         (i32.const 2)
        )
       )
      )
     )
    )
    (i32.shl
     (i32.xor
      (i32.const 0)
      (i32.const -1)
     )
     (local.get $sl)
    )
   )
  )
  (local.set $head
   (i32.const 0)
  )
  (if
   (i32.eqz
    (local.get $slMap)
   )
   (then
    (local.set $flMap
     (i32.and
      (call $~lib/rt/tlsf/Root#get:flMap
       (local.get $root)
      )
      (i32.shl
       (i32.xor
        (i32.const 0)
        (i32.const -1)
       )
       (i32.add
        (local.get $fl)
        (i32.const 1)
       )
      )
     )
    )
    (if
     (i32.eqz
      (local.get $flMap)
     )
     (then
      (local.set $head
       (i32.const 0)
      )
     )
     (else
      (local.set $fl
       (i32.ctz
        (local.get $flMap)
       )
      )
      (local.set $slMap
       (block $~lib/rt/tlsf/GETSL|inlined.3 (result i32)
        (local.set $root|10
         (local.get $root)
        )
        (local.set $fl|11
         (local.get $fl)
        )
        (br $~lib/rt/tlsf/GETSL|inlined.3
         (i32.load offset=4
          (i32.add
           (local.get $root|10)
           (i32.shl
            (local.get $fl|11)
            (i32.const 2)
           )
          )
         )
        )
       )
      )
      (drop
       (i32.const 1)
      )
      (if
       (i32.eqz
        (local.get $slMap)
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 0)
         (i32.const 592)
         (i32.const 347)
         (i32.const 18)
        )
        (unreachable)
       )
      )
      (local.set $head
       (block $~lib/rt/tlsf/GETHEAD|inlined.2 (result i32)
        (local.set $root|12
         (local.get $root)
        )
        (local.set $fl|13
         (local.get $fl)
        )
        (local.set $sl|14
         (i32.ctz
          (local.get $slMap)
         )
        )
        (br $~lib/rt/tlsf/GETHEAD|inlined.2
         (i32.load offset=96
          (i32.add
           (local.get $root|12)
           (i32.shl
            (i32.add
             (i32.shl
              (local.get $fl|13)
              (i32.const 4)
             )
             (local.get $sl|14)
            )
            (i32.const 2)
           )
          )
         )
        )
       )
      )
     )
    )
   )
   (else
    (local.set $head
     (block $~lib/rt/tlsf/GETHEAD|inlined.3 (result i32)
      (local.set $root|15
       (local.get $root)
      )
      (local.set $fl|16
       (local.get $fl)
      )
      (local.set $sl|17
       (i32.ctz
        (local.get $slMap)
       )
      )
      (br $~lib/rt/tlsf/GETHEAD|inlined.3
       (i32.load offset=96
        (i32.add
         (local.get $root|15)
         (i32.shl
          (i32.add
           (i32.shl
            (local.get $fl|16)
            (i32.const 4)
           )
           (local.get $sl|17)
          )
          (i32.const 2)
         )
        )
       )
      )
     )
    )
   )
  )
  (return
   (local.get $head)
  )
 )
 (func $~lib/rt/tlsf/growMemory (param $root i32) (param $size i32)
  (local $pagesBefore i32)
  (local $root|3 i32)
  (local $pagesNeeded i32)
  (local $5 i32)
  (local $6 i32)
  (local $pagesWanted i32)
  (local $pagesAfter i32)
  (drop
   (i32.const 0)
  )
  (if
   (i32.ge_u
    (local.get $size)
    (i32.const 256)
   )
   (then
    (local.set $size
     (call $~lib/rt/tlsf/roundSize
      (local.get $size)
     )
    )
   )
  )
  (local.set $pagesBefore
   (memory.size)
  )
  (local.set $size
   (i32.add
    (local.get $size)
    (i32.shl
     (i32.const 4)
     (i32.ne
      (i32.sub
       (i32.shl
        (local.get $pagesBefore)
        (i32.const 16)
       )
       (i32.const 4)
      )
      (block $~lib/rt/tlsf/GETTAIL|inlined.1 (result i32)
       (local.set $root|3
        (local.get $root)
       )
       (br $~lib/rt/tlsf/GETTAIL|inlined.1
        (i32.load offset=1568
         (local.get $root|3)
        )
       )
      )
     )
    )
   )
  )
  (local.set $pagesNeeded
   (i32.shr_u
    (i32.and
     (i32.add
      (local.get $size)
      (i32.const 65535)
     )
     (i32.xor
      (i32.const 65535)
      (i32.const -1)
     )
    )
    (i32.const 16)
   )
  )
  (local.set $pagesWanted
   (select
    (local.tee $5
     (local.get $pagesBefore)
    )
    (local.tee $6
     (local.get $pagesNeeded)
    )
    (i32.gt_s
     (local.get $5)
     (local.get $6)
    )
   )
  )
  (if
   (i32.lt_s
    (memory.grow
     (local.get $pagesWanted)
    )
    (i32.const 0)
   )
   (then
    (if
     (i32.lt_s
      (memory.grow
       (local.get $pagesNeeded)
      )
      (i32.const 0)
     )
     (then
      (unreachable)
     )
    )
   )
  )
  (local.set $pagesAfter
   (memory.size)
  )
  (drop
   (call $~lib/rt/tlsf/addMemory
    (local.get $root)
    (i32.shl
     (local.get $pagesBefore)
     (i32.const 16)
    )
    (i64.shl
     (i64.extend_i32_s
      (local.get $pagesAfter)
     )
     (i64.const 16)
    )
   )
  )
 )
 (func $~lib/rt/tlsf/prepareBlock (param $root i32) (param $block i32) (param $size i32)
  (local $blockInfo i32)
  (local $remaining i32)
  (local $spare i32)
  (local $block|6 i32)
  (local $block|7 i32)
  (local.set $blockInfo
   (call $~lib/rt/common/BLOCK#get:mmInfo
    (local.get $block)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.eqz
     (i32.and
      (i32.add
       (local.get $size)
       (i32.const 4)
      )
      (i32.const 15)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 361)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $remaining
   (i32.sub
    (i32.and
     (local.get $blockInfo)
     (i32.xor
      (i32.const 3)
      (i32.const -1)
     )
    )
    (local.get $size)
   )
  )
  (if
   (i32.ge_u
    (local.get $remaining)
    (i32.add
     (i32.const 4)
     (i32.const 12)
    )
   )
   (then
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $block)
     (i32.or
      (local.get $size)
      (i32.and
       (local.get $blockInfo)
       (i32.const 2)
      )
     )
    )
    (local.set $spare
     (i32.add
      (i32.add
       (local.get $block)
       (i32.const 4)
      )
      (local.get $size)
     )
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $spare)
     (i32.or
      (i32.sub
       (local.get $remaining)
       (i32.const 4)
      )
      (i32.const 1)
     )
    )
    (call $~lib/rt/tlsf/insertBlock
     (local.get $root)
     (local.get $spare)
    )
   )
   (else
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $block)
     (i32.and
      (local.get $blockInfo)
      (i32.xor
       (i32.const 1)
       (i32.const -1)
      )
     )
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (block $~lib/rt/tlsf/GETRIGHT|inlined.3 (result i32)
      (local.set $block|7
       (local.get $block)
      )
      (br $~lib/rt/tlsf/GETRIGHT|inlined.3
       (i32.add
        (i32.add
         (local.get $block|7)
         (i32.const 4)
        )
        (i32.and
         (call $~lib/rt/common/BLOCK#get:mmInfo
          (local.get $block|7)
         )
         (i32.xor
          (i32.const 3)
          (i32.const -1)
         )
        )
       )
      )
     )
     (i32.and
      (call $~lib/rt/common/BLOCK#get:mmInfo
       (block $~lib/rt/tlsf/GETRIGHT|inlined.2 (result i32)
        (local.set $block|6
         (local.get $block)
        )
        (br $~lib/rt/tlsf/GETRIGHT|inlined.2
         (i32.add
          (i32.add
           (local.get $block|6)
           (i32.const 4)
          )
          (i32.and
           (call $~lib/rt/common/BLOCK#get:mmInfo
            (local.get $block|6)
           )
           (i32.xor
            (i32.const 3)
            (i32.const -1)
           )
          )
         )
        )
       )
      )
      (i32.xor
       (i32.const 2)
       (i32.const -1)
      )
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/allocateBlock (param $root i32) (param $size i32) (result i32)
  (local $payloadSize i32)
  (local $block i32)
  (local.set $payloadSize
   (call $~lib/rt/tlsf/prepareSize
    (local.get $size)
   )
  )
  (local.set $block
   (call $~lib/rt/tlsf/searchBlock
    (local.get $root)
    (local.get $payloadSize)
   )
  )
  (if
   (i32.eqz
    (local.get $block)
   )
   (then
    (call $~lib/rt/tlsf/growMemory
     (local.get $root)
     (local.get $payloadSize)
    )
    (local.set $block
     (call $~lib/rt/tlsf/searchBlock
      (local.get $root)
      (local.get $payloadSize)
     )
    )
    (drop
     (i32.const 1)
    )
    (if
     (i32.eqz
      (local.get $block)
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 592)
       (i32.const 499)
       (i32.const 16)
      )
      (unreachable)
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (i32.ge_u
     (i32.and
      (call $~lib/rt/common/BLOCK#get:mmInfo
       (local.get $block)
      )
      (i32.xor
       (i32.const 3)
       (i32.const -1)
      )
     )
     (local.get $payloadSize)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 592)
     (i32.const 501)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (call $~lib/rt/tlsf/removeBlock
   (local.get $root)
   (local.get $block)
  )
  (call $~lib/rt/tlsf/prepareBlock
   (local.get $root)
   (local.get $block)
   (local.get $payloadSize)
  )
  (drop
   (i32.const 0)
  )
  (return
   (local.get $block)
  )
 )
 (func $~lib/rt/tlsf/__alloc (param $size i32) (result i32)
  (if
   (i32.eqz
    (global.get $~lib/rt/tlsf/ROOT)
   )
   (then
    (call $~lib/rt/tlsf/initialize)
   )
  )
  (return
   (i32.add
    (call $~lib/rt/tlsf/allocateBlock
     (global.get $~lib/rt/tlsf/ROOT)
     (local.get $size)
    )
    (i32.const 4)
   )
  )
 )
 (func $~lib/rt/itcms/Object#set:rtId (param $this i32) (param $rtId i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $rtId)
  )
 )
 (func $~lib/rt/itcms/Object#set:rtSize (param $this i32) (param $rtSize i32)
  (i32.store offset=16
   (local.get $this)
   (local.get $rtSize)
  )
 )
 (func $~lib/rt/itcms/__new (param $size i32) (param $id i32) (result i32)
  (local $obj i32)
  (local $ptr i32)
  (if
   (i32.ge_u
    (local.get $size)
    (i32.const 1073741804)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 320)
     (i32.const 384)
     (i32.const 262)
     (i32.const 31)
    )
    (unreachable)
   )
  )
  (if
   (i32.ge_u
    (global.get $~lib/rt/itcms/total)
    (global.get $~lib/rt/itcms/threshold)
   )
   (then
    (call $~lib/rt/itcms/interrupt)
   )
  )
  (local.set $obj
   (i32.sub
    (call $~lib/rt/tlsf/__alloc
     (i32.add
      (i32.const 16)
      (local.get $size)
     )
    )
    (i32.const 4)
   )
  )
  (call $~lib/rt/itcms/Object#set:rtId
   (local.get $obj)
   (local.get $id)
  )
  (call $~lib/rt/itcms/Object#set:rtSize
   (local.get $obj)
   (local.get $size)
  )
  (call $~lib/rt/itcms/Object#linkTo
   (local.get $obj)
   (global.get $~lib/rt/itcms/fromSpace)
   (global.get $~lib/rt/itcms/white)
  )
  (global.set $~lib/rt/itcms/total
   (i32.add
    (global.get $~lib/rt/itcms/total)
    (call $~lib/rt/itcms/Object#get:size
     (local.get $obj)
    )
   )
  )
  (local.set $ptr
   (i32.add
    (local.get $obj)
    (i32.const 20)
   )
  )
  (memory.fill
   (local.get $ptr)
   (i32.const 0)
   (local.get $size)
  )
  (return
   (local.get $ptr)
  )
 )
 (func $~lib/rt/__newBuffer (param $size i32) (param $id i32) (param $data i32) (result i32)
  (local $buffer i32)
  (local.set $buffer
   (call $~lib/rt/itcms/__new
    (local.get $size)
    (local.get $id)
   )
  )
  (if
   (local.get $data)
   (then
    (memory.copy
     (local.get $buffer)
     (local.get $data)
     (local.get $size)
    )
   )
  )
  (return
   (local.get $buffer)
  )
 )
 (func $std/staticarray/test (result i32)
  (local $0 i32)
  (return
   (call $~lib/rt/__newBuffer
    (i32.const 12)
    (i32.const 4)
    (i32.const 288)
   )
  )
 )
 (func $~lib/object/Object#constructor (param $this i32) (result i32)
  (if
   (i32.eqz
    (local.get $this)
   )
   (then
    (local.set $this
     (call $~lib/rt/__localtostack
      (call $~lib/rt/itcms/__new
       (i32.const 0)
       (i32.const 0)
      )
     )
    )
   )
  )
  (local.get $this)
 )
 (func $std/staticarray/Ref#constructor (param $this i32) (result i32)
  (if
   (i32.eqz
    (local.get $this)
   )
   (then
    (local.set $this
     (call $~lib/rt/__localtostack
      (call $~lib/rt/itcms/__new
       (i32.const 0)
       (i32.const 5)
      )
     )
    )
   )
  )
  (local.set $this
   (call $~lib/rt/__localtostack
    (call $~lib/object/Object#constructor
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (local.get $this)
 )
 (func $~lib/rt/itcms/__link (param $parentPtr i32) (param $childPtr i32) (param $expectMultiple i32)
  (local $child i32)
  (local $parent i32)
  (local $parentColor i32)
  (if
   (i32.eqz
    (local.get $childPtr)
   )
   (then
    (return)
   )
  )
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (local.get $parentPtr)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 384)
     (i32.const 296)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $child
   (i32.sub
    (local.get $childPtr)
    (i32.const 20)
   )
  )
  (if
   (i32.eq
    (call $~lib/rt/itcms/Object#get:color
     (local.get $child)
    )
    (global.get $~lib/rt/itcms/white)
   )
   (then
    (local.set $parent
     (i32.sub
      (local.get $parentPtr)
      (i32.const 20)
     )
    )
    (local.set $parentColor
     (call $~lib/rt/itcms/Object#get:color
      (local.get $parent)
     )
    )
    (if
     (i32.eq
      (local.get $parentColor)
      (i32.eqz
       (global.get $~lib/rt/itcms/white)
      )
     )
     (then
      (if
       (local.get $expectMultiple)
       (then
        (call $~lib/rt/itcms/Object#makeGray
         (local.get $parent)
        )
       )
       (else
        (call $~lib/rt/itcms/Object#makeGray
         (local.get $child)
        )
       )
      )
     )
     (else
      (if
       (if (result i32)
        (i32.eq
         (local.get $parentColor)
         (i32.const 3)
        )
        (then
         (i32.eq
          (global.get $~lib/rt/itcms/state)
          (i32.const 1)
         )
        )
        (else
         (i32.const 0)
        )
       )
       (then
        (call $~lib/rt/itcms/Object#makeGray
         (local.get $child)
        )
       )
      )
     )
    )
   )
  )
 )
 (func $~lib/staticarray/StaticArray<std/staticarray/Ref>#__uset (param $this i32) (param $index i32) (param $value i32)
  (i32.store
   (i32.add
    (local.get $this)
    (i32.shl
     (local.get $index)
     (i32.const 2)
    )
   )
   (local.get $value)
  )
  (drop
   (i32.const 1)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $value)
   (i32.const 1)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#constructor (param $this i32) (param $length i32) (result i32)
  (local $outSize i32)
  (local $out i32)
  (if
   (i32.gt_u
    (local.get $length)
    (i32.shr_u
     (i32.const 1073741820)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 656)
     (i32.const 128)
     (i32.const 51)
     (i32.const 60)
    )
    (unreachable)
   )
  )
  (local.set $outSize
   (i32.shl
    (local.get $length)
    (i32.const 2)
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (local.get $outSize)
     (i32.const 4)
    )
   )
  )
  (drop
   (i32.ne
    (i32.const 2)
    (global.get $~lib/shared/runtime/Runtime.Incremental)
   )
  )
  (return
   (local.get $out)
  )
 )
 (func $~lib/rt/__newArray (param $length i32) (param $alignLog2 i32) (param $id i32) (param $data i32) (result i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (local $array i32)
  (local.set $bufferSize
   (i32.shl
    (local.get $length)
    (local.get $alignLog2)
   )
  )
  (local.set $buffer
   (call $~lib/rt/__localtostack
    (call $~lib/rt/__newBuffer
     (local.get $bufferSize)
     (i32.const 1)
     (local.get $data)
    )
   )
  )
  (local.set $array
   (call $~lib/rt/itcms/__new
    (i32.const 16)
    (local.get $id)
   )
  )
  (i32.store
   (local.get $array)
   (local.get $buffer)
  )
  (call $~lib/rt/itcms/__link
   (local.get $array)
   (local.get $buffer)
   (i32.const 0)
  )
  (i32.store offset=4
   (local.get $array)
   (local.get $buffer)
  )
  (i32.store offset=8
   (local.get $array)
   (local.get $bufferSize)
  )
  (i32.store offset=12
   (local.get $array)
   (local.get $length)
  )
  (return
   (local.get $array)
  )
 )
 (func $~lib/array/Array<i32>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<i32>#get:length (param $this i32) (result i32)
  (return
   (call $~lib/array/Array<i32>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $~lib/array/Array<i32>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/staticarray/StaticArray.fromArray<i32> (param $source i32) (result i32)
  (local $length i32)
  (local $outSize i32)
  (local $out i32)
  (local.set $length
   (call $~lib/array/Array<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $source)
    )
   )
  )
  (local.set $outSize
   (i32.shl
    (local.get $length)
    (i32.const 2)
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (local.get $outSize)
     (i32.const 4)
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (memory.copy
   (local.get $out)
   (call $~lib/array/Array<i32>#get:dataStart
    (call $~lib/rt/__tmptostack
     (local.get $source)
    )
   )
   (local.get $outSize)
  )
  (return
   (local.get $out)
  )
 )
 (func $~lib/array/Array<i32>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/array/Array<i32>#get:length_
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 64)
     (i32.const 752)
     (i32.const 114)
     (i32.const 42)
    )
    (unreachable)
   )
  )
  (local.set $value
   (i32.load
    (i32.add
     (call $~lib/array/Array<i32>#get:dataStart
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.shl
      (local.get $index)
      (i32.const 2)
     )
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (return
   (local.get $value)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#concat<~lib/staticarray/StaticArray<i32>> (param $this i32) (param $other i32) (result i32)
  (local $sourceLen i32)
  (local $otherLen i32)
  (local $outLen i32)
  (local $sourceSize i32)
  (local $out i32)
  (local $outStart i32)
  (local $otherStart i32)
  (local $thisStart i32)
  (local.set $sourceLen
   (call $~lib/staticarray/StaticArray<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $otherLen
   (call $~lib/staticarray/StaticArray<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $other)
    )
   )
  )
  (local.set $outLen
   (i32.add
    (local.get $sourceLen)
    (local.get $otherLen)
   )
  )
  (if
   (i32.gt_u
    (local.get $outLen)
    (i32.shr_u
     (i32.const 1073741820)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 656)
     (i32.const 128)
     (i32.const 178)
     (i32.const 7)
    )
    (unreachable)
   )
  )
  (local.set $sourceSize
   (i32.shl
    (local.get $sourceLen)
    (i32.const 2)
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (local.get $this)
   )
  )
  (drop
   (i32.const 0)
  )
  (block
   (drop
    (i32.const 1)
   )
   (block
    (local.set $out
     (call $~lib/rt/__localtostack
      (call $~lib/rt/itcms/__new
       (i32.shl
        (local.get $outLen)
        (i32.const 2)
       )
       (i32.const 4)
      )
     )
    )
    (local.set $outStart
     (local.get $out)
    )
    (local.set $otherStart
     (local.get $other)
    )
    (local.set $thisStart
     (local.get $this)
    )
    (drop
     (i32.const 0)
    )
    (block
     (memory.copy
      (local.get $outStart)
      (local.get $thisStart)
      (local.get $sourceSize)
     )
     (memory.copy
      (i32.add
       (local.get $outStart)
       (local.get $sourceSize)
      )
      (local.get $otherStart)
      (i32.shl
       (local.get $otherLen)
       (i32.const 2)
      )
     )
    )
   )
  )
  (return
   (local.get $out)
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#get:length (param $this i32) (result i32)
  (return
   (i32.shr_u
    (call $~lib/rt/common/OBJECT#get:rtSize
     (i32.sub
      (local.get $this)
      (i32.const 20)
     )
    )
    (i32.const 2)
   )
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#concat<~lib/staticarray/StaticArray<~lib/string/String>> (param $this i32) (param $other i32) (result i32)
  (local $sourceLen i32)
  (local $otherLen i32)
  (local $outLen i32)
  (local $sourceSize i32)
  (local $out i32)
  (local $outStart i32)
  (local $otherStart i32)
  (local $thisStart i32)
  (local $offset i32)
  (local $ref i32)
  (local $otherSize i32)
  (local $offset|13 i32)
  (local $ref|14 i32)
  (local.set $sourceLen
   (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $otherLen
   (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $other)
    )
   )
  )
  (local.set $outLen
   (i32.add
    (local.get $sourceLen)
    (local.get $otherLen)
   )
  )
  (if
   (i32.gt_u
    (local.get $outLen)
    (i32.shr_u
     (i32.const 1073741820)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 656)
     (i32.const 128)
     (i32.const 178)
     (i32.const 7)
    )
    (unreachable)
   )
  )
  (local.set $sourceSize
   (i32.shl
    (local.get $sourceLen)
    (i32.const 2)
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (local.get $this)
   )
  )
  (drop
   (i32.const 0)
  )
  (block
   (drop
    (i32.const 1)
   )
   (block
    (local.set $out
     (call $~lib/rt/__localtostack
      (call $~lib/rt/itcms/__new
       (i32.shl
        (local.get $outLen)
        (i32.const 2)
       )
       (i32.const 8)
      )
     )
    )
    (local.set $outStart
     (local.get $out)
    )
    (local.set $otherStart
     (local.get $other)
    )
    (local.set $thisStart
     (local.get $this)
    )
    (drop
     (i32.const 1)
    )
    (block
     (local.set $offset
      (i32.const 0)
     )
     (loop $for-loop|0
      (if
       (i32.lt_u
        (local.get $offset)
        (local.get $sourceSize)
       )
       (then
        (local.set $ref
         (i32.load
          (i32.add
           (local.get $thisStart)
           (local.get $offset)
          )
         )
        )
        (i32.store
         (i32.add
          (local.get $outStart)
          (local.get $offset)
         )
         (local.get $ref)
        )
        (call $~lib/rt/itcms/__link
         (local.get $out)
         (local.get $ref)
         (i32.const 1)
        )
        (local.set $offset
         (i32.add
          (local.get $offset)
          (i32.const 4)
         )
        )
        (br $for-loop|0)
       )
      )
     )
     (local.set $outStart
      (i32.add
       (local.get $outStart)
       (local.get $sourceSize)
      )
     )
     (local.set $otherSize
      (i32.shl
       (local.get $otherLen)
       (i32.const 2)
      )
     )
     (local.set $offset|13
      (i32.const 0)
     )
     (loop $for-loop|1
      (if
       (i32.lt_u
        (local.get $offset|13)
        (local.get $otherSize)
       )
       (then
        (local.set $ref|14
         (i32.load
          (i32.add
           (local.get $otherStart)
           (local.get $offset|13)
          )
         )
        )
        (i32.store
         (i32.add
          (local.get $outStart)
          (local.get $offset|13)
         )
         (local.get $ref|14)
        )
        (call $~lib/rt/itcms/__link
         (local.get $out)
         (local.get $ref|14)
         (i32.const 1)
        )
        (local.set $offset|13
         (i32.add
          (local.get $offset|13)
          (i32.const 4)
         )
        )
        (br $for-loop|1)
       )
      )
     )
    )
   )
  )
  (return
   (local.get $out)
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>> (param $this i32) (param $start i32) (param $end i32) (result i32)
  (local $length i32)
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
  (local $sourceStart i32)
  (local $size i32)
  (local $out i32)
  (local $outStart i32)
  (local $off i32)
  (local $ref i32)
  (local.set $length
   (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $start
   (if (result i32)
    (i32.lt_s
     (local.get $start)
     (i32.const 0)
    )
    (then
     (select
      (local.tee $4
       (i32.add
        (local.get $start)
        (local.get $length)
       )
      )
      (local.tee $5
       (i32.const 0)
      )
      (i32.gt_s
       (local.get $4)
       (local.get $5)
      )
     )
    )
    (else
     (select
      (local.tee $6
       (local.get $start)
      )
      (local.tee $7
       (local.get $length)
      )
      (i32.lt_s
       (local.get $6)
       (local.get $7)
      )
     )
    )
   )
  )
  (local.set $end
   (if (result i32)
    (i32.lt_s
     (local.get $end)
     (i32.const 0)
    )
    (then
     (select
      (local.tee $8
       (i32.add
        (local.get $end)
        (local.get $length)
       )
      )
      (local.tee $9
       (i32.const 0)
      )
      (i32.gt_s
       (local.get $8)
       (local.get $9)
      )
     )
    )
    (else
     (select
      (local.tee $10
       (local.get $end)
      )
      (local.tee $11
       (local.get $length)
      )
      (i32.lt_s
       (local.get $10)
       (local.get $11)
      )
     )
    )
   )
  )
  (local.set $length
   (select
    (local.tee $12
     (i32.sub
      (local.get $end)
      (local.get $start)
     )
    )
    (local.tee $13
     (i32.const 0)
    )
    (i32.gt_s
     (local.get $12)
     (local.get $13)
    )
   )
  )
  (local.set $sourceStart
   (i32.add
    (local.get $this)
    (i32.shl
     (local.get $start)
     (i32.const 2)
    )
   )
  )
  (local.set $size
   (i32.shl
    (local.get $length)
    (i32.const 2)
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (local.get $this)
   )
  )
  (drop
   (i32.const 0)
  )
  (block
   (drop
    (i32.const 1)
   )
   (block
    (local.set $out
     (call $~lib/rt/__localtostack
      (call $~lib/rt/itcms/__new
       (local.get $size)
       (i32.const 8)
      )
     )
    )
    (local.set $outStart
     (local.get $out)
    )
    (drop
     (i32.const 1)
    )
    (block
     (local.set $off
      (i32.const 0)
     )
     (block $while-break|0
      (loop $while-continue|0
       (if
        (i32.lt_u
         (local.get $off)
         (local.get $size)
        )
        (then
         (local.set $ref
          (i32.load
           (i32.add
            (local.get $sourceStart)
            (local.get $off)
           )
          )
         )
         (i32.store
          (i32.add
           (local.get $outStart)
           (local.get $off)
          )
          (local.get $ref)
         )
         (call $~lib/rt/itcms/__link
          (local.get $outStart)
          (local.get $ref)
          (i32.const 1)
         )
         (local.set $off
          (i32.add
           (local.get $off)
           (i32.const 4)
          )
         )
         (br $while-continue|0)
        )
       )
      )
     )
    )
   )
  )
  (return
   (local.get $out)
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs (param $this i32) (param $start i32) (param $end i32) (result i32)
  (block $2of2
   (block $1of2
    (block $0of2
     (block $outOfRange
      (br_table $0of2 $1of2 $2of2 $outOfRange
       (global.get $~argumentsLength)
      )
     )
     (unreachable)
    )
    (local.set $start
     (i32.const 0)
    )
   )
   (local.set $end
    (global.get $~lib/builtins/i32.MAX_VALUE)
   )
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $start)
   (local.get $end)
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#__get (param $this i32) (param $index i32) (result i32)
  (local $value i32)
  (if
   (i32.ge_u
    (local.get $index)
    (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 64)
     (i32.const 128)
     (i32.const 78)
     (i32.const 41)
    )
    (unreachable)
   )
  )
  (local.set $value
   (call $~lib/rt/__localtostack
    (i32.load
     (i32.add
      (local.get $this)
      (i32.shl
       (local.get $index)
       (i32.const 2)
      )
     )
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (block
   (drop
    (i32.eqz
     (i32.const 0)
    )
   )
   (if
    (i32.eqz
     (local.get $value)
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 1312)
      (i32.const 128)
      (i32.const 82)
      (i32.const 40)
     )
     (unreachable)
    )
   )
  )
  (return
   (local.get $value)
  )
 )
 (func $~lib/string/String#get:length (param $this i32) (result i32)
  (return
   (i32.shr_u
    (call $~lib/rt/common/OBJECT#get:rtSize
     (i32.sub
      (local.get $this)
      (i32.const 20)
     )
    )
    (i32.const 1)
   )
  )
 )
 (func $~lib/util/string/compareImpl (param $str1 i32) (param $index1 i32) (param $str2 i32) (param $index2 i32) (param $len i32) (result i32)
  (local $ptr1 i32)
  (local $ptr2 i32)
  (local $7 i32)
  (local $a i32)
  (local $b i32)
  (local.set $ptr1
   (i32.add
    (local.get $str1)
    (i32.shl
     (local.get $index1)
     (i32.const 1)
    )
   )
  )
  (local.set $ptr2
   (i32.add
    (local.get $str2)
    (i32.shl
     (local.get $index2)
     (i32.const 1)
    )
   )
  )
  (drop
   (i32.lt_s
    (i32.const 0)
    (i32.const 2)
   )
  )
  (if
   (if (result i32)
    (i32.ge_u
     (local.get $len)
     (i32.const 4)
    )
    (then
     (i32.eqz
      (i32.or
       (i32.and
        (local.get $ptr1)
        (i32.const 7)
       )
       (i32.and
        (local.get $ptr2)
        (i32.const 7)
       )
      )
     )
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (block $do-break|0
     (loop $do-loop|0
      (if
       (i64.ne
        (i64.load
         (local.get $ptr1)
        )
        (i64.load
         (local.get $ptr2)
        )
       )
       (then
        (br $do-break|0)
       )
      )
      (local.set $ptr1
       (i32.add
        (local.get $ptr1)
        (i32.const 8)
       )
      )
      (local.set $ptr2
       (i32.add
        (local.get $ptr2)
        (i32.const 8)
       )
      )
      (local.set $len
       (i32.sub
        (local.get $len)
        (i32.const 4)
       )
      )
      (br_if $do-loop|0
       (i32.ge_u
        (local.get $len)
        (i32.const 4)
       )
      )
     )
    )
   )
  )
  (block $while-break|1
   (loop $while-continue|1
    (if
     (block (result i32)
      (local.set $len
       (i32.sub
        (local.tee $7
         (local.get $len)
        )
        (i32.const 1)
       )
      )
      (local.get $7)
     )
     (then
      (local.set $a
       (i32.load16_u
        (local.get $ptr1)
       )
      )
      (local.set $b
       (i32.load16_u
        (local.get $ptr2)
       )
      )
      (if
       (i32.ne
        (local.get $a)
        (local.get $b)
       )
       (then
        (return
         (i32.sub
          (local.get $a)
          (local.get $b)
         )
        )
       )
      )
      (local.set $ptr1
       (i32.add
        (local.get $ptr1)
        (i32.const 2)
       )
      )
      (local.set $ptr2
       (i32.add
        (local.get $ptr2)
        (i32.const 2)
       )
      )
      (br $while-continue|1)
     )
    )
   )
  )
  (return
   (i32.const 0)
  )
 )
 (func $~lib/string/String.__eq (param $left i32) (param $right i32) (result i32)
  (local $leftLength i32)
  (if
   (i32.eq
    (local.get $left)
    (local.get $right)
   )
   (then
    (return
     (i32.const 1)
    )
   )
  )
  (if
   (if (result i32)
    (i32.eq
     (local.get $left)
     (i32.const 0)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.eq
      (local.get $right)
      (i32.const 0)
     )
    )
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (local.set $leftLength
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (local.get $left)
    )
   )
  )
  (if
   (i32.ne
    (local.get $leftLength)
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $right)
     )
    )
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (return
   (i32.eqz
    (call $~lib/util/string/compareImpl
     (call $~lib/rt/__tmptostack
      (local.get $left)
     )
     (i32.const 0)
     (call $~lib/rt/__tmptostack
      (local.get $right)
     )
     (i32.const 0)
     (local.get $leftLength)
    )
   )
  )
 )
 (func $~lib/array/Array<~lib/string/String>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/string/String>#get:length (param $this i32) (result i32)
  (return
   (call $~lib/array/Array<~lib/string/String>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $~lib/array/Array<~lib/string/String>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#concat<~lib/array/Array<~lib/string/String>> (param $this i32) (param $other i32) (result i32)
  (local $sourceLen i32)
  (local $otherLen i32)
  (local $outLen i32)
  (local $sourceSize i32)
  (local $out i32)
  (local $outStart i32)
  (local $otherStart i32)
  (local $thisStart i32)
  (local $offset i32)
  (local $ref i32)
  (local $otherSize i32)
  (local $offset|13 i32)
  (local $ref|14 i32)
  (local.set $sourceLen
   (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $otherLen
   (call $~lib/array/Array<~lib/string/String>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $other)
    )
   )
  )
  (local.set $outLen
   (i32.add
    (local.get $sourceLen)
    (local.get $otherLen)
   )
  )
  (if
   (i32.gt_u
    (local.get $outLen)
    (i32.shr_u
     (i32.const 1073741820)
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 656)
     (i32.const 128)
     (i32.const 178)
     (i32.const 7)
    )
    (unreachable)
   )
  )
  (local.set $sourceSize
   (i32.shl
    (local.get $sourceLen)
    (i32.const 2)
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (local.get $this)
   )
  )
  (drop
   (i32.const 1)
  )
  (block
   (local.set $out
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newArray
      (local.get $outLen)
      (i32.const 2)
      (i32.const 9)
      (i32.const 0)
     )
    )
   )
   (local.set $outStart
    (call $~lib/array/Array<~lib/string/String>#get:dataStart
     (call $~lib/rt/__tmptostack
      (local.get $out)
     )
    )
   )
   (local.set $otherStart
    (call $~lib/array/Array<~lib/string/String>#get:dataStart
     (call $~lib/rt/__tmptostack
      (local.get $other)
     )
    )
   )
   (local.set $thisStart
    (local.get $this)
   )
   (drop
    (i32.const 1)
   )
   (block
    (local.set $offset
     (i32.const 0)
    )
    (loop $for-loop|0
     (if
      (i32.lt_u
       (local.get $offset)
       (local.get $sourceSize)
      )
      (then
       (local.set $ref
        (i32.load
         (i32.add
          (local.get $thisStart)
          (local.get $offset)
         )
        )
       )
       (i32.store
        (i32.add
         (local.get $outStart)
         (local.get $offset)
        )
        (local.get $ref)
       )
       (call $~lib/rt/itcms/__link
        (local.get $out)
        (local.get $ref)
        (i32.const 1)
       )
       (local.set $offset
        (i32.add
         (local.get $offset)
         (i32.const 4)
        )
       )
       (br $for-loop|0)
      )
     )
    )
    (local.set $outStart
     (i32.add
      (local.get $outStart)
      (local.get $sourceSize)
     )
    )
    (local.set $otherSize
     (i32.shl
      (local.get $otherLen)
      (i32.const 2)
     )
    )
    (local.set $offset|13
     (i32.const 0)
    )
    (loop $for-loop|1
     (if
      (i32.lt_u
       (local.get $offset|13)
       (local.get $otherSize)
      )
      (then
       (local.set $ref|14
        (i32.load
         (i32.add
          (local.get $otherStart)
          (local.get $offset|13)
         )
        )
       )
       (i32.store
        (i32.add
         (local.get $outStart)
         (local.get $offset|13)
        )
        (local.get $ref|14)
       )
       (call $~lib/rt/itcms/__link
        (local.get $out)
        (local.get $ref|14)
        (i32.const 1)
       )
       (local.set $offset|13
        (i32.add
         (local.get $offset|13)
         (i32.const 4)
        )
       )
       (br $for-loop|1)
      )
     )
    )
   )
  )
  (return
   (local.get $out)
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#indexOf (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (local $length i32)
  (local $4 i32)
  (local $5 i32)
  (local.set $length
   (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (if
   (if (result i32)
    (i32.eq
     (local.get $length)
     (i32.const 0)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.ge_s
      (local.get $fromIndex)
      (local.get $length)
     )
    )
   )
   (then
    (return
     (i32.const -1)
    )
   )
  )
  (if
   (i32.lt_s
    (local.get $fromIndex)
    (i32.const 0)
   )
   (then
    (local.set $fromIndex
     (select
      (local.tee $4
       (i32.add
        (local.get $length)
        (local.get $fromIndex)
       )
      )
      (local.tee $5
       (i32.const 0)
      )
      (i32.gt_s
       (local.get $4)
       (local.get $5)
      )
     )
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.lt_s
      (local.get $fromIndex)
      (local.get $length)
     )
     (then
      (if
       (call $~lib/string/String.__eq
        (call $~lib/rt/__tmptostack
         (i32.load
          (i32.add
           (local.get $this)
           (i32.shl
            (local.get $fromIndex)
            (i32.const 2)
           )
          )
         )
        )
        (call $~lib/rt/__tmptostack
         (local.get $value)
        )
       )
       (then
        (return
         (local.get $fromIndex)
        )
       )
      )
      (local.set $fromIndex
       (i32.add
        (local.get $fromIndex)
        (i32.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (return
   (i32.const -1)
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#includes (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (drop
   (i32.const 0)
  )
  (return
   (i32.ge_s
    (call $~lib/staticarray/StaticArray<~lib/string/String>#indexOf
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (call $~lib/rt/__tmptostack
      (local.get $value)
     )
     (local.get $fromIndex)
    )
    (i32.const 0)
   )
  )
 )
 (func $~lib/staticarray/StaticArray<f64>#get:length (param $this i32) (result i32)
  (return
   (i32.shr_u
    (call $~lib/rt/common/OBJECT#get:rtSize
     (i32.sub
      (local.get $this)
      (i32.const 20)
     )
    )
    (i32.const 3)
   )
  )
 )
 (func $~lib/staticarray/StaticArray<f64>#includes (param $this i32) (param $value f64) (param $fromIndex i32) (result i32)
  (local $length i32)
  (local $4 i32)
  (local $5 i32)
  (local $elem f64)
  (drop
   (i32.const 1)
  )
  (block
   (local.set $length
    (call $~lib/staticarray/StaticArray<f64>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (if
    (if (result i32)
     (i32.eq
      (local.get $length)
      (i32.const 0)
     )
     (then
      (i32.const 1)
     )
     (else
      (i32.ge_s
       (local.get $fromIndex)
       (local.get $length)
      )
     )
    )
    (then
     (return
      (i32.const 0)
     )
    )
   )
   (if
    (i32.lt_s
     (local.get $fromIndex)
     (i32.const 0)
    )
    (then
     (local.set $fromIndex
      (select
       (local.tee $4
        (i32.add
         (local.get $length)
         (local.get $fromIndex)
        )
       )
       (local.tee $5
        (i32.const 0)
       )
       (i32.gt_s
        (local.get $4)
        (local.get $5)
       )
      )
     )
    )
   )
   (block $while-break|0
    (loop $while-continue|0
     (if
      (i32.lt_s
       (local.get $fromIndex)
       (local.get $length)
      )
      (then
       (local.set $elem
        (f64.load
         (i32.add
          (local.get $this)
          (i32.shl
           (local.get $fromIndex)
           (i32.const 3)
          )
         )
        )
       )
       (if
        (if (result i32)
         (f64.eq
          (local.get $elem)
          (local.get $value)
         )
         (then
          (i32.const 1)
         )
         (else
          (i32.and
           (f64.ne
            (local.get $elem)
            (local.get $elem)
           )
           (f64.ne
            (local.get $value)
            (local.get $value)
           )
          )
         )
        )
        (then
         (return
          (i32.const 1)
         )
        )
       )
       (local.set $fromIndex
        (i32.add
         (local.get $fromIndex)
         (i32.const 1)
        )
       )
       (br $while-continue|0)
      )
     )
    )
   )
   (return
    (i32.const 0)
   )
  )
 )
 (func $~lib/staticarray/StaticArray<f32>#get:length (param $this i32) (result i32)
  (return
   (i32.shr_u
    (call $~lib/rt/common/OBJECT#get:rtSize
     (i32.sub
      (local.get $this)
      (i32.const 20)
     )
    )
    (i32.const 2)
   )
  )
 )
 (func $~lib/staticarray/StaticArray<f32>#includes (param $this i32) (param $value f32) (param $fromIndex i32) (result i32)
  (local $length i32)
  (local $4 i32)
  (local $5 i32)
  (local $elem f32)
  (drop
   (i32.const 1)
  )
  (block
   (local.set $length
    (call $~lib/staticarray/StaticArray<f32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (if
    (if (result i32)
     (i32.eq
      (local.get $length)
      (i32.const 0)
     )
     (then
      (i32.const 1)
     )
     (else
      (i32.ge_s
       (local.get $fromIndex)
       (local.get $length)
      )
     )
    )
    (then
     (return
      (i32.const 0)
     )
    )
   )
   (if
    (i32.lt_s
     (local.get $fromIndex)
     (i32.const 0)
    )
    (then
     (local.set $fromIndex
      (select
       (local.tee $4
        (i32.add
         (local.get $length)
         (local.get $fromIndex)
        )
       )
       (local.tee $5
        (i32.const 0)
       )
       (i32.gt_s
        (local.get $4)
        (local.get $5)
       )
      )
     )
    )
   )
   (block $while-break|0
    (loop $while-continue|0
     (if
      (i32.lt_s
       (local.get $fromIndex)
       (local.get $length)
      )
      (then
       (local.set $elem
        (f32.load
         (i32.add
          (local.get $this)
          (i32.shl
           (local.get $fromIndex)
           (i32.const 2)
          )
         )
        )
       )
       (if
        (if (result i32)
         (f32.eq
          (local.get $elem)
          (local.get $value)
         )
         (then
          (i32.const 1)
         )
         (else
          (i32.and
           (f32.ne
            (local.get $elem)
            (local.get $elem)
           )
           (f32.ne
            (local.get $value)
            (local.get $value)
           )
          )
         )
        )
        (then
         (return
          (i32.const 1)
         )
        )
       )
       (local.set $fromIndex
        (i32.add
         (local.get $fromIndex)
         (i32.const 1)
        )
       )
       (br $while-continue|0)
      )
     )
    )
   )
   (return
    (i32.const 0)
   )
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#indexOf (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (local $length i32)
  (local $4 i32)
  (local $5 i32)
  (local.set $length
   (call $~lib/staticarray/StaticArray<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (if
   (if (result i32)
    (i32.eq
     (local.get $length)
     (i32.const 0)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.ge_s
      (local.get $fromIndex)
      (local.get $length)
     )
    )
   )
   (then
    (return
     (i32.const -1)
    )
   )
  )
  (if
   (i32.lt_s
    (local.get $fromIndex)
    (i32.const 0)
   )
   (then
    (local.set $fromIndex
     (select
      (local.tee $4
       (i32.add
        (local.get $length)
        (local.get $fromIndex)
       )
      )
      (local.tee $5
       (i32.const 0)
      )
      (i32.gt_s
       (local.get $4)
       (local.get $5)
      )
     )
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.lt_s
      (local.get $fromIndex)
      (local.get $length)
     )
     (then
      (if
       (i32.eq
        (i32.load
         (i32.add
          (local.get $this)
          (i32.shl
           (local.get $fromIndex)
           (i32.const 2)
          )
         )
        )
        (local.get $value)
       )
       (then
        (return
         (local.get $fromIndex)
        )
       )
      )
      (local.set $fromIndex
       (i32.add
        (local.get $fromIndex)
        (i32.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (return
   (i32.const -1)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#lastIndexOf (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (local $length i32)
  (local.set $length
   (call $~lib/staticarray/StaticArray<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (if
   (i32.eq
    (local.get $length)
    (i32.const 0)
   )
   (then
    (return
     (i32.const -1)
    )
   )
  )
  (if
   (i32.lt_s
    (local.get $fromIndex)
    (i32.const 0)
   )
   (then
    (local.set $fromIndex
     (i32.add
      (local.get $length)
      (local.get $fromIndex)
     )
    )
   )
   (else
    (if
     (i32.ge_s
      (local.get $fromIndex)
      (local.get $length)
     )
     (then
      (local.set $fromIndex
       (i32.sub
        (local.get $length)
        (i32.const 1)
       )
      )
     )
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.ge_s
      (local.get $fromIndex)
      (i32.const 0)
     )
     (then
      (if
       (i32.eq
        (i32.load
         (i32.add
          (local.get $this)
          (i32.shl
           (local.get $fromIndex)
           (i32.const 2)
          )
         )
        )
        (local.get $value)
       )
       (then
        (return
         (local.get $fromIndex)
        )
       )
      )
      (local.set $fromIndex
       (i32.sub
        (local.get $fromIndex)
        (i32.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (return
   (i32.const -1)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#lastIndexOf@varargs (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (block $1of1
   (block $0of1
    (block $outOfRange
     (br_table $0of1 $1of1 $outOfRange
      (i32.sub
       (global.get $~argumentsLength)
       (i32.const 1)
      )
     )
    )
    (unreachable)
   )
   (local.set $fromIndex
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (call $~lib/staticarray/StaticArray<i32>#lastIndexOf
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $value)
   (local.get $fromIndex)
  )
 )
 (func $~lib/util/string/joinStringArray (param $dataStart i32) (param $length i32) (param $separator i32) (result i32)
  (local $lastIndex i32)
  (local $4 i32)
  (local $estLen i32)
  (local $value i32)
  (local $i i32)
  (local $offset i32)
  (local $sepLen i32)
  (local $result i32)
  (local $i|11 i32)
  (local $valueLen i32)
  (local.set $lastIndex
   (i32.sub
    (local.get $length)
    (i32.const 1)
   )
  )
  (if
   (i32.lt_s
    (local.get $lastIndex)
    (i32.const 0)
   )
   (then
    (return
     (i32.const 1904)
    )
   )
  )
  (if
   (i32.eqz
    (local.get $lastIndex)
   )
   (then
    (return
     (if (result i32)
      (local.tee $4
       (call $~lib/rt/__localtostack
        (i32.load
         (local.get $dataStart)
        )
       )
      )
      (then
       (local.get $4)
      )
      (else
       (i32.const 1904)
      )
     )
    )
   )
  )
  (local.set $estLen
   (i32.const 0)
  )
  (local.set $i
   (i32.const 0)
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $length)
    )
    (then
     (local.set $value
      (call $~lib/rt/__localtostack
       (i32.load
        (i32.add
         (local.get $dataStart)
         (i32.shl
          (local.get $i)
          (i32.const 2)
         )
        )
       )
      )
     )
     (if
      (i32.ne
       (local.get $value)
       (i32.const 0)
      )
      (then
       (local.set $estLen
        (i32.add
         (local.get $estLen)
         (call $~lib/string/String#get:length
          (call $~lib/rt/__tmptostack
           (local.get $value)
          )
         )
        )
       )
      )
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (local.set $offset
   (i32.const 0)
  )
  (local.set $sepLen
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (local.get $separator)
    )
   )
  )
  (local.set $result
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (i32.shl
      (i32.add
       (local.get $estLen)
       (i32.mul
        (local.get $sepLen)
        (local.get $lastIndex)
       )
      )
      (i32.const 1)
     )
     (i32.const 2)
    )
   )
  )
  (local.set $i|11
   (i32.const 0)
  )
  (loop $for-loop|1
   (if
    (i32.lt_s
     (local.get $i|11)
     (local.get $lastIndex)
    )
    (then
     (local.set $value
      (call $~lib/rt/__localtostack
       (i32.load
        (i32.add
         (local.get $dataStart)
         (i32.shl
          (local.get $i|11)
          (i32.const 2)
         )
        )
       )
      )
     )
     (if
      (i32.ne
       (local.get $value)
       (i32.const 0)
      )
      (then
       (local.set $valueLen
        (call $~lib/string/String#get:length
         (call $~lib/rt/__tmptostack
          (local.get $value)
         )
        )
       )
       (memory.copy
        (i32.add
         (local.get $result)
         (i32.shl
          (local.get $offset)
          (i32.const 1)
         )
        )
        (local.get $value)
        (i32.shl
         (local.get $valueLen)
         (i32.const 1)
        )
       )
       (local.set $offset
        (i32.add
         (local.get $offset)
         (local.get $valueLen)
        )
       )
      )
     )
     (if
      (local.get $sepLen)
      (then
       (memory.copy
        (i32.add
         (local.get $result)
         (i32.shl
          (local.get $offset)
          (i32.const 1)
         )
        )
        (local.get $separator)
        (i32.shl
         (local.get $sepLen)
         (i32.const 1)
        )
       )
       (local.set $offset
        (i32.add
         (local.get $offset)
         (local.get $sepLen)
        )
       )
      )
     )
     (local.set $i|11
      (i32.add
       (local.get $i|11)
       (i32.const 1)
      )
     )
     (br $for-loop|1)
    )
   )
  )
  (local.set $value
   (call $~lib/rt/__localtostack
    (i32.load
     (i32.add
      (local.get $dataStart)
      (i32.shl
       (local.get $lastIndex)
       (i32.const 2)
      )
     )
    )
   )
  )
  (if
   (i32.ne
    (local.get $value)
    (i32.const 0)
   )
   (then
    (memory.copy
     (i32.add
      (local.get $result)
      (i32.shl
       (local.get $offset)
       (i32.const 1)
      )
     )
     (local.get $value)
     (i32.shl
      (call $~lib/string/String#get:length
       (call $~lib/rt/__tmptostack
        (local.get $value)
       )
      )
      (i32.const 1)
     )
    )
   )
  )
  (return
   (local.get $result)
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#join (param $this i32) (param $separator i32) (result i32)
  (drop
   (i32.const 0)
  )
  (drop
   (i32.const 0)
  )
  (drop
   (i32.const 0)
  )
  (drop
   (i32.lt_s
    (i32.const 0)
    (i32.const 1)
   )
  )
  (block
   (drop
    (i32.const 1)
   )
   (return
    (call $~lib/util/string/joinStringArray
     (local.get $this)
     (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (call $~lib/rt/__tmptostack
      (local.get $separator)
     )
    )
   )
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#toString (param $this i32) (result i32)
  (return
   (call $~lib/staticarray/StaticArray<~lib/string/String>#join
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (i32.const 1936)
   )
  )
 )
 (func $~lib/util/bytes/FILL<i32> (param $ptr i32) (param $len i32) (param $value i32) (param $start i32) (param $end i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local.set $start
   (if (result i32)
    (i32.lt_s
     (local.get $start)
     (i32.const 0)
    )
    (then
     (select
      (local.tee $5
       (i32.add
        (local.get $len)
        (local.get $start)
       )
      )
      (local.tee $6
       (i32.const 0)
      )
      (i32.gt_u
       (local.get $5)
       (local.get $6)
      )
     )
    )
    (else
     (select
      (local.tee $7
       (local.get $start)
      )
      (local.tee $8
       (local.get $len)
      )
      (i32.lt_s
       (local.get $7)
       (local.get $8)
      )
     )
    )
   )
  )
  (local.set $end
   (if (result i32)
    (i32.lt_s
     (local.get $end)
     (i32.const 0)
    )
    (then
     (select
      (local.tee $9
       (i32.add
        (local.get $len)
        (local.get $end)
       )
      )
      (local.tee $10
       (i32.const 0)
      )
      (i32.gt_u
       (local.get $9)
       (local.get $10)
      )
     )
    )
    (else
     (select
      (local.tee $11
       (local.get $end)
      )
      (local.tee $12
       (local.get $len)
      )
      (i32.lt_s
       (local.get $11)
       (local.get $12)
      )
     )
    )
   )
  )
  (drop
   (i32.eq
    (i32.const 4)
    (i32.const 1)
   )
  )
  (block
   (drop
    (i32.le_s
     (i32.const 0)
     (i32.const 1)
    )
   )
   (block
    (drop
     (i32.const 1)
    )
    (if
     (i32.or
      (i32.eq
       (local.get $value)
       (i32.const 0)
      )
      (i32.eq
       (local.get $value)
       (i32.const -1)
      )
     )
     (then
      (if
       (i32.lt_s
        (local.get $start)
        (local.get $end)
       )
       (then
        (memory.fill
         (i32.add
          (local.get $ptr)
          (i32.shl
           (local.get $start)
           (i32.const 2)
          )
         )
         (local.get $value)
         (i32.shl
          (i32.sub
           (local.get $end)
           (local.get $start)
          )
          (i32.const 2)
         )
        )
       )
      )
      (return)
     )
    )
   )
   (loop $for-loop|0
    (if
     (i32.lt_s
      (local.get $start)
      (local.get $end)
     )
     (then
      (i32.store
       (i32.add
        (local.get $ptr)
        (i32.shl
         (local.get $start)
         (i32.const 2)
        )
       )
       (local.get $value)
      )
      (local.set $start
       (i32.add
        (local.get $start)
        (i32.const 1)
       )
      )
      (br $for-loop|0)
     )
    )
   )
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#fill (param $this i32) (param $value i32) (param $start i32) (param $end i32) (result i32)
  (drop
   (i32.const 0)
  )
  (call $~lib/util/bytes/FILL<i32>
   (local.get $this)
   (call $~lib/staticarray/StaticArray<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $value)
   (local.get $start)
   (local.get $end)
  )
  (return
   (local.get $this)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#fill@varargs (param $this i32) (param $value i32) (param $start i32) (param $end i32) (result i32)
  (block $2of2
   (block $1of2
    (block $0of2
     (block $outOfRange
      (br_table $0of2 $1of2 $2of2 $outOfRange
       (i32.sub
        (global.get $~argumentsLength)
        (i32.const 1)
       )
      )
     )
     (unreachable)
    )
    (local.set $start
     (i32.const 0)
    )
   )
   (local.set $end
    (global.get $~lib/builtins/i32.MAX_VALUE)
   )
  )
  (call $~lib/staticarray/StaticArray<i32>#fill
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $value)
   (local.get $start)
   (local.get $end)
  )
 )
 (func $~lib/util/bytes/REVERSE<i32> (param $ptr i32) (param $len i32)
  (local $i i32)
  (local $tail i32)
  (local $hlen i32)
  (local $front i32)
  (local $back i32)
  (local $temp i32)
  (if
   (i32.gt_u
    (local.get $len)
    (i32.const 1)
   )
   (then
    (local.set $i
     (i32.const 0)
    )
    (local.set $hlen
     (i32.shr_u
      (local.get $len)
      (i32.const 1)
     )
    )
    (drop
     (i32.lt_s
      (i32.const 0)
      (i32.const 1)
     )
    )
    (block
     (drop
      (i32.eq
       (i32.const 4)
       (i32.const 1)
      )
     )
     (drop
      (i32.eq
       (i32.const 4)
       (i32.const 2)
      )
     )
    )
    (local.set $tail
     (i32.sub
      (local.get $len)
      (i32.const 1)
     )
    )
    (block $while-break|0
     (loop $while-continue|0
      (if
       (i32.lt_u
        (local.get $i)
        (local.get $hlen)
       )
       (then
        (local.set $front
         (i32.add
          (local.get $ptr)
          (i32.shl
           (local.get $i)
           (i32.const 2)
          )
         )
        )
        (local.set $back
         (i32.add
          (local.get $ptr)
          (i32.shl
           (i32.sub
            (local.get $tail)
            (local.get $i)
           )
           (i32.const 2)
          )
         )
        )
        (local.set $temp
         (i32.load
          (local.get $front)
         )
        )
        (i32.store
         (local.get $front)
         (i32.load
          (local.get $back)
         )
        )
        (i32.store
         (local.get $back)
         (local.get $temp)
        )
        (local.set $i
         (i32.add
          (local.get $i)
          (i32.const 1)
         )
        )
        (br $while-continue|0)
       )
      )
     )
    )
   )
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#reverse (param $this i32) (result i32)
  (call $~lib/util/bytes/REVERSE<i32>
   (local.get $this)
   (call $~lib/staticarray/StaticArray<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (return
   (local.get $this)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#copyWithin (param $this i32) (param $target i32) (param $start i32) (param $end i32) (result i32)
  (local $ptr i32)
  (local $len i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $to i32)
  (local $13 i32)
  (local $14 i32)
  (local $15 i32)
  (local $16 i32)
  (local $from i32)
  (local $18 i32)
  (local $19 i32)
  (local $20 i32)
  (local $21 i32)
  (local $last i32)
  (local $23 i32)
  (local $24 i32)
  (local $count i32)
  (local.set $ptr
   (local.get $this)
  )
  (local.set $len
   (call $~lib/staticarray/StaticArray<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $end
   (select
    (local.tee $6
     (local.get $end)
    )
    (local.tee $7
     (local.get $len)
    )
    (i32.lt_s
     (local.get $6)
     (local.get $7)
    )
   )
  )
  (local.set $to
   (if (result i32)
    (i32.lt_s
     (local.get $target)
     (i32.const 0)
    )
    (then
     (select
      (local.tee $8
       (i32.add
        (local.get $len)
        (local.get $target)
       )
      )
      (local.tee $9
       (i32.const 0)
      )
      (i32.gt_s
       (local.get $8)
       (local.get $9)
      )
     )
    )
    (else
     (select
      (local.tee $10
       (local.get $target)
      )
      (local.tee $11
       (local.get $len)
      )
      (i32.lt_s
       (local.get $10)
       (local.get $11)
      )
     )
    )
   )
  )
  (local.set $from
   (if (result i32)
    (i32.lt_s
     (local.get $start)
     (i32.const 0)
    )
    (then
     (select
      (local.tee $13
       (i32.add
        (local.get $len)
        (local.get $start)
       )
      )
      (local.tee $14
       (i32.const 0)
      )
      (i32.gt_s
       (local.get $13)
       (local.get $14)
      )
     )
    )
    (else
     (select
      (local.tee $15
       (local.get $start)
      )
      (local.tee $16
       (local.get $len)
      )
      (i32.lt_s
       (local.get $15)
       (local.get $16)
      )
     )
    )
   )
  )
  (local.set $last
   (if (result i32)
    (i32.lt_s
     (local.get $end)
     (i32.const 0)
    )
    (then
     (select
      (local.tee $18
       (i32.add
        (local.get $len)
        (local.get $end)
       )
      )
      (local.tee $19
       (i32.const 0)
      )
      (i32.gt_s
       (local.get $18)
       (local.get $19)
      )
     )
    )
    (else
     (select
      (local.tee $20
       (local.get $end)
      )
      (local.tee $21
       (local.get $len)
      )
      (i32.lt_s
       (local.get $20)
       (local.get $21)
      )
     )
    )
   )
  )
  (local.set $count
   (select
    (local.tee $23
     (i32.sub
      (local.get $last)
      (local.get $from)
     )
    )
    (local.tee $24
     (i32.sub
      (local.get $len)
      (local.get $to)
     )
    )
    (i32.lt_s
     (local.get $23)
     (local.get $24)
    )
   )
  )
  (memory.copy
   (i32.add
    (local.get $ptr)
    (i32.shl
     (local.get $to)
     (i32.const 2)
    )
   )
   (i32.add
    (local.get $ptr)
    (i32.shl
     (local.get $from)
     (i32.const 2)
    )
   )
   (i32.shl
    (local.get $count)
    (i32.const 2)
   )
  )
  (return
   (local.get $this)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#copyWithin@varargs (param $this i32) (param $target i32) (param $start i32) (param $end i32) (result i32)
  (block $1of1
   (block $0of1
    (block $outOfRange
     (br_table $0of1 $1of1 $outOfRange
      (i32.sub
       (global.get $~argumentsLength)
       (i32.const 2)
      )
     )
    )
    (unreachable)
   )
   (local.set $end
    (global.get $~lib/builtins/i32.MAX_VALUE)
   )
  )
  (call $~lib/staticarray/StaticArray<i32>#copyWithin
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $target)
   (local.get $start)
   (local.get $end)
  )
 )
 (func $start:std/staticarray~anonymous|0 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.add
   (local.get $x)
   (i32.const 1)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#map<i32> (param $this i32) (param $fn i32) (result i32)
  (local $len i32)
  (local $out i32)
  (local $outStart i32)
  (local $i i32)
  (local $result i32)
  (local.set $len
   (call $~lib/staticarray/StaticArray<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (call $~lib/rt/__newArray
     (local.get $len)
     (i32.const 2)
     (i32.const 7)
     (i32.const 0)
    )
   )
  )
  (local.set $outStart
   (call $~lib/array/Array<i32>#get:dataStart
    (call $~lib/rt/__tmptostack
     (local.get $out)
    )
   )
  )
  (local.set $i
   (i32.const 0)
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $len)
    )
    (then
     (local.set $result
      (call_indirect (type $3)
       (i32.load
        (i32.add
         (local.get $this)
         (i32.shl
          (local.get $i)
          (i32.const 2)
         )
        )
       )
       (local.get $i)
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (i32.load
        (block (result i32)
         (global.set $~argumentsLength
          (i32.const 3)
         )
         (local.get $fn)
        )
       )
      )
     )
     (i32.store
      (i32.add
       (local.get $outStart)
       (i32.shl
        (local.get $i)
        (i32.const 2)
       )
      )
      (local.get $result)
     )
     (drop
      (i32.const 0)
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (return
   (local.get $out)
  )
 )
 (func $start:std/staticarray~anonymous|1 (param $x i32) (param $$1 i32) (param $$2 i32)
  (local $3 i32)
  (local $4 i32)
  (global.set $std/staticarray/maxVal
   (select
    (local.tee $3
     (global.get $std/staticarray/maxVal)
    )
    (local.tee $4
     (local.get $x)
    )
    (i32.gt_s
     (local.get $3)
     (local.get $4)
    )
   )
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#forEach (param $this i32) (param $fn i32)
  (local $i i32)
  (local $len i32)
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $len)
    )
    (then
     (call_indirect (type $5)
      (i32.load
       (i32.add
        (local.get $this)
        (i32.shl
         (local.get $i)
         (i32.const 2)
        )
       )
      )
      (local.get $i)
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
      (i32.load
       (block (result i32)
        (global.set $~argumentsLength
         (i32.const 3)
        )
        (local.get $fn)
       )
      )
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
 )
 (func $start:std/staticarray~anonymous|2 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.ge_s
   (local.get $x)
   (i32.const 2)
  )
 )
 (func $~lib/arraybuffer/ArrayBufferView#get:byteLength (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $~lib/arraybuffer/ArrayBufferView#get:buffer (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/rt/itcms/Object#get:rtSize (param $this i32) (result i32)
  (i32.load offset=16
   (local.get $this)
  )
 )
 (func $~lib/rt/itcms/__renew (param $oldPtr i32) (param $size i32) (result i32)
  (local $oldObj i32)
  (local $newPtr i32)
  (local $4 i32)
  (local $5 i32)
  (local.set $oldObj
   (i32.sub
    (local.get $oldPtr)
    (i32.const 20)
   )
  )
  (if
   (i32.le_u
    (local.get $size)
    (i32.sub
     (i32.and
      (call $~lib/rt/common/BLOCK#get:mmInfo
       (local.get $oldObj)
      )
      (i32.xor
       (i32.const 3)
       (i32.const -1)
      )
     )
     (i32.const 16)
    )
   )
   (then
    (call $~lib/rt/itcms/Object#set:rtSize
     (local.get $oldObj)
     (local.get $size)
    )
    (return
     (local.get $oldPtr)
    )
   )
  )
  (local.set $newPtr
   (call $~lib/rt/itcms/__new
    (local.get $size)
    (call $~lib/rt/itcms/Object#get:rtId
     (local.get $oldObj)
    )
   )
  )
  (memory.copy
   (local.get $newPtr)
   (local.get $oldPtr)
   (select
    (local.tee $4
     (local.get $size)
    )
    (local.tee $5
     (call $~lib/rt/itcms/Object#get:rtSize
      (local.get $oldObj)
     )
    )
    (i32.lt_u
     (local.get $4)
     (local.get $5)
    )
   )
  )
  (return
   (local.get $newPtr)
  )
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
  (local.set $oldCapacity
   (call $~lib/arraybuffer/ArrayBufferView#get:byteLength
    (call $~lib/rt/__tmptostack
     (local.get $array)
    )
   )
  )
  (if
   (i32.gt_u
    (local.get $newSize)
    (i32.shr_u
     (local.get $oldCapacity)
     (local.get $alignLog2)
    )
   )
   (then
    (if
     (i32.gt_u
      (local.get $newSize)
      (i32.shr_u
       (i32.const 1073741820)
       (local.get $alignLog2)
      )
     )
     (then
      (call $~lib/builtins/abort
       (i32.const 656)
       (i32.const 752)
       (i32.const 19)
       (i32.const 48)
      )
      (unreachable)
     )
    )
    (local.set $oldData
     (call $~lib/arraybuffer/ArrayBufferView#get:buffer
      (call $~lib/rt/__tmptostack
       (local.get $array)
      )
     )
    )
    (local.set $newCapacity
     (i32.shl
      (select
       (local.tee $6
        (local.get $newSize)
       )
       (local.tee $7
        (i32.const 8)
       )
       (i32.gt_u
        (local.get $6)
        (local.get $7)
       )
      )
      (local.get $alignLog2)
     )
    )
    (if
     (local.get $canGrow)
     (then
      (local.set $newCapacity
       (select
        (local.tee $11
         (select
          (local.tee $9
           (i32.shl
            (local.get $oldCapacity)
            (i32.const 1)
           )
          )
          (local.tee $10
           (i32.const 1073741820)
          )
          (i32.lt_u
           (local.get $9)
           (local.get $10)
          )
         )
        )
        (local.tee $12
         (local.get $newCapacity)
        )
        (i32.gt_u
         (local.get $11)
         (local.get $12)
        )
       )
      )
     )
    )
    (local.set $newData
     (call $~lib/rt/itcms/__renew
      (local.get $oldData)
      (local.get $newCapacity)
     )
    )
    (drop
     (i32.ne
      (i32.const 2)
      (global.get $~lib/shared/runtime/Runtime.Incremental)
     )
    )
    (if
     (i32.ne
      (local.get $newData)
      (local.get $oldData)
     )
     (then
      (i32.store
       (local.get $array)
       (local.get $newData)
      )
      (i32.store offset=4
       (local.get $array)
       (local.get $newData)
      )
      (call $~lib/rt/itcms/__link
       (local.get $array)
       (local.get $newData)
       (i32.const 0)
      )
     )
    )
    (i32.store offset=8
     (local.get $array)
     (local.get $newCapacity)
    )
   )
  )
 )
 (func $~lib/array/Array<i32>#set:length_ (param $this i32) (param $length_ i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $length_)
  )
 )
 (func $~lib/array/Array<i32>#push (param $this i32) (param $value i32) (result i32)
  (local $oldLen i32)
  (local $len i32)
  (local.set $oldLen
   (call $~lib/array/Array<i32>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $len
   (i32.add
    (local.get $oldLen)
    (i32.const 1)
   )
  )
  (call $~lib/array/ensureCapacity
   (local.get $this)
   (local.get $len)
   (i32.const 2)
   (i32.const 1)
  )
  (drop
   (i32.const 0)
  )
  (i32.store
   (i32.add
    (call $~lib/array/Array<i32>#get:dataStart
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.shl
     (local.get $oldLen)
     (i32.const 2)
    )
   )
   (local.get $value)
  )
  (call $~lib/array/Array<i32>#set:length_
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $len)
  )
  (return
   (local.get $len)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#filter (param $this i32) (param $fn i32) (result i32)
  (local $result i32)
  (local $i i32)
  (local $len i32)
  (local $value i32)
  (local.set $result
   (call $~lib/rt/__localtostack
    (call $~lib/rt/__newArray
     (i32.const 0)
     (i32.const 2)
     (i32.const 7)
     (i32.const 0)
    )
   )
  )
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $len)
    )
    (then
     (local.set $value
      (i32.load
       (i32.add
        (local.get $this)
        (i32.shl
         (local.get $i)
         (i32.const 2)
        )
       )
      )
     )
     (if
      (call_indirect (type $3)
       (local.get $value)
       (local.get $i)
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (i32.load
        (block (result i32)
         (global.set $~argumentsLength
          (i32.const 3)
         )
         (local.get $fn)
        )
       )
      )
      (then
       (drop
        (call $~lib/array/Array<i32>#push
         (call $~lib/rt/__tmptostack
          (local.get $result)
         )
         (local.get $value)
        )
       )
      )
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (return
   (local.get $result)
  )
 )
 (func $start:std/staticarray~anonymous|3 (param $x i32) (param $y i32) (param $$2 i32) (param $$3 i32) (result i32)
  (i32.add
   (local.get $x)
   (local.get $y)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#reduce<i32> (param $this i32) (param $fn i32) (param $initialValue i32) (result i32)
  (local $acc i32)
  (local $i i32)
  (local $len i32)
  (local.set $acc
   (local.get $initialValue)
  )
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $len)
    )
    (then
     (local.set $acc
      (call_indirect (type $4)
       (local.get $acc)
       (i32.load
        (i32.add
         (local.get $this)
         (i32.shl
          (local.get $i)
          (i32.const 2)
         )
        )
       )
       (local.get $i)
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (i32.load
        (block (result i32)
         (global.set $~argumentsLength
          (i32.const 4)
         )
         (local.get $fn)
        )
       )
      )
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (return
   (local.get $acc)
  )
 )
 (func $start:std/staticarray~anonymous|4 (param $x i32) (param $y i32) (param $$2 i32) (param $$3 i32) (result i32)
  (i32.add
   (local.get $x)
   (local.get $y)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#reduceRight<i32> (param $this i32) (param $fn i32) (param $initialValue i32) (result i32)
  (local $acc i32)
  (local $i i32)
  (local.set $acc
   (local.get $initialValue)
  )
  (local.set $i
   (i32.sub
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (loop $for-loop|0
   (if
    (i32.ge_s
     (local.get $i)
     (i32.const 0)
    )
    (then
     (local.set $acc
      (call_indirect (type $4)
       (local.get $acc)
       (i32.load
        (i32.add
         (local.get $this)
         (i32.shl
          (local.get $i)
          (i32.const 2)
         )
        )
       )
       (local.get $i)
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (i32.load
        (block (result i32)
         (global.set $~argumentsLength
          (i32.const 4)
         )
         (local.get $fn)
        )
       )
      )
     )
     (local.set $i
      (i32.sub
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (return
   (local.get $acc)
  )
 )
 (func $start:std/staticarray~anonymous|5 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.eq
   (local.get $x)
   (i32.const 2)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#some (param $this i32) (param $fn i32) (result i32)
  (local $i i32)
  (local $len i32)
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $len)
    )
    (then
     (if
      (call_indirect (type $3)
       (i32.load
        (i32.add
         (local.get $this)
         (i32.shl
          (local.get $i)
          (i32.const 2)
         )
        )
       )
       (local.get $i)
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (i32.load
        (block (result i32)
         (global.set $~argumentsLength
          (i32.const 3)
         )
         (local.get $fn)
        )
       )
      )
      (then
       (return
        (i32.const 1)
       )
      )
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (return
   (i32.const 0)
  )
 )
 (func $start:std/staticarray~anonymous|6 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.eq
   (local.get $x)
   (i32.const 4)
  )
 )
 (func $start:std/staticarray~anonymous|7 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.le_s
   (local.get $x)
   (i32.const 3)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#every (param $this i32) (param $fn i32) (result i32)
  (local $i i32)
  (local $len i32)
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $len)
    )
    (then
     (if
      (i32.eqz
       (call_indirect (type $3)
        (i32.load
         (i32.add
          (local.get $this)
          (i32.shl
           (local.get $i)
           (i32.const 2)
          )
         )
        )
        (local.get $i)
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
        (i32.load
         (block (result i32)
          (global.set $~argumentsLength
           (i32.const 3)
          )
          (local.get $fn)
         )
        )
       )
      )
      (then
       (return
        (i32.const 0)
       )
      )
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (return
   (i32.const 1)
  )
 )
 (func $start:std/staticarray~anonymous|8 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.gt_s
   (local.get $x)
   (i32.const 3)
  )
 )
 (func $start:std/staticarray~anonymous|9 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.eq
   (local.get $x)
   (i32.const 2)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#findIndex (param $this i32) (param $fn i32) (result i32)
  (local $i i32)
  (local $len i32)
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $len)
    )
    (then
     (if
      (call_indirect (type $3)
       (i32.load
        (i32.add
         (local.get $this)
         (i32.shl
          (local.get $i)
          (i32.const 2)
         )
        )
       )
       (local.get $i)
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (i32.load
        (block (result i32)
         (global.set $~argumentsLength
          (i32.const 3)
         )
         (local.get $fn)
        )
       )
      )
      (then
       (return
        (local.get $i)
       )
      )
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (return
   (i32.const -1)
  )
 )
 (func $start:std/staticarray~anonymous|10 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.eq
   (local.get $x)
   (i32.const 4)
  )
 )
 (func $start:std/staticarray~anonymous|11 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.eq
   (local.get $x)
   (i32.const 2)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#findLastIndex (param $this i32) (param $fn i32) (result i32)
  (local $i i32)
  (local.set $i
   (i32.sub
    (call $~lib/staticarray/StaticArray<i32>#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (loop $for-loop|0
   (if
    (i32.ge_s
     (local.get $i)
     (i32.const 0)
    )
    (then
     (if
      (call_indirect (type $3)
       (i32.load
        (i32.add
         (local.get $this)
         (i32.shl
          (local.get $i)
          (i32.const 2)
         )
        )
       )
       (local.get $i)
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (i32.load
        (block (result i32)
         (global.set $~argumentsLength
          (i32.const 3)
         )
         (local.get $fn)
        )
       )
      )
      (then
       (return
        (local.get $i)
       )
      )
     )
     (local.set $i
      (i32.sub
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (return
   (i32.const -1)
  )
 )
 (func $start:std/staticarray~anonymous|12 (param $x i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.eq
   (local.get $x)
   (i32.const 4)
  )
 )
 (func $~lib/util/sort/insertionSort<i32> (param $ptr i32) (param $left i32) (param $right i32) (param $presorted i32) (param $comparator i32)
  (local $range i32)
  (local $i i32)
  (local $a i32)
  (local $b i32)
  (local $min i32)
  (local $max i32)
  (local $j i32)
  (drop
   (i32.ge_s
    (i32.const 0)
    (i32.const 1)
   )
  )
  (block
   (local.set $range
    (i32.add
     (i32.sub
      (local.get $right)
      (local.get $left)
     )
     (i32.const 1)
    )
   )
   (local.set $i
    (i32.add
     (local.get $left)
     (select
      (i32.and
       (local.get $range)
       (i32.const 1)
      )
      (i32.sub
       (local.get $presorted)
       (i32.and
        (i32.sub
         (local.get $range)
         (local.get $presorted)
        )
        (i32.const 1)
       )
      )
      (i32.eq
       (local.get $presorted)
       (i32.const 0)
      )
     )
    )
   )
   (block $for-break0
    (loop $for-loop|0
     (if
      (i32.le_s
       (local.get $i)
       (local.get $right)
      )
      (then
       (local.set $a
        (i32.load
         (i32.add
          (local.get $ptr)
          (i32.shl
           (local.get $i)
           (i32.const 2)
          )
         )
        )
       )
       (local.set $b
        (i32.load offset=4
         (i32.add
          (local.get $ptr)
          (i32.shl
           (local.get $i)
           (i32.const 2)
          )
         )
        )
       )
       (local.set $min
        (local.get $b)
       )
       (local.set $max
        (local.get $a)
       )
       (if
        (i32.le_s
         (call_indirect (type $2)
          (local.get $a)
          (local.get $b)
          (i32.load
           (block (result i32)
            (global.set $~argumentsLength
             (i32.const 2)
            )
            (local.get $comparator)
           )
          )
         )
         (i32.const 0)
        )
        (then
         (local.set $min
          (local.get $a)
         )
         (local.set $max
          (local.get $b)
         )
        )
       )
       (local.set $j
        (i32.sub
         (local.get $i)
         (i32.const 1)
        )
       )
       (block $while-break|1
        (loop $while-continue|1
         (if
          (i32.ge_s
           (local.get $j)
           (local.get $left)
          )
          (then
           (local.set $a
            (i32.load
             (i32.add
              (local.get $ptr)
              (i32.shl
               (local.get $j)
               (i32.const 2)
              )
             )
            )
           )
           (if
            (i32.gt_s
             (call_indirect (type $2)
              (local.get $a)
              (local.get $max)
              (i32.load
               (block (result i32)
                (global.set $~argumentsLength
                 (i32.const 2)
                )
                (local.get $comparator)
               )
              )
             )
             (i32.const 0)
            )
            (then
             (i32.store offset=8
              (i32.add
               (local.get $ptr)
               (i32.shl
                (local.get $j)
                (i32.const 2)
               )
              )
              (local.get $a)
             )
             (local.set $j
              (i32.sub
               (local.get $j)
               (i32.const 1)
              )
             )
            )
            (else
             (br $while-break|1)
            )
           )
           (br $while-continue|1)
          )
         )
        )
       )
       (i32.store offset=8
        (i32.add
         (local.get $ptr)
         (i32.shl
          (local.get $j)
          (i32.const 2)
         )
        )
        (local.get $max)
       )
       (block $while-break|2
        (loop $while-continue|2
         (if
          (i32.ge_s
           (local.get $j)
           (local.get $left)
          )
          (then
           (local.set $a
            (i32.load
             (i32.add
              (local.get $ptr)
              (i32.shl
               (local.get $j)
               (i32.const 2)
              )
             )
            )
           )
           (if
            (i32.gt_s
             (call_indirect (type $2)
              (local.get $a)
              (local.get $min)
              (i32.load
               (block (result i32)
                (global.set $~argumentsLength
                 (i32.const 2)
                )
                (local.get $comparator)
               )
              )
             )
             (i32.const 0)
            )
            (then
             (i32.store offset=4
              (i32.add
               (local.get $ptr)
               (i32.shl
                (local.get $j)
                (i32.const 2)
               )
              )
              (local.get $a)
             )
             (local.set $j
              (i32.sub
               (local.get $j)
               (i32.const 1)
              )
             )
            )
            (else
             (br $while-break|2)
            )
           )
           (br $while-continue|2)
          )
         )
        )
       )
       (i32.store offset=4
        (i32.add
         (local.get $ptr)
         (i32.shl
          (local.get $j)
          (i32.const 2)
         )
        )
        (local.get $min)
       )
       (local.set $i
        (i32.add
         (local.get $i)
         (i32.const 2)
        )
       )
       (br $for-loop|0)
      )
     )
    )
   )
  )
 )
 (func $~lib/util/sort/extendRunRight<i32> (param $ptr i32) (param $i i32) (param $right i32) (param $comparator i32) (result i32)
  (local $j i32)
  (local $k i32)
  (local $tmp i32)
  (if
   (i32.eq
    (local.get $i)
    (local.get $right)
   )
   (then
    (return
     (local.get $i)
    )
   )
  )
  (local.set $j
   (local.get $i)
  )
  (if
   (i32.gt_s
    (call_indirect (type $2)
     (i32.load
      (i32.add
       (local.get $ptr)
       (i32.shl
        (local.get $j)
        (i32.const 2)
       )
      )
     )
     (i32.load
      (i32.add
       (local.get $ptr)
       (i32.shl
        (local.tee $j
         (i32.add
          (local.get $j)
          (i32.const 1)
         )
        )
        (i32.const 2)
       )
      )
     )
     (i32.load
      (block (result i32)
       (global.set $~argumentsLength
        (i32.const 2)
       )
       (local.get $comparator)
      )
     )
    )
    (i32.const 0)
   )
   (then
    (block $while-break|0
     (loop $while-continue|0
      (if
       (if (result i32)
        (i32.lt_s
         (local.get $j)
         (local.get $right)
        )
        (then
         (i32.shr_u
          (call_indirect (type $2)
           (i32.load offset=4
            (i32.add
             (local.get $ptr)
             (i32.shl
              (local.get $j)
              (i32.const 2)
             )
            )
           )
           (i32.load
            (i32.add
             (local.get $ptr)
             (i32.shl
              (local.get $j)
              (i32.const 2)
             )
            )
           )
           (i32.load
            (block (result i32)
             (global.set $~argumentsLength
              (i32.const 2)
             )
             (local.get $comparator)
            )
           )
          )
          (i32.const 31)
         )
        )
        (else
         (i32.const 0)
        )
       )
       (then
        (local.set $j
         (i32.add
          (local.get $j)
          (i32.const 1)
         )
        )
        (br $while-continue|0)
       )
      )
     )
    )
    (local.set $k
     (local.get $j)
    )
    (block $while-break|1
     (loop $while-continue|1
      (if
       (i32.lt_s
        (local.get $i)
        (local.get $k)
       )
       (then
        (local.set $tmp
         (i32.load
          (i32.add
           (local.get $ptr)
           (i32.shl
            (local.get $i)
            (i32.const 2)
           )
          )
         )
        )
        (i32.store
         (i32.add
          (local.get $ptr)
          (i32.shl
           (local.get $i)
           (i32.const 2)
          )
         )
         (i32.load
          (i32.add
           (local.get $ptr)
           (i32.shl
            (local.get $k)
            (i32.const 2)
           )
          )
         )
        )
        (local.set $i
         (i32.add
          (local.get $i)
          (i32.const 1)
         )
        )
        (i32.store
         (i32.add
          (local.get $ptr)
          (i32.shl
           (local.get $k)
           (i32.const 2)
          )
         )
         (local.get $tmp)
        )
        (local.set $k
         (i32.sub
          (local.get $k)
          (i32.const 1)
         )
        )
        (br $while-continue|1)
       )
      )
     )
    )
   )
   (else
    (block $while-break|2
     (loop $while-continue|2
      (if
       (if (result i32)
        (i32.lt_s
         (local.get $j)
         (local.get $right)
        )
        (then
         (i32.ge_s
          (call_indirect (type $2)
           (i32.load offset=4
            (i32.add
             (local.get $ptr)
             (i32.shl
              (local.get $j)
              (i32.const 2)
             )
            )
           )
           (i32.load
            (i32.add
             (local.get $ptr)
             (i32.shl
              (local.get $j)
              (i32.const 2)
             )
            )
           )
           (i32.load
            (block (result i32)
             (global.set $~argumentsLength
              (i32.const 2)
             )
             (local.get $comparator)
            )
           )
          )
          (i32.const 0)
         )
        )
        (else
         (i32.const 0)
        )
       )
       (then
        (local.set $j
         (i32.add
          (local.get $j)
          (i32.const 1)
         )
        )
        (br $while-continue|2)
       )
      )
     )
    )
   )
  )
  (return
   (local.get $j)
  )
 )
 (func $~lib/util/sort/nodePower (param $left i32) (param $right i32) (param $startA i32) (param $startB i32) (param $endB i32) (result i32)
  (local $n i64)
  (local $s i32)
  (local $l i32)
  (local $r i32)
  (local $a i64)
  (local $b i64)
  (local.set $n
   (i64.extend_i32_u
    (i32.add
     (i32.sub
      (local.get $right)
      (local.get $left)
     )
     (i32.const 1)
    )
   )
  )
  (local.set $s
   (i32.sub
    (local.get $startB)
    (i32.shl
     (local.get $left)
     (i32.const 1)
    )
   )
  )
  (local.set $l
   (i32.add
    (local.get $startA)
    (local.get $s)
   )
  )
  (local.set $r
   (i32.add
    (i32.add
     (local.get $endB)
     (local.get $s)
    )
    (i32.const 1)
   )
  )
  (local.set $a
   (i64.div_u
    (i64.shl
     (i64.extend_i32_u
      (local.get $l)
     )
     (i64.const 30)
    )
    (local.get $n)
   )
  )
  (local.set $b
   (i64.div_u
    (i64.shl
     (i64.extend_i32_u
      (local.get $r)
     )
     (i64.const 30)
    )
    (local.get $n)
   )
  )
  (return
   (i32.clz
    (i32.wrap_i64
     (i64.xor
      (local.get $a)
      (local.get $b)
     )
    )
   )
  )
 )
 (func $~lib/util/sort/mergeRuns<i32> (param $ptr i32) (param $l i32) (param $m i32) (param $r i32) (param $buffer i32) (param $comparator i32)
  (local $i i32)
  (local $j i32)
  (local $t i32)
  (local $k i32)
  (local $a i32)
  (local $b i32)
  (local.set $m
   (i32.sub
    (local.get $m)
    (i32.const 1)
   )
  )
  (local.set $t
   (i32.add
    (local.get $r)
    (local.get $m)
   )
  )
  (local.set $i
   (i32.add
    (local.get $m)
    (i32.const 1)
   )
  )
  (loop $for-loop|0
   (if
    (i32.gt_s
     (local.get $i)
     (local.get $l)
    )
    (then
     (i32.store
      (i32.add
       (local.get $buffer)
       (i32.shl
        (i32.sub
         (local.get $i)
         (i32.const 1)
        )
        (i32.const 2)
       )
      )
      (i32.load
       (i32.add
        (local.get $ptr)
        (i32.shl
         (i32.sub
          (local.get $i)
          (i32.const 1)
         )
         (i32.const 2)
        )
       )
      )
     )
     (local.set $i
      (i32.sub
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|0)
    )
   )
  )
  (local.set $j
   (local.get $m)
  )
  (loop $for-loop|1
   (if
    (i32.lt_s
     (local.get $j)
     (local.get $r)
    )
    (then
     (i32.store
      (i32.add
       (local.get $buffer)
       (i32.shl
        (i32.sub
         (local.get $t)
         (local.get $j)
        )
        (i32.const 2)
       )
      )
      (i32.load offset=4
       (i32.add
        (local.get $ptr)
        (i32.shl
         (local.get $j)
         (i32.const 2)
        )
       )
      )
     )
     (local.set $j
      (i32.add
       (local.get $j)
       (i32.const 1)
      )
     )
     (br $for-loop|1)
    )
   )
  )
  (local.set $k
   (local.get $l)
  )
  (loop $for-loop|2
   (if
    (i32.le_s
     (local.get $k)
     (local.get $r)
    )
    (then
     (local.set $a
      (i32.load
       (i32.add
        (local.get $buffer)
        (i32.shl
         (local.get $j)
         (i32.const 2)
        )
       )
      )
     )
     (local.set $b
      (i32.load
       (i32.add
        (local.get $buffer)
        (i32.shl
         (local.get $i)
         (i32.const 2)
        )
       )
      )
     )
     (if
      (i32.lt_s
       (call_indirect (type $2)
        (local.get $a)
        (local.get $b)
        (i32.load
         (block (result i32)
          (global.set $~argumentsLength
           (i32.const 2)
          )
          (local.get $comparator)
         )
        )
       )
       (i32.const 0)
      )
      (then
       (i32.store
        (i32.add
         (local.get $ptr)
         (i32.shl
          (local.get $k)
          (i32.const 2)
         )
        )
        (local.get $a)
       )
       (local.set $j
        (i32.sub
         (local.get $j)
         (i32.const 1)
        )
       )
      )
      (else
       (i32.store
        (i32.add
         (local.get $ptr)
         (i32.shl
          (local.get $k)
          (i32.const 2)
         )
        )
        (local.get $b)
       )
       (local.set $i
        (i32.add
         (local.get $i)
         (i32.const 1)
        )
       )
      )
     )
     (local.set $k
      (i32.add
       (local.get $k)
       (i32.const 1)
      )
     )
     (br $for-loop|2)
    )
   )
  )
 )
 (func $~lib/util/sort/SORT<i32> (param $ptr i32) (param $len i32) (param $comparator i32)
  (local $3 i32)
  (local $a i32)
  (local $b i32)
  (local $c i32)
  (local $a|7 i32)
  (local $b|8 i32)
  (local $c|9 i32)
  (local $n i32)
  (local $lgPlus2 i32)
  (local $lgPlus2Size i32)
  (local $leftRunStartBuf i32)
  (local $leftRunEndBuf i32)
  (local $i i32)
  (local $buffer i32)
  (local $hi i32)
  (local $endA i32)
  (local $lenA i32)
  (local $20 i32)
  (local $21 i32)
  (local $top i32)
  (local $startA i32)
  (local $startB i32)
  (local $endB i32)
  (local $lenB i32)
  (local $27 i32)
  (local $28 i32)
  (local $k i32)
  (local $i|30 i32)
  (local $start i32)
  (local $i|32 i32)
  (local $start|33 i32)
  (if
   (i32.le_s
    (local.get $len)
    (i32.const 48)
   )
   (then
    (if
     (i32.le_s
      (local.get $len)
      (i32.const 1)
     )
     (then
      (return)
     )
    )
    (drop
     (i32.lt_s
      (i32.const 0)
      (i32.const 1)
     )
    )
    (block $break|0
     (block $case1|0
      (block $case0|0
       (local.set $3
        (local.get $len)
       )
       (br_if $case0|0
        (i32.eq
         (local.get $3)
         (i32.const 3)
        )
       )
       (br_if $case1|0
        (i32.eq
         (local.get $3)
         (i32.const 2)
        )
       )
       (br $break|0)
      )
      (block
       (local.set $a
        (i32.load
         (local.get $ptr)
        )
       )
       (local.set $b
        (i32.load offset=4
         (local.get $ptr)
        )
       )
       (local.set $c
        (i32.gt_s
         (call_indirect (type $2)
          (local.get $a)
          (local.get $b)
          (i32.load
           (block (result i32)
            (global.set $~argumentsLength
             (i32.const 2)
            )
            (local.get $comparator)
           )
          )
         )
         (i32.const 0)
        )
       )
       (i32.store
        (local.get $ptr)
        (select
         (local.get $b)
         (local.get $a)
         (local.get $c)
        )
       )
       (local.set $a
        (select
         (local.get $a)
         (local.get $b)
         (local.get $c)
        )
       )
       (local.set $b
        (i32.load offset=8
         (local.get $ptr)
        )
       )
       (local.set $c
        (i32.gt_s
         (call_indirect (type $2)
          (local.get $a)
          (local.get $b)
          (i32.load
           (block (result i32)
            (global.set $~argumentsLength
             (i32.const 2)
            )
            (local.get $comparator)
           )
          )
         )
         (i32.const 0)
        )
       )
       (i32.store offset=4
        (local.get $ptr)
        (select
         (local.get $b)
         (local.get $a)
         (local.get $c)
        )
       )
       (i32.store offset=8
        (local.get $ptr)
        (select
         (local.get $a)
         (local.get $b)
         (local.get $c)
        )
       )
      )
     )
     (block
      (local.set $a|7
       (i32.load
        (local.get $ptr)
       )
      )
      (local.set $b|8
       (i32.load offset=4
        (local.get $ptr)
       )
      )
      (local.set $c|9
       (i32.gt_s
        (call_indirect (type $2)
         (local.get $a|7)
         (local.get $b|8)
         (i32.load
          (block (result i32)
           (global.set $~argumentsLength
            (i32.const 2)
           )
           (local.get $comparator)
          )
         )
        )
        (i32.const 0)
       )
      )
      (i32.store
       (local.get $ptr)
       (select
        (local.get $b|8)
        (local.get $a|7)
        (local.get $c|9)
       )
      )
      (i32.store offset=4
       (local.get $ptr)
       (select
        (local.get $a|7)
        (local.get $b|8)
        (local.get $c|9)
       )
      )
      (return)
     )
    )
    (call $~lib/util/sort/insertionSort<i32>
     (local.get $ptr)
     (i32.const 0)
     (i32.sub
      (local.get $len)
      (i32.const 1)
     )
     (i32.const 0)
     (call $~lib/rt/__tmptostack
      (local.get $comparator)
     )
    )
    (return)
   )
  )
  (local.set $lgPlus2
   (i32.add
    (block $~lib/util/sort/log2u|inlined.0 (result i32)
     (local.set $n
      (local.get $len)
     )
     (br $~lib/util/sort/log2u|inlined.0
      (i32.sub
       (i32.const 31)
       (i32.clz
        (local.get $n)
       )
      )
     )
    )
    (i32.const 2)
   )
  )
  (local.set $lgPlus2Size
   (i32.shl
    (local.get $lgPlus2)
    (i32.const 2)
   )
  )
  (local.set $leftRunStartBuf
   (call $~lib/rt/tlsf/__alloc
    (i32.shl
     (local.get $lgPlus2Size)
     (i32.const 1)
    )
   )
  )
  (local.set $leftRunEndBuf
   (i32.add
    (local.get $leftRunStartBuf)
    (local.get $lgPlus2Size)
   )
  )
  (local.set $i
   (i32.const 0)
  )
  (loop $for-loop|1
   (if
    (i32.lt_u
     (local.get $i)
     (local.get $lgPlus2)
    )
    (then
     (i32.store
      (i32.add
       (local.get $leftRunStartBuf)
       (i32.shl
        (local.get $i)
        (i32.const 2)
       )
      )
      (i32.const -1)
     )
     (local.set $i
      (i32.add
       (local.get $i)
       (i32.const 1)
      )
     )
     (br $for-loop|1)
    )
   )
  )
  (local.set $buffer
   (call $~lib/rt/tlsf/__alloc
    (i32.shl
     (local.get $len)
     (i32.const 2)
    )
   )
  )
  (local.set $hi
   (i32.sub
    (local.get $len)
    (i32.const 1)
   )
  )
  (local.set $endA
   (call $~lib/util/sort/extendRunRight<i32>
    (local.get $ptr)
    (i32.const 0)
    (local.get $hi)
    (call $~lib/rt/__tmptostack
     (local.get $comparator)
    )
   )
  )
  (local.set $lenA
   (i32.add
    (local.get $endA)
    (i32.const 1)
   )
  )
  (if
   (i32.lt_s
    (local.get $lenA)
    (i32.const 32)
   )
   (then
    (local.set $endA
     (select
      (local.tee $20
       (local.get $hi)
      )
      (local.tee $21
       (i32.sub
        (i32.const 32)
        (i32.const 1)
       )
      )
      (i32.lt_s
       (local.get $20)
       (local.get $21)
      )
     )
    )
    (call $~lib/util/sort/insertionSort<i32>
     (local.get $ptr)
     (i32.const 0)
     (local.get $endA)
     (local.get $lenA)
     (call $~lib/rt/__tmptostack
      (local.get $comparator)
     )
    )
   )
  )
  (local.set $top
   (i32.const 0)
  )
  (local.set $startA
   (i32.const 0)
  )
  (block $while-break|2
   (loop $while-continue|2
    (if
     (i32.lt_s
      (local.get $endA)
      (local.get $hi)
     )
     (then
      (local.set $startB
       (i32.add
        (local.get $endA)
        (i32.const 1)
       )
      )
      (local.set $endB
       (call $~lib/util/sort/extendRunRight<i32>
        (local.get $ptr)
        (local.get $startB)
        (local.get $hi)
        (call $~lib/rt/__tmptostack
         (local.get $comparator)
        )
       )
      )
      (local.set $lenB
       (i32.add
        (i32.sub
         (local.get $endB)
         (local.get $startB)
        )
        (i32.const 1)
       )
      )
      (if
       (i32.lt_s
        (local.get $lenB)
        (i32.const 32)
       )
       (then
        (local.set $endB
         (select
          (local.tee $27
           (local.get $hi)
          )
          (local.tee $28
           (i32.sub
            (i32.add
             (local.get $startB)
             (i32.const 32)
            )
            (i32.const 1)
           )
          )
          (i32.lt_s
           (local.get $27)
           (local.get $28)
          )
         )
        )
        (call $~lib/util/sort/insertionSort<i32>
         (local.get $ptr)
         (local.get $startB)
         (local.get $endB)
         (local.get $lenB)
         (call $~lib/rt/__tmptostack
          (local.get $comparator)
         )
        )
       )
      )
      (local.set $k
       (call $~lib/util/sort/nodePower
        (i32.const 0)
        (local.get $hi)
        (local.get $startA)
        (local.get $startB)
        (local.get $endB)
       )
      )
      (local.set $i|30
       (local.get $top)
      )
      (loop $for-loop|3
       (if
        (i32.gt_u
         (local.get $i|30)
         (local.get $k)
        )
        (then
         (local.set $start
          (i32.load
           (i32.add
            (local.get $leftRunStartBuf)
            (i32.shl
             (local.get $i|30)
             (i32.const 2)
            )
           )
          )
         )
         (if
          (i32.ne
           (local.get $start)
           (i32.const -1)
          )
          (then
           (call $~lib/util/sort/mergeRuns<i32>
            (local.get $ptr)
            (local.get $start)
            (i32.add
             (i32.load
              (i32.add
               (local.get $leftRunEndBuf)
               (i32.shl
                (local.get $i|30)
                (i32.const 2)
               )
              )
             )
             (i32.const 1)
            )
            (local.get $endA)
            (local.get $buffer)
            (call $~lib/rt/__tmptostack
             (local.get $comparator)
            )
           )
           (local.set $startA
            (local.get $start)
           )
           (i32.store
            (i32.add
             (local.get $leftRunStartBuf)
             (i32.shl
              (local.get $i|30)
              (i32.const 2)
             )
            )
            (i32.const -1)
           )
          )
         )
         (local.set $i|30
          (i32.sub
           (local.get $i|30)
           (i32.const 1)
          )
         )
         (br $for-loop|3)
        )
       )
      )
      (i32.store
       (i32.add
        (local.get $leftRunStartBuf)
        (i32.shl
         (local.get $k)
         (i32.const 2)
        )
       )
       (local.get $startA)
      )
      (i32.store
       (i32.add
        (local.get $leftRunEndBuf)
        (i32.shl
         (local.get $k)
         (i32.const 2)
        )
       )
       (local.get $endA)
      )
      (local.set $startA
       (local.get $startB)
      )
      (local.set $endA
       (local.get $endB)
      )
      (local.set $top
       (local.get $k)
      )
      (br $while-continue|2)
     )
    )
   )
  )
  (local.set $i|32
   (local.get $top)
  )
  (loop $for-loop|4
   (if
    (i32.ne
     (local.get $i|32)
     (i32.const 0)
    )
    (then
     (local.set $start|33
      (i32.load
       (i32.add
        (local.get $leftRunStartBuf)
        (i32.shl
         (local.get $i|32)
         (i32.const 2)
        )
       )
      )
     )
     (if
      (i32.ne
       (local.get $start|33)
       (i32.const -1)
      )
      (then
       (call $~lib/util/sort/mergeRuns<i32>
        (local.get $ptr)
        (local.get $start|33)
        (i32.add
         (i32.load
          (i32.add
           (local.get $leftRunEndBuf)
           (i32.shl
            (local.get $i|32)
            (i32.const 2)
           )
          )
         )
         (i32.const 1)
        )
        (local.get $hi)
        (local.get $buffer)
        (call $~lib/rt/__tmptostack
         (local.get $comparator)
        )
       )
      )
     )
     (local.set $i|32
      (i32.sub
       (local.get $i|32)
       (i32.const 1)
      )
     )
     (br $for-loop|4)
    )
   )
  )
  (call $~lib/rt/tlsf/__free
   (local.get $buffer)
  )
  (call $~lib/rt/tlsf/__free
   (local.get $leftRunStartBuf)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#sort (param $this i32) (param $comparator i32) (result i32)
  (call $~lib/util/sort/SORT<i32>
   (local.get $this)
   (call $~lib/staticarray/StaticArray<i32>#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (call $~lib/rt/__tmptostack
    (local.get $comparator)
   )
  )
  (return
   (local.get $this)
  )
 )
 (func $~lib/util/sort/COMPARATOR<i32>~anonymous|0 (param $a i32) (param $b i32) (result i32)
  (i32.sub
   (local.get $a)
   (local.get $b)
  )
 )
 (func $~lib/staticarray/StaticArray<i32>#sort@varargs (param $this i32) (param $comparator i32) (result i32)
  (block $1of1
   (block $0of1
    (block $outOfRange
     (br_table $0of1 $1of1 $outOfRange
      (global.get $~argumentsLength)
     )
    )
    (unreachable)
   )
   (local.set $comparator
    (call $~lib/rt/__localtostack
     (block $~lib/util/sort/COMPARATOR<i32>|inlined.0 (result i32)
      (drop
       (i32.const 1)
      )
      (block
       (drop
        (i32.le_u
         (i32.const 4)
         (i32.const 4)
        )
       )
       (br $~lib/util/sort/COMPARATOR<i32>|inlined.0
        (i32.const 2848)
       )
      )
     )
    )
   )
  )
  (call $~lib/staticarray/StaticArray<i32>#sort
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $comparator)
   )
  )
 )
 (func $~lib/rt/itcms/__collect
  (drop
   (i32.const 0)
  )
  (if
   (i32.gt_s
    (global.get $~lib/rt/itcms/state)
    (i32.const 0)
   )
   (then
    (block $while-break|0
     (loop $while-continue|0
      (if
       (i32.ne
        (global.get $~lib/rt/itcms/state)
        (i32.const 0)
       )
       (then
        (drop
         (call $~lib/rt/itcms/step)
        )
        (br $while-continue|0)
       )
      )
     )
    )
   )
  )
  (drop
   (call $~lib/rt/itcms/step)
  )
  (block $while-break|1
   (loop $while-continue|1
    (if
     (i32.ne
      (global.get $~lib/rt/itcms/state)
      (i32.const 0)
     )
     (then
      (drop
       (call $~lib/rt/itcms/step)
      )
      (br $while-continue|1)
     )
    )
   )
  )
  (global.set $~lib/rt/itcms/threshold
   (i32.add
    (i32.wrap_i64
     (i64.div_u
      (i64.mul
       (i64.extend_i32_u
        (global.get $~lib/rt/itcms/total)
       )
       (i64.extend_i32_u
        (i32.const 200)
       )
      )
      (i64.const 100)
     )
    )
    (i32.const 1024)
   )
  )
  (drop
   (i32.const 0)
  )
  (drop
   (i32.const 0)
  )
 )
 (func $start:std/staticarray
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $source i32)
  (local $i i32)
  (local $5 i32)
  (local $source|6 i32)
  (local $subject i32)
  (local $i|8 i32)
  (local $9 i32)
  (local $10 i32)
  (local $source|11 i32)
  (local $12 i32)
  (local $result i32)
  (local $14 i32)
  (local $15 i32)
  (local $source|16 i32)
  (local $17 i32)
  (local $result|18 i32)
  (local $19 i32)
  (local $source|20 i32)
  (local $result|21 i32)
  (local $i|22 i32)
  (local $23 i32)
  (local $source|24 i32)
  (local $25 i32)
  (local $result|26 i32)
  (local $27 i32)
  (local $28 i32)
  (local $source|29 i32)
  (local $30 i32)
  (local $31 i32)
  (local $32 i32)
  (local $array i32)
  (local $34 i32)
  (local $numbers i32)
  (local $36 i32)
  (local $elements i32)
  (local $38 i32)
  (local $numbers|39 i32)
  (local $40 i32)
  (local $numbers|41 i32)
  (local $42 i32)
  (local $numbers|43 i32)
  (local $44 i32)
  (local $numbers|45 i32)
  (local $incNums i32)
  (local $filtered i32)
  (local $sum1 i32)
  (local $sum2 i32)
  (local $50 i32)
  (local $array|51 i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr1)
      )
      (i32.const 1)
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 5)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr1)
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 6)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (call $~lib/staticarray/StaticArray<i32>#__set
   (call $~lib/rt/__tmptostack
    (global.get $std/staticarray/arr1)
   )
   (i32.const 1)
   (i32.const 4)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr1)
      )
      (i32.const 1)
     )
     (i32.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 8)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/rt/common/OBJECT#get:rtId
      (i32.sub
       (global.get $std/staticarray/arr1)
       (i32.const 20)
      )
     )
     (i32.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 9)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr2)
      )
      (i32.const 1)
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 13)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr2)
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 14)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (call $~lib/staticarray/StaticArray<i32>#__set
   (call $~lib/rt/__tmptostack
    (global.get $std/staticarray/arr2)
   )
   (i32.const 1)
   (i32.const 4)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr2)
      )
      (i32.const 1)
     )
     (i32.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 16)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $~lib/rt/itcms/threshold
   (i32.shr_u
    (i32.sub
     (i32.shl
      (memory.size)
      (i32.const 16)
     )
     (global.get $~lib/memory/__heap_base)
    )
    (i32.const 1)
   )
  )
  (global.set $~lib/rt/itcms/pinSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 432)
   )
  )
  (global.set $~lib/rt/itcms/toSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 464)
   )
  )
  (global.set $~lib/rt/itcms/fromSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 544)
   )
  )
  (global.set $std/staticarray/arr3
   (call $std/staticarray/test)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr3)
      )
      (i32.const 0)
     )
     (i32.const 5)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr3)
      )
      (i32.const 1)
     )
     (i32.const 6)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 24)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr3)
      )
      (i32.const 2)
     )
     (i32.const 7)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 25)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr3)
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 26)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (call $~lib/staticarray/StaticArray<i32>#__set
   (call $~lib/rt/__tmptostack
    (global.get $std/staticarray/arr3)
   )
   (i32.const 1)
   (i32.const 8)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr3)
      )
      (i32.const 1)
     )
     (i32.const 8)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 28)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/staticarray/arr3
   (call $std/staticarray/test)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/staticarray/StaticArray<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/staticarray/arr3)
      )
      (i32.const 1)
     )
     (i32.const 6)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 192)
     (i32.const 30)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/staticarray/arr4
   (block (result i32)
    (local.set $2
     (call $~lib/rt/__localtostack
      (call $~lib/rt/__newBuffer
       (i32.const 8)
       (i32.const 6)
       (i32.const 0)
      )
     )
    )
    (call $~lib/staticarray/StaticArray<std/staticarray/Ref>#__uset
     (local.get $2)
     (i32.const 0)
     (call $std/staticarray/Ref#constructor
      (i32.const 0)
     )
    )
    (call $~lib/staticarray/StaticArray<std/staticarray/Ref>#__uset
     (local.get $2)
     (i32.const 1)
     (call $std/staticarray/Ref#constructor
      (i32.const 0)
     )
    )
    (local.get $2)
   )
  )
  (global.set $std/staticarray/arr3
   (i32.const 0)
  )
  (global.set $std/staticarray/arr4
   (i32.const 0)
  )
  (block
   (local.set $source
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<i32>#constructor
      (i32.const 0)
      (i32.const 3)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $source)
       )
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 43)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $i
    (i32.const 0)
   )
   (loop $for-loop|0
    (if
     (i32.lt_s
      (local.get $i)
      (call $~lib/staticarray/StaticArray<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $source)
       )
      )
     )
     (then
      (if
       (i32.eqz
        (i32.eq
         (call $~lib/staticarray/StaticArray<i32>#__get
          (call $~lib/rt/__tmptostack
           (local.get $source)
          )
          (local.get $i)
         )
         (i32.const 0)
        )
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 0)
         (i32.const 192)
         (i32.const 45)
         (i32.const 5)
        )
        (unreachable)
       )
      )
      (local.set $i
       (i32.add
        (local.get $i)
        (i32.const 1)
       )
      )
      (br $for-loop|0)
     )
    )
   )
  )
  (block
   (local.set $source|6
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newArray
      (i32.const 6)
      (i32.const 2)
      (i32.const 7)
      (i32.const 704)
     )
    )
   )
   (local.set $subject
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray.fromArray<i32>
      (call $~lib/rt/__tmptostack
       (local.get $source|6)
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $subject)
       )
      )
      (call $~lib/array/Array<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $source|6)
       )
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 54)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $i|8
    (i32.const 0)
   )
   (loop $for-loop|1
    (if
     (i32.lt_s
      (local.get $i|8)
      (call $~lib/array/Array<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $source|6)
       )
      )
     )
     (then
      (if
       (i32.eqz
        (i32.eq
         (call $~lib/staticarray/StaticArray<i32>#__get
          (call $~lib/rt/__tmptostack
           (local.get $subject)
          )
          (local.get $i|8)
         )
         (call $~lib/array/Array<i32>#__get
          (call $~lib/rt/__tmptostack
           (local.get $source|6)
          )
          (local.get $i|8)
         )
        )
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 0)
         (i32.const 192)
         (i32.const 56)
         (i32.const 5)
        )
        (unreachable)
       )
      )
      (local.set $i|8
       (i32.add
        (local.get $i|8)
        (i32.const 1)
       )
      )
      (br $for-loop|1)
     )
    )
   )
   (local.set $subject
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray.fromArray<i32>
      (call $~lib/rt/__tmptostack
       (call $~lib/rt/__newArray
        (i32.const 0)
        (i32.const 2)
        (i32.const 7)
        (i32.const 800)
       )
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $subject)
       )
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 59)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $source|11
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 8)
      (i32.const 4)
      (i32.const 832)
     )
    )
   )
   (local.set $result
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<i32>#concat<~lib/staticarray/StaticArray<i32>>
      (call $~lib/rt/__tmptostack
       (local.get $source|11)
      )
      (call $~lib/rt/__tmptostack
       (call $~lib/rt/__newBuffer
        (i32.const 4)
        (i32.const 4)
        (i32.const 864)
       )
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result)
       )
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 67)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $result
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<i32>#concat<~lib/staticarray/StaticArray<i32>>
      (call $~lib/rt/__tmptostack
       (local.get $source|11)
      )
      (call $~lib/rt/__tmptostack
       (call $~lib/rt/__newBuffer
        (i32.const 0)
        (i32.const 4)
        (i32.const 896)
       )
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result)
       )
      )
      (call $~lib/staticarray/StaticArray<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $source|11)
       )
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 69)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $source|16
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 8)
      (i32.const 8)
      (i32.const 992)
     )
    )
   )
   (local.set $result|18
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#concat<~lib/staticarray/StaticArray<~lib/string/String>>
      (call $~lib/rt/__tmptostack
       (local.get $source|16)
      )
      (call $~lib/rt/__tmptostack
       (call $~lib/rt/__newBuffer
        (i32.const 4)
        (i32.const 8)
        (i32.const 1056)
       )
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|18)
       )
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 74)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $source|20
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 20)
      (i32.const 8)
      (i32.const 1264)
     )
    )
   )
   (local.set $result|21
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs
      (call $~lib/rt/__tmptostack
       (local.get $source|20)
      )
      (i32.const 0)
      (block (result i32)
       (global.set $~argumentsLength
        (i32.const 0)
       )
       (i32.const 0)
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|21)
       )
      )
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $source|20)
       )
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 81)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $i|22
    (i32.const 0)
   )
   (loop $for-loop|2
    (if
     (i32.lt_s
      (local.get $i|22)
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $source|20)
       )
      )
     )
     (then
      (if
       (i32.eqz
        (call $~lib/string/String.__eq
         (call $~lib/rt/__tmptostack
          (call $~lib/staticarray/StaticArray<~lib/string/String>#__get
           (call $~lib/rt/__tmptostack
            (local.get $source|20)
           )
           (local.get $i|22)
          )
         )
         (call $~lib/rt/__tmptostack
          (call $~lib/staticarray/StaticArray<~lib/string/String>#__get
           (call $~lib/rt/__tmptostack
            (local.get $result|21)
           )
           (local.get $i|22)
          )
         )
        )
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 0)
         (i32.const 192)
         (i32.const 84)
         (i32.const 5)
        )
        (unreachable)
       )
      )
      (local.set $i|22
       (i32.add
        (local.get $i|22)
        (i32.const 1)
       )
      )
      (br $for-loop|2)
     )
    )
   )
   (local.set $result|21
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
      (call $~lib/rt/__tmptostack
       (local.get $source|20)
      )
      (i32.const 1)
      (i32.const 3)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|21)
       )
      )
      (i32.const 2)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 88)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#__get
        (call $~lib/rt/__tmptostack
         (local.get $result|21)
        )
        (i32.const 0)
       )
      )
      (i32.const 1120)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 89)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#__get
        (call $~lib/rt/__tmptostack
         (local.get $result|21)
        )
        (i32.const 1)
       )
      )
      (i32.const 1152)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 90)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $result|21
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs
      (call $~lib/rt/__tmptostack
       (local.get $source|20)
      )
      (i32.const 1)
      (block (result i32)
       (global.set $~argumentsLength
        (i32.const 1)
       )
       (i32.const 0)
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|21)
       )
      )
      (i32.sub
       (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
        (call $~lib/rt/__tmptostack
         (local.get $source|20)
        )
       )
       (i32.const 1)
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 93)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $result|21
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
      (call $~lib/rt/__tmptostack
       (local.get $source|20)
      )
      (i32.const 0)
      (i32.const 50)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|21)
       )
      )
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $source|20)
       )
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 96)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $result|21
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs
      (call $~lib/rt/__tmptostack
       (local.get $source|20)
      )
      (i32.const 100)
      (block (result i32)
       (global.set $~argumentsLength
        (i32.const 1)
       )
       (i32.const 0)
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|21)
       )
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 99)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $result|21
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>@varargs
      (call $~lib/rt/__tmptostack
       (local.get $source|20)
      )
      (i32.const -1)
      (block (result i32)
       (global.set $~argumentsLength
        (i32.const 1)
       )
       (i32.const 0)
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|21)
       )
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 102)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#__get
        (call $~lib/rt/__tmptostack
         (local.get $result|21)
        )
        (i32.const 0)
       )
      )
      (i32.const 1216)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 103)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $result|21
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
      (call $~lib/rt/__tmptostack
       (local.get $source|20)
      )
      (i32.const -2)
      (i32.const -2)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|21)
       )
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 106)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $result|21
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#slice<~lib/staticarray/StaticArray<~lib/string/String>>
      (call $~lib/rt/__tmptostack
       (local.get $source|20)
      )
      (i32.const 2)
      (i32.const -2)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|21)
       )
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 109)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#__get
        (call $~lib/rt/__tmptostack
         (local.get $result|21)
        )
        (i32.const 0)
       )
      )
      (i32.const 1152)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 110)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $source|24
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 20)
      (i32.const 8)
      (i32.const 1440)
     )
    )
   )
   (local.set $result|26
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#concat<~lib/array/Array<~lib/string/String>>
      (call $~lib/rt/__tmptostack
       (local.get $source|24)
      )
      (call $~lib/rt/__tmptostack
       (call $~lib/rt/__newArray
        (i32.const 0)
        (i32.const 2)
        (i32.const 9)
        (i32.const 1488)
       )
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/array/Array<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|26)
       )
      )
      (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $source|24)
       )
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 120)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (drop
    (i32.const 1)
   )
   (local.set $result|26
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<~lib/string/String>#concat<~lib/array/Array<~lib/string/String>>
      (call $~lib/rt/__tmptostack
       (local.get $source|24)
      )
      (call $~lib/rt/__tmptostack
       (call $~lib/rt/__newArray
        (i32.const 1)
        (i32.const 2)
        (i32.const 9)
        (i32.const 1552)
       )
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/array/Array<~lib/string/String>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $result|26)
       )
      )
      (i32.add
       (call $~lib/staticarray/StaticArray<~lib/string/String>#get:length
        (call $~lib/rt/__tmptostack
         (local.get $source|24)
        )
       )
       (i32.const 1)
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 124)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (drop
    (i32.const 1)
   )
  )
  (block
   (local.set $source|29
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 20)
      (i32.const 8)
      (i32.const 1584)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#includes
       (call $~lib/rt/__tmptostack
        (local.get $source|29)
       )
       (i32.const 1120)
       (i32.const 0)
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 131)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#includes
       (call $~lib/rt/__tmptostack
        (local.get $source|29)
       )
       (i32.const 1520)
       (i32.const 0)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 132)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#includes
       (call $~lib/rt/__tmptostack
        (local.get $source|29)
       )
       (i32.const 1216)
       (i32.const 5)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 133)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<~lib/string/String>#includes
       (call $~lib/rt/__tmptostack
        (local.get $source|29)
       )
       (i32.const 1216)
       (i32.const -1)
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 134)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<f64>#includes
       (call $~lib/rt/__tmptostack
        (call $~lib/rt/__newBuffer
         (i32.const 8)
         (i32.const 10)
         (i32.const 1632)
        )
       )
       (f64.const nan:0x8000000000000)
       (i32.const 0)
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 136)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<f32>#includes
       (call $~lib/rt/__tmptostack
        (call $~lib/rt/__newBuffer
         (i32.const 4)
         (i32.const 11)
         (i32.const 1664)
        )
       )
       (f32.const nan:0x400000)
       (i32.const 0)
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 137)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $array
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 12)
      (i32.const 4)
      (i32.const 1696)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#indexOf
       (call $~lib/rt/__tmptostack
        (local.get $array)
       )
       (i32.const 2)
       (i32.const 0)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 143)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#indexOf
       (call $~lib/rt/__tmptostack
        (local.get $array)
       )
       (i32.const 7)
       (i32.const 0)
      )
      (i32.const -1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 144)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#indexOf
       (call $~lib/rt/__tmptostack
        (local.get $array)
       )
       (i32.const 9)
       (i32.const 2)
      )
      (i32.const 2)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 145)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#indexOf
       (call $~lib/rt/__tmptostack
        (local.get $array)
       )
       (i32.const 2)
       (i32.const -1)
      )
      (i32.const -1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 146)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#indexOf
       (call $~lib/rt/__tmptostack
        (local.get $array)
       )
       (i32.const 2)
       (i32.const -3)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 147)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $numbers
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 16)
      (i32.const 4)
      (i32.const 1728)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#lastIndexOf@varargs
       (call $~lib/rt/__tmptostack
        (local.get $numbers)
       )
       (i32.const 2)
       (block (result i32)
        (global.set $~argumentsLength
         (i32.const 1)
        )
        (i32.const 0)
       )
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 153)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#lastIndexOf@varargs
       (call $~lib/rt/__tmptostack
        (local.get $numbers)
       )
       (i32.const 7)
       (block (result i32)
        (global.set $~argumentsLength
         (i32.const 1)
        )
        (i32.const 0)
       )
      )
      (i32.const -1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 154)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#lastIndexOf
       (call $~lib/rt/__tmptostack
        (local.get $numbers)
       )
       (i32.const 2)
       (i32.const 3)
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 155)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#lastIndexOf
       (call $~lib/rt/__tmptostack
        (local.get $numbers)
       )
       (i32.const 2)
       (i32.const 2)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 156)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#lastIndexOf
       (call $~lib/rt/__tmptostack
        (local.get $numbers)
       )
       (i32.const 2)
       (i32.const -2)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 157)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#lastIndexOf
       (call $~lib/rt/__tmptostack
        (local.get $numbers)
       )
       (i32.const 2)
       (i32.const -1)
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 158)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $elements
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 12)
      (i32.const 8)
      (i32.const 1872)
     )
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#join
        (call $~lib/rt/__tmptostack
         (local.get $elements)
        )
        (i32.const 1936)
       )
      )
      (i32.const 1968)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 164)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#join
        (call $~lib/rt/__tmptostack
         (local.get $elements)
        )
        (i32.const 1904)
       )
      )
      (i32.const 2016)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 165)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#join
        (call $~lib/rt/__tmptostack
         (local.get $elements)
        )
        (i32.const 2064)
       )
      )
      (i32.const 2096)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 166)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#join
        (call $~lib/rt/__tmptostack
         (local.get $elements)
        )
        (i32.const 2144)
       )
      )
      (i32.const 2176)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 167)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/string/String.__eq
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#join
        (call $~lib/rt/__tmptostack
         (local.get $elements)
        )
        (i32.const 1936)
       )
      )
      (call $~lib/rt/__tmptostack
       (call $~lib/staticarray/StaticArray<~lib/string/String>#toString
        (call $~lib/rt/__tmptostack
         (local.get $elements)
        )
       )
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 168)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $numbers|39
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 8)
      (i32.const 4)
      (i32.const 2240)
     )
    )
   )
   (drop
    (call $~lib/staticarray/StaticArray<i32>#fill@varargs
     (call $~lib/rt/__tmptostack
      (local.get $numbers|39)
     )
     (i32.const 1)
     (i32.const 1)
     (block (result i32)
      (global.set $~argumentsLength
       (i32.const 2)
      )
      (i32.const 0)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|39)
       )
       (i32.const 0)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 176)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|39)
       )
       (i32.const 1)
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 177)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $numbers|41
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 12)
      (i32.const 4)
      (i32.const 2272)
     )
    )
   )
   (drop
    (call $~lib/staticarray/StaticArray<i32>#reverse
     (call $~lib/rt/__tmptostack
      (local.get $numbers|41)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|41)
       )
       (i32.const 0)
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 185)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|41)
       )
       (i32.const 1)
      )
      (i32.const 2)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 186)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|41)
       )
       (i32.const 2)
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 187)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $numbers|43
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 20)
      (i32.const 4)
      (i32.const 2304)
     )
    )
   )
   (drop
    (call $~lib/staticarray/StaticArray<i32>#copyWithin@varargs
     (call $~lib/rt/__tmptostack
      (local.get $numbers|43)
     )
     (i32.const 0)
     (i32.const 3)
     (block (result i32)
      (global.set $~argumentsLength
       (i32.const 2)
      )
      (i32.const 0)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|43)
       )
       (i32.const 0)
      )
      (i32.const 4)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 195)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|43)
       )
       (i32.const 1)
      )
      (i32.const 5)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 196)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|43)
       )
       (i32.const 2)
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 197)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|43)
       )
       (i32.const 3)
      )
      (i32.const 4)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 198)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $numbers|43)
       )
       (i32.const 4)
      )
      (i32.const 5)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 199)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $numbers|45
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 12)
      (i32.const 4)
      (i32.const 2352)
     )
    )
   )
   (local.set $incNums
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<i32>#map<i32>
      (call $~lib/rt/__tmptostack
       (local.get $numbers|45)
      )
      (call $~lib/rt/__tmptostack
       (i32.const 2384)
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/array/Array<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $incNums)
       )
       (i32.const 0)
      )
      (i32.const 2)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 208)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/array/Array<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $incNums)
       )
       (i32.const 1)
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 209)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/array/Array<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $incNums)
       )
       (i32.const 2)
      )
      (i32.const 4)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 210)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (call $~lib/staticarray/StaticArray<i32>#forEach
    (call $~lib/rt/__tmptostack
     (local.get $numbers|45)
    )
    (call $~lib/rt/__tmptostack
     (i32.const 2416)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (global.get $std/staticarray/maxVal)
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 216)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $filtered
    (call $~lib/rt/__localtostack
     (call $~lib/staticarray/StaticArray<i32>#filter
      (call $~lib/rt/__tmptostack
       (local.get $numbers|45)
      )
      (call $~lib/rt/__tmptostack
       (i32.const 2448)
      )
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/array/Array<i32>#get:length
       (call $~lib/rt/__tmptostack
        (local.get $filtered)
       )
      )
      (i32.const 2)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 220)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/array/Array<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $filtered)
       )
       (i32.const 0)
      )
      (i32.const 2)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 221)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/array/Array<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $filtered)
       )
       (i32.const 1)
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 222)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $sum1
    (call $~lib/staticarray/StaticArray<i32>#reduce<i32>
     (call $~lib/rt/__tmptostack
      (local.get $numbers|45)
     )
     (call $~lib/rt/__tmptostack
      (i32.const 2480)
     )
     (i32.const 0)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (local.get $sum1)
      (i32.const 6)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 226)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (local.set $sum2
    (call $~lib/staticarray/StaticArray<i32>#reduceRight<i32>
     (call $~lib/rt/__tmptostack
      (local.get $numbers|45)
     )
     (call $~lib/rt/__tmptostack
      (i32.const 2512)
     )
     (i32.const 0)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (local.get $sum2)
      (i32.const 6)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 230)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/staticarray/StaticArray<i32>#some
      (call $~lib/rt/__tmptostack
       (local.get $numbers|45)
      )
      (call $~lib/rt/__tmptostack
       (i32.const 2544)
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 233)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eqz
      (call $~lib/staticarray/StaticArray<i32>#some
       (call $~lib/rt/__tmptostack
        (local.get $numbers|45)
       )
       (call $~lib/rt/__tmptostack
        (i32.const 2576)
       )
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 234)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (call $~lib/staticarray/StaticArray<i32>#every
      (call $~lib/rt/__tmptostack
       (local.get $numbers|45)
      )
      (call $~lib/rt/__tmptostack
       (i32.const 2608)
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 237)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eqz
      (call $~lib/staticarray/StaticArray<i32>#every
       (call $~lib/rt/__tmptostack
        (local.get $numbers|45)
       )
       (call $~lib/rt/__tmptostack
        (i32.const 2640)
       )
      )
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 238)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#findIndex
       (call $~lib/rt/__tmptostack
        (local.get $numbers|45)
       )
       (call $~lib/rt/__tmptostack
        (i32.const 2672)
       )
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 241)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#findIndex
       (call $~lib/rt/__tmptostack
        (local.get $numbers|45)
       )
       (call $~lib/rt/__tmptostack
        (i32.const 2704)
       )
      )
      (i32.const -1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 242)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#findLastIndex
       (call $~lib/rt/__tmptostack
        (local.get $numbers|45)
       )
       (call $~lib/rt/__tmptostack
        (i32.const 2736)
       )
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 245)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#findLastIndex
       (call $~lib/rt/__tmptostack
        (local.get $numbers|45)
       )
       (call $~lib/rt/__tmptostack
        (i32.const 2768)
       )
      )
      (i32.const -1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 246)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (block
   (local.set $array|51
    (call $~lib/rt/__localtostack
     (call $~lib/rt/__newBuffer
      (i32.const 16)
      (i32.const 4)
      (i32.const 2800)
     )
    )
   )
   (drop
    (call $~lib/staticarray/StaticArray<i32>#sort@varargs
     (call $~lib/rt/__tmptostack
      (local.get $array|51)
     )
     (block (result i32)
      (global.set $~argumentsLength
       (i32.const 0)
      )
      (i32.const 0)
     )
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $array|51)
       )
       (i32.const 0)
      )
      (i32.const 0)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 254)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $array|51)
       )
       (i32.const 1)
      )
      (i32.const 1)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 255)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $array|51)
       )
       (i32.const 2)
      )
      (i32.const 2)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 256)
      (i32.const 3)
     )
     (unreachable)
    )
   )
   (if
    (i32.eqz
     (i32.eq
      (call $~lib/staticarray/StaticArray<i32>#__get
       (call $~lib/rt/__tmptostack
        (local.get $array|51)
       )
       (i32.const 3)
      )
      (i32.const 3)
     )
    )
    (then
     (call $~lib/builtins/abort
      (i32.const 0)
      (i32.const 192)
      (i32.const 257)
      (i32.const 3)
     )
     (unreachable)
    )
   )
  )
  (global.set $~lib/memory/__stack_pointer
   (global.get $~lib/memory/__heap_base)
  )
  (call $~lib/rt/itcms/__collect)
 )
 (func $~lib/rt/__visit_globals (param $0 i32)
  (local $1 i32)
  (if
   (local.tee $1
    (global.get $std/staticarray/arr1)
   )
   (then
    (call $~lib/rt/itcms/__visit
     (local.get $1)
     (local.get $0)
    )
   )
  )
  (if
   (local.tee $1
    (global.get $std/staticarray/arr2)
   )
   (then
    (call $~lib/rt/itcms/__visit
     (local.get $1)
     (local.get $0)
    )
   )
  )
  (if
   (local.tee $1
    (global.get $std/staticarray/arr3)
   )
   (then
    (call $~lib/rt/itcms/__visit
     (local.get $1)
     (local.get $0)
    )
   )
  )
  (if
   (local.tee $1
    (global.get $std/staticarray/arr4)
   )
   (then
    (call $~lib/rt/itcms/__visit
     (local.get $1)
     (local.get $0)
    )
   )
  )
 )
 (func $~lib/arraybuffer/ArrayBufferView~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/rt/itcms/__visit
   (i32.load
    (local.get $0)
   )
   (local.get $1)
  )
 )
 (func $~lib/object/Object~visit (param $0 i32) (param $1 i32)
  (nop)
 )
 (func $~lib/staticarray/StaticArray<std/staticarray/Ref>#__visit (param $this i32) (param $cookie i32)
  (local $cur i32)
  (local $end i32)
  (local $val i32)
  (drop
   (i32.const 1)
  )
  (block
   (local.set $cur
    (local.get $this)
   )
   (local.set $end
    (i32.add
     (local.get $cur)
     (call $~lib/rt/common/OBJECT#get:rtSize
      (i32.sub
       (local.get $this)
       (i32.const 20)
      )
     )
    )
   )
   (block $while-break|0
    (loop $while-continue|0
     (if
      (i32.lt_u
       (local.get $cur)
       (local.get $end)
      )
      (then
       (local.set $val
        (i32.load
         (local.get $cur)
        )
       )
       (if
        (local.get $val)
        (then
         (call $~lib/rt/itcms/__visit
          (local.get $val)
          (local.get $cookie)
         )
        )
       )
       (local.set $cur
        (i32.add
         (local.get $cur)
         (i32.const 4)
        )
       )
       (br $while-continue|0)
      )
     )
    )
   )
  )
 )
 (func $~lib/staticarray/StaticArray<std/staticarray/Ref>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/staticarray/StaticArray<std/staticarray/Ref>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/array/Array<i32>#get:buffer (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/array/Array<i32>#__visit (param $this i32) (param $cookie i32)
  (drop
   (i32.const 0)
  )
  (call $~lib/rt/itcms/__visit
   (call $~lib/array/Array<i32>#get:buffer
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/array/Array<i32>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/array/Array<i32>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#__visit (param $this i32) (param $cookie i32)
  (local $cur i32)
  (local $end i32)
  (local $val i32)
  (drop
   (i32.const 1)
  )
  (block
   (local.set $cur
    (local.get $this)
   )
   (local.set $end
    (i32.add
     (local.get $cur)
     (call $~lib/rt/common/OBJECT#get:rtSize
      (i32.sub
       (local.get $this)
       (i32.const 20)
      )
     )
    )
   )
   (block $while-break|0
    (loop $while-continue|0
     (if
      (i32.lt_u
       (local.get $cur)
       (local.get $end)
      )
      (then
       (local.set $val
        (i32.load
         (local.get $cur)
        )
       )
       (if
        (local.get $val)
        (then
         (call $~lib/rt/itcms/__visit
          (local.get $val)
          (local.get $cookie)
         )
        )
       )
       (local.set $cur
        (i32.add
         (local.get $cur)
         (i32.const 4)
        )
       )
       (br $while-continue|0)
      )
     )
    )
   )
  )
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/staticarray/StaticArray<~lib/string/String>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/array/Array<~lib/string/String>#get:buffer (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/string/String>#__visit (param $this i32) (param $cookie i32)
  (local $cur i32)
  (local $end i32)
  (local $val i32)
  (drop
   (i32.const 1)
  )
  (block
   (local.set $cur
    (call $~lib/array/Array<~lib/string/String>#get:dataStart
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (local.set $end
    (i32.add
     (local.get $cur)
     (i32.shl
      (call $~lib/array/Array<~lib/string/String>#get:length_
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.const 2)
     )
    )
   )
   (block $while-break|0
    (loop $while-continue|0
     (if
      (i32.lt_u
       (local.get $cur)
       (local.get $end)
      )
      (then
       (local.set $val
        (i32.load
         (local.get $cur)
        )
       )
       (if
        (local.get $val)
        (then
         (call $~lib/rt/itcms/__visit
          (local.get $val)
          (local.get $cookie)
         )
        )
       )
       (local.set $cur
        (i32.add
         (local.get $cur)
         (i32.const 4)
        )
       )
       (br $while-continue|0)
      )
     )
    )
   )
  )
  (call $~lib/rt/itcms/__visit
   (call $~lib/array/Array<~lib/string/String>#get:buffer
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/array/Array<~lib/string/String>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/array/Array<~lib/string/String>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>#get:_env (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>#__visit (param $this i32) (param $cookie i32)
  (call $~lib/rt/itcms/__visit
   (call $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>#get:_env
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>void>#get:_env (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>void>#__visit (param $this i32) (param $cookie i32)
  (call $~lib/rt/itcms/__visit
   (call $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>void>#get:_env
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>void>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>void>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>bool>#get:_env (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>bool>#__visit (param $this i32) (param $cookie i32)
  (call $~lib/rt/itcms/__visit
   (call $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>bool>#get:_env
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>bool>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>bool>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>#get:_env (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>#__visit (param $this i32) (param $cookie i32)
  (call $~lib/rt/itcms/__visit
   (call $~lib/function/Function<%28i32%2Ci32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>#get:_env
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/function/Function<%28i32%2Ci32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%29=>i32>#get:_env (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%29=>i32>#__visit (param $this i32) (param $cookie i32)
  (call $~lib/rt/itcms/__visit
   (call $~lib/function/Function<%28i32%2Ci32%29=>i32>#get:_env
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%29=>i32>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/function/Function<%28i32%2Ci32%29=>i32>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/rt/__visit_members (param $0 i32) (param $1 i32)
  (block $invalid
   (block $~lib/function/Function<%28i32%2Ci32%29=>i32>
    (block $~lib/function/Function<%28i32%2Ci32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>
     (block $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>bool>
      (block $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>void>
       (block $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>
        (block $~lib/staticarray/StaticArray<f32>
         (block $~lib/staticarray/StaticArray<f64>
          (block $~lib/array/Array<~lib/string/String>
           (block $~lib/staticarray/StaticArray<~lib/string/String>
            (block $~lib/array/Array<i32>
             (block $~lib/staticarray/StaticArray<std/staticarray/Ref>
              (block $std/staticarray/Ref
               (block $~lib/staticarray/StaticArray<i32>
                (block $~lib/arraybuffer/ArrayBufferView
                 (block $~lib/string/String
                  (block $~lib/arraybuffer/ArrayBuffer
                   (block $~lib/object/Object
                    (br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $~lib/staticarray/StaticArray<i32> $std/staticarray/Ref $~lib/staticarray/StaticArray<std/staticarray/Ref> $~lib/array/Array<i32> $~lib/staticarray/StaticArray<~lib/string/String> $~lib/array/Array<~lib/string/String> $~lib/staticarray/StaticArray<f64> $~lib/staticarray/StaticArray<f32> $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32> $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>void> $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>bool> $~lib/function/Function<%28i32%2Ci32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32> $~lib/function/Function<%28i32%2Ci32%29=>i32> $invalid
                     (i32.load
                      (i32.sub
                       (local.get $0)
                       (i32.const 8)
                      )
                     )
                    )
                   )
                   (return)
                  )
                  (return)
                 )
                 (return)
                )
                (block
                 (call $~lib/arraybuffer/ArrayBufferView~visit
                  (local.get $0)
                  (local.get $1)
                 )
                 (return)
                )
               )
               (return)
              )
              (return)
             )
             (block
              (call $~lib/staticarray/StaticArray<std/staticarray/Ref>~visit
               (local.get $0)
               (local.get $1)
              )
              (return)
             )
            )
            (block
             (call $~lib/array/Array<i32>~visit
              (local.get $0)
              (local.get $1)
             )
             (return)
            )
           )
           (block
            (call $~lib/staticarray/StaticArray<~lib/string/String>~visit
             (local.get $0)
             (local.get $1)
            )
            (return)
           )
          )
          (block
           (call $~lib/array/Array<~lib/string/String>~visit
            (local.get $0)
            (local.get $1)
           )
           (return)
          )
         )
         (return)
        )
        (return)
       )
       (block
        (call $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>~visit
         (local.get $0)
         (local.get $1)
        )
        (return)
       )
      )
      (block
       (call $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>void>~visit
        (local.get $0)
        (local.get $1)
       )
       (return)
      )
     )
     (block
      (call $~lib/function/Function<%28i32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>bool>~visit
       (local.get $0)
       (local.get $1)
      )
      (return)
     )
    )
    (block
     (call $~lib/function/Function<%28i32%2Ci32%2Ci32%2C~lib/staticarray/StaticArray<i32>%29=>i32>~visit
      (local.get $0)
      (local.get $1)
     )
     (return)
    )
   )
   (block
    (call $~lib/function/Function<%28i32%2Ci32%29=>i32>~visit
     (local.get $0)
     (local.get $1)
    )
    (return)
   )
  )
  (unreachable)
 )
 (func $~start
  (call $start:std/staticarray)
 )
)
