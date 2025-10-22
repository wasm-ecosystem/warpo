(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32 i32)))
 (type $3 (func (param i32)))
 (type $4 (func))
 (type $5 (func (param i32 i32 i32)))
 (type $6 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $7 (func (param i32 i32 i32 i32)))
 (type $8 (func (param i32 i32 i64) (result i32)))
 (type $9 (func (result i32)))
 (type $10 (func (param i32 i64 i32)))
 (type $11 (func (param i64 i32) (result i32)))
 (type $12 (func (param i32 i64 i32 i32)))
 (type $13 (func (param f64 f64) (result f64)))
 (type $14 (func (param i32 i64 i32 i64 i32 i64 i32) (result i32)))
 (type $15 (func (param i32 i32 i32) (result i32)))
 (type $16 (func (param i32 f64 i32) (result i32)))
 (type $17 (func (param f64) (result i32)))
 (type $18 (func (param f64 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Minimal i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $resolve-binary/a (mut i32) (i32.const 0))
 (global $resolve-binary/f (mut f64) (f64.const 0))
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
 (global $~lib/util/math/log_tail (mut f64) (f64.const 0))
 (global $~lib/util/number/_frc_plus (mut i64) (i64.const 0))
 (global $~lib/util/number/_frc_minus (mut i64) (i64.const 0))
 (global $~lib/util/number/_exp (mut i32) (i32.const 0))
 (global $~lib/util/number/_K (mut i32) (i32.const 0))
 (global $~lib/util/number/_frc_pow (mut i64) (i64.const 0))
 (global $~lib/util/number/_exp_pow (mut i32) (i32.const 0))
 (global $resolve-binary/foo (mut i32) (i32.const 0))
 (global $resolve-binary/bar (mut i32) (i32.const 0))
 (global $resolve-binary/bar2 (mut i32) (i32.const 0))
 (global $resolve-binary/baz (mut i32) (i32.const 0))
 (global $~lib/rt/__rtti_base i32 (i32.const 10192))
 (global $~lib/memory/__data_end i32 (i32.const 10224))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 42992))
 (global $~lib/memory/__heap_base i32 (i32.const 42992))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00t\00r\00u\00e\00\00\00\00\00")
 (data $1 (i32.const 44) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00f\00a\00l\00s\00e\00\00\00")
 (data $2 (i32.const 76) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\"\00\00\00r\00e\00s\00o\00l\00v\00e\00-\00b\00i\00n\00a\00r\00y\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 140) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00d\00\00\00t\00o\00S\00t\00r\00i\00n\00g\00(\00)\00 \00r\00a\00d\00i\00x\00 \00a\00r\00g\00u\00m\00e\00n\00t\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 268) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00u\00t\00i\00l\00/\00n\00u\00m\00b\00e\00r\00.\00t\00s\00\00\00\00\00\00\00")
 (data $5 (i32.const 332) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\000\00\00\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 364) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $7 (i32.const 428) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 496) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 528) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $10 (i32.const 556) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $11 (i32.const 620) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $12 (i32.const 672) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $13 (i32.const 700) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $14 (i32.const 764) "0\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\00")
 (data $15 (i32.const 1164) "\1c\04\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\04\00\000\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\000\00a\000\00b\000\00c\000\00d\000\00e\000\00f\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\00a\001\00b\001\00c\001\00d\001\00e\001\00f\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\002\00a\002\00b\002\00c\002\00d\002\00e\002\00f\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\003\00a\003\00b\003\00c\003\00d\003\00e\003\00f\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\004\00a\004\00b\004\00c\004\00d\004\00e\004\00f\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\005\00a\005\00b\005\00c\005\00d\005\00e\005\00f\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\006\00a\006\00b\006\00c\006\00d\006\00e\006\00f\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\007\00a\007\00b\007\00c\007\00d\007\00e\007\00f\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\008\00a\008\00b\008\00c\008\00d\008\00e\008\00f\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\009\00a\009\00b\009\00c\009\00d\009\00e\009\00f\00a\000\00a\001\00a\002\00a\003\00a\004\00a\005\00a\006\00a\007\00a\008\00a\009\00a\00a\00a\00b\00a\00c\00a\00d\00a\00e\00a\00f\00b\000\00b\001\00b\002\00b\003\00b\004\00b\005\00b\006\00b\007\00b\008\00b\009\00b\00a\00b\00b\00b\00c\00b\00d\00b\00e\00b\00f\00c\000\00c\001\00c\002\00c\003\00c\004\00c\005\00c\006\00c\007\00c\008\00c\009\00c\00a\00c\00b\00c\00c\00c\00d\00c\00e\00c\00f\00d\000\00d\001\00d\002\00d\003\00d\004\00d\005\00d\006\00d\007\00d\008\00d\009\00d\00a\00d\00b\00d\00c\00d\00d\00d\00e\00d\00f\00e\000\00e\001\00e\002\00e\003\00e\004\00e\005\00e\006\00e\007\00e\008\00e\009\00e\00a\00e\00b\00e\00c\00e\00d\00e\00e\00e\00f\00f\000\00f\001\00f\002\00f\003\00f\004\00f\005\00f\006\00f\007\00f\008\00f\009\00f\00a\00f\00b\00f\00c\00f\00d\00f\00e\00f\00f\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $16 (i32.const 2220) "\\\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00H\00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00")
 (data $17 (i32.const 2316) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\001\00\00\00\00\00\00\00\00\00\00\00")
 (data $18 (i32.const 2348) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\002\00\00\00\00\00\00\00\00\00\00\00")
 (data $19 (i32.const 2384) "\00\00\00\00\00\a0\f6?\00\00\00\00\00\00\00\00\00\c8\b9\f2\82,\d6\bf\80V7($\b4\fa<\00\00\00\00\00\80\f6?\00\00\00\00\00\00\00\00\00\08X\bf\bd\d1\d5\bf \f7\e0\d8\08\a5\1c\bd\00\00\00\00\00`\f6?\00\00\00\00\00\00\00\00\00XE\17wv\d5\bfmP\b6\d5\a4b#\bd\00\00\00\00\00@\f6?\00\00\00\00\00\00\00\00\00\f8-\87\ad\1a\d5\bf\d5g\b0\9e\e4\84\e6\bc\00\00\00\00\00 \f6?\00\00\00\00\00\00\00\00\00xw\95_\be\d4\bf\e0>)\93i\1b\04\bd\00\00\00\00\00\00\f6?\00\00\00\00\00\00\00\00\00`\1c\c2\8ba\d4\bf\cc\84LH/\d8\13=\00\00\00\00\00\e0\f5?\00\00\00\00\00\00\00\00\00\a8\86\860\04\d4\bf:\0b\82\ed\f3B\dc<\00\00\00\00\00\c0\f5?\00\00\00\00\00\00\00\00\00HiUL\a6\d3\bf`\94Q\86\c6\b1 =\00\00\00\00\00\a0\f5?\00\00\00\00\00\00\00\00\00\80\98\9a\ddG\d3\bf\92\80\c5\d4MY%=\00\00\00\00\00\80\f5?\00\00\00\00\00\00\00\00\00 \e1\ba\e2\e8\d2\bf\d8+\b7\99\1e{&=\00\00\00\00\00`\f5?\00\00\00\00\00\00\00\00\00\88\de\13Z\89\d2\bf?\b0\cf\b6\14\ca\15=\00\00\00\00\00`\f5?\00\00\00\00\00\00\00\00\00\88\de\13Z\89\d2\bf?\b0\cf\b6\14\ca\15=\00\00\00\00\00@\f5?\00\00\00\00\00\00\00\00\00x\cf\fbA)\d2\bfv\daS($Z\16\bd\00\00\00\00\00 \f5?\00\00\00\00\00\00\00\00\00\98i\c1\98\c8\d1\bf\04T\e7h\bc\af\1f\bd\00\00\00\00\00\00\f5?\00\00\00\00\00\00\00\00\00\a8\ab\ab\\g\d1\bf\f0\a8\823\c6\1f\1f=\00\00\00\00\00\e0\f4?\00\00\00\00\00\00\00\00\00H\ae\f9\8b\05\d1\bffZ\05\fd\c4\a8&\bd\00\00\00\00\00\c0\f4?\00\00\00\00\00\00\00\00\00\90s\e2$\a3\d0\bf\0e\03\f4~\eek\0c\bd\00\00\00\00\00\a0\f4?\00\00\00\00\00\00\00\00\00\d0\b4\94%@\d0\bf\7f-\f4\9e\b86\f0\bc\00\00\00\00\00\a0\f4?\00\00\00\00\00\00\00\00\00\d0\b4\94%@\d0\bf\7f-\f4\9e\b86\f0\bc\00\00\00\00\00\80\f4?\00\00\00\00\00\00\00\00\00@^m\18\b9\cf\bf\87<\99\ab*W\r=\00\00\00\00\00`\f4?\00\00\00\00\00\00\00\00\00`\dc\cb\ad\f0\ce\bf$\af\86\9c\b7&+=\00\00\00\00\00@\f4?\00\00\00\00\00\00\00\00\00\f0*n\07\'\ce\bf\10\ff?TO/\17\bd\00\00\00\00\00 \f4?\00\00\00\00\00\00\00\00\00\c0Ok!\\\cd\bf\1bh\ca\bb\91\ba!=\00\00\00\00\00\00\f4?\00\00\00\00\00\00\00\00\00\a0\9a\c7\f7\8f\cc\bf4\84\9fhOy\'=\00\00\00\00\00\00\f4?\00\00\00\00\00\00\00\00\00\a0\9a\c7\f7\8f\cc\bf4\84\9fhOy\'=\00\00\00\00\00\e0\f3?\00\00\00\00\00\00\00\00\00\90-t\86\c2\cb\bf\8f\b7\8b1\b0N\19=\00\00\00\00\00\c0\f3?\00\00\00\00\00\00\00\00\00\c0\80N\c9\f3\ca\bff\90\cd?cN\ba<\00\00\00\00\00\a0\f3?\00\00\00\00\00\00\00\00\00\b0\e2\1f\bc#\ca\bf\ea\c1F\dcd\8c%\bd\00\00\00\00\00\a0\f3?\00\00\00\00\00\00\00\00\00\b0\e2\1f\bc#\ca\bf\ea\c1F\dcd\8c%\bd\00\00\00\00\00\80\f3?\00\00\00\00\00\00\00\00\00P\f4\9cZR\c9\bf\e3\d4\c1\04\d9\d1*\bd\00\00\00\00\00`\f3?\00\00\00\00\00\00\00\00\00\d0 e\a0\7f\c8\bf\t\fa\db\7f\bf\bd+=\00\00\00\00\00@\f3?\00\00\00\00\00\00\00\00\00\e0\10\02\89\ab\c7\bfXJSr\90\db+=\00\00\00\00\00@\f3?\00\00\00\00\00\00\00\00\00\e0\10\02\89\ab\c7\bfXJSr\90\db+=\00\00\00\00\00 \f3?\00\00\00\00\00\00\00\00\00\d0\19\e7\0f\d6\c6\bff\e2\b2\a3j\e4\10\bd\00\00\00\00\00\00\f3?\00\00\00\00\00\00\00\00\00\90\a7p0\ff\c5\bf9P\10\9fC\9e\1e\bd\00\00\00\00\00\00\f3?\00\00\00\00\00\00\00\00\00\90\a7p0\ff\c5\bf9P\10\9fC\9e\1e\bd\00\00\00\00\00\e0\f2?\00\00\00\00\00\00\00\00\00\b0\a1\e3\e5&\c5\bf\8f[\07\90\8b\de \bd\00\00\00\00\00\c0\f2?\00\00\00\00\00\00\00\00\00\80\cbl+M\c4\bf<x5a\c1\0c\17=\00\00\00\00\00\c0\f2?\00\00\00\00\00\00\00\00\00\80\cbl+M\c4\bf<x5a\c1\0c\17=\00\00\00\00\00\a0\f2?\00\00\00\00\00\00\00\00\00\90\1e \fcq\c3\bf:T\'M\86x\f1<\00\00\00\00\00\80\f2?\00\00\00\00\00\00\00\00\00\f0\1f\f8R\95\c2\bf\08\c4q\170\8d$\bd\00\00\00\00\00`\f2?\00\00\00\00\00\00\00\00\00`/\d5*\b7\c1\bf\96\a3\11\18\a4\80.\bd\00\00\00\00\00`\f2?\00\00\00\00\00\00\00\00\00`/\d5*\b7\c1\bf\96\a3\11\18\a4\80.\bd\00\00\00\00\00@\f2?\00\00\00\00\00\00\00\00\00\90\d0|~\d7\c0\bf\f4[\e8\88\96i\n=\00\00\00\00\00@\f2?\00\00\00\00\00\00\00\00\00\90\d0|~\d7\c0\bf\f4[\e8\88\96i\n=\00\00\00\00\00 \f2?\00\00\00\00\00\00\00\00\00\e0\db1\91\ec\bf\bf\f23\a3\\Tu%\bd\00\00\00\00\00\00\f2?\00\00\00\00\00\00\00\00\00\00+n\07\'\be\bf<\00\f0*,4*=\00\00\00\00\00\00\f2?\00\00\00\00\00\00\00\00\00\00+n\07\'\be\bf<\00\f0*,4*=\00\00\00\00\00\e0\f1?\00\00\00\00\00\00\00\00\00\c0[\8fT^\bc\bf\06\be_XW\0c\1d\bd\00\00\00\00\00\c0\f1?\00\00\00\00\00\00\00\00\00\e0J:m\92\ba\bf\c8\aa[\e859%=\00\00\00\00\00\c0\f1?\00\00\00\00\00\00\00\00\00\e0J:m\92\ba\bf\c8\aa[\e859%=\00\00\00\00\00\a0\f1?\00\00\00\00\00\00\00\00\00\a01\d6E\c3\b8\bfhV/M)|\13=\00\00\00\00\00\a0\f1?\00\00\00\00\00\00\00\00\00\a01\d6E\c3\b8\bfhV/M)|\13=\00\00\00\00\00\80\f1?\00\00\00\00\00\00\00\00\00`\e5\8a\d2\f0\b6\bf\das3\c97\97&\bd\00\00\00\00\00`\f1?\00\00\00\00\00\00\00\00\00 \06?\07\1b\b5\bfW^\c6a[\02\1f=\00\00\00\00\00`\f1?\00\00\00\00\00\00\00\00\00 \06?\07\1b\b5\bfW^\c6a[\02\1f=\00\00\00\00\00@\f1?\00\00\00\00\00\00\00\00\00\e0\1b\96\d7A\b3\bf\df\13\f9\cc\da^,=\00\00\00\00\00@\f1?\00\00\00\00\00\00\00\00\00\e0\1b\96\d7A\b3\bf\df\13\f9\cc\da^,=\00\00\00\00\00 \f1?\00\00\00\00\00\00\00\00\00\80\a3\ee6e\b1\bf\t\a3\8fv^|\14=\00\00\00\00\00\00\f1?\00\00\00\00\00\00\00\00\00\80\11\c00\n\af\bf\91\8e6\83\9eY-=\00\00\00\00\00\00\f1?\00\00\00\00\00\00\00\00\00\80\11\c00\n\af\bf\91\8e6\83\9eY-=\00\00\00\00\00\e0\f0?\00\00\00\00\00\00\00\00\00\80\19q\ddB\ab\bfLp\d6\e5z\82\1c=\00\00\00\00\00\e0\f0?\00\00\00\00\00\00\00\00\00\80\19q\ddB\ab\bfLp\d6\e5z\82\1c=\00\00\00\00\00\c0\f0?\00\00\00\00\00\00\00\00\00\c02\f6Xt\a7\bf\ee\a1\f24F\fc,\bd\00\00\00\00\00\c0\f0?\00\00\00\00\00\00\00\00\00\c02\f6Xt\a7\bf\ee\a1\f24F\fc,\bd\00\00\00\00\00\a0\f0?\00\00\00\00\00\00\00\00\00\c0\fe\b9\87\9e\a3\bf\aa\fe&\f5\b7\02\f5<\00\00\00\00\00\a0\f0?\00\00\00\00\00\00\00\00\00\c0\fe\b9\87\9e\a3\bf\aa\fe&\f5\b7\02\f5<\00\00\00\00\00\80\f0?\00\00\00\00\00\00\00\00\00\00x\0e\9b\82\9f\bf\e4\t~|&\80)\bd\00\00\00\00\00\80\f0?\00\00\00\00\00\00\00\00\00\00x\0e\9b\82\9f\bf\e4\t~|&\80)\bd\00\00\00\00\00`\f0?\00\00\00\00\00\00\00\00\00\80\d5\07\1b\b9\97\bf9\a6\fa\93T\8d(\bd\00\00\00\00\00@\f0?\00\00\00\00\00\00\00\00\00\00\fc\b0\a8\c0\8f\bf\9c\a6\d3\f6|\1e\df\bc\00\00\00\00\00@\f0?\00\00\00\00\00\00\00\00\00\00\fc\b0\a8\c0\8f\bf\9c\a6\d3\f6|\1e\df\bc\00\00\00\00\00 \f0?\00\00\00\00\00\00\00\00\00\00\10k*\e0\7f\bf\e4@\da\r?\e2\19\bd\00\00\00\00\00 \f0?\00\00\00\00\00\00\00\00\00\00\10k*\e0\7f\bf\e4@\da\r?\e2\19\bd\00\00\00\00\00\00\f0?\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\f0?\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\c0\ef?\00\00\00\00\00\00\00\00\00\00\89u\15\10\80?\e8+\9d\99k\c7\10\bd\00\00\00\00\00\80\ef?\00\00\00\00\00\00\00\00\00\80\93XV \90?\d2\f7\e2\06[\dc#\bd\00\00\00\00\00@\ef?\00\00\00\00\00\00\00\00\00\00\c9(%I\98?4\0cZ2\ba\a0*\bd\00\00\00\00\00\00\ef?\00\00\00\00\00\00\00\00\00@\e7\89]A\a0?S\d7\f1\\\c0\11\01=\00\00\00\00\00\c0\ee?\00\00\00\00\00\00\00\00\00\00.\d4\aef\a4?(\fd\bdus\16,\bd\00\00\00\00\00\80\ee?\00\00\00\00\00\00\00\00\00\c0\9f\14\aa\94\a8?}&Z\d0\95y\19\bd\00\00\00\00\00@\ee?\00\00\00\00\00\00\00\00\00\c0\dd\cds\cb\ac?\07(\d8G\f2h\1a\bd\00\00\00\00\00 \ee?\00\00\00\00\00\00\00\00\00\c0\06\c01\ea\ae?{;\c9O>\11\0e\bd\00\00\00\00\00\e0\ed?\00\00\00\00\00\00\00\00\00`F\d1;\97\b1?\9b\9e\rV]2%\bd\00\00\00\00\00\a0\ed?\00\00\00\00\00\00\00\00\00\e0\d1\a7\f5\bd\b3?\d7N\db\a5^\c8,=\00\00\00\00\00`\ed?\00\00\00\00\00\00\00\00\00\a0\97MZ\e9\b5?\1e\1d]<\06i,\bd\00\00\00\00\00@\ed?\00\00\00\00\00\00\00\00\00\c0\ea\n\d3\00\b7?2\ed\9d\a9\8d\1e\ec<\00\00\00\00\00\00\ed?\00\00\00\00\00\00\00\00\00@Y]^3\b9?\daG\bd:\\\11#=\00\00\00\00\00\c0\ec?\00\00\00\00\00\00\00\00\00`\ad\8d\c8j\bb?\e5h\f7+\80\90\13\bd\00\00\00\00\00\a0\ec?\00\00\00\00\00\00\00\00\00@\bc\01X\88\bc?\d3\acZ\c6\d1F&=\00\00\00\00\00`\ec?\00\00\00\00\00\00\00\00\00 \n\839\c7\be?\e0E\e6\afh\c0-\bd\00\00\00\00\00@\ec?\00\00\00\00\00\00\00\00\00\e0\db9\91\e8\bf?\fd\n\a1O\d64%\bd\00\00\00\00\00\00\ec?\00\00\00\00\00\00\00\00\00\e0\'\82\8e\17\c1?\f2\07-\cex\ef!=\00\00\00\00\00\e0\eb?\00\00\00\00\00\00\00\00\00\f0#~+\aa\c1?4\998D\8e\a7,=\00\00\00\00\00\a0\eb?\00\00\00\00\00\00\00\00\00\80\86\0ca\d1\c2?\a1\b4\81\cbl\9d\03=\00\00\00\00\00\80\eb?\00\00\00\00\00\00\00\00\00\90\15\b0\fce\c3?\89rK#\a8/\c6<\00\00\00\00\00@\eb?\00\00\00\00\00\00\00\00\00\b03\83=\91\c4?x\b6\fdTy\83%=\00\00\00\00\00 \eb?\00\00\00\00\00\00\00\00\00\b0\a1\e4\e5\'\c5?\c7}i\e5\e83&=\00\00\00\00\00\e0\ea?\00\00\00\00\00\00\00\00\00\10\8c\beNW\c6?x.<,\8b\cf\19=\00\00\00\00\00\c0\ea?\00\00\00\00\00\00\00\00\00pu\8b\12\f0\c6?\e1!\9c\e5\8d\11%\bd\00\00\00\00\00\a0\ea?\00\00\00\00\00\00\00\00\00PD\85\8d\89\c7?\05C\91p\10f\1c\bd\00\00\00\00\00`\ea?\00\00\00\00\00\00\00\00\00\009\eb\af\be\c8?\d1,\e9\aaT=\07\bd\00\00\00\00\00@\ea?\00\00\00\00\00\00\00\00\00\00\f7\dcZZ\c9?o\ff\a0X(\f2\07=\00\00\00\00\00\00\ea?\00\00\00\00\00\00\00\00\00\e0\8a<\ed\93\ca?i!VPCr(\bd\00\00\00\00\00\e0\e9?\00\00\00\00\00\00\00\00\00\d0[W\d81\cb?\aa\e1\acN\8d5\0c\bd\00\00\00\00\00\c0\e9?\00\00\00\00\00\00\00\00\00\e0;8\87\d0\cb?\b6\12TY\c4K-\bd\00\00\00\00\00\a0\e9?\00\00\00\00\00\00\00\00\00\10\f0\c6\fbo\cc?\d2+\96\c5r\ec\f1\bc\00\00\00\00\00`\e9?\00\00\00\00\00\00\00\00\00\90\d4\b0=\b1\cd?5\b0\15\f7*\ff*\bd\00\00\00\00\00@\e9?\00\00\00\00\00\00\00\00\00\10\e7\ff\0eS\ce?0\f4A`\'\12\c2<\00\00\00\00\00 \e9?\00\00\00\00\00\00\00\00\00\00\dd\e4\ad\f5\ce?\11\8e\bbe\15!\ca\bc\00\00\00\00\00\00\e9?\00\00\00\00\00\00\00\00\00\b0\b3l\1c\99\cf?0\df\0c\ca\ec\cb\1b=\00\00\00\00\00\c0\e8?\00\00\00\00\00\00\00\00\00XM`8q\d0?\91N\ed\16\db\9c\f8<\00\00\00\00\00\a0\e8?\00\00\00\00\00\00\00\00\00`ag-\c4\d0?\e9\ea<\16\8b\18\'=\00\00\00\00\00\80\e8?\00\00\00\00\00\00\00\00\00\e8\'\82\8e\17\d1?\1c\f0\a5c\0e!,\bd\00\00\00\00\00`\e8?\00\00\00\00\00\00\00\00\00\f8\ac\cb\\k\d1?\81\16\a5\f7\cd\9a+=\00\00\00\00\00@\e8?\00\00\00\00\00\00\00\00\00hZc\99\bf\d1?\b7\bdGQ\ed\a6,=\00\00\00\00\00 \e8?\00\00\00\00\00\00\00\00\00\b8\0emE\14\d2?\ea\baF\ba\de\87\n=\00\00\00\00\00\e0\e7?\00\00\00\00\00\00\00\00\00\90\dc|\f0\be\d2?\f4\04PJ\fa\9c*=\00\00\00\00\00\c0\e7?\00\00\00\00\00\00\00\00\00`\d3\e1\f1\14\d3?\b8<!\d3z\e2(\bd\00\00\00\00\00\a0\e7?\00\00\00\00\00\00\00\00\00\10\bevgk\d3?\c8w\f1\b0\cdn\11=\00\00\00\00\00\80\e7?\00\00\00\00\00\00\00\00\0003wR\c2\d3?\\\bd\06\b6T;\18=\00\00\00\00\00`\e7?\00\00\00\00\00\00\00\00\00\e8\d5#\b4\19\d4?\9d\e0\90\ec6\e4\08=\00\00\00\00\00@\e7?\00\00\00\00\00\00\00\00\00\c8q\c2\8dq\d4?u\d6g\t\ce\'/\bd\00\00\00\00\00 \e7?\00\00\00\00\00\00\00\00\000\17\9e\e0\c9\d4?\a4\d8\n\1b\89 .\bd\00\00\00\00\00\00\e7?\00\00\00\00\00\00\00\00\00\a08\07\ae\"\d5?Y\c7d\81p\be.=\00\00\00\00\00\e0\e6?\00\00\00\00\00\00\00\00\00\d0\c8S\f7{\d5?\ef@]\ee\ed\ad\1f=\00\00\00\00\00\c0\e6?\00\00\00\00\00\00\00\00\00`Y\df\bd\d5\d5?\dce\a4\08*\0b\n\bd")
 (data $20 (i32.const 6480) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\f0?n\bf\88\1aO;\9b<53\fb\a9=\f6\ef?]\dc\d8\9c\13`q\bca\80w>\9a\ec\ef?\d1f\87\10z^\90\bc\85\7fn\e8\15\e3\ef?\13\f6g5R\d2\8c<t\85\15\d3\b0\d9\ef?\fa\8e\f9#\80\ce\8b\bc\de\f6\dd)k\d0\ef?a\c8\e6aN\f7`<\c8\9bu\18E\c7\ef?\99\d33[\e4\a3\90<\83\f3\c6\ca>\be\ef?m{\83]\a6\9a\97<\0f\89\f9lX\b5\ef?\fc\ef\fd\92\1a\b5\8e<\f7Gr+\92\ac\ef?\d1\9c/p=\be><\a2\d1\d32\ec\a3\ef?\0bn\90\894\03j\bc\1b\d3\fe\aff\9b\ef?\0e\bd/*RV\95\bcQ[\12\d0\01\93\ef?U\eaN\8c\ef\80P\bc\cc1l\c0\bd\8a\ef?\16\f4\d5\b9#\c9\91\bc\e0-\a9\ae\9a\82\ef?\afU\\\e9\e3\d3\80<Q\8e\a5\c8\98z\ef?H\93\a5\ea\15\1b\80\bc{Q}<\b8r\ef?=2\deU\f0\1f\8f\bc\ea\8d\8c8\f9j\ef?\bfS\13?\8c\89\8b<u\cbo\eb[c\ef?&\eb\11v\9c\d9\96\bc\d4\\\04\84\e0[\ef?`/:>\f7\ec\9a<\aa\b9h1\87T\ef?\9d8\86\cb\82\e7\8f\bc\1d\d9\fc\"PM\ef?\8d\c3\a6DAo\8a<\d6\8cb\88;F\ef?}\04\e4\b0\05z\80<\96\dc}\91I?\ef?\94\a8\a8\e3\fd\8e\96<8bunz8\ef?}Ht\f2\18^\87<?\a6\b2O\ce1\ef?\f2\e7\1f\98+G\80<\dd|\e2eE+\ef?^\08q?{\b8\96\bc\81c\f5\e1\df$\ef?1\ab\tm\e1\f7\82<\e1\de\1f\f5\9d\1e\ef?\fa\bfo\1a\9b!=\bc\90\d9\da\d0\7f\18\ef?\b4\n\0cr\827\8b<\0b\03\e4\a6\85\12\ef?\8f\cb\ce\89\92\14n<V/>\a9\af\0c\ef?\b6\ab\b0MuM\83<\15\b71\n\fe\06\ef?Lt\ac\e2\01B\86<1\d8L\fcp\01\ef?J\f8\d3]9\dd\8f<\ff\16d\b2\08\fc\ee?\04[\8e;\80\a3\86\bc\f1\9f\92_\c5\f6\ee?hPK\cc\edJ\92\bc\cb\a9:7\a7\f1\ee?\8e-Q\1b\f8\07\99\bcf\d8\05m\ae\ec\ee?\d26\94>\e8\d1q\bc\f7\9f\e54\db\e7\ee?\15\1b\ce\b3\19\19\99\bc\e5\a8\13\c3-\e3\ee?mL*\a7H\9f\85<\"4\12L\a6\de\ee?\8ai(z`\12\93\bc\1c\80\ac\04E\da\ee?[\89\17H\8f\a7X\bc*.\f7!\n\d6\ee?\1b\9aIg\9b,|\bc\97\a8P\d9\f5\d1\ee?\11\ac\c2`\edcC<-\89a`\08\ce\ee?\efd\06;\tf\96<W\00\1d\edA\ca\ee?y\03\a1\da\e1\ccn<\d0<\c1\b5\a2\c6\ee?0\12\0f?\8e\ff\93<\de\d3\d7\f0*\c3\ee?\b0\afz\bb\ce\90v<\'*6\d5\da\bf\ee?w\e0T\eb\bd\1d\93<\r\dd\fd\99\b2\bc\ee?\8e\a3q\004\94\8f\bc\a7,\9dv\b2\b9\ee?I\a3\93\dc\cc\de\87\bcBf\cf\a2\da\b6\ee?_8\0f\bd\c6\dex\bc\82O\9dV+\b4\ee?\f6\\{\ecF\12\86\bc\0f\92]\ca\a4\b1\ee?\8e\d7\fd\18\055\93<\da\'\b56G\af\ee?\05\9b\8a/\b7\98{<\fd\c7\97\d4\12\ad\ee?\tT\1c\e2\e1c\90<)TH\dd\07\ab\ee?\ea\c6\19P\85\c74<\b7FY\8a&\a9\ee?5\c0d+\e62\94<H!\ad\15o\a7\ee?\9fv\99aJ\e4\8c\bc\t\dcv\b9\e1\a5\ee?\a8M\ef;\c53\8c\bc\85U:\b0~\a4\ee?\ae\e9+\89xS\84\bc \c3\cc4F\a3\ee?XXVx\dd\ce\93\bc%\"U\828\a2\ee?d\19~\80\aa\10W<s\a9L\d4U\a1\ee?(\"^\bf\ef\b3\93\bc\cd;\7ff\9e\a0\ee?\82\b94\87\ad\12j\bc\bf\da\0bu\12\a0\ee?\ee\a9m\b8\efgc\bc/\1ae<\b2\9f\ee?Q\88\e0T=\dc\80\bc\84\94Q\f9}\9f\ee?\cf>Z~d\1fx\bct_\ec\e8u\9f\ee?\b0}\8b\c0J\ee\86\bct\81\a5H\9a\9f\ee?\8a\e6U\1e2\19\86\bc\c9gBV\eb\9f\ee?\d3\d4\t^\cb\9c\90<?]\deOi\a0\ee?\1d\a5M\b9\dc2{\bc\87\01\ebs\14\a1\ee?k\c0gT\fd\ec\94<2\c10\01\ed\a1\ee?Ul\d6\ab\e1\ebe<bN\cf6\f3\a2\ee?B\cf\b3/\c5\a1\88\bc\12\1a>T\'\a4\ee?47;\f1\b6i\93\bc\13\ceL\99\89\a5\ee?\1e\ff\19:\84^\80\bc\ad\c7#F\1a\a7\ee?nWr\d8P\d4\94\bc\ed\92D\9b\d9\a8\ee?\00\8a\0e[g\ad\90<\99f\8a\d9\c7\aa\ee?\b4\ea\f0\c1/\b7\8d<\db\a0*B\e5\ac\ee?\ff\e7\c5\9c`\b6e\bc\8cD\b5\162\af\ee?D_\f3Y\83\f6{<6w\15\99\ae\b1\ee?\83=\1e\a7\1f\t\93\bc\c6\ff\91\0b[\b4\ee?)\1el\8b\b8\a9]\bc\e5\c5\cd\b07\b7\ee?Y\b9\90|\f9#l\bc\0fR\c8\cbD\ba\ee?\aa\f9\f4\"CC\92\bcPN\de\9f\82\bd\ee?K\8ef\d7l\ca\85\bc\ba\07\cap\f1\c0\ee?\'\ce\91+\fc\afq<\90\f0\a3\82\91\c4\ee?\bbs\n\e15\d2m<##\e3\19c\c8\ee?c\"b\"\04\c5\87\bce\e5]{f\cc\ee?\d51\e2\e3\86\1c\8b<3-J\ec\9b\d0\ee?\15\bb\bc\d3\d1\bb\91\bc]%>\b2\03\d5\ee?\d21\ee\9c1\cc\90<X\b30\13\9e\d9\ee?\b3Zsn\84i\84<\bf\fdyUk\de\ee?\b4\9d\8e\97\cd\df\82\bcz\f3\d3\bfk\e3\ee?\873\cb\92w\1a\8c<\ad\d3Z\99\9f\e8\ee?\fa\d9\d1J\8f{\90\bcf\b6\8d)\07\ee\ee?\ba\ae\dcV\d9\c3U\bc\fb\15O\b8\a2\f3\ee?@\f6\a6=\0e\a4\90\bc:Y\e5\8dr\f9\ee?4\93\ad8\f4\d6h\bcG^\fb\f2v\ff\ee?5\8aXk\e2\ee\91\bcJ\06\a10\b0\05\ef?\cd\dd_\n\d7\fft<\d2\c1K\90\1e\0c\ef?\ac\98\92\fa\fb\bd\91\bc\t\1e\d7[\c2\12\ef?\b3\0c\af0\aens<\9cR\85\dd\9b\19\ef?\94\fd\9f\\2\e3\8e<z\d0\ff_\ab \ef?\acY\t\d1\8f\e0\84<K\d1W.\f1\'\ef?g\1aN8\af\cdc<\b5\e7\06\94m/\ef?h\19\92l,kg<i\90\ef\dc 7\ef?\d2\b5\cc\83\18\8a\80\bc\fa\c3]U\0b?\ef?o\fa\ff?]\ad\8f\bc|\89\07J-G\ef?I\a9u8\ae\r\90\bc\f2\89\r\08\87O\ef?\a7\07=\a6\85\a3t<\87\a4\fb\dc\18X\ef?\0f\"@ \9e\91\82\bc\98\83\c9\16\e3`\ef?\ac\92\c1\d5PZ\8e<\852\db\03\e6i\ef?Kk\01\acY:\84<`\b4\01\f3!s\ef?\1f>\b4\07!\d5\82\bc_\9b{3\97|\ef?\c9\rG;\b9*\89\bc)\a1\f5\14F\86\ef?\d3\88:`\04\b6t<\f6?\8b\e7.\90\ef?qr\9dQ\ec\c5\83<\83L\c7\fbQ\9a\ef?\f0\91\d3\8f\12\f7\8f\bc\da\90\a4\a2\af\a4\ef?}t#\e2\98\ae\8d\bc\f1g\8e-H\af\ef?\08 \aaA\bc\c3\8e<\'Za\ee\1b\ba\ef?2\eb\a9\c3\94+\84<\97\bak7+\c5\ef?\ee\85\d11\a9d\8a<@En[v\d0\ef?\ed\e3;\e4\ba7\8e\bc\14\be\9c\ad\fd\db\ef?\9d\cd\91M;\89w<\d8\90\9e\81\c1\e7\ef?\89\cc`A\c1\05S<\f1q\8f+\c2\f3\ef?")
 (data $21 (i32.const 8540) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\000\00.\000\00\00\00\00\00\00\00")
 (data $22 (i32.const 8572) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00N\00a\00N\00\00\00\00\00\00\00")
 (data $23 (i32.const 8604) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00-\00I\00n\00f\00i\00n\00i\00t\00y\00\00\00\00\00\00\00\00\00\00\00")
 (data $24 (i32.const 8652) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00I\00n\00f\00i\00n\00i\00t\00y\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $25 (i32.const 8704) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $26 (i32.const 8760) "\88\02\1c\08\a0\d5\8f\fav\bf>\a2\7f\e1\ae\bav\acU0 \fb\16\8b\ea5\ce]J\89B\cf-;eU\aa\b0k\9a\dfE\1a=\03\cf\1a\e6\ca\c6\9a\c7\17\fep\abO\dc\bc\be\fc\b1w\ff\0c\d6kA\ef\91V\be<\fc\7f\90\ad\1f\d0\8d\83\9aU1(\\Q\d3\b5\c9\a6\ad\8f\acq\9d\cb\8b\ee#w\"\9c\eamSx@\91I\cc\aeW\ce\b6]y\12<\827V\fbM6\94\10\c2O\98H8o\ea\96\90\c7:\82%\cb\85t\d7\f4\97\bf\97\cd\cf\86\a0\e5\ac*\17\98\n4\ef\8e\b25*\fbg8\b2;?\c6\d2\df\d4\c8\84\ba\cd\d3\1a\'D\dd\c5\96\c9%\bb\ce\9fk\93\84\a5b}$l\ac\db\f6\da_\rXf\ab\a3&\f1\c3\de\93\f8\e2\f3\b8\80\ff\aa\a8\ad\b5\b5\8bJ|l\05_b\87S0\c14`\ff\bc\c9U&\ba\91\8c\85N\96\bd~)p$w\f9\df\8f\b8\e5\b8\9f\bd\df\a6\94}t\88\cf_\a9\f8\cf\9b\a8\8f\93pD\b9k\15\0f\bf\f8\f0\08\8a\b611eU%\b0\cd\ac\7f{\d0\c6\e2?\99\06;+*\c4\10\\\e4\d3\92si\99$$\aa\0e\ca\00\83\f2\b5\87\fd\eb\1a\11\92d\08\e5\bc\cc\88Po\t\cc\bc\8c,e\19\e2X\17\b7\d1\00\00\00\00\00\00@\9c\00\00\00\00\10\a5\d4\e8\00\00b\ac\c5\ebx\ad\84\t\94\f8x9?\81\b3\15\07\c9{\ce\97\c0p\\\ea{\ce2~\8fh\80\e9\ab\a48\d2\d5E\"\9a\17&\'O\9f\'\fb\c4\d41\a2c\ed\a8\ad\c8\8c8e\de\b0\dbe\ab\1a\8e\08\c7\83\9a\1dqB\f9\1d]\c4X\e7\1b\a6,iM\92\ea\8dp\1ad\ee\01\daJw\ef\9a\99\a3m\a2\85k}\b4{x\t\f2w\18\ddy\a1\e4T\b4\c2\c5\9b[\92\86[\86=]\96\c8\c5S5\c8\b3\a0\97\fa\\\b4*\95\e3_\a0\99\bd\9fF\de%\8c9\db4\c2\9b\a5\\\9f\98\a3r\9a\c6\f6\ce\be\e9TS\bf\dc\b7\e2A\"\f2\17\f3\fc\88\a5x\\\d3\9b\ce \cc\dfS!{\f3Z\16\98:0\1f\97\dc\b5\a0\e2\96\b3\e3\\S\d1\d9\a8<D\a7\a4\d9|\9b\fb\10D\a4\a7LLv\bb\1a\9c@\b6\ef\8e\ab\8b,\84W\a6\10\ef\1f\d0)1\91\e9\e5\a4\10\9b\9d\0c\9c\a1\fb\9b\10\e7)\f4;b\d9 (\ac\85\cf\a7z^KD\80-\dd\ac\03@\e4!\bf\8f\ffD^/\9cg\8eA\b8\8c\9c\9d\173\d4\a9\1b\e3\b4\92\db\19\9e\d9w\df\ban\bf\96\ebk\ee\f0\9b;\02\87\af")
 (data $27 (i32.const 9456) "<\fbW\fbr\fb\8c\fb\a7\fb\c1\fb\dc\fb\f6\fb\11\fc,\fcF\fca\fc{\fc\96\fc\b1\fc\cb\fc\e6\fc\00\fd\1b\fd5\fdP\fdk\fd\85\fd\a0\fd\ba\fd\d5\fd\ef\fd\n\fe%\fe?\feZ\fet\fe\8f\fe\a9\fe\c4\fe\df\fe\f9\fe\14\ff.\ffI\ffc\ff~\ff\99\ff\b3\ff\ce\ff\e8\ff\03\00\1e\008\00S\00m\00\88\00\a2\00\bd\00\d8\00\f2\00\r\01\'\01B\01\\\01w\01\92\01\ac\01\c7\01\e1\01\fc\01\16\021\02L\02f\02\81\02\9b\02\b6\02\d0\02\eb\02\06\03 \03;\03U\03p\03\8b\03\a5\03\c0\03\da\03\f5\03\0f\04*\04")
 (data $28 (i32.const 9632) "\01\00\00\00\n\00\00\00d\00\00\00\e8\03\00\00\10\'\00\00\a0\86\01\00@B\0f\00\80\96\98\00\00\e1\f5\05\00\ca\9a;")
 (data $29 (i32.const 9676) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\004\00.\000\00\00\00\00\00\00\00")
 (data $30 (i32.const 9708) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\004\00\00\00\00\00\00\00\00\00\00\00")
 (data $31 (i32.const 9740) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\003\00\00\00\00\00\00\00\00\00\00\00")
 (data $32 (i32.const 9772) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00-\001\00\00\00\00\00\00\00\00\00")
 (data $33 (i32.const 9804) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00l\00t\00\00\00\00\00\00\00\00\00")
 (data $34 (i32.const 9836) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00g\00t\00\00\00\00\00\00\00\00\00")
 (data $35 (i32.const 9868) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00l\00e\00\00\00\00\00\00\00\00\00")
 (data $36 (i32.const 9900) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $37 (i32.const 9932) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00e\00q\00\00\00\00\00\00\00\00\00")
 (data $38 (i32.const 9964) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00n\00e\00\00\00\00\00\00\00\00\00")
 (data $39 (i32.const 9996) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00a\00d\00d\00\00\00\00\00\00\00")
 (data $40 (i32.const 10028) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00s\00u\00b\00\00\00\00\00\00\00")
 (data $41 (i32.const 10060) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00m\00u\00l\00\00\00\00\00\00\00")
 (data $42 (i32.const 10092) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00d\00i\00v\00\00\00\00\00\00\00")
 (data $43 (i32.const 10124) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00r\00e\00m\00\00\00\00\00\00\00")
 (data $44 (i32.const 10156) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00p\00o\00w\00\00\00\00\00\00\00")
 (data $45 (i32.const 10192) "\07\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00 \00\00\00 \00\00\00 \00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/number/Bool#toString (param $this i32) (param $radix i32) (result i32)
  (return
   (if (result i32)
    (local.get $this)
    (then
     (i32.const 32)
    )
    (else
     (i32.const 64)
    )
   )
  )
 )
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
         (i32.const 448)
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
       (i32.const 448)
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
     (i32.const 448)
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
     (i32.const 576)
     (i32.const 640)
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
        (i32.const 448)
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
     (i32.const 720)
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
     (i32.const 720)
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
     (i32.const 720)
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
     (i32.const 720)
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
     (i32.const 720)
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
       (i32.const 720)
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
     (i32.const 720)
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
     (i32.const 720)
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
     (i32.const 720)
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
     (i32.const 720)
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
       (i32.const 720)
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
       (i32.const 720)
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
     (i32.const 720)
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
         (i32.const 448)
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
     (i32.const 384)
     (i32.const 720)
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
     (i32.const 720)
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
         (i32.const 720)
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
     (i32.const 720)
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
       (i32.const 720)
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
     (i32.const 720)
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
     (i32.const 384)
     (i32.const 448)
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
 (func $~lib/util/number/utoa32_dec_lut (param $buffer i32) (param $num i32) (param $offset i32)
  (local $t i32)
  (local $r i32)
  (local $d1 i32)
  (local $d2 i32)
  (local $digits1 i64)
  (local $digits2 i64)
  (local $t|9 i32)
  (local $d1|10 i32)
  (local $digits i32)
  (local $digits|12 i32)
  (local $digit i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.ge_u
      (local.get $num)
      (i32.const 10000)
     )
     (then
      (local.set $t
       (i32.div_u
        (local.get $num)
        (i32.const 10000)
       )
      )
      (local.set $r
       (i32.rem_u
        (local.get $num)
        (i32.const 10000)
       )
      )
      (local.set $num
       (local.get $t)
      )
      (local.set $d1
       (i32.div_u
        (local.get $r)
        (i32.const 100)
       )
      )
      (local.set $d2
       (i32.rem_u
        (local.get $r)
        (i32.const 100)
       )
      )
      (local.set $digits1
       (i64.load32_u
        (i32.add
         (i32.const 764)
         (i32.shl
          (local.get $d1)
          (i32.const 2)
         )
        )
       )
      )
      (local.set $digits2
       (i64.load32_u
        (i32.add
         (i32.const 764)
         (i32.shl
          (local.get $d2)
          (i32.const 2)
         )
        )
       )
      )
      (local.set $offset
       (i32.sub
        (local.get $offset)
        (i32.const 4)
       )
      )
      (i64.store
       (i32.add
        (local.get $buffer)
        (i32.shl
         (local.get $offset)
         (i32.const 1)
        )
       )
       (i64.or
        (local.get $digits1)
        (i64.shl
         (local.get $digits2)
         (i64.const 32)
        )
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (i32.ge_u
    (local.get $num)
    (i32.const 100)
   )
   (then
    (local.set $t|9
     (i32.div_u
      (local.get $num)
      (i32.const 100)
     )
    )
    (local.set $d1|10
     (i32.rem_u
      (local.get $num)
      (i32.const 100)
     )
    )
    (local.set $num
     (local.get $t|9)
    )
    (local.set $offset
     (i32.sub
      (local.get $offset)
      (i32.const 2)
     )
    )
    (local.set $digits
     (i32.load
      (i32.add
       (i32.const 764)
       (i32.shl
        (local.get $d1|10)
        (i32.const 2)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (local.get $buffer)
      (i32.shl
       (local.get $offset)
       (i32.const 1)
      )
     )
     (local.get $digits)
    )
   )
  )
  (if
   (i32.ge_u
    (local.get $num)
    (i32.const 10)
   )
   (then
    (local.set $offset
     (i32.sub
      (local.get $offset)
      (i32.const 2)
     )
    )
    (local.set $digits|12
     (i32.load
      (i32.add
       (i32.const 764)
       (i32.shl
        (local.get $num)
        (i32.const 2)
       )
      )
     )
    )
    (i32.store
     (i32.add
      (local.get $buffer)
      (i32.shl
       (local.get $offset)
       (i32.const 1)
      )
     )
     (local.get $digits|12)
    )
   )
   (else
    (local.set $offset
     (i32.sub
      (local.get $offset)
      (i32.const 1)
     )
    )
    (local.set $digit
     (i32.add
      (i32.const 48)
      (local.get $num)
     )
    )
    (i32.store16
     (i32.add
      (local.get $buffer)
      (i32.shl
       (local.get $offset)
       (i32.const 1)
      )
     )
     (local.get $digit)
    )
   )
  )
 )
 (func $~lib/util/number/utoa_hex_lut (param $buffer i32) (param $num i64) (param $offset i32)
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.ge_u
      (local.get $offset)
      (i32.const 2)
     )
     (then
      (local.set $offset
       (i32.sub
        (local.get $offset)
        (i32.const 2)
       )
      )
      (i32.store
       (i32.add
        (local.get $buffer)
        (i32.shl
         (local.get $offset)
         (i32.const 1)
        )
       )
       (i32.load
        (i32.add
         (i32.const 1184)
         (i32.shl
          (i32.and
           (i32.wrap_i64
            (local.get $num)
           )
           (i32.const 255)
          )
          (i32.const 2)
         )
        )
       )
      )
      (local.set $num
       (i64.shr_u
        (local.get $num)
        (i64.const 8)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (i32.and
    (local.get $offset)
    (i32.const 1)
   )
   (then
    (i32.store16
     (local.get $buffer)
     (i32.load16_u
      (i32.add
       (i32.const 1184)
       (i32.shl
        (i32.wrap_i64
         (local.get $num)
        )
        (i32.const 6)
       )
      )
     )
    )
   )
  )
 )
 (func $~lib/util/number/ulog_base (param $num i64) (param $base i32) (result i32)
  (local $value i32)
  (local $b64 i64)
  (local $b i64)
  (local $e i32)
  (if
   (block $~lib/util/number/isPowerOf2<i32>|inlined.0 (result i32)
    (local.set $value
     (local.get $base)
    )
    (br $~lib/util/number/isPowerOf2<i32>|inlined.0
     (i32.eq
      (i32.popcnt
       (local.get $value)
      )
      (i32.const 1)
     )
    )
   )
   (then
    (return
     (i32.add
      (i32.div_u
       (i32.sub
        (i32.const 63)
        (i32.wrap_i64
         (i64.clz
          (local.get $num)
         )
        )
       )
       (i32.sub
        (i32.const 31)
        (i32.clz
         (local.get $base)
        )
       )
      )
      (i32.const 1)
     )
    )
   )
  )
  (local.set $b64
   (i64.extend_i32_s
    (local.get $base)
   )
  )
  (local.set $b
   (local.get $b64)
  )
  (local.set $e
   (i32.const 1)
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i64.ge_u
      (local.get $num)
      (local.get $b)
     )
     (then
      (local.set $num
       (i64.div_u
        (local.get $num)
        (local.get $b)
       )
      )
      (local.set $b
       (i64.mul
        (local.get $b)
        (local.get $b)
       )
      )
      (local.set $e
       (i32.shl
        (local.get $e)
        (i32.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (block $while-break|1
   (loop $while-continue|1
    (if
     (i64.ge_u
      (local.get $num)
      (i64.const 1)
     )
     (then
      (local.set $num
       (i64.div_u
        (local.get $num)
        (local.get $b64)
       )
      )
      (local.set $e
       (i32.add
        (local.get $e)
        (i32.const 1)
       )
      )
      (br $while-continue|1)
     )
    )
   )
  )
  (return
   (i32.sub
    (local.get $e)
    (i32.const 1)
   )
  )
 )
 (func $~lib/util/number/utoa64_any_core (param $buffer i32) (param $num i64) (param $offset i32) (param $radix i32)
  (local $base i64)
  (local $shift i64)
  (local $mask i64)
  (local $q i64)
  (local.set $base
   (i64.extend_i32_s
    (local.get $radix)
   )
  )
  (if
   (i32.eq
    (i32.and
     (local.get $radix)
     (i32.sub
      (local.get $radix)
      (i32.const 1)
     )
    )
    (i32.const 0)
   )
   (then
    (local.set $shift
     (i64.extend_i32_s
      (i32.and
       (i32.ctz
        (local.get $radix)
       )
       (i32.const 7)
      )
     )
    )
    (local.set $mask
     (i64.sub
      (local.get $base)
      (i64.const 1)
     )
    )
    (loop $do-loop|0
     (local.set $offset
      (i32.sub
       (local.get $offset)
       (i32.const 1)
      )
     )
     (i32.store16
      (i32.add
       (local.get $buffer)
       (i32.shl
        (local.get $offset)
        (i32.const 1)
       )
      )
      (i32.load16_u
       (i32.add
        (i32.const 2240)
        (i32.shl
         (i32.wrap_i64
          (i64.and
           (local.get $num)
           (local.get $mask)
          )
         )
         (i32.const 1)
        )
       )
      )
     )
     (local.set $num
      (i64.shr_u
       (local.get $num)
       (local.get $shift)
      )
     )
     (br_if $do-loop|0
      (i64.ne
       (local.get $num)
       (i64.const 0)
      )
     )
    )
   )
   (else
    (loop $do-loop|1
     (local.set $offset
      (i32.sub
       (local.get $offset)
       (i32.const 1)
      )
     )
     (local.set $q
      (i64.div_u
       (local.get $num)
       (local.get $base)
      )
     )
     (i32.store16
      (i32.add
       (local.get $buffer)
       (i32.shl
        (local.get $offset)
        (i32.const 1)
       )
      )
      (i32.load16_u
       (i32.add
        (i32.const 2240)
        (i32.shl
         (i32.wrap_i64
          (i64.sub
           (local.get $num)
           (i64.mul
            (local.get $q)
            (local.get $base)
           )
          )
         )
         (i32.const 1)
        )
       )
      )
     )
     (local.set $num
      (local.get $q)
     )
     (br_if $do-loop|1
      (i64.ne
       (local.get $num)
       (i64.const 0)
      )
     )
    )
   )
  )
 )
 (func $~lib/util/number/itoa32 (param $value i32) (param $radix i32) (result i32)
  (local $sign i32)
  (local $out i32)
  (local $decimals i32)
  (local $buffer i32)
  (local $num i32)
  (local $offset i32)
  (local $decimals|8 i32)
  (local $buffer|9 i32)
  (local $num|10 i32)
  (local $offset|11 i32)
  (local $val32 i32)
  (local $decimals|13 i32)
  (if
   (if (result i32)
    (i32.lt_s
     (local.get $radix)
     (i32.const 2)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.gt_s
      (local.get $radix)
      (i32.const 36)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 160)
     (i32.const 288)
     (i32.const 373)
     (i32.const 5)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (local.get $value)
   )
   (then
    (return
     (i32.const 352)
    )
   )
  )
  (local.set $sign
   (i32.shl
    (i32.shr_u
     (local.get $value)
     (i32.const 31)
    )
    (i32.const 1)
   )
  )
  (if
   (local.get $sign)
   (then
    (local.set $value
     (i32.sub
      (i32.const 0)
      (local.get $value)
     )
    )
   )
  )
  (if
   (i32.eq
    (local.get $radix)
    (i32.const 10)
   )
   (then
    (local.set $decimals
     (call $~lib/util/number/decimalCount32
      (local.get $value)
     )
    )
    (local.set $out
     (call $~lib/rt/__localtostack
      (call $~lib/rt/itcms/__new
       (i32.add
        (i32.shl
         (local.get $decimals)
         (i32.const 1)
        )
        (local.get $sign)
       )
       (i32.const 2)
      )
     )
    )
    (block $~lib/util/number/utoa32_dec_core|inlined.0
     (local.set $buffer
      (i32.add
       (local.get $out)
       (local.get $sign)
      )
     )
     (local.set $num
      (local.get $value)
     )
     (local.set $offset
      (local.get $decimals)
     )
     (drop
      (i32.ge_s
       (i32.const 0)
       (i32.const 1)
      )
     )
     (call $~lib/util/number/utoa32_dec_lut
      (local.get $buffer)
      (local.get $num)
      (local.get $offset)
     )
    )
   )
   (else
    (if
     (i32.eq
      (local.get $radix)
      (i32.const 16)
     )
     (then
      (local.set $decimals|8
       (i32.add
        (i32.shr_s
         (i32.sub
          (i32.const 31)
          (i32.clz
           (local.get $value)
          )
         )
         (i32.const 2)
        )
        (i32.const 1)
       )
      )
      (local.set $out
       (call $~lib/rt/__localtostack
        (call $~lib/rt/itcms/__new
         (i32.add
          (i32.shl
           (local.get $decimals|8)
           (i32.const 1)
          )
          (local.get $sign)
         )
         (i32.const 2)
        )
       )
      )
      (block $~lib/util/number/utoa32_hex_core|inlined.0
       (local.set $buffer|9
        (i32.add
         (local.get $out)
         (local.get $sign)
        )
       )
       (local.set $num|10
        (local.get $value)
       )
       (local.set $offset|11
        (local.get $decimals|8)
       )
       (drop
        (i32.ge_s
         (i32.const 0)
         (i32.const 1)
        )
       )
       (call $~lib/util/number/utoa_hex_lut
        (local.get $buffer|9)
        (i64.extend_i32_u
         (local.get $num|10)
        )
        (local.get $offset|11)
       )
      )
     )
     (else
      (local.set $val32
       (local.get $value)
      )
      (local.set $decimals|13
       (call $~lib/util/number/ulog_base
        (i64.extend_i32_u
         (local.get $val32)
        )
        (local.get $radix)
       )
      )
      (local.set $out
       (call $~lib/rt/__localtostack
        (call $~lib/rt/itcms/__new
         (i32.add
          (i32.shl
           (local.get $decimals|13)
           (i32.const 1)
          )
          (local.get $sign)
         )
         (i32.const 2)
        )
       )
      )
      (call $~lib/util/number/utoa64_any_core
       (i32.add
        (local.get $out)
        (local.get $sign)
       )
       (i64.extend_i32_u
        (local.get $val32)
       )
       (local.get $decimals|13)
       (local.get $radix)
      )
     )
    )
   )
  )
  (if
   (local.get $sign)
   (then
    (i32.store16
     (local.get $out)
     (i32.const 45)
    )
   )
  )
  (return
   (local.get $out)
  )
 )
 (func $~lib/number/I32#toString (param $this i32) (param $radix i32) (result i32)
  (return
   (call $~lib/util/number/itoa32
    (local.get $this)
    (local.get $radix)
   )
  )
 )
 (func $~lib/math/NativeMath.pow (param $x f64) (param $y f64) (result f64)
  (local $x|2 f64)
  (local $y|3 f64)
  (local $sign_bias i32)
  (local $ix i64)
  (local $iy i64)
  (local $topx i64)
  (local $topy i64)
  (local $u i64)
  (local $u|10 i64)
  (local $x2 f64)
  (local $iy|12 i64)
  (local $e i64)
  (local $iy|14 i64)
  (local $e|15 i64)
  (local $yint i32)
  (local $ix|17 i64)
  (local $tmp i64)
  (local $i i32)
  (local $k i64)
  (local $iz i64)
  (local $z f64)
  (local $kd f64)
  (local $invc f64)
  (local $logc f64)
  (local $logctail f64)
  (local $zhi f64)
  (local $zlo f64)
  (local $rhi f64)
  (local $rlo f64)
  (local $r f64)
  (local $t1 f64)
  (local $t2 f64)
  (local $lo1 f64)
  (local $lo2 f64)
  (local $ar f64)
  (local $ar2 f64)
  (local $ar3 f64)
  (local $arhi f64)
  (local $arhi2 f64)
  (local $hi f64)
  (local $lo3 f64)
  (local $lo4 f64)
  (local $p f64)
  (local $lo f64)
  (local $y|46 f64)
  (local $hi|47 f64)
  (local $lo|48 f64)
  (local $ehi f64)
  (local $elo f64)
  (local $yhi f64)
  (local $ylo f64)
  (local $lhi f64)
  (local $llo f64)
  (local $x|55 f64)
  (local $xtail f64)
  (local $sign_bias|57 i32)
  (local $abstop i32)
  (local $ki i64)
  (local $top i64)
  (local $sbits i64)
  (local $idx i32)
  (local $kd|63 f64)
  (local $z|64 f64)
  (local $r|65 f64)
  (local $r2 f64)
  (local $scale f64)
  (local $tail f64)
  (local $tmp|69 f64)
  (local $ux i64)
  (local $sign i32)
  (local $sign|72 i32)
  (local $y|73 f64)
  (local $sign|74 i32)
  (local $sign|75 i32)
  (local $y|76 f64)
  (local $tmp|77 f64)
  (local $sbits|78 i64)
  (local $ki|79 i64)
  (local $scale|80 f64)
  (local $y|81 f64)
  (local $one f64)
  (local $lo|83 f64)
  (local $hi|84 f64)
  (if
   (f64.le
    (f64.abs
     (local.get $y)
    )
    (f64.const 2)
   )
   (then
    (if
     (f64.eq
      (local.get $y)
      (f64.const 2)
     )
     (then
      (return
       (f64.mul
        (local.get $x)
        (local.get $x)
       )
      )
     )
    )
    (if
     (f64.eq
      (local.get $y)
      (f64.const 0.5)
     )
     (then
      (return
       (select
        (f64.abs
         (f64.sqrt
          (local.get $x)
         )
        )
        (f64.const inf)
        (f64.ne
         (local.get $x)
         (f64.neg
          (f64.const inf)
         )
        )
       )
      )
     )
    )
    (if
     (f64.eq
      (local.get $y)
      (f64.const -1)
     )
     (then
      (return
       (f64.div
        (f64.const 1)
        (local.get $x)
       )
      )
     )
    )
    (if
     (f64.eq
      (local.get $y)
      (f64.const 1)
     )
     (then
      (return
       (local.get $x)
      )
     )
    )
    (if
     (f64.eq
      (local.get $y)
      (f64.const 0)
     )
     (then
      (return
       (f64.const 1)
      )
     )
    )
   )
  )
  (drop
   (i32.lt_s
    (i32.const 0)
    (i32.const 1)
   )
  )
  (return
   (block $~lib/util/math/pow_lut|inlined.0 (result f64)
    (local.set $x|2
     (local.get $x)
    )
    (local.set $y|3
     (local.get $y)
    )
    (local.set $sign_bias
     (i32.const 0)
    )
    (local.set $ix
     (i64.reinterpret_f64
      (local.get $x|2)
     )
    )
    (local.set $iy
     (i64.reinterpret_f64
      (local.get $y|3)
     )
    )
    (local.set $topx
     (i64.shr_u
      (local.get $ix)
      (i64.const 52)
     )
    )
    (local.set $topy
     (i64.shr_u
      (local.get $iy)
      (i64.const 52)
     )
    )
    (if
     (if (result i32)
      (i64.ge_u
       (i64.sub
        (local.get $topx)
        (i64.const 1)
       )
       (i64.sub
        (i64.const 2047)
        (i64.const 1)
       )
      )
      (then
       (i32.const 1)
      )
      (else
       (i64.ge_u
        (i64.sub
         (i64.and
          (local.get $topy)
          (i64.const 2047)
         )
         (i64.const 958)
        )
        (i64.sub
         (i64.const 1086)
         (i64.const 958)
        )
       )
      )
     )
     (then
      (if
       (block $~lib/util/math/zeroinfnan|inlined.0 (result i32)
        (local.set $u
         (local.get $iy)
        )
        (br $~lib/util/math/zeroinfnan|inlined.0
         (i64.ge_u
          (i64.sub
           (i64.shl
            (local.get $u)
            (i64.const 1)
           )
           (i64.const 1)
          )
          (i64.sub
           (i64.const -9007199254740992)
           (i64.const 1)
          )
         )
        )
       )
       (then
        (if
         (i64.eq
          (i64.shl
           (local.get $iy)
           (i64.const 1)
          )
          (i64.const 0)
         )
         (then
          (br $~lib/util/math/pow_lut|inlined.0
           (f64.const 1)
          )
         )
        )
        (if
         (i64.eq
          (local.get $ix)
          (i64.const 4607182418800017408)
         )
         (then
          (br $~lib/util/math/pow_lut|inlined.0
           (f64.const nan:0x8000000000000)
          )
         )
        )
        (if
         (if (result i32)
          (i64.gt_u
           (i64.shl
            (local.get $ix)
            (i64.const 1)
           )
           (i64.const -9007199254740992)
          )
          (then
           (i32.const 1)
          )
          (else
           (i64.gt_u
            (i64.shl
             (local.get $iy)
             (i64.const 1)
            )
            (i64.const -9007199254740992)
           )
          )
         )
         (then
          (br $~lib/util/math/pow_lut|inlined.0
           (f64.add
            (local.get $x|2)
            (local.get $y|3)
           )
          )
         )
        )
        (if
         (i64.eq
          (i64.shl
           (local.get $ix)
           (i64.const 1)
          )
          (i64.const 9214364837600034816)
         )
         (then
          (br $~lib/util/math/pow_lut|inlined.0
           (f64.const nan:0x8000000000000)
          )
         )
        )
        (if
         (i32.eq
          (i64.lt_u
           (i64.shl
            (local.get $ix)
            (i64.const 1)
           )
           (i64.const 9214364837600034816)
          )
          (i32.eqz
           (i64.ne
            (i64.shr_u
             (local.get $iy)
             (i64.const 63)
            )
            (i64.const 0)
           )
          )
         )
         (then
          (br $~lib/util/math/pow_lut|inlined.0
           (f64.const 0)
          )
         )
        )
        (br $~lib/util/math/pow_lut|inlined.0
         (f64.mul
          (local.get $y|3)
          (local.get $y|3)
         )
        )
       )
      )
      (if
       (block $~lib/util/math/zeroinfnan|inlined.1 (result i32)
        (local.set $u|10
         (local.get $ix)
        )
        (br $~lib/util/math/zeroinfnan|inlined.1
         (i64.ge_u
          (i64.sub
           (i64.shl
            (local.get $u|10)
            (i64.const 1)
           )
           (i64.const 1)
          )
          (i64.sub
           (i64.const -9007199254740992)
           (i64.const 1)
          )
         )
        )
       )
       (then
        (local.set $x2
         (f64.mul
          (local.get $x|2)
          (local.get $x|2)
         )
        )
        (if
         (if (result i32)
          (i32.wrap_i64
           (i64.shr_u
            (local.get $ix)
            (i64.const 63)
           )
          )
          (then
           (i32.eq
            (block $~lib/util/math/checkint|inlined.0 (result i32)
             (local.set $iy|12
              (local.get $iy)
             )
             (local.set $e
              (i64.and
               (i64.shr_u
                (local.get $iy|12)
                (i64.const 52)
               )
               (i64.const 2047)
              )
             )
             (if
              (i64.lt_u
               (local.get $e)
               (i64.const 1023)
              )
              (then
               (br $~lib/util/math/checkint|inlined.0
                (i32.const 0)
               )
              )
             )
             (if
              (i64.gt_u
               (local.get $e)
               (i64.add
                (i64.const 1023)
                (i64.const 52)
               )
              )
              (then
               (br $~lib/util/math/checkint|inlined.0
                (i32.const 2)
               )
              )
             )
             (local.set $e
              (i64.shl
               (i64.const 1)
               (i64.sub
                (i64.add
                 (i64.const 1023)
                 (i64.const 52)
                )
                (local.get $e)
               )
              )
             )
             (if
              (i64.ne
               (i64.and
                (local.get $iy|12)
                (i64.sub
                 (local.get $e)
                 (i64.const 1)
                )
               )
               (i64.const 0)
              )
              (then
               (br $~lib/util/math/checkint|inlined.0
                (i32.const 0)
               )
              )
             )
             (if
              (i64.ne
               (i64.and
                (local.get $iy|12)
                (local.get $e)
               )
               (i64.const 0)
              )
              (then
               (br $~lib/util/math/checkint|inlined.0
                (i32.const 1)
               )
              )
             )
             (br $~lib/util/math/checkint|inlined.0
              (i32.const 2)
             )
            )
            (i32.const 1)
           )
          )
          (else
           (i32.const 0)
          )
         )
         (then
          (local.set $x2
           (f64.neg
            (local.get $x2)
           )
          )
         )
        )
        (br $~lib/util/math/pow_lut|inlined.0
         (if (result f64)
          (i64.lt_s
           (local.get $iy)
           (i64.const 0)
          )
          (then
           (f64.div
            (f64.const 1)
            (local.get $x2)
           )
          )
          (else
           (local.get $x2)
          )
         )
        )
       )
      )
      (if
       (i64.lt_s
        (local.get $ix)
        (i64.const 0)
       )
       (then
        (local.set $yint
         (block $~lib/util/math/checkint|inlined.1 (result i32)
          (local.set $iy|14
           (local.get $iy)
          )
          (local.set $e|15
           (i64.and
            (i64.shr_u
             (local.get $iy|14)
             (i64.const 52)
            )
            (i64.const 2047)
           )
          )
          (if
           (i64.lt_u
            (local.get $e|15)
            (i64.const 1023)
           )
           (then
            (br $~lib/util/math/checkint|inlined.1
             (i32.const 0)
            )
           )
          )
          (if
           (i64.gt_u
            (local.get $e|15)
            (i64.add
             (i64.const 1023)
             (i64.const 52)
            )
           )
           (then
            (br $~lib/util/math/checkint|inlined.1
             (i32.const 2)
            )
           )
          )
          (local.set $e|15
           (i64.shl
            (i64.const 1)
            (i64.sub
             (i64.add
              (i64.const 1023)
              (i64.const 52)
             )
             (local.get $e|15)
            )
           )
          )
          (if
           (i64.ne
            (i64.and
             (local.get $iy|14)
             (i64.sub
              (local.get $e|15)
              (i64.const 1)
             )
            )
            (i64.const 0)
           )
           (then
            (br $~lib/util/math/checkint|inlined.1
             (i32.const 0)
            )
           )
          )
          (if
           (i64.ne
            (i64.and
             (local.get $iy|14)
             (local.get $e|15)
            )
            (i64.const 0)
           )
           (then
            (br $~lib/util/math/checkint|inlined.1
             (i32.const 1)
            )
           )
          )
          (br $~lib/util/math/checkint|inlined.1
           (i32.const 2)
          )
         )
        )
        (if
         (i32.eq
          (local.get $yint)
          (i32.const 0)
         )
         (then
          (br $~lib/util/math/pow_lut|inlined.0
           (f64.div
            (f64.sub
             (local.get $x|2)
             (local.get $x|2)
            )
            (f64.sub
             (local.get $x|2)
             (local.get $x|2)
            )
           )
          )
         )
        )
        (if
         (i32.eq
          (local.get $yint)
          (i32.const 1)
         )
         (then
          (local.set $sign_bias
           (i32.const 262144)
          )
         )
        )
        (local.set $ix
         (i64.and
          (local.get $ix)
          (i64.const 9223372036854775807)
         )
        )
        (local.set $topx
         (i64.and
          (local.get $topx)
          (i64.const 2047)
         )
        )
       )
      )
      (if
       (i64.ge_u
        (i64.sub
         (i64.and
          (local.get $topy)
          (i64.const 2047)
         )
         (i64.const 958)
        )
        (i64.sub
         (i64.const 1086)
         (i64.const 958)
        )
       )
       (then
        (if
         (i64.eq
          (local.get $ix)
          (i64.const 4607182418800017408)
         )
         (then
          (br $~lib/util/math/pow_lut|inlined.0
           (f64.const 1)
          )
         )
        )
        (if
         (i64.lt_u
          (i64.and
           (local.get $topy)
           (i64.const 2047)
          )
          (i64.const 958)
         )
         (then
          (br $~lib/util/math/pow_lut|inlined.0
           (f64.const 1)
          )
         )
        )
        (br $~lib/util/math/pow_lut|inlined.0
         (if (result f64)
          (i32.eq
           (i64.gt_u
            (local.get $ix)
            (i64.const 4607182418800017408)
           )
           (i64.lt_u
            (local.get $topy)
            (i64.const 2048)
           )
          )
          (then
           (f64.const inf)
          )
          (else
           (f64.const 0)
          )
         )
        )
       )
      )
      (if
       (i64.eq
        (local.get $topx)
        (i64.const 0)
       )
       (then
        (local.set $ix
         (i64.reinterpret_f64
          (f64.mul
           (local.get $x|2)
           (f64.const 4503599627370496)
          )
         )
        )
        (local.set $ix
         (i64.and
          (local.get $ix)
          (i64.const 9223372036854775807)
         )
        )
        (local.set $ix
         (i64.sub
          (local.get $ix)
          (i64.shl
           (i64.const 52)
           (i64.const 52)
          )
         )
        )
       )
      )
     )
    )
    (local.set $hi|47
     (block $~lib/util/math/log_inline|inlined.0 (result f64)
      (local.set $ix|17
       (local.get $ix)
      )
      (local.set $tmp
       (i64.sub
        (local.get $ix|17)
        (i64.const 4604531861337669632)
       )
      )
      (local.set $i
       (i32.wrap_i64
        (i64.and
         (i64.shr_u
          (local.get $tmp)
          (i64.sub
           (i64.const 52)
           (i64.extend_i32_s
            (i32.const 7)
           )
          )
         )
         (i64.extend_i32_s
          (i32.const 127)
         )
        )
       )
      )
      (local.set $k
       (i64.shr_s
        (local.get $tmp)
        (i64.const 52)
       )
      )
      (local.set $iz
       (i64.sub
        (local.get $ix|17)
        (i64.and
         (local.get $tmp)
         (i64.shl
          (i64.const 4095)
          (i64.const 52)
         )
        )
       )
      )
      (local.set $z
       (f64.reinterpret_i64
        (local.get $iz)
       )
      )
      (local.set $kd
       (f64.convert_i64_s
        (local.get $k)
       )
      )
      (local.set $invc
       (f64.load
        (i32.add
         (i32.const 2384)
         (i32.shl
          (local.get $i)
          (i32.add
           (i32.const 2)
           (i32.const 3)
          )
         )
        )
       )
      )
      (local.set $logc
       (f64.load offset=16
        (i32.add
         (i32.const 2384)
         (i32.shl
          (local.get $i)
          (i32.add
           (i32.const 2)
           (i32.const 3)
          )
         )
        )
       )
      )
      (local.set $logctail
       (f64.load offset=24
        (i32.add
         (i32.const 2384)
         (i32.shl
          (local.get $i)
          (i32.add
           (i32.const 2)
           (i32.const 3)
          )
         )
        )
       )
      )
      (local.set $zhi
       (f64.reinterpret_i64
        (i64.and
         (i64.add
          (local.get $iz)
          (i64.const 2147483648)
         )
         (i64.const -4294967296)
        )
       )
      )
      (local.set $zlo
       (f64.sub
        (local.get $z)
        (local.get $zhi)
       )
      )
      (local.set $rhi
       (f64.sub
        (f64.mul
         (local.get $zhi)
         (local.get $invc)
        )
        (f64.const 1)
       )
      )
      (local.set $rlo
       (f64.mul
        (local.get $zlo)
        (local.get $invc)
       )
      )
      (local.set $r
       (f64.add
        (local.get $rhi)
        (local.get $rlo)
       )
      )
      (local.set $t1
       (f64.add
        (f64.mul
         (local.get $kd)
         (f64.const 0.6931471805598903)
        )
        (local.get $logc)
       )
      )
      (local.set $t2
       (f64.add
        (local.get $t1)
        (local.get $r)
       )
      )
      (local.set $lo1
       (f64.add
        (f64.mul
         (local.get $kd)
         (f64.const 5.497923018708371e-14)
        )
        (local.get $logctail)
       )
      )
      (local.set $lo2
       (f64.add
        (f64.sub
         (local.get $t1)
         (local.get $t2)
        )
        (local.get $r)
       )
      )
      (local.set $ar
       (f64.mul
        (f64.const -0.5)
        (local.get $r)
       )
      )
      (local.set $ar2
       (f64.mul
        (local.get $r)
        (local.get $ar)
       )
      )
      (local.set $ar3
       (f64.mul
        (local.get $r)
        (local.get $ar2)
       )
      )
      (local.set $arhi
       (f64.mul
        (f64.const -0.5)
        (local.get $rhi)
       )
      )
      (local.set $arhi2
       (f64.mul
        (local.get $rhi)
        (local.get $arhi)
       )
      )
      (local.set $hi
       (f64.add
        (local.get $t2)
        (local.get $arhi2)
       )
      )
      (local.set $lo3
       (f64.mul
        (local.get $rlo)
        (f64.add
         (local.get $ar)
         (local.get $arhi)
        )
       )
      )
      (local.set $lo4
       (f64.add
        (f64.sub
         (local.get $t2)
         (local.get $hi)
        )
        (local.get $arhi2)
       )
      )
      (local.set $p
       (f64.mul
        (local.get $ar3)
        (f64.add
         (f64.add
          (f64.const -0.6666666666666679)
          (f64.mul
           (local.get $r)
           (f64.const 0.5000000000000007)
          )
         )
         (f64.mul
          (local.get $ar2)
          (f64.add
           (f64.add
            (f64.const 0.7999999995323976)
            (f64.mul
             (local.get $r)
             (f64.const -0.6666666663487739)
            )
           )
           (f64.mul
            (local.get $ar2)
            (f64.add
             (f64.const -1.142909628459501)
             (f64.mul
              (local.get $r)
              (f64.const 1.0000415263675542)
             )
            )
           )
          )
         )
        )
       )
      )
      (local.set $lo
       (f64.add
        (f64.add
         (f64.add
          (f64.add
           (local.get $lo1)
           (local.get $lo2)
          )
          (local.get $lo3)
         )
         (local.get $lo4)
        )
        (local.get $p)
       )
      )
      (local.set $y|46
       (f64.add
        (local.get $hi)
        (local.get $lo)
       )
      )
      (global.set $~lib/util/math/log_tail
       (f64.add
        (f64.sub
         (local.get $hi)
         (local.get $y|46)
        )
        (local.get $lo)
       )
      )
      (br $~lib/util/math/log_inline|inlined.0
       (local.get $y|46)
      )
     )
    )
    (local.set $lo|48
     (global.get $~lib/util/math/log_tail)
    )
    (local.set $yhi
     (f64.reinterpret_i64
      (i64.and
       (local.get $iy)
       (i64.const -134217728)
      )
     )
    )
    (local.set $ylo
     (f64.sub
      (local.get $y|3)
      (local.get $yhi)
     )
    )
    (local.set $lhi
     (f64.reinterpret_i64
      (i64.and
       (i64.reinterpret_f64
        (local.get $hi|47)
       )
       (i64.const -134217728)
      )
     )
    )
    (local.set $llo
     (f64.add
      (f64.sub
       (local.get $hi|47)
       (local.get $lhi)
      )
      (local.get $lo|48)
     )
    )
    (local.set $ehi
     (f64.mul
      (local.get $yhi)
      (local.get $lhi)
     )
    )
    (local.set $elo
     (f64.add
      (f64.mul
       (local.get $ylo)
       (local.get $lhi)
      )
      (f64.mul
       (local.get $y|3)
       (local.get $llo)
      )
     )
    )
    (br $~lib/util/math/pow_lut|inlined.0
     (block $~lib/util/math/exp_inline|inlined.0 (result f64)
      (local.set $x|55
       (local.get $ehi)
      )
      (local.set $xtail
       (local.get $elo)
      )
      (local.set $sign_bias|57
       (local.get $sign_bias)
      )
      (local.set $ux
       (i64.reinterpret_f64
        (local.get $x|55)
       )
      )
      (local.set $abstop
       (i32.and
        (i32.wrap_i64
         (i64.shr_u
          (local.get $ux)
          (i64.const 52)
         )
        )
        (i32.const 2047)
       )
      )
      (if
       (i32.ge_u
        (i32.sub
         (local.get $abstop)
         (i32.const 969)
        )
        (i32.const 63)
       )
       (then
        (if
         (i32.ge_u
          (i32.sub
           (local.get $abstop)
           (i32.const 969)
          )
          (i32.const -2147483648)
         )
         (then
          (br $~lib/util/math/exp_inline|inlined.0
           (select
            (f64.const -1)
            (f64.const 1)
            (local.get $sign_bias|57)
           )
          )
         )
        )
        (if
         (i32.ge_u
          (local.get $abstop)
          (i32.const 1033)
         )
         (then
          (br $~lib/util/math/exp_inline|inlined.0
           (if (result f64)
            (i64.lt_s
             (local.get $ux)
             (i64.const 0)
            )
            (then
             (block $~lib/util/math/uflow|inlined.0 (result f64)
              (local.set $sign
               (local.get $sign_bias|57)
              )
              (br $~lib/util/math/uflow|inlined.0
               (block $~lib/util/math/xflow|inlined.0 (result f64)
                (local.set $sign|72
                 (local.get $sign)
                )
                (local.set $y|73
                 (f64.reinterpret_i64
                  (i64.const 1152921504606846976)
                 )
                )
                (br $~lib/util/math/xflow|inlined.0
                 (f64.mul
                  (select
                   (f64.neg
                    (local.get $y|73)
                   )
                   (local.get $y|73)
                   (local.get $sign|72)
                  )
                  (local.get $y|73)
                 )
                )
               )
              )
             )
            )
            (else
             (block $~lib/util/math/oflow|inlined.0 (result f64)
              (local.set $sign|74
               (local.get $sign_bias|57)
              )
              (br $~lib/util/math/oflow|inlined.0
               (block $~lib/util/math/xflow|inlined.1 (result f64)
                (local.set $sign|75
                 (local.get $sign|74)
                )
                (local.set $y|76
                 (f64.reinterpret_i64
                  (i64.const 8070450532247928832)
                 )
                )
                (br $~lib/util/math/xflow|inlined.1
                 (f64.mul
                  (select
                   (f64.neg
                    (local.get $y|76)
                   )
                   (local.get $y|76)
                   (local.get $sign|75)
                  )
                  (local.get $y|76)
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
        (local.set $abstop
         (i32.const 0)
        )
       )
      )
      (local.set $z|64
       (f64.mul
        (f64.const 184.6649652337873)
        (local.get $x|55)
       )
      )
      (local.set $kd|63
       (f64.add
        (local.get $z|64)
        (f64.const 6755399441055744)
       )
      )
      (local.set $ki
       (i64.reinterpret_f64
        (local.get $kd|63)
       )
      )
      (local.set $kd|63
       (f64.sub
        (local.get $kd|63)
        (f64.const 6755399441055744)
       )
      )
      (local.set $r|65
       (f64.add
        (f64.add
         (local.get $x|55)
         (f64.mul
          (local.get $kd|63)
          (f64.const -0.005415212348111709)
         )
        )
        (f64.mul
         (local.get $kd|63)
         (f64.const -1.2864023111638346e-14)
        )
       )
      )
      (local.set $r|65
       (f64.add
        (local.get $r|65)
        (local.get $xtail)
       )
      )
      (local.set $idx
       (i32.wrap_i64
        (i64.shl
         (i64.and
          (local.get $ki)
          (i64.extend_i32_s
           (i32.const 127)
          )
         )
         (i64.const 1)
        )
       )
      )
      (local.set $top
       (i64.shl
        (i64.add
         (local.get $ki)
         (i64.extend_i32_u
          (local.get $sign_bias|57)
         )
        )
        (i64.sub
         (i64.const 52)
         (i64.extend_i32_s
          (i32.const 7)
         )
        )
       )
      )
      (local.set $tail
       (f64.reinterpret_i64
        (i64.load
         (i32.add
          (i32.const 6480)
          (i32.shl
           (local.get $idx)
           (i32.const 3)
          )
         )
        )
       )
      )
      (local.set $sbits
       (i64.add
        (i64.load offset=8
         (i32.add
          (i32.const 6480)
          (i32.shl
           (local.get $idx)
           (i32.const 3)
          )
         )
        )
        (local.get $top)
       )
      )
      (local.set $r2
       (f64.mul
        (local.get $r|65)
        (local.get $r|65)
       )
      )
      (local.set $tmp|69
       (f64.add
        (f64.add
         (f64.add
          (local.get $tail)
          (local.get $r|65)
         )
         (f64.mul
          (local.get $r2)
          (f64.add
           (f64.const 0.49999999999996786)
           (f64.mul
            (local.get $r|65)
            (f64.const 0.16666666666665886)
           )
          )
         )
        )
        (f64.mul
         (f64.mul
          (local.get $r2)
          (local.get $r2)
         )
         (f64.add
          (f64.const 0.0416666808410674)
          (f64.mul
           (local.get $r|65)
           (f64.const 0.008333335853059549)
          )
         )
        )
       )
      )
      (if
       (i32.eq
        (local.get $abstop)
        (i32.const 0)
       )
       (then
        (br $~lib/util/math/exp_inline|inlined.0
         (block $~lib/util/math/specialcase|inlined.0 (result f64)
          (local.set $tmp|77
           (local.get $tmp|69)
          )
          (local.set $sbits|78
           (local.get $sbits)
          )
          (local.set $ki|79
           (local.get $ki)
          )
          (if
           (i32.eqz
            (i64.ne
             (i64.and
              (local.get $ki|79)
              (i64.const 2147483648)
             )
             (i64.const 0)
            )
           )
           (then
            (local.set $sbits|78
             (i64.sub
              (local.get $sbits|78)
              (i64.shl
               (i64.const 1009)
               (i64.const 52)
              )
             )
            )
            (local.set $scale|80
             (f64.reinterpret_i64
              (local.get $sbits|78)
             )
            )
            (br $~lib/util/math/specialcase|inlined.0
             (f64.mul
              (f64.const 5486124068793688683255936e279)
              (f64.add
               (local.get $scale|80)
               (f64.mul
                (local.get $scale|80)
                (local.get $tmp|77)
               )
              )
             )
            )
           )
          )
          (local.set $sbits|78
           (i64.add
            (local.get $sbits|78)
            (i64.shl
             (i64.const 1022)
             (i64.const 52)
            )
           )
          )
          (local.set $scale|80
           (f64.reinterpret_i64
            (local.get $sbits|78)
           )
          )
          (local.set $y|81
           (f64.add
            (local.get $scale|80)
            (f64.mul
             (local.get $scale|80)
             (local.get $tmp|77)
            )
           )
          )
          (if
           (f64.lt
            (f64.abs
             (local.get $y|81)
            )
            (f64.const 1)
           )
           (then
            (local.set $one
             (f64.copysign
              (f64.const 1)
              (local.get $y|81)
             )
            )
            (local.set $lo|83
             (f64.add
              (f64.sub
               (local.get $scale|80)
               (local.get $y|81)
              )
              (f64.mul
               (local.get $scale|80)
               (local.get $tmp|77)
              )
             )
            )
            (local.set $hi|84
             (f64.add
              (local.get $one)
              (local.get $y|81)
             )
            )
            (local.set $lo|83
             (f64.add
              (f64.add
               (f64.sub
                (local.get $one)
                (local.get $hi|84)
               )
               (local.get $y|81)
              )
              (local.get $lo|83)
             )
            )
            (local.set $y|81
             (f64.sub
              (f64.add
               (local.get $hi|84)
               (local.get $lo|83)
              )
              (local.get $one)
             )
            )
            (if
             (f64.eq
              (local.get $y|81)
              (f64.const 0)
             )
             (then
              (local.set $y|81
               (f64.reinterpret_i64
                (i64.and
                 (local.get $sbits|78)
                 (i64.const -9223372036854775808)
                )
               )
              )
             )
            )
           )
          )
          (br $~lib/util/math/specialcase|inlined.0
           (f64.mul
            (local.get $y|81)
            (f64.const 2.2250738585072014e-308)
           )
          )
         )
        )
       )
      )
      (local.set $scale
       (f64.reinterpret_i64
        (local.get $sbits)
       )
      )
      (br $~lib/util/math/exp_inline|inlined.0
       (f64.add
        (local.get $scale)
        (f64.mul
         (local.get $scale)
         (local.get $tmp|69)
        )
       )
      )
     )
    )
   )
  )
 )
 (func $~lib/util/number/genDigits (param $buffer i32) (param $w_frc i64) (param $w_exp i32) (param $mp_frc i64) (param $mp_exp i32) (param $delta i64) (param $sign i32) (result i32)
  (local $one_exp i32)
  (local $one_frc i64)
  (local $mask i64)
  (local $wp_w_frc i64)
  (local $p1 i32)
  (local $p2 i64)
  (local $kappa i32)
  (local $len i32)
  (local $d i32)
  (local $16 i32)
  (local $17 i32)
  (local $tmp i64)
  (local $buffer|19 i32)
  (local $len|20 i32)
  (local $delta|21 i64)
  (local $rest i64)
  (local $ten_kappa i64)
  (local $wp_w i64)
  (local $lastp i32)
  (local $digit i32)
  (local $d|27 i64)
  (local $28 i32)
  (local $buffer|29 i32)
  (local $len|30 i32)
  (local $delta|31 i64)
  (local $rest|32 i64)
  (local $ten_kappa|33 i64)
  (local $wp_w|34 i64)
  (local $lastp|35 i32)
  (local $digit|36 i32)
  (local.set $one_exp
   (i32.sub
    (i32.const 0)
    (local.get $mp_exp)
   )
  )
  (local.set $one_frc
   (i64.shl
    (i64.const 1)
    (i64.extend_i32_s
     (local.get $one_exp)
    )
   )
  )
  (local.set $mask
   (i64.sub
    (local.get $one_frc)
    (i64.const 1)
   )
  )
  (local.set $wp_w_frc
   (i64.sub
    (local.get $mp_frc)
    (local.get $w_frc)
   )
  )
  (local.set $p1
   (i32.wrap_i64
    (i64.shr_u
     (local.get $mp_frc)
     (i64.extend_i32_s
      (local.get $one_exp)
     )
    )
   )
  )
  (local.set $p2
   (i64.and
    (local.get $mp_frc)
    (local.get $mask)
   )
  )
  (local.set $kappa
   (call $~lib/util/number/decimalCount32
    (local.get $p1)
   )
  )
  (local.set $len
   (local.get $sign)
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.gt_s
      (local.get $kappa)
      (i32.const 0)
     )
     (then
      (block $break|1
       (block $case10|1
        (block $case9|1
         (block $case8|1
          (block $case7|1
           (block $case6|1
            (block $case5|1
             (block $case4|1
              (block $case3|1
               (block $case2|1
                (block $case1|1
                 (block $case0|1
                  (local.set $16
                   (local.get $kappa)
                  )
                  (br_if $case0|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 10)
                   )
                  )
                  (br_if $case1|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 9)
                   )
                  )
                  (br_if $case2|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 8)
                   )
                  )
                  (br_if $case3|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 7)
                   )
                  )
                  (br_if $case4|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 6)
                   )
                  )
                  (br_if $case5|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 5)
                   )
                  )
                  (br_if $case6|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 4)
                   )
                  )
                  (br_if $case7|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 3)
                   )
                  )
                  (br_if $case8|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 2)
                   )
                  )
                  (br_if $case9|1
                   (i32.eq
                    (local.get $16)
                    (i32.const 1)
                   )
                  )
                  (br $case10|1)
                 )
                 (block
                  (local.set $d
                   (i32.div_u
                    (local.get $p1)
                    (i32.const 1000000000)
                   )
                  )
                  (local.set $p1
                   (i32.rem_u
                    (local.get $p1)
                    (i32.const 1000000000)
                   )
                  )
                  (br $break|1)
                 )
                )
                (block
                 (local.set $d
                  (i32.div_u
                   (local.get $p1)
                   (i32.const 100000000)
                  )
                 )
                 (local.set $p1
                  (i32.rem_u
                   (local.get $p1)
                   (i32.const 100000000)
                  )
                 )
                 (br $break|1)
                )
               )
               (block
                (local.set $d
                 (i32.div_u
                  (local.get $p1)
                  (i32.const 10000000)
                 )
                )
                (local.set $p1
                 (i32.rem_u
                  (local.get $p1)
                  (i32.const 10000000)
                 )
                )
                (br $break|1)
               )
              )
              (block
               (local.set $d
                (i32.div_u
                 (local.get $p1)
                 (i32.const 1000000)
                )
               )
               (local.set $p1
                (i32.rem_u
                 (local.get $p1)
                 (i32.const 1000000)
                )
               )
               (br $break|1)
              )
             )
             (block
              (local.set $d
               (i32.div_u
                (local.get $p1)
                (i32.const 100000)
               )
              )
              (local.set $p1
               (i32.rem_u
                (local.get $p1)
                (i32.const 100000)
               )
              )
              (br $break|1)
             )
            )
            (block
             (local.set $d
              (i32.div_u
               (local.get $p1)
               (i32.const 10000)
              )
             )
             (local.set $p1
              (i32.rem_u
               (local.get $p1)
               (i32.const 10000)
              )
             )
             (br $break|1)
            )
           )
           (block
            (local.set $d
             (i32.div_u
              (local.get $p1)
              (i32.const 1000)
             )
            )
            (local.set $p1
             (i32.rem_u
              (local.get $p1)
              (i32.const 1000)
             )
            )
            (br $break|1)
           )
          )
          (block
           (local.set $d
            (i32.div_u
             (local.get $p1)
             (i32.const 100)
            )
           )
           (local.set $p1
            (i32.rem_u
             (local.get $p1)
             (i32.const 100)
            )
           )
           (br $break|1)
          )
         )
         (block
          (local.set $d
           (i32.div_u
            (local.get $p1)
            (i32.const 10)
           )
          )
          (local.set $p1
           (i32.rem_u
            (local.get $p1)
            (i32.const 10)
           )
          )
          (br $break|1)
         )
        )
        (block
         (local.set $d
          (local.get $p1)
         )
         (local.set $p1
          (i32.const 0)
         )
         (br $break|1)
        )
       )
       (block
        (local.set $d
         (i32.const 0)
        )
        (br $break|1)
       )
      )
      (if
       (i32.or
        (local.get $d)
        (local.get $len)
       )
       (then
        (i32.store16
         (i32.add
          (local.get $buffer)
          (i32.shl
           (block (result i32)
            (local.set $len
             (i32.add
              (local.tee $17
               (local.get $len)
              )
              (i32.const 1)
             )
            )
            (local.get $17)
           )
           (i32.const 1)
          )
         )
         (i32.add
          (i32.const 48)
          (i32.and
           (local.get $d)
           (i32.const 65535)
          )
         )
        )
       )
      )
      (local.set $kappa
       (i32.sub
        (local.get $kappa)
        (i32.const 1)
       )
      )
      (local.set $tmp
       (i64.add
        (i64.shl
         (i64.extend_i32_u
          (local.get $p1)
         )
         (i64.extend_i32_s
          (local.get $one_exp)
         )
        )
        (local.get $p2)
       )
      )
      (if
       (i64.le_u
        (local.get $tmp)
        (local.get $delta)
       )
       (then
        (global.set $~lib/util/number/_K
         (i32.add
          (global.get $~lib/util/number/_K)
          (local.get $kappa)
         )
        )
        (block $~lib/util/number/grisuRound|inlined.0
         (local.set $buffer|19
          (local.get $buffer)
         )
         (local.set $len|20
          (local.get $len)
         )
         (local.set $delta|21
          (local.get $delta)
         )
         (local.set $rest
          (local.get $tmp)
         )
         (local.set $ten_kappa
          (i64.shl
           (i64.load32_u
            (i32.add
             (i32.const 9632)
             (i32.shl
              (local.get $kappa)
              (i32.const 2)
             )
            )
           )
           (i64.extend_i32_s
            (local.get $one_exp)
           )
          )
         )
         (local.set $wp_w
          (local.get $wp_w_frc)
         )
         (local.set $lastp
          (i32.add
           (local.get $buffer|19)
           (i32.shl
            (i32.sub
             (local.get $len|20)
             (i32.const 1)
            )
            (i32.const 1)
           )
          )
         )
         (local.set $digit
          (i32.load16_u
           (local.get $lastp)
          )
         )
         (block $while-break|3
          (loop $while-continue|3
           (if
            (if (result i32)
             (if (result i32)
              (i64.lt_u
               (local.get $rest)
               (local.get $wp_w)
              )
              (then
               (i64.ge_u
                (i64.sub
                 (local.get $delta|21)
                 (local.get $rest)
                )
                (local.get $ten_kappa)
               )
              )
              (else
               (i32.const 0)
              )
             )
             (then
              (if (result i32)
               (i64.lt_u
                (i64.add
                 (local.get $rest)
                 (local.get $ten_kappa)
                )
                (local.get $wp_w)
               )
               (then
                (i32.const 1)
               )
               (else
                (i64.gt_u
                 (i64.sub
                  (local.get $wp_w)
                  (local.get $rest)
                 )
                 (i64.sub
                  (i64.add
                   (local.get $rest)
                   (local.get $ten_kappa)
                  )
                  (local.get $wp_w)
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
             (local.set $digit
              (i32.sub
               (local.get $digit)
               (i32.const 1)
              )
             )
             (local.set $rest
              (i64.add
               (local.get $rest)
               (local.get $ten_kappa)
              )
             )
             (br $while-continue|3)
            )
           )
          )
         )
         (i32.store16
          (local.get $lastp)
          (local.get $digit)
         )
        )
        (return
         (local.get $len)
        )
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (block $while-break|4
   (loop $while-continue|4
    (if
     (i32.const 1)
     (then
      (local.set $p2
       (i64.mul
        (local.get $p2)
        (i64.const 10)
       )
      )
      (local.set $delta
       (i64.mul
        (local.get $delta)
        (i64.const 10)
       )
      )
      (local.set $d|27
       (i64.shr_u
        (local.get $p2)
        (i64.extend_i32_s
         (local.get $one_exp)
        )
       )
      )
      (if
       (i64.ne
        (i64.or
         (local.get $d|27)
         (i64.extend_i32_s
          (local.get $len)
         )
        )
        (i64.const 0)
       )
       (then
        (i32.store16
         (i32.add
          (local.get $buffer)
          (i32.shl
           (block (result i32)
            (local.set $len
             (i32.add
              (local.tee $28
               (local.get $len)
              )
              (i32.const 1)
             )
            )
            (local.get $28)
           )
           (i32.const 1)
          )
         )
         (i32.add
          (i32.const 48)
          (i32.and
           (i32.wrap_i64
            (local.get $d|27)
           )
           (i32.const 65535)
          )
         )
        )
       )
      )
      (local.set $p2
       (i64.and
        (local.get $p2)
        (local.get $mask)
       )
      )
      (local.set $kappa
       (i32.sub
        (local.get $kappa)
        (i32.const 1)
       )
      )
      (if
       (i64.lt_u
        (local.get $p2)
        (local.get $delta)
       )
       (then
        (global.set $~lib/util/number/_K
         (i32.add
          (global.get $~lib/util/number/_K)
          (local.get $kappa)
         )
        )
        (local.set $wp_w_frc
         (i64.mul
          (local.get $wp_w_frc)
          (i64.load32_u
           (i32.add
            (i32.const 9632)
            (i32.shl
             (i32.sub
              (i32.const 0)
              (local.get $kappa)
             )
             (i32.const 2)
            )
           )
          )
         )
        )
        (block $~lib/util/number/grisuRound|inlined.1
         (local.set $buffer|29
          (local.get $buffer)
         )
         (local.set $len|30
          (local.get $len)
         )
         (local.set $delta|31
          (local.get $delta)
         )
         (local.set $rest|32
          (local.get $p2)
         )
         (local.set $ten_kappa|33
          (local.get $one_frc)
         )
         (local.set $wp_w|34
          (local.get $wp_w_frc)
         )
         (local.set $lastp|35
          (i32.add
           (local.get $buffer|29)
           (i32.shl
            (i32.sub
             (local.get $len|30)
             (i32.const 1)
            )
            (i32.const 1)
           )
          )
         )
         (local.set $digit|36
          (i32.load16_u
           (local.get $lastp|35)
          )
         )
         (block $while-break|6
          (loop $while-continue|6
           (if
            (if (result i32)
             (if (result i32)
              (i64.lt_u
               (local.get $rest|32)
               (local.get $wp_w|34)
              )
              (then
               (i64.ge_u
                (i64.sub
                 (local.get $delta|31)
                 (local.get $rest|32)
                )
                (local.get $ten_kappa|33)
               )
              )
              (else
               (i32.const 0)
              )
             )
             (then
              (if (result i32)
               (i64.lt_u
                (i64.add
                 (local.get $rest|32)
                 (local.get $ten_kappa|33)
                )
                (local.get $wp_w|34)
               )
               (then
                (i32.const 1)
               )
               (else
                (i64.gt_u
                 (i64.sub
                  (local.get $wp_w|34)
                  (local.get $rest|32)
                 )
                 (i64.sub
                  (i64.add
                   (local.get $rest|32)
                   (local.get $ten_kappa|33)
                  )
                  (local.get $wp_w|34)
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
             (local.set $digit|36
              (i32.sub
               (local.get $digit|36)
               (i32.const 1)
              )
             )
             (local.set $rest|32
              (i64.add
               (local.get $rest|32)
               (local.get $ten_kappa|33)
              )
             )
             (br $while-continue|6)
            )
           )
          )
         )
         (i32.store16
          (local.get $lastp|35)
          (local.get $digit|36)
         )
        )
        (return
         (local.get $len)
        )
       )
      )
      (br $while-continue|4)
     )
    )
   )
   (unreachable)
  )
 )
 (func $~lib/util/number/prettify (param $buffer i32) (param $length i32) (param $k i32) (result i32)
  (local $kk i32)
  (local $i i32)
  (local $ptr i32)
  (local $offset i32)
  (local $i|7 i32)
  (local $buffer|8 i32)
  (local $k|9 i32)
  (local $sign i32)
  (local $decimals i32)
  (local $buffer|12 i32)
  (local $num i32)
  (local $offset|14 i32)
  (local $len i32)
  (local $buffer|16 i32)
  (local $k|17 i32)
  (local $sign|18 i32)
  (local $decimals|19 i32)
  (local $buffer|20 i32)
  (local $num|21 i32)
  (local $offset|22 i32)
  (if
   (i32.eqz
    (local.get $k)
   )
   (then
    (i32.store
     (i32.add
      (local.get $buffer)
      (i32.shl
       (local.get $length)
       (i32.const 1)
      )
     )
     (i32.or
      (i32.const 46)
      (i32.shl
       (i32.const 48)
       (i32.const 16)
      )
     )
    )
    (return
     (i32.add
      (local.get $length)
      (i32.const 2)
     )
    )
   )
  )
  (local.set $kk
   (i32.add
    (local.get $length)
    (local.get $k)
   )
  )
  (if
   (if (result i32)
    (i32.le_s
     (local.get $length)
     (local.get $kk)
    )
    (then
     (i32.le_s
      (local.get $kk)
      (i32.const 21)
     )
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (local.set $i
     (local.get $length)
    )
    (loop $for-loop|0
     (if
      (i32.lt_s
       (local.get $i)
       (local.get $kk)
      )
      (then
       (i32.store16
        (i32.add
         (local.get $buffer)
         (i32.shl
          (local.get $i)
          (i32.const 1)
         )
        )
        (i32.const 48)
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
    (i32.store
     (i32.add
      (local.get $buffer)
      (i32.shl
       (local.get $kk)
       (i32.const 1)
      )
     )
     (i32.or
      (i32.const 46)
      (i32.shl
       (i32.const 48)
       (i32.const 16)
      )
     )
    )
    (return
     (i32.add
      (local.get $kk)
      (i32.const 2)
     )
    )
   )
   (else
    (if
     (if (result i32)
      (i32.gt_s
       (local.get $kk)
       (i32.const 0)
      )
      (then
       (i32.le_s
        (local.get $kk)
        (i32.const 21)
       )
      )
      (else
       (i32.const 0)
      )
     )
     (then
      (local.set $ptr
       (i32.add
        (local.get $buffer)
        (i32.shl
         (local.get $kk)
         (i32.const 1)
        )
       )
      )
      (memory.copy
       (i32.add
        (local.get $ptr)
        (i32.const 2)
       )
       (local.get $ptr)
       (i32.shl
        (i32.sub
         (i32.const 0)
         (local.get $k)
        )
        (i32.const 1)
       )
      )
      (i32.store16
       (i32.add
        (local.get $buffer)
        (i32.shl
         (local.get $kk)
         (i32.const 1)
        )
       )
       (i32.const 46)
      )
      (return
       (i32.add
        (local.get $length)
        (i32.const 1)
       )
      )
     )
     (else
      (if
       (if (result i32)
        (i32.lt_s
         (i32.const -6)
         (local.get $kk)
        )
        (then
         (i32.le_s
          (local.get $kk)
          (i32.const 0)
         )
        )
        (else
         (i32.const 0)
        )
       )
       (then
        (local.set $offset
         (i32.sub
          (i32.const 2)
          (local.get $kk)
         )
        )
        (memory.copy
         (i32.add
          (local.get $buffer)
          (i32.shl
           (local.get $offset)
           (i32.const 1)
          )
         )
         (local.get $buffer)
         (i32.shl
          (local.get $length)
          (i32.const 1)
         )
        )
        (i32.store
         (local.get $buffer)
         (i32.or
          (i32.const 48)
          (i32.shl
           (i32.const 46)
           (i32.const 16)
          )
         )
        )
        (local.set $i|7
         (i32.const 2)
        )
        (loop $for-loop|1
         (if
          (i32.lt_s
           (local.get $i|7)
           (local.get $offset)
          )
          (then
           (i32.store16
            (i32.add
             (local.get $buffer)
             (i32.shl
              (local.get $i|7)
              (i32.const 1)
             )
            )
            (i32.const 48)
           )
           (local.set $i|7
            (i32.add
             (local.get $i|7)
             (i32.const 1)
            )
           )
           (br $for-loop|1)
          )
         )
        )
        (return
         (i32.add
          (local.get $length)
          (local.get $offset)
         )
        )
       )
       (else
        (if
         (i32.eq
          (local.get $length)
          (i32.const 1)
         )
         (then
          (i32.store16 offset=2
           (local.get $buffer)
           (i32.const 101)
          )
          (local.set $length
           (block $~lib/util/number/genExponent|inlined.0 (result i32)
            (local.set $buffer|8
             (i32.add
              (local.get $buffer)
              (i32.const 4)
             )
            )
            (local.set $k|9
             (i32.sub
              (local.get $kk)
              (i32.const 1)
             )
            )
            (local.set $sign
             (i32.lt_s
              (local.get $k|9)
              (i32.const 0)
             )
            )
            (if
             (local.get $sign)
             (then
              (local.set $k|9
               (i32.sub
                (i32.const 0)
                (local.get $k|9)
               )
              )
             )
            )
            (local.set $decimals
             (i32.add
              (call $~lib/util/number/decimalCount32
               (local.get $k|9)
              )
              (i32.const 1)
             )
            )
            (block $~lib/util/number/utoa32_dec_core|inlined.1
             (local.set $buffer|12
              (local.get $buffer|8)
             )
             (local.set $num
              (local.get $k|9)
             )
             (local.set $offset|14
              (local.get $decimals)
             )
             (drop
              (i32.ge_s
               (i32.const 0)
               (i32.const 1)
              )
             )
             (call $~lib/util/number/utoa32_dec_lut
              (local.get $buffer|12)
              (local.get $num)
              (local.get $offset|14)
             )
            )
            (i32.store16
             (local.get $buffer|8)
             (select
              (i32.const 45)
              (i32.const 43)
              (local.get $sign)
             )
            )
            (br $~lib/util/number/genExponent|inlined.0
             (local.get $decimals)
            )
           )
          )
          (return
           (i32.add
            (local.get $length)
            (i32.const 2)
           )
          )
         )
         (else
          (local.set $len
           (i32.shl
            (local.get $length)
            (i32.const 1)
           )
          )
          (memory.copy
           (i32.add
            (local.get $buffer)
            (i32.const 4)
           )
           (i32.add
            (local.get $buffer)
            (i32.const 2)
           )
           (i32.sub
            (local.get $len)
            (i32.const 2)
           )
          )
          (i32.store16 offset=2
           (local.get $buffer)
           (i32.const 46)
          )
          (i32.store16 offset=2
           (i32.add
            (local.get $buffer)
            (local.get $len)
           )
           (i32.const 101)
          )
          (local.set $length
           (i32.add
            (local.get $length)
            (block $~lib/util/number/genExponent|inlined.1 (result i32)
             (local.set $buffer|16
              (i32.add
               (i32.add
                (local.get $buffer)
                (local.get $len)
               )
               (i32.const 4)
              )
             )
             (local.set $k|17
              (i32.sub
               (local.get $kk)
               (i32.const 1)
              )
             )
             (local.set $sign|18
              (i32.lt_s
               (local.get $k|17)
               (i32.const 0)
              )
             )
             (if
              (local.get $sign|18)
              (then
               (local.set $k|17
                (i32.sub
                 (i32.const 0)
                 (local.get $k|17)
                )
               )
              )
             )
             (local.set $decimals|19
              (i32.add
               (call $~lib/util/number/decimalCount32
                (local.get $k|17)
               )
               (i32.const 1)
              )
             )
             (block $~lib/util/number/utoa32_dec_core|inlined.2
              (local.set $buffer|20
               (local.get $buffer|16)
              )
              (local.set $num|21
               (local.get $k|17)
              )
              (local.set $offset|22
               (local.get $decimals|19)
              )
              (drop
               (i32.ge_s
                (i32.const 0)
                (i32.const 1)
               )
              )
              (call $~lib/util/number/utoa32_dec_lut
               (local.get $buffer|20)
               (local.get $num|21)
               (local.get $offset|22)
              )
             )
             (i32.store16
              (local.get $buffer|16)
              (select
               (i32.const 45)
               (i32.const 43)
               (local.get $sign|18)
              )
             )
             (br $~lib/util/number/genExponent|inlined.1
              (local.get $decimals|19)
             )
            )
           )
          )
          (return
           (i32.add
            (local.get $length)
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
  )
 )
 (func $~lib/util/number/dtoa_core (param $buffer i32) (param $value f64) (param $isSingle i32) (result i32)
  (local $sign i32)
  (local $value|4 f64)
  (local $buffer|5 i32)
  (local $sign|6 i32)
  (local $isSingle|7 i32)
  (local $frc i64)
  (local $exp i32)
  (local $uv i32)
  (local $sid i32)
  (local $uv|12 i64)
  (local $sid|13 i64)
  (local $f i64)
  (local $e i32)
  (local $isSingle|16 i32)
  (local $frc|17 i64)
  (local $exp|18 i32)
  (local $off i32)
  (local $m i32)
  (local $minExp i32)
  (local $dk f64)
  (local $k i32)
  (local $index i32)
  (local $off|25 i32)
  (local $frc_pow i64)
  (local $exp_pow i32)
  (local $u i64)
  (local $v i64)
  (local $u0 i64)
  (local $v0 i64)
  (local $u1 i64)
  (local $v1 i64)
  (local $l i64)
  (local $t i64)
  (local $w i64)
  (local $w_frc i64)
  (local $e1 i32)
  (local $e2 i32)
  (local $w_exp i32)
  (local $u|41 i64)
  (local $v|42 i64)
  (local $u0|43 i64)
  (local $v0|44 i64)
  (local $u1|45 i64)
  (local $v1|46 i64)
  (local $l|47 i64)
  (local $t|48 i64)
  (local $w|49 i64)
  (local $wp_frc i64)
  (local $e1|51 i32)
  (local $e2|52 i32)
  (local $wp_exp i32)
  (local $u|54 i64)
  (local $v|55 i64)
  (local $u0|56 i64)
  (local $v0|57 i64)
  (local $u1|58 i64)
  (local $v1|59 i64)
  (local $l|60 i64)
  (local $t|61 i64)
  (local $w|62 i64)
  (local $wm_frc i64)
  (local $delta i64)
  (local $len i32)
  (local.set $sign
   (f64.lt
    (local.get $value)
    (f64.const 0)
   )
  )
  (if
   (local.get $sign)
   (then
    (local.set $value
     (f64.neg
      (local.get $value)
     )
    )
    (i32.store16
     (local.get $buffer)
     (i32.const 45)
    )
   )
  )
  (local.set $len
   (block $~lib/util/number/grisu2|inlined.0 (result i32)
    (local.set $value|4
     (local.get $value)
    )
    (local.set $buffer|5
     (local.get $buffer)
    )
    (local.set $sign|6
     (local.get $sign)
    )
    (local.set $isSingle|7
     (local.get $isSingle)
    )
    (if
     (local.get $isSingle|7)
     (then
      (local.set $uv
       (i32.reinterpret_f32
        (f32.demote_f64
         (local.get $value|4)
        )
       )
      )
      (local.set $exp
       (i32.shr_u
        (i32.and
         (local.get $uv)
         (i32.const 2139095040)
        )
        (i32.const 23)
       )
      )
      (local.set $sid
       (i32.and
        (local.get $uv)
        (i32.const 8388607)
       )
      )
      (local.set $frc
       (i64.add
        (i64.shl
         (i64.extend_i32_u
          (i32.ne
           (local.get $exp)
           (i32.const 0)
          )
         )
         (i64.const 23)
        )
        (i64.extend_i32_u
         (local.get $sid)
        )
       )
      )
      (local.set $exp
       (i32.sub
        (if (result i32)
         (local.get $exp)
         (then
          (local.get $exp)
         )
         (else
          (i32.const 1)
         )
        )
        (i32.add
         (i32.const 127)
         (i32.const 23)
        )
       )
      )
     )
     (else
      (local.set $uv|12
       (i64.reinterpret_f64
        (local.get $value|4)
       )
      )
      (local.set $exp
       (i32.wrap_i64
        (i64.shr_u
         (i64.and
          (local.get $uv|12)
          (i64.const 9218868437227405312)
         )
         (i64.const 52)
        )
       )
      )
      (local.set $sid|13
       (i64.and
        (local.get $uv|12)
        (i64.const 4503599627370495)
       )
      )
      (local.set $frc
       (i64.add
        (i64.shl
         (i64.extend_i32_u
          (i32.ne
           (local.get $exp)
           (i32.const 0)
          )
         )
         (i64.const 52)
        )
        (local.get $sid|13)
       )
      )
      (local.set $exp
       (i32.sub
        (if (result i32)
         (local.get $exp)
         (then
          (local.get $exp)
         )
         (else
          (i32.const 1)
         )
        )
        (i32.add
         (i32.const 1023)
         (i32.const 52)
        )
       )
      )
     )
    )
    (block $~lib/util/number/normalizedBoundaries|inlined.0
     (local.set $f
      (local.get $frc)
     )
     (local.set $e
      (local.get $exp)
     )
     (local.set $isSingle|16
      (local.get $isSingle|7)
     )
     (local.set $frc|17
      (i64.add
       (i64.shl
        (local.get $f)
        (i64.const 1)
       )
       (i64.const 1)
      )
     )
     (local.set $exp|18
      (i32.sub
       (local.get $e)
       (i32.const 1)
      )
     )
     (local.set $off
      (i32.wrap_i64
       (i64.clz
        (local.get $frc|17)
       )
      )
     )
     (local.set $frc|17
      (i64.shl
       (local.get $frc|17)
       (i64.extend_i32_s
        (local.get $off)
       )
      )
     )
     (local.set $exp|18
      (i32.sub
       (local.get $exp|18)
       (local.get $off)
      )
     )
     (local.set $m
      (i32.add
       (i32.const 1)
       (i64.eq
        (local.get $f)
        (if (result i64)
         (local.get $isSingle|16)
         (then
          (i64.const 8388608)
         )
         (else
          (i64.const 4503599627370496)
         )
        )
       )
      )
     )
     (global.set $~lib/util/number/_frc_plus
      (local.get $frc|17)
     )
     (global.set $~lib/util/number/_frc_minus
      (i64.shl
       (i64.sub
        (i64.shl
         (local.get $f)
         (i64.extend_i32_s
          (local.get $m)
         )
        )
        (i64.const 1)
       )
       (i64.extend_i32_s
        (i32.sub
         (i32.sub
          (local.get $e)
          (local.get $m)
         )
         (local.get $exp|18)
        )
       )
      )
     )
     (global.set $~lib/util/number/_exp
      (local.get $exp|18)
     )
    )
    (block $~lib/util/number/getCachedPower|inlined.0
     (local.set $minExp
      (global.get $~lib/util/number/_exp)
     )
     (local.set $dk
      (f64.add
       (f64.mul
        (f64.convert_i32_s
         (i32.sub
          (i32.const -61)
          (local.get $minExp)
         )
        )
        (f64.const 0.30102999566398114)
       )
       (f64.const 347)
      )
     )
     (local.set $k
      (i32.trunc_f64_s
       (local.get $dk)
      )
     )
     (local.set $k
      (i32.add
       (local.get $k)
       (f64.ne
        (f64.convert_i32_s
         (local.get $k)
        )
        (local.get $dk)
       )
      )
     )
     (local.set $index
      (i32.add
       (i32.shr_s
        (local.get $k)
        (i32.const 3)
       )
       (i32.const 1)
      )
     )
     (global.set $~lib/util/number/_K
      (i32.sub
       (i32.const 348)
       (i32.shl
        (local.get $index)
        (i32.const 3)
       )
      )
     )
     (global.set $~lib/util/number/_frc_pow
      (i64.load
       (i32.add
        (i32.const 8760)
        (i32.shl
         (local.get $index)
         (i32.const 3)
        )
       )
      )
     )
     (global.set $~lib/util/number/_exp_pow
      (i32.load16_s
       (i32.add
        (i32.const 9456)
        (i32.shl
         (local.get $index)
         (i32.const 1)
        )
       )
      )
     )
    )
    (local.set $off|25
     (i32.wrap_i64
      (i64.clz
       (local.get $frc)
      )
     )
    )
    (local.set $frc
     (i64.shl
      (local.get $frc)
      (i64.extend_i32_s
       (local.get $off|25)
      )
     )
    )
    (local.set $exp
     (i32.sub
      (local.get $exp)
      (local.get $off|25)
     )
    )
    (local.set $frc_pow
     (global.get $~lib/util/number/_frc_pow)
    )
    (local.set $exp_pow
     (global.get $~lib/util/number/_exp_pow)
    )
    (local.set $w_frc
     (block $~lib/util/number/umul64f|inlined.0 (result i64)
      (local.set $u
       (local.get $frc)
      )
      (local.set $v
       (local.get $frc_pow)
      )
      (local.set $u0
       (i64.and
        (local.get $u)
        (i64.const 4294967295)
       )
      )
      (local.set $v0
       (i64.and
        (local.get $v)
        (i64.const 4294967295)
       )
      )
      (local.set $u1
       (i64.shr_u
        (local.get $u)
        (i64.const 32)
       )
      )
      (local.set $v1
       (i64.shr_u
        (local.get $v)
        (i64.const 32)
       )
      )
      (local.set $l
       (i64.mul
        (local.get $u0)
        (local.get $v0)
       )
      )
      (local.set $t
       (i64.add
        (i64.mul
         (local.get $u1)
         (local.get $v0)
        )
        (i64.shr_u
         (local.get $l)
         (i64.const 32)
        )
       )
      )
      (local.set $w
       (i64.add
        (i64.mul
         (local.get $u0)
         (local.get $v1)
        )
        (i64.and
         (local.get $t)
         (i64.const 4294967295)
        )
       )
      )
      (local.set $w
       (i64.add
        (local.get $w)
        (i64.const 2147483647)
       )
      )
      (local.set $t
       (i64.shr_u
        (local.get $t)
        (i64.const 32)
       )
      )
      (local.set $w
       (i64.shr_u
        (local.get $w)
        (i64.const 32)
       )
      )
      (br $~lib/util/number/umul64f|inlined.0
       (i64.add
        (i64.add
         (i64.mul
          (local.get $u1)
          (local.get $v1)
         )
         (local.get $t)
        )
        (local.get $w)
       )
      )
     )
    )
    (local.set $w_exp
     (block $~lib/util/number/umul64e|inlined.0 (result i32)
      (local.set $e1
       (local.get $exp)
      )
      (local.set $e2
       (local.get $exp_pow)
      )
      (br $~lib/util/number/umul64e|inlined.0
       (i32.add
        (i32.add
         (local.get $e1)
         (local.get $e2)
        )
        (i32.const 64)
       )
      )
     )
    )
    (local.set $wp_frc
     (i64.sub
      (block $~lib/util/number/umul64f|inlined.1 (result i64)
       (local.set $u|41
        (global.get $~lib/util/number/_frc_plus)
       )
       (local.set $v|42
        (local.get $frc_pow)
       )
       (local.set $u0|43
        (i64.and
         (local.get $u|41)
         (i64.const 4294967295)
        )
       )
       (local.set $v0|44
        (i64.and
         (local.get $v|42)
         (i64.const 4294967295)
        )
       )
       (local.set $u1|45
        (i64.shr_u
         (local.get $u|41)
         (i64.const 32)
        )
       )
       (local.set $v1|46
        (i64.shr_u
         (local.get $v|42)
         (i64.const 32)
        )
       )
       (local.set $l|47
        (i64.mul
         (local.get $u0|43)
         (local.get $v0|44)
        )
       )
       (local.set $t|48
        (i64.add
         (i64.mul
          (local.get $u1|45)
          (local.get $v0|44)
         )
         (i64.shr_u
          (local.get $l|47)
          (i64.const 32)
         )
        )
       )
       (local.set $w|49
        (i64.add
         (i64.mul
          (local.get $u0|43)
          (local.get $v1|46)
         )
         (i64.and
          (local.get $t|48)
          (i64.const 4294967295)
         )
        )
       )
       (local.set $w|49
        (i64.add
         (local.get $w|49)
         (i64.const 2147483647)
        )
       )
       (local.set $t|48
        (i64.shr_u
         (local.get $t|48)
         (i64.const 32)
        )
       )
       (local.set $w|49
        (i64.shr_u
         (local.get $w|49)
         (i64.const 32)
        )
       )
       (br $~lib/util/number/umul64f|inlined.1
        (i64.add
         (i64.add
          (i64.mul
           (local.get $u1|45)
           (local.get $v1|46)
          )
          (local.get $t|48)
         )
         (local.get $w|49)
        )
       )
      )
      (i64.const 1)
     )
    )
    (local.set $wp_exp
     (block $~lib/util/number/umul64e|inlined.1 (result i32)
      (local.set $e1|51
       (global.get $~lib/util/number/_exp)
      )
      (local.set $e2|52
       (local.get $exp_pow)
      )
      (br $~lib/util/number/umul64e|inlined.1
       (i32.add
        (i32.add
         (local.get $e1|51)
         (local.get $e2|52)
        )
        (i32.const 64)
       )
      )
     )
    )
    (local.set $wm_frc
     (i64.add
      (block $~lib/util/number/umul64f|inlined.2 (result i64)
       (local.set $u|54
        (global.get $~lib/util/number/_frc_minus)
       )
       (local.set $v|55
        (local.get $frc_pow)
       )
       (local.set $u0|56
        (i64.and
         (local.get $u|54)
         (i64.const 4294967295)
        )
       )
       (local.set $v0|57
        (i64.and
         (local.get $v|55)
         (i64.const 4294967295)
        )
       )
       (local.set $u1|58
        (i64.shr_u
         (local.get $u|54)
         (i64.const 32)
        )
       )
       (local.set $v1|59
        (i64.shr_u
         (local.get $v|55)
         (i64.const 32)
        )
       )
       (local.set $l|60
        (i64.mul
         (local.get $u0|56)
         (local.get $v0|57)
        )
       )
       (local.set $t|61
        (i64.add
         (i64.mul
          (local.get $u1|58)
          (local.get $v0|57)
         )
         (i64.shr_u
          (local.get $l|60)
          (i64.const 32)
         )
        )
       )
       (local.set $w|62
        (i64.add
         (i64.mul
          (local.get $u0|56)
          (local.get $v1|59)
         )
         (i64.and
          (local.get $t|61)
          (i64.const 4294967295)
         )
        )
       )
       (local.set $w|62
        (i64.add
         (local.get $w|62)
         (i64.const 2147483647)
        )
       )
       (local.set $t|61
        (i64.shr_u
         (local.get $t|61)
         (i64.const 32)
        )
       )
       (local.set $w|62
        (i64.shr_u
         (local.get $w|62)
         (i64.const 32)
        )
       )
       (br $~lib/util/number/umul64f|inlined.2
        (i64.add
         (i64.add
          (i64.mul
           (local.get $u1|58)
           (local.get $v1|59)
          )
          (local.get $t|61)
         )
         (local.get $w|62)
        )
       )
      )
      (i64.const 1)
     )
    )
    (local.set $delta
     (i64.sub
      (local.get $wp_frc)
      (local.get $wm_frc)
     )
    )
    (br $~lib/util/number/grisu2|inlined.0
     (call $~lib/util/number/genDigits
      (local.get $buffer|5)
      (local.get $w_frc)
      (local.get $w_exp)
      (local.get $wp_frc)
      (local.get $wp_exp)
      (local.get $delta)
      (local.get $sign|6)
     )
    )
   )
  )
  (local.set $len
   (call $~lib/util/number/prettify
    (i32.add
     (local.get $buffer)
     (i32.shl
      (local.get $sign)
      (i32.const 1)
     )
    )
    (i32.sub
     (local.get $len)
     (local.get $sign)
    )
    (global.get $~lib/util/number/_K)
   )
  )
  (return
   (i32.add
    (local.get $len)
    (local.get $sign)
   )
  )
 )
 (func $~lib/util/number/dtoa<f64> (param $value f64) (result i32)
  (local $value|1 f64)
  (local $isSingle i32)
  (local $size i32)
  (local $result i32)
  (return
   (block $~lib/util/number/dtoa_impl|inlined.0 (result i32)
    (local.set $value|1
     (local.get $value)
    )
    (local.set $isSingle
     (i32.const 0)
    )
    (if
     (f64.eq
      (local.get $value|1)
      (f64.const 0)
     )
     (then
      (br $~lib/util/number/dtoa_impl|inlined.0
       (i32.const 8560)
      )
     )
    )
    (if
     (i32.eqz
      (f64.eq
       (f64.sub
        (local.get $value|1)
        (local.get $value|1)
       )
       (f64.const 0)
      )
     )
     (then
      (if
       (f64.ne
        (local.get $value|1)
        (local.get $value|1)
       )
       (then
        (br $~lib/util/number/dtoa_impl|inlined.0
         (i32.const 8592)
        )
       )
      )
      (br $~lib/util/number/dtoa_impl|inlined.0
       (select
        (i32.const 8624)
        (i32.const 8672)
        (f64.lt
         (local.get $value|1)
         (f64.const 0)
        )
       )
      )
     )
    )
    (local.set $size
     (i32.shl
      (call $~lib/util/number/dtoa_core
       (i32.const 8704)
       (local.get $value|1)
       (local.get $isSingle)
      )
      (i32.const 1)
     )
    )
    (local.set $result
     (call $~lib/rt/__localtostack
      (call $~lib/rt/itcms/__new
       (local.get $size)
       (i32.const 2)
      )
     )
    )
    (memory.copy
     (local.get $result)
     (i32.const 8704)
     (local.get $size)
    )
    (br $~lib/util/number/dtoa_impl|inlined.0
     (local.get $result)
    )
   )
  )
 )
 (func $~lib/number/F64#toString (param $this f64) (param $radix i32) (result i32)
  (return
   (call $~lib/util/number/dtoa<f64>
    (local.get $this)
   )
  )
 )
 (func $~lib/math/ipow32 (param $x i32) (param $e i32) (result i32)
  (local $out i32)
  (local $log i32)
  (local $4 i32)
  (local.set $out
   (i32.const 1)
  )
  (drop
   (i32.lt_s
    (i32.const 0)
    (i32.const 1)
   )
  )
  (block
   (if
    (i32.eq
     (local.get $x)
     (i32.const 2)
    )
    (then
     (return
      (select
       (i32.shl
        (i32.const 1)
        (local.get $e)
       )
       (i32.const 0)
       (i32.lt_u
        (local.get $e)
        (i32.const 32)
       )
      )
     )
    )
   )
   (if
    (i32.le_s
     (local.get $e)
     (i32.const 0)
    )
    (then
     (if
      (i32.eq
       (local.get $x)
       (i32.const -1)
      )
      (then
       (return
        (select
         (i32.const -1)
         (i32.const 1)
         (i32.and
          (local.get $e)
          (i32.const 1)
         )
        )
       )
      )
     )
     (return
      (i32.or
       (i32.eq
        (local.get $e)
        (i32.const 0)
       )
       (i32.eq
        (local.get $x)
        (i32.const 1)
       )
      )
     )
    )
    (else
     (if
      (i32.eq
       (local.get $e)
       (i32.const 1)
      )
      (then
       (return
        (local.get $x)
       )
      )
      (else
       (if
        (i32.eq
         (local.get $e)
         (i32.const 2)
        )
        (then
         (return
          (i32.mul
           (local.get $x)
           (local.get $x)
          )
         )
        )
        (else
         (if
          (i32.lt_s
           (local.get $e)
           (i32.const 32)
          )
          (then
           (local.set $log
            (i32.sub
             (i32.const 32)
             (i32.clz
              (local.get $e)
             )
            )
           )
           (block $break|0
            (block $case4|0
             (block $case3|0
              (block $case2|0
               (block $case1|0
                (block $case0|0
                 (local.set $4
                  (local.get $log)
                 )
                 (br_if $case0|0
                  (i32.eq
                   (local.get $4)
                   (i32.const 5)
                  )
                 )
                 (br_if $case1|0
                  (i32.eq
                   (local.get $4)
                   (i32.const 4)
                  )
                 )
                 (br_if $case2|0
                  (i32.eq
                   (local.get $4)
                   (i32.const 3)
                  )
                 )
                 (br_if $case3|0
                  (i32.eq
                   (local.get $4)
                   (i32.const 2)
                  )
                 )
                 (br_if $case4|0
                  (i32.eq
                   (local.get $4)
                   (i32.const 1)
                  )
                 )
                 (br $break|0)
                )
                (block
                 (if
                  (i32.and
                   (local.get $e)
                   (i32.const 1)
                  )
                  (then
                   (local.set $out
                    (i32.mul
                     (local.get $out)
                     (local.get $x)
                    )
                   )
                  )
                 )
                 (local.set $e
                  (i32.shr_u
                   (local.get $e)
                   (i32.const 1)
                  )
                 )
                 (local.set $x
                  (i32.mul
                   (local.get $x)
                   (local.get $x)
                  )
                 )
                )
               )
               (block
                (if
                 (i32.and
                  (local.get $e)
                  (i32.const 1)
                 )
                 (then
                  (local.set $out
                   (i32.mul
                    (local.get $out)
                    (local.get $x)
                   )
                  )
                 )
                )
                (local.set $e
                 (i32.shr_u
                  (local.get $e)
                  (i32.const 1)
                 )
                )
                (local.set $x
                 (i32.mul
                  (local.get $x)
                  (local.get $x)
                 )
                )
               )
              )
              (block
               (if
                (i32.and
                 (local.get $e)
                 (i32.const 1)
                )
                (then
                 (local.set $out
                  (i32.mul
                   (local.get $out)
                   (local.get $x)
                  )
                 )
                )
               )
               (local.set $e
                (i32.shr_u
                 (local.get $e)
                 (i32.const 1)
                )
               )
               (local.set $x
                (i32.mul
                 (local.get $x)
                 (local.get $x)
                )
               )
              )
             )
             (block
              (if
               (i32.and
                (local.get $e)
                (i32.const 1)
               )
               (then
                (local.set $out
                 (i32.mul
                  (local.get $out)
                  (local.get $x)
                 )
                )
               )
              )
              (local.set $e
               (i32.shr_u
                (local.get $e)
                (i32.const 1)
               )
              )
              (local.set $x
               (i32.mul
                (local.get $x)
                (local.get $x)
               )
              )
             )
            )
            (if
             (i32.and
              (local.get $e)
              (i32.const 1)
             )
             (then
              (local.set $out
               (i32.mul
                (local.get $out)
                (local.get $x)
               )
              )
             )
            )
           )
           (return
            (local.get $out)
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
  (block $while-break|1
   (loop $while-continue|1
    (if
     (local.get $e)
     (then
      (if
       (i32.and
        (local.get $e)
        (i32.const 1)
       )
       (then
        (local.set $out
         (i32.mul
          (local.get $out)
          (local.get $x)
         )
        )
       )
      )
      (local.set $e
       (i32.shr_u
        (local.get $e)
        (i32.const 1)
       )
      )
      (local.set $x
       (i32.mul
        (local.get $x)
        (local.get $x)
       )
      )
      (br $while-continue|1)
     )
    )
   )
  )
  (return
   (local.get $out)
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
 (func $resolve-binary/Foo#constructor (param $this i32) (result i32)
  (if
   (i32.eqz
    (local.get $this)
   )
   (then
    (local.set $this
     (call $~lib/rt/__localtostack
      (call $~lib/rt/itcms/__new
       (i32.const 0)
       (i32.const 4)
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
 (func $resolve-binary/Foo#lt (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 9824)
  )
 )
 (func $~lib/string/String#toString (param $this i32) (result i32)
  (return
   (local.get $this)
  )
 )
 (func $resolve-binary/Foo#gt (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 9856)
  )
 )
 (func $resolve-binary/Foo#le (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 9888)
  )
 )
 (func $resolve-binary/Foo#ge (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 9920)
  )
 )
 (func $resolve-binary/Foo#eq (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 9952)
  )
 )
 (func $resolve-binary/Foo#ne (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 9984)
  )
 )
 (func $resolve-binary/Foo#add (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 10016)
  )
 )
 (func $resolve-binary/Foo.sub (param $a i32) (param $b i32) (result i32)
  (return
   (i32.const 10048)
  )
 )
 (func $resolve-binary/Foo#mul (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 10080)
  )
 )
 (func $resolve-binary/Foo#div (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 10112)
  )
 )
 (func $resolve-binary/Foo#rem (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 10144)
  )
 )
 (func $resolve-binary/Foo#pow (param $this i32) (param $other i32) (result i32)
  (return
   (i32.const 10176)
  )
 )
 (func $resolve-binary/Bar#constructor (param $this i32) (result i32)
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
 (func $resolve-binary/Bar#add (param $this i32) (param $other i32) (result i32)
  (return
   (local.get $other)
  )
 )
 (func $resolve-binary/Bar#self (param $this i32) (result i32)
  (return
   (local.get $this)
  )
 )
 (func $resolve-binary/Baz#constructor (param $this i32) (result i32)
  (if
   (i32.eqz
    (local.get $this)
   )
   (then
    (local.set $this
     (call $~lib/rt/__localtostack
      (call $~lib/rt/itcms/__new
       (i32.const 0)
       (i32.const 6)
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
 (func $resolve-binary/Baz#add (param $this i32) (param $other i32) (result i32)
  (return
   (local.get $other)
  )
 )
 (func $resolve-binary/Baz#sub (param $this i32) (param $other i32) (result i32)
  (return
   (local.get $this)
  )
 )
 (func $resolve-binary/Baz.mul (param $left i32) (param $right i32) (result i32)
  (return
   (local.get $right)
  )
 )
 (func $resolve-binary/Baz.div (param $left i32) (param $right i32) (result i32)
  (return
   (local.get $left)
  )
 )
 (func $start:resolve-binary
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/Bool#toString
       (i32.lt_s
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 2)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/Bool#toString
       (i32.gt_s
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 64)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/Bool#toString
       (i32.le_s
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/Bool#toString
       (i32.ge_s
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 64)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/Bool#toString
       (i32.eq
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 64)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/Bool#toString
       (i32.ne
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 7)
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
    (i32.const 496)
   )
  )
  (global.set $~lib/rt/itcms/toSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 528)
   )
  )
  (global.set $~lib/rt/itcms/fromSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 672)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.const 1)
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2336)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.add
          (global.get $resolve-binary/a)
          (i32.const 1)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.sub
          (global.get $resolve-binary/a)
          (i32.const 1)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2336)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.mul
          (global.get $resolve-binary/a)
          (i32.const 2)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 15)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $resolve-binary/f
   (f64.const 2)
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/F64#toString
       (block (result f64)
        (global.set $resolve-binary/f
         (call $~lib/math/NativeMath.pow
          (global.get $resolve-binary/f)
          (f64.const 2)
         )
        )
        (global.get $resolve-binary/f)
       )
       (i32.const 0)
      )
     )
     (i32.const 9696)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 17)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $resolve-binary/a
   (i32.const 4)
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.div_s
          (global.get $resolve-binary/a)
          (i32.const 2)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 19)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.rem_s
          (global.get $resolve-binary/a)
          (i32.const 3)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.shl
          (global.get $resolve-binary/a)
          (i32.const 1)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 9728)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 21)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.shr_s
          (global.get $resolve-binary/a)
          (i32.const 1)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.shr_u
          (global.get $resolve-binary/a)
          (i32.const 1)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2336)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 23)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.and
          (global.get $resolve-binary/a)
          (i32.const 3)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2336)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.or
          (global.get $resolve-binary/a)
          (i32.const 3)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 9760)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 25)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $resolve-binary/a
         (i32.xor
          (global.get $resolve-binary/a)
          (i32.const 2)
         )
        )
        (global.get $resolve-binary/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2336)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 26)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (i32.add
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 10)
      )
     )
     (i32.const 9760)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 29)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (i32.sub
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 10)
      )
     )
     (i32.const 9792)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 30)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (i32.mul
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 31)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (i32.div_s
        (i32.const 4)
        (i32.const 2)
       )
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 32)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (i32.rem_s
        (i32.const 3)
        (i32.const 2)
       )
       (i32.const 10)
      )
     )
     (i32.const 2336)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 33)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (call $~lib/math/ipow32
        (i32.const 2)
        (i32.const 2)
       )
       (i32.const 10)
      )
     )
     (i32.const 9728)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/F64#toString
       (call $~lib/math/NativeMath.pow
        (f64.const 2)
        (f64.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 9696)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/F64#toString
       (call $~lib/math/NativeMath.pow
        (f64.const 2)
        (f64.const 2)
       )
       (i32.const 0)
      )
     )
     (i32.const 9696)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (i32.shl
        (i32.const 2)
        (i32.const 1)
       )
       (i32.const 10)
      )
     )
     (i32.const 9728)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 45)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (i32.shr_s
        (i32.const 2)
        (i32.const 1)
       )
       (i32.const 10)
      )
     )
     (i32.const 2336)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 46)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (i32.shr_u
        (i32.const -1)
        (i32.const 30)
       )
       (i32.const 10)
      )
     )
     (i32.const 9760)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 47)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (i32.and
        (i32.const 3)
        (i32.const 1)
       )
       (i32.const 10)
      )
     )
     (i32.const 2336)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (i32.or
        (i32.const 1)
        (i32.const 2)
       )
       (i32.const 10)
      )
     )
     (i32.const 9760)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (i32.xor
        (i32.const 1)
        (i32.const 3)
       )
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (i32.const 2)
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (i32.const 0)
       (i32.const 10)
      )
     )
     (i32.const 352)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (i32.const 1)
       (i32.const 10)
      )
     )
     (i32.const 2336)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
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
      (call $~lib/number/I32#toString
       (i32.const 2)
       (i32.const 10)
      )
     )
     (i32.const 2368)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 58)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $resolve-binary/foo
   (call $resolve-binary/Foo#constructor
    (i32.const 0)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#lt
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 9824)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 128)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#gt
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 9856)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 129)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#le
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 9888)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 130)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#ge
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 9920)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 131)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#eq
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 9952)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 132)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#ne
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 9984)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 133)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#add
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 10016)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 134)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo.sub
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 10048)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 135)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#mul
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 10080)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 136)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#div
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 10112)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 137)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#rem
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 10144)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 138)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/string/String#toString
       (call $~lib/rt/__tmptostack
        (call $resolve-binary/Foo#pow
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
         (call $~lib/rt/__tmptostack
          (global.get $resolve-binary/foo)
         )
        )
       )
      )
     )
     (i32.const 10176)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 139)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $resolve-binary/bar
   (call $resolve-binary/Bar#constructor
    (i32.const 0)
   )
  )
  (global.set $resolve-binary/bar2
   (call $resolve-binary/Bar#constructor
    (i32.const 0)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $resolve-binary/Bar#self
      (call $~lib/rt/__tmptostack
       (block (result i32)
        (global.set $resolve-binary/bar
         (call $resolve-binary/Bar#add
          (call $~lib/rt/__tmptostack
           (global.get $resolve-binary/bar)
          )
          (call $~lib/rt/__tmptostack
           (global.get $resolve-binary/bar2)
          )
         )
        )
        (global.get $resolve-binary/bar)
       )
      )
     )
     (global.get $resolve-binary/bar2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 154)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $resolve-binary/bar)
     (global.get $resolve-binary/bar2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 155)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $resolve-binary/baz
   (call $resolve-binary/Baz#constructor
    (i32.const 0)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $resolve-binary/Baz#add
      (call $~lib/rt/__tmptostack
       (global.get $resolve-binary/baz)
      )
      (i32.const 42)
     )
     (i32.const 42)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 181)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $resolve-binary/Baz#sub
      (call $~lib/rt/__tmptostack
       (global.get $resolve-binary/baz)
      )
      (i32.const 42)
     )
     (global.get $resolve-binary/baz)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 182)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $resolve-binary/Baz.mul
      (call $~lib/rt/__tmptostack
       (global.get $resolve-binary/baz)
      )
      (i32.const 42)
     )
     (i32.const 42)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 183)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $resolve-binary/Baz.div
      (call $~lib/rt/__tmptostack
       (global.get $resolve-binary/baz)
      )
      (i32.const 42)
     )
     (global.get $resolve-binary/baz)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 96)
     (i32.const 184)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~lib/rt/__visit_globals (param $0 i32)
  (local $1 i32)
  (if
   (local.tee $1
    (global.get $resolve-binary/foo)
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
    (global.get $resolve-binary/bar)
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
    (global.get $resolve-binary/bar2)
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
    (global.get $resolve-binary/baz)
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
 (func $~lib/rt/__visit_members (param $0 i32) (param $1 i32)
  (block $invalid
   (block $resolve-binary/Baz
    (block $resolve-binary/Bar
     (block $resolve-binary/Foo
      (block $~lib/arraybuffer/ArrayBufferView
       (block $~lib/string/String
        (block $~lib/arraybuffer/ArrayBuffer
         (block $~lib/object/Object
          (br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $resolve-binary/Foo $resolve-binary/Bar $resolve-binary/Baz $invalid
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
   (return)
  )
  (unreachable)
 )
 (func $~start
  (call $start:resolve-binary)
 )
)
