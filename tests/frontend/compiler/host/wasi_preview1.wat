(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $4 (func (param i32)))
 (type $5 (func))
 (type $6 (func (param i32 i32 i32 i32)))
 (type $7 (func (param i32 i32 i32)))
 (type $8 (func (param i32 i32 i32 i32) (result i32)))
 (type $9 (func (param i32 i32 i32) (result i32)))
 (type $10 (func (param i32 i32 i64) (result i32)))
 (import "wasi_snapshot_preview1" "fd_write" (func $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/fd_write (param i32 i32 i32 i32) (result i32)))
 (import "wasi_snapshot_preview1" "proc_exit" (func $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/proc_exit (param i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/wasi_snapshot_preview1/wasi_process/wasi_process.stdout i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf i32 (i32.const 96))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $~lib/native/ASC_LOW_MEMORY_LIMIT i32 (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 3484))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 36252))
 (global $~lib/memory/__heap_base i32 (i32.const 36252))
 (memory $0 1)
 (data $0 (i32.const 12) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00.\00\00\00w\00a\00s\00i\00_\00p\00r\00e\00v\00i\00e\00w\001\00.\00t\00s\00 \00l\00o\00a\00d\00e\00d\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 96) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 124) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00U\00n\00p\00a\00i\00r\00e\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 188) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00~\00l\00i\00b\00/\00s\00t\00r\00i\00n\00g\00.\00t\00s\00")
 (data $4 (i32.const 236) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00S\00U\00C\00C\00E\00S\00S\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 284) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00T\00O\00O\00B\00I\00G\00")
 (data $6 (i32.const 316) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00A\00C\00C\00E\00S\00\00\00")
 (data $7 (i32.const 348) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00A\00D\00D\00R\00I\00N\00U\00S\00E\00\00\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 396) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\18\00\00\00A\00D\00D\00R\00N\00O\00T\00A\00V\00A\00I\00L\00\00\00\00\00")
 (data $9 (i32.const 444) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00A\00F\00N\00O\00S\00U\00P\00P\00O\00R\00T\00\00\00\00\00\00\00")
 (data $10 (i32.const 492) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00A\00G\00A\00I\00N\00\00\00")
 (data $11 (i32.const 524) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00A\00L\00R\00E\00A\00D\00Y\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $12 (i32.const 572) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00B\00A\00D\00F\00\00\00\00\00")
 (data $13 (i32.const 604) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00B\00A\00D\00M\00S\00G\00")
 (data $14 (i32.const 636) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00B\00U\00S\00Y\00\00\00\00\00")
 (data $15 (i32.const 668) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00C\00A\00N\00C\00E\00L\00E\00D\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $16 (i32.const 716) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00C\00H\00I\00L\00D\00\00\00")
 (data $17 (i32.const 748) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00C\00O\00N\00N\00A\00B\00O\00R\00T\00E\00D\00\00\00\00\00\00\00")
 (data $18 (i32.const 796) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00C\00O\00N\00N\00R\00E\00F\00U\00S\00E\00D\00\00\00\00\00\00\00")
 (data $19 (i32.const 844) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00C\00O\00N\00N\00R\00E\00S\00E\00T\00\00\00\00\00\00\00\00\00\00\00")
 (data $20 (i32.const 892) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00D\00E\00A\00D\00L\00K\00")
 (data $21 (i32.const 924) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00D\00E\00S\00T\00A\00D\00D\00R\00R\00E\00Q\00\00\00\00\00\00\00")
 (data $22 (i32.const 972) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00D\00O\00M\00\00\00\00\00\00\00")
 (data $23 (i32.const 1004) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00D\00Q\00U\00O\00T\00\00\00")
 (data $24 (i32.const 1036) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00E\00X\00I\00S\00T\00\00\00")
 (data $25 (i32.const 1068) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00F\00A\00U\00L\00T\00\00\00")
 (data $26 (i32.const 1100) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00F\00B\00I\00G\00\00\00\00\00")
 (data $27 (i32.const 1132) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00H\00O\00S\00T\00U\00N\00R\00E\00A\00C\00H\00\00\00\00\00\00\00")
 (data $28 (i32.const 1180) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00I\00D\00R\00M\00\00\00\00\00")
 (data $29 (i32.const 1212) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00I\00L\00S\00E\00Q\00\00\00")
 (data $30 (i32.const 1244) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00I\00N\00P\00R\00O\00G\00R\00E\00S\00S\00\00\00\00\00\00\00\00\00")
 (data $31 (i32.const 1292) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00I\00N\00T\00R\00\00\00\00\00")
 (data $32 (i32.const 1324) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00I\00N\00V\00A\00L\00\00\00")
 (data $33 (i32.const 1356) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00I\00O\00\00\00\00\00\00\00\00\00")
 (data $34 (i32.const 1388) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00I\00S\00C\00O\00N\00N\00")
 (data $35 (i32.const 1420) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00I\00S\00D\00I\00R\00\00\00")
 (data $36 (i32.const 1452) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00L\00O\00O\00P\00\00\00\00\00")
 (data $37 (i32.const 1484) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00M\00F\00I\00L\00E\00\00\00")
 (data $38 (i32.const 1516) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00M\00L\00I\00N\00K\00\00\00")
 (data $39 (i32.const 1548) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00M\00S\00G\00S\00I\00Z\00E\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $40 (i32.const 1596) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00M\00U\00L\00T\00I\00H\00O\00P\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $41 (i32.const 1644) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00N\00A\00M\00E\00T\00O\00O\00L\00O\00N\00G\00\00\00\00\00\00\00")
 (data $42 (i32.const 1692) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00N\00E\00T\00D\00O\00W\00N\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $43 (i32.const 1740) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00N\00E\00T\00R\00E\00S\00E\00T\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $44 (i32.const 1788) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00N\00E\00T\00U\00N\00R\00E\00A\00C\00H\00\00\00\00\00\00\00\00\00")
 (data $45 (i32.const 1836) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00N\00F\00I\00L\00E\00\00\00")
 (data $46 (i32.const 1868) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00N\00O\00B\00U\00F\00S\00")
 (data $47 (i32.const 1900) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00N\00O\00D\00E\00V\00\00\00")
 (data $48 (i32.const 1932) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00N\00O\00E\00N\00T\00\00\00")
 (data $49 (i32.const 1964) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00N\00O\00E\00X\00E\00C\00")
 (data $50 (i32.const 1996) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00N\00O\00L\00C\00K\00\00\00")
 (data $51 (i32.const 2028) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00N\00O\00L\00I\00N\00K\00")
 (data $52 (i32.const 2060) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00N\00O\00M\00E\00M\00\00\00")
 (data $53 (i32.const 2092) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00N\00O\00M\00S\00G\00\00\00")
 (data $54 (i32.const 2124) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00N\00O\00P\00R\00O\00T\00O\00O\00P\00T\00\00\00\00\00\00\00\00\00")
 (data $55 (i32.const 2172) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00N\00O\00S\00P\00C\00\00\00")
 (data $56 (i32.const 2204) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00N\00O\00S\00Y\00S\00\00\00")
 (data $57 (i32.const 2236) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00N\00O\00T\00C\00O\00N\00N\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $58 (i32.const 2284) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00N\00O\00T\00D\00I\00R\00")
 (data $59 (i32.const 2316) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00N\00O\00T\00E\00M\00P\00T\00Y\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $60 (i32.const 2364) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00N\00O\00T\00R\00E\00C\00O\00V\00E\00R\00A\00B\00L\00E\00")
 (data $61 (i32.const 2412) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00N\00O\00T\00S\00O\00C\00K\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $62 (i32.const 2460) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00N\00O\00T\00S\00U\00P\00")
 (data $63 (i32.const 2492) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00N\00O\00T\00T\00Y\00\00\00")
 (data $64 (i32.const 2524) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00N\00X\00I\00O\00\00\00\00\00")
 (data $65 (i32.const 2556) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00O\00V\00E\00R\00F\00L\00O\00W\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $66 (i32.const 2604) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00O\00W\00N\00E\00R\00D\00E\00A\00D\00\00\00\00\00\00\00\00\00\00\00")
 (data $67 (i32.const 2652) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00P\00E\00R\00M\00\00\00\00\00")
 (data $68 (i32.const 2684) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00P\00I\00P\00E\00\00\00\00\00")
 (data $69 (i32.const 2716) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00P\00R\00O\00T\00O\00\00\00")
 (data $70 (i32.const 2748) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00P\00R\00O\00T\00O\00N\00O\00S\00U\00P\00P\00O\00R\00T\00")
 (data $71 (i32.const 2796) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00P\00R\00O\00T\00O\00T\00Y\00P\00E\00\00\00\00\00\00\00\00\00\00\00")
 (data $72 (i32.const 2844) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00R\00A\00N\00G\00E\00\00\00")
 (data $73 (i32.const 2876) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00R\00O\00F\00S\00\00\00\00\00")
 (data $74 (i32.const 2908) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00S\00P\00I\00P\00E\00\00\00")
 (data $75 (i32.const 2940) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00S\00R\00C\00H\00\00\00\00\00")
 (data $76 (i32.const 2972) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00S\00T\00A\00L\00E\00\00\00")
 (data $77 (i32.const 3004) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00T\00I\00M\00E\00D\00O\00U\00T\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $78 (i32.const 3052) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00T\00X\00T\00B\00S\00Y\00")
 (data $79 (i32.const 3084) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00X\00D\00E\00V\00\00\00\00\00")
 (data $80 (i32.const 3116) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00N\00O\00T\00C\00A\00P\00A\00B\00L\00E\00\00\00\00\00\00\00\00\00")
 (data $81 (i32.const 3164) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00U\00N\00K\00N\00O\00W\00N\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $82 (i32.const 3212) "l\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00V\00\00\00~\00l\00i\00b\00/\00w\00a\00s\00i\00_\00s\00n\00a\00p\00s\00h\00o\00t\00_\00p\00r\00e\00v\00i\00e\00w\001\00/\00w\00a\00s\00i\00_\00p\00r\00o\00c\00e\00s\00s\00.\00t\00s\00\00\00\00\00\00\00")
 (data $83 (i32.const 3324) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $84 (i32.const 3388) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $85 (i32.const 3452) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00\n\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/common/OBJECT#get:rtSize (param $this i32) (result i32)
  (i32.load offset=16
   (local.get $this)
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
 (func $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/iovec#set:buf (param $this i32) (param $buf i32)
  (i32.store
   (local.get $this)
   (local.get $buf)
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
 (func $~lib/string/String.__ne (param $left i32) (param $right i32) (result i32)
  (return
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (local.get $left)
     )
     (call $~lib/rt/__tmptostack
      (local.get $right)
     )
    )
   )
  )
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
  (local.set $strEnd
   (i32.add
    (local.get $str)
    (i32.shl
     (local.get $len)
     (i32.const 1)
    )
   )
  )
  (local.set $bufOff
   (local.get $buf)
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.lt_u
      (local.get $str)
      (local.get $strEnd)
     )
     (then
      (local.set $c1
       (i32.load16_u
        (local.get $str)
       )
      )
      (if
       (i32.lt_u
        (local.get $c1)
        (i32.const 128)
       )
       (then
        (i32.store8
         (local.get $bufOff)
         (local.get $c1)
        )
        (local.set $bufOff
         (i32.add
          (local.get $bufOff)
          (i32.const 1)
         )
        )
        (if
         (i32.and
          (local.get $nullTerminated)
          (i32.eqz
           (local.get $c1)
          )
         )
         (then
          (return
           (i32.sub
            (local.get $bufOff)
            (local.get $buf)
           )
          )
         )
        )
       )
       (else
        (if
         (i32.lt_u
          (local.get $c1)
          (i32.const 2048)
         )
         (then
          (local.set $b0
           (i32.or
            (i32.shr_u
             (local.get $c1)
             (i32.const 6)
            )
            (i32.const 192)
           )
          )
          (local.set $b1
           (i32.or
            (i32.and
             (local.get $c1)
             (i32.const 63)
            )
            (i32.const 128)
           )
          )
          (i32.store16
           (local.get $bufOff)
           (i32.or
            (i32.shl
             (local.get $b1)
             (i32.const 8)
            )
            (local.get $b0)
           )
          )
          (local.set $bufOff
           (i32.add
            (local.get $bufOff)
            (i32.const 2)
           )
          )
         )
         (else
          (if
           (i32.eq
            (i32.and
             (local.get $c1)
             (i32.const 63488)
            )
            (i32.const 55296)
           )
           (then
            (if
             (if (result i32)
              (i32.lt_u
               (local.get $c1)
               (i32.const 56320)
              )
              (then
               (i32.lt_u
                (i32.add
                 (local.get $str)
                 (i32.const 2)
                )
                (local.get $strEnd)
               )
              )
              (else
               (i32.const 0)
              )
             )
             (then
              (local.set $c2
               (i32.load16_u offset=2
                (local.get $str)
               )
              )
              (if
               (i32.eq
                (i32.and
                 (local.get $c2)
                 (i32.const 64512)
                )
                (i32.const 56320)
               )
               (then
                (local.set $c1
                 (i32.or
                  (i32.add
                   (i32.const 65536)
                   (i32.shl
                    (i32.and
                     (local.get $c1)
                     (i32.const 1023)
                    )
                    (i32.const 10)
                   )
                  )
                  (i32.and
                   (local.get $c2)
                   (i32.const 1023)
                  )
                 )
                )
                (local.set $b0|11
                 (i32.or
                  (i32.shr_u
                   (local.get $c1)
                   (i32.const 18)
                  )
                  (i32.const 240)
                 )
                )
                (local.set $b1|12
                 (i32.or
                  (i32.and
                   (i32.shr_u
                    (local.get $c1)
                    (i32.const 12)
                   )
                   (i32.const 63)
                  )
                  (i32.const 128)
                 )
                )
                (local.set $b2
                 (i32.or
                  (i32.and
                   (i32.shr_u
                    (local.get $c1)
                    (i32.const 6)
                   )
                   (i32.const 63)
                  )
                  (i32.const 128)
                 )
                )
                (local.set $b3
                 (i32.or
                  (i32.and
                   (local.get $c1)
                   (i32.const 63)
                  )
                  (i32.const 128)
                 )
                )
                (i32.store
                 (local.get $bufOff)
                 (i32.or
                  (i32.or
                   (i32.or
                    (i32.shl
                     (local.get $b3)
                     (i32.const 24)
                    )
                    (i32.shl
                     (local.get $b2)
                     (i32.const 16)
                    )
                   )
                   (i32.shl
                    (local.get $b1|12)
                    (i32.const 8)
                   )
                  )
                  (local.get $b0|11)
                 )
                )
                (local.set $bufOff
                 (i32.add
                  (local.get $bufOff)
                  (i32.const 4)
                 )
                )
                (local.set $str
                 (i32.add
                  (local.get $str)
                  (i32.const 4)
                 )
                )
                (br $while-continue|0)
               )
              )
             )
            )
            (if
             (i32.ne
              (local.get $errorMode)
              (i32.const 0)
             )
             (then
              (if
               (i32.eq
                (local.get $errorMode)
                (i32.const 2)
               )
               (then
                (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
                 (i32.const 144)
                 (i32.const 208)
                 (i32.const 785)
                 (i32.const 49)
                )
                (unreachable)
               )
              )
              (local.set $c1
               (i32.const 65533)
              )
             )
            )
           )
          )
          (local.set $b0|15
           (i32.or
            (i32.shr_u
             (local.get $c1)
             (i32.const 12)
            )
            (i32.const 224)
           )
          )
          (local.set $b1|16
           (i32.or
            (i32.and
             (i32.shr_u
              (local.get $c1)
              (i32.const 6)
             )
             (i32.const 63)
            )
            (i32.const 128)
           )
          )
          (local.set $b2|17
           (i32.or
            (i32.and
             (local.get $c1)
             (i32.const 63)
            )
            (i32.const 128)
           )
          )
          (i32.store16
           (local.get $bufOff)
           (i32.or
            (i32.shl
             (local.get $b1|16)
             (i32.const 8)
            )
            (local.get $b0|15)
           )
          )
          (i32.store8 offset=2
           (local.get $bufOff)
           (local.get $b2|17)
          )
          (local.set $bufOff
           (i32.add
            (local.get $bufOff)
            (i32.const 3)
           )
          )
         )
        )
       )
      )
      (local.set $str
       (i32.add
        (local.get $str)
        (i32.const 2)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (local.get $nullTerminated)
   (then
    (i32.store8
     (block (result i32)
      (local.set $bufOff
       (i32.add
        (local.tee $18
         (local.get $bufOff)
        )
        (i32.const 1)
       )
      )
      (local.get $18)
     )
     (i32.const 0)
    )
   )
  )
  (return
   (i32.sub
    (local.get $bufOff)
    (local.get $buf)
   )
  )
 )
 (func $~lib/string/String.UTF8.encodeUnsafe@varargs (param $str i32) (param $len i32) (param $buf i32) (param $nullTerminated i32) (param $errorMode i32) (result i32)
  (block $2of2
   (block $1of2
    (block $0of2
     (block $outOfRange
      (br_table $0of2 $1of2 $2of2 $outOfRange
       (i32.sub
        (global.get $~argumentsLength)
        (i32.const 3)
       )
      )
     )
     (unreachable)
    )
    (local.set $nullTerminated
     (i32.const 0)
    )
   )
   (local.set $errorMode
    (i32.const 0)
   )
  )
  (call $~lib/string/String.UTF8.encodeUnsafe
   (local.get $str)
   (local.get $len)
   (local.get $buf)
   (local.get $nullTerminated)
   (local.get $errorMode)
  )
 )
 (func $~lib/util/number/decimalCount32 (param $value i32) (result i32)
  (if
   (i32.lt_u
    (local.get $value)
    (i32.const 100000)
   )
   (then
    (if
     (i32.lt_u
      (local.get $value)
      (i32.const 100)
     )
     (then
      (return
       (i32.add
        (i32.const 1)
        (i32.ge_u
         (local.get $value)
         (i32.const 10)
        )
       )
      )
     )
     (else
      (return
       (i32.add
        (i32.add
         (i32.const 3)
         (i32.ge_u
          (local.get $value)
          (i32.const 10000)
         )
        )
        (i32.ge_u
         (local.get $value)
         (i32.const 1000)
        )
       )
      )
     )
    )
   )
   (else
    (if
     (i32.lt_u
      (local.get $value)
      (i32.const 10000000)
     )
     (then
      (return
       (i32.add
        (i32.const 6)
        (i32.ge_u
         (local.get $value)
         (i32.const 1000000)
        )
       )
      )
     )
     (else
      (return
       (i32.add
        (i32.add
         (i32.const 8)
         (i32.ge_u
          (local.get $value)
          (i32.const 1000000000)
         )
        )
        (i32.ge_u
         (local.get $value)
         (i32.const 100000000)
        )
       )
      )
     )
    )
   )
  )
 )
 (func $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/iovec#set:buf_len (param $this i32) (param $buf_len i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $buf_len)
  )
 )
 (func $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort (param $message i32) (param $fileName i32) (param $lineNumber i32) (param $columnNumber i32)
  (local $ptr i32)
  (local $5 i32)
  (local $len i32)
  (local $t i32)
  (local $8 i32)
  (local $t|9 i32)
  (call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/iovec#set:buf
   (i32.const 0)
   (i32.const 12)
  )
  (local.set $ptr
   (i32.const 12)
  )
  (i64.store
   (local.get $ptr)
   (i64.const 9071471065260641)
  )
  (local.set $ptr
   (i32.add
    (local.get $ptr)
    (i32.const 7)
   )
  )
  (if
   (call $~lib/string/String.__ne
    (call $~lib/rt/__tmptostack
     (local.get $message)
    )
    (i32.const 0)
   )
   (then
    (local.set $ptr
     (i32.add
      (local.get $ptr)
      (call $~lib/string/String.UTF8.encodeUnsafe@varargs
       (local.get $message)
       (call $~lib/string/String#get:length
        (call $~lib/rt/__tmptostack
         (local.get $message)
        )
       )
       (local.get $ptr)
       (i32.const 0)
       (block (result i32)
        (global.set $~argumentsLength
         (i32.const 3)
        )
        (i32.const 0)
       )
      )
     )
    )
   )
  )
  (i32.store
   (local.get $ptr)
   (i32.const 544106784)
  )
  (local.set $ptr
   (i32.add
    (local.get $ptr)
    (i32.const 4)
   )
  )
  (if
   (call $~lib/string/String.__ne
    (call $~lib/rt/__tmptostack
     (local.get $fileName)
    )
    (i32.const 0)
   )
   (then
    (local.set $ptr
     (i32.add
      (local.get $ptr)
      (call $~lib/string/String.UTF8.encodeUnsafe@varargs
       (local.get $fileName)
       (call $~lib/string/String#get:length
        (call $~lib/rt/__tmptostack
         (local.get $fileName)
        )
       )
       (local.get $ptr)
       (i32.const 0)
       (block (result i32)
        (global.set $~argumentsLength
         (i32.const 3)
        )
        (i32.const 0)
       )
      )
     )
    )
   )
  )
  (i32.store8
   (block (result i32)
    (local.set $ptr
     (i32.add
      (local.tee $5
       (local.get $ptr)
      )
      (i32.const 1)
     )
    )
    (local.get $5)
   )
   (i32.const 40)
  )
  (local.set $len
   (call $~lib/util/number/decimalCount32
    (local.get $lineNumber)
   )
  )
  (local.set $ptr
   (i32.add
    (local.get $ptr)
    (local.get $len)
   )
  )
  (loop $do-loop|0
   (local.set $t
    (i32.div_u
     (local.get $lineNumber)
     (i32.const 10)
    )
   )
   (i32.store8
    (local.tee $ptr
     (i32.sub
      (local.get $ptr)
      (i32.const 1)
     )
    )
    (i32.add
     (i32.const 48)
     (i32.rem_u
      (local.get $lineNumber)
      (i32.const 10)
     )
    )
   )
   (local.set $lineNumber
    (local.get $t)
   )
   (br_if $do-loop|0
    (local.get $lineNumber)
   )
  )
  (local.set $ptr
   (i32.add
    (local.get $ptr)
    (local.get $len)
   )
  )
  (i32.store8
   (block (result i32)
    (local.set $ptr
     (i32.add
      (local.tee $8
       (local.get $ptr)
      )
      (i32.const 1)
     )
    )
    (local.get $8)
   )
   (i32.const 58)
  )
  (local.set $len
   (call $~lib/util/number/decimalCount32
    (local.get $columnNumber)
   )
  )
  (local.set $ptr
   (i32.add
    (local.get $ptr)
    (local.get $len)
   )
  )
  (loop $do-loop|1
   (local.set $t|9
    (i32.div_u
     (local.get $columnNumber)
     (i32.const 10)
    )
   )
   (i32.store8
    (local.tee $ptr
     (i32.sub
      (local.get $ptr)
      (i32.const 1)
     )
    )
    (i32.add
     (i32.const 48)
     (i32.rem_u
      (local.get $columnNumber)
      (i32.const 10)
     )
    )
   )
   (local.set $columnNumber
    (local.get $t|9)
   )
   (br_if $do-loop|1
    (local.get $columnNumber)
   )
  )
  (local.set $ptr
   (i32.add
    (local.get $ptr)
    (local.get $len)
   )
  )
  (i32.store16
   (local.get $ptr)
   (i32.const 2601)
  )
  (local.set $ptr
   (i32.add
    (local.get $ptr)
    (i32.const 2)
   )
  )
  (call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/iovec#set:buf_len
   (i32.const 0)
   (i32.sub
    (local.get $ptr)
    (i32.const 12)
   )
  )
  (drop
   (call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/fd_write
    (i32.const 2)
    (i32.const 0)
    (i32.const 1)
    (i32.const 8)
   )
  )
  (call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/proc_exit
   (i32.const 255)
  )
 )
 (func $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/errnoToString (param $err i32) (result i32)
  (local $1 i32)
  (block $break|0
   (block $case76|0
    (block $case75|0
     (block $case74|0
      (block $case73|0
       (block $case72|0
        (block $case71|0
         (block $case70|0
          (block $case69|0
           (block $case68|0
            (block $case67|0
             (block $case66|0
              (block $case65|0
               (block $case64|0
                (block $case63|0
                 (block $case62|0
                  (block $case61|0
                   (block $case60|0
                    (block $case59|0
                     (block $case58|0
                      (block $case57|0
                       (block $case56|0
                        (block $case55|0
                         (block $case54|0
                          (block $case53|0
                           (block $case52|0
                            (block $case51|0
                             (block $case50|0
                              (block $case49|0
                               (block $case48|0
                                (block $case47|0
                                 (block $case46|0
                                  (block $case45|0
                                   (block $case44|0
                                    (block $case43|0
                                     (block $case42|0
                                      (block $case41|0
                                       (block $case40|0
                                        (block $case39|0
                                         (block $case38|0
                                          (block $case37|0
                                           (block $case36|0
                                            (block $case35|0
                                             (block $case34|0
                                              (block $case33|0
                                               (block $case32|0
                                                (block $case31|0
                                                 (block $case30|0
                                                  (block $case29|0
                                                   (block $case28|0
                                                    (block $case27|0
                                                     (block $case26|0
                                                      (block $case25|0
                                                       (block $case24|0
                                                        (block $case23|0
                                                         (block $case22|0
                                                          (block $case21|0
                                                           (block $case20|0
                                                            (block $case19|0
                                                             (block $case18|0
                                                              (block $case17|0
                                                               (block $case16|0
                                                                (block $case15|0
                                                                 (block $case14|0
                                                                  (block $case13|0
                                                                   (block $case12|0
                                                                    (block $case11|0
                                                                     (block $case10|0
                                                                      (block $case9|0
                                                                       (block $case8|0
                                                                        (block $case7|0
                                                                         (block $case6|0
                                                                          (block $case5|0
                                                                           (block $case4|0
                                                                            (block $case3|0
                                                                             (block $case2|0
                                                                              (block $case1|0
                                                                               (block $case0|0
                                                                                (local.set $1
                                                                                 (local.get $err)
                                                                                )
                                                                                (br_if $case0|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 0)
                                                                                 )
                                                                                )
                                                                                (br_if $case1|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 1)
                                                                                 )
                                                                                )
                                                                                (br_if $case2|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 2)
                                                                                 )
                                                                                )
                                                                                (br_if $case3|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 3)
                                                                                 )
                                                                                )
                                                                                (br_if $case4|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 4)
                                                                                 )
                                                                                )
                                                                                (br_if $case5|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 5)
                                                                                 )
                                                                                )
                                                                                (br_if $case6|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 6)
                                                                                 )
                                                                                )
                                                                                (br_if $case7|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 7)
                                                                                 )
                                                                                )
                                                                                (br_if $case8|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 8)
                                                                                 )
                                                                                )
                                                                                (br_if $case9|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 9)
                                                                                 )
                                                                                )
                                                                                (br_if $case10|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 10)
                                                                                 )
                                                                                )
                                                                                (br_if $case11|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 11)
                                                                                 )
                                                                                )
                                                                                (br_if $case12|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 12)
                                                                                 )
                                                                                )
                                                                                (br_if $case13|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 13)
                                                                                 )
                                                                                )
                                                                                (br_if $case14|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 14)
                                                                                 )
                                                                                )
                                                                                (br_if $case15|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 15)
                                                                                 )
                                                                                )
                                                                                (br_if $case16|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 16)
                                                                                 )
                                                                                )
                                                                                (br_if $case17|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 17)
                                                                                 )
                                                                                )
                                                                                (br_if $case18|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 18)
                                                                                 )
                                                                                )
                                                                                (br_if $case19|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 19)
                                                                                 )
                                                                                )
                                                                                (br_if $case20|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 20)
                                                                                 )
                                                                                )
                                                                                (br_if $case21|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 21)
                                                                                 )
                                                                                )
                                                                                (br_if $case22|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 22)
                                                                                 )
                                                                                )
                                                                                (br_if $case23|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 23)
                                                                                 )
                                                                                )
                                                                                (br_if $case24|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 24)
                                                                                 )
                                                                                )
                                                                                (br_if $case25|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 25)
                                                                                 )
                                                                                )
                                                                                (br_if $case26|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 26)
                                                                                 )
                                                                                )
                                                                                (br_if $case27|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 27)
                                                                                 )
                                                                                )
                                                                                (br_if $case28|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 28)
                                                                                 )
                                                                                )
                                                                                (br_if $case29|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 29)
                                                                                 )
                                                                                )
                                                                                (br_if $case30|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 30)
                                                                                 )
                                                                                )
                                                                                (br_if $case31|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 31)
                                                                                 )
                                                                                )
                                                                                (br_if $case32|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 32)
                                                                                 )
                                                                                )
                                                                                (br_if $case33|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 33)
                                                                                 )
                                                                                )
                                                                                (br_if $case34|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 34)
                                                                                 )
                                                                                )
                                                                                (br_if $case35|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 35)
                                                                                 )
                                                                                )
                                                                                (br_if $case36|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 36)
                                                                                 )
                                                                                )
                                                                                (br_if $case37|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 37)
                                                                                 )
                                                                                )
                                                                                (br_if $case38|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 38)
                                                                                 )
                                                                                )
                                                                                (br_if $case39|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 39)
                                                                                 )
                                                                                )
                                                                                (br_if $case40|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 40)
                                                                                 )
                                                                                )
                                                                                (br_if $case41|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 41)
                                                                                 )
                                                                                )
                                                                                (br_if $case42|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 42)
                                                                                 )
                                                                                )
                                                                                (br_if $case43|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 43)
                                                                                 )
                                                                                )
                                                                                (br_if $case44|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 44)
                                                                                 )
                                                                                )
                                                                                (br_if $case45|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 45)
                                                                                 )
                                                                                )
                                                                                (br_if $case46|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 46)
                                                                                 )
                                                                                )
                                                                                (br_if $case47|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 47)
                                                                                 )
                                                                                )
                                                                                (br_if $case48|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 48)
                                                                                 )
                                                                                )
                                                                                (br_if $case49|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 49)
                                                                                 )
                                                                                )
                                                                                (br_if $case50|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 50)
                                                                                 )
                                                                                )
                                                                                (br_if $case51|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 51)
                                                                                 )
                                                                                )
                                                                                (br_if $case52|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 52)
                                                                                 )
                                                                                )
                                                                                (br_if $case53|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 53)
                                                                                 )
                                                                                )
                                                                                (br_if $case54|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 54)
                                                                                 )
                                                                                )
                                                                                (br_if $case55|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 55)
                                                                                 )
                                                                                )
                                                                                (br_if $case56|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 56)
                                                                                 )
                                                                                )
                                                                                (br_if $case57|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 57)
                                                                                 )
                                                                                )
                                                                                (br_if $case58|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 58)
                                                                                 )
                                                                                )
                                                                                (br_if $case59|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 59)
                                                                                 )
                                                                                )
                                                                                (br_if $case60|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 60)
                                                                                 )
                                                                                )
                                                                                (br_if $case61|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 61)
                                                                                 )
                                                                                )
                                                                                (br_if $case62|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 62)
                                                                                 )
                                                                                )
                                                                                (br_if $case63|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 63)
                                                                                 )
                                                                                )
                                                                                (br_if $case64|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 64)
                                                                                 )
                                                                                )
                                                                                (br_if $case65|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 65)
                                                                                 )
                                                                                )
                                                                                (br_if $case66|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 66)
                                                                                 )
                                                                                )
                                                                                (br_if $case67|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 67)
                                                                                 )
                                                                                )
                                                                                (br_if $case68|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 68)
                                                                                 )
                                                                                )
                                                                                (br_if $case69|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 69)
                                                                                 )
                                                                                )
                                                                                (br_if $case70|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 70)
                                                                                 )
                                                                                )
                                                                                (br_if $case71|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 71)
                                                                                 )
                                                                                )
                                                                                (br_if $case72|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 72)
                                                                                 )
                                                                                )
                                                                                (br_if $case73|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 73)
                                                                                 )
                                                                                )
                                                                                (br_if $case74|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 74)
                                                                                 )
                                                                                )
                                                                                (br_if $case75|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 75)
                                                                                 )
                                                                                )
                                                                                (br_if $case76|0
                                                                                 (i32.eq
                                                                                  (i32.and
                                                                                   (local.get $1)
                                                                                   (i32.const 65535)
                                                                                  )
                                                                                  (i32.const 76)
                                                                                 )
                                                                                )
                                                                                (br $break|0)
                                                                               )
                                                                               (return
                                                                                (i32.const 256)
                                                                               )
                                                                              )
                                                                              (return
                                                                               (i32.const 304)
                                                                              )
                                                                             )
                                                                             (return
                                                                              (i32.const 336)
                                                                             )
                                                                            )
                                                                            (return
                                                                             (i32.const 368)
                                                                            )
                                                                           )
                                                                           (return
                                                                            (i32.const 416)
                                                                           )
                                                                          )
                                                                          (return
                                                                           (i32.const 464)
                                                                          )
                                                                         )
                                                                         (return
                                                                          (i32.const 512)
                                                                         )
                                                                        )
                                                                        (return
                                                                         (i32.const 544)
                                                                        )
                                                                       )
                                                                       (return
                                                                        (i32.const 592)
                                                                       )
                                                                      )
                                                                      (return
                                                                       (i32.const 624)
                                                                      )
                                                                     )
                                                                     (return
                                                                      (i32.const 656)
                                                                     )
                                                                    )
                                                                    (return
                                                                     (i32.const 688)
                                                                    )
                                                                   )
                                                                   (return
                                                                    (i32.const 736)
                                                                   )
                                                                  )
                                                                  (return
                                                                   (i32.const 768)
                                                                  )
                                                                 )
                                                                 (return
                                                                  (i32.const 816)
                                                                 )
                                                                )
                                                                (return
                                                                 (i32.const 864)
                                                                )
                                                               )
                                                               (return
                                                                (i32.const 912)
                                                               )
                                                              )
                                                              (return
                                                               (i32.const 944)
                                                              )
                                                             )
                                                             (return
                                                              (i32.const 992)
                                                             )
                                                            )
                                                            (return
                                                             (i32.const 1024)
                                                            )
                                                           )
                                                           (return
                                                            (i32.const 1056)
                                                           )
                                                          )
                                                          (return
                                                           (i32.const 1088)
                                                          )
                                                         )
                                                         (return
                                                          (i32.const 1120)
                                                         )
                                                        )
                                                        (return
                                                         (i32.const 1152)
                                                        )
                                                       )
                                                       (return
                                                        (i32.const 1200)
                                                       )
                                                      )
                                                      (return
                                                       (i32.const 1232)
                                                      )
                                                     )
                                                     (return
                                                      (i32.const 1264)
                                                     )
                                                    )
                                                    (return
                                                     (i32.const 1312)
                                                    )
                                                   )
                                                   (return
                                                    (i32.const 1344)
                                                   )
                                                  )
                                                  (return
                                                   (i32.const 1376)
                                                  )
                                                 )
                                                 (return
                                                  (i32.const 1408)
                                                 )
                                                )
                                                (return
                                                 (i32.const 1440)
                                                )
                                               )
                                               (return
                                                (i32.const 1472)
                                               )
                                              )
                                              (return
                                               (i32.const 1504)
                                              )
                                             )
                                             (return
                                              (i32.const 1536)
                                             )
                                            )
                                            (return
                                             (i32.const 1568)
                                            )
                                           )
                                           (return
                                            (i32.const 1616)
                                           )
                                          )
                                          (return
                                           (i32.const 1664)
                                          )
                                         )
                                         (return
                                          (i32.const 1712)
                                         )
                                        )
                                        (return
                                         (i32.const 1760)
                                        )
                                       )
                                       (return
                                        (i32.const 1808)
                                       )
                                      )
                                      (return
                                       (i32.const 1856)
                                      )
                                     )
                                     (return
                                      (i32.const 1888)
                                     )
                                    )
                                    (return
                                     (i32.const 1920)
                                    )
                                   )
                                   (return
                                    (i32.const 1952)
                                   )
                                  )
                                  (return
                                   (i32.const 1984)
                                  )
                                 )
                                 (return
                                  (i32.const 2016)
                                 )
                                )
                                (return
                                 (i32.const 2048)
                                )
                               )
                               (return
                                (i32.const 2080)
                               )
                              )
                              (return
                               (i32.const 2112)
                              )
                             )
                             (return
                              (i32.const 2144)
                             )
                            )
                            (return
                             (i32.const 2192)
                            )
                           )
                           (return
                            (i32.const 2224)
                           )
                          )
                          (return
                           (i32.const 2256)
                          )
                         )
                         (return
                          (i32.const 2304)
                         )
                        )
                        (return
                         (i32.const 2336)
                        )
                       )
                       (return
                        (i32.const 2384)
                       )
                      )
                      (return
                       (i32.const 2432)
                      )
                     )
                     (return
                      (i32.const 2480)
                     )
                    )
                    (return
                     (i32.const 2512)
                    )
                   )
                   (return
                    (i32.const 2544)
                   )
                  )
                  (return
                   (i32.const 2576)
                  )
                 )
                 (return
                  (i32.const 2624)
                 )
                )
                (return
                 (i32.const 2672)
                )
               )
               (return
                (i32.const 2704)
               )
              )
              (return
               (i32.const 2736)
              )
             )
             (return
              (i32.const 2768)
             )
            )
            (return
             (i32.const 2816)
            )
           )
           (return
            (i32.const 2864)
           )
          )
          (return
           (i32.const 2896)
          )
         )
         (return
          (i32.const 2928)
         )
        )
        (return
         (i32.const 2960)
        )
       )
       (return
        (i32.const 2992)
       )
      )
      (return
       (i32.const 3024)
      )
     )
     (return
      (i32.const 3072)
     )
    )
    (return
     (i32.const 3104)
    )
   )
   (return
    (i32.const 3136)
   )
  )
  (return
   (i32.const 3184)
  )
 )
 (func $~lib/string/String.UTF8.byteLength (param $str i32) (param $nullTerminated i32) (result i32)
  (local $strOff i32)
  (local $strEnd i32)
  (local $bufLen i32)
  (local $c1 i32)
  (local.set $strOff
   (local.get $str)
  )
  (local.set $strEnd
   (i32.add
    (local.get $strOff)
    (call $~lib/rt/common/OBJECT#get:rtSize
     (i32.sub
      (local.get $str)
      (i32.const 20)
     )
    )
   )
  )
  (local.set $bufLen
   (i32.ne
    (local.get $nullTerminated)
    (i32.const 0)
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.lt_u
      (local.get $strOff)
      (local.get $strEnd)
     )
     (then
      (local.set $c1
       (i32.load16_u
        (local.get $strOff)
       )
      )
      (if
       (i32.lt_u
        (local.get $c1)
        (i32.const 128)
       )
       (then
        (if
         (i32.and
          (local.get $nullTerminated)
          (i32.eqz
           (local.get $c1)
          )
         )
         (then
          (br $while-break|0)
         )
        )
        (local.set $bufLen
         (i32.add
          (local.get $bufLen)
          (i32.const 1)
         )
        )
       )
       (else
        (if
         (i32.lt_u
          (local.get $c1)
          (i32.const 2048)
         )
         (then
          (local.set $bufLen
           (i32.add
            (local.get $bufLen)
            (i32.const 2)
           )
          )
         )
         (else
          (if
           (if (result i32)
            (i32.eq
             (i32.and
              (local.get $c1)
              (i32.const 64512)
             )
             (i32.const 55296)
            )
            (then
             (i32.lt_u
              (i32.add
               (local.get $strOff)
               (i32.const 2)
              )
              (local.get $strEnd)
             )
            )
            (else
             (i32.const 0)
            )
           )
           (then
            (if
             (i32.eq
              (i32.and
               (i32.load16_u offset=2
                (local.get $strOff)
               )
               (i32.const 64512)
              )
              (i32.const 56320)
             )
             (then
              (local.set $bufLen
               (i32.add
                (local.get $bufLen)
                (i32.const 4)
               )
              )
              (local.set $strOff
               (i32.add
                (local.get $strOff)
                (i32.const 4)
               )
              )
              (br $while-continue|0)
             )
            )
           )
          )
          (local.set $bufLen
           (i32.add
            (local.get $bufLen)
            (i32.const 3)
           )
          )
         )
        )
       )
      )
      (local.set $strOff
       (i32.add
        (local.get $strOff)
        (i32.const 2)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (return
   (local.get $bufLen)
  )
 )
 (func $~lib/rt/tlsf/Root#set:flMap (param $this i32) (param $flMap i32)
  (i32.store
   (local.get $this)
   (local.get $flMap)
  )
 )
 (func $~lib/rt/tlsf/SETTAIL (param $root i32) (param $tail i32)
  (i32.store offset=1568
   (local.get $root)
   (local.get $tail)
  )
 )
 (func $~lib/rt/tlsf/SETSL (param $root i32) (param $fl i32) (param $slMap i32)
  (i32.store offset=4
   (i32.add
    (local.get $root)
    (i32.shl
     (local.get $fl)
     (i32.const 2)
    )
   )
   (local.get $slMap)
  )
 )
 (func $~lib/rt/tlsf/SETHEAD (param $root i32) (param $fl i32) (param $sl i32) (param $head i32)
  (i32.store offset=96
   (i32.add
    (local.get $root)
    (i32.shl
     (i32.add
      (i32.shl
       (local.get $fl)
       (i32.const 4)
      )
      (local.get $sl)
     )
     (i32.const 2)
    )
   )
   (local.get $head)
  )
 )
 (func $~lib/rt/tlsf/GETTAIL (param $root i32) (result i32)
  (return
   (i32.load offset=1568
    (local.get $root)
   )
  )
 )
 (func $~lib/rt/common/BLOCK#get:mmInfo (param $this i32) (result i32)
  (i32.load
   (local.get $this)
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
 (func $~lib/rt/tlsf/GETRIGHT (param $block i32) (result i32)
  (return
   (i32.add
    (i32.add
     (local.get $block)
     (i32.const 4)
    )
    (i32.and
     (call $~lib/rt/common/BLOCK#get:mmInfo
      (local.get $block)
     )
     (i32.xor
      (i32.const 3)
      (i32.const -1)
     )
    )
   )
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
 (func $~lib/rt/tlsf/GETHEAD (param $root i32) (param $fl i32) (param $sl i32) (result i32)
  (return
   (i32.load offset=96
    (i32.add
     (local.get $root)
     (i32.shl
      (i32.add
       (i32.shl
        (local.get $fl)
        (i32.const 4)
       )
       (local.get $sl)
      )
      (i32.const 2)
     )
    )
   )
  )
 )
 (func $~lib/rt/tlsf/GETSL (param $root i32) (param $fl i32) (result i32)
  (return
   (i32.load offset=4
    (i32.add
     (local.get $root)
     (i32.shl
      (local.get $fl)
      (i32.const 2)
     )
    )
   )
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
  (local $slMap i32)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 245)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 247)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 261)
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
    (call $~lib/rt/tlsf/GETHEAD
     (local.get $root)
     (local.get $fl)
     (local.get $sl)
    )
   )
   (then
    (call $~lib/rt/tlsf/SETHEAD
     (local.get $root)
     (local.get $fl)
     (local.get $sl)
     (local.get $next)
    )
    (if
     (i32.eqz
      (local.get $next)
     )
     (then
      (local.set $slMap
       (call $~lib/rt/tlsf/GETSL
        (local.get $root)
        (local.get $fl)
       )
      )
      (call $~lib/rt/tlsf/SETSL
       (local.get $root)
       (local.get $fl)
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
 (func $~lib/rt/tlsf/GETFREELEFT (param $block i32) (result i32)
  (return
   (i32.load
    (i32.sub
     (local.get $block)
     (i32.const 4)
    )
   )
  )
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
  (drop
   (i32.const 1)
  )
  (if
   (i32.eqz
    (local.get $block)
   )
   (then
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 178)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 180)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $right
   (call $~lib/rt/tlsf/GETRIGHT
    (local.get $block)
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
     (call $~lib/rt/tlsf/GETRIGHT
      (local.get $block)
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
     (call $~lib/rt/tlsf/GETFREELEFT
      (local.get $block)
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
      (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
       (i32.const 0)
       (i32.const 3344)
       (i32.const 198)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 210)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 211)
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
      (local.tee $10
       (local.get $size)
      )
      (local.tee $11
       (i32.const 1073741820)
      )
      (i32.lt_u
       (local.get $10)
       (local.get $11)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 228)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $head
   (call $~lib/rt/tlsf/GETHEAD
    (local.get $root)
    (local.get $fl)
    (local.get $sl)
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
  (call $~lib/rt/tlsf/SETHEAD
   (local.get $root)
   (local.get $fl)
   (local.get $sl)
   (local.get $block)
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
  (call $~lib/rt/tlsf/SETSL
   (local.get $root)
   (local.get $fl)
   (i32.or
    (call $~lib/rt/tlsf/GETSL
     (local.get $root)
     (local.get $fl)
    )
    (i32.shl
     (i32.const 1)
     (local.get $sl)
    )
   )
  )
 )
 (func $~lib/rt/tlsf/addMemory (param $root i32) (param $start i32) (param $endU64 i64) (result i32)
  (local $end i32)
  (local $tail i32)
  (local $tailInfo i32)
  (local $size i32)
  (local $leftSize i32)
  (local $left i32)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 357)
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
   (call $~lib/rt/tlsf/GETTAIL
    (local.get $root)
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
      (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
       (i32.const 0)
       (i32.const 3344)
       (i32.const 365)
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
      (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
       (i32.const 0)
       (i32.const 3344)
       (i32.const 378)
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
  (call $~lib/rt/tlsf/SETTAIL
   (local.get $root)
   (local.get $tail)
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
  (local $fl i32)
  (local $sl i32)
  (local $memStart i32)
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
  (call $~lib/rt/tlsf/SETTAIL
   (local.get $root)
   (i32.const 0)
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
     (call $~lib/rt/tlsf/SETSL
      (local.get $root)
      (local.get $fl)
      (i32.const 0)
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
        (call $~lib/rt/tlsf/SETHEAD
         (local.get $root)
         (local.get $fl)
         (local.get $sl)
         (i32.const 0)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 3408)
     (i32.const 3344)
     (i32.const 435)
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
  (local $slMap i32)
  (local $head i32)
  (local $flMap i32)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 309)
     (i32.const 14)
    )
    (unreachable)
   )
  )
  (local.set $slMap
   (i32.and
    (call $~lib/rt/tlsf/GETSL
     (local.get $root)
     (local.get $fl)
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
       (call $~lib/rt/tlsf/GETSL
        (local.get $root)
        (local.get $fl)
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
        (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
         (i32.const 0)
         (i32.const 3344)
         (i32.const 322)
         (i32.const 18)
        )
        (unreachable)
       )
      )
      (local.set $head
       (call $~lib/rt/tlsf/GETHEAD
        (local.get $root)
        (local.get $fl)
        (i32.ctz
         (local.get $slMap)
        )
       )
      )
     )
    )
   )
   (else
    (local.set $head
     (call $~lib/rt/tlsf/GETHEAD
      (local.get $root)
      (local.get $fl)
      (i32.ctz
       (local.get $slMap)
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
  (local $pagesNeeded i32)
  (local $4 i32)
  (local $5 i32)
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
      (call $~lib/rt/tlsf/GETTAIL
       (local.get $root)
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
    (local.tee $4
     (local.get $pagesBefore)
    )
    (local.tee $5
     (local.get $pagesNeeded)
    )
    (i32.gt_s
     (local.get $4)
     (local.get $5)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 336)
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
     (call $~lib/rt/tlsf/GETRIGHT
      (local.get $block)
     )
     (i32.and
      (call $~lib/rt/common/BLOCK#get:mmInfo
       (call $~lib/rt/tlsf/GETRIGHT
        (local.get $block)
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
      (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
       (i32.const 0)
       (i32.const 3344)
       (i32.const 472)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 474)
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
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3344)
     (i32.const 532)
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
 (func $~lib/wasi_snapshot_preview1/wasi_process/writeString (param $fd i32) (param $data i32)
  (local $len i32)
  (local $char2 i32)
  (local $char3 i32)
  (local $char4 i32)
  (local $6 i32)
  (local $char1 i32)
  (local $err i32)
  (local $utf8len i32)
  (local $utf8buf i32)
  (local $err|11 i32)
  (local.set $len
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (local.get $data)
    )
   )
  )
  (local.set $char2
   (i32.const 0)
  )
  (local.set $char3
   (i32.const 0)
  )
  (local.set $char4
   (i32.const 0)
  )
  (block $break|0
   (block $case4|0
    (block $case3|0
     (block $case2|0
      (block $case1|0
       (block $case0|0
        (local.set $6
         (local.get $len)
        )
        (br_if $case0|0
         (i32.eq
          (local.get $6)
          (i32.const 4)
         )
        )
        (br_if $case1|0
         (i32.eq
          (local.get $6)
          (i32.const 3)
         )
        )
        (br_if $case2|0
         (i32.eq
          (local.get $6)
          (i32.const 2)
         )
        )
        (br_if $case3|0
         (i32.eq
          (local.get $6)
          (i32.const 1)
         )
        )
        (br_if $case4|0
         (i32.eq
          (local.get $6)
          (i32.const 0)
         )
        )
        (br $break|0)
       )
       (block
        (local.set $char4
         (i32.load16_u offset=6
          (local.get $data)
         )
        )
        (if
         (i32.ge_u
          (local.get $char4)
          (i32.const 128)
         )
         (then
          (br $break|0)
         )
        )
       )
      )
      (block
       (local.set $char3
        (i32.load16_u offset=4
         (local.get $data)
        )
       )
       (if
        (i32.ge_u
         (local.get $char3)
         (i32.const 128)
        )
        (then
         (br $break|0)
        )
       )
      )
     )
     (block
      (local.set $char2
       (i32.load16_u offset=2
        (local.get $data)
       )
      )
      (if
       (i32.ge_u
        (local.get $char2)
        (i32.const 128)
       )
       (then
        (br $break|0)
       )
      )
     )
    )
    (block
     (local.set $char1
      (i32.load16_u
       (local.get $data)
      )
     )
     (if
      (i32.ge_u
       (local.get $char1)
       (i32.const 128)
      )
      (then
       (br $break|0)
      )
     )
     (i32.store
      (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
      (i32.add
       (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
       (i32.mul
        (i32.const 2)
        (i32.const 4)
       )
      )
     )
     (i32.store offset=4
      (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
      (local.get $len)
     )
     (i32.store offset=8
      (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
      (i32.or
       (i32.or
        (i32.or
         (local.get $char1)
         (i32.shl
          (local.get $char2)
          (i32.const 8)
         )
        )
        (i32.shl
         (local.get $char3)
         (i32.const 16)
        )
       )
       (i32.shl
        (local.get $char4)
        (i32.const 24)
       )
      )
     )
     (local.set $err
      (call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/fd_write
       (local.get $fd)
       (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
       (i32.const 1)
       (i32.add
        (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
        (i32.mul
         (i32.const 3)
         (i32.const 4)
        )
       )
      )
     )
     (if
      (i32.and
       (local.get $err)
       (i32.const 65535)
      )
      (then
       (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
        (call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/errnoToString
         (local.get $err)
        )
        (i32.const 3232)
        (i32.const 178)
        (i32.const 16)
       )
       (unreachable)
      )
     )
    )
   )
   (return)
  )
  (local.set $utf8len
   (call $~lib/string/String.UTF8.byteLength
    (call $~lib/rt/__tmptostack
     (local.get $data)
    )
    (i32.const 0)
   )
  )
  (local.set $utf8buf
   (call $~lib/rt/tlsf/__alloc
    (local.get $utf8len)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/string/String.UTF8.encodeUnsafe@varargs
      (local.get $data)
      (local.get $len)
      (local.get $utf8buf)
      (i32.const 0)
      (block (result i32)
       (global.set $~argumentsLength
        (i32.const 3)
       )
       (i32.const 0)
      )
     )
     (local.get $utf8len)
    )
   )
   (then
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (i32.const 0)
     (i32.const 3232)
     (i32.const 185)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (i32.store
   (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
   (local.get $utf8buf)
  )
  (i32.store offset=4
   (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
   (local.get $utf8len)
  )
  (local.set $err|11
   (call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/fd_write
    (local.get $fd)
    (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
    (i32.const 1)
    (i32.add
     (global.get $~lib/wasi_snapshot_preview1/wasi_internal/tempbuf)
     (i32.mul
      (i32.const 2)
      (i32.const 4)
     )
    )
   )
  )
  (call $~lib/rt/tlsf/__free
   (local.get $utf8buf)
  )
  (if
   (i32.and
    (local.get $err|11)
    (i32.const 65535)
   )
   (then
    (call $~lib/wasi_snapshot_preview1/wasi_internal/wasi_abort
     (call $~lib/wasi_snapshot_preview1/bindings/wasi_snapshot_preview1/errnoToString
      (local.get $err|11)
     )
     (i32.const 3232)
     (i32.const 190)
     (i32.const 12)
    )
    (unreachable)
   )
  )
 )
 (func $~lib/wasi_snapshot_preview1/wasi_process/WritableStream#write<~lib/string/String> (param $this i32) (param $data i32)
  (drop
   (i32.const 1)
  )
  (call $~lib/wasi_snapshot_preview1/wasi_process/writeString
   (local.get $this)
   (call $~lib/rt/__tmptostack
    (local.get $data)
   )
  )
 )
 (func $~lib/wasi_snapshot_preview1/wasi_console/wasi_console.log (param $message i32)
  (local $stdout i32)
  (local.set $stdout
   (global.get $~lib/wasi_snapshot_preview1/wasi_process/wasi_process.stdout)
  )
  (call $~lib/wasi_snapshot_preview1/wasi_process/WritableStream#write<~lib/string/String>
   (local.get $stdout)
   (call $~lib/rt/__tmptostack
    (local.get $message)
   )
  )
  (call $~lib/wasi_snapshot_preview1/wasi_process/WritableStream#write<~lib/string/String>
   (local.get $stdout)
   (i32.const 3472)
  )
 )
 (func $start:host/wasi_preview1
  (call $~lib/wasi_snapshot_preview1/wasi_console/wasi_console.log
   (i32.const 32)
  )
 )
 (func $~start
  (call $start:host/wasi_preview1)
 )
)
