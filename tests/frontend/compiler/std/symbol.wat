(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (type $3 (func (param i32)))
 (type $4 (func))
 (type $5 (func (param i32 i32 i32) (result i32)))
 (type $6 (func (param i32 i32 i32)))
 (type $7 (func (param i32 i32 i32 i32)))
 (type $8 (func (param i32 i32 i64) (result i32)))
 (type $9 (func (result i32)))
 (type $10 (func (param i32 i32 i32 i32 i32) (result i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/symbol/nextId (mut i32) (i32.const 12))
 (global $std/symbol/sym1 (mut i32) (i32.const 0))
 (global $std/symbol/sym2 (mut i32) (i32.const 0))
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
 (global $~lib/native/ASC_RUNTIME i32 (i32.const 2))
 (global $~lib/symbol/stringToId (mut i32) (i32.const 0))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $~lib/symbol/idToString (mut i32) (i32.const 0))
 (global $std/symbol/sym3 (mut i32) (i32.const 0))
 (global $std/symbol/sym4 (mut i32) (i32.const 0))
 (global $std/symbol/key1 (mut i32) (i32.const 0))
 (global $std/symbol/key2 (mut i32) (i32.const 0))
 (global $std/symbol/key3 (mut i32) (i32.const 0))
 (global $std/symbol/key4 (mut i32) (i32.const 0))
 (global $~lib/symbol/_Symbol.hasInstance i32 (i32.const 1))
 (global $std/symbol/hasInstance (mut i32) (i32.const 0))
 (global $~lib/symbol/_Symbol.isConcatSpreadable i32 (i32.const 2))
 (global $std/symbol/isConcatSpreadable (mut i32) (i32.const 0))
 (global $~lib/rt/__rtti_base i32 (i32.const 1696))
 (global $~lib/memory/__data_end i32 (i32.const 1724))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 34492))
 (global $~lib/memory/__heap_base i32 (i32.const 34492))
 (global $~started (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\001\002\003\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1a\00\00\00s\00t\00d\00/\00s\00y\00m\00b\00o\00l\00.\00t\00s\00\00\00")
 (data $2 (i32.const 92) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $3 (i32.const 156) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 224) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 256) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 284) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $7 (i32.const 348) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 400) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 428) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $10 (i32.const 492) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00")
 (data $11 (i32.const 540) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s\00\00\00\00\00\00\00")
 (data $12 (i32.const 604) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00K\00e\00y\00 \00d\00o\00e\00s\00 \00n\00o\00t\00 \00e\00x\00i\00s\00t\00\00\00\00\00\00\00\00\00")
 (data $13 (i32.const 668) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00~\00l\00i\00b\00/\00m\00a\00p\00.\00t\00s\00\00\00\00\00\00\00")
 (data $14 (i32.const 716) "|\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00^\00\00\00U\00n\00e\00x\00p\00e\00c\00t\00e\00d\00 \00\'\00n\00u\00l\00l\00\'\00 \00(\00n\00o\00t\00 \00a\00s\00s\00i\00g\00n\00e\00d\00 \00o\00r\00 \00f\00a\00i\00l\00e\00d\00 \00c\00a\00s\00t\00)\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $15 (i32.const 844) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $16 (i32.const 876) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00h\00a\00s\00I\00n\00s\00t\00a\00n\00c\00e\00\00\00\00\00\00\00")
 (data $17 (i32.const 924) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00i\00s\00C\00o\00n\00c\00a\00t\00S\00p\00r\00e\00a\00d\00a\00b\00l\00e\00\00\00\00\00\00\00\00\00")
 (data $18 (i32.const 988) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00i\00s\00R\00e\00g\00E\00x\00p\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $19 (i32.const 1036) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00m\00a\00t\00c\00h\00\00\00")
 (data $20 (i32.const 1068) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00r\00e\00p\00l\00a\00c\00e\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $21 (i32.const 1116) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00s\00e\00a\00r\00c\00h\00")
 (data $22 (i32.const 1148) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00s\00p\00e\00c\00i\00e\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $23 (i32.const 1196) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00s\00p\00l\00i\00t\00\00\00")
 (data $24 (i32.const 1228) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00t\00o\00P\00r\00i\00m\00i\00t\00i\00v\00e\00\00\00\00\00\00\00")
 (data $25 (i32.const 1276) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00t\00o\00S\00t\00r\00i\00n\00g\00T\00a\00g\00\00\00\00\00\00\00")
 (data $26 (i32.const 1324) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00u\00n\00s\00c\00o\00p\00a\00b\00l\00e\00s\00\00\00\00\00\00\00")
 (data $27 (i32.const 1372) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00S\00y\00m\00b\00o\00l\00(\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $28 (i32.const 1420) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00)\00\00\00\00\00\00\00\00\00\00\00")
 (data $29 (i32.const 1452) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00S\00y\00m\00b\00o\00l\00(\00)\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $30 (i32.const 1500) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\16\00\00\00S\00y\00m\00b\00o\00l\00(\001\002\003\00)\00\00\00\00\00\00\00")
 (data $31 (i32.const 1548) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00S\00y\00m\00b\00o\00l\00(\00h\00a\00s\00I\00n\00s\00t\00a\00n\00c\00e\00)\00\00\00\00\00\00\00")
 (data $32 (i32.const 1612) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\004\00\00\00S\00y\00m\00b\00o\00l\00(\00i\00s\00C\00o\00n\00c\00a\00t\00S\00p\00r\00e\00a\00d\00a\00b\00l\00e\00)\00\00\00\00\00\00\00\00\00")
 (data $33 (i32.const 1696) "\06\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\10\01\82\00\10A\02\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (export "_start" (func $~start))
 (func $~lib/symbol/Symbol (param $description i32) (result i32)
  (local $1 i32)
  (local $id i32)
  (local.set $id
   (block (result i32)
    (global.set $~lib/symbol/nextId
     (i32.add
      (local.tee $1
       (global.get $~lib/symbol/nextId)
      )
      (i32.const 1)
     )
    )
    (local.get $1)
   )
  )
  (if
   (i32.eqz
    (local.get $id)
   )
   (then
    (unreachable)
   )
  )
  (return
   (local.get $id)
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
         (i32.const 176)
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
       (i32.const 176)
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
     (i32.const 176)
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
     (i32.const 304)
     (i32.const 368)
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
        (i32.const 176)
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
     (i32.const 448)
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
     (i32.const 448)
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
     (i32.const 448)
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
     (i32.const 448)
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
     (i32.const 448)
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
       (i32.const 448)
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
     (i32.const 448)
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
     (i32.const 448)
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
     (i32.const 448)
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
     (i32.const 448)
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
       (i32.const 448)
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
       (i32.const 448)
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
     (i32.const 448)
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
         (i32.const 176)
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
     (i32.const 112)
     (i32.const 448)
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
     (i32.const 448)
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
         (i32.const 448)
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
     (i32.const 448)
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
       (i32.const 448)
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
     (i32.const 448)
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
     (i32.const 112)
     (i32.const 176)
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
 (func $~lib/arraybuffer/ArrayBuffer#constructor (param $this i32) (param $length i32) (result i32)
  (local $buffer i32)
  (if
   (i32.gt_u
    (local.get $length)
    (i32.const 1073741820)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 512)
     (i32.const 560)
     (i32.const 52)
     (i32.const 43)
    )
    (unreachable)
   )
  )
  (local.set $buffer
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (local.get $length)
     (i32.const 1)
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
   (local.get $buffer)
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
     (i32.const 176)
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
 (func $"~lib/map/Map<~lib/string/String,usize>#set:buckets" (param $this i32) (param $buckets i32)
  (i32.store
   (local.get $this)
   (local.get $buckets)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $buckets)
   (i32.const 0)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#set:bucketsMask" (param $this i32) (param $bucketsMask i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $bucketsMask)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#set:entries" (param $this i32) (param $entries i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $entries)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $entries)
   (i32.const 0)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#set:entriesCapacity" (param $this i32) (param $entriesCapacity i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $entriesCapacity)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#constructor" (param $this i32) (result i32)
  (block
   (if
    (i32.eqz
     (local.get $this)
    )
    (then
     (local.set $this
      (call $~lib/rt/__localtostack
       (call $~lib/rt/itcms/__new
        (i32.const 24)
        (i32.const 4)
       )
      )
     )
    )
   )
   (call $"~lib/map/Map<~lib/string/String,usize>#set:buckets"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (call $~lib/rt/__tmptostack
     (call $~lib/arraybuffer/ArrayBuffer#constructor
      (i32.const 0)
      (i32.mul
       (i32.const 4)
       (i32.const 4)
      )
     )
    )
   )
   (call $"~lib/map/Map<~lib/string/String,usize>#set:bucketsMask"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (i32.sub
     (i32.const 4)
     (i32.const 1)
    )
   )
   (call $"~lib/map/Map<~lib/string/String,usize>#set:entries"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (call $~lib/rt/__tmptostack
     (call $~lib/arraybuffer/ArrayBuffer#constructor
      (i32.const 0)
      (i32.mul
       (i32.const 4)
       (block $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.0" (result i32)
        (br $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.0"
         (i32.const 12)
        )
       )
      )
     )
    )
   )
   (call $"~lib/map/Map<~lib/string/String,usize>#set:entriesCapacity"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (i32.const 4)
   )
  )
  (local.get $this)
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
 (func $~lib/util/hash/HASH<~lib/string/String> (param $key i32) (result i32)
  (local $key|1 i32)
  (local $h i32)
  (local $len i32)
  (local $pos i32)
  (local $s1 i32)
  (local $s2 i32)
  (local $s3 i32)
  (local $s4 i32)
  (local $end i32)
  (local $h|10 i32)
  (local $key|11 i32)
  (local $h|12 i32)
  (local $key|13 i32)
  (local $h|14 i32)
  (local $key|15 i32)
  (local $h|16 i32)
  (local $key|17 i32)
  (local $end|18 i32)
  (drop
   (i32.const 1)
  )
  (return
   (block $~lib/util/hash/hashStr|inlined.0 (result i32)
    (local.set $key|1
     (call $~lib/rt/__localtostack
      (local.get $key)
     )
    )
    (if
     (i32.eq
      (local.get $key|1)
      (i32.const 0)
     )
     (then
      (br $~lib/util/hash/hashStr|inlined.0
       (i32.const 0)
      )
     )
    )
    (local.set $h
     (i32.shl
      (call $~lib/string/String#get:length
       (call $~lib/rt/__tmptostack
        (local.get $key|1)
       )
      )
      (i32.const 1)
     )
    )
    (local.set $len
     (local.get $h)
    )
    (local.set $pos
     (local.get $key|1)
    )
    (if
     (i32.ge_u
      (local.get $len)
      (i32.const 16)
     )
     (then
      (local.set $s1
       (i32.add
        (i32.add
         (i32.const 0)
         (i32.const -1640531535)
        )
        (i32.const -2048144777)
       )
      )
      (local.set $s2
       (i32.add
        (i32.const 0)
        (i32.const -2048144777)
       )
      )
      (local.set $s3
       (i32.const 0)
      )
      (local.set $s4
       (i32.sub
        (i32.const 0)
        (i32.const -1640531535)
       )
      )
      (local.set $end
       (i32.sub
        (i32.add
         (local.get $len)
         (local.get $pos)
        )
        (i32.const 16)
       )
      )
      (block $while-break|0
       (loop $while-continue|0
        (if
         (i32.le_u
          (local.get $pos)
          (local.get $end)
         )
         (then
          (local.set $s1
           (block $~lib/util/hash/mix|inlined.0 (result i32)
            (local.set $h|10
             (local.get $s1)
            )
            (local.set $key|11
             (i32.load
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.0
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|10)
                (i32.mul
                 (local.get $key|11)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $s2
           (block $~lib/util/hash/mix|inlined.1 (result i32)
            (local.set $h|12
             (local.get $s2)
            )
            (local.set $key|13
             (i32.load offset=4
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.1
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|12)
                (i32.mul
                 (local.get $key|13)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $s3
           (block $~lib/util/hash/mix|inlined.2 (result i32)
            (local.set $h|14
             (local.get $s3)
            )
            (local.set $key|15
             (i32.load offset=8
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.2
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|14)
                (i32.mul
                 (local.get $key|15)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $s4
           (block $~lib/util/hash/mix|inlined.3 (result i32)
            (local.set $h|16
             (local.get $s4)
            )
            (local.set $key|17
             (i32.load offset=12
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.3
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|16)
                (i32.mul
                 (local.get $key|17)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $pos
           (i32.add
            (local.get $pos)
            (i32.const 16)
           )
          )
          (br $while-continue|0)
         )
        )
       )
      )
      (local.set $h
       (i32.add
        (local.get $h)
        (i32.add
         (i32.add
          (i32.add
           (i32.rotl
            (local.get $s1)
            (i32.const 1)
           )
           (i32.rotl
            (local.get $s2)
            (i32.const 7)
           )
          )
          (i32.rotl
           (local.get $s3)
           (i32.const 12)
          )
         )
         (i32.rotl
          (local.get $s4)
          (i32.const 18)
         )
        )
       )
      )
     )
     (else
      (local.set $h
       (i32.add
        (local.get $h)
        (i32.add
         (i32.const 0)
         (i32.const 374761393)
        )
       )
      )
     )
    )
    (local.set $end|18
     (i32.sub
      (i32.add
       (local.get $key|1)
       (local.get $len)
      )
      (i32.const 4)
     )
    )
    (block $while-break|1
     (loop $while-continue|1
      (if
       (i32.le_u
        (local.get $pos)
        (local.get $end|18)
       )
       (then
        (local.set $h
         (i32.add
          (local.get $h)
          (i32.mul
           (i32.load
            (local.get $pos)
           )
           (i32.const -1028477379)
          )
         )
        )
        (local.set $h
         (i32.mul
          (i32.rotl
           (local.get $h)
           (i32.const 17)
          )
          (i32.const 668265263)
         )
        )
        (local.set $pos
         (i32.add
          (local.get $pos)
          (i32.const 4)
         )
        )
        (br $while-continue|1)
       )
      )
     )
    )
    (local.set $end|18
     (i32.add
      (local.get $key|1)
      (local.get $len)
     )
    )
    (block $while-break|2
     (loop $while-continue|2
      (if
       (i32.lt_u
        (local.get $pos)
        (local.get $end|18)
       )
       (then
        (local.set $h
         (i32.add
          (local.get $h)
          (i32.mul
           (i32.load8_u
            (local.get $pos)
           )
           (i32.const 374761393)
          )
         )
        )
        (local.set $h
         (i32.mul
          (i32.rotl
           (local.get $h)
           (i32.const 11)
          )
          (i32.const -1640531535)
         )
        )
        (local.set $pos
         (i32.add
          (local.get $pos)
          (i32.const 1)
         )
        )
        (br $while-continue|2)
       )
      )
     )
    )
    (local.set $h
     (i32.xor
      (local.get $h)
      (i32.shr_u
       (local.get $h)
       (i32.const 15)
      )
     )
    )
    (local.set $h
     (i32.mul
      (local.get $h)
      (i32.const -2048144777)
     )
    )
    (local.set $h
     (i32.xor
      (local.get $h)
      (i32.shr_u
       (local.get $h)
       (i32.const 13)
      )
     )
    )
    (local.set $h
     (i32.mul
      (local.get $h)
      (i32.const -1028477379)
     )
    )
    (local.set $h
     (i32.xor
      (local.get $h)
      (i32.shr_u
       (local.get $h)
       (i32.const 16)
      )
     )
    )
    (br $~lib/util/hash/hashStr|inlined.0
     (local.get $h)
    )
   )
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#get:buckets" (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#get:bucketsMask" (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $"~lib/map/MapEntry<~lib/string/String,usize>#get:taggedNext" (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $"~lib/map/MapEntry<~lib/string/String,usize>#get:key" (param $this i32) (result i32)
  (i32.load
   (local.get $this)
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
 (func $"~lib/map/Map<~lib/string/String,usize>#find" (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
  (local $entry i32)
  (local $taggedNext i32)
  (local.set $entry
   (i32.load
    (i32.add
     (call $"~lib/map/Map<~lib/string/String,usize>#get:buckets"
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.mul
      (i32.and
       (local.get $hashCode)
       (call $"~lib/map/Map<~lib/string/String,usize>#get:bucketsMask"
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
      )
      (i32.const 4)
     )
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (local.get $entry)
     (then
      (local.set $taggedNext
       (call $"~lib/map/MapEntry<~lib/string/String,usize>#get:taggedNext"
        (local.get $entry)
       )
      )
      (if
       (if (result i32)
        (i32.eqz
         (i32.and
          (local.get $taggedNext)
          (i32.const 1)
         )
        )
        (then
         (call $~lib/string/String.__eq
          (call $~lib/rt/__tmptostack
           (call $"~lib/map/MapEntry<~lib/string/String,usize>#get:key"
            (local.get $entry)
           )
          )
          (call $~lib/rt/__tmptostack
           (local.get $key)
          )
         )
        )
        (else
         (i32.const 0)
        )
       )
       (then
        (return
         (local.get $entry)
        )
       )
      )
      (local.set $entry
       (i32.and
        (local.get $taggedNext)
        (i32.xor
         (i32.const 1)
         (i32.const -1)
        )
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
 (func $"~lib/map/Map<~lib/string/String,usize>#has" (param $this i32) (param $key i32) (result i32)
  (return
   (i32.ne
    (call $"~lib/map/Map<~lib/string/String,usize>#find"
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (call $~lib/rt/__tmptostack
      (local.get $key)
     )
     (call $~lib/util/hash/HASH<~lib/string/String>
      (call $~lib/rt/__tmptostack
       (local.get $key)
      )
     )
    )
    (i32.const 0)
   )
  )
 )
 (func $"~lib/map/MapEntry<~lib/string/String,usize>#get:value" (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#get" (param $this i32) (param $key i32) (result i32)
  (local $entry i32)
  (local.set $entry
   (call $"~lib/map/Map<~lib/string/String,usize>#find"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (call $~lib/rt/__tmptostack
     (local.get $key)
    )
    (call $~lib/util/hash/HASH<~lib/string/String>
     (call $~lib/rt/__tmptostack
      (local.get $key)
     )
    )
   )
  )
  (if
   (i32.eqz
    (local.get $entry)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 624)
     (i32.const 688)
     (i32.const 105)
     (i32.const 17)
    )
    (unreachable)
   )
  )
  (return
   (call $"~lib/map/MapEntry<~lib/string/String,usize>#get:value"
    (local.get $entry)
   )
  )
 )
 (func $"~lib/map/MapEntry<~lib/string/String,usize>#set:value" (param $this i32) (param $value i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $value)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#get:entriesOffset" (param $this i32) (result i32)
  (i32.load offset=16
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#get:entriesCapacity" (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#get:entriesCount" (param $this i32) (result i32)
  (i32.load offset=20
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#get:entries" (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $"~lib/map/MapEntry<~lib/string/String,usize>#set:key" (param $this i32) (param $key i32)
  (i32.store
   (local.get $this)
   (local.get $key)
  )
 )
 (func $"~lib/map/MapEntry<~lib/string/String,usize>#set:taggedNext" (param $this i32) (param $taggedNext i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $taggedNext)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#set:entriesOffset" (param $this i32) (param $entriesOffset i32)
  (i32.store offset=16
   (local.get $this)
   (local.get $entriesOffset)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#rehash" (param $this i32) (param $newBucketsMask i32)
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
  (local.set $newBucketsCapacity
   (i32.add
    (local.get $newBucketsMask)
    (i32.const 1)
   )
  )
  (local.set $newBuckets
   (call $~lib/rt/__localtostack
    (call $~lib/arraybuffer/ArrayBuffer#constructor
     (i32.const 0)
     (i32.mul
      (local.get $newBucketsCapacity)
      (i32.const 4)
     )
    )
   )
  )
  (local.set $newEntriesCapacity
   (i32.div_s
    (i32.mul
     (local.get $newBucketsCapacity)
     (i32.const 8)
    )
    (i32.const 3)
   )
  )
  (local.set $newEntries
   (call $~lib/rt/__localtostack
    (call $~lib/arraybuffer/ArrayBuffer#constructor
     (i32.const 0)
     (i32.mul
      (local.get $newEntriesCapacity)
      (block $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.1" (result i32)
       (br $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.1"
        (i32.const 12)
       )
      )
     )
    )
   )
  )
  (local.set $oldPtr
   (call $"~lib/map/Map<~lib/string/String,usize>#get:entries"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $oldEnd
   (i32.add
    (local.get $oldPtr)
    (i32.mul
     (call $"~lib/map/Map<~lib/string/String,usize>#get:entriesOffset"
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (block $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.2" (result i32)
      (br $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.2"
       (i32.const 12)
      )
     )
    )
   )
  )
  (local.set $newPtr
   (local.get $newEntries)
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.ne
      (local.get $oldPtr)
      (local.get $oldEnd)
     )
     (then
      (local.set $oldEntry
       (local.get $oldPtr)
      )
      (if
       (i32.eqz
        (i32.and
         (call $"~lib/map/MapEntry<~lib/string/String,usize>#get:taggedNext"
          (local.get $oldEntry)
         )
         (i32.const 1)
        )
       )
       (then
        (local.set $newEntry
         (local.get $newPtr)
        )
        (local.set $oldEntryKey
         (call $~lib/rt/__localtostack
          (call $"~lib/map/MapEntry<~lib/string/String,usize>#get:key"
           (local.get $oldEntry)
          )
         )
        )
        (call $"~lib/map/MapEntry<~lib/string/String,usize>#set:key"
         (local.get $newEntry)
         (call $~lib/rt/__tmptostack
          (local.get $oldEntryKey)
         )
        )
        (call $"~lib/map/MapEntry<~lib/string/String,usize>#set:value"
         (local.get $newEntry)
         (call $"~lib/map/MapEntry<~lib/string/String,usize>#get:value"
          (local.get $oldEntry)
         )
        )
        (local.set $newBucketIndex
         (i32.and
          (call $~lib/util/hash/HASH<~lib/string/String>
           (call $~lib/rt/__tmptostack
            (local.get $oldEntryKey)
           )
          )
          (local.get $newBucketsMask)
         )
        )
        (local.set $newBucketPtrBase
         (i32.add
          (local.get $newBuckets)
          (i32.mul
           (local.get $newBucketIndex)
           (i32.const 4)
          )
         )
        )
        (call $"~lib/map/MapEntry<~lib/string/String,usize>#set:taggedNext"
         (local.get $newEntry)
         (i32.load
          (local.get $newBucketPtrBase)
         )
        )
        (i32.store
         (local.get $newBucketPtrBase)
         (local.get $newPtr)
        )
        (local.set $newPtr
         (i32.add
          (local.get $newPtr)
          (block $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.3" (result i32)
           (br $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.3"
            (i32.const 12)
           )
          )
         )
        )
       )
      )
      (local.set $oldPtr
       (i32.add
        (local.get $oldPtr)
        (block $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.4" (result i32)
         (br $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.4"
          (i32.const 12)
         )
        )
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (call $"~lib/map/Map<~lib/string/String,usize>#set:buckets"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $newBuckets)
   )
  )
  (call $"~lib/map/Map<~lib/string/String,usize>#set:bucketsMask"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $newBucketsMask)
  )
  (call $"~lib/map/Map<~lib/string/String,usize>#set:entries"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $newEntries)
   )
  )
  (call $"~lib/map/Map<~lib/string/String,usize>#set:entriesCapacity"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $newEntriesCapacity)
  )
  (call $"~lib/map/Map<~lib/string/String,usize>#set:entriesOffset"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $"~lib/map/Map<~lib/string/String,usize>#get:entriesCount"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#set:entriesCount" (param $this i32) (param $entriesCount i32)
  (i32.store offset=20
   (local.get $this)
   (local.get $entriesCount)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>#set" (param $this i32) (param $key i32) (param $value i32) (result i32)
  (local $hashCode i32)
  (local $entry i32)
  (local $entries i32)
  (local $6 i32)
  (local $bucketPtrBase i32)
  (local.set $hashCode
   (call $~lib/util/hash/HASH<~lib/string/String>
    (call $~lib/rt/__tmptostack
     (local.get $key)
    )
   )
  )
  (local.set $entry
   (call $"~lib/map/Map<~lib/string/String,usize>#find"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (call $~lib/rt/__tmptostack
     (local.get $key)
    )
    (local.get $hashCode)
   )
  )
  (if
   (local.get $entry)
   (then
    (call $"~lib/map/MapEntry<~lib/string/String,usize>#set:value"
     (local.get $entry)
     (local.get $value)
    )
    (drop
     (i32.const 0)
    )
   )
   (else
    (if
     (i32.eq
      (call $"~lib/map/Map<~lib/string/String,usize>#get:entriesOffset"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (call $"~lib/map/Map<~lib/string/String,usize>#get:entriesCapacity"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
     )
     (then
      (call $"~lib/map/Map<~lib/string/String,usize>#rehash"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (if (result i32)
        (i32.lt_s
         (call $"~lib/map/Map<~lib/string/String,usize>#get:entriesCount"
          (call $~lib/rt/__tmptostack
           (local.get $this)
          )
         )
         (i32.div_s
          (i32.mul
           (call $"~lib/map/Map<~lib/string/String,usize>#get:entriesCapacity"
            (call $~lib/rt/__tmptostack
             (local.get $this)
            )
           )
           (i32.const 3)
          )
          (i32.const 4)
         )
        )
        (then
         (call $"~lib/map/Map<~lib/string/String,usize>#get:bucketsMask"
          (call $~lib/rt/__tmptostack
           (local.get $this)
          )
         )
        )
        (else
         (i32.or
          (i32.shl
           (call $"~lib/map/Map<~lib/string/String,usize>#get:bucketsMask"
            (call $~lib/rt/__tmptostack
             (local.get $this)
            )
           )
           (i32.const 1)
          )
          (i32.const 1)
         )
        )
       )
      )
     )
    )
    (local.set $entries
     (call $~lib/rt/__localtostack
      (call $"~lib/map/Map<~lib/string/String,usize>#get:entries"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
     )
    )
    (local.set $entry
     (i32.add
      (local.get $entries)
      (i32.mul
       (block (result i32)
        (call $"~lib/map/Map<~lib/string/String,usize>#set:entriesOffset"
         (call $~lib/rt/__tmptostack
          (local.get $this)
         )
         (i32.add
          (local.tee $6
           (call $"~lib/map/Map<~lib/string/String,usize>#get:entriesOffset"
            (call $~lib/rt/__tmptostack
             (local.get $this)
            )
           )
          )
          (i32.const 1)
         )
        )
        (local.get $6)
       )
       (block $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.5" (result i32)
        (br $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.5"
         (i32.const 12)
        )
       )
      )
     )
    )
    (call $"~lib/map/MapEntry<~lib/string/String,usize>#set:key"
     (local.get $entry)
     (call $~lib/rt/__tmptostack
      (local.get $key)
     )
    )
    (drop
     (i32.const 1)
    )
    (call $~lib/rt/itcms/__link
     (local.get $this)
     (local.get $key)
     (i32.const 1)
    )
    (call $"~lib/map/MapEntry<~lib/string/String,usize>#set:value"
     (local.get $entry)
     (local.get $value)
    )
    (drop
     (i32.const 0)
    )
    (call $"~lib/map/Map<~lib/string/String,usize>#set:entriesCount"
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (i32.add
      (call $"~lib/map/Map<~lib/string/String,usize>#get:entriesCount"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.const 1)
     )
    )
    (local.set $bucketPtrBase
     (i32.add
      (call $"~lib/map/Map<~lib/string/String,usize>#get:buckets"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.mul
       (i32.and
        (local.get $hashCode)
        (call $"~lib/map/Map<~lib/string/String,usize>#get:bucketsMask"
         (call $~lib/rt/__tmptostack
          (local.get $this)
         )
        )
       )
       (i32.const 4)
      )
     )
    )
    (call $"~lib/map/MapEntry<~lib/string/String,usize>#set:taggedNext"
     (local.get $entry)
     (i32.load
      (local.get $bucketPtrBase)
     )
    )
    (i32.store
     (local.get $bucketPtrBase)
     (local.get $entry)
    )
   )
  )
  (return
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#set:buckets" (param $this i32) (param $buckets i32)
  (i32.store
   (local.get $this)
   (local.get $buckets)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $buckets)
   (i32.const 0)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#set:bucketsMask" (param $this i32) (param $bucketsMask i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $bucketsMask)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#set:entries" (param $this i32) (param $entries i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $entries)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $entries)
   (i32.const 0)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#set:entriesCapacity" (param $this i32) (param $entriesCapacity i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $entriesCapacity)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#constructor" (param $this i32) (result i32)
  (block
   (if
    (i32.eqz
     (local.get $this)
    )
    (then
     (local.set $this
      (call $~lib/rt/__localtostack
       (call $~lib/rt/itcms/__new
        (i32.const 24)
        (i32.const 5)
       )
      )
     )
    )
   )
   (call $"~lib/map/Map<usize,~lib/string/String>#set:buckets"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (call $~lib/rt/__tmptostack
     (call $~lib/arraybuffer/ArrayBuffer#constructor
      (i32.const 0)
      (i32.mul
       (i32.const 4)
       (i32.const 4)
      )
     )
    )
   )
   (call $"~lib/map/Map<usize,~lib/string/String>#set:bucketsMask"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (i32.sub
     (i32.const 4)
     (i32.const 1)
    )
   )
   (call $"~lib/map/Map<usize,~lib/string/String>#set:entries"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (call $~lib/rt/__tmptostack
     (call $~lib/arraybuffer/ArrayBuffer#constructor
      (i32.const 0)
      (i32.mul
       (i32.const 4)
       (block $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.0" (result i32)
        (br $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.0"
         (i32.const 12)
        )
       )
      )
     )
    )
   )
   (call $"~lib/map/Map<usize,~lib/string/String>#set:entriesCapacity"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (i32.const 4)
   )
  )
  (local.get $this)
 )
 (func $~lib/util/hash/HASH<usize> (param $key i32) (result i32)
  (local $key|1 i32)
  (local $len i32)
  (local $h i32)
  (drop
   (i32.const 0)
  )
  (block
   (drop
    (i32.const 0)
   )
   (block
    (drop
     (i32.const 0)
    )
    (block
     (drop
      (i32.le_u
       (i32.const 4)
       (i32.const 4)
      )
     )
     (return
      (block $~lib/util/hash/hash32|inlined.0 (result i32)
       (local.set $key|1
        (local.get $key)
       )
       (local.set $len
        (i32.const 4)
       )
       (local.set $h
        (i32.add
         (i32.add
          (i32.const 0)
          (i32.const 374761393)
         )
         (local.get $len)
        )
       )
       (local.set $h
        (i32.add
         (local.get $h)
         (i32.mul
          (local.get $key|1)
          (i32.const -1028477379)
         )
        )
       )
       (local.set $h
        (i32.mul
         (i32.rotl
          (local.get $h)
          (i32.const 17)
         )
         (i32.const 668265263)
        )
       )
       (local.set $h
        (i32.xor
         (local.get $h)
         (i32.shr_u
          (local.get $h)
          (i32.const 15)
         )
        )
       )
       (local.set $h
        (i32.mul
         (local.get $h)
         (i32.const -2048144777)
        )
       )
       (local.set $h
        (i32.xor
         (local.get $h)
         (i32.shr_u
          (local.get $h)
          (i32.const 13)
         )
        )
       )
       (local.set $h
        (i32.mul
         (local.get $h)
         (i32.const -1028477379)
        )
       )
       (local.set $h
        (i32.xor
         (local.get $h)
         (i32.shr_u
          (local.get $h)
          (i32.const 16)
         )
        )
       )
       (br $~lib/util/hash/hash32|inlined.0
        (local.get $h)
       )
      )
     )
    )
   )
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#get:buckets" (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#get:bucketsMask" (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $"~lib/map/MapEntry<usize,~lib/string/String>#get:taggedNext" (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $"~lib/map/MapEntry<usize,~lib/string/String>#get:key" (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#find" (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
  (local $entry i32)
  (local $taggedNext i32)
  (local.set $entry
   (i32.load
    (i32.add
     (call $"~lib/map/Map<usize,~lib/string/String>#get:buckets"
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.mul
      (i32.and
       (local.get $hashCode)
       (call $"~lib/map/Map<usize,~lib/string/String>#get:bucketsMask"
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
      )
      (i32.const 4)
     )
    )
   )
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (local.get $entry)
     (then
      (local.set $taggedNext
       (call $"~lib/map/MapEntry<usize,~lib/string/String>#get:taggedNext"
        (local.get $entry)
       )
      )
      (if
       (if (result i32)
        (i32.eqz
         (i32.and
          (local.get $taggedNext)
          (i32.const 1)
         )
        )
        (then
         (i32.eq
          (call $"~lib/map/MapEntry<usize,~lib/string/String>#get:key"
           (local.get $entry)
          )
          (local.get $key)
         )
        )
        (else
         (i32.const 0)
        )
       )
       (then
        (return
         (local.get $entry)
        )
       )
      )
      (local.set $entry
       (i32.and
        (local.get $taggedNext)
        (i32.xor
         (i32.const 1)
         (i32.const -1)
        )
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
 (func $"~lib/map/MapEntry<usize,~lib/string/String>#set:value" (param $this i32) (param $value i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $value)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#get:entriesOffset" (param $this i32) (result i32)
  (i32.load offset=16
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#get:entriesCapacity" (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#get:entriesCount" (param $this i32) (result i32)
  (i32.load offset=20
   (local.get $this)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#get:entries" (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $"~lib/map/MapEntry<usize,~lib/string/String>#set:key" (param $this i32) (param $key i32)
  (i32.store
   (local.get $this)
   (local.get $key)
  )
 )
 (func $"~lib/map/MapEntry<usize,~lib/string/String>#get:value" (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $"~lib/map/MapEntry<usize,~lib/string/String>#set:taggedNext" (param $this i32) (param $taggedNext i32)
  (i32.store offset=8
   (local.get $this)
   (local.get $taggedNext)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#set:entriesOffset" (param $this i32) (param $entriesOffset i32)
  (i32.store offset=16
   (local.get $this)
   (local.get $entriesOffset)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#rehash" (param $this i32) (param $newBucketsMask i32)
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
  (local.set $newBucketsCapacity
   (i32.add
    (local.get $newBucketsMask)
    (i32.const 1)
   )
  )
  (local.set $newBuckets
   (call $~lib/rt/__localtostack
    (call $~lib/arraybuffer/ArrayBuffer#constructor
     (i32.const 0)
     (i32.mul
      (local.get $newBucketsCapacity)
      (i32.const 4)
     )
    )
   )
  )
  (local.set $newEntriesCapacity
   (i32.div_s
    (i32.mul
     (local.get $newBucketsCapacity)
     (i32.const 8)
    )
    (i32.const 3)
   )
  )
  (local.set $newEntries
   (call $~lib/rt/__localtostack
    (call $~lib/arraybuffer/ArrayBuffer#constructor
     (i32.const 0)
     (i32.mul
      (local.get $newEntriesCapacity)
      (block $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.1" (result i32)
       (br $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.1"
        (i32.const 12)
       )
      )
     )
    )
   )
  )
  (local.set $oldPtr
   (call $"~lib/map/Map<usize,~lib/string/String>#get:entries"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $oldEnd
   (i32.add
    (local.get $oldPtr)
    (i32.mul
     (call $"~lib/map/Map<usize,~lib/string/String>#get:entriesOffset"
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (block $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.2" (result i32)
      (br $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.2"
       (i32.const 12)
      )
     )
    )
   )
  )
  (local.set $newPtr
   (local.get $newEntries)
  )
  (block $while-break|0
   (loop $while-continue|0
    (if
     (i32.ne
      (local.get $oldPtr)
      (local.get $oldEnd)
     )
     (then
      (local.set $oldEntry
       (local.get $oldPtr)
      )
      (if
       (i32.eqz
        (i32.and
         (call $"~lib/map/MapEntry<usize,~lib/string/String>#get:taggedNext"
          (local.get $oldEntry)
         )
         (i32.const 1)
        )
       )
       (then
        (local.set $newEntry
         (local.get $newPtr)
        )
        (local.set $oldEntryKey
         (call $"~lib/map/MapEntry<usize,~lib/string/String>#get:key"
          (local.get $oldEntry)
         )
        )
        (call $"~lib/map/MapEntry<usize,~lib/string/String>#set:key"
         (local.get $newEntry)
         (local.get $oldEntryKey)
        )
        (call $"~lib/map/MapEntry<usize,~lib/string/String>#set:value"
         (local.get $newEntry)
         (call $~lib/rt/__tmptostack
          (call $"~lib/map/MapEntry<usize,~lib/string/String>#get:value"
           (local.get $oldEntry)
          )
         )
        )
        (local.set $newBucketIndex
         (i32.and
          (call $~lib/util/hash/HASH<usize>
           (local.get $oldEntryKey)
          )
          (local.get $newBucketsMask)
         )
        )
        (local.set $newBucketPtrBase
         (i32.add
          (local.get $newBuckets)
          (i32.mul
           (local.get $newBucketIndex)
           (i32.const 4)
          )
         )
        )
        (call $"~lib/map/MapEntry<usize,~lib/string/String>#set:taggedNext"
         (local.get $newEntry)
         (i32.load
          (local.get $newBucketPtrBase)
         )
        )
        (i32.store
         (local.get $newBucketPtrBase)
         (local.get $newPtr)
        )
        (local.set $newPtr
         (i32.add
          (local.get $newPtr)
          (block $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.3" (result i32)
           (br $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.3"
            (i32.const 12)
           )
          )
         )
        )
       )
      )
      (local.set $oldPtr
       (i32.add
        (local.get $oldPtr)
        (block $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.4" (result i32)
         (br $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.4"
          (i32.const 12)
         )
        )
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (call $"~lib/map/Map<usize,~lib/string/String>#set:buckets"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $newBuckets)
   )
  )
  (call $"~lib/map/Map<usize,~lib/string/String>#set:bucketsMask"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $newBucketsMask)
  )
  (call $"~lib/map/Map<usize,~lib/string/String>#set:entries"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $newEntries)
   )
  )
  (call $"~lib/map/Map<usize,~lib/string/String>#set:entriesCapacity"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $newEntriesCapacity)
  )
  (call $"~lib/map/Map<usize,~lib/string/String>#set:entriesOffset"
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $"~lib/map/Map<usize,~lib/string/String>#get:entriesCount"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#set:entriesCount" (param $this i32) (param $entriesCount i32)
  (i32.store offset=20
   (local.get $this)
   (local.get $entriesCount)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#set" (param $this i32) (param $key i32) (param $value i32) (result i32)
  (local $hashCode i32)
  (local $entry i32)
  (local $entries i32)
  (local $6 i32)
  (local $bucketPtrBase i32)
  (local.set $hashCode
   (call $~lib/util/hash/HASH<usize>
    (local.get $key)
   )
  )
  (local.set $entry
   (call $"~lib/map/Map<usize,~lib/string/String>#find"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $key)
    (local.get $hashCode)
   )
  )
  (if
   (local.get $entry)
   (then
    (call $"~lib/map/MapEntry<usize,~lib/string/String>#set:value"
     (local.get $entry)
     (call $~lib/rt/__tmptostack
      (local.get $value)
     )
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
   (else
    (if
     (i32.eq
      (call $"~lib/map/Map<usize,~lib/string/String>#get:entriesOffset"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (call $"~lib/map/Map<usize,~lib/string/String>#get:entriesCapacity"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
     )
     (then
      (call $"~lib/map/Map<usize,~lib/string/String>#rehash"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (if (result i32)
        (i32.lt_s
         (call $"~lib/map/Map<usize,~lib/string/String>#get:entriesCount"
          (call $~lib/rt/__tmptostack
           (local.get $this)
          )
         )
         (i32.div_s
          (i32.mul
           (call $"~lib/map/Map<usize,~lib/string/String>#get:entriesCapacity"
            (call $~lib/rt/__tmptostack
             (local.get $this)
            )
           )
           (i32.const 3)
          )
          (i32.const 4)
         )
        )
        (then
         (call $"~lib/map/Map<usize,~lib/string/String>#get:bucketsMask"
          (call $~lib/rt/__tmptostack
           (local.get $this)
          )
         )
        )
        (else
         (i32.or
          (i32.shl
           (call $"~lib/map/Map<usize,~lib/string/String>#get:bucketsMask"
            (call $~lib/rt/__tmptostack
             (local.get $this)
            )
           )
           (i32.const 1)
          )
          (i32.const 1)
         )
        )
       )
      )
     )
    )
    (local.set $entries
     (call $~lib/rt/__localtostack
      (call $"~lib/map/Map<usize,~lib/string/String>#get:entries"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
     )
    )
    (local.set $entry
     (i32.add
      (local.get $entries)
      (i32.mul
       (block (result i32)
        (call $"~lib/map/Map<usize,~lib/string/String>#set:entriesOffset"
         (call $~lib/rt/__tmptostack
          (local.get $this)
         )
         (i32.add
          (local.tee $6
           (call $"~lib/map/Map<usize,~lib/string/String>#get:entriesOffset"
            (call $~lib/rt/__tmptostack
             (local.get $this)
            )
           )
          )
          (i32.const 1)
         )
        )
        (local.get $6)
       )
       (block $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.5" (result i32)
        (br $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.5"
         (i32.const 12)
        )
       )
      )
     )
    )
    (call $"~lib/map/MapEntry<usize,~lib/string/String>#set:key"
     (local.get $entry)
     (local.get $key)
    )
    (drop
     (i32.const 0)
    )
    (call $"~lib/map/MapEntry<usize,~lib/string/String>#set:value"
     (local.get $entry)
     (call $~lib/rt/__tmptostack
      (local.get $value)
     )
    )
    (drop
     (i32.const 1)
    )
    (call $~lib/rt/itcms/__link
     (local.get $this)
     (local.get $value)
     (i32.const 1)
    )
    (call $"~lib/map/Map<usize,~lib/string/String>#set:entriesCount"
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (i32.add
      (call $"~lib/map/Map<usize,~lib/string/String>#get:entriesCount"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.const 1)
     )
    )
    (local.set $bucketPtrBase
     (i32.add
      (call $"~lib/map/Map<usize,~lib/string/String>#get:buckets"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.mul
       (i32.and
        (local.get $hashCode)
        (call $"~lib/map/Map<usize,~lib/string/String>#get:bucketsMask"
         (call $~lib/rt/__tmptostack
          (local.get $this)
         )
        )
       )
       (i32.const 4)
      )
     )
    )
    (call $"~lib/map/MapEntry<usize,~lib/string/String>#set:taggedNext"
     (local.get $entry)
     (i32.load
      (local.get $bucketPtrBase)
     )
    )
    (i32.store
     (local.get $bucketPtrBase)
     (local.get $entry)
    )
   )
  )
  (return
   (local.get $this)
  )
 )
 (func $~lib/symbol/_Symbol.for (param $key i32) (result i32)
  (local $1 i32)
  (local $id i32)
  (if
   (call $"~lib/map/Map<~lib/string/String,usize>#has"
    (call $~lib/rt/__tmptostack
     (global.get $~lib/symbol/stringToId)
    )
    (call $~lib/rt/__tmptostack
     (local.get $key)
    )
   )
   (then
    (return
     (call $"~lib/map/Map<~lib/string/String,usize>#get"
      (call $~lib/rt/__tmptostack
       (global.get $~lib/symbol/stringToId)
      )
      (call $~lib/rt/__tmptostack
       (local.get $key)
      )
     )
    )
   )
  )
  (local.set $id
   (block (result i32)
    (global.set $~lib/symbol/nextId
     (i32.add
      (local.tee $1
       (global.get $~lib/symbol/nextId)
      )
      (i32.const 1)
     )
    )
    (local.get $1)
   )
  )
  (if
   (i32.eqz
    (local.get $id)
   )
   (then
    (unreachable)
   )
  )
  (drop
   (call $"~lib/map/Map<~lib/string/String,usize>#set"
    (call $~lib/rt/__tmptostack
     (global.get $~lib/symbol/stringToId)
    )
    (call $~lib/rt/__tmptostack
     (local.get $key)
    )
    (local.get $id)
   )
  )
  (drop
   (call $"~lib/map/Map<usize,~lib/string/String>#set"
    (call $~lib/rt/__tmptostack
     (global.get $~lib/symbol/idToString)
    )
    (local.get $id)
    (call $~lib/rt/__tmptostack
     (local.get $key)
    )
   )
  )
  (return
   (local.get $id)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#has" (param $this i32) (param $key i32) (result i32)
  (return
   (i32.ne
    (call $"~lib/map/Map<usize,~lib/string/String>#find"
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (local.get $key)
     (call $~lib/util/hash/HASH<usize>
      (local.get $key)
     )
    )
    (i32.const 0)
   )
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#get" (param $this i32) (param $key i32) (result i32)
  (local $entry i32)
  (local.set $entry
   (call $"~lib/map/Map<usize,~lib/string/String>#find"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $key)
    (call $~lib/util/hash/HASH<usize>
     (local.get $key)
    )
   )
  )
  (if
   (i32.eqz
    (local.get $entry)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 624)
     (i32.const 688)
     (i32.const 105)
     (i32.const 17)
    )
    (unreachable)
   )
  )
  (return
   (call $"~lib/map/MapEntry<usize,~lib/string/String>#get:value"
    (local.get $entry)
   )
  )
 )
 (func $~lib/symbol/_Symbol.keyFor (param $sym i32) (result i32)
  (return
   (if (result i32)
    (call $"~lib/map/Map<usize,~lib/string/String>#has"
     (call $~lib/rt/__tmptostack
      (global.get $~lib/symbol/idToString)
     )
     (local.get $sym)
    )
    (then
     (call $"~lib/map/Map<usize,~lib/string/String>#get"
      (call $~lib/rt/__tmptostack
       (global.get $~lib/symbol/idToString)
      )
      (local.get $sym)
     )
    )
    (else
     (i32.const 0)
    )
   )
  )
 )
 (func $~lib/string/String#concat (param $this i32) (param $other i32) (result i32)
  (local $thisSize i32)
  (local $otherSize i32)
  (local $outSize i32)
  (local $out i32)
  (local.set $thisSize
   (i32.shl
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (local.set $otherSize
   (i32.shl
    (call $~lib/string/String#get:length
     (call $~lib/rt/__tmptostack
      (local.get $other)
     )
    )
    (i32.const 1)
   )
  )
  (local.set $outSize
   (i32.add
    (local.get $thisSize)
    (local.get $otherSize)
   )
  )
  (if
   (i32.eq
    (local.get $outSize)
    (i32.const 0)
   )
   (then
    (return
     (i32.const 864)
    )
   )
  )
  (local.set $out
   (call $~lib/rt/__localtostack
    (call $~lib/rt/itcms/__new
     (local.get $outSize)
     (i32.const 2)
    )
   )
  )
  (memory.copy
   (local.get $out)
   (local.get $this)
   (local.get $thisSize)
  )
  (memory.copy
   (i32.add
    (local.get $out)
    (local.get $thisSize)
   )
   (local.get $other)
   (local.get $otherSize)
  )
  (return
   (local.get $out)
  )
 )
 (func $~lib/string/String.__concat (param $left i32) (param $right i32) (result i32)
  (return
   (call $~lib/string/String#concat
    (call $~lib/rt/__tmptostack
     (local.get $left)
    )
    (call $~lib/rt/__tmptostack
     (local.get $right)
    )
   )
  )
 )
 (func $~lib/symbol/_Symbol#toString (param $this i32) (result i32)
  (local $id i32)
  (local $str i32)
  (local $3 i32)
  (local.set $id
   (local.get $this)
  )
  (local.set $str
   (call $~lib/rt/__localtostack
    (i32.const 864)
   )
  )
  (block $break|0
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
               (local.set $3
                (local.get $id)
               )
               (br_if $case0|0
                (i32.eq
                 (local.get $3)
                 (i32.const 1)
                )
               )
               (br_if $case1|0
                (i32.eq
                 (local.get $3)
                 (i32.const 2)
                )
               )
               (br_if $case2|0
                (i32.eq
                 (local.get $3)
                 (i32.const 3)
                )
               )
               (br_if $case3|0
                (i32.eq
                 (local.get $3)
                 (i32.const 4)
                )
               )
               (br_if $case4|0
                (i32.eq
                 (local.get $3)
                 (i32.const 5)
                )
               )
               (br_if $case5|0
                (i32.eq
                 (local.get $3)
                 (i32.const 6)
                )
               )
               (br_if $case6|0
                (i32.eq
                 (local.get $3)
                 (i32.const 7)
                )
               )
               (br_if $case7|0
                (i32.eq
                 (local.get $3)
                 (i32.const 8)
                )
               )
               (br_if $case8|0
                (i32.eq
                 (local.get $3)
                 (i32.const 9)
                )
               )
               (br_if $case9|0
                (i32.eq
                 (local.get $3)
                 (i32.const 10)
                )
               )
               (br_if $case10|0
                (i32.eq
                 (local.get $3)
                 (i32.const 11)
                )
               )
               (br $case11|0)
              )
              (block
               (local.set $str
                (call $~lib/rt/__localtostack
                 (i32.const 896)
                )
               )
               (br $break|0)
              )
             )
             (block
              (local.set $str
               (call $~lib/rt/__localtostack
                (i32.const 944)
               )
              )
              (br $break|0)
             )
            )
            (block
             (local.set $str
              (call $~lib/rt/__localtostack
               (i32.const 1008)
              )
             )
             (br $break|0)
            )
           )
           (block
            (local.set $str
             (call $~lib/rt/__localtostack
              (i32.const 1056)
             )
            )
            (br $break|0)
           )
          )
          (block
           (local.set $str
            (call $~lib/rt/__localtostack
             (i32.const 1088)
            )
           )
           (br $break|0)
          )
         )
         (block
          (local.set $str
           (call $~lib/rt/__localtostack
            (i32.const 1136)
           )
          )
          (br $break|0)
         )
        )
        (block
         (local.set $str
          (call $~lib/rt/__localtostack
           (i32.const 1168)
          )
         )
         (br $break|0)
        )
       )
       (block
        (local.set $str
         (call $~lib/rt/__localtostack
          (i32.const 1216)
         )
        )
        (br $break|0)
       )
      )
      (block
       (local.set $str
        (call $~lib/rt/__localtostack
         (i32.const 1248)
        )
       )
       (br $break|0)
      )
     )
     (block
      (local.set $str
       (call $~lib/rt/__localtostack
        (i32.const 1296)
       )
      )
      (br $break|0)
     )
    )
    (block
     (local.set $str
      (call $~lib/rt/__localtostack
       (i32.const 1344)
      )
     )
     (br $break|0)
    )
   )
   (block
    (if
     (if (result i32)
      (i32.ne
       (global.get $~lib/symbol/idToString)
       (i32.const 0)
      )
      (then
       (call $"~lib/map/Map<usize,~lib/string/String>#has"
        (call $~lib/rt/__tmptostack
         (global.get $~lib/symbol/idToString)
        )
        (local.get $id)
       )
      )
      (else
       (i32.const 0)
      )
     )
     (then
      (local.set $str
       (call $~lib/rt/__localtostack
        (call $"~lib/map/Map<usize,~lib/string/String>#get"
         (call $~lib/rt/__tmptostack
          (global.get $~lib/symbol/idToString)
         )
         (local.get $id)
        )
       )
      )
     )
    )
    (br $break|0)
   )
  )
  (return
   (call $~lib/string/String.__concat
    (call $~lib/rt/__tmptostack
     (call $~lib/string/String.__concat
      (i32.const 1392)
      (call $~lib/rt/__tmptostack
       (local.get $str)
      )
     )
    )
    (i32.const 1440)
   )
  )
 )
 (func $start:std/symbol
  (local $0 i32)
  (local $1 i32)
  (global.set $std/symbol/sym1
   (call $~lib/symbol/Symbol
    (i32.const 32)
   )
  )
  (global.set $std/symbol/sym2
   (call $~lib/symbol/Symbol
    (i32.const 32)
   )
  )
  (if
   (i32.eqz
    (i32.ne
     (global.get $std/symbol/sym1)
     (global.get $std/symbol/sym2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 4)
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
    (i32.const 224)
   )
  )
  (global.set $~lib/rt/itcms/toSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 256)
   )
  )
  (global.set $~lib/rt/itcms/fromSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 400)
   )
  )
  (global.set $~lib/symbol/stringToId
   (call $"~lib/map/Map<~lib/string/String,usize>#constructor"
    (i32.const 0)
   )
  )
  (global.set $~lib/symbol/idToString
   (call $"~lib/map/Map<usize,~lib/string/String>#constructor"
    (i32.const 0)
   )
  )
  (global.set $std/symbol/sym3
   (call $~lib/symbol/_Symbol.for
    (i32.const 32)
   )
  )
  (global.set $std/symbol/sym4
   (call $~lib/symbol/_Symbol.for
    (i32.const 32)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/symbol/sym3)
     (global.get $std/symbol/sym4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 9)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/symbol/key1
   (call $~lib/symbol/_Symbol.keyFor
    (global.get $std/symbol/sym1)
   )
  )
  (global.set $std/symbol/key2
   (call $~lib/symbol/_Symbol.keyFor
    (global.get $std/symbol/sym2)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (global.get $std/symbol/key1)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
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
      (global.get $std/symbol/key2)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 15)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/symbol/key3
   (if (result i32)
    (local.tee $0
     (call $~lib/rt/__localtostack
      (call $~lib/symbol/_Symbol.keyFor
       (global.get $std/symbol/sym3)
      )
     )
    )
    (then
     (local.get $0)
    )
    (else
     (call $~lib/builtins/abort
      (i32.const 736)
      (i32.const 64)
      (i32.const 17)
      (i32.const 12)
     )
     (unreachable)
    )
   )
  )
  (global.set $std/symbol/key4
   (if (result i32)
    (local.tee $1
     (call $~lib/rt/__localtostack
      (call $~lib/symbol/_Symbol.keyFor
       (global.get $std/symbol/sym4)
      )
     )
    )
    (then
     (local.get $1)
    )
    (else
     (call $~lib/builtins/abort
      (i32.const 736)
      (i32.const 64)
      (i32.const 18)
      (i32.const 12)
     )
     (unreachable)
    )
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (global.get $std/symbol/key3)
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
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
      (global.get $std/symbol/key3)
     )
     (call $~lib/rt/__tmptostack
      (global.get $std/symbol/key4)
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
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
      (call $~lib/symbol/_Symbol#toString
       (call $~lib/symbol/Symbol
        (i32.const 0)
       )
      )
     )
     (i32.const 1472)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
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
      (call $~lib/symbol/_Symbol#toString
       (global.get $std/symbol/sym3)
      )
     )
     (i32.const 1520)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 24)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/symbol/hasInstance
   (global.get $~lib/symbol/_Symbol.hasInstance)
  )
  (global.set $std/symbol/isConcatSpreadable
   (global.get $~lib/symbol/_Symbol.isConcatSpreadable)
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/symbol/_Symbol#toString
       (global.get $std/symbol/hasInstance)
      )
     )
     (i32.const 1568)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 28)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (call $~lib/symbol/_Symbol#toString
       (global.get $std/symbol/isConcatSpreadable)
      )
     )
     (i32.const 1632)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 29)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (drop
   (global.get $~lib/symbol/_Symbol.hasInstance)
  )
  (drop
   (global.get $~lib/symbol/_Symbol.isConcatSpreadable)
  )
 )
 (func $~lib/rt/__visit_globals (param $0 i32)
  (local $1 i32)
  (if
   (local.tee $1
    (global.get $~lib/symbol/stringToId)
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
    (global.get $~lib/symbol/idToString)
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
    (global.get $std/symbol/key1)
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
    (global.get $std/symbol/key2)
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
    (global.get $std/symbol/key3)
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
    (global.get $std/symbol/key4)
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
 (func $"~lib/map/Map<~lib/string/String,usize>#__visit" (param $this i32) (param $cookie i32)
  (local $entries i32)
  (local $cur i32)
  (local $end i32)
  (local $entry i32)
  (local $val i32)
  (call $~lib/rt/itcms/__visit
   (call $"~lib/map/Map<~lib/string/String,usize>#get:buckets"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
  (local.set $entries
   (call $"~lib/map/Map<~lib/string/String,usize>#get:entries"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (block
   (local.set $cur
    (local.get $entries)
   )
   (local.set $end
    (i32.add
     (local.get $cur)
     (i32.mul
      (call $"~lib/map/Map<~lib/string/String,usize>#get:entriesOffset"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (block $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.6" (result i32)
       (br $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.6"
        (i32.const 12)
       )
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
       (local.set $entry
        (local.get $cur)
       )
       (if
        (i32.eqz
         (i32.and
          (call $"~lib/map/MapEntry<~lib/string/String,usize>#get:taggedNext"
           (local.get $entry)
          )
          (i32.const 1)
         )
        )
        (then
         (drop
          (i32.const 1)
         )
         (block
          (local.set $val
           (call $"~lib/map/MapEntry<~lib/string/String,usize>#get:key"
            (local.get $entry)
           )
          )
          (drop
           (i32.const 0)
          )
          (call $~lib/rt/itcms/__visit
           (local.get $val)
           (local.get $cookie)
          )
         )
         (drop
          (i32.const 0)
         )
        )
       )
       (local.set $cur
        (i32.add
         (local.get $cur)
         (block $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.7" (result i32)
          (br $"~lib/map/ENTRY_SIZE<~lib/string/String,usize>|inlined.7"
           (i32.const 12)
          )
         )
        )
       )
       (br $while-continue|0)
      )
     )
    )
   )
  )
  (call $~lib/rt/itcms/__visit
   (local.get $entries)
   (local.get $cookie)
  )
 )
 (func $"~lib/map/Map<~lib/string/String,usize>~visit" (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $"~lib/map/Map<~lib/string/String,usize>#__visit"
   (local.get $0)
   (local.get $1)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>#__visit" (param $this i32) (param $cookie i32)
  (local $entries i32)
  (local $cur i32)
  (local $end i32)
  (local $entry i32)
  (local $val i32)
  (call $~lib/rt/itcms/__visit
   (call $"~lib/map/Map<usize,~lib/string/String>#get:buckets"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
  (local.set $entries
   (call $"~lib/map/Map<usize,~lib/string/String>#get:entries"
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (drop
   (i32.const 1)
  )
  (block
   (local.set $cur
    (local.get $entries)
   )
   (local.set $end
    (i32.add
     (local.get $cur)
     (i32.mul
      (call $"~lib/map/Map<usize,~lib/string/String>#get:entriesOffset"
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (block $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.6" (result i32)
       (br $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.6"
        (i32.const 12)
       )
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
       (local.set $entry
        (local.get $cur)
       )
       (if
        (i32.eqz
         (i32.and
          (call $"~lib/map/MapEntry<usize,~lib/string/String>#get:taggedNext"
           (local.get $entry)
          )
          (i32.const 1)
         )
        )
        (then
         (drop
          (i32.const 0)
         )
         (drop
          (i32.const 1)
         )
         (block
          (local.set $val
           (call $"~lib/map/MapEntry<usize,~lib/string/String>#get:value"
            (local.get $entry)
           )
          )
          (drop
           (i32.const 0)
          )
          (call $~lib/rt/itcms/__visit
           (local.get $val)
           (local.get $cookie)
          )
         )
        )
       )
       (local.set $cur
        (i32.add
         (local.get $cur)
         (block $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.7" (result i32)
          (br $"~lib/map/ENTRY_SIZE<usize,~lib/string/String>|inlined.7"
           (i32.const 12)
          )
         )
        )
       )
       (br $while-continue|0)
      )
     )
    )
   )
  )
  (call $~lib/rt/itcms/__visit
   (local.get $entries)
   (local.get $cookie)
  )
 )
 (func $"~lib/map/Map<usize,~lib/string/String>~visit" (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $"~lib/map/Map<usize,~lib/string/String>#__visit"
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/rt/__visit_members (param $0 i32) (param $1 i32)
  (block $invalid
   (block $"~lib/map/Map<usize,~lib/string/String>"
    (block $"~lib/map/Map<~lib/string/String,usize>"
     (block $~lib/arraybuffer/ArrayBufferView
      (block $~lib/string/String
       (block $~lib/arraybuffer/ArrayBuffer
        (block $~lib/object/Object
         (br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $"~lib/map/Map<~lib/string/String,usize>" $"~lib/map/Map<usize,~lib/string/String>" $invalid
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
     (call $"~lib/map/Map<~lib/string/String,usize>~visit"
      (local.get $0)
      (local.get $1)
     )
     (return)
    )
   )
   (block
    (call $"~lib/map/Map<usize,~lib/string/String>~visit"
     (local.get $0)
     (local.get $1)
    )
    (return)
   )
  )
  (unreachable)
 )
 (func $~start
  (if
   (global.get $~started)
   (then
    (return)
   )
  )
  (global.set $~started
   (i32.const 1)
  )
  (call $start:std/symbol)
 )
)
