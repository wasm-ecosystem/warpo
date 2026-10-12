(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (type $3 (func (param i32 i32 i32) (result i32)))
 (type $4 (func (param i32 i32 i32)))
 (type $5 (func (param i32)))
 (type $6 (func))
 (type $7 (func (param i32 i32 i32 i32)))
 (type $8 (func (result i32)))
 (type $9 (func (param i32 i32 i64) (result i32)))
 (type $10 (func (param i32 i64) (result i32)))
 (type $11 (func (param i32 i32 i32 i32 i32) (result i32)))
 (type $12 (func (param i32 i32 i32 i32) (result i32)))
 (type $13 (func (param i32 i64 i32)))
 (type $14 (func (param i64 i32) (result i32)))
 (type $15 (func (param i32 i64 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/closure/getClosureEnvByLevel" (func $~lib/rt/closure/getClosureEnvByLevel (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/closure/setClosureEnv" (func $~lib/rt/closure/setClosureEnv (param i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
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
 (global $std/readonlyarray/source (mut i32) (i32.const 0))
 (global $std/readonlyarray/values (mut i32) (i32.const 0))
 (global $~lib/builtins/i32.MAX_VALUE i32 (i32.const 2147483647))
 (global $~lib/rt/closure/env (mut i32) (i32.const 0))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $std/readonlyarray/nestedSource (mut i32) (i32.const 0))
 (global $std/readonlyarray/nested (mut i32) (i32.const 0))
 (global $std/readonlyarray/flattened (mut i32) (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $~lib/rt/__rtti_base i32 (i32.const 2832))
 (global $~lib/memory/__data_end i32 (i32.const 2884))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 35652))
 (global $~lib/memory/__heap_base i32 (i32.const 35652))
 (memory $0 1)
 (data $0 (i32.const 12) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00")
 (data $1 (i32.const 60) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00")
 (data $2 (i32.const 108) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $3 (i32.const 172) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 240) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 272) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 300) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $7 (i32.const 364) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 416) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 444) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $10 (i32.const 508) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00s\00t\00d\00/\00r\00e\00a\00d\00o\00n\00l\00y\00a\00r\00r\00a\00y\00.\00t\00s\00\00\00\00\00")
 (data $11 (i32.const 572) "\1c\00\00\00\00\00\00\00\00\00\00\00\06\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $12 (i32.const 604) "\1c\00\00\00\00\00\00\00\00\00\00\00\06\00\00\00\08\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00")
 (data $13 (i32.const 636) "\1c\00\00\00\00\00\00\00\00\00\00\00\06\00\00\00\08\00\00\00\04\00\00\00\00\00\00\00\00\00\00\00")
 (data $14 (i32.const 668) "\1c\00\00\00\00\00\00\00\00\00\00\00\06\00\00\00\08\00\00\00\05\00\00\00\00\00\00\00\00\00\00\00")
 (data $15 (i32.const 700) "\1c\00\00\00\00\00\00\00\00\00\00\00\06\00\00\00\08\00\00\00\06\00\00\00\00\00\00\00\00\00\00\00")
 (data $16 (i32.const 732) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00i\00n\00v\00a\00l\00i\00d\00 \00d\00o\00w\00n\00c\00a\00s\00t\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $17 (i32.const 796) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00-\00\00\00\00\00\00\00\00\00\00\00")
 (data $18 (i32.const 828) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\001\00-\002\00-\003\00-\002\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $19 (i32.const 876) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\001\00,\002\00,\003\00,\002\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $20 (i32.const 924) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\08\00\00\00\01\00\00\00\02\00\00\00\00\00\00\00")
 (data $21 (i32.const 956) "\1c\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\08\00\00\00\03\00\00\00\04\00\00\00\00\00\00\00")
 (data $22 (i32.const 988) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $23 (i32.const 1020) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00d\00\00\00t\00o\00S\00t\00r\00i\00n\00g\00(\00)\00 \00r\00a\00d\00i\00x\00 \00a\00r\00g\00u\00m\00e\00n\00t\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006\00\00\00\00\00\00\00\00\00")
 (data $24 (i32.const 1148) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00u\00t\00i\00l\00/\00n\00u\00m\00b\00e\00r\00.\00t\00s\00\00\00\00\00\00\00")
 (data $25 (i32.const 1212) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\000\00\00\00\00\00\00\00\00\00\00\00")
 (data $26 (i32.const 1244) "0\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\00")
 (data $27 (i32.const 1644) "\1c\04\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\04\00\000\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\000\00a\000\00b\000\00c\000\00d\000\00e\000\00f\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\00a\001\00b\001\00c\001\00d\001\00e\001\00f\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\002\00a\002\00b\002\00c\002\00d\002\00e\002\00f\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\003\00a\003\00b\003\00c\003\00d\003\00e\003\00f\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\004\00a\004\00b\004\00c\004\00d\004\00e\004\00f\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\005\00a\005\00b\005\00c\005\00d\005\00e\005\00f\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\006\00a\006\00b\006\00c\006\00d\006\00e\006\00f\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\007\00a\007\00b\007\00c\007\00d\007\00e\007\00f\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\008\00a\008\00b\008\00c\008\00d\008\00e\008\00f\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\009\00a\009\00b\009\00c\009\00d\009\00e\009\00f\00a\000\00a\001\00a\002\00a\003\00a\004\00a\005\00a\006\00a\007\00a\008\00a\009\00a\00a\00a\00b\00a\00c\00a\00d\00a\00e\00a\00f\00b\000\00b\001\00b\002\00b\003\00b\004\00b\005\00b\006\00b\007\00b\008\00b\009\00b\00a\00b\00b\00b\00c\00b\00d\00b\00e\00b\00f\00c\000\00c\001\00c\002\00c\003\00c\004\00c\005\00c\006\00c\007\00c\008\00c\009\00c\00a\00c\00b\00c\00c\00c\00d\00c\00e\00c\00f\00d\000\00d\001\00d\002\00d\003\00d\004\00d\005\00d\006\00d\007\00d\008\00d\009\00d\00a\00d\00b\00d\00c\00d\00d\00d\00e\00d\00f\00e\000\00e\001\00e\002\00e\003\00e\004\00e\005\00e\006\00e\007\00e\008\00e\009\00e\00a\00e\00b\00e\00c\00e\00d\00e\00e\00e\00f\00f\000\00f\001\00f\002\00f\003\00f\004\00f\005\00f\006\00f\007\00f\008\00f\009\00f\00a\00f\00b\00f\00c\00f\00d\00f\00e\00f\00f\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $28 (i32.const 2700) "\\\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00H\00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z\00\00\00\00\00")
 (data $29 (i32.const 2796) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00,\00\00\00\00\00\00\00\00\00\00\00")
 (data $30 (i32.const 2832) "\0c\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\02\t\00\00\00\00\00\00\00\00\00\00\00\00\00\00 \00\00\00\02A\00\00\00\00\00\00\00\00\00\00")
 (table $0 7 7 funcref)
 (elem $0 (i32.const 1) $std/readonlyarray/checkReadonlyArray~anonymous|0 $std/readonlyarray/checkReadonlyArray~anonymous|1 $std/readonlyarray/checkReadonlyArray~anonymous|2 $std/readonlyarray/checkReadonlyArray~anonymous|3 $std/readonlyarray/checkReadonlyArray~anonymous|4 $std/readonlyarray/checkReadonlyArray~anonymous|5)
 (export "memory" (memory $0))
 (start $~start)
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
         (i32.const 192)
         (i32.const 159)
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
       (i32.const 192)
       (i32.const 127)
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
     (i32.const 192)
     (i32.const 131)
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
     (i32.const 320)
     (i32.const 384)
     (i32.const 22)
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
        (i32.const 192)
        (i32.const 147)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 464)
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
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 464)
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
     (i32.const 464)
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
         (i32.const 192)
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
     (drop
      (i32.eq
       (i32.rem_u
        (i32.const 200)
        (i32.const 100)
       )
       (i32.const 0)
      )
     )
     (global.set $~lib/rt/itcms/threshold
      (i32.add
       (i32.mul
        (global.get $~lib/rt/itcms/total)
        (i32.div_u
         (i32.const 200)
         (i32.const 100)
        )
       )
       (i32.const 1024)
      )
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
     (i32.const 128)
     (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
        (call $~lib/builtins/abort
         (i32.const 0)
         (i32.const 464)
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
  (local $6 i32)
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
     (i32.const 464)
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
    (local.set $6
     (call $~lib/rt/tlsf/GETRIGHT
      (local.get $block)
     )
    )
    (call $~lib/rt/common/BLOCK#set:mmInfo
     (local.get $6)
     (i32.and
      (call $~lib/rt/common/BLOCK#get:mmInfo
       (local.get $6)
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
       (i32.const 464)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 464)
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
     (i32.const 128)
     (i32.const 192)
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
     (i32.const 192)
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
 (func $~lib/array/Array<i32>#set:buffer (param $this i32) (param $buffer i32)
  (i32.store
   (local.get $this)
   (local.get $buffer)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $buffer)
   (i32.const 0)
  )
 )
 (func $~lib/array/Array<i32>#set:dataStart (param $this i32) (param $dataStart i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $dataStart)
  )
 )
 (func $~lib/array/Array<i32>#set:byteLength (param $this i32) (param $byteLength i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $byteLength)
  )
 )
 (func $~lib/array/Array<i32>#set:length_ (param $this i32) (param $length_ i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $length_)
  )
 )
 (func $~lib/array/Array<i32>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (nop)
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
     (i32.const 32)
     (i32.const 80)
     (i32.const 82)
     (i32.const 62)
    )
    (unreachable)
   )
  )
  (local.set $bufferSize
   (i32.shl
    (select
     (local.tee $2
      (local.get $length)
     )
     (local.tee $3
      (i32.const 8)
     )
     (i32.gt_u
      (local.get $2)
      (local.get $3)
     )
    )
    (i32.const 2)
   )
  )
  (local.set $buffer
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (local.get $bufferSize)
     (i32.const 1)
    )
   )
  )
  (call $~lib/array/Array<i32>#set:buffer
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $buffer)
   )
  )
  (call $~lib/array/Array<i32>#set:dataStart
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $buffer)
  )
  (call $~lib/array/Array<i32>#set:byteLength
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $bufferSize)
  )
  (call $~lib/array/Array<i32>#set:length_
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $length)
  )
  (local.get $this)
 )
 (func $~lib/array/Array<i32>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
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
       (i32.const 32)
       (i32.const 80)
       (i32.const 31)
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
 (func $~lib/array/Array<i32>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
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
 (func $~lib/readonlyarray/ReadonlyArray<i32>#get:length (param $this i32) (result i32)
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#__get (param $this i32) (param $index i32) (result i32)
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#at (param $this i32) (param $index i32) (result i32)
  (unreachable)
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|0 (param $value i32) (param $index i32) (param $array i32) (result i32)
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/readonlyarray/ReadonlyArray<i32>#__get@override
      (call $~lib/rt/__tmptostack
       (local.get $array)
      )
      (local.get $index)
     )
     (local.get $value)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 7)
     (i32.const 7)
    )
    (unreachable)
   )
  )
  (return
   (i32.eq
    (local.get $value)
    (i32.const 3)
   )
  )
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#findIndex (param $this i32) (param $fn i32) (result i32)
  (unreachable)
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|1 (param $value i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.eq
   (local.get $value)
   (i32.const 2)
  )
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#findLastIndex (param $this i32) (param $fn i32) (result i32)
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#includes (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#indexOf (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#lastIndexOf (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (unreachable)
 )
 (func $~lib/tuple/SmallTuple#__set<i32> (param $this i32) (param $offset i32) (param $value i32)
  (local $elementPtr i32)
  (local.set $elementPtr
   (i32.add
    (local.get $this)
    (local.get $offset)
   )
  )
  (i32.store
   (local.get $elementPtr)
   (local.get $value)
  )
  (drop
   (i32.const 0)
  )
 )
 (func $~lib/tuple/SmallTuple#__get<i32> (param $this i32) (param $offset i32) (result i32)
  (local $elementPtr i32)
  (local.set $elementPtr
   (i32.add
    (local.get $this)
    (local.get $offset)
   )
  )
  (return
   (i32.load
    (local.get $elementPtr)
   )
  )
 )
 (func $~lib/rt/__newTuple (param $elementSize i32) (param $bitmap i64) (result i32)
  (local $totalSize i32)
  (local $ptr i32)
  (local.set $totalSize
   (i32.add
    (local.get $elementSize)
    (i32.const 8)
   )
  )
  (local.set $ptr
   (call $~lib/rt/itcms/__new
    (local.get $totalSize)
    (i32.const 5)
   )
  )
  (i64.store
   (i32.add
    (local.get $ptr)
    (local.get $elementSize)
   )
   (local.get $bitmap)
  )
  (return
   (local.get $ptr)
  )
 )
 (func $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null> (param $this i32) (param $offset i32) (param $value i32)
  (local $elementPtr i32)
  (local.set $elementPtr
   (i32.add
    (local.get $this)
    (local.get $offset)
   )
  )
  (i32.store
   (local.get $elementPtr)
   (local.get $value)
  )
  (drop
   (i32.const 1)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $value)
   (i32.const 0)
  )
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|2 (param $value i32) (param $index i32) (param $array i32)
  (local $3 i32)
  (local.set $3
   (call $~lib/rt/__localtostack
    (call $~lib/rt/__newTuple
     (i32.const 4)
     (i64.const 1)
    )
   )
  )
  (call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
   (call $~lib/rt/__tmptostack
    (local.get $3)
   )
   (i32.const 0)
   (call $~lib/rt/__tmptostack
    (global.get $~lib/rt/closure/env)
   )
  )
  (global.set $~lib/rt/closure/env
   (i32.const 0)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/readonlyarray/ReadonlyArray<i32>#__get@override
      (call $~lib/rt/__tmptostack
       (local.get $array)
      )
      (local.get $index)
     )
     (local.get $value)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 19)
     (i32.const 5)
    )
    (unreachable)
   )
  )
  (call $~lib/tuple/SmallTuple#__set<i32>
   (call $~lib/rt/__tmptostack
    (call $~lib/rt/closure/getClosureEnvByLevel
     (i32.const 1)
    )
   )
   (i32.const 4)
   (i32.add
    (call $~lib/tuple/SmallTuple#__get<i32>
     (call $~lib/rt/__tmptostack
      (call $~lib/rt/closure/getClosureEnvByLevel
       (i32.const 1)
      )
     )
     (i32.const 4)
    )
    (local.get $value)
   )
  )
  (call $~lib/tuple/SmallTuple#__set<i32>
   (call $~lib/rt/__tmptostack
    (call $~lib/rt/closure/getClosureEnvByLevel
     (i32.const 1)
    )
   )
   (i32.const 8)
   (i32.add
    (call $~lib/tuple/SmallTuple#__get<i32>
     (call $~lib/rt/__tmptostack
      (call $~lib/rt/closure/getClosureEnvByLevel
       (i32.const 1)
      )
     )
     (i32.const 8)
    )
    (i32.const 1)
   )
  )
 )
 (func $~lib/rt/__newFunction (param $functionIdnex i32) (param $env i32) (param $rtid i32) (result i32)
  (local $ptr i32)
  (local.set $ptr
   (call $~lib/rt/itcms/__new
    (i32.const 8)
    (local.get $rtid)
   )
  )
  (i32.store
   (local.get $ptr)
   (local.get $functionIdnex)
  )
  (i32.store
   (i32.add
    (local.get $ptr)
    (i32.const 4)
   )
   (local.get $env)
  )
  (return
   (local.get $ptr)
  )
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#forEach (param $this i32) (param $fn i32)
  (unreachable)
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|3 (param $value i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.gt_s
   (local.get $value)
   (i32.const 0)
  )
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#every (param $this i32) (param $fn i32) (result i32)
  (unreachable)
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|4 (param $value i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.eq
   (local.get $value)
   (i32.const 3)
  )
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#some (param $this i32) (param $fn i32) (result i32)
  (unreachable)
 )
 (func $std/readonlyarray/checkReadonlyArray~anonymous|5 (param $value i32) (param $$1 i32) (param $$2 i32) (result i32)
  (i32.eq
   (i32.rem_s
    (local.get $value)
    (i32.const 2)
   )
   (i32.const 0)
  )
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#filter (param $this i32) (param $fn i32) (result i32)
  (unreachable)
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
     (i32.const 320)
     (i32.const 80)
     (i32.const 124)
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
 (func $~lib/readonlyarray/ReadonlyArray<i32>#slice (param $this i32) (param $start i32) (param $end i32) (result i32)
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#concat (param $this i32) (param $other i32) (result i32)
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#join (param $this i32) (param $separator i32) (result i32)
  (unreachable)
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
 (func $~lib/readonlyarray/ReadonlyArray<i32>#toString (param $this i32) (result i32)
  (unreachable)
 )
 (func $"~lib/iterator/Iterable<i32>#[~lib/symbol/Symbol.iterator]" (param $this i32) (result i32)
  (unreachable)
 )
 (func $~lib/iterator/Iterator<i32>#next (param $this i32) (result i32)
  (unreachable)
 )
 (func $~lib/iterator/IteratorResult<i32>#get:done (param $this i32) (result i32)
  (return
   (i32.eq
    (i32.const 0)
    (local.get $this)
   )
  )
 )
 (func $~lib/iterator/IteratorResult<i32>#get:value (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $std/readonlyarray/checkReadonlyArray (param $values i32)
  (local $1 i32)
  (local $sum i32)
  (local $count i32)
  (local $filtered i32)
  (local $sliced i32)
  (local $6 i32)
  (local $concatenated i32)
  (local $iterated i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $value i32)
  (local.set $1
   (call $~lib/rt/__localtostack
    (call $~lib/rt/__newTuple
     (i32.const 12)
     (i64.const 1)
    )
   )
  )
  (call $~lib/tuple/SmallTuple#__set<~lib/tuple/SmallTuple|null>
   (call $~lib/rt/__tmptostack
    (local.get $1)
   )
   (i32.const 0)
   (i32.const 0)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/readonlyarray/ReadonlyArray<i32>#get:length@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
     )
     (i32.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 2)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/readonlyarray/ReadonlyArray<i32>#__get@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
      (i32.const 1)
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 3)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/readonlyarray/ReadonlyArray<i32>#at@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
      (i32.const -1)
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 4)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/readonlyarray/ReadonlyArray<i32>#findIndex@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
      (call $~lib/rt/__tmptostack
       (i32.const 592)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 5)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/readonlyarray/ReadonlyArray<i32>#findLastIndex@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
      (call $~lib/rt/__tmptostack
       (i32.const 624)
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 11)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.ne
     (call $~lib/readonlyarray/ReadonlyArray<i32>#includes@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
      (i32.const 3)
      (i32.const 0)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 12)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/readonlyarray/ReadonlyArray<i32>#indexOf@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
      (i32.const 2)
      (i32.const 0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 13)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/readonlyarray/ReadonlyArray<i32>#lastIndexOf@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
      (i32.const 2)
      (global.get $~lib/builtins/i32.MAX_VALUE)
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 14)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (call $~lib/tuple/SmallTuple#__set<i32>
   (call $~lib/rt/__tmptostack
    (local.get $1)
   )
   (i32.const 4)
   (i32.const 0)
  )
  (call $~lib/tuple/SmallTuple#__set<i32>
   (call $~lib/rt/__tmptostack
    (local.get $1)
   )
   (i32.const 8)
   (i32.const 0)
  )
  (call $~lib/readonlyarray/ReadonlyArray<i32>#forEach@override
   (call $~lib/rt/__tmptostack
    (local.get $values)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/rt/__newFunction
     (i32.const 3)
     (local.get $1)
     (i32.const 7)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/tuple/SmallTuple#__get<i32>
      (call $~lib/rt/__tmptostack
       (local.get $1)
      )
      (i32.const 4)
     )
     (i32.const 8)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 23)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/tuple/SmallTuple#__get<i32>
      (call $~lib/rt/__tmptostack
       (local.get $1)
      )
      (i32.const 8)
     )
     (call $~lib/readonlyarray/ReadonlyArray<i32>#get:length@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 24)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.ne
     (call $~lib/readonlyarray/ReadonlyArray<i32>#every@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
      (call $~lib/rt/__tmptostack
       (i32.const 656)
      )
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 26)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.ne
     (call $~lib/readonlyarray/ReadonlyArray<i32>#some@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
      (call $~lib/rt/__tmptostack
       (i32.const 688)
      )
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 27)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (local.set $filtered
   (call $~lib/rt/__localtostack
    (call $~lib/readonlyarray/ReadonlyArray<i32>#filter@override
     (call $~lib/rt/__tmptostack
      (local.get $values)
     )
     (call $~lib/rt/__tmptostack
      (i32.const 720)
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
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 30)
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
     (i32.const 528)
     (i32.const 31)
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
     (i32.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 32)
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
      (i32.const 2)
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 33)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (local.set $sliced
   (call $~lib/rt/__localtostack
    (call $~lib/readonlyarray/ReadonlyArray<i32>#slice@override
     (call $~lib/rt/__tmptostack
      (local.get $values)
     )
     (i32.const 1)
     (i32.const 3)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#get:length
      (call $~lib/rt/__tmptostack
       (local.get $sliced)
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 36)
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
       (local.get $sliced)
      )
      (i32.const 0)
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 37)
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
       (local.get $sliced)
      )
      (i32.const 1)
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 38)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (local.set $concatenated
   (call $~lib/rt/__localtostack
    (call $~lib/readonlyarray/ReadonlyArray<i32>#concat@override
     (call $~lib/rt/__tmptostack
      (local.get $values)
     )
     (call $~lib/rt/__tmptostack
      (if (result i32)
       (call $~instanceof|~lib/array/Array<i32>
        (local.tee $6
         (call $~lib/rt/__localtostack
          (local.get $values)
         )
        )
       )
       (then
        (local.get $6)
       )
       (else
        (call $~lib/builtins/abort
         (i32.const 752)
         (i32.const 528)
         (i32.const 40)
         (i32.const 36)
        )
        (unreachable)
       )
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#get:length
      (call $~lib/rt/__tmptostack
       (local.get $concatenated)
      )
     )
     (i32.const 8)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 41)
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
       (local.get $concatenated)
      )
      (i32.const 4)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 42)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/readonlyarray/ReadonlyArray<i32>#join@override
       (call $~lib/rt/__tmptostack
        (local.get $values)
       )
       (i32.const 816)
      )
     )
     (i32.const 848)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 44)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/readonlyarray/ReadonlyArray<i32>#toString@override
       (call $~lib/rt/__tmptostack
        (local.get $values)
       )
      )
     )
     (i32.const 896)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 45)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (local.set $iterated
   (i32.const 0)
  )
  (local.set $9
   (call $~lib/rt/__localtostack
    (local.get $values)
   )
  )
  (local.set $10
   (call $~lib/rt/__localtostack
    (call $"~lib/iterator/Iterable<i32>#[~lib/symbol/Symbol.iterator]@override"
     (call $~lib/rt/__tmptostack
      (local.get $9)
     )
    )
   )
  )
  (local.set $11
   (call $~lib/rt/__localtostack
    (call $~lib/iterator/Iterator<i32>#next@override
     (call $~lib/rt/__tmptostack
      (local.get $10)
     )
    )
   )
  )
  (loop $for-of-loop|0
   (if
    (i32.eqz
     (call $~lib/iterator/IteratorResult<i32>#get:done
      (call $~lib/rt/__tmptostack
       (local.get $11)
      )
     )
    )
    (then
     (local.set $value
      (call $~lib/iterator/IteratorResult<i32>#get:value
       (call $~lib/rt/__tmptostack
        (local.get $11)
       )
      )
     )
     (if
      (i32.eqz
       (i32.eq
        (local.get $value)
        (call $~lib/readonlyarray/ReadonlyArray<i32>#__get@override
         (call $~lib/rt/__tmptostack
          (local.get $values)
         )
         (local.get $iterated)
        )
       )
      )
      (then
       (call $~lib/builtins/abort
        (i32.const 0)
        (i32.const 528)
        (i32.const 49)
        (i32.const 5)
       )
       (unreachable)
      )
     )
     (local.set $iterated
      (i32.add
       (local.get $iterated)
       (i32.const 1)
      )
     )
     (local.set $11
      (call $~lib/rt/__localtostack
       (call $~lib/iterator/Iterator<i32>#next@override
        (call $~lib/rt/__tmptostack
         (local.get $10)
        )
       )
      )
     )
     (br $for-of-loop|0)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (local.get $iterated)
     (call $~lib/readonlyarray/ReadonlyArray<i32>#get:length@override
      (call $~lib/rt/__tmptostack
       (local.get $values)
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 52)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#set:buffer (param $this i32) (param $buffer i32)
  (i32.store
   (local.get $this)
   (local.get $buffer)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $buffer)
   (i32.const 0)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#set:dataStart (param $this i32) (param $dataStart i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $dataStart)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#set:byteLength (param $this i32) (param $byteLength i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $byteLength)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#set:length_ (param $this i32) (param $length_ i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $length_)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#constructor (param $this i32) (param $length i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $bufferSize i32)
  (local $buffer i32)
  (nop)
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
     (i32.const 32)
     (i32.const 80)
     (i32.const 82)
     (i32.const 62)
    )
    (unreachable)
   )
  )
  (local.set $bufferSize
   (i32.shl
    (select
     (local.tee $2
      (local.get $length)
     )
     (local.tee $3
      (i32.const 8)
     )
     (i32.gt_u
      (local.get $2)
      (local.get $3)
     )
    )
    (i32.const 2)
   )
  )
  (local.set $buffer
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (local.get $bufferSize)
     (i32.const 1)
    )
   )
  )
  (call $~lib/array/Array<~lib/array/Array<i32>>#set:buffer
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $buffer)
   )
  )
  (call $~lib/array/Array<~lib/array/Array<i32>>#set:dataStart
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $buffer)
  )
  (call $~lib/array/Array<~lib/array/Array<i32>>#set:byteLength
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $bufferSize)
  )
  (call $~lib/array/Array<~lib/array/Array<i32>>#set:length_
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $length)
  )
  (local.get $this)
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
 (func $~lib/array/Array<~lib/array/Array<i32>>#get:length_ (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#get:dataStart (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#push (param $this i32) (param $value i32) (result i32)
  (local $oldLen i32)
  (local $len i32)
  (local.set $oldLen
   (call $~lib/array/Array<~lib/array/Array<i32>>#get:length_
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
   (i32.const 1)
  )
  (block
   (i32.store
    (i32.add
     (call $~lib/array/Array<~lib/array/Array<i32>>#get:dataStart
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
   (call $~lib/rt/itcms/__link
    (local.get $this)
    (local.get $value)
    (i32.const 1)
   )
  )
  (call $~lib/array/Array<~lib/array/Array<i32>>#set:length_
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $len)
  )
  (return
   (local.get $len)
  )
 )
 (func $~lib/readonlyarray/ReadonlyArray<~lib/array/Array<i32>>#flat (param $this i32) (result i32)
  (unreachable)
 )
 (func $start:std/readonlyarray
  (local $0 i32)
  (local $1 i32)
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
    (i32.const 240)
   )
  )
  (global.set $~lib/rt/itcms/toSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 272)
   )
  )
  (global.set $~lib/rt/itcms/fromSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 416)
   )
  )
  (global.set $std/readonlyarray/source
   (call $~lib/array/Array<i32>#constructor
    (call $~lib/rt/__tmptostack
     (call $~lib/rt/itcms/__new
      (i32.const 16)
      (i32.const 4)
     )
    )
    (i32.const 0)
   )
  )
  (drop
   (call $~lib/array/Array<i32>#push
    (call $~lib/rt/__tmptostack
     (global.get $std/readonlyarray/source)
    )
    (i32.const 1)
   )
  )
  (drop
   (call $~lib/array/Array<i32>#push
    (call $~lib/rt/__tmptostack
     (global.get $std/readonlyarray/source)
    )
    (i32.const 2)
   )
  )
  (drop
   (call $~lib/array/Array<i32>#push
    (call $~lib/rt/__tmptostack
     (global.get $std/readonlyarray/source)
    )
    (i32.const 3)
   )
  )
  (drop
   (call $~lib/array/Array<i32>#push
    (call $~lib/rt/__tmptostack
     (global.get $std/readonlyarray/source)
    )
    (i32.const 2)
   )
  )
  (global.set $std/readonlyarray/values
   (global.get $std/readonlyarray/source)
  )
  (block
   (call $~lib/rt/closure/setClosureEnv
    (i32.const 0)
   )
   (call $std/readonlyarray/checkReadonlyArray
    (call $~lib/rt/__tmptostack
     (global.get $std/readonlyarray/values)
    )
   )
  )
  (global.set $std/readonlyarray/nestedSource
   (call $~lib/array/Array<~lib/array/Array<i32>>#constructor
    (call $~lib/rt/__tmptostack
     (call $~lib/rt/itcms/__new
      (i32.const 16)
      (i32.const 9)
     )
    )
    (i32.const 0)
   )
  )
  (drop
   (call $~lib/array/Array<~lib/array/Array<i32>>#push
    (call $~lib/rt/__tmptostack
     (global.get $std/readonlyarray/nestedSource)
    )
    (call $~lib/rt/__tmptostack
     (call $~lib/rt/__newArray
      (i32.const 2)
      (i32.const 2)
      (i32.const 4)
      (i32.const 944)
     )
    )
   )
  )
  (drop
   (call $~lib/array/Array<~lib/array/Array<i32>>#push
    (call $~lib/rt/__tmptostack
     (global.get $std/readonlyarray/nestedSource)
    )
    (call $~lib/rt/__tmptostack
     (call $~lib/rt/__newArray
      (i32.const 2)
      (i32.const 2)
      (i32.const 4)
      (i32.const 976)
     )
    )
   )
  )
  (global.set $std/readonlyarray/nested
   (global.get $std/readonlyarray/nestedSource)
  )
  (global.set $std/readonlyarray/flattened
   (call $~lib/readonlyarray/ReadonlyArray<~lib/array/Array<i32>>#flat@override
    (call $~lib/rt/__tmptostack
     (global.get $std/readonlyarray/nested)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#get:length
      (call $~lib/rt/__tmptostack
       (global.get $std/readonlyarray/flattened)
      )
     )
     (i32.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 69)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/readonlyarray/flattened)
      )
      (i32.const 0)
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 70)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/array/Array<i32>#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/readonlyarray/flattened)
      )
      (i32.const 3)
     )
     (i32.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 528)
     (i32.const 71)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~lib/array/Array<i32>#at (param $this i32) (param $index i32) (result i32)
  (local $len i32)
  (local $value i32)
  (local.set $len
   (call $~lib/array/Array<i32>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $index
   (i32.add
    (local.get $index)
    (select
     (i32.const 0)
     (local.get $len)
     (i32.ge_s
      (local.get $index)
      (i32.const 0)
     )
    )
   )
  )
  (if
   (i32.ge_u
    (local.get $index)
    (local.get $len)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 320)
     (i32.const 80)
     (i32.const 155)
     (i32.const 33)
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
 (func $~lib/array/Array<i32>#findIndex (param $this i32) (param $fn i32) (result i32)
  (local $i i32)
  (local $len i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/array/Array<i32>#get:length_
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
     (select
      (local.tee $4
       (local.get $len)
      )
      (local.tee $5
       (call $~lib/array/Array<i32>#get:length_
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
      )
      (i32.lt_s
       (local.get $4)
       (local.get $5)
      )
     )
    )
    (then
     (if
      (block (result i32)
       (local.set $6
        (local.get $fn)
       )
       (call_indirect (type $3)
        (i32.load
         (i32.add
          (call $~lib/array/Array<i32>#get:dataStart
           (call $~lib/rt/__tmptostack
            (local.get $this)
           )
          )
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
        (block (result i32)
         (call $~lib/rt/closure/setClosureEnv
          (i32.load offset=4
           (local.get $6)
          )
         )
         (global.set $~argumentsLength
          (i32.const 3)
         )
         (i32.load
          (local.get $6)
         )
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
 (func $~lib/array/Array<i32>#findLastIndex (param $this i32) (param $fn i32) (result i32)
  (local $i i32)
  (local $3 i32)
  (local.set $i
   (i32.sub
    (call $~lib/array/Array<i32>#get:length_
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
      (block (result i32)
       (local.set $3
        (local.get $fn)
       )
       (call_indirect (type $3)
        (i32.load
         (i32.add
          (call $~lib/array/Array<i32>#get:dataStart
           (call $~lib/rt/__tmptostack
            (local.get $this)
           )
          )
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
        (block (result i32)
         (call $~lib/rt/closure/setClosureEnv
          (i32.load offset=4
           (local.get $3)
          )
         )
         (global.set $~argumentsLength
          (i32.const 3)
         )
         (i32.load
          (local.get $3)
         )
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
 (func $~lib/array/Array<i32>#indexOf (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (local $len i32)
  (local $4 i32)
  (local $5 i32)
  (local $ptr i32)
  (local.set $len
   (call $~lib/array/Array<i32>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (if
   (if (result i32)
    (i32.eq
     (local.get $len)
     (i32.const 0)
    )
    (then
     (i32.const 1)
    )
    (else
     (i32.ge_s
      (local.get $fromIndex)
      (local.get $len)
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
        (local.get $len)
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
  (local.set $ptr
   (call $~lib/array/Array<i32>#get:dataStart
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.lt_s
      (local.get $fromIndex)
      (local.get $len)
     )
     (then
      (if
       (i32.eq
        (i32.load
         (i32.add
          (local.get $ptr)
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
 (func $~lib/array/Array<i32>#includes (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (drop
   (i32.const 0)
  )
  (return
   (i32.ge_s
    (call $~lib/array/Array<i32>#indexOf
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (local.get $value)
     (local.get $fromIndex)
    )
    (i32.const 0)
   )
  )
 )
 (func $~lib/array/Array<i32>#lastIndexOf (param $this i32) (param $value i32) (param $fromIndex i32) (result i32)
  (local $len i32)
  (local $ptr i32)
  (local.set $len
   (call $~lib/array/Array<i32>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (if
   (i32.eq
    (local.get $len)
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
      (local.get $len)
      (local.get $fromIndex)
     )
    )
   )
   (else
    (if
     (i32.ge_s
      (local.get $fromIndex)
      (local.get $len)
     )
     (then
      (local.set $fromIndex
       (i32.sub
        (local.get $len)
        (i32.const 1)
       )
      )
     )
    )
   )
  )
  (local.set $ptr
   (call $~lib/array/Array<i32>#get:dataStart
    (call $~lib/rt/__tmptostack
     (local.get $this)
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
          (local.get $ptr)
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
 (func $~lib/array/Array<i32>#forEach (param $this i32) (param $fn i32)
  (local $i i32)
  (local $len i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/array/Array<i32>#get:length_
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
     (select
      (local.tee $4
       (local.get $len)
      )
      (local.tee $5
       (call $~lib/array/Array<i32>#get:length_
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
      )
      (i32.lt_s
       (local.get $4)
       (local.get $5)
      )
     )
    )
    (then
     (local.set $6
      (local.get $fn)
     )
     (call_indirect (type $4)
      (i32.load
       (i32.add
        (call $~lib/array/Array<i32>#get:dataStart
         (call $~lib/rt/__tmptostack
          (local.get $this)
         )
        )
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
      (block (result i32)
       (call $~lib/rt/closure/setClosureEnv
        (i32.load offset=4
         (local.get $6)
        )
       )
       (global.set $~argumentsLength
        (i32.const 3)
       )
       (i32.load
        (local.get $6)
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
 (func $~lib/array/Array<i32>#every (param $this i32) (param $fn i32) (result i32)
  (local $i i32)
  (local $len i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/array/Array<i32>#get:length_
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
     (select
      (local.tee $4
       (local.get $len)
      )
      (local.tee $5
       (call $~lib/array/Array<i32>#get:length_
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
      )
      (i32.lt_s
       (local.get $4)
       (local.get $5)
      )
     )
    )
    (then
     (if
      (i32.eqz
       (block (result i32)
        (local.set $6
         (local.get $fn)
        )
        (call_indirect (type $3)
         (i32.load
          (i32.add
           (call $~lib/array/Array<i32>#get:dataStart
            (call $~lib/rt/__tmptostack
             (local.get $this)
            )
           )
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
         (block (result i32)
          (call $~lib/rt/closure/setClosureEnv
           (i32.load offset=4
            (local.get $6)
           )
          )
          (global.set $~argumentsLength
           (i32.const 3)
          )
          (i32.load
           (local.get $6)
          )
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
 (func $~lib/array/Array<i32>#some (param $this i32) (param $fn i32) (result i32)
  (local $i i32)
  (local $len i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/array/Array<i32>#get:length_
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
     (select
      (local.tee $4
       (local.get $len)
      )
      (local.tee $5
       (call $~lib/array/Array<i32>#get:length_
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
      )
      (i32.lt_s
       (local.get $4)
       (local.get $5)
      )
     )
    )
    (then
     (if
      (block (result i32)
       (local.set $6
        (local.get $fn)
       )
       (call_indirect (type $3)
        (i32.load
         (i32.add
          (call $~lib/array/Array<i32>#get:dataStart
           (call $~lib/rt/__tmptostack
            (local.get $this)
           )
          )
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
        (block (result i32)
         (call $~lib/rt/closure/setClosureEnv
          (i32.load offset=4
           (local.get $6)
          )
         )
         (global.set $~argumentsLength
          (i32.const 3)
         )
         (i32.load
          (local.get $6)
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
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool>#get:index (param $this i32) (result i32)
  (return
   (i32.load
    (local.get $this)
   )
  )
 )
 (func $~lib/array/Array<i32>#filterImpl (param $this i32) (param $fnIndex i32) (result i32)
  (local $result i32)
  (local $i i32)
  (local $len i32)
  (local $5 i32)
  (local $6 i32)
  (local $value i32)
  (local.set $result
   (call $~lib/rt/__localtostack
    (call $~lib/rt/__newArray
     (i32.const 0)
     (i32.const 2)
     (i32.const 4)
     (i32.const 0)
    )
   )
  )
  (block
   (local.set $i
    (i32.const 0)
   )
   (local.set $len
    (call $~lib/array/Array<i32>#get:length_
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
     (select
      (local.tee $5
       (local.get $len)
      )
      (local.tee $6
       (call $~lib/array/Array<i32>#get:length_
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
      )
      (i32.lt_s
       (local.get $5)
       (local.get $6)
      )
     )
    )
    (then
     (local.set $value
      (i32.load
       (i32.add
        (call $~lib/array/Array<i32>#get:dataStart
         (call $~lib/rt/__tmptostack
          (local.get $this)
         )
        )
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
       (local.get $fnIndex)
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
 (func $~lib/array/Array<i32>#filter (param $this i32) (param $fn i32) (result i32)
  (return
   (call $~lib/array/Array<i32>#filterImpl
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (call $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool>#get:index
     (call $~lib/rt/__tmptostack
      (local.get $fn)
     )
    )
   )
  )
 )
 (func $~lib/array/Array<i32>#slice (param $this i32) (param $start i32) (param $end i32) (result i32)
  (local $len i32)
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
  (local $slice i32)
  (local $sliceBase i32)
  (local $thisBase i32)
  (local.set $len
   (call $~lib/array/Array<i32>#get:length_
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
        (local.get $len)
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
       (local.get $len)
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
        (local.get $len)
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
  (local.set $len
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
  (local.set $slice
   (call $~lib/rt/__localtostack
    (call $~lib/rt/__newArray
     (local.get $len)
     (i32.const 2)
     (i32.const 4)
     (i32.const 0)
    )
   )
  )
  (local.set $sliceBase
   (call $~lib/array/Array<i32>#get:dataStart
    (call $~lib/rt/__tmptostack
     (local.get $slice)
    )
   )
  )
  (local.set $thisBase
   (i32.add
    (call $~lib/array/Array<i32>#get:dataStart
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.shl
     (local.get $start)
     (i32.const 2)
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (memory.copy
   (local.get $sliceBase)
   (local.get $thisBase)
   (i32.shl
    (local.get $len)
    (i32.const 2)
   )
  )
  (return
   (local.get $slice)
  )
 )
 (func $~lib/array/Array<i32>#concat (param $this i32) (param $other i32) (result i32)
  (local $thisLen i32)
  (local $otherLen i32)
  (local $outLen i32)
  (local $out i32)
  (local $outStart i32)
  (local $thisSize i32)
  (local.set $thisLen
   (call $~lib/array/Array<i32>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $otherLen
   (call $~lib/array/Array<i32>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $other)
    )
   )
  )
  (local.set $outLen
   (i32.add
    (local.get $thisLen)
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
     (i32.const 32)
     (i32.const 80)
     (i32.const 236)
     (i32.const 62)
    )
    (unreachable)
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (call $~lib/rt/__newArray
     (local.get $outLen)
     (i32.const 2)
     (i32.const 4)
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
  (local.set $thisSize
   (i32.shl
    (local.get $thisLen)
    (i32.const 2)
   )
  )
  (drop
   (i32.const 0)
  )
  (block
   (memory.copy
    (local.get $outStart)
    (call $~lib/array/Array<i32>#get:dataStart
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (local.get $thisSize)
   )
   (memory.copy
    (i32.add
     (local.get $outStart)
     (local.get $thisSize)
    )
    (call $~lib/array/Array<i32>#get:dataStart
     (call $~lib/rt/__tmptostack
      (local.get $other)
     )
    )
    (i32.shl
     (local.get $otherLen)
     (i32.const 2)
    )
   )
  )
  (return
   (local.get $out)
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
         (i32.const 1244)
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
         (i32.const 1244)
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
       (i32.const 1244)
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
       (i32.const 1244)
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
 (func $~lib/util/number/utoa32_dec_core (param $buffer i32) (param $num i32) (param $offset i32)
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
         (i32.const 1664)
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
       (i32.const 1664)
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
 (func $~lib/util/number/utoa32_hex_core (param $buffer i32) (param $num i32) (param $offset i32)
  (drop
   (i32.ge_s
    (i32.const 0)
    (i32.const 1)
   )
  )
  (call $~lib/util/number/utoa_hex_lut
   (local.get $buffer)
   (i64.extend_i32_u
    (local.get $num)
   )
   (local.get $offset)
  )
 )
 (func $~lib/util/number/isPowerOf2<i32> (param $value i32) (result i32)
  (return
   (i32.eq
    (i32.popcnt
     (local.get $value)
    )
    (i32.const 1)
   )
  )
 )
 (func $~lib/util/number/ulog_base (param $num i64) (param $base i32) (result i32)
  (local $b64 i64)
  (local $b i64)
  (local $e i32)
  (if
   (call $~lib/util/number/isPowerOf2<i32>
    (local.get $base)
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
        (i32.const 2720)
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
        (i32.const 2720)
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
  (local $decimals|5 i32)
  (local $val32 i32)
  (local $decimals|7 i32)
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
     (i32.const 1040)
     (i32.const 1168)
     (i32.const 349)
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
     (i32.const 1232)
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
    (call $~lib/util/number/utoa32_dec_core
     (i32.add
      (local.get $out)
      (local.get $sign)
     )
     (local.get $value)
     (local.get $decimals)
    )
   )
   (else
    (if
     (i32.eq
      (local.get $radix)
      (i32.const 16)
     )
     (then
      (local.set $decimals|5
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
           (local.get $decimals|5)
           (i32.const 1)
          )
          (local.get $sign)
         )
         (i32.const 2)
        )
       )
      )
      (call $~lib/util/number/utoa32_hex_core
       (i32.add
        (local.get $out)
        (local.get $sign)
       )
       (local.get $value)
       (local.get $decimals|5)
      )
     )
     (else
      (local.set $val32
       (local.get $value)
      )
      (local.set $decimals|7
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
           (local.get $decimals|7)
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
       (local.get $decimals|7)
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
 (func $~lib/util/number/itoa_buffered<i32> (param $buffer i32) (param $value i32) (result i32)
  (local $sign i32)
  (local $dest i32)
  (local $decimals i32)
  (local $val32 i32)
  (local.set $sign
   (i32.const 0)
  )
  (drop
   (i32.const 1)
  )
  (block
   (local.set $sign
    (i32.lt_s
     (local.get $value)
     (i32.const 0)
    )
   )
   (if
    (local.get $sign)
    (then
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
     (i32.store16
      (local.get $buffer)
      (i32.const 45)
     )
     (local.set $value
      (i32.sub
       (i32.const 0)
       (local.get $value)
      )
     )
    )
   )
  )
  (local.set $dest
   (i32.add
    (local.get $buffer)
    (i32.shl
     (local.get $sign)
     (i32.const 1)
    )
   )
  )
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
   (block
    (drop
     (i32.le_u
      (i32.const 4)
      (i32.const 4)
     )
    )
    (if
     (i32.lt_u
      (local.get $value)
      (i32.const 10)
     )
     (then
      (i32.store16
       (local.get $dest)
       (i32.or
        (local.get $value)
        (i32.const 48)
       )
      )
      (return
       (i32.add
        (i32.const 1)
        (local.get $sign)
       )
      )
     )
    )
   )
  )
  (local.set $decimals
   (i32.const 0)
  )
  (drop
   (i32.le_u
    (i32.const 4)
    (i32.const 4)
   )
  )
  (block
   (local.set $val32
    (local.get $value)
   )
   (local.set $decimals
    (call $~lib/util/number/decimalCount32
     (local.get $val32)
    )
   )
   (call $~lib/util/number/utoa32_dec_core
    (local.get $dest)
    (local.get $val32)
    (local.get $decimals)
   )
  )
  (return
   (i32.add
    (local.get $sign)
    (local.get $decimals)
   )
  )
 )
 (func $~lib/string/String#substring (param $this i32) (param $start i32) (param $end i32) (result i32)
  (local $len i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $finalStart i32)
  (local $9 i32)
  (local $10 i32)
  (local $11 i32)
  (local $12 i32)
  (local $finalEnd i32)
  (local $14 i32)
  (local $15 i32)
  (local $fromPos i32)
  (local $17 i32)
  (local $18 i32)
  (local $toPos i32)
  (local $size i32)
  (local $out i32)
  (local.set $len
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $finalStart
   (select
    (local.tee $6
     (select
      (local.tee $4
       (local.get $start)
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
    (local.tee $7
     (local.get $len)
    )
    (i32.lt_s
     (local.get $6)
     (local.get $7)
    )
   )
  )
  (local.set $finalEnd
   (select
    (local.tee $11
     (select
      (local.tee $9
       (local.get $end)
      )
      (local.tee $10
       (i32.const 0)
      )
      (i32.gt_s
       (local.get $9)
       (local.get $10)
      )
     )
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
  (local.set $fromPos
   (i32.shl
    (select
     (local.tee $14
      (local.get $finalStart)
     )
     (local.tee $15
      (local.get $finalEnd)
     )
     (i32.lt_s
      (local.get $14)
      (local.get $15)
     )
    )
    (i32.const 1)
   )
  )
  (local.set $toPos
   (i32.shl
    (select
     (local.tee $17
      (local.get $finalStart)
     )
     (local.tee $18
      (local.get $finalEnd)
     )
     (i32.gt_s
      (local.get $17)
      (local.get $18)
     )
    )
    (i32.const 1)
   )
  )
  (local.set $size
   (i32.sub
    (local.get $toPos)
    (local.get $fromPos)
   )
  )
  (if
   (i32.eqz
    (local.get $size)
   )
   (then
    (return
     (i32.const 1008)
    )
   )
  )
  (if
   (if (result i32)
    (i32.eqz
     (local.get $fromPos)
    )
    (then
     (i32.eq
      (local.get $toPos)
      (i32.shl
       (local.get $len)
       (i32.const 1)
      )
     )
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (return
     (local.get $this)
    )
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (local.get $size)
     (i32.const 2)
    )
   )
  )
  (memory.copy
   (local.get $out)
   (i32.add
    (local.get $this)
    (local.get $fromPos)
   )
   (local.get $size)
  )
  (return
   (local.get $out)
  )
 )
 (func $~lib/util/string/joinIntegerArray<i32> (param $dataStart i32) (param $length i32) (param $separator i32) (result i32)
  (local $lastIndex i32)
  (local $value i32)
  (local $sepLen i32)
  (local $estLen i32)
  (local $result i32)
  (local $offset i32)
  (local $value|9 i32)
  (local $i i32)
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
     (i32.const 1008)
    )
   )
  )
  (if
   (i32.eqz
    (local.get $lastIndex)
   )
   (then
    (local.set $value
     (i32.load
      (local.get $dataStart)
     )
    )
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
     (return
      (call $~lib/util/number/itoa32
       (local.get $value)
       (i32.const 10)
      )
     )
    )
   )
  )
  (local.set $sepLen
   (call $~lib/string/String#get:length
    (call $~lib/rt/__tmptostack
     (local.get $separator)
    )
   )
  )
  (local.set $estLen
   (i32.add
    (i32.mul
     (i32.add
      (i32.const 11)
      (local.get $sepLen)
     )
     (local.get $lastIndex)
    )
    (i32.const 11)
   )
  )
  (local.set $result
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (i32.shl
      (local.get $estLen)
      (i32.const 1)
     )
     (i32.const 2)
    )
   )
  )
  (local.set $offset
   (i32.const 0)
  )
  (local.set $i
   (i32.const 0)
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $lastIndex)
    )
    (then
     (local.set $value|9
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
     (local.set $offset
      (i32.add
       (local.get $offset)
       (call $~lib/util/number/itoa_buffered<i32>
        (i32.add
         (local.get $result)
         (i32.shl
          (local.get $offset)
          (i32.const 1)
         )
        )
        (local.get $value|9)
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
  (local.set $value|9
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
  (local.set $offset
   (i32.add
    (local.get $offset)
    (call $~lib/util/number/itoa_buffered<i32>
     (i32.add
      (local.get $result)
      (i32.shl
       (local.get $offset)
       (i32.const 1)
      )
     )
     (local.get $value|9)
    )
   )
  )
  (if
   (i32.gt_s
    (local.get $estLen)
    (local.get $offset)
   )
   (then
    (return
     (call $~lib/string/String#substring
      (call $~lib/rt/__tmptostack
       (local.get $result)
      )
      (i32.const 0)
      (local.get $offset)
     )
    )
   )
  )
  (return
   (local.get $result)
  )
 )
 (func $~lib/array/Array<i32>#join (param $this i32) (param $separator i32) (result i32)
  (local $ptr i32)
  (local $len i32)
  (local.set $ptr
   (call $~lib/array/Array<i32>#get:dataStart
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $len
   (call $~lib/array/Array<i32>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (drop
   (i32.const 1)
  )
  (return
   (call $~lib/util/string/joinIntegerArray<i32>
    (local.get $ptr)
    (local.get $len)
    (call $~lib/rt/__tmptostack
     (local.get $separator)
    )
   )
  )
 )
 (func $~lib/array/Array<i32>#toString (param $this i32) (result i32)
  (return
   (call $~lib/array/Array<i32>#join
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (i32.const 2816)
   )
  )
 )
 (func $~lib/array/ArrayIterator<i32>#set:array (param $this i32) (param $array i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $array)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $array)
   (i32.const 0)
  )
 )
 (func $~lib/array/ArrayIterator<i32>#constructor (param $this i32) (param $array i32) (result i32)
  (call $~lib/array/ArrayIterator<i32>#set:array
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $array)
   )
  )
  (local.get $this)
 )
 (func $"~lib/array/Array<i32>#[~lib/symbol/Symbol.iterator]" (param $this i32) (result i32)
  (return
   (call $~lib/array/ArrayIterator<i32>#constructor
    (call $~lib/rt/__tmptostack
     (call $~lib/rt/itcms/__new
      (i32.const 8)
      (i32.const 11)
     )
    )
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $~lib/array/ArrayIterator<i32>#get:current (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/array/ArrayIterator<i32>#set:current (param $this i32) (param $current i32)
  (i32.store
   (local.get $this)
   (local.get $current)
  )
 )
 (func $~lib/array/ArrayIterator<i32>#get:array (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/iterator/IteratorResult.done<i32> (result i32)
  (return
   (i32.const 0)
  )
 )
 (func $~lib/array/Array<i32>#__uget (param $this i32) (param $index i32) (result i32)
  (return
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
 )
 (func $~lib/iterator/IteratorResult<i32>#set:value (param $this i32) (param $value i32)
  (i32.store
   (local.get $this)
   (local.get $value)
  )
 )
 (func $~lib/iterator/IteratorResult<i32>#constructor (param $this i32) (param $value i32) (result i32)
  (call $~lib/iterator/IteratorResult<i32>#set:value
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $value)
  )
  (local.get $this)
 )
 (func $~lib/iterator/IteratorResult.fromValue<i32> (param $value i32) (result i32)
  (return
   (call $~lib/iterator/IteratorResult<i32>#constructor
    (call $~lib/rt/__tmptostack
     (call $~lib/rt/itcms/__new
      (i32.const 4)
      (i32.const 8)
     )
    )
    (local.get $value)
   )
  )
 )
 (func $~lib/array/ArrayIterator<i32>#next (param $this i32) (result i32)
  (local $current i32)
  (local.set $current
   (call $~lib/array/ArrayIterator<i32>#get:current
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (call $~lib/array/ArrayIterator<i32>#set:current
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.add
    (call $~lib/array/ArrayIterator<i32>#get:current
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (if
   (i32.ge_s
    (local.get $current)
    (call $~lib/array/Array<i32>#get:length
     (call $~lib/rt/__tmptostack
      (call $~lib/array/ArrayIterator<i32>#get:array
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
     )
    )
   )
   (then
    (return
     (call $~lib/iterator/IteratorResult.done<i32>)
    )
   )
  )
  (return
   (call $~lib/iterator/IteratorResult.fromValue<i32>
    (call $~lib/array/Array<i32>#__uget
     (call $~lib/rt/__tmptostack
      (call $~lib/array/ArrayIterator<i32>#get:array
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
     )
     (local.get $current)
    )
   )
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#flat (param $this i32) (result i32)
  (local $ptr i32)
  (local $len i32)
  (local $size i32)
  (local $i i32)
  (local $child i32)
  (local $byteLength i32)
  (local $outBuffer i32)
  (local $outArray i32)
  (local $resultOffset i32)
  (local $i|10 i32)
  (local $child|11 i32)
  (local $childDataLength i32)
  (drop
   (i32.eqz
    (i32.const 1)
   )
  )
  (local.set $ptr
   (call $~lib/array/Array<~lib/array/Array<i32>>#get:dataStart
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $len
   (call $~lib/array/Array<~lib/array/Array<i32>>#get:length_
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $size
   (i32.const 0)
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
     (local.set $child
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
     (local.set $size
      (i32.add
       (local.get $size)
       (if (result i32)
        (i32.eq
         (local.get $child)
         (i32.const 0)
        )
        (then
         (i32.const 0)
        )
        (else
         (i32.load offset=12
          (local.get $child)
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
  (local.set $byteLength
   (i32.shl
    (local.get $size)
    (i32.const 2)
   )
  )
  (local.set $outBuffer
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (local.get $byteLength)
     (i32.const 1)
    )
   )
  )
  (local.set $outArray
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (i32.const 16)
     (i32.const 4)
    )
   )
  )
  (i32.store offset=12
   (local.get $outArray)
   (local.get $size)
  )
  (i32.store offset=8
   (local.get $outArray)
   (local.get $byteLength)
  )
  (i32.store offset=4
   (local.get $outArray)
   (local.get $outBuffer)
  )
  (i32.store
   (local.get $outArray)
   (local.get $outBuffer)
  )
  (call $~lib/rt/itcms/__link
   (local.get $outArray)
   (local.get $outBuffer)
   (i32.const 0)
  )
  (local.set $resultOffset
   (i32.const 0)
  )
  (local.set $i|10
   (i32.const 0)
  )
  (loop $for-loop|1
   (if
    (i32.lt_s
     (local.get $i|10)
     (local.get $len)
    )
    (then
     (block $for-continue|1
      (local.set $child|11
       (i32.load
        (i32.add
         (local.get $ptr)
         (i32.shl
          (local.get $i|10)
          (i32.const 2)
         )
        )
       )
      )
      (if
       (i32.eqz
        (local.get $child|11)
       )
       (then
        (br $for-continue|1)
       )
      )
      (local.set $childDataLength
       (i32.shl
        (i32.load offset=12
         (local.get $child|11)
        )
        (i32.const 2)
       )
      )
      (memory.copy
       (i32.add
        (local.get $outBuffer)
        (local.get $resultOffset)
       )
       (i32.load offset=4
        (local.get $child|11)
       )
       (local.get $childDataLength)
      )
      (local.set $resultOffset
       (i32.add
        (local.get $resultOffset)
        (local.get $childDataLength)
       )
      )
     )
     (local.set $i|10
      (i32.add
       (local.get $i|10)
       (i32.const 1)
      )
     )
     (br $for-loop|1)
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (return
   (local.get $outArray)
  )
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#get:length@override (param $0 i32) (result i32)
  (local $1 i32)
  (block $default
   (block $case0
    (local.set $1
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $1)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#get:length
     (local.get $0)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#__get@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#__get
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#at@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#at
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#findIndex@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#findIndex
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#findLastIndex@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#findLastIndex
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#includes@override (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (block $default
   (block $case0
    (local.set $3
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $3)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#includes
     (local.get $0)
     (local.get $1)
     (local.get $2)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#indexOf@override (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (block $default
   (block $case0
    (local.set $3
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $3)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#indexOf
     (local.get $0)
     (local.get $1)
     (local.get $2)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#lastIndexOf@override (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (block $default
   (block $case0
    (local.set $3
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $3)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#lastIndexOf
     (local.get $0)
     (local.get $1)
     (local.get $2)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#forEach@override (param $0 i32) (param $1 i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (call $~lib/array/Array<i32>#forEach
    (local.get $0)
    (local.get $1)
   )
   (return)
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#every@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#every
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#some@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#some
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#filter@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#filter
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#slice@override (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (block $default
   (block $case0
    (local.set $3
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $3)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#slice
     (local.get $0)
     (local.get $1)
     (local.get $2)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#concat@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#concat
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#join@override (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (block $default
   (block $case0
    (local.set $2
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $2)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#join
     (local.get $0)
     (local.get $1)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<i32>#toString@override (param $0 i32) (result i32)
  (local $1 i32)
  (block $default
   (block $case0
    (local.set $1
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $1)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<i32>#toString
     (local.get $0)
    )
   )
  )
  (unreachable)
 )
 (func $"~lib/iterator/Iterable<i32>#[~lib/symbol/Symbol.iterator]@override" (param $0 i32) (result i32)
  (local $1 i32)
  (block $default
   (block $case0
    (local.set $1
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $1)
      (i32.const 4)
     )
    )
    (br $default)
   )
   (return
    (call $"~lib/array/Array<i32>#[~lib/symbol/Symbol.iterator]"
     (local.get $0)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/iterator/Iterator<i32>#next@override (param $0 i32) (result i32)
  (local $1 i32)
  (block $default
   (block $case0
    (local.set $1
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $1)
      (i32.const 11)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/ArrayIterator<i32>#next
     (local.get $0)
    )
   )
  )
  (unreachable)
 )
 (func $~lib/readonlyarray/ReadonlyArray<~lib/array/Array<i32>>#flat@override (param $0 i32) (result i32)
  (local $1 i32)
  (block $default
   (block $case0
    (local.set $1
     (i32.load
      (i32.sub
       (local.get $0)
       (i32.const 8)
      )
     )
    )
    (br_if $case0
     (i32.eq
      (local.get $1)
      (i32.const 9)
     )
    )
    (br $default)
   )
   (return
    (call $~lib/array/Array<~lib/array/Array<i32>>#flat
     (local.get $0)
    )
   )
  )
  (unreachable)
 )
 (func $~instanceof|~lib/array/Array<i32> (param $0 i32) (result i32)
  (local $1 i32)
  (block $is_instance
   (local.set $1
    (i32.load
     (i32.sub
      (local.get $0)
      (i32.const 8)
     )
    )
   )
   (br_if $is_instance
    (i32.eq
     (local.get $1)
     (i32.const 4)
    )
   )
   (return
    (i32.const 0)
   )
  )
  (i32.const 1)
 )
 (func $~lib/rt/__visit_globals (param $0 i32)
  (local $1 i32)
  (if
   (local.tee $1
    (global.get $std/readonlyarray/source)
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
    (global.get $std/readonlyarray/values)
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
    (global.get $std/readonlyarray/nestedSource)
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
    (global.get $std/readonlyarray/nested)
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
    (global.get $std/readonlyarray/flattened)
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
    (global.get $~lib/rt/closure/env)
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
 (func $~lib/tuple/SmallTuple#__visit (param $this i32) (param $cookie i32)
  (local $rtSize i32)
  (local $remaining i64)
  (local $index i32)
  (local $elementPtr i32)
  (local.set $rtSize
   (call $~lib/rt/common/OBJECT#get:rtSize
    (i32.sub
     (local.get $this)
     (i32.const 20)
    )
   )
  )
  (local.set $remaining
   (i64.load
    (i32.sub
     (i32.add
      (local.get $this)
      (local.get $rtSize)
     )
     (i32.const 8)
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i64.ne
      (local.get $remaining)
      (i64.const 0)
     )
     (then
      (local.set $index
       (i32.wrap_i64
        (i64.ctz
         (local.get $remaining)
        )
       )
      )
      (local.set $elementPtr
       (i32.add
        (local.get $this)
        (i32.shl
         (local.get $index)
         (i32.const 2)
        )
       )
      )
      (call $~lib/rt/itcms/__visit
       (i32.load
        (local.get $elementPtr)
       )
       (local.get $cookie)
      )
      (local.set $remaining
       (i64.and
        (local.get $remaining)
        (i64.sub
         (local.get $remaining)
         (i64.const 1)
        )
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
 )
 (func $~lib/tuple/SmallTuple~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/tuple/SmallTuple#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>bool>#get:_env (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>bool>#__visit (param $this i32) (param $cookie i32)
  (call $~lib/rt/itcms/__visit
   (call $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>bool>#get:_env
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>bool>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>bool>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>void>#get:_env (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>void>#__visit (param $this i32) (param $cookie i32)
  (call $~lib/rt/itcms/__visit
   (call $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>void>#get:_env
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>void>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>void>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#get:buffer (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>#__visit (param $this i32) (param $cookie i32)
  (local $cur i32)
  (local $end i32)
  (local $val i32)
  (drop
   (i32.const 1)
  )
  (block
   (local.set $cur
    (call $~lib/array/Array<~lib/array/Array<i32>>#get:dataStart
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
   (local.set $end
    (i32.add
     (local.get $cur)
     (i32.shl
      (call $~lib/array/Array<~lib/array/Array<i32>>#get:length_
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
   (call $~lib/array/Array<~lib/array/Array<i32>>#get:buffer
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/array/Array<~lib/array/Array<i32>>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/array/Array<~lib/array/Array<i32>>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool>#get:_env (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool>#__visit (param $this i32) (param $cookie i32)
  (call $~lib/rt/itcms/__visit
   (call $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool>#get:_env
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
 )
 (func $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/array/ArrayIterator<i32>~visit (param $0 i32) (param $1 i32)
  (local $2 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/rt/itcms/__visit
   (i32.load offset=4
    (local.get $0)
   )
   (local.get $1)
  )
 )
 (func $~lib/rt/__visit_members (param $0 i32) (param $1 i32)
  (block $invalid
   (block $~lib/array/ArrayIterator<i32>
    (block $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool>
     (block $~lib/array/Array<~lib/array/Array<i32>>
      (block $~lib/iterator/IteratorResult<i32>
       (block $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>void>
        (block $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>bool>
         (block $~lib/tuple/SmallTuple
          (block $~lib/array/Array<i32>
           (block $~lib/arraybuffer/ArrayBufferView
            (block $~lib/string/String
             (block $~lib/arraybuffer/ArrayBuffer
              (block $~lib/object/Object
               (br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $~lib/array/Array<i32> $~lib/tuple/SmallTuple $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>bool> $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>void> $~lib/iterator/IteratorResult<i32> $~lib/array/Array<~lib/array/Array<i32>> $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool> $~lib/array/ArrayIterator<i32> $invalid
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
          (block
           (call $~lib/array/Array<i32>~visit
            (local.get $0)
            (local.get $1)
           )
           (return)
          )
         )
         (block
          (call $~lib/tuple/SmallTuple~visit
           (local.get $0)
           (local.get $1)
          )
          (return)
         )
        )
        (block
         (call $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>bool>~visit
          (local.get $0)
          (local.get $1)
         )
         (return)
        )
       )
       (block
        (call $~lib/function/Function<%28i32%2Ci32%2C~lib/readonlyarray/ReadonlyArray<i32>%29=>void>~visit
         (local.get $0)
         (local.get $1)
        )
        (return)
       )
      )
      (return)
     )
     (block
      (call $~lib/array/Array<~lib/array/Array<i32>>~visit
       (local.get $0)
       (local.get $1)
      )
      (return)
     )
    )
    (block
     (call $~lib/function/Function<%28i32%2Ci32%2C~lib/array/Array<i32>%29=>bool>~visit
      (local.get $0)
      (local.get $1)
     )
     (return)
    )
   )
   (block
    (call $~lib/array/ArrayIterator<i32>~visit
     (local.get $0)
     (local.get $1)
    )
    (return)
   )
  )
  (unreachable)
 )
 (func $~start
  (call $start:std/readonlyarray)
 )
)
