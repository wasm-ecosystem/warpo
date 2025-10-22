(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32)))
 (type $3 (func (param i32 i32) (result i32)))
 (type $4 (func))
 (type $5 (func (param i32 i32 i32)))
 (type $6 (func (param i32 i32 i32) (result i32)))
 (type $7 (func (param i32 i32 i32 i32)))
 (type $8 (func (param i32 i32 i64) (result i32)))
 (type $9 (func (result i32)))
 (type $10 (func (param i32 i32 i32 i32 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Minimal i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/util/uri/URL_UNSAFE i32 (i32.const 44))
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
 (global $~lib/util/uri/URI_UNSAFE i32 (i32.const 2364))
 (global $~lib/util/uri/URI_RESERVED i32 (i32.const 2572))
 (global $~lib/rt/__rtti_base i32 (i32.const 3312))
 (global $~lib/memory/__data_end i32 (i32.const 3332))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 36100))
 (global $~lib/memory/__heap_base i32 (i32.const 36100))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "\00\01\01\01\01\01\00\00\00\00\01\01\00\00\01\00\00\00\00\00\00\00\00\00\00\01\01\01\01\01\01\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\01\01\01\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\01\01\00")
 (data $2 (i32.const 140) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $3 (i32.const 204) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 272) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 304) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 332) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $7 (i32.const 396) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 448) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 476) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $10 (i32.const 540) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00U\00R\00I\00 \00m\00a\00l\00f\00o\00r\00m\00e\00d\00\00\00")
 (data $11 (i32.const 588) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00u\00t\00i\00l\00/\00u\00r\00i\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $12 (i32.const 652) "0123456789ABCDEF")
 (data $13 (i32.const 668) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00s\00t\00d\00/\00u\00r\00i\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $14 (i32.const 716) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00a\00\00\00\00\00\00\00\00\00\00\00")
 (data $15 (i32.const 748) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00a\001\00\00\00\00\00\00\00\00\00")
 (data $16 (i32.const 780) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00a\00b\00_\00\00\00\00\00\00\00")
 (data $17 (i32.const 812) "\\\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00H\00\00\00A\00B\00C\00D\00X\00Y\00Z\00a\00f\00g\00k\00l\00m\00n\00w\00y\00z\000\001\002\003\004\005\006\007\008\009\00-\00_\00.\00!\00~\00*\00\'\00(\00)\00\00\00\00\00")
 (data $18 (i32.const 908) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $19 (i32.const 940) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00%\000\000\00\00\00\00\00\00\00")
 (data $20 (i32.const 972) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00+\00\00\00\00\00\00\00\00\00\00\00")
 (data $21 (i32.const 1004) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00%\002\00B\00\00\00\00\00\00\00")
 (data $22 (i32.const 1036) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00#\000\00=\00\00\00\00\00\00\00")
 (data $23 (i32.const 1068) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00%\002\003\000\00%\003\00D\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $24 (i32.const 1116) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00 \001\002\003\00 \00\00\00")
 (data $25 (i32.const 1148) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00%\002\000\001\002\003\00%\002\000\00\00\00\00\00\00\00\00\00\00\00")
 (data $26 (i32.const 1196) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00?\00+\00\00\00\00\00\00\00\00\00")
 (data $27 (i32.const 1228) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00%\003\00F\00%\002\00B\00")
 (data $28 (i32.const 1260) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00-\00?\001\00.\00-\00\00\00")
 (data $29 (i32.const 1292) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00-\00%\003\00F\001\00.\00-\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $30 (i32.const 1340) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00<\d8\ed\dd<\d8\fa\dd<\d8N\df")
 (data $31 (i32.const 1372) "\\\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00H\00\00\00%\00F\000\00%\009\00F\00%\008\007\00%\00A\00D\00%\00F\000\00%\009\00F\00%\008\007\00%\00B\00A\00%\00F\000\00%\009\00F\00%\008\00D\00%\008\00E\00\00\00\00\00")
 (data $32 (i32.const 1468) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00H\c5U\b1X\d58\c1\94\c6\00\00")
 (data $33 (i32.const 1500) "l\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00Z\00\00\00%\00E\00C\00%\009\005\00%\008\008\00%\00E\00B\00%\008\005\00%\009\005\00%\00E\00D\00%\009\005\00%\009\008\00%\00E\00C\00%\008\004\00%\00B\008\00%\00E\00C\00%\009\00A\00%\009\004\00\00\00")
 (data $34 (i32.const 1612) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00~\00\7f\00\80\00\00\00\00\00\00\00")
 (data $35 (i32.const 1644) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00%\007\00F\00%\00C\002\00%\008\000\00\00\00\00\00\00\00\00\00")
 (data $36 (i32.const 1692) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00\00\d8\ff\df\00\00\00\00\00\00\00\00")
 (data $37 (i32.const 1724) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\18\00\00\00%\00F\000\00%\009\000\00%\008\00F\00%\00B\00F\00\00\00\00\00")
 (data $38 (i32.const 1772) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00{\da\01\dc-\00P\da\02\dc\00\00")
 (data $39 (i32.const 1804) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\002\00\00\00%\00F\002\00%\00A\00E\00%\00B\000\00%\008\001\00-\00%\00F\002\00%\00A\004\00%\008\000\00%\008\002\00\00\00\00\00\00\00\00\00\00\00")
 (data $40 (i32.const 1884) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00\n\00\t\00\0b\00\0c\00\r\00\00\00")
 (data $41 (i32.const 1916) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00%\000\00A\00%\000\009\00%\000\00B\00%\000\00C\00%\000\00D\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $42 (i32.const 1980) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00;\00/\00?\00:\00@\00&\00=\00+\00$\00,\00\00\00\00\00\00\00\00\00")
 (data $43 (i32.const 2028) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00<\00\00\00%\003\00B\00%\002\00F\00%\003\00F\00%\003\00A\00%\004\000\00%\002\006\00%\003\00D\00%\002\00B\00%\002\004\00%\002\00C\00")
 (data $44 (i32.const 2108) "l\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\\\00\00\00h\00t\00t\00p\00:\00/\00/\00e\00n\00.\00w\00i\00k\00i\00p\00e\00d\00i\00a\00.\00o\00r\00g\00/\00w\00i\00k\00i\00/\00U\00T\00F\00-\008\00#\00D\00e\00s\00c\00r\00i\00p\00t\00i\00o\00n\00")
 (data $45 (i32.const 2220) "\8c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00t\00\00\00h\00t\00t\00p\00%\003\00A\00%\002\00F\00%\002\00F\00e\00n\00.\00w\00i\00k\00i\00p\00e\00d\00i\00a\00.\00o\00r\00g\00%\002\00F\00w\00i\00k\00i\00%\002\00F\00U\00T\00F\00-\008\00%\002\003\00D\00e\00s\00c\00r\00i\00p\00t\00i\00o\00n\00\00\00\00\00\00\00\00\00")
 (data $46 (i32.const 2364) "\00\01\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\01\01\01\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\01\01\01\00")
 (data $47 (i32.const 2460) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00;\00,\00/\00?\00:\00@\00&\00=\00+\00$\00#\00\00\00\00\00\00\00")
 (data $48 (i32.const 2508) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00 \00\00\00\00\00\00\00\00\00\00\00")
 (data $49 (i32.const 2540) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00%\002\000\00\00\00\00\00\00\00")
 (data $50 (i32.const 2572) "\01\01\00\01\00\00\00\00\01\01\00\00\01\00\00\00\00\00\00\00\00\00\00\01\01\00\01\00\01\01")
 (data $51 (i32.const 2604) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00%\002\006\00\00\00\00\00\00\00")
 (data $52 (i32.const 2636) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00&\00\00\00\00\00\00\00\00\00\00\00")
 (data $53 (i32.const 2668) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00%\005\00E\00\00\00\00\00\00\00")
 (data $54 (i32.const 2700) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00^\00\00\00\00\00\00\00\00\00\00\00")
 (data $55 (i32.const 2732) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00\00\d8\00\00\00\00\00\00\00\00\00\00")
 (data $56 (i32.const 2764) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00<\00\00\00%\003\00b\00%\002\00f\00%\003\00f\00%\003\00a\00%\004\000\00%\003\00d\00%\002\00b\00%\002\004\00%\002\00c\00%\002\003\00")
 (data $57 (i32.const 2844) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00;\00/\00?\00:\00@\00=\00+\00$\00,\00#\00\00\00\00\00\00\00\00\00")
 (data $58 (i32.const 2892) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00<\00\00\00%\003\00B\00%\002\00F\00%\003\00F\00%\003\00A\00%\004\000\00%\003\00D\00%\002\00B\00%\002\004\00%\002\00C\00%\002\003\00")
 (data $59 (i32.const 2972) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00h\00\00\00h\00t\00t\00p\00:\00%\002\00F\00%\002\00F\00e\00n\00.\00w\00i\00k\00i\00p\00e\00d\00i\00a\00.\00o\00r\00g\00/\00w\00i\00k\00i\00/\00U\00T\00F\00-\008\00%\002\003\00D\00e\00s\00c\00r\00i\00p\00t\00i\00o\00n\00\00\00\00\00")
 (data $60 (i32.const 3100) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00%\00D\00F\00%\008\000\00")
 (data $61 (i32.const 3132) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00\c0\07\00\00\00\00\00\00\00\00\00\00")
 (data $62 (i32.const 3164) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00%\00C\002\00%\00B\00F\00")
 (data $63 (i32.const 3196) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00\bf\00\00\00\00\00\00\00\00\00\00\00")
 (data $64 (i32.const 3228) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00\f7\00\b8\00W\00\ef\00\0f\00\f4\00V\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $65 (i32.const 3276) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00\f4\00\b8\00\ef\00\00\00\00\00\00\00")
 (data $66 (i32.const 3312) "\04\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00")
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
         (i32.const 224)
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
       (i32.const 224)
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
     (i32.const 224)
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
     (i32.const 352)
     (i32.const 416)
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
        (i32.const 224)
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
     (i32.const 496)
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
     (i32.const 496)
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
     (i32.const 496)
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
     (i32.const 496)
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
     (i32.const 496)
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
       (i32.const 496)
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
     (i32.const 496)
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
     (i32.const 496)
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
     (i32.const 496)
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
     (i32.const 496)
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
       (i32.const 496)
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
       (i32.const 496)
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
     (i32.const 496)
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
         (i32.const 224)
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
     (i32.const 160)
     (i32.const 496)
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
     (i32.const 496)
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
         (i32.const 496)
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
     (i32.const 496)
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
       (i32.const 496)
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
     (i32.const 496)
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
     (i32.const 160)
     (i32.const 224)
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
 (func $~lib/util/uri/storeHex (param $dst i32) (param $offset i32) (param $ch i32)
  (i32.store16
   (i32.add
    (local.get $dst)
    (local.get $offset)
   )
   (i32.const 37)
  )
  (i32.store offset=2
   (i32.add
    (local.get $dst)
    (local.get $offset)
   )
   (i32.or
    (i32.load8_u
     (i32.add
      (i32.const 652)
      (i32.and
       (i32.shr_u
        (local.get $ch)
        (i32.const 4)
       )
       (i32.const 15)
      )
     )
    )
    (i32.shl
     (i32.load8_u
      (i32.add
       (i32.const 652)
       (i32.and
        (local.get $ch)
        (i32.const 15)
       )
      )
     )
     (i32.const 16)
    )
   )
  )
 )
 (func $~lib/util/uri/encode (param $src i32) (param $len i32) (param $table i32) (result i32)
  (local $i i32)
  (local $offset i32)
  (local $outSize i32)
  (local $dst i32)
  (local $org i32)
  (local $c i32)
  (local $c1 i32)
  (local $size i32)
  (local $estSize i32)
  (if
   (i32.eqz
    (local.get $len)
   )
   (then
    (return
     (local.get $src)
    )
   )
  )
  (local.set $i
   (i32.const 0)
  )
  (local.set $offset
   (i32.const 0)
  )
  (local.set $outSize
   (i32.shl
    (local.get $len)
    (i32.const 1)
   )
  )
  (local.set $dst
   (call $~lib/rt/itcms/__new
    (local.get $outSize)
    (i32.const 2)
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.lt_u
      (local.get $i)
      (local.get $len)
     )
     (then
      (local.set $org
       (local.get $i)
      )
      (block $do-break|1
       (loop $do-loop|1
        (local.set $c
         (i32.load16_u
          (i32.add
           (local.get $src)
           (i32.shl
            (local.get $i)
            (i32.const 1)
           )
          )
         )
        )
        (if
         (i32.lt_u
          (i32.sub
           (local.get $c)
           (i32.const 33)
          )
          (i32.const 94)
         )
         (then
          (if
           (i32.load8_u
            (i32.add
             (local.get $table)
             (i32.sub
              (local.get $c)
              (i32.const 33)
             )
            )
           )
           (then
            (br $do-break|1)
           )
          )
         )
         (else
          (br $do-break|1)
         )
        )
        (br_if $do-loop|1
         (i32.lt_u
          (local.tee $i
           (i32.add
            (local.get $i)
            (i32.const 1)
           )
          )
          (local.get $len)
         )
        )
       )
      )
      (if
       (i32.gt_u
        (local.get $i)
        (local.get $org)
       )
       (then
        (local.set $size
         (i32.shl
          (i32.sub
           (local.get $i)
           (local.get $org)
          )
          (i32.const 1)
         )
        )
        (if
         (i32.gt_u
          (i32.add
           (local.get $offset)
           (local.get $size)
          )
          (local.get $outSize)
         )
         (then
          (local.set $outSize
           (i32.add
            (local.get $offset)
            (local.get $size)
           )
          )
          (local.set $dst
           (call $~lib/rt/itcms/__renew
            (local.get $dst)
            (local.get $outSize)
           )
          )
         )
        )
        (memory.copy
         (i32.add
          (local.get $dst)
          (local.get $offset)
         )
         (i32.add
          (local.get $src)
          (i32.shl
           (local.get $org)
           (i32.const 1)
          )
         )
         (local.get $size)
        )
        (local.set $offset
         (i32.add
          (local.get $offset)
          (local.get $size)
         )
        )
        (if
         (i32.ge_u
          (local.get $i)
          (local.get $len)
         )
         (then
          (br $while-break|0)
         )
        )
       )
      )
      (if
       (i32.ge_u
        (local.get $c)
        (i32.const 55296)
       )
       (then
        (if
         (if (result i32)
          (i32.ge_u
           (local.get $c)
           (i32.const 56320)
          )
          (then
           (i32.le_u
            (local.get $c)
            (i32.const 57343)
           )
          )
          (else
           (i32.const 0)
          )
         )
         (then
          (call $~lib/builtins/abort
           (i32.const 560)
           (i32.const 608)
           (i32.const 81)
           (i32.const 9)
          )
          (unreachable)
         )
        )
        (if
         (i32.le_u
          (local.get $c)
          (i32.const 56319)
         )
         (then
          (if
           (i32.ge_u
            (local.get $i)
            (local.get $len)
           )
           (then
            (call $~lib/builtins/abort
             (i32.const 560)
             (i32.const 608)
             (i32.const 85)
             (i32.const 11)
            )
            (unreachable)
           )
          )
          (local.set $c1
           (i32.load16_u
            (i32.add
             (local.get $src)
             (i32.shl
              (local.tee $i
               (i32.add
                (local.get $i)
                (i32.const 1)
               )
              )
              (i32.const 1)
             )
            )
           )
          )
          (if
           (if (result i32)
            (i32.lt_u
             (local.get $c1)
             (i32.const 56320)
            )
            (then
             (i32.const 1)
            )
            (else
             (i32.gt_u
              (local.get $c1)
              (i32.const 57343)
             )
            )
           )
           (then
            (call $~lib/builtins/abort
             (i32.const 560)
             (i32.const 608)
             (i32.const 89)
             (i32.const 11)
            )
            (unreachable)
           )
          )
          (local.set $c
           (i32.add
            (i32.or
             (i32.shl
              (i32.and
               (local.get $c)
               (i32.const 1023)
              )
              (i32.const 10)
             )
             (i32.and
              (local.get $c1)
              (i32.const 1023)
             )
            )
            (i32.const 65536)
           )
          )
         )
        )
       )
      )
      (local.set $estSize
       (i32.add
        (local.get $offset)
        (if (result i32)
         (i32.lt_u
          (local.get $c)
          (i32.const 128)
         )
         (then
          (i32.mul
           (i32.const 1)
           (i32.const 6)
          )
         )
         (else
          (i32.mul
           (i32.const 4)
           (i32.const 6)
          )
         )
        )
       )
      )
      (if
       (i32.gt_u
        (local.get $estSize)
        (local.get $outSize)
       )
       (then
        (local.set $outSize
         (if (result i32)
          (i32.gt_u
           (local.get $len)
           (i32.const 1)
          )
          (then
           (i32.shl
            (local.get $estSize)
            (i32.const 1)
           )
          )
          (else
           (local.get $estSize)
          )
         )
        )
        (local.set $dst
         (call $~lib/rt/itcms/__renew
          (local.get $dst)
          (local.get $outSize)
         )
        )
       )
      )
      (if
       (i32.lt_u
        (local.get $c)
        (i32.const 128)
       )
       (then
        (call $~lib/util/uri/storeHex
         (local.get $dst)
         (local.get $offset)
         (local.get $c)
        )
        (local.set $offset
         (i32.add
          (local.get $offset)
          (i32.const 6)
         )
        )
       )
       (else
        (if
         (i32.lt_u
          (local.get $c)
          (i32.const 2048)
         )
         (then
          (call $~lib/util/uri/storeHex
           (local.get $dst)
           (local.get $offset)
           (i32.or
            (i32.shr_u
             (local.get $c)
             (i32.const 6)
            )
            (i32.const 192)
           )
          )
          (local.set $offset
           (i32.add
            (local.get $offset)
            (i32.const 6)
           )
          )
         )
         (else
          (if
           (i32.lt_u
            (local.get $c)
            (i32.const 65536)
           )
           (then
            (call $~lib/util/uri/storeHex
             (local.get $dst)
             (local.get $offset)
             (i32.or
              (i32.shr_u
               (local.get $c)
               (i32.const 12)
              )
              (i32.const 224)
             )
            )
            (local.set $offset
             (i32.add
              (local.get $offset)
              (i32.const 6)
             )
            )
           )
           (else
            (call $~lib/util/uri/storeHex
             (local.get $dst)
             (local.get $offset)
             (i32.or
              (i32.shr_u
               (local.get $c)
               (i32.const 18)
              )
              (i32.const 240)
             )
            )
            (local.set $offset
             (i32.add
              (local.get $offset)
              (i32.const 6)
             )
            )
            (call $~lib/util/uri/storeHex
             (local.get $dst)
             (local.get $offset)
             (i32.or
              (i32.and
               (i32.shr_u
                (local.get $c)
                (i32.const 12)
               )
               (i32.const 63)
              )
              (i32.const 128)
             )
            )
            (local.set $offset
             (i32.add
              (local.get $offset)
              (i32.const 6)
             )
            )
           )
          )
          (call $~lib/util/uri/storeHex
           (local.get $dst)
           (local.get $offset)
           (i32.or
            (i32.and
             (i32.shr_u
              (local.get $c)
              (i32.const 6)
             )
             (i32.const 63)
            )
            (i32.const 128)
           )
          )
          (local.set $offset
           (i32.add
            (local.get $offset)
            (i32.const 6)
           )
          )
         )
        )
        (call $~lib/util/uri/storeHex
         (local.get $dst)
         (local.get $offset)
         (i32.or
          (i32.and
           (local.get $c)
           (i32.const 63)
          )
          (i32.const 128)
         )
        )
        (local.set $offset
         (i32.add
          (local.get $offset)
          (i32.const 6)
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
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (i32.gt_u
    (local.get $outSize)
    (local.get $offset)
   )
   (then
    (local.set $dst
     (call $~lib/rt/itcms/__renew
      (local.get $dst)
      (local.get $offset)
     )
    )
   )
  )
  (return
   (local.get $dst)
  )
 )
 (func $~lib/uri/encodeURIComponent (param $str i32) (result i32)
  (return
   (call $~lib/util/uri/encode
    (local.get $str)
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $str)
     )
    )
    (global.get $~lib/util/uri/URL_UNSAFE)
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
 (func $~lib/uri/encodeURI (param $str i32) (result i32)
  (return
   (call $~lib/util/uri/encode
    (local.get $str)
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $str)
     )
    )
    (global.get $~lib/util/uri/URI_UNSAFE)
   )
  )
 )
 (func $~lib/util/uri/loadHex (param $src i32) (param $offset i32) (result i32)
  (local $c0 i32)
  (local $c1 i32)
  (local $ch i32)
  (local $ch|5 i32)
  (local $ch|6 i32)
  (local $ch|7 i32)
  (local.set $c0
   (i32.load16_u
    (i32.add
     (local.get $src)
     (local.get $offset)
    )
   )
  )
  (local.set $c1
   (i32.load16_u offset=2
    (i32.add
     (local.get $src)
     (local.get $offset)
    )
   )
  )
  (return
   (if (result i32)
    (if (result i32)
     (block $~lib/util/uri/isHex|inlined.0 (result i32)
      (local.set $ch
       (local.get $c0)
      )
      (br $~lib/util/uri/isHex|inlined.0
       (if (result i32)
        (i32.lt_u
         (i32.sub
          (local.get $ch)
          (i32.const 48)
         )
         (i32.const 10)
        )
        (then
         (i32.const 1)
        )
        (else
         (i32.lt_u
          (i32.sub
           (i32.or
            (local.get $ch)
            (i32.const 32)
           )
           (i32.const 97)
          )
          (i32.const 6)
         )
        )
       )
      )
     )
     (then
      (block $~lib/util/uri/isHex|inlined.1 (result i32)
       (local.set $ch|5
        (local.get $c1)
       )
       (br $~lib/util/uri/isHex|inlined.1
        (if (result i32)
         (i32.lt_u
          (i32.sub
           (local.get $ch|5)
           (i32.const 48)
          )
          (i32.const 10)
         )
         (then
          (i32.const 1)
         )
         (else
          (i32.lt_u
           (i32.sub
            (i32.or
             (local.get $ch|5)
             (i32.const 32)
            )
            (i32.const 97)
           )
           (i32.const 6)
          )
         )
        )
       )
      )
     )
     (else
      (i32.const 0)
     )
    )
    (then
     (i32.or
      (i32.shl
       (block $~lib/util/uri/fromHex|inlined.0 (result i32)
        (local.set $ch|6
         (local.get $c0)
        )
        (br $~lib/util/uri/fromHex|inlined.0
         (i32.sub
          (i32.rem_u
           (i32.or
            (local.get $ch|6)
            (i32.const 32)
           )
           (i32.const 39)
          )
          (i32.const 9)
         )
        )
       )
       (i32.const 4)
      )
      (block $~lib/util/uri/fromHex|inlined.1 (result i32)
       (local.set $ch|7
        (local.get $c1)
       )
       (br $~lib/util/uri/fromHex|inlined.1
        (i32.sub
         (i32.rem_u
          (i32.or
           (local.get $ch|7)
           (i32.const 32)
          )
          (i32.const 39)
         )
         (i32.const 9)
        )
       )
      )
     )
    )
    (else
     (i32.const -1)
    )
   )
  )
 )
 (func $~lib/util/uri/decode (param $src i32) (param $len i32) (param $component i32) (result i32)
  (local $i i32)
  (local $offset i32)
  (local $ch i32)
  (local $dst i32)
  (local $org i32)
  (local $size i32)
  (local $ch|9 i32)
  (local $c0 i32)
  (local $nb i32)
  (local $lo i32)
  (local $c1 i32)
  (local $lo|14 i32)
  (local $hi i32)
  (if
   (i32.eqz
    (local.get $len)
   )
   (then
    (return
     (local.get $src)
    )
   )
  )
  (local.set $i
   (i32.const 0)
  )
  (local.set $offset
   (i32.const 0)
  )
  (local.set $ch
   (i32.const 0)
  )
  (local.set $dst
   (call $~lib/rt/itcms/__new
    (i32.shl
     (local.get $len)
     (i32.const 1)
    )
    (i32.const 2)
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.lt_u
      (local.get $i)
      (local.get $len)
     )
     (then
      (local.set $org
       (local.get $i)
      )
      (block $while-break|1
       (loop $while-continue|1
        (if
         (if (result i32)
          (i32.lt_u
           (local.get $i)
           (local.get $len)
          )
          (then
           (i32.ne
            (local.tee $ch
             (i32.load16_u
              (i32.add
               (local.get $src)
               (i32.shl
                (local.get $i)
                (i32.const 1)
               )
              )
             )
            )
            (i32.const 37)
           )
          )
          (else
           (i32.const 0)
          )
         )
         (then
          (local.set $i
           (i32.add
            (local.get $i)
            (i32.const 1)
           )
          )
          (br $while-continue|1)
         )
        )
       )
      )
      (if
       (i32.gt_u
        (local.get $i)
        (local.get $org)
       )
       (then
        (local.set $size
         (i32.shl
          (i32.sub
           (local.get $i)
           (local.get $org)
          )
          (i32.const 1)
         )
        )
        (memory.copy
         (i32.add
          (local.get $dst)
          (local.get $offset)
         )
         (i32.add
          (local.get $src)
          (i32.shl
           (local.get $org)
           (i32.const 1)
          )
         )
         (local.get $size)
        )
        (local.set $offset
         (i32.add
          (local.get $offset)
          (local.get $size)
         )
        )
        (if
         (i32.ge_u
          (local.get $i)
          (local.get $len)
         )
         (then
          (br $while-break|0)
         )
        )
       )
      )
      (if
       (if (result i32)
        (if (result i32)
         (i32.ge_u
          (i32.add
           (local.get $i)
           (i32.const 2)
          )
          (local.get $len)
         )
         (then
          (i32.const 1)
         )
         (else
          (i32.ne
           (local.get $ch)
           (i32.const 37)
          )
         )
        )
        (then
         (i32.const 1)
        )
        (else
         (i32.eq
          (local.tee $ch
           (call $~lib/util/uri/loadHex
            (local.get $src)
            (i32.shl
             (i32.add
              (local.get $i)
              (i32.const 1)
             )
             (i32.const 1)
            )
           )
          )
          (i32.const -1)
         )
        )
       )
       (then
        (call $~lib/builtins/abort
         (i32.const 560)
         (i32.const 608)
         (i32.const 164)
         (i32.const 7)
        )
        (unreachable)
       )
      )
      (local.set $i
       (i32.add
        (local.get $i)
        (i32.const 3)
       )
      )
      (if
       (i32.lt_u
        (local.get $ch)
        (i32.const 128)
       )
       (then
        (if
         (if (result i32)
          (i32.eqz
           (local.get $component)
          )
          (then
           (block $~lib/util/uri/isReserved|inlined.0 (result i32)
            (local.set $ch|9
             (local.get $ch)
            )
            (br $~lib/util/uri/isReserved|inlined.0
             (if (result i32)
              (i32.lt_u
               (i32.sub
                (local.get $ch|9)
                (i32.const 35)
               )
               (i32.const 30)
              )
              (then
               (i32.load8_u
                (i32.add
                 (global.get $~lib/util/uri/URI_RESERVED)
                 (i32.sub
                  (local.get $ch|9)
                  (i32.const 35)
                 )
                )
               )
              )
              (else
               (i32.const 0)
              )
             )
            )
           )
          )
          (else
           (i32.const 0)
          )
         )
         (then
          (local.set $ch
           (i32.const 37)
          )
          (local.set $i
           (i32.sub
            (local.get $i)
            (i32.const 2)
           )
          )
         )
        )
       )
       (else
        (local.set $nb
         (block $~lib/util/uri/utf8LenFromUpperByte|inlined.0 (result i32)
          (local.set $c0
           (local.get $ch)
          )
          (br $~lib/util/uri/utf8LenFromUpperByte|inlined.0
           (if (result i32)
            (i32.lt_u
             (i32.sub
              (local.get $c0)
              (i32.const 192)
             )
             (i32.const 56)
            )
            (then
             (i32.clz
              (i32.xor
               (i32.shl
                (local.get $c0)
                (i32.const 24)
               )
               (i32.const -1)
              )
             )
            )
            (else
             (i32.const 0)
            )
           )
          )
         )
        )
        (local.set $lo
         (i32.shl
          (i32.const 1)
          (i32.sub
           (i32.shr_u
            (i32.mul
             (i32.const 17)
             (local.get $nb)
            )
            (i32.const 2)
           )
           (i32.const 1)
          )
         )
        )
        (local.set $ch
         (i32.and
          (local.get $ch)
          (if (result i32)
           (local.get $nb)
           (then
            (i32.sub
             (i32.shr_u
              (i32.const 128)
              (local.get $nb)
             )
             (i32.const 1)
            )
           )
           (else
            (i32.const 0)
           )
          )
         )
        )
        (block $while-break|2
         (loop $while-continue|2
          (if
           (i32.ne
            (local.tee $nb
             (i32.sub
              (local.get $nb)
              (i32.const 1)
             )
            )
            (i32.const 0)
           )
           (then
            (if
             (if (result i32)
              (if (result i32)
               (i32.ge_u
                (i32.add
                 (local.get $i)
                 (i32.const 2)
                )
                (local.get $len)
               )
               (then
                (i32.const 1)
               )
               (else
                (i32.ne
                 (i32.load16_u
                  (i32.add
                   (local.get $src)
                   (i32.shl
                    (local.get $i)
                    (i32.const 1)
                   )
                  )
                 )
                 (i32.const 37)
                )
               )
              )
              (then
               (i32.const 1)
              )
              (else
               (i32.eq
                (local.tee $c1
                 (call $~lib/util/uri/loadHex
                  (local.get $src)
                  (i32.shl
                   (i32.add
                    (local.get $i)
                    (i32.const 1)
                   )
                   (i32.const 1)
                  )
                 )
                )
                (i32.const -1)
               )
              )
             )
             (then
              (call $~lib/builtins/abort
               (i32.const 560)
               (i32.const 608)
               (i32.const 187)
               (i32.const 11)
              )
              (unreachable)
             )
            )
            (local.set $i
             (i32.add
              (local.get $i)
              (i32.const 3)
             )
            )
            (if
             (i32.ne
              (i32.and
               (local.get $c1)
               (i32.const 192)
              )
              (i32.const 128)
             )
             (then
              (local.set $ch
               (i32.const 0)
              )
              (br $while-break|2)
             )
            )
            (local.set $ch
             (i32.or
              (i32.shl
               (local.get $ch)
               (i32.const 6)
              )
              (i32.and
               (local.get $c1)
               (i32.const 63)
              )
             )
            )
            (br $while-continue|2)
           )
          )
         )
        )
        (if
         (if (result i32)
          (if (result i32)
           (if (result i32)
            (i32.lt_u
             (local.get $ch)
             (local.get $lo)
            )
            (then
             (i32.const 1)
            )
            (else
             (i32.eq
              (local.get $lo)
              (i32.const -1)
             )
            )
           )
           (then
            (i32.const 1)
           )
           (else
            (i32.gt_u
             (local.get $ch)
             (i32.const 1114111)
            )
           )
          )
          (then
           (i32.const 1)
          )
          (else
           (if (result i32)
            (i32.ge_u
             (local.get $ch)
             (i32.const 55296)
            )
            (then
             (i32.lt_u
              (local.get $ch)
              (i32.const 57344)
             )
            )
            (else
             (i32.const 0)
            )
           )
          )
         )
         (then
          (call $~lib/builtins/abort
           (i32.const 560)
           (i32.const 608)
           (i32.const 199)
           (i32.const 9)
          )
          (unreachable)
         )
        )
        (if
         (i32.ge_u
          (local.get $ch)
          (i32.const 65536)
         )
         (then
          (local.set $ch
           (i32.sub
            (local.get $ch)
            (i32.const 65536)
           )
          )
          (local.set $lo|14
           (i32.or
            (i32.shr_u
             (local.get $ch)
             (i32.const 10)
            )
            (i32.const 55296)
           )
          )
          (local.set $hi
           (i32.or
            (i32.and
             (local.get $ch)
             (i32.const 1023)
            )
            (i32.const 56320)
           )
          )
          (i32.store
           (i32.add
            (local.get $dst)
            (local.get $offset)
           )
           (i32.or
            (local.get $lo|14)
            (i32.shl
             (local.get $hi)
             (i32.const 16)
            )
           )
          )
          (local.set $offset
           (i32.add
            (local.get $offset)
            (i32.const 4)
           )
          )
          (br $while-continue|0)
         )
        )
       )
      )
      (i32.store16
       (i32.add
        (local.get $dst)
        (local.get $offset)
       )
       (local.get $ch)
      )
      (local.set $offset
       (i32.add
        (local.get $offset)
        (i32.const 2)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.le_u
     (local.get $offset)
     (i32.shl
      (local.get $len)
      (i32.const 1)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 608)
     (i32.const 216)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.gt_u
    (i32.shl
     (local.get $len)
     (i32.const 1)
    )
    (local.get $offset)
   )
   (then
    (local.set $dst
     (call $~lib/rt/itcms/__renew
      (local.get $dst)
      (local.get $offset)
     )
    )
   )
  )
  (return
   (local.get $dst)
  )
 )
 (func $~lib/uri/decodeURIComponent (param $str i32) (result i32)
  (return
   (call $~lib/util/uri/decode
    (local.get $str)
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $str)
     )
    )
    (i32.const 1)
   )
  )
 )
 (func $~lib/uri/decodeURI (param $str i32) (result i32)
  (return
   (call $~lib/util/uri/decode
    (local.get $str)
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $str)
     )
    )
    (i32.const 0)
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
 (func $start:std/uri
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
    (i32.const 272)
   )
  )
  (global.set $~lib/rt/itcms/toSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 304)
   )
  )
  (global.set $~lib/rt/itcms/fromSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 448)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 32)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 3)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 736)
      )
     )
     (i32.const 736)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 4)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 768)
      )
     )
     (i32.const 768)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 5)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 800)
      )
     )
     (i32.const 800)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 6)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 832)
      )
     )
     (i32.const 832)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 7)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 928)
      )
     )
     (i32.const 960)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 8)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 992)
      )
     )
     (i32.const 1024)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 9)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1056)
      )
     )
     (i32.const 1088)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 10)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1136)
      )
     )
     (i32.const 1168)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 11)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1216)
      )
     )
     (i32.const 1248)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 12)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1280)
      )
     )
     (i32.const 1312)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 13)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1360)
      )
     )
     (i32.const 1392)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 14)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1488)
      )
     )
     (i32.const 1520)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 15)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1632)
      )
     )
     (i32.const 1664)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 16)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1712)
      )
     )
     (i32.const 1744)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 17)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1792)
      )
     )
     (i32.const 1824)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 18)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 1904)
      )
     )
     (i32.const 1936)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 20)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 2000)
      )
     )
     (i32.const 2048)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 22)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURIComponent
       (i32.const 2128)
      )
     )
     (i32.const 2240)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 24)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURI
       (i32.const 32)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 34)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURI
       (i32.const 736)
      )
     )
     (i32.const 736)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 35)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURI
       (i32.const 2480)
      )
     )
     (i32.const 2480)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 36)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURI
       (i32.const 832)
      )
     )
     (i32.const 832)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 37)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURI
       (i32.const 2528)
      )
     )
     (i32.const 2560)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 38)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURI
       (i32.const 1632)
      )
     )
     (i32.const 1664)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 39)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURI
       (i32.const 1712)
      )
     )
     (i32.const 1744)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 40)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURI
       (i32.const 1904)
      )
     )
     (i32.const 1936)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 42)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/encodeURI
       (i32.const 2128)
      )
     )
     (i32.const 2128)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 43)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 32)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 50)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 736)
      )
     )
     (i32.const 736)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 51)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 2624)
      )
     )
     (i32.const 2656)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 52)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 2688)
      )
     )
     (i32.const 2720)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 53)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 2752)
      )
     )
     (i32.const 2752)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 54)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 1712)
      )
     )
     (i32.const 1712)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 55)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 2784)
      )
     )
     (i32.const 2864)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 56)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 2912)
      )
     )
     (i32.const 2864)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 57)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 2992)
      )
     )
     (i32.const 2128)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 58)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURIComponent
       (i32.const 1392)
      )
     )
     (i32.const 1360)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 63)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 32)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 73)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 736)
      )
     )
     (i32.const 736)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 74)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 2624)
      )
     )
     (i32.const 2624)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 75)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 3120)
      )
     )
     (i32.const 3152)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 76)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 3184)
      )
     )
     (i32.const 3216)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 77)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 2752)
      )
     )
     (i32.const 2752)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 78)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 1712)
      )
     )
     (i32.const 1712)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 79)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 2784)
      )
     )
     (i32.const 2784)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 80)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 1392)
      )
     )
     (i32.const 1360)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 81)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 3248)
      )
     )
     (i32.const 3248)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 82)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 3296)
      )
     )
     (i32.const 3296)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 83)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/uri/decodeURI
       (i32.const 2992)
      )
     )
     (i32.const 2992)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 688)
     (i32.const 84)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $~lib/memory/__stack_pointer
   (global.get $~lib/memory/__heap_base)
  )
  (call $~lib/rt/itcms/__collect)
 )
 (func $~lib/rt/__visit_globals (param $0 i32)
  (local $1 i32)
  (nop)
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
 (func $~lib/rt/__visit_members (param $0 i32) (param $1 i32)
  (block $invalid
   (block $~lib/arraybuffer/ArrayBufferView
    (block $~lib/string/String
     (block $~lib/arraybuffer/ArrayBuffer
      (block $~lib/object/Object
       (br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $invalid
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
  (unreachable)
 )
 (func $~start
  (call $start:std/uri)
 )
)
