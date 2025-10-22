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
 (global $std/operator-overloading/a1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/a2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/a (mut i32) (i32.const 0))
 (global $std/operator-overloading/s1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/s2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/s (mut i32) (i32.const 0))
 (global $std/operator-overloading/m1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/m2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/m (mut i32) (i32.const 0))
 (global $std/operator-overloading/d1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/d2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/d (mut i32) (i32.const 0))
 (global $std/operator-overloading/f1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/f2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/f (mut i32) (i32.const 0))
 (global $std/operator-overloading/p1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/p2 (mut i32) (i32.const 0))
 (global $~lib/native/ASC_SHRINK_LEVEL i32 (i32.const 0))
 (global $std/operator-overloading/p (mut i32) (i32.const 0))
 (global $std/operator-overloading/n1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/n2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/n (mut i32) (i32.const 0))
 (global $std/operator-overloading/o1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/o2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/o (mut i32) (i32.const 0))
 (global $std/operator-overloading/x1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/x2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/x (mut i32) (i32.const 0))
 (global $std/operator-overloading/eq1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/eq2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/eq (mut i32) (i32.const 0))
 (global $std/operator-overloading/eq3 (mut i32) (i32.const 0))
 (global $std/operator-overloading/eq4 (mut i32) (i32.const 0))
 (global $std/operator-overloading/eqf (mut i32) (i32.const 0))
 (global $~lib/builtins/i32.MAX_VALUE i32 (i32.const 2147483647))
 (global $std/operator-overloading/gt1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/gt2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/gt (mut i32) (i32.const 0))
 (global $std/operator-overloading/gte1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/gte2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/gte (mut i32) (i32.const 0))
 (global $std/operator-overloading/le1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/le2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/le (mut i32) (i32.const 0))
 (global $std/operator-overloading/leq1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/leq2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/leq (mut i32) (i32.const 0))
 (global $std/operator-overloading/shr (mut i32) (i32.const 0))
 (global $std/operator-overloading/sres (mut i32) (i32.const 0))
 (global $std/operator-overloading/shu (mut i32) (i32.const 0))
 (global $std/operator-overloading/ures (mut i32) (i32.const 0))
 (global $std/operator-overloading/shl (mut i32) (i32.const 0))
 (global $std/operator-overloading/pos (mut i32) (i32.const 0))
 (global $std/operator-overloading/pres (mut i32) (i32.const 0))
 (global $std/operator-overloading/neg (mut i32) (i32.const 0))
 (global $std/operator-overloading/nres (mut i32) (i32.const 0))
 (global $std/operator-overloading/not (mut i32) (i32.const 0))
 (global $std/operator-overloading/res (mut i32) (i32.const 0))
 (global $std/operator-overloading/excl (mut i32) (i32.const 0))
 (global $std/operator-overloading/bres (mut i32) (i32.const 0))
 (global $std/operator-overloading/incdec (mut i32) (i32.const 0))
 (global $std/operator-overloading/tmp (mut i32) (i32.const 0))
 (global $std/operator-overloading/ais1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/ais2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/ais (mut i32) (i32.const 0))
 (global $std/operator-overloading/aii1 (mut i32) (i32.const 0))
 (global $std/operator-overloading/aii2 (mut i32) (i32.const 0))
 (global $std/operator-overloading/aii (mut i32) (i32.const 0))
 (global $std/operator-overloading/tea (mut i32) (i32.const 0))
 (global $~lib/rt/__rtti_base i32 (i32.const 560))
 (global $~lib/memory/__data_end i32 (i32.const 596))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33364))
 (global $~lib/memory/__heap_base i32 (i32.const 33364))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $1 (i32.const 76) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 144) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 176) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 204) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 268) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 320) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $7 (i32.const 348) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 412) "L\00\00\00\00\00\00\00\00\00\00\00\02\00\00\006\00\00\00s\00t\00d\00/\00o\00p\00e\00r\00a\00t\00o\00r\00-\00o\00v\00e\00r\00l\00o\00a\00d\00i\00n\00g\00.\00t\00s\00\00\00\00\00\00\00")
 (data $9 (i32.const 492) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00x\00\00\00\00\00\00\00\00\00\00\00")
 (data $10 (i32.const 524) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00y\00\00\00\00\00\00\00\00\00\00\00")
 (data $11 (i32.const 560) "\08\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00 \00\00\00 \00\00\00 \00\00\00 \00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
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
         (i32.const 96)
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
       (i32.const 96)
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
     (i32.const 96)
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
     (i32.const 224)
     (i32.const 288)
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
        (i32.const 96)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
       (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
       (i32.const 368)
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
       (i32.const 368)
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
     (i32.const 368)
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
         (i32.const 96)
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
     (i32.const 32)
     (i32.const 368)
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
     (i32.const 368)
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
         (i32.const 368)
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
     (i32.const 368)
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
       (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 32)
     (i32.const 96)
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
 (func $std/operator-overloading/Tester#set:x (param $this i32) (param $x i32)
  (i32.store
   (local.get $this)
   (local.get $x)
  )
 )
 (func $std/operator-overloading/Tester#set:y (param $this i32) (param $y i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $y)
  )
 )
 (func $std/operator-overloading/Tester#constructor (param $this i32) (param $x i32) (param $y i32) (result i32)
  (block
   (if
    (i32.eqz
     (local.get $this)
    )
    (then
     (local.set $this
      (call $~lib/rt/__localtostack
       (call $~lib/rt/itcms/__new
        (i32.const 8)
        (i32.const 4)
       )
      )
     )
    )
   )
   (call $std/operator-overloading/Tester#set:x
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $x)
   )
   (call $std/operator-overloading/Tester#set:y
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $y)
   )
  )
  (local.get $this)
 )
 (func $std/operator-overloading/Tester#get:x (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $std/operator-overloading/Tester#get:y (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $std/operator-overloading/Tester.add (param $a i32) (param $b i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.add
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (i32.add
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.sub (param $a i32) (param $b i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.sub
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (i32.sub
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.mul (param $a i32) (param $b i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.mul
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (i32.mul
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.div (param $a i32) (param $b i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.div_s
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (i32.div_s
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.mod (param $a i32) (param $b i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.rem_s
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (i32.rem_s
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
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
 (func $std/operator-overloading/Tester.pow (param $a i32) (param $b i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (call $~lib/math/ipow32
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (call $~lib/math/ipow32
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.and (param $a i32) (param $b i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.and
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (i32.and
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.or (param $a i32) (param $b i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.or
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (i32.or
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.xor (param $a i32) (param $b i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.xor
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (i32.xor
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.equals (param $a i32) (param $b i32) (result i32)
  (return
   (if (result i32)
    (i32.eq
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (then
     (i32.eq
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $a)
       )
      )
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $b)
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
 (func $std/operator-overloading/Tester.notEquals (param $a i32) (param $b i32) (result i32)
  (return
   (if (result i32)
    (i32.ne
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (then
     (i32.ne
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $a)
       )
      )
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $b)
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
 (func $std/operator-overloading/Tester.greater (param $a i32) (param $b i32) (result i32)
  (return
   (if (result i32)
    (i32.gt_s
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (then
     (i32.gt_s
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $a)
       )
      )
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $b)
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
 (func $std/operator-overloading/Tester.greaterEquals (param $a i32) (param $b i32) (result i32)
  (return
   (if (result i32)
    (i32.ge_s
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (then
     (i32.ge_s
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $a)
       )
      )
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $b)
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
 (func $std/operator-overloading/Tester.less (param $a i32) (param $b i32) (result i32)
  (return
   (if (result i32)
    (i32.lt_s
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (then
     (i32.lt_s
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $a)
       )
      )
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $b)
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
 (func $std/operator-overloading/Tester.lessEquals (param $a i32) (param $b i32) (result i32)
  (return
   (if (result i32)
    (i32.le_s
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $a)
      )
     )
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $b)
      )
     )
    )
    (then
     (i32.le_s
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $a)
       )
      )
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $b)
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
 (func $std/operator-overloading/Tester.shr (param $value i32) (param $shift i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.shr_s
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
     (local.get $shift)
    )
    (i32.shr_s
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
     (local.get $shift)
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.shu (param $value i32) (param $shift i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.shr_u
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
     (local.get $shift)
    )
    (i32.shr_u
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
     (local.get $shift)
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.shl (param $value i32) (param $shift i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.shl
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
     (local.get $shift)
    )
    (i32.shl
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
     (local.get $shift)
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.pos (param $value i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (call $std/operator-overloading/Tester#get:x
     (call $~lib/rt/__tmptostack
      (local.get $value)
     )
    )
    (call $std/operator-overloading/Tester#get:y
     (call $~lib/rt/__tmptostack
      (local.get $value)
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.neg (param $value i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.sub
     (i32.const 0)
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
    )
    (i32.sub
     (i32.const 0)
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.not (param $value i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.xor
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
     (i32.const -1)
    )
    (i32.xor
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
     (i32.const -1)
    )
   )
  )
 )
 (func $std/operator-overloading/Tester.excl (param $value i32) (result i32)
  (return
   (if (result i32)
    (i32.eqz
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $value)
      )
     )
    )
    (then
     (i32.eqz
      (call $std/operator-overloading/Tester#get:y
       (call $~lib/rt/__tmptostack
        (local.get $value)
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
 (func $std/operator-overloading/Tester#inc (param $this i32) (result i32)
  (call $std/operator-overloading/Tester#set:x
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.add
    (call $std/operator-overloading/Tester#get:x
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (call $std/operator-overloading/Tester#set:y
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.add
    (call $std/operator-overloading/Tester#get:y
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (return
   (local.get $this)
  )
 )
 (func $std/operator-overloading/Tester#dec (param $this i32) (result i32)
  (call $std/operator-overloading/Tester#set:x
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.sub
    (call $std/operator-overloading/Tester#get:x
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (call $std/operator-overloading/Tester#set:y
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.sub
    (call $std/operator-overloading/Tester#get:y
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (return
   (local.get $this)
  )
 )
 (func $std/operator-overloading/Tester#postInc (param $this i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.add
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.const 1)
    )
    (i32.add
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.const 1)
    )
   )
  )
 )
 (func $std/operator-overloading/Tester#postDec (param $this i32) (result i32)
  (return
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.sub
     (call $std/operator-overloading/Tester#get:x
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.const 1)
    )
    (i32.sub
     (call $std/operator-overloading/Tester#get:y
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.const 1)
    )
   )
  )
 )
 (func $std/operator-overloading/TesterInlineStatic#set:x (param $this i32) (param $x i32)
  (i32.store
   (local.get $this)
   (local.get $x)
  )
 )
 (func $std/operator-overloading/TesterInlineStatic#set:y (param $this i32) (param $y i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $y)
  )
 )
 (func $std/operator-overloading/TesterInlineStatic#constructor (param $this i32) (param $x i32) (param $y i32) (result i32)
  (block
   (if
    (i32.eqz
     (local.get $this)
    )
    (then
     (local.set $this
      (call $~lib/rt/__localtostack
       (call $~lib/rt/itcms/__new
        (i32.const 8)
        (i32.const 5)
       )
      )
     )
    )
   )
   (call $std/operator-overloading/TesterInlineStatic#set:x
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $x)
   )
   (call $std/operator-overloading/TesterInlineStatic#set:y
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $y)
   )
  )
  (local.get $this)
 )
 (func $std/operator-overloading/TesterInlineStatic#get:x (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $std/operator-overloading/TesterInlineStatic#get:y (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $std/operator-overloading/TesterInlineInstance#set:x (param $this i32) (param $x i32)
  (i32.store
   (local.get $this)
   (local.get $x)
  )
 )
 (func $std/operator-overloading/TesterInlineInstance#set:y (param $this i32) (param $y i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $y)
  )
 )
 (func $std/operator-overloading/TesterInlineInstance#constructor (param $this i32) (param $x i32) (param $y i32) (result i32)
  (block
   (if
    (i32.eqz
     (local.get $this)
    )
    (then
     (local.set $this
      (call $~lib/rt/__localtostack
       (call $~lib/rt/itcms/__new
        (i32.const 8)
        (i32.const 6)
       )
      )
     )
    )
   )
   (call $std/operator-overloading/TesterInlineInstance#set:x
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $x)
   )
   (call $std/operator-overloading/TesterInlineInstance#set:y
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $y)
   )
  )
  (local.get $this)
 )
 (func $std/operator-overloading/TesterInlineInstance#get:x (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $std/operator-overloading/TesterInlineInstance#get:y (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $std/operator-overloading/TesterElementAccess#set:x (param $this i32) (param $x i32)
  (i32.store
   (local.get $this)
   (local.get $x)
  )
 )
 (func $std/operator-overloading/TesterElementAccess#set:y (param $this i32) (param $y i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $y)
  )
 )
 (func $std/operator-overloading/TesterElementAccess#constructor (param $this i32) (param $x i32) (param $y i32) (result i32)
  (block
   (if
    (i32.eqz
     (local.get $this)
    )
    (then
     (local.set $this
      (call $~lib/rt/__localtostack
       (call $~lib/rt/itcms/__new
        (i32.const 8)
        (i32.const 7)
       )
      )
     )
    )
   )
   (call $std/operator-overloading/TesterElementAccess#set:x
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $x)
   )
   (call $std/operator-overloading/TesterElementAccess#set:y
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $y)
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
 (func $std/operator-overloading/TesterElementAccess#__set (param $this i32) (param $key i32) (param $value i32)
  (if
   (call $~lib/string/String.__eq
    (call $~lib/rt/__tmptostack
     (local.get $key)
    )
    (i32.const 512)
   )
   (then
    (call $std/operator-overloading/TesterElementAccess#set:x
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (local.get $value)
    )
   )
   (else
    (call $std/operator-overloading/TesterElementAccess#set:y
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (local.get $value)
    )
   )
  )
 )
 (func $std/operator-overloading/TesterElementAccess#get:x (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $std/operator-overloading/TesterElementAccess#get:y (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $std/operator-overloading/TesterElementAccess#__get (param $this i32) (param $key i32) (result i32)
  (return
   (if (result i32)
    (call $~lib/string/String.__eq
     (call $~lib/rt/__tmptostack
      (local.get $key)
     )
     (i32.const 512)
    )
    (then
     (call $std/operator-overloading/TesterElementAccess#get:x
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
    )
    (else
     (call $std/operator-overloading/TesterElementAccess#get:y
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
    )
   )
  )
 )
 (func $start:std/operator-overloading
  (local $0 i32)
  (local $1 i32)
  (local $2 i32)
  (local $a i32)
  (local $a|4 i32)
  (local $b i32)
  (local $this i32)
  (local $this|7 i32)
  (local $b|8 i32)
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
    (i32.const 144)
   )
  )
  (global.set $~lib/rt/itcms/toSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 176)
   )
  )
  (global.set $~lib/rt/itcms/fromSpace
   (call $~lib/rt/itcms/initLazy
    (i32.const 320)
   )
  )
  (global.set $std/operator-overloading/a1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const 2)
   )
  )
  (global.set $std/operator-overloading/a2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 2)
    (i32.const 3)
   )
  )
  (global.set $std/operator-overloading/a
   (call $std/operator-overloading/Tester.add
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/a1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/a2)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/a)
       )
      )
      (i32.const 3)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/a)
        )
       )
       (i32.const 5)
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
     (i32.const 432)
     (i32.const 172)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/s1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 2)
    (i32.const 3)
   )
  )
  (global.set $std/operator-overloading/s2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 2)
    (i32.const -3)
   )
  )
  (global.set $std/operator-overloading/s
   (call $std/operator-overloading/Tester.sub
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/s1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/s2)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/s)
       )
      )
      (i32.const 0)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/s)
        )
       )
       (i32.const 6)
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
     (i32.const 432)
     (i32.const 178)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/m1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 2)
    (i32.const 5)
   )
  )
  (global.set $std/operator-overloading/m2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 3)
    (i32.const 2)
   )
  )
  (global.set $std/operator-overloading/m
   (call $std/operator-overloading/Tester.mul
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/m1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/m2)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/m)
       )
      )
      (i32.const 6)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/m)
        )
       )
       (i32.const 10)
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
     (i32.const 432)
     (i32.const 184)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/d1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 6)
    (i32.const 50)
   )
  )
  (global.set $std/operator-overloading/d2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 3)
    (i32.const 10)
   )
  )
  (global.set $std/operator-overloading/d
   (call $std/operator-overloading/Tester.div
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/d1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/d2)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/d)
       )
      )
      (i32.const 2)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/d)
        )
       )
       (i32.const 5)
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
     (i32.const 432)
     (i32.const 190)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/f1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 10)
    (i32.const 10)
   )
  )
  (global.set $std/operator-overloading/f2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 6)
    (i32.const 10)
   )
  )
  (global.set $std/operator-overloading/f
   (call $std/operator-overloading/Tester.mod
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/f1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/f2)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/f)
       )
      )
      (i32.const 4)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/f)
        )
       )
       (i32.const 0)
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
     (i32.const 432)
     (i32.const 196)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/p1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 2)
    (i32.const 3)
   )
  )
  (global.set $std/operator-overloading/p2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 4)
    (i32.const 5)
   )
  )
  (global.set $std/operator-overloading/p
   (call $std/operator-overloading/Tester.pow
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/p1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/p2)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/p)
       )
      )
      (i32.const 16)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/p)
        )
       )
       (i32.const 243)
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
     (i32.const 432)
     (i32.const 202)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/n1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 255)
    (i32.const 15)
   )
  )
  (global.set $std/operator-overloading/n2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 15)
    (i32.const 255)
   )
  )
  (global.set $std/operator-overloading/n
   (call $std/operator-overloading/Tester.and
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/n1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/n2)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/n)
       )
      )
      (i32.const 15)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/n)
        )
       )
       (i32.const 15)
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
     (i32.const 432)
     (i32.const 208)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/o1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 3855)
    (i32.const 255)
   )
  )
  (global.set $std/operator-overloading/o2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 61680)
    (i32.const 0)
   )
  )
  (global.set $std/operator-overloading/o
   (call $std/operator-overloading/Tester.or
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/o1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/o2)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/o)
       )
      )
      (i32.const 65535)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/o)
        )
       )
       (i32.const 255)
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
     (i32.const 432)
     (i32.const 214)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/x1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 255)
    (i32.const 255)
   )
  )
  (global.set $std/operator-overloading/x2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 65280)
    (i32.const 0)
   )
  )
  (global.set $std/operator-overloading/x
   (call $std/operator-overloading/Tester.xor
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/x1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/x2)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/x)
       )
      )
      (i32.const 65535)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/x)
        )
       )
       (i32.const 255)
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
     (i32.const 432)
     (i32.const 220)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/eq1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const -2)
   )
  )
  (global.set $std/operator-overloading/eq2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const -2)
   )
  )
  (global.set $std/operator-overloading/eq
   (call $std/operator-overloading/Tester.equals
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/eq1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/eq2)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/eq)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 226)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/eq3
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const 0)
   )
  )
  (global.set $std/operator-overloading/eq4
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 0)
    (i32.const 1)
   )
  )
  (global.set $std/operator-overloading/eqf
   (call $std/operator-overloading/Tester.equals
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/eq3)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/eq4)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/eqf)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 232)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/eq
   (call $std/operator-overloading/Tester.notEquals
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/eq1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/eq2)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/eq)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 236)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/eqf
   (call $std/operator-overloading/Tester.notEquals
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/eq3)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/eq4)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/eqf)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 240)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/gt1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 2)
    (global.get $~lib/builtins/i32.MAX_VALUE)
   )
  )
  (global.set $std/operator-overloading/gt2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const 0)
   )
  )
  (global.set $std/operator-overloading/gt
   (call $std/operator-overloading/Tester.greater
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/gt1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/gt2)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/gt)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 246)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/gte1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 2)
    (i32.const 2)
   )
  )
  (global.set $std/operator-overloading/gte2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 2)
    (i32.const 2)
   )
  )
  (global.set $std/operator-overloading/gte
   (call $std/operator-overloading/Tester.greaterEquals
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/gte1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/gte2)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/gte)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 252)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/le1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 5)
    (i32.const -1)
   )
  )
  (global.set $std/operator-overloading/le2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 6)
    (i32.const 6)
   )
  )
  (global.set $std/operator-overloading/le
   (call $std/operator-overloading/Tester.less
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/le1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/le2)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/le)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 258)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/leq1
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 4)
    (i32.const 3)
   )
  )
  (global.set $std/operator-overloading/leq2
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 4)
    (i32.const 3)
   )
  )
  (global.set $std/operator-overloading/leq
   (call $std/operator-overloading/Tester.lessEquals
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/leq1)
    )
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/leq2)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/leq)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 264)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/shr
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 8)
    (i32.const 16)
   )
  )
  (global.set $std/operator-overloading/sres
   (call $std/operator-overloading/Tester.shr
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/shr)
    )
    (i32.const 3)
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/sres)
       )
      )
      (i32.const 1)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/sres)
        )
       )
       (i32.const 2)
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
     (i32.const 432)
     (i32.const 269)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/shu
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const -8)
    (i32.const -16)
   )
  )
  (global.set $std/operator-overloading/ures
   (call $std/operator-overloading/Tester.shu
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/shu)
    )
    (i32.const 3)
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/ures)
       )
      )
      (i32.const 536870911)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/ures)
        )
       )
       (i32.const 536870910)
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
     (i32.const 432)
     (i32.const 274)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/shl
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const 2)
   )
  )
  (global.set $std/operator-overloading/sres
   (call $std/operator-overloading/Tester.shl
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/shl)
    )
    (i32.const 3)
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/sres)
       )
      )
      (i32.const 8)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/sres)
        )
       )
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
     (i32.const 432)
     (i32.const 279)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/pos
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const -2)
   )
  )
  (global.set $std/operator-overloading/pres
   (call $std/operator-overloading/Tester.pos
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/pos)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/pres)
       )
      )
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/pos)
       )
      )
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/pres)
        )
       )
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/pos)
        )
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
     (i32.const 432)
     (i32.const 284)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/neg
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const -1)
    (i32.const -2)
   )
  )
  (global.set $std/operator-overloading/nres
   (call $std/operator-overloading/Tester.neg
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/neg)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/nres)
       )
      )
      (i32.sub
       (i32.const 0)
       (call $std/operator-overloading/Tester#get:x
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/neg)
        )
       )
      )
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/nres)
        )
       )
       (i32.sub
        (i32.const 0)
        (call $std/operator-overloading/Tester#get:y
         (call $~lib/rt/__tmptostack
          (global.get $std/operator-overloading/neg)
         )
        )
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
     (i32.const 432)
     (i32.const 289)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/not
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 255)
    (i32.const 16)
   )
  )
  (global.set $std/operator-overloading/res
   (call $std/operator-overloading/Tester.not
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/not)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/res)
       )
      )
      (i32.xor
       (call $std/operator-overloading/Tester#get:x
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/not)
        )
       )
       (i32.const -1)
      )
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/res)
        )
       )
       (i32.xor
        (call $std/operator-overloading/Tester#get:y
         (call $~lib/rt/__tmptostack
          (global.get $std/operator-overloading/not)
         )
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
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 294)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/excl
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 0)
    (i32.const 0)
   )
  )
  (global.set $std/operator-overloading/bres
   (call $std/operator-overloading/Tester.excl
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/excl)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/bres)
     (if (result i32)
      (i32.eqz
       (call $std/operator-overloading/Tester#get:x
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/excl)
        )
       )
      )
      (then
       (i32.eqz
        (call $std/operator-overloading/Tester#get:y
         (call $~lib/rt/__tmptostack
          (global.get $std/operator-overloading/excl)
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
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 299)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $std/operator-overloading/bres)
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 300)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/incdec
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 0)
    (i32.const 1)
   )
  )
  (global.set $std/operator-overloading/incdec
   (call $std/operator-overloading/Tester#inc
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/incdec)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/incdec)
       )
      )
      (i32.const 1)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/incdec)
        )
       )
       (i32.const 2)
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
     (i32.const 432)
     (i32.const 306)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/incdec
   (call $std/operator-overloading/Tester#dec
    (call $~lib/rt/__tmptostack
     (global.get $std/operator-overloading/incdec)
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/incdec)
       )
      )
      (i32.const 0)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/incdec)
        )
       )
       (i32.const 1)
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
     (i32.const 432)
     (i32.const 309)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/incdec
   (call $std/operator-overloading/Tester#constructor
    (i32.const 0)
    (i32.const 0)
    (i32.const 1)
   )
  )
  (global.set $std/operator-overloading/tmp
   (block (result i32)
    (global.set $std/operator-overloading/incdec
     (call $std/operator-overloading/Tester#postInc
      (call $~lib/rt/__tmptostack
       (local.tee $0
        (call $~lib/rt/__localtostack
         (global.get $std/operator-overloading/incdec)
        )
       )
      )
     )
    )
    (local.get $0)
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/tmp)
       )
      )
      (i32.const 0)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/tmp)
        )
       )
       (i32.const 1)
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
     (i32.const 432)
     (i32.const 314)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/incdec)
       )
      )
      (i32.const 1)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/incdec)
        )
       )
       (i32.const 2)
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
     (i32.const 432)
     (i32.const 315)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/tmp
   (block (result i32)
    (global.set $std/operator-overloading/incdec
     (call $std/operator-overloading/Tester#postDec
      (call $~lib/rt/__tmptostack
       (local.tee $1
        (call $~lib/rt/__localtostack
         (global.get $std/operator-overloading/incdec)
        )
       )
      )
     )
    )
    (local.get $1)
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/tmp)
       )
      )
      (i32.const 1)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/tmp)
        )
       )
       (i32.const 2)
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
     (i32.const 432)
     (i32.const 318)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/Tester#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/incdec)
       )
      )
      (i32.const 0)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/Tester#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/incdec)
        )
       )
       (i32.const 1)
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
     (i32.const 432)
     (i32.const 319)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/ais1
   (call $std/operator-overloading/TesterInlineStatic#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const 2)
   )
  )
  (global.set $std/operator-overloading/ais1
   (block $std/operator-overloading/TesterInlineStatic.postInc|inlined.0 (result i32)
    (local.set $a
     (call $~lib/rt/__localtostack
      (global.get $std/operator-overloading/ais1)
     )
    )
    (br $std/operator-overloading/TesterInlineStatic.postInc|inlined.0
     (call $std/operator-overloading/TesterInlineStatic#constructor
      (i32.const 0)
      (i32.add
       (call $std/operator-overloading/TesterInlineStatic#get:x
        (call $~lib/rt/__tmptostack
         (local.get $a)
        )
       )
       (i32.const 1)
      )
      (i32.add
       (call $std/operator-overloading/TesterInlineStatic#get:y
        (call $~lib/rt/__tmptostack
         (local.get $a)
        )
       )
       (i32.const 1)
      )
     )
    )
   )
  )
  (global.set $std/operator-overloading/ais2
   (call $std/operator-overloading/TesterInlineStatic#constructor
    (i32.const 0)
    (i32.const 2)
    (i32.const 3)
   )
  )
  (global.set $std/operator-overloading/ais
   (block $std/operator-overloading/TesterInlineStatic.add|inlined.0 (result i32)
    (local.set $a|4
     (call $~lib/rt/__localtostack
      (global.get $std/operator-overloading/ais1)
     )
    )
    (local.set $b
     (call $~lib/rt/__localtostack
      (global.get $std/operator-overloading/ais2)
     )
    )
    (br $std/operator-overloading/TesterInlineStatic.add|inlined.0
     (call $std/operator-overloading/TesterInlineStatic#constructor
      (i32.const 0)
      (i32.add
       (call $std/operator-overloading/TesterInlineStatic#get:x
        (call $~lib/rt/__tmptostack
         (local.get $a|4)
        )
       )
       (call $std/operator-overloading/TesterInlineStatic#get:x
        (call $~lib/rt/__tmptostack
         (local.get $b)
        )
       )
      )
      (i32.add
       (call $std/operator-overloading/TesterInlineStatic#get:y
        (call $~lib/rt/__tmptostack
         (local.get $a|4)
        )
       )
       (call $std/operator-overloading/TesterInlineStatic#get:y
        (call $~lib/rt/__tmptostack
         (local.get $b)
        )
       )
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/TesterInlineStatic#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/ais)
       )
      )
      (i32.const 4)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/TesterInlineStatic#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/ais)
        )
       )
       (i32.const 6)
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
     (i32.const 432)
     (i32.const 343)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/aii1
   (call $std/operator-overloading/TesterInlineInstance#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const 2)
   )
  )
  (global.set $std/operator-overloading/aii1
   (block $std/operator-overloading/TesterInlineInstance#postInc|inlined.0 (result i32)
    (local.set $this
     (call $~lib/rt/__localtostack
      (global.get $std/operator-overloading/aii1)
     )
    )
    (br $std/operator-overloading/TesterInlineInstance#postInc|inlined.0
     (call $std/operator-overloading/TesterInlineInstance#constructor
      (i32.const 0)
      (i32.add
       (call $std/operator-overloading/TesterInlineInstance#get:x
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
       (i32.const 1)
      )
      (i32.add
       (call $std/operator-overloading/TesterInlineInstance#get:y
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
       (i32.const 1)
      )
     )
    )
   )
  )
  (global.set $std/operator-overloading/aii2
   (call $std/operator-overloading/TesterInlineInstance#constructor
    (i32.const 0)
    (i32.const 2)
    (i32.const 3)
   )
  )
  (global.set $std/operator-overloading/aii
   (block $std/operator-overloading/TesterInlineInstance#add|inlined.0 (result i32)
    (local.set $this|7
     (call $~lib/rt/__localtostack
      (global.get $std/operator-overloading/aii1)
     )
    )
    (local.set $b|8
     (call $~lib/rt/__localtostack
      (global.get $std/operator-overloading/aii2)
     )
    )
    (br $std/operator-overloading/TesterInlineInstance#add|inlined.0
     (call $std/operator-overloading/TesterInlineInstance#constructor
      (i32.const 0)
      (i32.add
       (call $std/operator-overloading/TesterInlineInstance#get:x
        (call $~lib/rt/__tmptostack
         (local.get $this|7)
        )
       )
       (call $std/operator-overloading/TesterInlineInstance#get:x
        (call $~lib/rt/__tmptostack
         (local.get $b|8)
        )
       )
      )
      (i32.add
       (call $std/operator-overloading/TesterInlineInstance#get:y
        (call $~lib/rt/__tmptostack
         (local.get $this|7)
        )
       )
       (call $std/operator-overloading/TesterInlineInstance#get:y
        (call $~lib/rt/__tmptostack
         (local.get $b|8)
        )
       )
      )
     )
    )
   )
  )
  (if
   (i32.eqz
    (if (result i32)
     (i32.eq
      (call $std/operator-overloading/TesterInlineInstance#get:x
       (call $~lib/rt/__tmptostack
        (global.get $std/operator-overloading/aii)
       )
      )
      (i32.const 4)
     )
     (then
      (i32.eq
       (call $std/operator-overloading/TesterInlineInstance#get:y
        (call $~lib/rt/__tmptostack
         (global.get $std/operator-overloading/aii)
        )
       )
       (i32.const 6)
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
     (i32.const 432)
     (i32.const 367)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (global.set $std/operator-overloading/tea
   (call $std/operator-overloading/TesterElementAccess#constructor
    (i32.const 0)
    (i32.const 1)
    (i32.const 2)
   )
  )
  (call $std/operator-overloading/TesterElementAccess#__set
   (call $~lib/rt/__tmptostack
    (global.get $std/operator-overloading/tea)
   )
   (i32.const 512)
   (i32.const -1)
  )
  (call $std/operator-overloading/TesterElementAccess#__set
   (call $~lib/rt/__tmptostack
    (global.get $std/operator-overloading/tea)
   )
   (i32.const 544)
   (i32.const -2)
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/operator-overloading/TesterElementAccess#get:x
      (call $~lib/rt/__tmptostack
       (global.get $std/operator-overloading/tea)
      )
     )
     (i32.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 393)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/operator-overloading/TesterElementAccess#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/operator-overloading/tea)
      )
      (i32.const 512)
     )
     (i32.const -1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 394)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/operator-overloading/TesterElementAccess#get:y
      (call $~lib/rt/__tmptostack
       (global.get $std/operator-overloading/tea)
      )
     )
     (i32.const -2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 396)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/operator-overloading/TesterElementAccess#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/operator-overloading/tea)
      )
      (i32.const 544)
     )
     (i32.const -2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 397)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (call $std/operator-overloading/TesterElementAccess#__set
   (call $~lib/rt/__tmptostack
    (global.get $std/operator-overloading/tea)
   )
   (i32.const 512)
   (i32.add
    (call $std/operator-overloading/TesterElementAccess#__get
     (call $~lib/rt/__tmptostack
      (global.get $std/operator-overloading/tea)
     )
     (i32.const 512)
    )
    (i32.const 1)
   )
  )
  (call $std/operator-overloading/TesterElementAccess#__set
   (call $~lib/rt/__tmptostack
    (global.get $std/operator-overloading/tea)
   )
   (i32.const 544)
   (i32.sub
    (call $std/operator-overloading/TesterElementAccess#__get
     (call $~lib/rt/__tmptostack
      (global.get $std/operator-overloading/tea)
     )
     (i32.const 544)
    )
    (i32.const 1)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/operator-overloading/TesterElementAccess#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/operator-overloading/tea)
      )
      (i32.const 512)
     )
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 402)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $std/operator-overloading/TesterElementAccess#__get
      (call $~lib/rt/__tmptostack
       (global.get $std/operator-overloading/tea)
      )
      (i32.const 544)
     )
     (i32.const -3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 432)
     (i32.const 403)
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
    (global.get $std/operator-overloading/a1)
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
    (global.get $std/operator-overloading/a2)
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
    (global.get $std/operator-overloading/a)
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
    (global.get $std/operator-overloading/s1)
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
    (global.get $std/operator-overloading/s2)
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
    (global.get $std/operator-overloading/s)
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
    (global.get $std/operator-overloading/m1)
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
    (global.get $std/operator-overloading/m2)
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
    (global.get $std/operator-overloading/m)
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
    (global.get $std/operator-overloading/d1)
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
    (global.get $std/operator-overloading/d2)
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
    (global.get $std/operator-overloading/d)
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
    (global.get $std/operator-overloading/f1)
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
    (global.get $std/operator-overloading/f2)
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
    (global.get $std/operator-overloading/f)
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
    (global.get $std/operator-overloading/p1)
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
    (global.get $std/operator-overloading/p2)
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
    (global.get $std/operator-overloading/p)
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
    (global.get $std/operator-overloading/n1)
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
    (global.get $std/operator-overloading/n2)
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
    (global.get $std/operator-overloading/n)
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
    (global.get $std/operator-overloading/o1)
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
    (global.get $std/operator-overloading/o2)
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
    (global.get $std/operator-overloading/o)
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
    (global.get $std/operator-overloading/x1)
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
    (global.get $std/operator-overloading/x2)
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
    (global.get $std/operator-overloading/x)
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
    (global.get $std/operator-overloading/eq1)
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
    (global.get $std/operator-overloading/eq2)
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
    (global.get $std/operator-overloading/eq3)
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
    (global.get $std/operator-overloading/eq4)
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
    (global.get $std/operator-overloading/gt1)
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
    (global.get $std/operator-overloading/gt2)
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
    (global.get $std/operator-overloading/gte1)
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
    (global.get $std/operator-overloading/gte2)
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
    (global.get $std/operator-overloading/le1)
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
    (global.get $std/operator-overloading/le2)
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
    (global.get $std/operator-overloading/leq1)
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
    (global.get $std/operator-overloading/leq2)
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
    (global.get $std/operator-overloading/shr)
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
    (global.get $std/operator-overloading/sres)
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
    (global.get $std/operator-overloading/shu)
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
    (global.get $std/operator-overloading/ures)
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
    (global.get $std/operator-overloading/shl)
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
    (global.get $std/operator-overloading/pos)
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
    (global.get $std/operator-overloading/pres)
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
    (global.get $std/operator-overloading/neg)
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
    (global.get $std/operator-overloading/nres)
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
    (global.get $std/operator-overloading/not)
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
    (global.get $std/operator-overloading/res)
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
    (global.get $std/operator-overloading/excl)
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
    (global.get $std/operator-overloading/incdec)
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
    (global.get $std/operator-overloading/tmp)
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
    (global.get $std/operator-overloading/ais1)
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
    (global.get $std/operator-overloading/ais2)
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
    (global.get $std/operator-overloading/ais)
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
    (global.get $std/operator-overloading/aii1)
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
    (global.get $std/operator-overloading/aii2)
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
    (global.get $std/operator-overloading/aii)
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
    (global.get $std/operator-overloading/tea)
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
   (block $std/operator-overloading/TesterElementAccess
    (block $std/operator-overloading/TesterInlineInstance
     (block $std/operator-overloading/TesterInlineStatic
      (block $std/operator-overloading/Tester
       (block $~lib/arraybuffer/ArrayBufferView
        (block $~lib/string/String
         (block $~lib/arraybuffer/ArrayBuffer
          (block $~lib/object/Object
           (br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $std/operator-overloading/Tester $std/operator-overloading/TesterInlineStatic $std/operator-overloading/TesterInlineInstance $std/operator-overloading/TesterElementAccess $invalid
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
   (return)
  )
  (unreachable)
 )
 (func $~start
  (call $start:std/operator-overloading)
 )
)
