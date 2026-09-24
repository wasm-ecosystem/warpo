(module
 (type $0 (func (param i32 i32) (result i32)))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32)))
 (type $3 (func (param i32 i32 i32) (result i32)))
 (type $4 (func (param i32)))
 (type $5 (func))
 (type $6 (func (param i32 i32)))
 (type $7 (func (param i32 i32 i32 i32)))
 (type $8 (func (param i32 i32 i64)))
 (type $9 (func (param f64) (result i32)))
 (type $10 (func (param i32 i32 i32 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 40148))
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
 (global $~lib/util/number/_frc_plus (mut i64) (i64.const 0))
 (global $~lib/util/number/_frc_minus (mut i64) (i64.const 0))
 (global $~lib/util/number/_exp (mut i32) (i32.const 0))
 (global $~lib/util/number/_K (mut i32) (i32.const 0))
 (global $~lib/util/number/_frc_pow (mut i64) (i64.const 0))
 (global $~lib/util/number/_exp_pow (mut i32) (i32.const 0))
 (global $~lib/rt/closure/env (mut i32) (i32.const 0))
 (global $~started (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c")
 (data $0.1 (i32.const 24) "\02\00\00\00\02\00\00\00a")
 (data $1 (i32.const 44) "\1c")
 (data $1.1 (i32.const 56) "\02\00\00\00\02\00\00\00b")
 (data $2 (i32.const 76) "<")
 (data $2.1 (i32.const 88) "\02\00\00\00$\00\00\00t\00e\00m\00p\00l\00a\00t\00e\00l\00i\00t\00e\00r\00a\00l\00.\00t\00s")
 (data $3 (i32.const 140) "\1c")
 (data $3.1 (i32.const 152) "\02")
 (data $4 (i32.const 172) "<")
 (data $4.1 (i32.const 184) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00<")
 (data $5.1 (i32.const 248) "\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s")
 (data $8 (i32.const 364) "<")
 (data $8.1 (i32.const 376) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $9 (i32.const 428) ",")
 (data $9.1 (i32.const 440) "\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s")
 (data $11 (i32.const 508) "<")
 (data $11.1 (i32.const 520) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
 (data $12 (i32.const 572) "\1c")
 (data $12.1 (i32.const 584) "\02\00\00\00\04\00\00\00a\00b")
 (data $13 (i32.const 604) "\1c")
 (data $13.1 (i32.const 616) "\02\00\00\00\06\00\00\00(\00A\00=")
 (data $14 (i32.const 636) "\1c")
 (data $14.1 (i32.const 648) "\02\00\00\00\08\00\00\00,\00 \00B\00=\00\00\00\00\00\1c")
 (data $15.1 (i32.const 680) "\02\00\00\00\02\00\00\00)")
 (data $16 (i32.const 700) ",\00\00\00\03\00\00\00\00\00\00\00\04\00\00\00\14\00\00\00p\02\00\00\00\00\00\00\90\02\00\00\00\00\00\00\b0\02")
 (data $17 (i32.const 748) ",")
 (data $17.1 (i32.const 760) "\02\00\00\00\14\00\00\00(\00A\00=\00a\00,\00 \00B\00=\00b\00)")
 (data $18 (i32.const 796) "|")
 (data $18.1 (i32.const 808) "\02\00\00\00d\00\00\00t\00o\00S\00t\00r\00i\00n\00g\00(\00)\00 \00r\00a\00d\00i\00x\00 \00a\00r\00g\00u\00m\00e\00n\00t\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006")
 (data $19 (i32.const 924) "<")
 (data $19.1 (i32.const 936) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00u\00t\00i\00l\00/\00n\00u\00m\00b\00e\00r\00.\00t\00s")
 (data $20 (i32.const 988) "\1c")
 (data $20.1 (i32.const 1000) "\02\00\00\00\02\00\00\000")
 (data $21 (i32.const 1020) "0\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\00\1c\04")
 (data $22.1 (i32.const 1432) "\02\00\00\00\00\04\00\000\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\000\00a\000\00b\000\00c\000\00d\000\00e\000\00f\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\00a\001\00b\001\00c\001\00d\001\00e\001\00f\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\002\00a\002\00b\002\00c\002\00d\002\00e\002\00f\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\003\00a\003\00b\003\00c\003\00d\003\00e\003\00f\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\004\00a\004\00b\004\00c\004\00d\004\00e\004\00f\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\005\00a\005\00b\005\00c\005\00d\005\00e\005\00f\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\006\00a\006\00b\006\00c\006\00d\006\00e\006\00f\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\007\00a\007\00b\007\00c\007\00d\007\00e\007\00f\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\008\00a\008\00b\008\00c\008\00d\008\00e\008\00f\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\009\00a\009\00b\009\00c\009\00d\009\00e\009\00f\00a\000\00a\001\00a\002\00a\003\00a\004\00a\005\00a\006\00a\007\00a\008\00a\009\00a\00a\00a\00b\00a\00c\00a\00d\00a\00e\00a\00f\00b\000\00b\001\00b\002\00b\003\00b\004\00b\005\00b\006\00b\007\00b\008\00b\009\00b\00a\00b\00b\00b\00c\00b\00d\00b\00e\00b\00f\00c\000\00c\001\00c\002\00c\003\00c\004\00c\005\00c\006\00c\007\00c\008\00c\009\00c\00a\00c\00b\00c\00c\00c\00d\00c\00e\00c\00f\00d\000\00d\001\00d\002\00d\003\00d\004\00d\005\00d\006\00d\007\00d\008\00d\009\00d\00a\00d\00b\00d\00c\00d\00d\00d\00e\00d\00f\00e\000\00e\001\00e\002\00e\003\00e\004\00e\005\00e\006\00e\007\00e\008\00e\009\00e\00a\00e\00b\00e\00c\00e\00d\00e\00e\00e\00f\00f\000\00f\001\00f\002\00f\003\00f\004\00f\005\00f\006\00f\007\00f\008\00f\009\00f\00a\00f\00b\00f\00c\00f\00d\00f\00e\00f\00f")
 (data $23 (i32.const 2476) "\\")
 (data $23.1 (i32.const 2488) "\02\00\00\00H\00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00\1c")
 (data $24.1 (i32.const 2584) "\02\00\00\00\02\00\00\001")
 (data $25 (i32.const 2604) "\1c")
 (data $25.1 (i32.const 2616) "\02\00\00\00\04\00\00\001\002")
 (data $26 (i32.const 2636) ",\00\00\00\03\00\00\00\00\00\00\00\04\00\00\00\14\00\00\00p\02\00\00\00\00\00\00\90\02\00\00\00\00\00\00\b0\02")
 (data $27 (i32.const 2684) ",")
 (data $27.1 (i32.const 2696) "\02\00\00\00\14\00\00\00(\00A\00=\001\00,\00 \00B\00=\002\00)")
 (data $28 (i32.const 2732) "\1c")
 (data $28.1 (i32.const 2744) "\02\00\00\00\06\00\00\000\00.\000")
 (data $29 (i32.const 2764) "\1c")
 (data $29.1 (i32.const 2776) "\02\00\00\00\06\00\00\00N\00a\00N")
 (data $30 (i32.const 2796) ",")
 (data $30.1 (i32.const 2808) "\02\00\00\00\12\00\00\00-\00I\00n\00f\00i\00n\00i\00t\00y")
 (data $31 (i32.const 2844) ",")
 (data $31.1 (i32.const 2856) "\02\00\00\00\10\00\00\00I\00n\00f\00i\00n\00i\00t\00y")
 (data $33 (i32.const 2952) "\88\02\1c\08\a0\d5\8f\fav\bf>\a2\7f\e1\ae\bav\acU0 \fb\16\8b\ea5\ce]J\89B\cf-;eU\aa\b0k\9a\dfE\1a=\03\cf\1a\e6\ca\c6\9a\c7\17\fep\abO\dc\bc\be\fc\b1w\ff\0c\d6kA\ef\91V\be<\fc\7f\90\ad\1f\d0\8d\83\9aU1(\\Q\d3\b5\c9\a6\ad\8f\acq\9d\cb\8b\ee#w\"\9c\eamSx@\91I\cc\aeW\ce\b6]y\12<\827V\fbM6\94\10\c2O\98H8o\ea\96\90\c7:\82%\cb\85t\d7\f4\97\bf\97\cd\cf\86\a0\e5\ac*\17\98\n4\ef\8e\b25*\fbg8\b2;?\c6\d2\df\d4\c8\84\ba\cd\d3\1a\'D\dd\c5\96\c9%\bb\ce\9fk\93\84\a5b}$l\ac\db\f6\da_\rXf\ab\a3&\f1\c3\de\93\f8\e2\f3\b8\80\ff\aa\a8\ad\b5\b5\8bJ|l\05_b\87S0\c14`\ff\bc\c9U&\ba\91\8c\85N\96\bd~)p$w\f9\df\8f\b8\e5\b8\9f\bd\df\a6\94}t\88\cf_\a9\f8\cf\9b\a8\8f\93pD\b9k\15\0f\bf\f8\f0\08\8a\b611eU%\b0\cd\ac\7f{\d0\c6\e2?\99\06;+*\c4\10\\\e4\d3\92si\99$$\aa\0e\ca\00\83\f2\b5\87\fd\eb\1a\11\92d\08\e5\bc\cc\88Po\t\cc\bc\8c,e\19\e2X\17\b7\d1\00\00\00\00\00\00@\9c\00\00\00\00\10\a5\d4\e8\00\00b\ac\c5\ebx\ad\84\t\94\f8x9?\81\b3\15\07\c9{\ce\97\c0p\\\ea{\ce2~\8fh\80\e9\ab\a48\d2\d5E\"\9a\17&\'O\9f\'\fb\c4\d41\a2c\ed\a8\ad\c8\8c8e\de\b0\dbe\ab\1a\8e\08\c7\83\9a\1dqB\f9\1d]\c4X\e7\1b\a6,iM\92\ea\8dp\1ad\ee\01\daJw\ef\9a\99\a3m\a2\85k}\b4{x\t\f2w\18\ddy\a1\e4T\b4\c2\c5\9b[\92\86[\86=]\96\c8\c5S5\c8\b3\a0\97\fa\\\b4*\95\e3_\a0\99\bd\9fF\de%\8c9\db4\c2\9b\a5\\\9f\98\a3r\9a\c6\f6\ce\be\e9TS\bf\dc\b7\e2A\"\f2\17\f3\fc\88\a5x\\\d3\9b\ce \cc\dfS!{\f3Z\16\98:0\1f\97\dc\b5\a0\e2\96\b3\e3\\S\d1\d9\a8<D\a7\a4\d9|\9b\fb\10D\a4\a7LLv\bb\1a\9c@\b6\ef\8e\ab\8b,\84W\a6\10\ef\1f\d0)1\91\e9\e5\a4\10\9b\9d\0c\9c\a1\fb\9b\10\e7)\f4;b\d9 (\ac\85\cf\a7z^KD\80-\dd\ac\03@\e4!\bf\8f\ffD^/\9cg\8eA\b8\8c\9c\9d\173\d4\a9\1b\e3\b4\92\db\19\9e\d9w\df\ban\bf\96\ebk\ee\f0\9b;\02\87\af<\fbW\fbr\fb\8c\fb\a7\fb\c1\fb\dc\fb\f6\fb\11\fc,\fcF\fca\fc{\fc\96\fc\b1\fc\cb\fc\e6\fc\00\fd\1b\fd5\fdP\fdk\fd\85\fd\a0\fd\ba\fd\d5\fd\ef\fd\n\fe%\fe?\feZ\fet\fe\8f\fe\a9\fe\c4\fe\df\fe\f9\fe\14\ff.\ffI\ffc\ff~\ff\99\ff\b3\ff\ce\ff\e8\ff\03\00\1e\008\00S\00m\00\88\00\a2\00\bd\00\d8\00\f2\00\r\01\'\01B\01\\\01w\01\92\01\ac\01\c7\01\e1\01\fc\01\16\021\02L\02f\02\81\02\9b\02\b6\02\d0\02\eb\02\06\03 \03;\03U\03p\03\8b\03\a5\03\c0\03\da\03\f5\03\0f\04*\04\00\00\01\00\00\00\n\00\00\00d\00\00\00\e8\03\00\00\10\'\00\00\a0\86\01\00@B\0f\00\80\96\98\00\00\e1\f5\05\00\ca\9a;\00\00\00\00\1c")
 (data $36.1 (i32.const 3880) "\02\00\00\00\06\00\00\001\00.\000")
 (data $37 (i32.const 3900) "\1c")
 (data $37.1 (i32.const 3912) "\02\00\00\00\0c\00\00\001\00.\000\002\00.\000\00,\00\00\00\03\00\00\00\00\00\00\00\04\00\00\00\14\00\00\00p\02\00\00\00\00\00\00\90\02\00\00\00\00\00\00\b0\02")
 (data $39 (i32.const 3980) ",")
 (data $39.1 (i32.const 3992) "\02\00\00\00\1c\00\00\00(\00A\00=\001\00.\000\00,\00 \00B\00=\002\00.\000\00)\00\1c")
 (data $40.1 (i32.const 4040) "\02\00\00\00\02\00\00\002")
 (data $41 (i32.const 4060) "\1c")
 (data $41.1 (i32.const 4072) "\02\00\00\00\08\00\00\00p\00r\00e\00f\00\00\00\00\00\1c")
 (data $42.1 (i32.const 4104) "\02\00\00\00\n\00\00\00p\00r\00e\00f\002\00\00\00\1c")
 (data $43.1 (i32.const 4136) "\02\00\00\00\n\00\00\00p\00r\00e\00f\00b\00\00\00\1c")
 (data $44.1 (i32.const 4168) "\02\00\00\00\08\00\00\00s\00u\00f\00f\00\00\00\00\00\1c")
 (data $45.1 (i32.const 4200) "\02\00\00\00\n\00\00\002\00s\00u\00f\00f\00\00\00\1c")
 (data $46.1 (i32.const 4232) "\02\00\00\00\n\00\00\00b\00s\00u\00f\00f\00\00\00\1c")
 (data $47.1 (i32.const 4264) "\02\00\00\00\04\00\00\002\00b")
 (data $48 (i32.const 4284) "\1c")
 (data $48.1 (i32.const 4296) "\02\00\00\00\08\00\00\00r\00e\00f\00#\00\00\00\00\00\1c")
 (data $49.1 (i32.const 4328) "\02\00\00\00\n\00\00\00r\00e\00f\00#\001\00\00\00,")
 (data $50.1 (i32.const 4360) "\02\00\00\00\14\00\00\00r\00e\00f\00#\001\00r\00e\00f\00#\002")
 (data $51 (i32.const 4396) ",\00\00\00\03\00\00\00\00\00\00\00\04\00\00\00\14\00\00\00p\02\00\00\00\00\00\00\90\02\00\00\00\00\00\00\b0\02")
 (data $52 (i32.const 4444) "<")
 (data $52.1 (i32.const 4456) "\02\00\00\00$\00\00\00(\00A\00=\00r\00e\00f\00#\001\00,\00 \00B\00=\00r\00e\00f\00#\002\00)")
 (data $53 (i32.const 4508) "\1c")
 (data $53.1 (i32.const 4520) "\02\00\00\00\06\00\00\00c\00:\00 ")
 (data $54 (i32.const 4540) "\1c")
 (data $54.1 (i32.const 4552) "\02\00\00\00\n\00\00\00;\00 \00d\00:\00 \00\00\00,\00\00\00\03\00\00\00\00\00\00\00\04\00\00\00\10\00\00\00\b0\11\00\00\00\00\00\00\d0\11")
 (data $56 (i32.const 4620) "\1c")
 (data $56.1 (i32.const 4632) "\02\00\00\00\08\00\00\00n\00u\00l\00l\00\00\00\00\00<")
 (data $57.1 (i32.const 4664) "\02\00\00\00\"\00\00\00c\00:\00 \00r\00e\00f\00#\003\00;\00 \00d\00:\00 \00n\00u\00l\00l")
 (data $58 (i32.const 4716) "\1c")
 (data $58.1 (i32.const 4728) "\01\00\00\00\0c\00\00\00 \00\00\00@\00\00\00 \00\00\00,")
 (data $59.1 (i32.const 4760) "\07\00\00\00\10\00\00\00\80\12\00\00\80\12\00\00\0c\00\00\00\03")
 (data $60 (i32.const 4796) "\1c")
 (data $60.1 (i32.const 4808) "\01\00\00\00\0c\00\00\00 \00\00\00@\00\00\00 \00\00\00,")
 (data $61.1 (i32.const 4840) "\07\00\00\00\10\00\00\00\d0\12\00\00\d0\12\00\00\0c\00\00\00\03")
 (data $62 (i32.const 4876) "\1c")
 (data $62.1 (i32.const 4888) "\06\00\00\00\08\00\00\00\a0\12\00\00\f0\12")
 (data $63 (i32.const 4908) ",")
 (data $63.1 (i32.const 4920) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00|")
 (data $64.1 (i32.const 4968) "\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y")
 (data $65 (i32.const 5084) "\1c")
 (data $65.1 (i32.const 5096) "\t\00\00\00\08\00\00\00\01")
 (data $66 (i32.const 5116) "\1c")
 (data $66.1 (i32.const 5128) "\t\00\00\00\08\00\00\00\02")
 (data $67 (i32.const 5148) "\1c")
 (data $67.1 (i32.const 5160) "\02\00\00\00\0c\00\00\00a\000\00b\001\00a\002\00\1c")
 (data $68.1 (i32.const 5192) "\0b\00\00\00\08\00\00\00\04")
 (data $69 (i32.const 5212) "\1c")
 (data $69.1 (i32.const 5224) "\t\00\00\00\08\00\00\00\05")
 (data $70 (i32.const 5244) ",")
 (data $70.1 (i32.const 5256) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00\1c")
 (data $71.1 (i32.const 5304) "\0f\00\00\00\08\00\00\00\06")
 (data $72 (i32.const 5324) "\1c")
 (data $72.1 (i32.const 5336) "\0f\00\00\00\08\00\00\00\07")
 (data $73 (i32.const 5356) "\1c")
 (data $73.1 (i32.const 5368) "\02\00\00\00\0c\00\00\00a\002\00b\001\00a\000\00\1c")
 (data $74.1 (i32.const 5400) "\t\00\00\00\08\00\00\00\08")
 (data $75 (i32.const 5420) "\1c")
 (data $75.1 (i32.const 5432) "\t\00\00\00\08\00\00\00\t")
 (data $76 (i32.const 5452) "\1c")
 (data $76.1 (i32.const 5464) "\02\00\00\00\02\00\00\00c")
 (data $77 (i32.const 5484) "\1c")
 (data $77.1 (i32.const 5496) "\02\00\00\00\02\00\00\00-")
 (data $78 (i32.const 5516) "\1c")
 (data $78.1 (i32.const 5528) "\02\00\00\00\n\00\00\00a\00-\00b\00-\00a\00\00\00\1c")
 (data $79.1 (i32.const 5560) "\02\00\00\00\02\00\00\00,")
 (data $80 (i32.const 5580) "\1c")
 (data $80.1 (i32.const 5592) "\02\00\00\00\n\00\00\00a\00,\00b\00,\00a\00\00\00\1c")
 (data $81.1 (i32.const 5624) "\02\00\00\00\06\00\00\00a\00b\00a")
 (data $82 (i32.const 5644) "\1c")
 (data $82.1 (i32.const 5656) "\02\00\00\00\n\00\00\00a\001\00b\002\00a\00\00\00,")
 (data $83.1 (i32.const 5688) "\02\00\00\00\0e\00\00\00C\00o\00u\00n\00t\00:\00 ")
 (data $84 (i32.const 5724) "\1c")
 (data $84.1 (i32.const 5736) "\01\00\00\00\08\00\00\00@\16\00\00\a0")
 (data $85 (i32.const 5756) ",")
 (data $85.1 (i32.const 5768) "\07\00\00\00\10\00\00\00p\16\00\00p\16\00\00\08\00\00\00\02")
 (data $86 (i32.const 5804) "\1c")
 (data $86.1 (i32.const 5816) "\01\00\00\00\08\00\00\00@\16\00\00\a0")
 (data $87 (i32.const 5836) ",")
 (data $87.1 (i32.const 5848) "\07\00\00\00\10\00\00\00\c0\16\00\00\c0\16\00\00\08\00\00\00\02")
 (data $88 (i32.const 5884) "\1c")
 (data $88.1 (i32.const 5896) "\06\00\00\00\08\00\00\00\90\16\00\00\e0\16")
 (data $89 (i32.const 5916) "<")
 (data $89.1 (i32.const 5928) "\02\00\00\00(\00\00\00T\00e\00m\00p\00l\00a\00t\00e\00S\00t\00r\00i\00n\00g\00s\00A\00r\00r\00a\00y\00\00\00\00\00\1c")
 (data $90.1 (i32.const 5992) "\02\00\00\00\06\00\00\00i\003\002")
 (data $91 (i32.const 6012) ",")
 (data $91.1 (i32.const 6024) "\02\00\00\00\0e\00\00\00g\00e\00n\00e\00r\00i\00c")
 (data $92 (i32.const 6060) ",")
 (data $92.1 (i32.const 6072) "\02\00\00\00\10\00\00\00i\00d\00e\00n\00t\00i\00t\00y")
 (data $93 (i32.const 6108) "\1c")
 (data $93.1 (i32.const 6120) "\01\00\00\00\04\00\00\00\c0\17")
 (data $94 (i32.const 6140) ",")
 (data $94.1 (i32.const 6152) "\07\00\00\00\10\00\00\00\f0\17\00\00\f0\17\00\00\04\00\00\00\01")
 (data $95 (i32.const 6188) "\1c")
 (data $95.1 (i32.const 6200) "\01\00\00\00\04\00\00\00\c0\17")
 (data $96 (i32.const 6220) ",")
 (data $96.1 (i32.const 6232) "\07\00\00\00\10\00\00\00@\18\00\00@\18\00\00\04\00\00\00\01")
 (data $97 (i32.const 6268) "\1c")
 (data $97.1 (i32.const 6280) "\06\00\00\00\08\00\00\00\10\18\00\00`\18")
 (data $98 (i32.const 6300) "\1c")
 (data $98.1 (i32.const 6312) "\01\00\00\00\04\00\00\00\a0")
 (data $99 (i32.const 6332) ",")
 (data $99.1 (i32.const 6344) "\07\00\00\00\10\00\00\00\b0\18\00\00\b0\18\00\00\04\00\00\00\01")
 (data $100 (i32.const 6380) "\1c")
 (data $100.1 (i32.const 6392) "\01\00\00\00\04\00\00\00\a0")
 (data $101 (i32.const 6412) ",")
 (data $101.1 (i32.const 6424) "\07\00\00\00\10\00\00\00\00\19\00\00\00\19\00\00\04\00\00\00\01")
 (data $102 (i32.const 6460) "\1c")
 (data $102.1 (i32.const 6472) "\06\00\00\00\08\00\00\00\d0\18\00\00 \19")
 (data $103 (i32.const 6492) "\1c")
 (data $103.1 (i32.const 6504) "\02\00\00\00\04\00\00\00\\\00u")
 (data $104 (i32.const 6524) "\1c")
 (data $104.1 (i32.const 6536) "\01\00\00\00\04\00\00\00p\19")
 (data $105 (i32.const 6556) ",")
 (data $105.1 (i32.const 6568) "\07\00\00\00\10\00\00\00\90\19\00\00\90\19\00\00\04\00\00\00\01")
 (data $106 (i32.const 6604) "\1c")
 (data $106.1 (i32.const 6616) "\01\00\00\00\04\00\00\00p\19")
 (data $107 (i32.const 6636) ",")
 (data $107.1 (i32.const 6648) "\07\00\00\00\10\00\00\00\e0\19\00\00\e0\19\00\00\04\00\00\00\01")
 (data $108 (i32.const 6684) "\1c")
 (data $108.1 (i32.const 6696) "\06\00\00\00\08\00\00\00\b0\19\00\00\00\1a")
 (data $109 (i32.const 6716) "\1c")
 (data $109.1 (i32.const 6728) "\02\00\00\00\06\00\00\00\\\00u\001")
 (data $110 (i32.const 6748) "\1c")
 (data $110.1 (i32.const 6760) "\01\00\00\00\04\00\00\00P\1a")
 (data $111 (i32.const 6780) ",")
 (data $111.1 (i32.const 6792) "\07\00\00\00\10\00\00\00p\1a\00\00p\1a\00\00\04\00\00\00\01")
 (data $112 (i32.const 6828) "\1c")
 (data $112.1 (i32.const 6840) "\01\00\00\00\04\00\00\00P\1a")
 (data $113 (i32.const 6860) ",")
 (data $113.1 (i32.const 6872) "\07\00\00\00\10\00\00\00\c0\1a\00\00\c0\1a\00\00\04\00\00\00\01")
 (data $114 (i32.const 6908) "\1c")
 (data $114.1 (i32.const 6920) "\06\00\00\00\08\00\00\00\90\1a\00\00\e0\1a")
 (data $115 (i32.const 6940) "\1c")
 (data $115.1 (i32.const 6952) "\02\00\00\00\02\00\00\00\00\10")
 (data $116 (i32.const 6972) "\1c")
 (data $116.1 (i32.const 6984) "\02\00\00\00\0c\00\00\00\\\00u\001\000\000\000\00\1c")
 (data $117.1 (i32.const 7016) "\01\00\00\00\04\00\00\000\1b")
 (data $118 (i32.const 7036) ",")
 (data $118.1 (i32.const 7048) "\07\00\00\00\10\00\00\00p\1b\00\00p\1b\00\00\04\00\00\00\01")
 (data $119 (i32.const 7084) "\1c")
 (data $119.1 (i32.const 7096) "\01\00\00\00\04\00\00\00P\1b")
 (data $120 (i32.const 7116) ",")
 (data $120.1 (i32.const 7128) "\07\00\00\00\10\00\00\00\c0\1b\00\00\c0\1b\00\00\04\00\00\00\01")
 (data $121 (i32.const 7164) "\1c")
 (data $121.1 (i32.const 7176) "\06\00\00\00\08\00\00\00\90\1b\00\00\e0\1b")
 (data $122 (i32.const 7196) "\1c")
 (data $122.1 (i32.const 7208) "\02\00\00\00\02\00\00\00:")
 (data $123 (i32.const 7228) "\1c\00\00\00\03\00\00\00\00\00\00\00\04\00\00\00\0c\00\00\00\00\00\00\000\1c")
 (data $124 (i32.const 7260) "\1c")
 (data $124.1 (i32.const 7272) "\02\00\00\00\n\00\00\00a\00:\00b\00:\00c")
 (data $125 (i32.const 7296) "\14\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\04A\00\00 \00\00\00\00\00\00\00\02A")
 (data $125.1 (i32.const 7352) "\02\t")
 (table $0 10 10 funcref)
 (elem $0 (i32.const 1) $templateliteral/tag~anonymous|0 $templateliteral/tag~anonymous|1 $templateliteral/tag~anonymous|2 $templateliteral/tag~anonymous|3 $templateliteral/tag~anonymous|1 $templateliteral/tag~anonymous|5 $templateliteral/tag~anonymous|5 $templateliteral/tag~anonymous|7 $templateliteral/tag~anonymous|8)
 (export "memory" (memory $0))
 (export "_start" (func $~start))
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
  block $__inlined_func$~lib/util/string/compareImpl$1 (result i32)
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
      br $__inlined_func$~lib/util/string/compareImpl$1
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
 (func $~lib/rt/itcms/visitRoots
  (local $0 i32)
  (local $1 i32)
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
     i32.const 256
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
    i32.const 256
    i32.const 147
    i32.const 30
    call $~lib/builtins/abort
    unreachable
   end
   global.set $~lib/rt/itcms/iter
  end
  block $__inlined_func$~lib/rt/itcms/Object#unlink$220
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
    i32.const 40148
    i32.lt_u
    i32.and
    i32.eqz
    if
     i32.const 0
     i32.const 256
     i32.const 127
     i32.const 18
     call $~lib/builtins/abort
     unreachable
    end
    br $__inlined_func$~lib/rt/itcms/Object#unlink$220
   end
   local.get $0
   i32.load offset=8
   local.tee $1
   i32.eqz
   if
    i32.const 0
    i32.const 256
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
   i32.const 7296
   i32.load
   i32.gt_u
   if
    i32.const 384
    i32.const 448
    i32.const 22
    i32.const 28
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2
   i32.shl
   i32.const 7300
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
   i32.const 528
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
   i32.const 528
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
   i32.const 528
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
   i32.const 528
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
   i32.const 528
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
    i32.const 528
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
   i32.const 528
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
   i32.const 528
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
   i32.const 528
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
    i32.const 528
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
     i32.const 528
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
     i32.const 528
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
  i32.const 40160
  i32.const 0
  i32.store
  i32.const 41728
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
    i32.const 40160
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
      i32.const 40160
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
  i32.const 40160
  i32.const 41732
  memory.size
  i64.extend_i32_s
  i64.const 16
  i64.shl
  call $~lib/rt/tlsf/addMemory
  i32.const 40160
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
   i32.const 528
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
     i32.const 528
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
   i32.const 192
   i32.const 256
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
     block $__inlined_func$~lib/rt/itcms/step$225 (result i32)
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
         br $__inlined_func$~lib/rt/itcms/step$225
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
           br $__inlined_func$~lib/rt/itcms/step$225
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
          i32.const 40148
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
        br $__inlined_func$~lib/rt/itcms/step$225
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
         i32.const 256
         i32.const 229
         i32.const 20
         call $~lib/builtins/abort
         unreachable
        end
        local.get $2
        i32.const 40148
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
         i32.const 40148
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
           i32.const 528
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
        br $__inlined_func$~lib/rt/itcms/step$225
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
   i32.const 192
   i32.const 528
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
    i32.const 528
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
   i32.const 528
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
   i32.const 528
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
 (func $~lib/string/String#concat (param $0 i32) (param $1 i32) (result i32)
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
  i32.eqz
  if
   i32.const 160
   return
  end
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
 )
 (func $~lib/rt/itcms/__link (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  local.get $1
  if
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 256
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
  end
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#__uset (param $0 i32) (param $1 i32) (param $2 i32)
  local.get $0
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  local.get $2
  i32.store
  local.get $0
  local.get $2
  i32.const 1
  return_call $~lib/rt/itcms/__link
 )
 (func $~lib/util/string/joinStringArray (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $1
  i32.const 1
  i32.sub
  local.tee $6
  i32.const 0
  i32.lt_s
  if
   i32.const 160
   return
  end
  local.get $6
  i32.eqz
  if
   local.get $0
   i32.load
   local.tee $0
   if (result i32)
    local.get $0
   else
    i32.const 160
   end
   return
  end
  loop $for-loop|0
   local.get $1
   local.get $3
   i32.gt_s
   if
    local.get $0
    local.get $3
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.tee $5
    if
     local.get $4
     local.get $5
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
     i32.add
     local.set $4
    end
    local.get $3
    i32.const 1
    i32.add
    local.set $3
    br $for-loop|0
   end
  end
  i32.const 0
  local.set $1
  local.get $4
  local.get $2
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
  local.set $3
  i32.const 0
  local.set $4
  loop $for-loop|1
   local.get $4
   local.get $6
   i32.lt_s
   if
    local.get $0
    local.get $4
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.tee $7
    if
     local.get $3
     local.get $1
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
     local.get $1
     local.get $7
     i32.add
     local.set $1
    end
    local.get $5
    if
     local.get $3
     local.get $1
     i32.const 1
     i32.shl
     i32.add
     local.get $2
     local.get $5
     i32.const 1
     i32.shl
     memory.copy
     local.get $1
     local.get $5
     i32.add
     local.set $1
    end
    local.get $4
    i32.const 1
    i32.add
    local.set $4
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
   local.get $3
   local.get $1
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
  local.get $3
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#join (param $0 i32) (result i32)
  local.get $0
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 2
  i32.shr_u
  i32.const 160
  return_call $~lib/util/string/joinStringArray
 )
 (func $~lib/util/number/decimalCount32 (param $0 i32) (result i32)
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
    i32.const 1020
    i32.add
    i64.load32_u
    local.get $3
    i32.const 100
    i32.rem_u
    i32.const 2
    i32.shl
    i32.const 1020
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
   i32.const 1020
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
   i32.const 1020
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
 (func $~lib/number/I32#toString (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
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
   local.tee $0
   select
   local.set $1
   local.get $1
   call $~lib/util/number/decimalCount32
   local.tee $3
   i32.const 1
   i32.shl
   local.get $0
   i32.add
   i32.const 2
   call $~lib/rt/itcms/__new
   local.tee $2
   local.get $0
   i32.add
   local.get $1
   local.get $3
   call $~lib/util/number/utoa32_dec_lut
   local.get $0
   if
    local.get $2
    i32.const 45
    i32.store16
   end
   local.get $2
  else
   i32.const 1008
  end
 )
 (func $~lib/number/F64#toString (param $0 f64) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  (local $7 i32)
  (local $8 i64)
  (local $9 i64)
  (local $10 i32)
  (local $11 i64)
  (local $12 i64)
  (local $13 i64)
  (local $14 i32)
  (local $15 i32)
  (local $16 i64)
  block $__inlined_func$~lib/util/number/dtoa_impl$1 (result i32)
   i32.const 2752
   local.get $0
   f64.const 0
   f64.eq
   br_if $__inlined_func$~lib/util/number/dtoa_impl$1
   drop
   local.get $0
   local.get $0
   f64.sub
   f64.const 0
   f64.ne
   if
    i32.const 2784
    local.get $0
    local.get $0
    f64.ne
    br_if $__inlined_func$~lib/util/number/dtoa_impl$1
    drop
    i32.const 2816
    i32.const 2864
    local.get $0
    f64.const 0
    f64.lt
    select
    br $__inlined_func$~lib/util/number/dtoa_impl$1
   end
   local.get $0
   f64.const 0
   f64.lt
   local.tee $15
   if (result f64)
    i32.const 2896
    i32.const 45
    i32.store16
    local.get $0
    f64.neg
   else
    local.get $0
   end
   i64.reinterpret_f64
   local.tee $3
   i64.const 9218868437227405312
   i64.and
   i64.const 52
   i64.shr_u
   i32.wrap_i64
   local.tee $2
   i32.const 1
   local.get $2
   select
   i32.const 1075
   i32.sub
   local.tee $4
   i32.const 1
   i32.sub
   local.get $3
   i64.const 4503599627370495
   i64.and
   local.get $2
   i32.const 0
   i32.ne
   i64.extend_i32_u
   i64.const 52
   i64.shl
   i64.add
   local.tee $9
   i64.const 1
   i64.shl
   i64.const 1
   i64.add
   local.tee $3
   i64.clz
   i32.wrap_i64
   local.tee $2
   i32.sub
   local.set $5
   local.get $3
   local.get $2
   i64.extend_i32_s
   i64.shl
   global.set $~lib/util/number/_frc_plus
   local.get $9
   local.get $9
   i64.const 4503599627370496
   i64.eq
   i32.const 1
   i32.add
   local.tee $2
   i64.extend_i32_s
   i64.shl
   i64.const 1
   i64.sub
   local.get $4
   local.get $2
   i32.sub
   local.get $5
   i32.sub
   i64.extend_i32_s
   i64.shl
   global.set $~lib/util/number/_frc_minus
   local.get $5
   global.set $~lib/util/number/_exp
   i32.const -61
   global.get $~lib/util/number/_exp
   i32.sub
   f64.convert_i32_s
   f64.const 0.30102999566398114
   f64.mul
   f64.const 347
   f64.add
   local.tee $0
   i32.trunc_f64_s
   local.set $2
   i32.const 348
   local.get $2
   local.get $2
   f64.convert_i32_s
   local.get $0
   f64.ne
   i32.add
   i32.const 3
   i32.shr_s
   i32.const 1
   i32.add
   local.tee $2
   i32.const 3
   i32.shl
   i32.sub
   global.set $~lib/util/number/_K
   local.get $2
   i32.const 3
   i32.shl
   i32.const 2952
   i32.add
   i64.load
   global.set $~lib/util/number/_frc_pow
   local.get $2
   i32.const 1
   i32.shl
   i32.const 3648
   i32.add
   i32.load16_s
   global.set $~lib/util/number/_exp_pow
   global.get $~lib/util/number/_frc_pow
   local.tee $11
   i64.const 4294967295
   i64.and
   local.set $13
   global.get $~lib/util/number/_frc_plus
   local.tee $6
   i64.const 4294967295
   i64.and
   local.tee $3
   local.get $11
   i64.const 32
   i64.shr_u
   local.tee $8
   i64.mul
   local.get $6
   i64.const 32
   i64.shr_u
   local.tee $6
   local.get $13
   i64.mul
   local.get $3
   local.get $13
   i64.mul
   i64.const 32
   i64.shr_u
   i64.add
   local.tee $3
   i64.const 4294967295
   i64.and
   i64.add
   i64.const 2147483647
   i64.add
   i64.const 32
   i64.shr_u
   local.get $6
   local.get $8
   i64.mul
   local.get $3
   i64.const 32
   i64.shr_u
   i64.add
   i64.add
   i64.const 1
   i64.sub
   local.set $16
   block $__inlined_func$~lib/util/number/prettify$76 (result i32)
    local.get $15
    i32.const 1
    i32.shl
    i32.const 2896
    i32.add
    local.set $7
    local.get $8
    local.get $9
    local.get $9
    i64.clz
    i64.shl
    local.tee $6
    i64.const 4294967295
    i64.and
    local.tee $3
    i64.mul
    local.get $11
    i64.const 4294967295
    i64.and
    local.tee $11
    local.get $6
    i64.const 32
    i64.shr_u
    local.tee $6
    i64.mul
    local.get $3
    local.get $11
    i64.mul
    i64.const 32
    i64.shr_u
    i64.add
    local.tee $3
    i64.const 4294967295
    i64.and
    i64.add
    i64.const 2147483647
    i64.add
    i64.const 32
    i64.shr_u
    local.get $6
    local.get $8
    i64.mul
    local.get $3
    i64.const 32
    i64.shr_u
    i64.add
    i64.add
    local.set $13
    block $__inlined_func$~lib/util/number/genDigits$75 (result i32)
     local.get $16
     local.get $8
     global.get $~lib/util/number/_frc_minus
     local.tee $6
     i64.const 4294967295
     i64.and
     local.tee $3
     i64.mul
     local.get $6
     i64.const 32
     i64.shr_u
     local.tee $6
     local.get $11
     i64.mul
     local.get $3
     local.get $11
     i64.mul
     i64.const 32
     i64.shr_u
     i64.add
     local.tee $3
     i64.const 4294967295
     i64.and
     i64.add
     i64.const 2147483647
     i64.add
     i64.const 32
     i64.shr_u
     local.get $6
     local.get $8
     i64.mul
     local.get $3
     i64.const 32
     i64.shr_u
     i64.add
     i64.add
     i64.const 1
     i64.add
     i64.sub
     local.set $8
     local.get $15
     local.set $2
     local.get $16
     local.get $13
     i64.sub
     local.set $9
     i64.const 1
     i32.const -64
     global.get $~lib/util/number/_exp
     global.get $~lib/util/number/_exp_pow
     i32.add
     i32.sub
     local.tee $14
     i64.extend_i32_s
     i64.shl
     local.tee $11
     i64.const 1
     i64.sub
     local.tee $13
     local.get $16
     i64.and
     local.set $12
     local.get $16
     local.get $14
     i64.extend_i32_s
     i64.shr_u
     i32.wrap_i64
     local.tee $1
     call $~lib/util/number/decimalCount32
     local.set $10
     loop $while-continue|0
      local.get $10
      i32.const 0
      i32.gt_s
      if
       block $break|1
        block $case10|1
         block $case9|1
          block $case8|1
           block $case7|1
            block $case6|1
             block $case5|1
              block $case4|1
               block $case3|1
                block $case2|1
                 block $case1|1
                  block $case0|1
                   local.get $10
                   i32.const 1
                   i32.sub
                   br_table $case9|1 $case8|1 $case7|1 $case6|1 $case5|1 $case4|1 $case3|1 $case2|1 $case1|1 $case0|1 $case10|1
                  end
                  local.get $1
                  i32.const 1000000000
                  i32.div_u
                  local.set $5
                  local.get $1
                  i32.const 1000000000
                  i32.rem_u
                  local.set $1
                  br $break|1
                 end
                 local.get $1
                 i32.const 100000000
                 i32.div_u
                 local.set $5
                 local.get $1
                 i32.const 100000000
                 i32.rem_u
                 local.set $1
                 br $break|1
                end
                local.get $1
                i32.const 10000000
                i32.div_u
                local.set $5
                local.get $1
                i32.const 10000000
                i32.rem_u
                local.set $1
                br $break|1
               end
               local.get $1
               i32.const 1000000
               i32.div_u
               local.set $5
               local.get $1
               i32.const 1000000
               i32.rem_u
               local.set $1
               br $break|1
              end
              local.get $1
              i32.const 100000
              i32.div_u
              local.set $5
              local.get $1
              i32.const 100000
              i32.rem_u
              local.set $1
              br $break|1
             end
             local.get $1
             i32.const 10000
             i32.div_u
             local.set $5
             local.get $1
             i32.const 10000
             i32.rem_u
             local.set $1
             br $break|1
            end
            local.get $1
            i32.const 1000
            i32.div_u
            local.set $5
            local.get $1
            i32.const 1000
            i32.rem_u
            local.set $1
            br $break|1
           end
           local.get $1
           i32.const 100
           i32.div_u
           local.set $5
           local.get $1
           i32.const 100
           i32.rem_u
           local.set $1
           br $break|1
          end
          local.get $1
          i32.const 10
          i32.div_u
          local.set $5
          local.get $1
          i32.const 10
          i32.rem_u
          local.set $1
          br $break|1
         end
         local.get $1
         local.set $5
         i32.const 0
         local.set $1
         br $break|1
        end
        i32.const 0
        local.set $5
       end
       local.get $2
       local.get $5
       i32.or
       if
        local.get $2
        local.tee $4
        i32.const 1
        i32.add
        local.set $2
        local.get $4
        i32.const 1
        i32.shl
        i32.const 2896
        i32.add
        local.get $5
        i32.const 65535
        i32.and
        i32.const 48
        i32.add
        i32.store16
       end
       local.get $10
       i32.const 1
       i32.sub
       local.set $10
       local.get $1
       i64.extend_i32_u
       local.get $14
       i64.extend_i32_s
       i64.shl
       local.get $12
       i64.add
       local.tee $6
       local.get $8
       i64.le_u
       if
        global.get $~lib/util/number/_K
        local.get $10
        i32.add
        global.set $~lib/util/number/_K
        local.get $10
        i32.const 2
        i32.shl
        i32.const 3824
        i32.add
        i64.load32_u
        local.get $14
        i64.extend_i32_s
        i64.shl
        local.set $3
        local.get $2
        i32.const 1
        i32.shl
        i32.const 2894
        i32.add
        local.tee $4
        i32.load16_u
        local.set $1
        loop $while-continue|1
         local.get $6
         local.get $9
         i64.lt_u
         local.get $8
         local.get $6
         i64.sub
         local.get $3
         i64.ge_u
         i32.and
         local.get $9
         local.get $6
         i64.sub
         local.get $3
         local.get $6
         i64.add
         local.tee $6
         local.get $9
         i64.sub
         i64.gt_u
         local.get $6
         local.get $9
         i64.lt_u
         i32.or
         i32.and
         if
          local.get $1
          i32.const 1
          i32.sub
          local.set $1
          br $while-continue|1
         end
        end
        local.get $4
        local.get $1
        i32.store16
        local.get $2
        br $__inlined_func$~lib/util/number/genDigits$75
       end
       br $while-continue|0
      end
     end
     loop $while-continue|2 (result i32)
      local.get $8
      i64.const 10
      i64.mul
      local.set $8
      local.get $12
      i64.const 10
      i64.mul
      local.tee $6
      local.get $14
      i64.extend_i32_s
      i64.shr_u
      local.tee $3
      local.get $2
      i64.extend_i32_s
      i64.or
      i64.const 0
      i64.ne
      if
       local.get $2
       local.tee $4
       i32.const 1
       i32.add
       local.set $2
       local.get $4
       i32.const 1
       i32.shl
       i32.const 2896
       i32.add
       local.get $3
       i32.wrap_i64
       i32.const 65535
       i32.and
       i32.const 48
       i32.add
       i32.store16
      end
      local.get $10
      i32.const 1
      i32.sub
      local.set $10
      local.get $6
      local.get $13
      i64.and
      local.tee $12
      local.get $8
      i64.ge_u
      br_if $while-continue|2
      global.get $~lib/util/number/_K
      local.get $10
      i32.add
      global.set $~lib/util/number/_K
      local.get $9
      i32.const 0
      local.get $10
      i32.sub
      i32.const 2
      i32.shl
      i32.const 3824
      i32.add
      i64.load32_u
      i64.mul
      local.set $3
      local.get $2
      i32.const 1
      i32.shl
      i32.const 2894
      i32.add
      local.tee $4
      i32.load16_u
      local.set $1
      loop $while-continue|11
       local.get $3
       local.get $12
       i64.gt_u
       local.get $8
       local.get $12
       i64.sub
       local.get $11
       i64.ge_u
       i32.and
       local.get $3
       local.get $12
       i64.sub
       local.get $11
       local.get $12
       i64.add
       local.tee $12
       local.get $3
       i64.sub
       i64.gt_u
       local.get $3
       local.get $12
       i64.gt_u
       i32.or
       i32.and
       if
        local.get $1
        i32.const 1
        i32.sub
        local.set $1
        br $while-continue|11
       end
      end
      local.get $4
      local.get $1
      i32.store16
      local.get $2
     end
    end
    local.get $15
    i32.sub
    local.set $2
    global.get $~lib/util/number/_K
    local.tee $5
    i32.eqz
    if
     local.get $7
     local.get $2
     i32.const 1
     i32.shl
     i32.add
     i32.const 3145774
     i32.store
     local.get $2
     i32.const 2
     i32.add
     br $__inlined_func$~lib/util/number/prettify$76
    end
    local.get $2
    local.get $5
    i32.add
    local.tee $1
    i32.const 21
    i32.le_s
    local.get $1
    local.get $2
    i32.ge_s
    i32.and
    if (result i32)
     loop $for-loop|0
      local.get $1
      local.get $2
      i32.gt_s
      if
       local.get $7
       local.get $2
       i32.const 1
       i32.shl
       i32.add
       i32.const 48
       i32.store16
       local.get $2
       i32.const 1
       i32.add
       local.set $2
       br $for-loop|0
      end
     end
     local.get $7
     local.get $1
     i32.const 1
     i32.shl
     i32.add
     i32.const 3145774
     i32.store
     local.get $1
     i32.const 2
     i32.add
    else
     local.get $1
     i32.const 21
     i32.le_s
     local.get $1
     i32.const 0
     i32.gt_s
     i32.and
     if (result i32)
      local.get $7
      local.get $1
      i32.const 1
      i32.shl
      i32.add
      local.tee $4
      i32.const 2
      i32.add
      local.get $4
      i32.const 0
      local.get $5
      i32.sub
      i32.const 1
      i32.shl
      memory.copy
      local.get $4
      i32.const 46
      i32.store16
      local.get $2
      i32.const 1
      i32.add
     else
      local.get $1
      i32.const 0
      i32.le_s
      local.get $1
      i32.const -6
      i32.gt_s
      i32.and
      if (result i32)
       local.get $7
       i32.const 2
       local.get $1
       i32.sub
       local.tee $4
       i32.const 1
       i32.shl
       i32.add
       local.get $7
       local.get $2
       i32.const 1
       i32.shl
       memory.copy
       local.get $7
       i32.const 3014704
       i32.store
       i32.const 2
       local.set $1
       loop $for-loop|1
        local.get $1
        local.get $4
        i32.lt_s
        if
         local.get $7
         local.get $1
         i32.const 1
         i32.shl
         i32.add
         i32.const 48
         i32.store16
         local.get $1
         i32.const 1
         i32.add
         local.set $1
         br $for-loop|1
        end
       end
       local.get $2
       local.get $4
       i32.add
      else
       local.get $2
       i32.const 1
       i32.eq
       if (result i32)
        local.get $7
        i32.const 101
        i32.store16 offset=2
        local.get $1
        i32.const 1
        i32.sub
        local.tee $2
        i32.const 0
        i32.lt_s
        local.tee $5
        if
         i32.const 0
         local.get $2
         i32.sub
         local.set $2
        end
        local.get $7
        i32.const 4
        i32.add
        local.tee $4
        local.get $2
        local.get $2
        call $~lib/util/number/decimalCount32
        i32.const 1
        i32.add
        local.tee $2
        call $~lib/util/number/utoa32_dec_lut
        local.get $4
        i32.const 45
        i32.const 43
        local.get $5
        select
        i32.store16
        local.get $2
        i32.const 2
        i32.add
       else
        local.get $7
        i32.const 4
        i32.add
        local.get $7
        i32.const 2
        i32.add
        local.get $2
        i32.const 1
        i32.shl
        local.tee $4
        i32.const 2
        i32.sub
        memory.copy
        local.get $7
        i32.const 46
        i32.store16 offset=2
        local.get $4
        local.get $7
        i32.add
        i32.const 101
        i32.store16 offset=2
        local.get $1
        i32.const 1
        i32.sub
        local.tee $1
        i32.const 0
        i32.lt_s
        local.tee $14
        if
         i32.const 0
         local.get $1
         i32.sub
         local.set $1
        end
        local.get $4
        local.get $7
        i32.add
        i32.const 4
        i32.add
        local.tee $5
        local.get $1
        local.get $1
        call $~lib/util/number/decimalCount32
        i32.const 1
        i32.add
        local.tee $4
        call $~lib/util/number/utoa32_dec_lut
        local.get $5
        i32.const 45
        i32.const 43
        local.get $14
        select
        i32.store16
        local.get $2
        local.get $4
        i32.add
        i32.const 2
        i32.add
       end
      end
     end
    end
   end
   local.get $15
   i32.add
   i32.const 1
   i32.shl
   local.tee $4
   i32.const 2
   call $~lib/rt/itcms/__new
   local.tee $2
   i32.const 2896
   local.get $4
   memory.copy
   local.get $2
  end
 )
 (func $templateliteral/Ref#toString (param $0 i32) (result i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $0
  i32.load
  call $~lib/number/I32#toString
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  i32.const 4304
  local.get $0
  call $~lib/string/String#concat
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $~lib/array/Array<~lib/string/String>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   i32.const 384
   i32.const 4928
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
  local.tee $0
  i32.eqz
  if
   i32.const 4976
   i32.const 4928
   i32.const 128
   i32.const 40
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
 )
 (func $~lib/array/Array<~lib/string/String>#at (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  local.get $1
  local.get $0
  i32.load offset=12
  local.tee $2
  i32.const 0
  local.get $1
  i32.const 0
  i32.lt_s
  select
  i32.add
  local.set $1
  local.get $1
  local.get $2
  i32.ge_u
  if
   i32.const 384
   i32.const 4928
   i32.const 155
   i32.const 33
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
  local.tee $0
  i32.eqz
  if
   i32.const 4976
   i32.const 4928
   i32.const 159
   i32.const 40
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
 )
 (func $templateliteral/tag~anonymous|0 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $2
  local.get $1
  call $~lib/readonlyarray/ReadonlyArray<~lib/string/String>#__get@override
  local.get $0
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 79
   i32.const 7
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 64
  return_call $~lib/string/String.__eq
 )
 (func $templateliteral/tag~anonymous|1 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 32
  return_call $~lib/string/String.__eq
 )
 (func $~lib/array/Array<~lib/string/String>#indexOf (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.load offset=12
  local.tee $3
  i32.eqz
  local.get $3
  i32.const 0
  i32.le_s
  i32.or
  if
   i32.const -1
   return
  end
  local.get $0
  i32.load offset=4
  local.set $0
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
    call $~lib/string/String.__eq
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
 (func $templateliteral/tag~anonymous|2 (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  (local $4 i32)
  i32.const 12
  i32.const 8
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
  call $~lib/readonlyarray/ReadonlyArray<~lib/string/String>#__get@override
  local.get $0
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 91
   i32.const 5
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 16
  call $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  local.get $3
  i32.load
  local.tee $2
  i32.store offset=4 align=1
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.const 4
  i32.add
  local.tee $3
  i32.load
  local.tee $4
  i32.store align=1
  local.get $0
  local.get $1
  call $~lib/number/I32#toString
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=12 align=1
  local.get $0
  call $~lib/string/String#concat
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=8 align=1
  local.get $3
  local.get $4
  local.get $0
  call $~lib/string/String#concat
  local.tee $0
  i32.store
  local.get $2
  local.get $0
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $2
  i32.const 8
  i32.add
  local.tee $0
  local.get $0
  i32.load
  i32.const 1
  i32.add
  i32.store
  global.get $~lib/memory/__stack_pointer
  i32.const 16
  i32.add
  global.set $~lib/memory/__stack_pointer
 )
 (func $templateliteral/tag~anonymous|3 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $2
  local.get $1
  call $~lib/readonlyarray/ReadonlyArray<~lib/string/String>#__get@override
  local.get $0
  call $~lib/string/String.__eq
  i32.eqz
  if
   i32.const 0
   i32.const 96
   i32.const 99
   i32.const 5
   call $~lib/builtins/abort
   unreachable
  end
  i32.const 4
  call $~lib/rt/__decrease_sp
  local.get $0
  local.get $1
  call $~lib/number/I32#toString
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $~lib/string/String#concat
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $~lib/rt/__newArray (param $0 i32) (result i32)
  (local $1 i32)
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
  global.get $~lib/memory/__stack_pointer
  local.get $2
  i32.store align=1
  i32.const 16
  i32.const 7
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
 (func $~lib/array/Array<~lib/string/String>#join (param $0 i32) (param $1 i32) (result i32)
  local.get $0
  i32.load offset=4
  local.get $0
  i32.load offset=12
  local.get $1
  return_call $~lib/util/string/joinStringArray
 )
 (func $~lib/array/Array<~lib/string/String>#push (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $0
  i32.load offset=12
  local.tee $5
  i32.const 1
  i32.add
  local.tee $6
  local.tee $2
  local.get $0
  i32.load offset=8
  local.tee $3
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   local.get $2
   i32.const 268435455
   i32.gt_u
   if
    i32.const 5264
    i32.const 4928
    i32.const 31
    i32.const 48
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.load
   local.tee $4
   block $__inlined_func$~lib/rt/itcms/__renew$234 (result i32)
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
    local.get $2
    local.get $2
    i32.const 8
    i32.le_u
    select
    i32.const 2
    i32.shl
    local.tee $2
    local.get $2
    local.get $3
    i32.lt_u
    select
    local.tee $2
    local.get $4
    i32.const 20
    i32.sub
    local.tee $3
    i32.load
    i32.const -4
    i32.and
    i32.const 16
    i32.sub
    i32.le_u
    if
     local.get $3
     local.get $2
     i32.store offset=16
     local.get $4
     br $__inlined_func$~lib/rt/itcms/__renew$234
    end
    local.get $2
    local.get $3
    i32.load offset=12
    call $~lib/rt/itcms/__new
    local.tee $7
    local.get $4
    local.get $2
    local.get $3
    i32.load offset=16
    local.tee $4
    local.get $2
    local.get $4
    i32.lt_u
    select
    memory.copy
    local.get $7
   end
   local.tee $4
   i32.ne
   if
    local.get $0
    local.get $4
    i32.store
    local.get $0
    local.get $4
    i32.store offset=4
    local.get $0
    local.get $4
    i32.const 0
    call $~lib/rt/itcms/__link
   end
   local.get $0
   local.get $2
   i32.store offset=8
  end
  local.get $0
  i32.load offset=4
  local.get $5
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
  local.get $6
  i32.store offset=12
 )
 (func $templateliteral/tag~anonymous|5 (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
  i32.const 8
  call $~lib/rt/__decrease_sp
  local.get $0
  local.get $1
  call $~lib/string/String#concat
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store offset=4 align=1
  local.get $0
  local.get $2
  call $~lib/number/I32#toString
  local.set $0
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.store align=1
  local.get $0
  call $~lib/string/String#concat
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 8
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $templateliteral/tag~anonymous|7 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.const 0
  i32.ne
 )
 (func $templateliteral/tag~anonymous|8 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  i32.const 64
  return_call $~lib/string/String.__eq
 )
 (func $templateliteral/raw (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 4
  call $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.load offset=4
  local.tee $0
  i32.store align=1
  block $__inlined_func$~lib/readonlyarray/ReadonlyArray<~lib/string/String>#join@override$183 (result i32)
   block $case1
    local.get $0
    i32.const 8
    i32.sub
    i32.load
    local.tee $1
    i32.const 7
    i32.ne
    if
     local.get $1
     i32.const 6
     i32.eq
     br_if $case1
     unreachable
    end
    local.get $0
    i32.const 160
    call $~lib/array/Array<~lib/string/String>#join
    br $__inlined_func$~lib/readonlyarray/ReadonlyArray<~lib/string/String>#join@override$183
   end
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.load
   local.tee $0
   i32.store align=1
   local.get $0
   i32.const 160
   call $~lib/array/Array<~lib/string/String>#join
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
  end
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 4
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $templateliteral/RecursiveObject#toString (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 12
  call $~lib/rt/__decrease_sp
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.load offset=4
  local.tee $1
  i32.store offset=8 align=1
  local.get $1
  i32.eqz
  if
   local.get $0
   i32.load
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 12
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   return
  end
  global.get $~lib/memory/__stack_pointer
  i32.const 7248
  i32.store offset=4 align=1
  global.get $~lib/memory/__stack_pointer
  local.get $0
  i32.load
  local.tee $0
  i32.store align=1
  local.get $1
  call $templateliteral/RecursiveObject#toString
  local.set $1
  i32.const 7248
  i32.const 0
  local.get $0
  call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
  i32.const 7248
  i32.const 2
  local.get $1
  call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
  i32.const 7248
  call $~lib/staticarray/StaticArray<~lib/string/String>#join
  local.set $0
  global.get $~lib/memory/__stack_pointer
  i32.const 12
  i32.add
  global.set $~lib/memory/__stack_pointer
  local.get $0
 )
 (func $~lib/readonlyarray/ReadonlyArray<~lib/string/String>#__get@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  block $case1
   local.get $0
   i32.const 8
   i32.sub
   i32.load
   local.tee $2
   i32.const 7
   i32.ne
   if
    local.get $2
    i32.const 6
    i32.eq
    br_if $case1
    unreachable
   end
   local.get $0
   local.get $1
   return_call $~lib/array/Array<~lib/string/String>#__get
  end
  local.get $0
  i32.load
  local.get $1
  return_call $~lib/array/Array<~lib/string/String>#__get
 )
 (func $~lib/iterator/Iterator<~lib/string/String>#next@override (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 8
  i32.sub
  i32.load
  i32.const 17
  i32.eq
  if
   block $__inlined_func$~lib/array/ArrayIterator<~lib/string/String>#next$278 (result i32)
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
    br_if $__inlined_func$~lib/array/ArrayIterator<~lib/string/String>#next$278
    drop
    i32.const 4
    call $~lib/rt/__decrease_sp
    global.get $~lib/memory/__stack_pointer
    local.get $0
    i32.load offset=4
    i32.load offset=4
    local.get $1
    i32.const 2
    i32.shl
    i32.add
    i32.load
    local.tee $0
    i32.store align=1
    i32.const 4
    i32.const 18
    call $~lib/rt/itcms/__new
    local.tee $1
    local.get $0
    i32.store
    local.get $1
    local.get $0
    i32.const 0
    call $~lib/rt/itcms/__link
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
    local.get $1
   end
   return
  end
  unreachable
 )
 (func $~lib/rt/__visit_members (param $0 i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  block $folding-inner2
   block $folding-inner1
    block $folding-inner0
     block $invalid
      block $~lib/tuple/SmallTuple
       block $~lib/array/Array<~lib/string/String>
        block $templateliteral/Ref
         block $~lib/staticarray/StaticArray<~lib/string/String>
          local.get $0
          i32.const 8
          i32.sub
          i32.load
          br_table $templateliteral/Ref $templateliteral/Ref $templateliteral/Ref $folding-inner1 $~lib/staticarray/StaticArray<~lib/string/String> $templateliteral/Ref $folding-inner2 $~lib/array/Array<~lib/string/String> $~lib/tuple/SmallTuple $folding-inner0 $folding-inner0 $folding-inner0 $folding-inner0 $folding-inner1 $folding-inner0 $folding-inner0 $folding-inner0 $folding-inner0 $folding-inner1 $folding-inner2 $invalid
         end
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
           local.tee $3
           if
            local.get $3
            call $~lib/rt/itcms/__visit
           end
           local.get $0
           i32.const 4
           i32.add
           local.set $0
           br $while-continue|0
          end
         end
         return
        end
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
       local.set $3
       loop $while-continue|00
        local.get $1
        local.get $3
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
         br $while-continue|00
        end
       end
       br $folding-inner1
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
      local.set $2
      loop $while-continue|01
       local.get $2
       i64.const 0
       i64.ne
       if
        local.get $0
        local.get $2
        i64.ctz
        i32.wrap_i64
        i32.const 2
        i32.shl
        i32.add
        i32.load
        call $~lib/rt/itcms/__visit
        local.get $2
        local.get $2
        i64.const 1
        i64.sub
        i64.and
        local.set $2
        br $while-continue|01
       end
      end
      return
     end
     unreachable
    end
    local.get $0
    i32.load offset=4
    return_call $~lib/rt/itcms/__visit
   end
   local.get $0
   i32.load
   return_call $~lib/rt/itcms/__visit
  end
  local.get $0
  i32.load
  call $~lib/rt/itcms/__visit
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
  (local $7 i32)
  global.get $~started
  i32.eqz
  if
   i32.const 1
   global.set $~started
   memory.size
   i32.const 16
   i32.shl
   i32.const 40148
   i32.sub
   i32.const 1
   i32.shr_u
   global.set $~lib/rt/itcms/threshold
   i32.const 308
   i32.const 304
   i32.store
   i32.const 312
   i32.const 304
   i32.store
   i32.const 304
   global.set $~lib/rt/itcms/pinSpace
   i32.const 340
   i32.const 336
   i32.store
   i32.const 344
   i32.const 336
   i32.store
   i32.const 336
   global.set $~lib/rt/itcms/toSpace
   i32.const 484
   i32.const 480
   i32.store
   i32.const 488
   i32.const 480
   i32.store
   i32.const 480
   global.set $~lib/rt/itcms/fromSpace
   i32.const 12
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 32
   i32.store offset=8 align=1
   global.get $~lib/memory/__stack_pointer
   i32.const 64
   i32.store offset=4 align=1
   i32.const 32
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 4
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 32
   i32.const 64
   call $~lib/string/String#concat
   i32.const 592
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 5
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 720
   i32.store align=1
   i32.const 720
   i32.const 1
   i32.const 32
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 720
   i32.const 3
   i32.const 64
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 720
   call $~lib/staticarray/StaticArray<~lib/string/String>#join
   i32.const 768
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 6
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 12
   i32.add
   global.set $~lib/memory/__stack_pointer
   i32.const 1
   call $~lib/number/I32#toString
   i32.const 2592
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 13
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 8
   call $~lib/rt/__decrease_sp
   i32.const 1
   call $~lib/number/I32#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   local.get $0
   i32.const 2
   call $~lib/number/I32#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   local.get $0
   call $~lib/string/String#concat
   i32.const 2624
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 14
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 2656
   i32.store offset=4 align=1
   i32.const 1
   call $~lib/number/I32#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   i32.const 2
   call $~lib/number/I32#toString
   local.set $1
   i32.const 2656
   i32.const 1
   local.get $0
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 2656
   i32.const 3
   local.get $1
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 2656
   call $~lib/staticarray/StaticArray<~lib/string/String>#join
   i32.const 2704
   call $~lib/string/String.__eq
   i32.eqz
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   if
    i32.const 0
    i32.const 96
    i32.const 15
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   f64.const 1
   call $~lib/number/F64#toString
   i32.const 3888
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 22
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 8
   call $~lib/rt/__decrease_sp
   f64.const 1
   call $~lib/number/F64#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   local.get $0
   f64.const 2
   call $~lib/number/F64#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   local.get $0
   call $~lib/string/String#concat
   i32.const 3920
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 23
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 3952
   i32.store offset=4 align=1
   f64.const 1
   call $~lib/number/F64#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   f64.const 2
   call $~lib/number/F64#toString
   local.set $1
   i32.const 3952
   i32.const 1
   local.get $0
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 3952
   i32.const 3
   local.get $1
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 3952
   call $~lib/staticarray/StaticArray<~lib/string/String>#join
   i32.const 4000
   call $~lib/string/String.__eq
   i32.eqz
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   if
    i32.const 0
    i32.const 96
    i32.const 24
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 8
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 64
   i32.store align=1
   i32.const 2
   call $~lib/number/I32#toString
   i32.const 4048
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 31
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 64
   i32.const 64
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 32
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 2
   call $~lib/number/I32#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   i32.const 4080
   local.get $0
   call $~lib/string/String#concat
   i32.const 4112
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 33
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4080
   i32.const 64
   call $~lib/string/String#concat
   i32.const 4144
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 34
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 2
   call $~lib/number/I32#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   local.get $0
   i32.const 4176
   call $~lib/string/String#concat
   i32.const 4208
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 35
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 64
   i32.const 4176
   call $~lib/string/String#concat
   i32.const 4240
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 36
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 2
   call $~lib/number/I32#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   local.get $0
   i32.const 64
   call $~lib/string/String#concat
   i32.const 4272
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 37
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   i32.const 16
   call $~lib/rt/__decrease_sp
   i32.const 4
   i32.const 5
   call $~lib/rt/itcms/__new
   local.tee $0
   i32.const 1
   i32.store
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   i32.const 4
   i32.const 5
   call $~lib/rt/itcms/__new
   local.tee $1
   i32.const 2
   i32.store
   global.get $~lib/memory/__stack_pointer
   local.get $1
   i32.store align=1
   local.get $0
   call $templateliteral/Ref#toString
   i32.const 4336
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 51
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   call $templateliteral/Ref#toString
   local.set $2
   global.get $~lib/memory/__stack_pointer
   local.get $2
   i32.store offset=12 align=1
   local.get $2
   local.get $1
   call $templateliteral/Ref#toString
   local.set $2
   global.get $~lib/memory/__stack_pointer
   local.get $2
   i32.store offset=8 align=1
   local.get $2
   call $~lib/string/String#concat
   i32.const 4368
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 52
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4416
   i32.store offset=8 align=1
   local.get $0
   call $templateliteral/Ref#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   local.get $1
   call $templateliteral/Ref#toString
   local.set $1
   i32.const 4416
   i32.const 1
   local.get $0
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 4416
   i32.const 3
   local.get $1
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 4416
   call $~lib/staticarray/StaticArray<~lib/string/String>#join
   i32.const 4464
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 53
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 16
   i32.add
   global.set $~lib/memory/__stack_pointer
   i32.const 12
   call $~lib/rt/__decrease_sp
   i32.const 4
   i32.const 5
   call $~lib/rt/itcms/__new
   local.tee $0
   i32.const 3
   i32.store
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   global.get $~lib/memory/__stack_pointer
   i32.const 0
   i32.store offset=8 align=1
   global.get $~lib/memory/__stack_pointer
   i32.const 4592
   i32.store align=1
   local.get $0
   call $templateliteral/Ref#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   global.get $~lib/memory/__stack_pointer
   i32.const 0
   i32.store offset=8 align=1
   i32.const 4592
   i32.const 1
   local.get $0
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 4592
   i32.const 3
   i32.const 4640
   call $~lib/staticarray/StaticArray<~lib/string/String>#__uset
   i32.const 4592
   call $~lib/staticarray/StaticArray<~lib/string/String>#join
   i32.const 4672
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 60
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 12
   i32.add
   global.set $~lib/memory/__stack_pointer
   i32.const 4
   call $~lib/rt/__decrease_sp
   i32.const 0
   global.set $~lib/rt/closure/env
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.store align=1
   i32.const 32
   call $~lib/rt/__decrease_sp
   i32.const 20
   i32.const 8
   call $~lib/rt/itcms/__new
   local.tee $0
   i32.const 12
   i32.add
   i64.const 3
   i64.store
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=12 align=1
   local.get $0
   i32.const 0
   i32.store
   local.get $0
   i32.const 0
   i32.const 0
   call $~lib/rt/itcms/__link
   i32.const 4900
   i32.load
   local.set $1
   i32.const 4896
   i32.load
   i32.load offset=12
   i32.const 3
   i32.ne
   if
    i32.const 0
    i32.const 96
    i32.const 66
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   block $__inlined_func$~lib/readonlyarray/ReadonlyArray<~lib/string/String>#get:length@override$172 (result i32)
    block $case1
     local.get $1
     i32.const 8
     i32.sub
     i32.load
     local.tee $2
     i32.const 7
     i32.ne
     if
      local.get $2
      i32.const 6
      i32.eq
      br_if $case1
      unreachable
     end
     local.get $1
     i32.load offset=12
     br $__inlined_func$~lib/readonlyarray/ReadonlyArray<~lib/string/String>#get:length@override$172
    end
    local.get $1
    i32.load
    i32.load offset=12
   end
   i32.const 3
   i32.ne
   if
    i32.const 0
    i32.const 96
    i32.const 67
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4896
   i32.load
   i32.const 0
   call $~lib/array/Array<~lib/string/String>#__get
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 68
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   i32.const 0
   call $~lib/readonlyarray/ReadonlyArray<~lib/string/String>#__get@override
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 69
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4896
   i32.load
   i32.const 1
   call $~lib/array/Array<~lib/string/String>#__get
   i32.const 64
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 70
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   i32.const 1
   call $~lib/readonlyarray/ReadonlyArray<~lib/string/String>#__get@override
   i32.const 64
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 71
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4896
   i32.load
   i32.const 2
   call $~lib/array/Array<~lib/string/String>#__get
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 72
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   i32.const 2
   call $~lib/readonlyarray/ReadonlyArray<~lib/string/String>#__get@override
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 73
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4896
   i32.load
   i32.const -1
   call $~lib/array/Array<~lib/string/String>#at
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 74
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   block $__inlined_func$~lib/readonlyarray/ReadonlyArray<~lib/string/String>#at@override$173 (result i32)
    block $case10
     local.get $1
     i32.const 8
     i32.sub
     i32.load
     local.tee $2
     i32.const 7
     i32.ne
     if
      local.get $2
      i32.const 6
      i32.eq
      br_if $case10
      unreachable
     end
     local.get $1
     i32.const 1
     call $~lib/array/Array<~lib/string/String>#at
     br $__inlined_func$~lib/readonlyarray/ReadonlyArray<~lib/string/String>#at@override$173
    end
    local.get $1
    i32.load
    i32.const 1
    call $~lib/array/Array<~lib/string/String>#at
   end
   i32.const 64
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 75
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 5104
   i32.store offset=16 align=1
   i32.const 0
   local.set $1
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $2
   i32.store align=1
   block $__inlined_func$~lib/array/Array<~lib/string/String>#findIndex$229 (result i32)
    i32.const 4
    call $~lib/rt/__decrease_sp
    local.get $2
    i32.load offset=12
    local.set $3
    loop $for-loop|0
     local.get $1
     local.get $3
     local.get $2
     i32.load offset=12
     local.tee $4
     local.get $3
     local.get $4
     i32.lt_s
     select
     i32.lt_s
     if
      global.get $~lib/memory/__stack_pointer
      local.get $2
      i32.load offset=4
      local.get $1
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.tee $4
      i32.store align=1
      i32.const 0
      global.set $~lib/rt/closure/env
      local.get $4
      local.get $1
      local.get $2
      call $templateliteral/tag~anonymous|0
      if
       global.get $~lib/memory/__stack_pointer
       i32.const 4
       i32.add
       global.set $~lib/memory/__stack_pointer
       local.get $1
       br $__inlined_func$~lib/array/Array<~lib/string/String>#findIndex$229
      end
      local.get $1
      i32.const 1
      i32.add
      local.set $1
      br $for-loop|0
     end
    end
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
    i32.const -1
   end
   local.set $1
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $1
   i32.const 1
   i32.ne
   if
    i32.const 0
    i32.const 96
    i32.const 77
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 5136
   i32.store offset=16 align=1
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $2
   i32.store align=1
   block $__inlined_func$~lib/array/Array<~lib/string/String>#findLastIndex$230 (result i32)
    i32.const 4
    call $~lib/rt/__decrease_sp
    local.get $2
    i32.load offset=12
    i32.const 1
    i32.sub
    local.set $1
    loop $for-loop|00
     local.get $1
     i32.const 0
     i32.ge_s
     if
      global.get $~lib/memory/__stack_pointer
      local.get $2
      i32.load offset=4
      local.get $1
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.tee $3
      i32.store align=1
      i32.const 0
      global.set $~lib/rt/closure/env
      local.get $3
      local.get $1
      local.get $2
      call $templateliteral/tag~anonymous|1
      if
       global.get $~lib/memory/__stack_pointer
       i32.const 4
       i32.add
       global.set $~lib/memory/__stack_pointer
       local.get $1
       br $__inlined_func$~lib/array/Array<~lib/string/String>#findLastIndex$230
      end
      local.get $1
      i32.const 1
      i32.sub
      local.set $1
      br $for-loop|00
     end
    end
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
    i32.const -1
   end
   local.set $1
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $1
   i32.const 2
   i32.ne
   if
    i32.const 0
    i32.const 96
    i32.const 83
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4896
   i32.load
   i32.const 64
   call $~lib/array/Array<~lib/string/String>#indexOf
   i32.const 0
   i32.lt_s
   if
    i32.const 0
    i32.const 96
    i32.const 84
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4896
   i32.load
   i32.const 32
   call $~lib/array/Array<~lib/string/String>#indexOf
   if
    i32.const 0
    i32.const 96
    i32.const 85
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   block $__inlined_func$~lib/array/Array<~lib/string/String>#lastIndexOf$231 (result i32)
    i32.const -1
    i32.const 4896
    i32.load
    local.tee $2
    i32.load offset=12
    local.tee $1
    i32.eqz
    br_if $__inlined_func$~lib/array/Array<~lib/string/String>#lastIndexOf$231
    drop
    local.get $1
    i32.const 1
    i32.sub
    local.set $1
    local.get $2
    i32.load offset=4
    local.set $2
    loop $while-continue|0
     local.get $1
     i32.const 0
     i32.ge_s
     if
      local.get $1
      local.get $2
      local.get $1
      i32.const 2
      i32.shl
      i32.add
      i32.load
      i32.const 32
      call $~lib/string/String.__eq
      br_if $__inlined_func$~lib/array/Array<~lib/string/String>#lastIndexOf$231
      drop
      local.get $1
      i32.const 1
      i32.sub
      local.set $1
      br $while-continue|0
     end
    end
    i32.const -1
   end
   i32.const 2
   i32.ne
   if
    i32.const 0
    i32.const 96
    i32.const 86
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 4
   i32.add
   i32.const 160
   i32.store
   local.get $0
   i32.const 160
   i32.const 0
   call $~lib/rt/itcms/__link
   local.get $0
   i32.const 8
   i32.add
   i32.const 0
   i32.store
   i32.const 8
   i32.const 10
   call $~lib/rt/itcms/__new
   local.tee $1
   i32.const 3
   i32.store
   local.get $1
   i32.const 4
   i32.add
   local.get $0
   i32.store
   global.get $~lib/memory/__stack_pointer
   local.get $1
   i32.store offset=16 align=1
   i32.const 0
   local.set $2
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $3
   i32.store align=1
   i32.const 4
   call $~lib/rt/__decrease_sp
   local.get $3
   i32.load offset=12
   local.set $4
   loop $for-loop|01
    local.get $2
    local.get $4
    local.get $3
    i32.load offset=12
    local.tee $5
    local.get $4
    local.get $5
    i32.lt_s
    select
    i32.lt_s
    if
     global.get $~lib/memory/__stack_pointer
     local.get $3
     i32.load offset=4
     local.get $2
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $5
     i32.store align=1
     local.get $1
     i32.load offset=4
     global.set $~lib/rt/closure/env
     local.get $5
     local.get $2
     local.get $3
     local.get $1
     i32.load
     call_indirect (type $2)
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $for-loop|01
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   i32.const 4
   i32.add
   i32.load
   i32.const 5168
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 95
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 8
   i32.add
   i32.load
   i32.const 4896
   i32.load
   i32.load offset=12
   i32.ne
   if
    i32.const 0
    i32.const 96
    i32.const 96
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 5200
   i32.store offset=12 align=1
   i32.const 0
   local.set $1
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $2
   i32.store align=1
   i32.const 8
   call $~lib/rt/__decrease_sp
   local.get $2
   i32.load offset=12
   local.tee $3
   call $~lib/rt/__newArray
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   local.get $0
   i32.load offset=4
   local.set $4
   loop $for-loop|02
    local.get $1
    local.get $3
    local.get $2
    i32.load offset=12
    local.tee $5
    local.get $3
    local.get $5
    i32.lt_s
    select
    i32.lt_s
    if
     local.get $4
     local.get $1
     i32.const 2
     i32.shl
     local.tee $5
     i32.add
     global.get $~lib/memory/__stack_pointer
     local.get $5
     local.get $2
     i32.load offset=4
     i32.add
     i32.load
     local.tee $5
     i32.store align=1
     local.get $5
     local.get $1
     local.get $2
     call $templateliteral/tag~anonymous|3
     local.tee $5
     i32.store
     local.get $0
     local.get $5
     i32.const 1
     call $~lib/rt/itcms/__link
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $for-loop|02
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=12 align=1
   local.get $0
   i32.const 160
   call $~lib/array/Array<~lib/string/String>#join
   i32.const 5168
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 102
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 5232
   i32.store offset=12 align=1
   i32.const 0
   local.set $1
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $2
   i32.store align=1
   i32.const 8
   call $~lib/rt/__decrease_sp
   i32.const 0
   call $~lib/rt/__newArray
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   local.get $2
   i32.load offset=12
   local.set $3
   loop $for-loop|03
    local.get $1
    local.get $3
    local.get $2
    i32.load offset=12
    local.tee $4
    local.get $3
    local.get $4
    i32.lt_s
    select
    i32.lt_s
    if
     global.get $~lib/memory/__stack_pointer
     local.get $2
     i32.load offset=4
     local.get $1
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $4
     i32.store align=1
     local.get $4
     local.get $1
     local.get $2
     call $templateliteral/tag~anonymous|1
     if
      local.get $0
      local.get $4
      call $~lib/array/Array<~lib/string/String>#push
     end
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $for-loop|03
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   i32.load offset=12
   i32.const 2
   i32.ne
   if
    i32.const 0
    i32.const 96
    i32.const 105
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 0
   call $~lib/array/Array<~lib/string/String>#__get
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 106
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 1
   call $~lib/array/Array<~lib/string/String>#__get
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 107
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 5312
   i32.store offset=12 align=1
   i32.const 0
   local.set $1
   i32.const 8
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $0
   i32.store offset=4 align=1
   global.get $~lib/memory/__stack_pointer
   i32.const 160
   i32.store align=1
   i32.const 12
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 160
   i32.store offset=8 align=1
   i32.const 160
   local.set $2
   local.get $0
   i32.load offset=12
   local.set $3
   loop $for-loop|04
    local.get $1
    local.get $3
    local.get $0
    i32.load offset=12
    local.tee $4
    local.get $3
    local.get $4
    i32.lt_s
    select
    i32.lt_s
    if
     local.get $2
     global.get $~lib/memory/__stack_pointer
     local.get $0
     i32.load offset=4
     local.get $1
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $2
     i32.store offset=4 align=1
     local.get $2
     local.get $1
     local.get $0
     call $templateliteral/tag~anonymous|5
     local.set $2
     global.get $~lib/memory/__stack_pointer
     local.get $2
     i32.store align=1
     local.get $1
     i32.const 1
     i32.add
     local.set $1
     br $for-loop|04
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 12
   i32.add
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $2
   i32.const 5168
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 113
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 5344
   i32.store offset=12 align=1
   i32.const 8
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $0
   i32.store offset=4 align=1
   global.get $~lib/memory/__stack_pointer
   i32.const 160
   i32.store align=1
   i32.const 12
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 160
   i32.store offset=8 align=1
   i32.const 160
   local.set $2
   local.get $0
   i32.load offset=12
   i32.const 1
   i32.sub
   local.set $1
   loop $for-loop|05
    local.get $1
    i32.const 0
    i32.ge_s
    if
     local.get $2
     global.get $~lib/memory/__stack_pointer
     local.get $0
     i32.load offset=4
     local.get $1
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $2
     i32.store offset=4 align=1
     local.get $2
     local.get $1
     local.get $0
     call $templateliteral/tag~anonymous|5
     local.set $2
     global.get $~lib/memory/__stack_pointer
     local.get $2
     i32.store align=1
     local.get $1
     i32.const 1
     i32.sub
     local.set $1
     br $for-loop|05
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 12
   i32.add
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   i32.const 8
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $2
   i32.const 5376
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 119
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 5408
   i32.store offset=12 align=1
   i32.const 0
   local.set $1
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $0
   i32.store align=1
   block $__inlined_func$~lib/array/Array<~lib/string/String>#every$238 (result i32)
    i32.const 4
    call $~lib/rt/__decrease_sp
    local.get $0
    i32.load offset=12
    local.set $2
    loop $for-loop|06
     local.get $1
     local.get $2
     local.get $0
     i32.load offset=12
     local.tee $3
     local.get $2
     local.get $3
     i32.lt_s
     select
     i32.lt_s
     if
      global.get $~lib/memory/__stack_pointer
      local.get $0
      i32.load offset=4
      local.get $1
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.tee $3
      i32.store align=1
      i32.const 0
      global.set $~lib/rt/closure/env
      local.get $3
      local.get $1
      local.get $0
      call $templateliteral/tag~anonymous|7
      i32.eqz
      if
       global.get $~lib/memory/__stack_pointer
       i32.const 4
       i32.add
       global.set $~lib/memory/__stack_pointer
       i32.const 0
       br $__inlined_func$~lib/array/Array<~lib/string/String>#every$238
      end
      local.get $1
      i32.const 1
      i32.add
      local.set $1
      br $for-loop|06
     end
    end
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
    i32.const 1
   end
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 121
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 5440
   i32.store offset=12 align=1
   i32.const 0
   local.set $1
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $0
   i32.store align=1
   block $__inlined_func$~lib/array/Array<~lib/string/String>#some$239 (result i32)
    i32.const 4
    call $~lib/rt/__decrease_sp
    local.get $0
    i32.load offset=12
    local.set $2
    loop $for-loop|07
     local.get $1
     local.get $2
     local.get $0
     i32.load offset=12
     local.tee $3
     local.get $2
     local.get $3
     i32.lt_s
     select
     i32.lt_s
     if
      global.get $~lib/memory/__stack_pointer
      local.get $0
      i32.load offset=4
      local.get $1
      i32.const 2
      i32.shl
      i32.add
      i32.load
      local.tee $3
      i32.store align=1
      i32.const 0
      global.set $~lib/rt/closure/env
      local.get $3
      local.get $1
      local.get $0
      call $templateliteral/tag~anonymous|8
      if
       global.get $~lib/memory/__stack_pointer
       i32.const 4
       i32.add
       global.set $~lib/memory/__stack_pointer
       i32.const 1
       br $__inlined_func$~lib/array/Array<~lib/string/String>#some$239
      end
      local.get $1
      i32.const 1
      i32.add
      local.set $1
      br $for-loop|07
     end
    end
    global.get $~lib/memory/__stack_pointer
    i32.const 4
    i32.add
    global.set $~lib/memory/__stack_pointer
    i32.const 0
   end
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 122
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 16
   i32.const 7
   call $~lib/rt/itcms/__new
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=12 align=1
   local.get $0
   i32.const 32
   i32.const 1
   call $~lib/rt/itcms/__new
   local.tee $1
   i32.store
   local.get $0
   local.get $1
   i32.const 0
   call $~lib/rt/itcms/__link
   local.get $0
   local.get $1
   i32.store offset=4
   local.get $0
   i32.const 32
   i32.store offset=8
   local.get $0
   i32.const 0
   i32.store offset=12
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=12 align=1
   local.get $0
   i32.const 5472
   call $~lib/array/Array<~lib/string/String>#push
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $2
   i32.store align=1
   local.get $2
   i32.load offset=12
   local.tee $4
   local.get $0
   i32.load offset=12
   local.tee $5
   i32.add
   local.tee $1
   i32.const 268435455
   i32.gt_u
   if
    i32.const 5264
    i32.const 4928
    i32.const 236
    i32.const 62
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   call $~lib/rt/__newArray
   local.tee $1
   i32.load offset=4
   local.set $3
   local.get $4
   i32.const 2
   i32.shl
   local.set $4
   local.get $2
   i32.load offset=4
   local.set $6
   i32.const 0
   local.set $2
   loop $for-loop|08
    local.get $2
    local.get $4
    i32.lt_u
    if
     local.get $2
     local.get $3
     i32.add
     local.get $2
     local.get $6
     i32.add
     i32.load
     local.tee $7
     i32.store
     local.get $1
     local.get $7
     i32.const 1
     call $~lib/rt/itcms/__link
     local.get $2
     i32.const 4
     i32.add
     local.set $2
     br $for-loop|08
    end
   end
   local.get $3
   local.get $4
   i32.add
   local.set $3
   local.get $0
   i32.load offset=4
   local.set $0
   local.get $5
   i32.const 2
   i32.shl
   local.set $4
   i32.const 0
   local.set $2
   loop $for-loop|1
    local.get $2
    local.get $4
    i32.lt_u
    if
     local.get $2
     local.get $3
     i32.add
     local.get $0
     local.get $2
     i32.add
     i32.load
     local.tee $5
     i32.store
     local.get $1
     local.get $5
     i32.const 1
     call $~lib/rt/itcms/__link
     local.get $2
     i32.const 4
     i32.add
     local.set $2
     br $for-loop|1
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $1
   i32.load offset=12
   i32.const 4
   i32.ne
   if
    i32.const 0
    i32.const 96
    i32.const 127
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   i32.const 3
   call $~lib/array/Array<~lib/string/String>#__get
   i32.const 5472
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 128
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $1
   i32.store align=1
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
   local.tee $3
   call $~lib/rt/__newArray
   local.tee $0
   i32.load offset=4
   local.set $4
   local.get $1
   i32.load offset=4
   local.get $2
   i32.const 2
   i32.shl
   i32.add
   local.set $2
   i32.const 0
   local.set $1
   local.get $3
   i32.const 2
   i32.shl
   local.set $3
   loop $while-continue|09
    local.get $1
    local.get $3
    i32.lt_u
    if
     local.get $1
     local.get $4
     i32.add
     local.get $1
     local.get $2
     i32.add
     i32.load
     local.tee $5
     i32.store
     local.get $0
     local.get $5
     i32.const 1
     call $~lib/rt/itcms/__link
     local.get $1
     i32.const 4
     i32.add
     local.set $1
     br $while-continue|09
    end
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   i32.load offset=12
   i32.const 2
   i32.ne
   if
    i32.const 0
    i32.const 96
    i32.const 131
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 0
   call $~lib/array/Array<~lib/string/String>#__get
   i32.const 64
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 132
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 1
   call $~lib/array/Array<~lib/string/String>#__get
   i32.const 32
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 133
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $0
   i32.store align=1
   local.get $0
   i32.const 5504
   call $~lib/array/Array<~lib/string/String>#join
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   i32.const 5536
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 135
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $0
   i32.store align=1
   local.get $0
   i32.const 5568
   call $~lib/array/Array<~lib/string/String>#join
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   i32.const 5600
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 136
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 160
   i32.store offset=12 align=1
   i32.const 160
   local.set $1
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.store offset=16 align=1
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 4896
   i32.load
   local.tee $2
   i32.store align=1
   i32.const 8
   i32.const 17
   call $~lib/rt/itcms/__new
   local.tee $0
   local.get $2
   i32.store offset=4
   local.get $0
   local.get $2
   i32.const 0
   call $~lib/rt/itcms/__link
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=28 align=1
   local.get $0
   call $~lib/iterator/Iterator<~lib/string/String>#next@override
   local.set $2
   global.get $~lib/memory/__stack_pointer
   local.get $2
   i32.store offset=24 align=1
   loop $for-of-loop|0
    local.get $2
    if
     local.get $1
     global.get $~lib/memory/__stack_pointer
     local.get $2
     i32.load
     local.tee $1
     i32.store offset=20 align=1
     local.get $1
     call $~lib/string/String#concat
     local.set $1
     global.get $~lib/memory/__stack_pointer
     local.get $1
     i32.store offset=16 align=1
     local.get $0
     call $~lib/iterator/Iterator<~lib/string/String>#next@override
     local.set $2
     br $for-of-loop|0
    end
   end
   local.get $1
   i32.const 5632
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 140
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 4896
   i32.load
   i32.const 0
   call $~lib/array/Array<~lib/string/String>#__get
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=12 align=1
   i32.const 1
   call $~lib/number/I32#toString
   local.set $1
   global.get $~lib/memory/__stack_pointer
   local.get $1
   i32.store offset=8 align=1
   local.get $0
   local.get $1
   call $~lib/string/String#concat
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=12 align=1
   local.get $0
   i32.const 4896
   i32.load
   i32.const 1
   call $~lib/array/Array<~lib/string/String>#__get
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=8 align=1
   local.get $0
   call $~lib/string/String#concat
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=8 align=1
   local.get $0
   i32.const 2
   call $~lib/number/I32#toString
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   local.get $0
   call $~lib/string/String#concat
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store offset=4 align=1
   i32.const 4896
   i32.load
   i32.const 2
   call $~lib/array/Array<~lib/string/String>#__get
   local.set $1
   global.get $~lib/memory/__stack_pointer
   local.get $1
   i32.store align=1
   local.get $0
   local.get $1
   call $~lib/string/String#concat
   local.set $0
   global.get $~lib/memory/__stack_pointer
   i32.const 32
   i32.add
   global.set $~lib/memory/__stack_pointer
   local.get $0
   i32.const 5664
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 147
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   i32.const 5936
   i32.const 5936
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 152
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 6000
   i32.const 6000
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 153
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 6032
   i32.const 6032
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 158
    i32.const 1
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 0
   local.set $2
   i32.const 0
   local.set $1
   loop $for-loop|09
    local.get $2
    i32.const 2
    i32.lt_s
    if
     local.get $1
     i32.const 0
     i32.ne
     local.get $1
     i32.const 6288
     local.tee $1
     i32.ne
     i32.and
     if
      i32.const 0
      i32.const 96
      i32.const 168
      i32.const 24
      call $~lib/builtins/abort
      unreachable
     end
     local.get $2
     i32.const 1
     i32.add
     local.set $2
     br $for-loop|09
    end
   end
   i32.const 4
   call $~lib/rt/__decrease_sp
   global.get $~lib/memory/__stack_pointer
   i32.const 6480
   i32.store align=1
   i32.const 6480
   call $templateliteral/raw
   i32.const 160
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 179
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 6704
   i32.store align=1
   i32.const 6704
   call $templateliteral/raw
   i32.const 6512
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 180
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 6928
   i32.store align=1
   i32.const 6928
   call $templateliteral/raw
   i32.const 6736
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 181
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 7184
   i32.store align=1
   i32.const 7184
   call $templateliteral/raw
   i32.const 6992
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 182
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
   i32.const 4
   call $~lib/rt/__decrease_sp
   i32.const 5472
   i32.const 0
   call $templateliteral/RecursiveObject#constructor@new
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   i32.const 64
   local.get $0
   call $templateliteral/RecursiveObject#constructor@new
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   i32.const 32
   local.get $0
   call $templateliteral/RecursiveObject#constructor@new
   local.set $0
   global.get $~lib/memory/__stack_pointer
   local.get $0
   i32.store align=1
   local.get $0
   call $templateliteral/RecursiveObject#toString
   i32.const 7280
   call $~lib/string/String.__eq
   i32.eqz
   if
    i32.const 0
    i32.const 96
    i32.const 204
    i32.const 3
    call $~lib/builtins/abort
    unreachable
   end
   global.get $~lib/memory/__stack_pointer
   i32.const 4
   i32.add
   global.set $~lib/memory/__stack_pointer
  end
 )
 (func $templateliteral/RecursiveObject#constructor@new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  i32.const 8
  i32.const 19
  call $~lib/rt/itcms/__new
  local.tee $2
  local.get $0
  i32.store
  local.get $2
  local.get $0
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $2
  local.get $1
  i32.store offset=4
  local.get $2
  local.get $1
  i32.const 0
  call $~lib/rt/itcms/__link
  local.get $2
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
  i32.const 7380
  i32.lt_s
  if
   unreachable
  end
 )
)
