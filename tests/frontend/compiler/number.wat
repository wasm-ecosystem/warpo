(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32)))
 (type $3 (func (param i32 i32) (result i32)))
 (type $4 (func))
 (type $5 (func (param i32 i32 i32)))
 (type $6 (func (param f64) (result i32)))
 (type $7 (func (param f32) (result i32)))
 (type $8 (func (param i32 i32 i32 i32)))
 (type $9 (func (param i32 i32 i64) (result i32)))
 (type $10 (func (result i32)))
 (type $11 (func (param i32 i64 i32)))
 (type $12 (func (param i64 i32) (result i32)))
 (type $13 (func (param i32 i64 i32 i32)))
 (type $14 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $15 (func (param i32 i64 i32 i64 i32 i64 i32) (result i32)))
 (type $16 (func (param i32 i32 i32) (result i32)))
 (type $17 (func (param i32 f64 i32) (result i32)))
 (type $18 (func (param f64 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $number/a (mut i32) (i32.const 1))
 (global $~lib/rt/itcms/total (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/threshold (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/state (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/visitCount (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/pinSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/iter (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/toSpace (mut i32) (i32.const 0))
 (global $~lib/rt/itcms/white (mut i32) (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Minimal i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/rt/itcms/fromSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $~lib/native/ASC_LOW_MEMORY_LIMIT i32 (i32.const 0))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $~lib/util/number/_frc_plus (mut i64) (i64.const 0))
 (global $~lib/util/number/_frc_minus (mut i64) (i64.const 0))
 (global $~lib/util/number/_exp (mut i32) (i32.const 0))
 (global $~lib/util/number/_K (mut i32) (i32.const 0))
 (global $~lib/util/number/_frc_pow (mut i64) (i64.const 0))
 (global $~lib/util/number/_exp_pow (mut i32) (i32.const 0))
 (global $~lib/builtins/f32.NaN f32 (f32.const nan:0x400000))
 (global $~lib/number/F32.NaN f32 (f32.const nan:0x400000))
 (global $~lib/builtins/f32.MIN_SAFE_INTEGER f32 (f32.const -16777215))
 (global $~lib/builtins/f32.MAX_SAFE_INTEGER f32 (f32.const 16777215))
 (global $~lib/builtins/f32.EPSILON f32 (f32.const 1.1920928955078125e-07))
 (global $~lib/builtins/f64.NaN f64 (f64.const nan:0x8000000000000))
 (global $~lib/number/F64.NaN f64 (f64.const nan:0x8000000000000))
 (global $~lib/builtins/f64.MIN_SAFE_INTEGER f64 (f64.const -9007199254740991))
 (global $~lib/builtins/f64.MAX_SAFE_INTEGER f64 (f64.const 9007199254740991))
 (global $~lib/builtins/f64.EPSILON f64 (f64.const 2.220446049250313e-16))
 (global $~lib/rt/__rtti_base i32 (i32.const 3632))
 (global $~lib/memory/__data_end i32 (i32.const 3652))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 36420))
 (global $~lib/memory/__heap_base i32 (i32.const 36420))
 (memory $0 1)
 (data $0 (i32.const 12) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00d\00\00\00t\00o\00S\00t\00r\00i\00n\00g\00(\00)\00 \00r\00a\00d\00i\00x\00 \00a\00r\00g\00u\00m\00e\00n\00t\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 140) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00u\00t\00i\00l\00/\00n\00u\00m\00b\00e\00r\00.\00t\00s\00\00\00\00\00\00\00")
 (data $2 (i32.const 204) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\000\00\00\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 236) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $4 (i32.const 300) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 368) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 400) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $7 (i32.const 428) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 492) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 544) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $10 (i32.const 572) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $11 (i32.const 636) "0\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\00")
 (data $12 (i32.const 1036) "\1c\04\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\04\00\000\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\000\00a\000\00b\000\00c\000\00d\000\00e\000\00f\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\00a\001\00b\001\00c\001\00d\001\00e\001\00f\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\002\00a\002\00b\002\00c\002\00d\002\00e\002\00f\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\003\00a\003\00b\003\00c\003\00d\003\00e\003\00f\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\004\00a\004\00b\004\00c\004\00d\004\00e\004\00f\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\005\00a\005\00b\005\00c\005\00d\005\00e\005\00f\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\006\00a\006\00b\006\00c\006\00d\006\00e\006\00f\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\007\00a\007\00b\007\00c\007\00d\007\00e\007\00f\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\008\00a\008\00b\008\00c\008\00d\008\00e\008\00f\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\009\00a\009\00b\009\00c\009\00d\009\00e\009\00f\00a\000\00a\001\00a\002\00a\003\00a\004\00a\005\00a\006\00a\007\00a\008\00a\009\00a\00a\00a\00b\00a\00c\00a\00d\00a\00e\00a\00f\00b\000\00b\001\00b\002\00b\003\00b\004\00b\005\00b\006\00b\007\00b\008\00b\009\00b\00a\00b\00b\00b\00c\00b\00d\00b\00e\00b\00f\00c\000\00c\001\00c\002\00c\003\00c\004\00c\005\00c\006\00c\007\00c\008\00c\009\00c\00a\00c\00b\00c\00c\00c\00d\00c\00e\00c\00f\00d\000\00d\001\00d\002\00d\003\00d\004\00d\005\00d\006\00d\007\00d\008\00d\009\00d\00a\00d\00b\00d\00c\00d\00d\00d\00e\00d\00f\00e\000\00e\001\00e\002\00e\003\00e\004\00e\005\00e\006\00e\007\00e\008\00e\009\00e\00a\00e\00b\00e\00c\00e\00d\00e\00e\00e\00f\00f\000\00f\001\00f\002\00f\003\00f\004\00f\005\00f\006\00f\007\00f\008\00f\009\00f\00a\00f\00b\00f\00c\00f\00d\00f\00e\00f\00f\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $13 (i32.const 2092) "\\\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00H\00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00")
 (data $14 (i32.const 2188) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\001\00\00\00\00\00\00\00\00\00\00\00")
 (data $15 (i32.const 2220) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00n\00u\00m\00b\00e\00r\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00")
 (data $16 (i32.const 2268) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\000\00.\000\00\00\00\00\00\00\00")
 (data $17 (i32.const 2300) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00N\00a\00N\00\00\00\00\00\00\00")
 (data $18 (i32.const 2332) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00-\00I\00n\00f\00i\00n\00i\00t\00y\00\00\00\00\00\00\00\00\00\00\00")
 (data $19 (i32.const 2380) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00I\00n\00f\00i\00n\00i\00t\00y\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $20 (i32.const 2432) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $21 (i32.const 2488) "\88\02\1c\08\a0\d5\8f\fav\bf>\a2\7f\e1\ae\bav\acU0 \fb\16\8b\ea5\ce]J\89B\cf-;eU\aa\b0k\9a\dfE\1a=\03\cf\1a\e6\ca\c6\9a\c7\17\fep\abO\dc\bc\be\fc\b1w\ff\0c\d6kA\ef\91V\be<\fc\7f\90\ad\1f\d0\8d\83\9aU1(\\Q\d3\b5\c9\a6\ad\8f\acq\9d\cb\8b\ee#w\"\9c\eamSx@\91I\cc\aeW\ce\b6]y\12<\827V\fbM6\94\10\c2O\98H8o\ea\96\90\c7:\82%\cb\85t\d7\f4\97\bf\97\cd\cf\86\a0\e5\ac*\17\98\n4\ef\8e\b25*\fbg8\b2;?\c6\d2\df\d4\c8\84\ba\cd\d3\1a\'D\dd\c5\96\c9%\bb\ce\9fk\93\84\a5b}$l\ac\db\f6\da_\rXf\ab\a3&\f1\c3\de\93\f8\e2\f3\b8\80\ff\aa\a8\ad\b5\b5\8bJ|l\05_b\87S0\c14`\ff\bc\c9U&\ba\91\8c\85N\96\bd~)p$w\f9\df\8f\b8\e5\b8\9f\bd\df\a6\94}t\88\cf_\a9\f8\cf\9b\a8\8f\93pD\b9k\15\0f\bf\f8\f0\08\8a\b611eU%\b0\cd\ac\7f{\d0\c6\e2?\99\06;+*\c4\10\\\e4\d3\92si\99$$\aa\0e\ca\00\83\f2\b5\87\fd\eb\1a\11\92d\08\e5\bc\cc\88Po\t\cc\bc\8c,e\19\e2X\17\b7\d1\00\00\00\00\00\00@\9c\00\00\00\00\10\a5\d4\e8\00\00b\ac\c5\ebx\ad\84\t\94\f8x9?\81\b3\15\07\c9{\ce\97\c0p\\\ea{\ce2~\8fh\80\e9\ab\a48\d2\d5E\"\9a\17&\'O\9f\'\fb\c4\d41\a2c\ed\a8\ad\c8\8c8e\de\b0\dbe\ab\1a\8e\08\c7\83\9a\1dqB\f9\1d]\c4X\e7\1b\a6,iM\92\ea\8dp\1ad\ee\01\daJw\ef\9a\99\a3m\a2\85k}\b4{x\t\f2w\18\ddy\a1\e4T\b4\c2\c5\9b[\92\86[\86=]\96\c8\c5S5\c8\b3\a0\97\fa\\\b4*\95\e3_\a0\99\bd\9fF\de%\8c9\db4\c2\9b\a5\\\9f\98\a3r\9a\c6\f6\ce\be\e9TS\bf\dc\b7\e2A\"\f2\17\f3\fc\88\a5x\\\d3\9b\ce \cc\dfS!{\f3Z\16\98:0\1f\97\dc\b5\a0\e2\96\b3\e3\\S\d1\d9\a8<D\a7\a4\d9|\9b\fb\10D\a4\a7LLv\bb\1a\9c@\b6\ef\8e\ab\8b,\84W\a6\10\ef\1f\d0)1\91\e9\e5\a4\10\9b\9d\0c\9c\a1\fb\9b\10\e7)\f4;b\d9 (\ac\85\cf\a7z^KD\80-\dd\ac\03@\e4!\bf\8f\ffD^/\9cg\8eA\b8\8c\9c\9d\173\d4\a9\1b\e3\b4\92\db\19\9e\d9w\df\ban\bf\96\ebk\ee\f0\9b;\02\87\af")
 (data $22 (i32.const 3184) "<\fbW\fbr\fb\8c\fb\a7\fb\c1\fb\dc\fb\f6\fb\11\fc,\fcF\fca\fc{\fc\96\fc\b1\fc\cb\fc\e6\fc\00\fd\1b\fd5\fdP\fdk\fd\85\fd\a0\fd\ba\fd\d5\fd\ef\fd\n\fe%\fe?\feZ\fet\fe\8f\fe\a9\fe\c4\fe\df\fe\f9\fe\14\ff.\ffI\ffc\ff~\ff\99\ff\b3\ff\ce\ff\e8\ff\03\00\1e\008\00S\00m\00\88\00\a2\00\bd\00\d8\00\f2\00\r\01\'\01B\01\\\01w\01\92\01\ac\01\c7\01\e1\01\fc\01\16\021\02L\02f\02\81\02\9b\02\b6\02\d0\02\eb\02\06\03 \03;\03U\03p\03\8b\03\a5\03\c0\03\da\03\f5\03\0f\04*\04")
 (data $23 (i32.const 3360) "\01\00\00\00\n\00\00\00d\00\00\00\e8\03\00\00\10\'\00\00\a0\86\01\00@B\0f\00\80\96\98\00\00\e1\f5\05\00\ca\9a;")
 (data $24 (i32.const 3404) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\002\00.\000\00\00\00\00\00\00\00")
 (data $25 (i32.const 3436) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\003\00\00\00\00\00\00\00\00\00\00\00")
 (data $26 (i32.const 3468) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00-\005\00\00\00\00\00\00\00\00\00")
 (data $27 (i32.const 3500) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\004\00\00\00\00\00\00\00\00\00\00\00")
 (data $28 (i32.const 3532) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\002\00\00\00\00\00\00\00\00\00\00\00")
 (data $29 (i32.const 3564) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00t\00r\00u\00e\00\00\00\00\00")
 (data $30 (i32.const 3596) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00f\00a\00l\00s\00e\00\00\00")
 (data $31 (i32.const 3632) "\04\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
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
         (i32.const 320)
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
       (i32.const 320)
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
     (i32.const 320)
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
     (i32.const 448)
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
        (i32.const 320)
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
         (i32.const 320)
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
     (i32.const 256)
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
     (i32.const 256)
     (i32.const 320)
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
         (i32.const 636)
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
         (i32.const 636)
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
       (i32.const 636)
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
       (i32.const 636)
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
         (i32.const 1056)
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
       (i32.const 1056)
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
        (i32.const 2112)
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
        (i32.const 2112)
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
     (i32.const 32)
     (i32.const 160)
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
     (i32.const 224)
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
             (i32.const 3360)
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
            (i32.const 3360)
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
        (i32.const 2488)
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
        (i32.const 3184)
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
       (i32.const 2288)
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
         (i32.const 2320)
        )
       )
      )
      (br $~lib/util/number/dtoa_impl|inlined.0
       (select
        (i32.const 2352)
        (i32.const 2400)
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
       (i32.const 2432)
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
     (i32.const 2432)
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
 (func $~lib/number/Bool#toString (param $this i32) (param $radix i32) (result i32)
  (return
   (if (result i32)
    (local.get $this)
    (then
     (i32.const 3584)
    )
    (else
     (i32.const 3616)
    )
   )
  )
 )
 (func $~lib/number/F32.isSafeInteger (param $value f32) (result i32)
  (return
   (if (result i32)
    (f32.le
     (f32.abs
      (local.get $value)
     )
     (global.get $~lib/builtins/f32.MAX_SAFE_INTEGER)
    )
    (then
     (f32.eq
      (f32.trunc
       (local.get $value)
      )
      (local.get $value)
     )
    )
    (else
     (i32.const 0)
    )
   )
  )
 )
 (func $~lib/number/F32.isInteger (param $value f32) (result i32)
  (return
   (if (result i32)
    (f32.eq
     (f32.sub
      (local.get $value)
      (local.get $value)
     )
     (f32.const 0)
    )
    (then
     (f32.eq
      (f32.trunc
       (local.get $value)
      )
      (local.get $value)
     )
    )
    (else
     (i32.const 0)
    )
   )
  )
 )
 (func $~lib/number/F64.isSafeInteger (param $value f64) (result i32)
  (return
   (if (result i32)
    (f64.le
     (f64.abs
      (local.get $value)
     )
     (global.get $~lib/builtins/f64.MAX_SAFE_INTEGER)
    )
    (then
     (f64.eq
      (f64.trunc
       (local.get $value)
      )
      (local.get $value)
     )
    )
    (else
     (i32.const 0)
    )
   )
  )
 )
 (func $~lib/number/F64.isInteger (param $value f64) (result i32)
  (return
   (if (result i32)
    (f64.eq
     (f64.sub
      (local.get $value)
      (local.get $value)
     )
     (f64.const 0)
    )
    (then
     (f64.eq
      (f64.trunc
       (local.get $value)
      )
      (local.get $value)
     )
    )
    (else
     (i32.const 0)
    )
   )
  )
 )
 (func $start:number
  (local $0 i32)
  (local $1 i32)
  (local $2 f32)
  (local $3 f64)
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
    (i32.const 368)
   )
  )
  (global.set $~lib/rt/itcms/toSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 400)
   )
  )
  (global.set $~lib/rt/itcms/fromSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 544)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/number/I32#toString
       (global.get $number/a)
       (i32.const 10)
      )
     )
     (i32.const 2208)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
      (call $~lib/number/F64#toString
       (f64.const 2)
       (i32.const 0)
      )
     )
     (i32.const 3424)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
      (call $~lib/number/I32#toString
       (i32.const 3)
       (i32.const 10)
      )
     )
     (i32.const 3456)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
      (call $~lib/number/I32#toString
       (i32.const -5)
       (i32.const 10)
      )
     )
     (i32.const 3488)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
      (call $~lib/number/I32#toString
       (i32.const 4)
       (i32.const 10)
      )
     )
     (i32.const 3520)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $number/a
         (i32.add
          (global.get $number/a)
          (i32.const 1)
         )
        )
        (global.get $number/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 3552)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
        (global.set $number/a
         (i32.sub
          (global.get $number/a)
          (i32.const 1)
         )
        )
        (global.get $number/a)
       )
       (i32.const 10)
      )
     )
     (i32.const 2208)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
      (call $~lib/number/Bool#toString
       (i32.eqz
        (i32.const 0)
       )
       (i32.const 0)
      )
     )
     (i32.const 3584)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
      (call $~lib/number/Bool#toString
       (i32.eqz
        (i32.const 1)
       )
       (i32.const 0)
      )
     )
     (i32.const 3616)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $number/a
         (i32.add
          (local.tee $0
           (global.get $number/a)
          )
          (i32.const 1)
         )
        )
        (local.get $0)
       )
       (i32.const 10)
      )
     )
     (i32.const 2208)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
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
      (call $~lib/number/I32#toString
       (block (result i32)
        (global.set $number/a
         (i32.sub
          (local.tee $1
           (global.get $number/a)
          )
          (i32.const 1)
         )
        )
        (local.get $1)
       )
       (i32.const 10)
      )
     )
     (i32.const 3552)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 19)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (drop
   (f32.ne
    (local.tee $2
     (global.get $~lib/number/F32.NaN)
    )
    (local.get $2)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isSafeInteger
      (f32.sub
       (global.get $~lib/builtins/f32.MIN_SAFE_INTEGER)
       (f32.const 1)
      )
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 25)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isSafeInteger
      (global.get $~lib/builtins/f32.MIN_SAFE_INTEGER)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 26)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isSafeInteger
      (f32.const 0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 27)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isSafeInteger
      (f32.const -0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 28)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isSafeInteger
      (f32.const nan:0x400000)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 29)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isSafeInteger
      (f32.const inf)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 30)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isSafeInteger
      (global.get $~lib/builtins/f32.MAX_SAFE_INTEGER)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 31)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isSafeInteger
      (f32.add
       (global.get $~lib/builtins/f32.MAX_SAFE_INTEGER)
       (f32.const 1)
      )
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 32)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isSafeInteger
      (f32.const 0.5)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 33)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (f32.const 0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 34)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (f32.const -0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 35)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (f32.const nan:0x400000)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 36)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (f32.const inf)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 37)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (global.get $~lib/builtins/f32.EPSILON)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 38)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (f32.const 1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 39)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (f32.const -1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 40)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (global.get $~lib/builtins/f32.MIN_SAFE_INTEGER)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 41)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (global.get $~lib/builtins/f32.MAX_SAFE_INTEGER)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 42)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (f32.const 0.5)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 43)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F32.isInteger
      (f32.const -1.5)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 44)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (drop
   (f64.ne
    (local.tee $3
     (global.get $~lib/number/F64.NaN)
    )
    (local.get $3)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isSafeInteger
      (f64.sub
       (global.get $~lib/builtins/f64.MIN_SAFE_INTEGER)
       (f64.const 1)
      )
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 48)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isSafeInteger
      (global.get $~lib/builtins/f64.MIN_SAFE_INTEGER)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 49)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isSafeInteger
      (f64.const 0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 50)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isSafeInteger
      (f64.const -0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 51)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isSafeInteger
      (f64.const nan:0x8000000000000)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 52)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isSafeInteger
      (f64.const inf)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 53)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isSafeInteger
      (global.get $~lib/builtins/f64.MAX_SAFE_INTEGER)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 54)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isSafeInteger
      (f64.add
       (global.get $~lib/builtins/f64.MAX_SAFE_INTEGER)
       (f64.const 1)
      )
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 55)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isSafeInteger
      (f64.const 0.5)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 56)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (f64.const 0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 57)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (f64.const -0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 58)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (f64.const nan:0x8000000000000)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 59)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (f64.const inf)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 60)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (global.get $~lib/builtins/f64.EPSILON)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 61)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (f64.const 1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 62)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (f64.const -1)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 63)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (global.get $~lib/builtins/f64.MIN_SAFE_INTEGER)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 64)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (global.get $~lib/builtins/f64.MAX_SAFE_INTEGER)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 65)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (f64.const 0.5)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 66)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/number/F64.isInteger
      (f64.const -1.5)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 2240)
     (i32.const 67)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (drop
   (i32.eqz
    (f64.eq
     (f64.const 1)
     (f64.const nan:0x8000000000000)
    )
   )
  )
  (drop
   (i32.eqz
    (f64.eq
     (f64.const nan:0x8000000000000)
     (f64.promote_f32
      (global.get $~lib/number/F32.NaN)
     )
    )
   )
  )
  (drop
   (i32.eqz
    (f64.eq
     (global.get $~lib/number/F64.NaN)
     (f64.const 1)
    )
   )
  )
  (drop
   (f64.ne
    (f64.const 1)
    (f64.const nan:0x8000000000000)
   )
  )
  (drop
   (f64.ne
    (f64.const nan:0x8000000000000)
    (f64.promote_f32
     (global.get $~lib/number/F32.NaN)
    )
   )
  )
  (drop
   (f64.ne
    (global.get $~lib/builtins/f64.NaN)
    (f64.const 1)
   )
  )
  (drop
   (f64.eq
    (f64.const 0)
    (f64.const -0)
   )
  )
  (drop
   (f64.eq
    (f64.const -0)
    (f64.const -0)
   )
  )
  (drop
   (f64.eq
    (f64.const -0)
    (f64.const 0)
   )
  )
  (drop
   (f32.eq
    (f32.const 0)
    (f32.const -0)
   )
  )
  (drop
   (f32.eq
    (f32.const -0)
    (f32.const -0)
   )
  )
  (drop
   (f32.eq
    (f32.const -0)
    (f32.const 0)
   )
  )
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
  (call $start:number)
 )
)
