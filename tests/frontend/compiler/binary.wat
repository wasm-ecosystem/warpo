(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32) (result f64)))
 (type $2 (func (param f64 f64) (result f64)))
 (type $3 (func (param f32 f32) (result f32)))
 (type $4 (func (param i64) (result i32)))
 (type $5 (func (param i32) (result f32)))
 (type $6 (func))
 (type $7 (func (param i32 i32) (result i32)))
 (type $8 (func (param i64) (result f64)))
 (type $9 (func (param i32 f64) (result f64)))
 (type $10 (func (param f64 i64 i64) (result f64)))
 (type $11 (func (param f64 f64 i32) (result f64)))
 (type $12 (func (param i32 f32) (result f32)))
 (type $13 (func (param f64 i32) (result f32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $binary/b (mut i32) (i32.const 0))
 (global $binary/i (mut i32) (i32.const 0))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $binary/I (mut i64) (i64.const 0))
 (global $~lib/util/math/log_tail (mut f64) (f64.const 0))
 (global $binary/f (mut f32) (f32.const 0))
 (global $binary/F (mut f64) (f64.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 6664))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 39432))
 (global $~lib/memory/__heap_base i32 (i32.const 39432))
 (memory $0 1)
 (data $0 (i32.const 8) "\00\00\00\00\00\a0\f6?\00\00\00\00\00\00\00\00\00\c8\b9\f2\82,\d6\bf\80V7($\b4\fa<\00\00\00\00\00\80\f6?\00\00\00\00\00\00\00\00\00\08X\bf\bd\d1\d5\bf \f7\e0\d8\08\a5\1c\bd\00\00\00\00\00`\f6?\00\00\00\00\00\00\00\00\00XE\17wv\d5\bfmP\b6\d5\a4b#\bd\00\00\00\00\00@\f6?\00\00\00\00\00\00\00\00\00\f8-\87\ad\1a\d5\bf\d5g\b0\9e\e4\84\e6\bc\00\00\00\00\00 \f6?\00\00\00\00\00\00\00\00\00xw\95_\be\d4\bf\e0>)\93i\1b\04\bd\00\00\00\00\00\00\f6?\00\00\00\00\00\00\00\00\00`\1c\c2\8ba\d4\bf\cc\84LH/\d8\13=\00\00\00\00\00\e0\f5?\00\00\00\00\00\00\00\00\00\a8\86\860\04\d4\bf:\0b\82\ed\f3B\dc<\00\00\00\00\00\c0\f5?\00\00\00\00\00\00\00\00\00HiUL\a6\d3\bf`\94Q\86\c6\b1 =\00\00\00\00\00\a0\f5?\00\00\00\00\00\00\00\00\00\80\98\9a\ddG\d3\bf\92\80\c5\d4MY%=\00\00\00\00\00\80\f5?\00\00\00\00\00\00\00\00\00 \e1\ba\e2\e8\d2\bf\d8+\b7\99\1e{&=\00\00\00\00\00`\f5?\00\00\00\00\00\00\00\00\00\88\de\13Z\89\d2\bf?\b0\cf\b6\14\ca\15=\00\00\00\00\00`\f5?\00\00\00\00\00\00\00\00\00\88\de\13Z\89\d2\bf?\b0\cf\b6\14\ca\15=\00\00\00\00\00@\f5?\00\00\00\00\00\00\00\00\00x\cf\fbA)\d2\bfv\daS($Z\16\bd\00\00\00\00\00 \f5?\00\00\00\00\00\00\00\00\00\98i\c1\98\c8\d1\bf\04T\e7h\bc\af\1f\bd\00\00\00\00\00\00\f5?\00\00\00\00\00\00\00\00\00\a8\ab\ab\\g\d1\bf\f0\a8\823\c6\1f\1f=\00\00\00\00\00\e0\f4?\00\00\00\00\00\00\00\00\00H\ae\f9\8b\05\d1\bffZ\05\fd\c4\a8&\bd\00\00\00\00\00\c0\f4?\00\00\00\00\00\00\00\00\00\90s\e2$\a3\d0\bf\0e\03\f4~\eek\0c\bd\00\00\00\00\00\a0\f4?\00\00\00\00\00\00\00\00\00\d0\b4\94%@\d0\bf\7f-\f4\9e\b86\f0\bc\00\00\00\00\00\a0\f4?\00\00\00\00\00\00\00\00\00\d0\b4\94%@\d0\bf\7f-\f4\9e\b86\f0\bc\00\00\00\00\00\80\f4?\00\00\00\00\00\00\00\00\00@^m\18\b9\cf\bf\87<\99\ab*W\r=\00\00\00\00\00`\f4?\00\00\00\00\00\00\00\00\00`\dc\cb\ad\f0\ce\bf$\af\86\9c\b7&+=\00\00\00\00\00@\f4?\00\00\00\00\00\00\00\00\00\f0*n\07\'\ce\bf\10\ff?TO/\17\bd\00\00\00\00\00 \f4?\00\00\00\00\00\00\00\00\00\c0Ok!\\\cd\bf\1bh\ca\bb\91\ba!=\00\00\00\00\00\00\f4?\00\00\00\00\00\00\00\00\00\a0\9a\c7\f7\8f\cc\bf4\84\9fhOy\'=\00\00\00\00\00\00\f4?\00\00\00\00\00\00\00\00\00\a0\9a\c7\f7\8f\cc\bf4\84\9fhOy\'=\00\00\00\00\00\e0\f3?\00\00\00\00\00\00\00\00\00\90-t\86\c2\cb\bf\8f\b7\8b1\b0N\19=\00\00\00\00\00\c0\f3?\00\00\00\00\00\00\00\00\00\c0\80N\c9\f3\ca\bff\90\cd?cN\ba<\00\00\00\00\00\a0\f3?\00\00\00\00\00\00\00\00\00\b0\e2\1f\bc#\ca\bf\ea\c1F\dcd\8c%\bd\00\00\00\00\00\a0\f3?\00\00\00\00\00\00\00\00\00\b0\e2\1f\bc#\ca\bf\ea\c1F\dcd\8c%\bd\00\00\00\00\00\80\f3?\00\00\00\00\00\00\00\00\00P\f4\9cZR\c9\bf\e3\d4\c1\04\d9\d1*\bd\00\00\00\00\00`\f3?\00\00\00\00\00\00\00\00\00\d0 e\a0\7f\c8\bf\t\fa\db\7f\bf\bd+=\00\00\00\00\00@\f3?\00\00\00\00\00\00\00\00\00\e0\10\02\89\ab\c7\bfXJSr\90\db+=\00\00\00\00\00@\f3?\00\00\00\00\00\00\00\00\00\e0\10\02\89\ab\c7\bfXJSr\90\db+=\00\00\00\00\00 \f3?\00\00\00\00\00\00\00\00\00\d0\19\e7\0f\d6\c6\bff\e2\b2\a3j\e4\10\bd\00\00\00\00\00\00\f3?\00\00\00\00\00\00\00\00\00\90\a7p0\ff\c5\bf9P\10\9fC\9e\1e\bd\00\00\00\00\00\00\f3?\00\00\00\00\00\00\00\00\00\90\a7p0\ff\c5\bf9P\10\9fC\9e\1e\bd\00\00\00\00\00\e0\f2?\00\00\00\00\00\00\00\00\00\b0\a1\e3\e5&\c5\bf\8f[\07\90\8b\de \bd\00\00\00\00\00\c0\f2?\00\00\00\00\00\00\00\00\00\80\cbl+M\c4\bf<x5a\c1\0c\17=\00\00\00\00\00\c0\f2?\00\00\00\00\00\00\00\00\00\80\cbl+M\c4\bf<x5a\c1\0c\17=\00\00\00\00\00\a0\f2?\00\00\00\00\00\00\00\00\00\90\1e \fcq\c3\bf:T\'M\86x\f1<\00\00\00\00\00\80\f2?\00\00\00\00\00\00\00\00\00\f0\1f\f8R\95\c2\bf\08\c4q\170\8d$\bd\00\00\00\00\00`\f2?\00\00\00\00\00\00\00\00\00`/\d5*\b7\c1\bf\96\a3\11\18\a4\80.\bd\00\00\00\00\00`\f2?\00\00\00\00\00\00\00\00\00`/\d5*\b7\c1\bf\96\a3\11\18\a4\80.\bd\00\00\00\00\00@\f2?\00\00\00\00\00\00\00\00\00\90\d0|~\d7\c0\bf\f4[\e8\88\96i\n=\00\00\00\00\00@\f2?\00\00\00\00\00\00\00\00\00\90\d0|~\d7\c0\bf\f4[\e8\88\96i\n=\00\00\00\00\00 \f2?\00\00\00\00\00\00\00\00\00\e0\db1\91\ec\bf\bf\f23\a3\\Tu%\bd\00\00\00\00\00\00\f2?\00\00\00\00\00\00\00\00\00\00+n\07\'\be\bf<\00\f0*,4*=\00\00\00\00\00\00\f2?\00\00\00\00\00\00\00\00\00\00+n\07\'\be\bf<\00\f0*,4*=\00\00\00\00\00\e0\f1?\00\00\00\00\00\00\00\00\00\c0[\8fT^\bc\bf\06\be_XW\0c\1d\bd\00\00\00\00\00\c0\f1?\00\00\00\00\00\00\00\00\00\e0J:m\92\ba\bf\c8\aa[\e859%=\00\00\00\00\00\c0\f1?\00\00\00\00\00\00\00\00\00\e0J:m\92\ba\bf\c8\aa[\e859%=\00\00\00\00\00\a0\f1?\00\00\00\00\00\00\00\00\00\a01\d6E\c3\b8\bfhV/M)|\13=\00\00\00\00\00\a0\f1?\00\00\00\00\00\00\00\00\00\a01\d6E\c3\b8\bfhV/M)|\13=\00\00\00\00\00\80\f1?\00\00\00\00\00\00\00\00\00`\e5\8a\d2\f0\b6\bf\das3\c97\97&\bd\00\00\00\00\00`\f1?\00\00\00\00\00\00\00\00\00 \06?\07\1b\b5\bfW^\c6a[\02\1f=\00\00\00\00\00`\f1?\00\00\00\00\00\00\00\00\00 \06?\07\1b\b5\bfW^\c6a[\02\1f=\00\00\00\00\00@\f1?\00\00\00\00\00\00\00\00\00\e0\1b\96\d7A\b3\bf\df\13\f9\cc\da^,=\00\00\00\00\00@\f1?\00\00\00\00\00\00\00\00\00\e0\1b\96\d7A\b3\bf\df\13\f9\cc\da^,=\00\00\00\00\00 \f1?\00\00\00\00\00\00\00\00\00\80\a3\ee6e\b1\bf\t\a3\8fv^|\14=\00\00\00\00\00\00\f1?\00\00\00\00\00\00\00\00\00\80\11\c00\n\af\bf\91\8e6\83\9eY-=\00\00\00\00\00\00\f1?\00\00\00\00\00\00\00\00\00\80\11\c00\n\af\bf\91\8e6\83\9eY-=\00\00\00\00\00\e0\f0?\00\00\00\00\00\00\00\00\00\80\19q\ddB\ab\bfLp\d6\e5z\82\1c=\00\00\00\00\00\e0\f0?\00\00\00\00\00\00\00\00\00\80\19q\ddB\ab\bfLp\d6\e5z\82\1c=\00\00\00\00\00\c0\f0?\00\00\00\00\00\00\00\00\00\c02\f6Xt\a7\bf\ee\a1\f24F\fc,\bd\00\00\00\00\00\c0\f0?\00\00\00\00\00\00\00\00\00\c02\f6Xt\a7\bf\ee\a1\f24F\fc,\bd\00\00\00\00\00\a0\f0?\00\00\00\00\00\00\00\00\00\c0\fe\b9\87\9e\a3\bf\aa\fe&\f5\b7\02\f5<\00\00\00\00\00\a0\f0?\00\00\00\00\00\00\00\00\00\c0\fe\b9\87\9e\a3\bf\aa\fe&\f5\b7\02\f5<\00\00\00\00\00\80\f0?\00\00\00\00\00\00\00\00\00\00x\0e\9b\82\9f\bf\e4\t~|&\80)\bd\00\00\00\00\00\80\f0?\00\00\00\00\00\00\00\00\00\00x\0e\9b\82\9f\bf\e4\t~|&\80)\bd\00\00\00\00\00`\f0?\00\00\00\00\00\00\00\00\00\80\d5\07\1b\b9\97\bf9\a6\fa\93T\8d(\bd\00\00\00\00\00@\f0?\00\00\00\00\00\00\00\00\00\00\fc\b0\a8\c0\8f\bf\9c\a6\d3\f6|\1e\df\bc\00\00\00\00\00@\f0?\00\00\00\00\00\00\00\00\00\00\fc\b0\a8\c0\8f\bf\9c\a6\d3\f6|\1e\df\bc\00\00\00\00\00 \f0?\00\00\00\00\00\00\00\00\00\00\10k*\e0\7f\bf\e4@\da\r?\e2\19\bd\00\00\00\00\00 \f0?\00\00\00\00\00\00\00\00\00\00\10k*\e0\7f\bf\e4@\da\r?\e2\19\bd\00\00\00\00\00\00\f0?\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\f0?\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\c0\ef?\00\00\00\00\00\00\00\00\00\00\89u\15\10\80?\e8+\9d\99k\c7\10\bd\00\00\00\00\00\80\ef?\00\00\00\00\00\00\00\00\00\80\93XV \90?\d2\f7\e2\06[\dc#\bd\00\00\00\00\00@\ef?\00\00\00\00\00\00\00\00\00\00\c9(%I\98?4\0cZ2\ba\a0*\bd\00\00\00\00\00\00\ef?\00\00\00\00\00\00\00\00\00@\e7\89]A\a0?S\d7\f1\\\c0\11\01=\00\00\00\00\00\c0\ee?\00\00\00\00\00\00\00\00\00\00.\d4\aef\a4?(\fd\bdus\16,\bd\00\00\00\00\00\80\ee?\00\00\00\00\00\00\00\00\00\c0\9f\14\aa\94\a8?}&Z\d0\95y\19\bd\00\00\00\00\00@\ee?\00\00\00\00\00\00\00\00\00\c0\dd\cds\cb\ac?\07(\d8G\f2h\1a\bd\00\00\00\00\00 \ee?\00\00\00\00\00\00\00\00\00\c0\06\c01\ea\ae?{;\c9O>\11\0e\bd\00\00\00\00\00\e0\ed?\00\00\00\00\00\00\00\00\00`F\d1;\97\b1?\9b\9e\rV]2%\bd\00\00\00\00\00\a0\ed?\00\00\00\00\00\00\00\00\00\e0\d1\a7\f5\bd\b3?\d7N\db\a5^\c8,=\00\00\00\00\00`\ed?\00\00\00\00\00\00\00\00\00\a0\97MZ\e9\b5?\1e\1d]<\06i,\bd\00\00\00\00\00@\ed?\00\00\00\00\00\00\00\00\00\c0\ea\n\d3\00\b7?2\ed\9d\a9\8d\1e\ec<\00\00\00\00\00\00\ed?\00\00\00\00\00\00\00\00\00@Y]^3\b9?\daG\bd:\\\11#=\00\00\00\00\00\c0\ec?\00\00\00\00\00\00\00\00\00`\ad\8d\c8j\bb?\e5h\f7+\80\90\13\bd\00\00\00\00\00\a0\ec?\00\00\00\00\00\00\00\00\00@\bc\01X\88\bc?\d3\acZ\c6\d1F&=\00\00\00\00\00`\ec?\00\00\00\00\00\00\00\00\00 \n\839\c7\be?\e0E\e6\afh\c0-\bd\00\00\00\00\00@\ec?\00\00\00\00\00\00\00\00\00\e0\db9\91\e8\bf?\fd\n\a1O\d64%\bd\00\00\00\00\00\00\ec?\00\00\00\00\00\00\00\00\00\e0\'\82\8e\17\c1?\f2\07-\cex\ef!=\00\00\00\00\00\e0\eb?\00\00\00\00\00\00\00\00\00\f0#~+\aa\c1?4\998D\8e\a7,=\00\00\00\00\00\a0\eb?\00\00\00\00\00\00\00\00\00\80\86\0ca\d1\c2?\a1\b4\81\cbl\9d\03=\00\00\00\00\00\80\eb?\00\00\00\00\00\00\00\00\00\90\15\b0\fce\c3?\89rK#\a8/\c6<\00\00\00\00\00@\eb?\00\00\00\00\00\00\00\00\00\b03\83=\91\c4?x\b6\fdTy\83%=\00\00\00\00\00 \eb?\00\00\00\00\00\00\00\00\00\b0\a1\e4\e5\'\c5?\c7}i\e5\e83&=\00\00\00\00\00\e0\ea?\00\00\00\00\00\00\00\00\00\10\8c\beNW\c6?x.<,\8b\cf\19=\00\00\00\00\00\c0\ea?\00\00\00\00\00\00\00\00\00pu\8b\12\f0\c6?\e1!\9c\e5\8d\11%\bd\00\00\00\00\00\a0\ea?\00\00\00\00\00\00\00\00\00PD\85\8d\89\c7?\05C\91p\10f\1c\bd\00\00\00\00\00`\ea?\00\00\00\00\00\00\00\00\00\009\eb\af\be\c8?\d1,\e9\aaT=\07\bd\00\00\00\00\00@\ea?\00\00\00\00\00\00\00\00\00\00\f7\dcZZ\c9?o\ff\a0X(\f2\07=\00\00\00\00\00\00\ea?\00\00\00\00\00\00\00\00\00\e0\8a<\ed\93\ca?i!VPCr(\bd\00\00\00\00\00\e0\e9?\00\00\00\00\00\00\00\00\00\d0[W\d81\cb?\aa\e1\acN\8d5\0c\bd\00\00\00\00\00\c0\e9?\00\00\00\00\00\00\00\00\00\e0;8\87\d0\cb?\b6\12TY\c4K-\bd\00\00\00\00\00\a0\e9?\00\00\00\00\00\00\00\00\00\10\f0\c6\fbo\cc?\d2+\96\c5r\ec\f1\bc\00\00\00\00\00`\e9?\00\00\00\00\00\00\00\00\00\90\d4\b0=\b1\cd?5\b0\15\f7*\ff*\bd\00\00\00\00\00@\e9?\00\00\00\00\00\00\00\00\00\10\e7\ff\0eS\ce?0\f4A`\'\12\c2<\00\00\00\00\00 \e9?\00\00\00\00\00\00\00\00\00\00\dd\e4\ad\f5\ce?\11\8e\bbe\15!\ca\bc\00\00\00\00\00\00\e9?\00\00\00\00\00\00\00\00\00\b0\b3l\1c\99\cf?0\df\0c\ca\ec\cb\1b=\00\00\00\00\00\c0\e8?\00\00\00\00\00\00\00\00\00XM`8q\d0?\91N\ed\16\db\9c\f8<\00\00\00\00\00\a0\e8?\00\00\00\00\00\00\00\00\00`ag-\c4\d0?\e9\ea<\16\8b\18\'=\00\00\00\00\00\80\e8?\00\00\00\00\00\00\00\00\00\e8\'\82\8e\17\d1?\1c\f0\a5c\0e!,\bd\00\00\00\00\00`\e8?\00\00\00\00\00\00\00\00\00\f8\ac\cb\\k\d1?\81\16\a5\f7\cd\9a+=\00\00\00\00\00@\e8?\00\00\00\00\00\00\00\00\00hZc\99\bf\d1?\b7\bdGQ\ed\a6,=\00\00\00\00\00 \e8?\00\00\00\00\00\00\00\00\00\b8\0emE\14\d2?\ea\baF\ba\de\87\n=\00\00\00\00\00\e0\e7?\00\00\00\00\00\00\00\00\00\90\dc|\f0\be\d2?\f4\04PJ\fa\9c*=\00\00\00\00\00\c0\e7?\00\00\00\00\00\00\00\00\00`\d3\e1\f1\14\d3?\b8<!\d3z\e2(\bd\00\00\00\00\00\a0\e7?\00\00\00\00\00\00\00\00\00\10\bevgk\d3?\c8w\f1\b0\cdn\11=\00\00\00\00\00\80\e7?\00\00\00\00\00\00\00\00\0003wR\c2\d3?\\\bd\06\b6T;\18=\00\00\00\00\00`\e7?\00\00\00\00\00\00\00\00\00\e8\d5#\b4\19\d4?\9d\e0\90\ec6\e4\08=\00\00\00\00\00@\e7?\00\00\00\00\00\00\00\00\00\c8q\c2\8dq\d4?u\d6g\t\ce\'/\bd\00\00\00\00\00 \e7?\00\00\00\00\00\00\00\00\000\17\9e\e0\c9\d4?\a4\d8\n\1b\89 .\bd\00\00\00\00\00\00\e7?\00\00\00\00\00\00\00\00\00\a08\07\ae\"\d5?Y\c7d\81p\be.=\00\00\00\00\00\e0\e6?\00\00\00\00\00\00\00\00\00\d0\c8S\f7{\d5?\ef@]\ee\ed\ad\1f=\00\00\00\00\00\c0\e6?\00\00\00\00\00\00\00\00\00`Y\df\bd\d5\d5?\dce\a4\08*\0b\n\bd")
 (data $1 (i32.const 4104) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\f0?n\bf\88\1aO;\9b<53\fb\a9=\f6\ef?]\dc\d8\9c\13`q\bca\80w>\9a\ec\ef?\d1f\87\10z^\90\bc\85\7fn\e8\15\e3\ef?\13\f6g5R\d2\8c<t\85\15\d3\b0\d9\ef?\fa\8e\f9#\80\ce\8b\bc\de\f6\dd)k\d0\ef?a\c8\e6aN\f7`<\c8\9bu\18E\c7\ef?\99\d33[\e4\a3\90<\83\f3\c6\ca>\be\ef?m{\83]\a6\9a\97<\0f\89\f9lX\b5\ef?\fc\ef\fd\92\1a\b5\8e<\f7Gr+\92\ac\ef?\d1\9c/p=\be><\a2\d1\d32\ec\a3\ef?\0bn\90\894\03j\bc\1b\d3\fe\aff\9b\ef?\0e\bd/*RV\95\bcQ[\12\d0\01\93\ef?U\eaN\8c\ef\80P\bc\cc1l\c0\bd\8a\ef?\16\f4\d5\b9#\c9\91\bc\e0-\a9\ae\9a\82\ef?\afU\\\e9\e3\d3\80<Q\8e\a5\c8\98z\ef?H\93\a5\ea\15\1b\80\bc{Q}<\b8r\ef?=2\deU\f0\1f\8f\bc\ea\8d\8c8\f9j\ef?\bfS\13?\8c\89\8b<u\cbo\eb[c\ef?&\eb\11v\9c\d9\96\bc\d4\\\04\84\e0[\ef?`/:>\f7\ec\9a<\aa\b9h1\87T\ef?\9d8\86\cb\82\e7\8f\bc\1d\d9\fc\"PM\ef?\8d\c3\a6DAo\8a<\d6\8cb\88;F\ef?}\04\e4\b0\05z\80<\96\dc}\91I?\ef?\94\a8\a8\e3\fd\8e\96<8bunz8\ef?}Ht\f2\18^\87<?\a6\b2O\ce1\ef?\f2\e7\1f\98+G\80<\dd|\e2eE+\ef?^\08q?{\b8\96\bc\81c\f5\e1\df$\ef?1\ab\tm\e1\f7\82<\e1\de\1f\f5\9d\1e\ef?\fa\bfo\1a\9b!=\bc\90\d9\da\d0\7f\18\ef?\b4\n\0cr\827\8b<\0b\03\e4\a6\85\12\ef?\8f\cb\ce\89\92\14n<V/>\a9\af\0c\ef?\b6\ab\b0MuM\83<\15\b71\n\fe\06\ef?Lt\ac\e2\01B\86<1\d8L\fcp\01\ef?J\f8\d3]9\dd\8f<\ff\16d\b2\08\fc\ee?\04[\8e;\80\a3\86\bc\f1\9f\92_\c5\f6\ee?hPK\cc\edJ\92\bc\cb\a9:7\a7\f1\ee?\8e-Q\1b\f8\07\99\bcf\d8\05m\ae\ec\ee?\d26\94>\e8\d1q\bc\f7\9f\e54\db\e7\ee?\15\1b\ce\b3\19\19\99\bc\e5\a8\13\c3-\e3\ee?mL*\a7H\9f\85<\"4\12L\a6\de\ee?\8ai(z`\12\93\bc\1c\80\ac\04E\da\ee?[\89\17H\8f\a7X\bc*.\f7!\n\d6\ee?\1b\9aIg\9b,|\bc\97\a8P\d9\f5\d1\ee?\11\ac\c2`\edcC<-\89a`\08\ce\ee?\efd\06;\tf\96<W\00\1d\edA\ca\ee?y\03\a1\da\e1\ccn<\d0<\c1\b5\a2\c6\ee?0\12\0f?\8e\ff\93<\de\d3\d7\f0*\c3\ee?\b0\afz\bb\ce\90v<\'*6\d5\da\bf\ee?w\e0T\eb\bd\1d\93<\r\dd\fd\99\b2\bc\ee?\8e\a3q\004\94\8f\bc\a7,\9dv\b2\b9\ee?I\a3\93\dc\cc\de\87\bcBf\cf\a2\da\b6\ee?_8\0f\bd\c6\dex\bc\82O\9dV+\b4\ee?\f6\\{\ecF\12\86\bc\0f\92]\ca\a4\b1\ee?\8e\d7\fd\18\055\93<\da\'\b56G\af\ee?\05\9b\8a/\b7\98{<\fd\c7\97\d4\12\ad\ee?\tT\1c\e2\e1c\90<)TH\dd\07\ab\ee?\ea\c6\19P\85\c74<\b7FY\8a&\a9\ee?5\c0d+\e62\94<H!\ad\15o\a7\ee?\9fv\99aJ\e4\8c\bc\t\dcv\b9\e1\a5\ee?\a8M\ef;\c53\8c\bc\85U:\b0~\a4\ee?\ae\e9+\89xS\84\bc \c3\cc4F\a3\ee?XXVx\dd\ce\93\bc%\"U\828\a2\ee?d\19~\80\aa\10W<s\a9L\d4U\a1\ee?(\"^\bf\ef\b3\93\bc\cd;\7ff\9e\a0\ee?\82\b94\87\ad\12j\bc\bf\da\0bu\12\a0\ee?\ee\a9m\b8\efgc\bc/\1ae<\b2\9f\ee?Q\88\e0T=\dc\80\bc\84\94Q\f9}\9f\ee?\cf>Z~d\1fx\bct_\ec\e8u\9f\ee?\b0}\8b\c0J\ee\86\bct\81\a5H\9a\9f\ee?\8a\e6U\1e2\19\86\bc\c9gBV\eb\9f\ee?\d3\d4\t^\cb\9c\90<?]\deOi\a0\ee?\1d\a5M\b9\dc2{\bc\87\01\ebs\14\a1\ee?k\c0gT\fd\ec\94<2\c10\01\ed\a1\ee?Ul\d6\ab\e1\ebe<bN\cf6\f3\a2\ee?B\cf\b3/\c5\a1\88\bc\12\1a>T\'\a4\ee?47;\f1\b6i\93\bc\13\ceL\99\89\a5\ee?\1e\ff\19:\84^\80\bc\ad\c7#F\1a\a7\ee?nWr\d8P\d4\94\bc\ed\92D\9b\d9\a8\ee?\00\8a\0e[g\ad\90<\99f\8a\d9\c7\aa\ee?\b4\ea\f0\c1/\b7\8d<\db\a0*B\e5\ac\ee?\ff\e7\c5\9c`\b6e\bc\8cD\b5\162\af\ee?D_\f3Y\83\f6{<6w\15\99\ae\b1\ee?\83=\1e\a7\1f\t\93\bc\c6\ff\91\0b[\b4\ee?)\1el\8b\b8\a9]\bc\e5\c5\cd\b07\b7\ee?Y\b9\90|\f9#l\bc\0fR\c8\cbD\ba\ee?\aa\f9\f4\"CC\92\bcPN\de\9f\82\bd\ee?K\8ef\d7l\ca\85\bc\ba\07\cap\f1\c0\ee?\'\ce\91+\fc\afq<\90\f0\a3\82\91\c4\ee?\bbs\n\e15\d2m<##\e3\19c\c8\ee?c\"b\"\04\c5\87\bce\e5]{f\cc\ee?\d51\e2\e3\86\1c\8b<3-J\ec\9b\d0\ee?\15\bb\bc\d3\d1\bb\91\bc]%>\b2\03\d5\ee?\d21\ee\9c1\cc\90<X\b30\13\9e\d9\ee?\b3Zsn\84i\84<\bf\fdyUk\de\ee?\b4\9d\8e\97\cd\df\82\bcz\f3\d3\bfk\e3\ee?\873\cb\92w\1a\8c<\ad\d3Z\99\9f\e8\ee?\fa\d9\d1J\8f{\90\bcf\b6\8d)\07\ee\ee?\ba\ae\dcV\d9\c3U\bc\fb\15O\b8\a2\f3\ee?@\f6\a6=\0e\a4\90\bc:Y\e5\8dr\f9\ee?4\93\ad8\f4\d6h\bcG^\fb\f2v\ff\ee?5\8aXk\e2\ee\91\bcJ\06\a10\b0\05\ef?\cd\dd_\n\d7\fft<\d2\c1K\90\1e\0c\ef?\ac\98\92\fa\fb\bd\91\bc\t\1e\d7[\c2\12\ef?\b3\0c\af0\aens<\9cR\85\dd\9b\19\ef?\94\fd\9f\\2\e3\8e<z\d0\ff_\ab \ef?\acY\t\d1\8f\e0\84<K\d1W.\f1\'\ef?g\1aN8\af\cdc<\b5\e7\06\94m/\ef?h\19\92l,kg<i\90\ef\dc 7\ef?\d2\b5\cc\83\18\8a\80\bc\fa\c3]U\0b?\ef?o\fa\ff?]\ad\8f\bc|\89\07J-G\ef?I\a9u8\ae\r\90\bc\f2\89\r\08\87O\ef?\a7\07=\a6\85\a3t<\87\a4\fb\dc\18X\ef?\0f\"@ \9e\91\82\bc\98\83\c9\16\e3`\ef?\ac\92\c1\d5PZ\8e<\852\db\03\e6i\ef?Kk\01\acY:\84<`\b4\01\f3!s\ef?\1f>\b4\07!\d5\82\bc_\9b{3\97|\ef?\c9\rG;\b9*\89\bc)\a1\f5\14F\86\ef?\d3\88:`\04\b6t<\f6?\8b\e7.\90\ef?qr\9dQ\ec\c5\83<\83L\c7\fbQ\9a\ef?\f0\91\d3\8f\12\f7\8f\bc\da\90\a4\a2\af\a4\ef?}t#\e2\98\ae\8d\bc\f1g\8e-H\af\ef?\08 \aaA\bc\c3\8e<\'Za\ee\1b\ba\ef?2\eb\a9\c3\94+\84<\97\bak7+\c5\ef?\ee\85\d11\a9d\8a<@En[v\d0\ef?\ed\e3;\e4\ba7\8e\bc\14\be\9c\ad\fd\db\ef?\9d\cd\91M;\89w<\d8\90\9e\81\c1\e7\ef?\89\cc`A\c1\05S<\f1q\8f+\c2\f3\ef?")
 (data $2 (i32.const 6152) "\be\f3\f8y\eca\f6?\190\96[\c6\fe\de\bf=\88\afJ\edq\f5?\a4\fc\d42h\0b\db\bf\b0\10\f0\f09\95\f4?{\b7\1f\n\8bA\d7\bf\85\03\b8\b0\95\c9\f3?{\cfm\1a\e9\9d\d3\bf\a5d\88\0c\19\r\f3?1\b6\f2\f3\9b\1d\d0\bf\a0\8e\0b{\"^\f2?\f0z;\1b\1d|\c9\bf?4\1aJJ\bb\f1?\9f<\af\93\e3\f9\c2\bf\ba\e5\8a\f0X#\f1?\\\8dx\bf\cb`\b9\bf\a7\00\99A?\95\f0?\ce_G\b6\9do\aa\bf\00\00\00\00\00\00\f0?\00\00\00\00\00\00\00\00\acG\9a\fd\8c`\ee?=\f5$\9f\ca8\b3?\a0j\02\1f\b3\a4\ec?\ba\918T\a9v\c4?\e6\fcjW6 \eb?\d2\e4\c4J\0b\84\ce?-\aa\a1c\d1\c2\e9?\1ce\c6\f0E\06\d4?\edAx\03\e6\86\e8?\f8\9f\1b,\9c\8e\d8?bHS\f5\dcg\e7?\cc{\b1N\a4\e0\dc?")
 (data $3 (i32.const 6408) "\00\00\00\00\00\00\f0?t\85\15\d3\b0\d9\ef?\0f\89\f9lX\b5\ef?Q[\12\d0\01\93\ef?{Q}<\b8r\ef?\aa\b9h1\87T\ef?8bunz8\ef?\e1\de\1f\f5\9d\1e\ef?\15\b71\n\fe\06\ef?\cb\a9:7\a7\f1\ee?\"4\12L\a6\de\ee?-\89a`\08\ce\ee?\'*6\d5\da\bf\ee?\82O\9dV+\b4\ee?)TH\dd\07\ab\ee?\85U:\b0~\a4\ee?\cd;\7ff\9e\a0\ee?t_\ec\e8u\9f\ee?\87\01\ebs\14\a1\ee?\13\ceL\99\89\a5\ee?\db\a0*B\e5\ac\ee?\e5\c5\cd\b07\b7\ee?\90\f0\a3\82\91\c4\ee?]%>\b2\03\d5\ee?\ad\d3Z\99\9f\e8\ee?G^\fb\f2v\ff\ee?\9cR\85\dd\9b\19\ef?i\90\ef\dc 7\ef?\87\a4\fb\dc\18X\ef?_\9b{3\97|\ef?\da\90\a4\a2\af\a4\ef?@En[v\d0\ef?")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
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
 (func $~lib/util/math/zeroinfnan (param $u i64) (result i32)
  (return
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
 (func $~lib/util/math/checkint (param $iy i64) (result i32)
  (local $e i64)
  (local.set $e
   (i64.and
    (i64.shr_u
     (local.get $iy)
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
    (return
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
    (return
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
     (local.get $iy)
     (i64.sub
      (local.get $e)
      (i64.const 1)
     )
    )
    (i64.const 0)
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (if
   (i64.ne
    (i64.and
     (local.get $iy)
     (local.get $e)
    )
    (i64.const 0)
   )
   (then
    (return
     (i32.const 1)
    )
   )
  )
  (return
   (i32.const 2)
  )
 )
 (func $~lib/util/math/log_inline (param $ix i64) (result f64)
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
  (local $y f64)
  (local.set $tmp
   (i64.sub
    (local.get $ix)
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
    (local.get $ix)
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
     (i32.const 8)
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
     (i32.const 8)
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
     (i32.const 8)
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
  (local.set $y
   (f64.add
    (local.get $hi)
    (local.get $lo)
   )
  )
  (global.set $~lib/util/math/log_tail
   (f64.add
    (f64.sub
     (local.get $hi)
     (local.get $y)
    )
    (local.get $lo)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $~lib/util/math/xflow (param $sign i32) (param $y f64) (result f64)
  (return
   (f64.mul
    (select
     (f64.neg
      (local.get $y)
     )
     (local.get $y)
     (local.get $sign)
    )
    (local.get $y)
   )
  )
 )
 (func $~lib/util/math/uflow (param $sign i32) (result f64)
  (return
   (call $~lib/util/math/xflow
    (local.get $sign)
    (f64.reinterpret_i64
     (i64.const 1152921504606846976)
    )
   )
  )
 )
 (func $~lib/util/math/oflow (param $sign i32) (result f64)
  (return
   (call $~lib/util/math/xflow
    (local.get $sign)
    (f64.reinterpret_i64
     (i64.const 8070450532247928832)
    )
   )
  )
 )
 (func $~lib/util/math/specialcase (param $tmp f64) (param $sbits i64) (param $ki i64) (result f64)
  (local $scale f64)
  (local $y f64)
  (local $one f64)
  (local $lo f64)
  (local $hi f64)
  (if
   (i32.eqz
    (i64.ne
     (i64.and
      (local.get $ki)
      (i64.const 2147483648)
     )
     (i64.const 0)
    )
   )
   (then
    (local.set $sbits
     (i64.sub
      (local.get $sbits)
      (i64.shl
       (i64.const 1009)
       (i64.const 52)
      )
     )
    )
    (local.set $scale
     (f64.reinterpret_i64
      (local.get $sbits)
     )
    )
    (return
     (f64.mul
      (f64.const 5486124068793688683255936e279)
      (f64.add
       (local.get $scale)
       (f64.mul
        (local.get $scale)
        (local.get $tmp)
       )
      )
     )
    )
   )
  )
  (local.set $sbits
   (i64.add
    (local.get $sbits)
    (i64.shl
     (i64.const 1022)
     (i64.const 52)
    )
   )
  )
  (local.set $scale
   (f64.reinterpret_i64
    (local.get $sbits)
   )
  )
  (local.set $y
   (f64.add
    (local.get $scale)
    (f64.mul
     (local.get $scale)
     (local.get $tmp)
    )
   )
  )
  (if
   (f64.lt
    (f64.abs
     (local.get $y)
    )
    (f64.const 1)
   )
   (then
    (local.set $one
     (f64.copysign
      (f64.const 1)
      (local.get $y)
     )
    )
    (local.set $lo
     (f64.add
      (f64.sub
       (local.get $scale)
       (local.get $y)
      )
      (f64.mul
       (local.get $scale)
       (local.get $tmp)
      )
     )
    )
    (local.set $hi
     (f64.add
      (local.get $one)
      (local.get $y)
     )
    )
    (local.set $lo
     (f64.add
      (f64.add
       (f64.sub
        (local.get $one)
        (local.get $hi)
       )
       (local.get $y)
      )
      (local.get $lo)
     )
    )
    (local.set $y
     (f64.sub
      (f64.add
       (local.get $hi)
       (local.get $lo)
      )
      (local.get $one)
     )
    )
    (if
     (f64.eq
      (local.get $y)
      (f64.const 0)
     )
     (then
      (local.set $y
       (f64.reinterpret_i64
        (i64.and
         (local.get $sbits)
         (i64.const -9223372036854775808)
        )
       )
      )
     )
    )
   )
  )
  (return
   (f64.mul
    (local.get $y)
    (f64.const 2.2250738585072014e-308)
   )
  )
 )
 (func $~lib/util/math/exp_inline (param $x f64) (param $xtail f64) (param $sign_bias i32) (result f64)
  (local $abstop i32)
  (local $ki i64)
  (local $top i64)
  (local $sbits i64)
  (local $idx i32)
  (local $kd f64)
  (local $z f64)
  (local $r f64)
  (local $r2 f64)
  (local $scale f64)
  (local $tail f64)
  (local $tmp f64)
  (local $ux i64)
  (local.set $ux
   (i64.reinterpret_f64
    (local.get $x)
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
      (return
       (select
        (f64.const -1)
        (f64.const 1)
        (local.get $sign_bias)
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
      (return
       (if (result f64)
        (i64.lt_s
         (local.get $ux)
         (i64.const 0)
        )
        (then
         (call $~lib/util/math/uflow
          (local.get $sign_bias)
         )
        )
        (else
         (call $~lib/util/math/oflow
          (local.get $sign_bias)
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
  (local.set $z
   (f64.mul
    (f64.const 184.6649652337873)
    (local.get $x)
   )
  )
  (local.set $kd
   (f64.add
    (local.get $z)
    (f64.const 6755399441055744)
   )
  )
  (local.set $ki
   (i64.reinterpret_f64
    (local.get $kd)
   )
  )
  (local.set $kd
   (f64.sub
    (local.get $kd)
    (f64.const 6755399441055744)
   )
  )
  (local.set $r
   (f64.add
    (f64.add
     (local.get $x)
     (f64.mul
      (local.get $kd)
      (f64.const -0.005415212348111709)
     )
    )
    (f64.mul
     (local.get $kd)
     (f64.const -1.2864023111638346e-14)
    )
   )
  )
  (local.set $r
   (f64.add
    (local.get $r)
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
      (local.get $sign_bias)
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
      (i32.const 4104)
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
      (i32.const 4104)
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
    (local.get $r)
    (local.get $r)
   )
  )
  (local.set $tmp
   (f64.add
    (f64.add
     (f64.add
      (local.get $tail)
      (local.get $r)
     )
     (f64.mul
      (local.get $r2)
      (f64.add
       (f64.const 0.49999999999996786)
       (f64.mul
        (local.get $r)
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
       (local.get $r)
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
    (return
     (call $~lib/util/math/specialcase
      (local.get $tmp)
      (local.get $sbits)
      (local.get $ki)
     )
    )
   )
  )
  (local.set $scale
   (f64.reinterpret_i64
    (local.get $sbits)
   )
  )
  (return
   (f64.add
    (local.get $scale)
    (f64.mul
     (local.get $scale)
     (local.get $tmp)
    )
   )
  )
 )
 (func $~lib/util/math/pow_lut (param $x f64) (param $y f64) (result f64)
  (local $sign_bias i32)
  (local $ix i64)
  (local $iy i64)
  (local $topx i64)
  (local $topy i64)
  (local $x2 f64)
  (local $yint i32)
  (local $hi f64)
  (local $lo f64)
  (local $ehi f64)
  (local $elo f64)
  (local $yhi f64)
  (local $ylo f64)
  (local $lhi f64)
  (local $llo f64)
  (local.set $sign_bias
   (i32.const 0)
  )
  (local.set $ix
   (i64.reinterpret_f64
    (local.get $x)
   )
  )
  (local.set $iy
   (i64.reinterpret_f64
    (local.get $y)
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
     (call $~lib/util/math/zeroinfnan
      (local.get $iy)
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
        (return
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
        (return
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
        (return
         (f64.add
          (local.get $x)
          (local.get $y)
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
        (return
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
        (return
         (f64.const 0)
        )
       )
      )
      (return
       (f64.mul
        (local.get $y)
        (local.get $y)
       )
      )
     )
    )
    (if
     (call $~lib/util/math/zeroinfnan
      (local.get $ix)
     )
     (then
      (local.set $x2
       (f64.mul
        (local.get $x)
        (local.get $x)
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
          (call $~lib/util/math/checkint
           (local.get $iy)
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
      (return
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
       (call $~lib/util/math/checkint
        (local.get $iy)
       )
      )
      (if
       (i32.eq
        (local.get $yint)
        (i32.const 0)
       )
       (then
        (return
         (f64.div
          (f64.sub
           (local.get $x)
           (local.get $x)
          )
          (f64.sub
           (local.get $x)
           (local.get $x)
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
        (return
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
        (return
         (f64.const 1)
        )
       )
      )
      (return
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
         (local.get $x)
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
  (local.set $hi
   (call $~lib/util/math/log_inline
    (local.get $ix)
   )
  )
  (local.set $lo
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
    (local.get $y)
    (local.get $yhi)
   )
  )
  (local.set $lhi
   (f64.reinterpret_i64
    (i64.and
     (i64.reinterpret_f64
      (local.get $hi)
     )
     (i64.const -134217728)
    )
   )
  )
  (local.set $llo
   (f64.add
    (f64.sub
     (local.get $hi)
     (local.get $lhi)
    )
    (local.get $lo)
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
     (local.get $y)
     (local.get $llo)
    )
   )
  )
  (return
   (call $~lib/util/math/exp_inline
    (local.get $ehi)
    (local.get $elo)
    (local.get $sign_bias)
   )
  )
 )
 (func $~lib/math/NativeMath.pow (param $x f64) (param $y f64) (result f64)
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
   (call $~lib/util/math/pow_lut
    (local.get $x)
    (local.get $y)
   )
  )
 )
 (func $~lib/math/NativeMathf.mod (param $x f32) (param $y f32) (result f32)
  (local $ux i32)
  (local $uy i32)
  (local $ex i32)
  (local $ey i32)
  (local $sm i32)
  (local $uy1 i32)
  (local $m f32)
  (local $ux1 i32)
  (local $shift i32)
  (if
   (f32.eq
    (f32.abs
     (local.get $y)
    )
    (f32.const 1)
   )
   (then
    (return
     (f32.copysign
      (f32.sub
       (local.get $x)
       (f32.trunc
        (local.get $x)
       )
      )
      (local.get $x)
     )
    )
   )
  )
  (local.set $ux
   (i32.reinterpret_f32
    (local.get $x)
   )
  )
  (local.set $uy
   (i32.reinterpret_f32
    (local.get $y)
   )
  )
  (local.set $ex
   (i32.and
    (i32.shr_u
     (local.get $ux)
     (i32.const 23)
    )
    (i32.const 255)
   )
  )
  (local.set $ey
   (i32.and
    (i32.shr_u
     (local.get $uy)
     (i32.const 23)
    )
    (i32.const 255)
   )
  )
  (local.set $sm
   (i32.and
    (local.get $ux)
    (i32.const -2147483648)
   )
  )
  (local.set $uy1
   (i32.shl
    (local.get $uy)
    (i32.const 1)
   )
  )
  (if
   (if (result i32)
    (if (result i32)
     (i32.eq
      (local.get $uy1)
      (i32.const 0)
     )
     (then
      (i32.const 1)
     )
     (else
      (i32.eq
       (local.get $ex)
       (i32.const 255)
      )
     )
    )
    (then
     (i32.const 1)
    )
    (else
     (f32.ne
      (local.get $y)
      (local.get $y)
     )
    )
   )
   (then
    (local.set $m
     (f32.mul
      (local.get $x)
      (local.get $y)
     )
    )
    (return
     (f32.div
      (local.get $m)
      (local.get $m)
     )
    )
   )
  )
  (local.set $ux1
   (i32.shl
    (local.get $ux)
    (i32.const 1)
   )
  )
  (if
   (i32.le_u
    (local.get $ux1)
    (local.get $uy1)
   )
   (then
    (return
     (f32.mul
      (local.get $x)
      (f32.convert_i32_u
       (i32.ne
        (local.get $ux1)
        (local.get $uy1)
       )
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (local.get $ex)
   )
   (then
    (local.set $ex
     (i32.sub
      (local.get $ex)
      (i32.clz
       (i32.shl
        (local.get $ux)
        (i32.const 9)
       )
      )
     )
    )
    (local.set $ux
     (i32.shl
      (local.get $ux)
      (i32.sub
       (i32.const 1)
       (local.get $ex)
      )
     )
    )
   )
   (else
    (local.set $ux
     (i32.and
      (local.get $ux)
      (i32.shr_u
       (i32.const -1)
       (i32.const 9)
      )
     )
    )
    (local.set $ux
     (i32.or
      (local.get $ux)
      (i32.shl
       (i32.const 1)
       (i32.const 23)
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (local.get $ey)
   )
   (then
    (local.set $ey
     (i32.sub
      (local.get $ey)
      (i32.clz
       (i32.shl
        (local.get $uy)
        (i32.const 9)
       )
      )
     )
    )
    (local.set $uy
     (i32.shl
      (local.get $uy)
      (i32.sub
       (i32.const 1)
       (local.get $ey)
      )
     )
    )
   )
   (else
    (local.set $uy
     (i32.and
      (local.get $uy)
      (i32.shr_u
       (i32.const -1)
       (i32.const 9)
      )
     )
    )
    (local.set $uy
     (i32.or
      (local.get $uy)
      (i32.shl
       (i32.const 1)
       (i32.const 23)
      )
     )
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.gt_s
      (local.get $ex)
      (local.get $ey)
     )
     (then
      (if
       (i32.ge_u
        (local.get $ux)
        (local.get $uy)
       )
       (then
        (if
         (i32.eq
          (local.get $ux)
          (local.get $uy)
         )
         (then
          (return
           (f32.mul
            (f32.const 0)
            (local.get $x)
           )
          )
         )
        )
        (local.set $ux
         (i32.sub
          (local.get $ux)
          (local.get $uy)
         )
        )
       )
      )
      (local.set $ux
       (i32.shl
        (local.get $ux)
        (i32.const 1)
       )
      )
      (local.set $ex
       (i32.sub
        (local.get $ex)
        (i32.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (i32.ge_u
    (local.get $ux)
    (local.get $uy)
   )
   (then
    (if
     (i32.eq
      (local.get $ux)
      (local.get $uy)
     )
     (then
      (return
       (f32.mul
        (f32.const 0)
        (local.get $x)
       )
      )
     )
    )
    (local.set $ux
     (i32.sub
      (local.get $ux)
      (local.get $uy)
     )
    )
   )
  )
  (local.set $shift
   (i32.clz
    (i32.shl
     (local.get $ux)
     (i32.const 8)
    )
   )
  )
  (local.set $ex
   (i32.sub
    (local.get $ex)
    (local.get $shift)
   )
  )
  (local.set $ux
   (i32.shl
    (local.get $ux)
    (local.get $shift)
   )
  )
  (if
   (i32.gt_s
    (local.get $ex)
    (i32.const 0)
   )
   (then
    (local.set $ux
     (i32.sub
      (local.get $ux)
      (i32.shl
       (i32.const 1)
       (i32.const 23)
      )
     )
    )
    (local.set $ux
     (i32.or
      (local.get $ux)
      (i32.shl
       (local.get $ex)
       (i32.const 23)
      )
     )
    )
   )
   (else
    (local.set $ux
     (i32.shr_u
      (local.get $ux)
      (i32.add
       (i32.sub
        (i32.const 0)
        (local.get $ex)
       )
       (i32.const 1)
      )
     )
    )
   )
  )
  (return
   (f32.reinterpret_i32
    (i32.or
     (local.get $ux)
     (local.get $sm)
    )
   )
  )
 )
 (func $~lib/util/math/zeroinfnanf (param $ux i32) (result i32)
  (return
   (i32.ge_u
    (i32.sub
     (i32.shl
      (local.get $ux)
      (i32.const 1)
     )
     (i32.const 1)
    )
    (i32.sub
     (i32.shl
      (i32.const 2139095040)
      (i32.const 1)
     )
     (i32.const 1)
    )
   )
  )
 )
 (func $~lib/util/math/checkintf (param $iy i32) (result i32)
  (local $e i32)
  (local.set $e
   (i32.and
    (i32.shr_u
     (local.get $iy)
     (i32.const 23)
    )
    (i32.const 255)
   )
  )
  (if
   (i32.lt_u
    (local.get $e)
    (i32.const 127)
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (if
   (i32.gt_u
    (local.get $e)
    (i32.add
     (i32.const 127)
     (i32.const 23)
    )
   )
   (then
    (return
     (i32.const 2)
    )
   )
  )
  (local.set $e
   (i32.shl
    (i32.const 1)
    (i32.sub
     (i32.add
      (i32.const 127)
      (i32.const 23)
     )
     (local.get $e)
    )
   )
  )
  (if
   (i32.and
    (local.get $iy)
    (i32.sub
     (local.get $e)
     (i32.const 1)
    )
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (if
   (i32.and
    (local.get $iy)
    (local.get $e)
   )
   (then
    (return
     (i32.const 1)
    )
   )
  )
  (return
   (i32.const 2)
  )
 )
 (func $~lib/util/math/log2f_inline (param $ux i32) (result f64)
  (local $tmp i32)
  (local $i i32)
  (local $top i32)
  (local $uz i32)
  (local $k i32)
  (local $invc f64)
  (local $logc f64)
  (local $z f64)
  (local $r f64)
  (local $y0 f64)
  (local $y f64)
  (local $p f64)
  (local $q f64)
  (local.set $tmp
   (i32.sub
    (local.get $ux)
    (i32.const 1060306944)
   )
  )
  (local.set $i
   (i32.and
    (i32.shr_u
     (local.get $tmp)
     (i32.sub
      (i32.const 23)
      (i32.const 4)
     )
    )
    (i32.const 15)
   )
  )
  (local.set $top
   (i32.and
    (local.get $tmp)
    (i32.const -8388608)
   )
  )
  (local.set $uz
   (i32.sub
    (local.get $ux)
    (local.get $top)
   )
  )
  (local.set $k
   (i32.shr_s
    (local.get $top)
    (i32.const 23)
   )
  )
  (local.set $invc
   (f64.load
    (i32.add
     (i32.const 6152)
     (i32.shl
      (local.get $i)
      (i32.add
       (i32.const 1)
       (i32.const 3)
      )
     )
    )
   )
  )
  (local.set $logc
   (f64.load offset=8
    (i32.add
     (i32.const 6152)
     (i32.shl
      (local.get $i)
      (i32.add
       (i32.const 1)
       (i32.const 3)
      )
     )
    )
   )
  )
  (local.set $z
   (f64.promote_f32
    (f32.reinterpret_i32
     (local.get $uz)
    )
   )
  )
  (local.set $r
   (f64.sub
    (f64.mul
     (local.get $z)
     (local.get $invc)
    )
    (f64.const 1)
   )
  )
  (local.set $y0
   (f64.add
    (local.get $logc)
    (f64.convert_i32_s
     (local.get $k)
    )
   )
  )
  (local.set $y
   (f64.add
    (f64.mul
     (f64.const 0.288457581109214)
     (local.get $r)
    )
    (f64.const -0.36092606229713164)
   )
  )
  (local.set $p
   (f64.add
    (f64.mul
     (f64.const 0.480898481472577)
     (local.get $r)
    )
    (f64.const -0.7213474675006291)
   )
  )
  (local.set $q
   (f64.add
    (f64.mul
     (f64.const 1.4426950408774342)
     (local.get $r)
    )
    (local.get $y0)
   )
  )
  (local.set $r
   (f64.mul
    (local.get $r)
    (local.get $r)
   )
  )
  (local.set $q
   (f64.add
    (local.get $q)
    (f64.mul
     (local.get $p)
     (local.get $r)
    )
   )
  )
  (local.set $y
   (f64.add
    (f64.mul
     (local.get $y)
     (f64.mul
      (local.get $r)
      (local.get $r)
     )
    )
    (local.get $q)
   )
  )
  (return
   (local.get $y)
  )
 )
 (func $~lib/util/math/xflowf (param $sign i32) (param $y f32) (result f32)
  (return
   (f32.mul
    (select
     (f32.neg
      (local.get $y)
     )
     (local.get $y)
     (local.get $sign)
    )
    (local.get $y)
   )
  )
 )
 (func $~lib/util/math/oflowf (param $sign i32) (result f32)
  (return
   (call $~lib/util/math/xflowf
    (local.get $sign)
    (f32.reinterpret_i32
     (i32.const 1879048192)
    )
   )
  )
 )
 (func $~lib/util/math/uflowf (param $sign i32) (result f32)
  (return
   (call $~lib/util/math/xflowf
    (local.get $sign)
    (f32.reinterpret_i32
     (i32.const 268435456)
    )
   )
  )
 )
 (func $~lib/util/math/exp2f_inline (param $xd f64) (param $signBias i32) (result f32)
  (local $kd f64)
  (local $ki i64)
  (local $r f64)
  (local $t i64)
  (local $z f64)
  (local $y f64)
  (local $s f64)
  (local.set $kd
   (f64.add
    (local.get $xd)
    (f64.const 211106232532992)
   )
  )
  (local.set $ki
   (i64.reinterpret_f64
    (local.get $kd)
   )
  )
  (local.set $r
   (f64.sub
    (local.get $xd)
    (f64.sub
     (local.get $kd)
     (f64.const 211106232532992)
    )
   )
  )
  (local.set $t
   (i64.load
    (i32.add
     (i32.const 6408)
     (i32.shl
      (i32.and
       (i32.wrap_i64
        (local.get $ki)
       )
       (i32.const 31)
      )
      (i32.const 3)
     )
    )
   )
  )
  (local.set $t
   (i64.add
    (local.get $t)
    (i64.shl
     (i64.add
      (local.get $ki)
      (i64.extend_i32_u
       (local.get $signBias)
      )
     )
     (i64.sub
      (i64.const 52)
      (i64.extend_i32_s
       (i32.const 5)
      )
     )
    )
   )
  )
  (local.set $s
   (f64.reinterpret_i64
    (local.get $t)
   )
  )
  (local.set $z
   (f64.add
    (f64.mul
     (f64.const 0.05550361559341535)
     (local.get $r)
    )
    (f64.const 0.2402284522445722)
   )
  )
  (local.set $y
   (f64.add
    (f64.mul
     (f64.const 0.6931471806916203)
     (local.get $r)
    )
    (f64.const 1)
   )
  )
  (local.set $y
   (f64.add
    (local.get $y)
    (f64.mul
     (local.get $z)
     (f64.mul
      (local.get $r)
      (local.get $r)
     )
    )
   )
  )
  (local.set $y
   (f64.mul
    (local.get $y)
    (local.get $s)
   )
  )
  (return
   (f32.demote_f64
    (local.get $y)
   )
  )
 )
 (func $~lib/util/math/powf_lut (param $x f32) (param $y f32) (result f32)
  (local $signBias i32)
  (local $ix i32)
  (local $iy i32)
  (local $ny i32)
  (local $x2 f32)
  (local $yint i32)
  (local $logx f64)
  (local $ylogx f64)
  (local.set $signBias
   (i32.const 0)
  )
  (local.set $ix
   (i32.reinterpret_f32
    (local.get $x)
   )
  )
  (local.set $iy
   (i32.reinterpret_f32
    (local.get $y)
   )
  )
  (local.set $ny
   (i32.const 0)
  )
  (if
   (i32.or
    (i32.ge_u
     (i32.sub
      (local.get $ix)
      (i32.const 8388608)
     )
     (i32.sub
      (i32.const 2139095040)
      (i32.const 8388608)
     )
    )
    (local.tee $ny
     (call $~lib/util/math/zeroinfnanf
      (local.get $iy)
     )
    )
   )
   (then
    (if
     (local.get $ny)
     (then
      (if
       (i32.eq
        (i32.shl
         (local.get $iy)
         (i32.const 1)
        )
        (i32.const 0)
       )
       (then
        (return
         (f32.const 1)
        )
       )
      )
      (if
       (i32.eq
        (local.get $ix)
        (i32.const 1065353216)
       )
       (then
        (return
         (f32.const nan:0x400000)
        )
       )
      )
      (if
       (if (result i32)
        (i32.gt_u
         (i32.shl
          (local.get $ix)
          (i32.const 1)
         )
         (i32.shl
          (i32.const 2139095040)
          (i32.const 1)
         )
        )
        (then
         (i32.const 1)
        )
        (else
         (i32.gt_u
          (i32.shl
           (local.get $iy)
           (i32.const 1)
          )
          (i32.shl
           (i32.const 2139095040)
           (i32.const 1)
          )
         )
        )
       )
       (then
        (return
         (f32.add
          (local.get $x)
          (local.get $y)
         )
        )
       )
      )
      (if
       (i32.eq
        (i32.shl
         (local.get $ix)
         (i32.const 1)
        )
        (i32.shl
         (i32.const 1065353216)
         (i32.const 1)
        )
       )
       (then
        (return
         (f32.const nan:0x400000)
        )
       )
      )
      (if
       (i32.eq
        (i32.lt_u
         (i32.shl
          (local.get $ix)
          (i32.const 1)
         )
         (i32.shl
          (i32.const 1065353216)
          (i32.const 1)
         )
        )
        (i32.eqz
         (i32.shr_u
          (local.get $iy)
          (i32.const 31)
         )
        )
       )
       (then
        (return
         (f32.const 0)
        )
       )
      )
      (return
       (f32.mul
        (local.get $y)
        (local.get $y)
       )
      )
     )
    )
    (if
     (call $~lib/util/math/zeroinfnanf
      (local.get $ix)
     )
     (then
      (local.set $x2
       (f32.mul
        (local.get $x)
        (local.get $x)
       )
      )
      (if
       (if (result i32)
        (i32.shr_u
         (local.get $ix)
         (i32.const 31)
        )
        (then
         (i32.eq
          (call $~lib/util/math/checkintf
           (local.get $iy)
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
         (f32.neg
          (local.get $x2)
         )
        )
       )
      )
      (return
       (if (result f32)
        (i32.lt_s
         (local.get $iy)
         (i32.const 0)
        )
        (then
         (f32.div
          (f32.const 1)
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
     (i32.lt_s
      (local.get $ix)
      (i32.const 0)
     )
     (then
      (local.set $yint
       (call $~lib/util/math/checkintf
        (local.get $iy)
       )
      )
      (if
       (i32.eq
        (local.get $yint)
        (i32.const 0)
       )
       (then
        (return
         (f32.div
          (f32.sub
           (local.get $x)
           (local.get $x)
          )
          (f32.sub
           (local.get $x)
           (local.get $x)
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
        (local.set $signBias
         (i32.const 65536)
        )
       )
      )
      (local.set $ix
       (i32.and
        (local.get $ix)
        (i32.const 2147483647)
       )
      )
     )
    )
    (if
     (i32.lt_u
      (local.get $ix)
      (i32.const 8388608)
     )
     (then
      (local.set $ix
       (i32.reinterpret_f32
        (f32.mul
         (local.get $x)
         (f32.const 8388608)
        )
       )
      )
      (local.set $ix
       (i32.and
        (local.get $ix)
        (i32.const 2147483647)
       )
      )
      (local.set $ix
       (i32.sub
        (local.get $ix)
        (i32.shl
         (i32.const 23)
         (i32.const 23)
        )
       )
      )
     )
    )
   )
  )
  (local.set $logx
   (call $~lib/util/math/log2f_inline
    (local.get $ix)
   )
  )
  (local.set $ylogx
   (f64.mul
    (f64.promote_f32
     (local.get $y)
    )
    (local.get $logx)
   )
  )
  (if
   (i64.ge_u
    (i64.and
     (i64.shr_u
      (i64.reinterpret_f64
       (local.get $ylogx)
      )
      (i64.const 47)
     )
     (i64.const 65535)
    )
    (i64.const 32959)
   )
   (then
    (if
     (f64.gt
      (local.get $ylogx)
      (f64.const 127.99999995700433)
     )
     (then
      (return
       (call $~lib/util/math/oflowf
        (local.get $signBias)
       )
      )
     )
    )
    (if
     (f64.le
      (local.get $ylogx)
      (f64.const -150)
     )
     (then
      (return
       (call $~lib/util/math/uflowf
        (local.get $signBias)
       )
      )
     )
    )
   )
  )
  (return
   (call $~lib/util/math/exp2f_inline
    (local.get $ylogx)
    (local.get $signBias)
   )
  )
 )
 (func $~lib/math/NativeMathf.pow (param $x f32) (param $y f32) (result f32)
  (if
   (f32.le
    (f32.abs
     (local.get $y)
    )
    (f32.const 2)
   )
   (then
    (if
     (f32.eq
      (local.get $y)
      (f32.const 2)
     )
     (then
      (return
       (f32.mul
        (local.get $x)
        (local.get $x)
       )
      )
     )
    )
    (if
     (f32.eq
      (local.get $y)
      (f32.const 0.5)
     )
     (then
      (return
       (select
        (f32.abs
         (f32.sqrt
          (local.get $x)
         )
        )
        (f32.const inf)
        (f32.ne
         (local.get $x)
         (f32.neg
          (f32.const inf)
         )
        )
       )
      )
     )
    )
    (if
     (f32.eq
      (local.get $y)
      (f32.const -1)
     )
     (then
      (return
       (f32.div
        (f32.const 1)
        (local.get $x)
       )
      )
     )
    )
    (if
     (f32.eq
      (local.get $y)
      (f32.const 1)
     )
     (then
      (return
       (local.get $x)
      )
     )
    )
    (if
     (f32.eq
      (local.get $y)
      (f32.const 0)
     )
     (then
      (return
       (f32.const 1)
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
   (call $~lib/util/math/powf_lut
    (local.get $x)
    (local.get $y)
   )
  )
 )
 (func $~lib/math/NativeMath.mod (param $x f64) (param $y f64) (result f64)
  (local $ux i64)
  (local $uy i64)
  (local $ex i64)
  (local $ey i64)
  (local $sx i64)
  (local $uy1 i64)
  (local $m f64)
  (local $ux1 i64)
  (local $shift i64)
  (if
   (f64.eq
    (f64.abs
     (local.get $y)
    )
    (f64.const 1)
   )
   (then
    (return
     (f64.copysign
      (f64.sub
       (local.get $x)
       (f64.trunc
        (local.get $x)
       )
      )
      (local.get $x)
     )
    )
   )
  )
  (local.set $ux
   (i64.reinterpret_f64
    (local.get $x)
   )
  )
  (local.set $uy
   (i64.reinterpret_f64
    (local.get $y)
   )
  )
  (local.set $ex
   (i64.and
    (i64.shr_u
     (local.get $ux)
     (i64.const 52)
    )
    (i64.const 2047)
   )
  )
  (local.set $ey
   (i64.and
    (i64.shr_u
     (local.get $uy)
     (i64.const 52)
    )
    (i64.const 2047)
   )
  )
  (local.set $sx
   (i64.shr_u
    (local.get $ux)
    (i64.const 63)
   )
  )
  (local.set $uy1
   (i64.shl
    (local.get $uy)
    (i64.const 1)
   )
  )
  (if
   (if (result i32)
    (if (result i32)
     (i64.eq
      (local.get $uy1)
      (i64.const 0)
     )
     (then
      (i32.const 1)
     )
     (else
      (i64.eq
       (local.get $ex)
       (i64.const 2047)
      )
     )
    )
    (then
     (i32.const 1)
    )
    (else
     (f64.ne
      (local.get $y)
      (local.get $y)
     )
    )
   )
   (then
    (local.set $m
     (f64.mul
      (local.get $x)
      (local.get $y)
     )
    )
    (return
     (f64.div
      (local.get $m)
      (local.get $m)
     )
    )
   )
  )
  (local.set $ux1
   (i64.shl
    (local.get $ux)
    (i64.const 1)
   )
  )
  (if
   (i64.le_u
    (local.get $ux1)
    (local.get $uy1)
   )
   (then
    (return
     (f64.mul
      (local.get $x)
      (f64.convert_i32_u
       (i64.ne
        (local.get $ux1)
        (local.get $uy1)
       )
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (i64.ne
     (local.get $ex)
     (i64.const 0)
    )
   )
   (then
    (local.set $ex
     (i64.sub
      (local.get $ex)
      (i64.clz
       (i64.shl
        (local.get $ux)
        (i64.const 12)
       )
      )
     )
    )
    (local.set $ux
     (i64.shl
      (local.get $ux)
      (i64.sub
       (i64.const 1)
       (local.get $ex)
      )
     )
    )
   )
   (else
    (local.set $ux
     (i64.and
      (local.get $ux)
      (i64.shr_u
       (i64.const -1)
       (i64.const 12)
      )
     )
    )
    (local.set $ux
     (i64.or
      (local.get $ux)
      (i64.shl
       (i64.const 1)
       (i64.const 52)
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (i64.ne
     (local.get $ey)
     (i64.const 0)
    )
   )
   (then
    (local.set $ey
     (i64.sub
      (local.get $ey)
      (i64.clz
       (i64.shl
        (local.get $uy)
        (i64.const 12)
       )
      )
     )
    )
    (local.set $uy
     (i64.shl
      (local.get $uy)
      (i64.sub
       (i64.const 1)
       (local.get $ey)
      )
     )
    )
   )
   (else
    (local.set $uy
     (i64.and
      (local.get $uy)
      (i64.shr_u
       (i64.const -1)
       (i64.const 12)
      )
     )
    )
    (local.set $uy
     (i64.or
      (local.get $uy)
      (i64.shl
       (i64.const 1)
       (i64.const 52)
      )
     )
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i64.gt_s
      (local.get $ex)
      (local.get $ey)
     )
     (then
      (if
       (i64.ge_u
        (local.get $ux)
        (local.get $uy)
       )
       (then
        (if
         (i64.eq
          (local.get $ux)
          (local.get $uy)
         )
         (then
          (return
           (f64.mul
            (f64.const 0)
            (local.get $x)
           )
          )
         )
        )
        (local.set $ux
         (i64.sub
          (local.get $ux)
          (local.get $uy)
         )
        )
       )
      )
      (local.set $ux
       (i64.shl
        (local.get $ux)
        (i64.const 1)
       )
      )
      (local.set $ex
       (i64.sub
        (local.get $ex)
        (i64.const 1)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (if
   (i64.ge_u
    (local.get $ux)
    (local.get $uy)
   )
   (then
    (if
     (i64.eq
      (local.get $ux)
      (local.get $uy)
     )
     (then
      (return
       (f64.mul
        (f64.const 0)
        (local.get $x)
       )
      )
     )
    )
    (local.set $ux
     (i64.sub
      (local.get $ux)
      (local.get $uy)
     )
    )
   )
  )
  (local.set $shift
   (i64.clz
    (i64.shl
     (local.get $ux)
     (i64.const 11)
    )
   )
  )
  (local.set $ex
   (i64.sub
    (local.get $ex)
    (local.get $shift)
   )
  )
  (local.set $ux
   (i64.shl
    (local.get $ux)
    (local.get $shift)
   )
  )
  (if
   (i64.gt_s
    (local.get $ex)
    (i64.const 0)
   )
   (then
    (local.set $ux
     (i64.sub
      (local.get $ux)
      (i64.shl
       (i64.const 1)
       (i64.const 52)
      )
     )
    )
    (local.set $ux
     (i64.or
      (local.get $ux)
      (i64.shl
       (local.get $ex)
       (i64.const 52)
      )
     )
    )
   )
   (else
    (local.set $ux
     (i64.shr_u
      (local.get $ux)
      (i64.add
       (i64.sub
        (i64.const 0)
        (local.get $ex)
       )
       (i64.const 1)
      )
     )
    )
   )
  )
  (return
   (f64.reinterpret_i64
    (i64.or
     (local.get $ux)
     (i64.shl
      (local.get $sx)
      (i64.const 63)
     )
    )
   )
  )
 )
 (func $start:binary
  (drop
   (i32.lt_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.gt_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.le_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.ge_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.eq
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.add
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.sub
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.mul
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.div_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.rem_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (call $~lib/math/ipow32
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.shl
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.shr_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.shr_u
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.and
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.or
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i32.xor
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/b
   (i32.lt_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/b
   (i32.gt_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/b
   (i32.le_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/b
   (i32.ge_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/b
   (i32.eq
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/b
   (i32.eq
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.add
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.sub
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.mul
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.div_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.rem_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (call $~lib/math/ipow32
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.shl
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.shr_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.shr_u
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.and
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.or
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.xor
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.add
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.sub
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.mul
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.rem_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.shl
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.shr_s
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.shr_u
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.and
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.or
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (global.set $binary/i
   (i32.xor
    (global.get $binary/i)
    (i32.const 1)
   )
  )
  (drop
   (i64.lt_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.gt_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.le_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.ge_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.eq
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.eq
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.add
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.sub
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.mul
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.div_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.rem_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (call $~lib/math/NativeMath.pow
    (f64.convert_i64_s
     (global.get $binary/I)
    )
    (f64.const 1)
   )
  )
  (drop
   (i64.shl
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.shr_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.shr_u
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.and
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.or
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (i64.xor
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/b
   (i64.lt_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/b
   (i64.gt_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/b
   (i64.le_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/b
   (i64.ge_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/b
   (i64.eq
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/b
   (i64.eq
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.add
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.sub
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.mul
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.div_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.rem_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.trunc_f64_s
    (call $~lib/math/NativeMath.pow
     (f64.convert_i64_s
      (global.get $binary/I)
     )
     (f64.const 1)
    )
   )
  )
  (global.set $binary/I
   (i64.shl
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.shr_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.shr_u
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.and
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.or
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.xor
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.add
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.sub
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.mul
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.rem_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.shl
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.shr_s
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.shr_u
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.and
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.or
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (global.set $binary/I
   (i64.xor
    (global.get $binary/I)
    (i64.const 1)
   )
  )
  (drop
   (f32.lt
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f32.gt
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f32.le
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f32.ge
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f32.eq
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f32.eq
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f32.add
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f32.sub
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f32.mul
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f32.div
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (call $~lib/math/NativeMathf.mod
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (call $~lib/math/NativeMathf.pow
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/b
   (f32.lt
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/b
   (f32.gt
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/b
   (f32.le
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/b
   (f32.ge
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/b
   (f32.eq
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/b
   (f32.eq
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (f32.add
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (f32.sub
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (f32.mul
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (f32.div
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (call $~lib/math/NativeMathf.mod
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (call $~lib/math/NativeMathf.pow
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (f32.add
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (f32.sub
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (f32.mul
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (call $~lib/math/NativeMathf.mod
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (global.set $binary/f
   (call $~lib/math/NativeMathf.pow
    (global.get $binary/f)
    (f32.const 1)
   )
  )
  (drop
   (f64.lt
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (f64.gt
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (f64.le
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (f64.ge
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (f64.eq
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (f64.eq
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (f64.add
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (f64.sub
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (f64.mul
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (f64.div
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (call $~lib/math/NativeMath.mod
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (drop
   (call $~lib/math/NativeMath.pow
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/b
   (f64.lt
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/b
   (f64.gt
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/b
   (f64.le
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/b
   (f64.ge
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/b
   (f64.eq
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/b
   (f64.eq
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (f64.add
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (f64.sub
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (f64.mul
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (f64.div
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (call $~lib/math/NativeMath.mod
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (call $~lib/math/NativeMath.pow
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (f64.add
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (f64.sub
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (f64.mul
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (call $~lib/math/NativeMath.mod
    (global.get $binary/F)
    (f64.const 1)
   )
  )
  (global.set $binary/F
   (call $~lib/math/NativeMath.pow
    (global.get $binary/F)
    (f64.const 1)
   )
  )
 )
 (func $~start
  (call $start:binary)
 )
)
