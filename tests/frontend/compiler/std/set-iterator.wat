(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32)))
 (type $2 (func (param i32 i32) (result i32)))
 (type $3 (func (param i32)))
 (type $4 (func))
 (type $5 (func (param i32 i32 i32)))
 (type $6 (func (result i32)))
 (type $7 (func (param i32 i32 i32 i32)))
 (type $8 (func (param i32 i32 i32) (result i32)))
 (type $9 (func (param i32 i32 i64) (result i32)))
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
 (global $~lib/shared/runtime/Runtime.Radical i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/rt/itcms/fromSpace (mut i32) (i32.const 0))
 (global $~lib/rt/tlsf/ROOT (mut i32) (i32.const 0))
 (global $~lib/native/ASC_LOW_MEMORY_LIMIT i32 (i32.const 0))
 (global $~lib/native/ASC_RUNTIME i32 (i32.const 2))
 (global $~lib/rt/__rtti_base i32 (i32.const 592))
 (global $~lib/memory/__data_end i32 (i32.const 632))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33400))
 (global $~lib/memory/__heap_base i32 (i32.const 33400))
 (memory $0 1)
 (data $0 (i32.const 12) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e\00\00\00\00\00")
 (data $1 (i32.const 76) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00 \00\00\00~\00l\00i\00b\00/\00r\00t\00/\00i\00t\00c\00m\00s\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 144) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 176) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $4 (i32.const 204) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e\00\00\00\00\00\00\00\00\00")
 (data $5 (i32.const 268) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\14\00\00\00~\00l\00i\00b\00/\00r\00t\00.\00t\00s\00\00\00\00\00\00\00\00\00")
 (data $6 (i32.const 320) "\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $7 (i32.const 348) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 412) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h\00")
 (data $9 (i32.const 460) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00b\00u\00f\00f\00e\00r\00.\00t\00s\00\00\00\00\00\00\00")
 (data $10 (i32.const 524) "<\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00&\00\00\00s\00t\00d\00/\00s\00e\00t\00-\00i\00t\00e\00r\00a\00t\00o\00r\00.\00t\00s\00\00\00\00\00\00\00")
 (data $11 (i32.const 592) "\t\00\00\00 \00\00\00 \00\00\00 \00\00\00\00\00\00\00\08\t\00\00 \00\00\00\00\00\00\00 \00\00\00 \00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "set_iterator_add" (func $std/set-iterator/set_iterator_add))
 (export "set_iterator_del" (func $std/set-iterator/set_iterator_del))
 (export "set_iterator_reassign" (func $std/set-iterator/set_iterator_reassign))
 (export "set_iterator_clear" (func $std/set-iterator/set_iterator_clear))
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
       (i32.const 96)
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
     (i32.const 96)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
       (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 368)
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
       (i32.const 368)
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
       (i32.const 368)
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
     (i32.const 368)
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
     (i32.const 32)
     (i32.const 368)
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
     (i32.const 368)
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
         (i32.const 368)
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
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 368)
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
      (call $~lib/builtins/abort
       (i32.const 0)
       (i32.const 368)
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
     (i32.const 368)
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
 (func $~lib/arraybuffer/ArrayBuffer#constructor (param $this i32) (param $length i32) (result i32)
  (local $buffer i32)
  (if
   (i32.gt_u
    (local.get $length)
    (i32.const 1073741820)
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 432)
     (i32.const 480)
     (i32.const 53)
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
   (i32.eq
    (i32.const 2)
    (global.get $~lib/shared/runtime/Runtime.Stub)
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
     (i32.const 96)
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
 (func $~lib/set/Set<i32>#set:buckets (param $this i32) (param $buckets i32)
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
 (func $~lib/set/Set<i32>#set:bucketsMask (param $this i32) (param $bucketsMask i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $bucketsMask)
  )
 )
 (func $~lib/set/ENTRY_ALIGN<i32> (result i32)
  (return
   (i32.const 3)
  )
 )
 (func $~lib/set/ENTRY_SIZE<i32> (result i32)
  (local $align i32)
  (local $size i32)
  (local.set $align
   (call $~lib/set/ENTRY_ALIGN<i32>)
  )
  (local.set $size
   (i32.and
    (i32.add
     (i32.const 8)
     (local.get $align)
    )
    (i32.xor
     (local.get $align)
     (i32.const -1)
    )
   )
  )
  (return
   (local.get $size)
  )
 )
 (func $~lib/set/Set<i32>#set:entries (param $this i32) (param $entries i32)
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
 (func $~lib/set/Set<i32>#set:entriesCapacity (param $this i32) (param $entriesCapacity i32)
  (i32.store offset=12
   (local.get $this)
   (local.get $entriesCapacity)
  )
 )
 (func $~lib/set/Set<i32>#constructor (param $this i32) (result i32)
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
   (call $~lib/set/Set<i32>#set:buckets
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
   (call $~lib/set/Set<i32>#set:bucketsMask
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (i32.sub
     (i32.const 4)
     (i32.const 1)
    )
   )
   (call $~lib/set/Set<i32>#set:entries
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (call $~lib/rt/__tmptostack
     (call $~lib/arraybuffer/ArrayBuffer#constructor
      (i32.const 0)
      (i32.mul
       (i32.const 4)
       (call $~lib/set/ENTRY_SIZE<i32>)
      )
     )
    )
   )
   (call $~lib/set/Set<i32>#set:entriesCapacity
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (i32.const 4)
   )
  )
  (local.get $this)
 )
 (func $~lib/util/hash/hash32 (param $key i32) (param $len i32) (result i32)
  (local $h i32)
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
     (local.get $key)
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
  (return
   (local.get $h)
  )
 )
 (func $~lib/util/hash/HASH<i32> (param $key i32) (result i32)
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
      (call $~lib/util/hash/hash32
       (local.get $key)
       (i32.const 4)
      )
     )
    )
   )
  )
 )
 (func $~lib/set/Set<i32>#get:buckets (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/set/Set<i32>#get:bucketsMask (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/set/SetEntry<i32>#get:taggedNext (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $~lib/set/SetEntry<i32>#get:key (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/set/Set<i32>#find (param $this i32) (param $key i32) (param $hashCode i32) (result i32)
  (local $entry i32)
  (local $taggedNext i32)
  (local.set $entry
   (i32.load
    (i32.add
     (call $~lib/set/Set<i32>#get:buckets
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (i32.mul
      (i32.and
       (local.get $hashCode)
       (call $~lib/set/Set<i32>#get:bucketsMask
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
       (call $~lib/set/SetEntry<i32>#get:taggedNext
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
          (call $~lib/set/SetEntry<i32>#get:key
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
 (func $~lib/set/Set<i32>#get:entriesOffset (param $this i32) (result i32)
  (i32.load offset=16
   (local.get $this)
  )
 )
 (func $~lib/set/Set<i32>#get:entriesCapacity (param $this i32) (result i32)
  (i32.load offset=12
   (local.get $this)
  )
 )
 (func $~lib/set/Set<i32>#get:entriesCount (param $this i32) (result i32)
  (i32.load offset=20
   (local.get $this)
  )
 )
 (func $~lib/set/Set<i32>#get:entries (param $this i32) (result i32)
  (i32.load offset=8
   (local.get $this)
  )
 )
 (func $~lib/set/SetEntry<i32>#set:key (param $this i32) (param $key i32)
  (i32.store
   (local.get $this)
   (local.get $key)
  )
 )
 (func $~lib/set/SetEntry<i32>#set:taggedNext (param $this i32) (param $taggedNext i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $taggedNext)
  )
 )
 (func $~lib/set/Set<i32>#set:entriesOffset (param $this i32) (param $entriesOffset i32)
  (i32.store offset=16
   (local.get $this)
   (local.get $entriesOffset)
  )
 )
 (func $~lib/set/Set<i32>#rehash (param $this i32) (param $newBucketsMask i32)
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
      (call $~lib/set/ENTRY_SIZE<i32>)
     )
    )
   )
  )
  (local.set $oldPtr
   (call $~lib/set/Set<i32>#get:entries
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (local.set $oldEnd
   (i32.add
    (local.get $oldPtr)
    (i32.mul
     (call $~lib/set/Set<i32>#get:entriesOffset
      (call $~lib/rt/__tmptostack
       (local.get $this)
      )
     )
     (call $~lib/set/ENTRY_SIZE<i32>)
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
         (call $~lib/set/SetEntry<i32>#get:taggedNext
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
         (call $~lib/set/SetEntry<i32>#get:key
          (local.get $oldEntry)
         )
        )
        (call $~lib/set/SetEntry<i32>#set:key
         (local.get $newEntry)
         (local.get $oldEntryKey)
        )
        (local.set $newBucketIndex
         (i32.and
          (call $~lib/util/hash/HASH<i32>
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
        (call $~lib/set/SetEntry<i32>#set:taggedNext
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
          (call $~lib/set/ENTRY_SIZE<i32>)
         )
        )
       )
      )
      (local.set $oldPtr
       (i32.add
        (local.get $oldPtr)
        (call $~lib/set/ENTRY_SIZE<i32>)
       )
      )
      (br $while-continue|0)
     )
    )
   )
  )
  (call $~lib/set/Set<i32>#set:buckets
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $newBuckets)
   )
  )
  (call $~lib/set/Set<i32>#set:bucketsMask
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $newBucketsMask)
  )
  (call $~lib/set/Set<i32>#set:entries
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (local.get $newEntries)
   )
  )
  (call $~lib/set/Set<i32>#set:entriesCapacity
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (local.get $newEntriesCapacity)
  )
  (call $~lib/set/Set<i32>#set:entriesOffset
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/set/Set<i32>#get:entriesCount
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $~lib/set/Set<i32>#set:entriesCount (param $this i32) (param $entriesCount i32)
  (i32.store offset=20
   (local.get $this)
   (local.get $entriesCount)
  )
 )
 (func $~lib/set/Set<i32>#add (param $this i32) (param $key i32) (result i32)
  (local $hashCode i32)
  (local $entry i32)
  (local $4 i32)
  (local $bucketPtrBase i32)
  (local.set $hashCode
   (call $~lib/util/hash/HASH<i32>
    (local.get $key)
   )
  )
  (local.set $entry
   (call $~lib/set/Set<i32>#find
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $key)
    (local.get $hashCode)
   )
  )
  (if
   (i32.eqz
    (local.get $entry)
   )
   (then
    (if
     (i32.eq
      (call $~lib/set/Set<i32>#get:entriesOffset
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (call $~lib/set/Set<i32>#get:entriesCapacity
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
     )
     (then
      (call $~lib/set/Set<i32>#rehash
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
       (if (result i32)
        (i32.lt_s
         (call $~lib/set/Set<i32>#get:entriesCount
          (call $~lib/rt/__tmptostack
           (local.get $this)
          )
         )
         (i32.div_s
          (i32.mul
           (call $~lib/set/Set<i32>#get:entriesCapacity
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
         (call $~lib/set/Set<i32>#get:bucketsMask
          (call $~lib/rt/__tmptostack
           (local.get $this)
          )
         )
        )
        (else
         (i32.or
          (i32.shl
           (call $~lib/set/Set<i32>#get:bucketsMask
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
    (local.set $entry
     (i32.add
      (call $~lib/set/Set<i32>#get:entries
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.mul
       (block (result i32)
        (call $~lib/set/Set<i32>#set:entriesOffset
         (call $~lib/rt/__tmptostack
          (local.get $this)
         )
         (i32.add
          (local.tee $4
           (call $~lib/set/Set<i32>#get:entriesOffset
            (call $~lib/rt/__tmptostack
             (local.get $this)
            )
           )
          )
          (i32.const 1)
         )
        )
        (local.get $4)
       )
       (call $~lib/set/ENTRY_SIZE<i32>)
      )
     )
    )
    (call $~lib/set/SetEntry<i32>#set:key
     (local.get $entry)
     (local.get $key)
    )
    (drop
     (i32.const 0)
    )
    (call $~lib/set/Set<i32>#set:entriesCount
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (i32.add
      (call $~lib/set/Set<i32>#get:entriesCount
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.const 1)
     )
    )
    (local.set $bucketPtrBase
     (i32.add
      (call $~lib/set/Set<i32>#get:buckets
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.mul
       (i32.and
        (local.get $hashCode)
        (call $~lib/set/Set<i32>#get:bucketsMask
         (call $~lib/rt/__tmptostack
          (local.get $this)
         )
        )
       )
       (i32.const 4)
      )
     )
    )
    (call $~lib/set/SetEntry<i32>#set:taggedNext
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
 (func $~lib/set/SetIterator<i32>#set:set (param $this i32) (param $set i32)
  (i32.store offset=4
   (local.get $this)
   (local.get $set)
  )
  (call $~lib/rt/itcms/__link
   (local.get $this)
   (local.get $set)
   (i32.const 0)
  )
 )
 (func $~lib/set/SetIterator<i32>#constructor (param $this i32) (param $set i32) (result i32)
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
   (call $~lib/set/SetIterator<i32>#set:set
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (call $~lib/rt/__tmptostack
     (local.get $set)
    )
   )
  )
  (local.get $this)
 )
 (func $"~lib/set/Set<i32>#[~lib/symbol/Symbol.iterator]" (param $this i32) (result i32)
  (return
   (call $~lib/set/SetIterator<i32>#constructor
    (i32.const 0)
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $~lib/set/SetIterator<i32>#get:set (param $this i32) (result i32)
  (i32.load offset=4
   (local.get $this)
  )
 )
 (func $"~lib/set/Set<i32>#[~lib/set/GET_START]" (param $this i32) (result i32)
  (return
   (call $~lib/set/Set<i32>#get:entries
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $"~lib/set/Set<i32>#[~lib/set/GET_ENTRIES_OFFSET]" (param $this i32) (result i32)
  (return
   (call $~lib/set/Set<i32>#get:entriesOffset
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
 )
 (func $~lib/set/SetIterator<i32>#get:i (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/set/SetIterator<i32>#set:i (param $this i32) (param $i i32)
  (i32.store
   (local.get $this)
   (local.get $i)
  )
 )
 (func $~lib/iterator/IteratorResult<i32>#set:value (param $this i32) (param $value i32)
  (i32.store
   (local.get $this)
   (local.get $value)
  )
 )
 (func $~lib/iterator/IteratorResult<i32>#constructor (param $this i32) (param $value i32) (result i32)
  (block
   (if
    (i32.eqz
     (local.get $this)
    )
    (then
     (local.set $this
      (call $~lib/rt/__localtostack
       (call $~lib/rt/itcms/__new
        (i32.const 4)
        (i32.const 8)
       )
      )
     )
    )
   )
   (call $~lib/iterator/IteratorResult<i32>#set:value
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $value)
   )
  )
  (local.get $this)
 )
 (func $~lib/iterator/IteratorResult.fromValue<i32> (param $value i32) (result i32)
  (return
   (call $~lib/iterator/IteratorResult<i32>#constructor
    (i32.const 0)
    (local.get $value)
   )
  )
 )
 (func $~lib/iterator/IteratorResult.done<i32> (result i32)
  (return
   (i32.const 0)
  )
 )
 (func $~lib/set/SetIterator<i32>#next (param $this i32) (result i32)
  (local $set i32)
  (local $start i32)
  (local $size i32)
  (local $i i32)
  (local $entry i32)
  (local.set $set
   (call $~lib/rt/__localtostack
    (call $~lib/set/SetIterator<i32>#get:set
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
   )
  )
  (local.set $start
   (call $"~lib/set/Set<i32>#[~lib/set/GET_START]"
    (call $~lib/rt/__tmptostack
     (local.get $set)
    )
   )
  )
  (local.set $size
   (call $"~lib/set/Set<i32>#[~lib/set/GET_ENTRIES_OFFSET]"
    (call $~lib/rt/__tmptostack
     (local.get $set)
    )
   )
  )
  (local.set $i
   (call $~lib/set/SetIterator<i32>#get:i
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (loop $for-loop|0
   (if
    (i32.lt_s
     (local.get $i)
     (local.get $size)
    )
    (then
     (local.set $entry
      (i32.add
       (local.get $start)
       (i32.mul
        (local.get $i)
        (call $~lib/set/ENTRY_SIZE<i32>)
       )
      )
     )
     (if
      (i32.eqz
       (i32.and
        (call $~lib/set/SetEntry<i32>#get:taggedNext
         (local.get $entry)
        )
        (i32.const 1)
       )
      )
      (then
       (call $~lib/set/SetIterator<i32>#set:i
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
        (i32.add
         (local.get $i)
         (i32.const 1)
        )
       )
       (return
        (call $~lib/iterator/IteratorResult.fromValue<i32>
         (call $~lib/set/SetEntry<i32>#get:key
          (local.get $entry)
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
  (return
   (call $~lib/iterator/IteratorResult.done<i32>)
  )
 )
 (func $~lib/iterator/IteratorResult<i32>#get:value (param $this i32) (result i32)
  (i32.load
   (local.get $this)
  )
 )
 (func $~lib/iterator/IteratorResult<i32>#get:done (param $this i32) (result i32)
  (return
   (i32.eq
    (i32.const 0)
    (local.get $this)
   )
  )
 )
 (func $std/set-iterator/set_iterator_add
  (local $s i32)
  (local $it i32)
  (local.set $s
   (call $~lib/rt/__localtostack
    (call $~lib/set/Set<i32>#constructor
     (i32.const 0)
    )
   )
  )
  (drop
   (call $~lib/set/Set<i32>#add
    (call $~lib/rt/__tmptostack
     (call $~lib/set/Set<i32>#add
      (call $~lib/rt/__tmptostack
       (call $~lib/set/Set<i32>#add
        (call $~lib/rt/__tmptostack
         (local.get $s)
        )
        (i32.const 1)
       )
      )
      (i32.const 3)
     )
    )
    (i32.const 2)
   )
  )
  (local.set $it
   (call $~lib/rt/__localtostack
    (call $"~lib/set/Set<i32>#[~lib/symbol/Symbol.iterator]"
     (call $~lib/rt/__tmptostack
      (local.get $s)
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/iterator/IteratorResult<i32>#get:value
      (call $~lib/rt/__tmptostack
       (call $~lib/set/SetIterator<i32>#next
        (call $~lib/rt/__tmptostack
         (local.get $it)
        )
       )
      )
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 5)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/iterator/IteratorResult<i32>#get:value
      (call $~lib/rt/__tmptostack
       (call $~lib/set/SetIterator<i32>#next
        (call $~lib/rt/__tmptostack
         (local.get $it)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 6)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (drop
   (call $~lib/set/Set<i32>#add
    (call $~lib/rt/__tmptostack
     (local.get $s)
    )
    (i32.const 4)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/iterator/IteratorResult<i32>#get:value
      (call $~lib/rt/__tmptostack
       (call $~lib/set/SetIterator<i32>#next
        (call $~lib/rt/__tmptostack
         (local.get $it)
        )
       )
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 8)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/iterator/IteratorResult<i32>#get:value
      (call $~lib/rt/__tmptostack
       (call $~lib/set/SetIterator<i32>#next
        (call $~lib/rt/__tmptostack
         (local.get $it)
        )
       )
      )
     )
     (i32.const 4)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 9)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/iterator/IteratorResult<i32>#get:done
     (call $~lib/rt/__tmptostack
      (call $~lib/set/SetIterator<i32>#next
       (call $~lib/rt/__tmptostack
        (local.get $it)
       )
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 10)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $~lib/set/Set<i32>#delete (param $this i32) (param $key i32) (result i32)
  (local $entry i32)
  (local $halfBucketsMask i32)
  (local $4 i32)
  (local $5 i32)
  (local.set $entry
   (call $~lib/set/Set<i32>#find
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
    (local.get $key)
    (call $~lib/util/hash/HASH<i32>
     (local.get $key)
    )
   )
  )
  (if
   (i32.eqz
    (local.get $entry)
   )
   (then
    (return
     (i32.const 0)
    )
   )
  )
  (call $~lib/set/SetEntry<i32>#set:taggedNext
   (local.get $entry)
   (i32.or
    (call $~lib/set/SetEntry<i32>#get:taggedNext
     (local.get $entry)
    )
    (i32.const 1)
   )
  )
  (call $~lib/set/Set<i32>#set:entriesCount
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.sub
    (call $~lib/set/Set<i32>#get:entriesCount
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (local.set $halfBucketsMask
   (i32.shr_u
    (call $~lib/set/Set<i32>#get:bucketsMask
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
    )
    (i32.const 1)
   )
  )
  (if
   (if (result i32)
    (i32.ge_u
     (i32.add
      (local.get $halfBucketsMask)
      (i32.const 1)
     )
     (select
      (local.tee $4
       (i32.const 4)
      )
      (local.tee $5
       (call $~lib/set/Set<i32>#get:entriesCount
        (call $~lib/rt/__tmptostack
         (local.get $this)
        )
       )
      )
      (i32.gt_u
       (local.get $4)
       (local.get $5)
      )
     )
    )
    (then
     (i32.lt_s
      (call $~lib/set/Set<i32>#get:entriesCount
       (call $~lib/rt/__tmptostack
        (local.get $this)
       )
      )
      (i32.div_s
       (i32.mul
        (call $~lib/set/Set<i32>#get:entriesCapacity
         (call $~lib/rt/__tmptostack
          (local.get $this)
         )
        )
        (i32.const 3)
       )
       (i32.const 4)
      )
     )
    )
    (else
     (i32.const 0)
    )
   )
   (then
    (call $~lib/set/Set<i32>#rehash
     (call $~lib/rt/__tmptostack
      (local.get $this)
     )
     (local.get $halfBucketsMask)
    )
   )
  )
  (return
   (i32.const 1)
  )
 )
 (func $std/set-iterator/set_iterator_del
  (local $s i32)
  (local $it i32)
  (local.set $s
   (call $~lib/rt/__localtostack
    (call $~lib/set/Set<i32>#constructor
     (i32.const 0)
    )
   )
  )
  (drop
   (call $~lib/set/Set<i32>#add
    (call $~lib/rt/__tmptostack
     (call $~lib/set/Set<i32>#add
      (call $~lib/rt/__tmptostack
       (call $~lib/set/Set<i32>#add
        (call $~lib/rt/__tmptostack
         (local.get $s)
        )
        (i32.const 1)
       )
      )
      (i32.const 3)
     )
    )
    (i32.const 2)
   )
  )
  (local.set $it
   (call $~lib/rt/__localtostack
    (call $"~lib/set/Set<i32>#[~lib/symbol/Symbol.iterator]"
     (call $~lib/rt/__tmptostack
      (local.get $s)
     )
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/iterator/IteratorResult<i32>#get:value
      (call $~lib/rt/__tmptostack
       (call $~lib/set/SetIterator<i32>#next
        (call $~lib/rt/__tmptostack
         (local.get $it)
        )
       )
      )
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 18)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/iterator/IteratorResult<i32>#get:value
      (call $~lib/rt/__tmptostack
       (call $~lib/set/SetIterator<i32>#next
        (call $~lib/rt/__tmptostack
         (local.get $it)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 19)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (drop
   (call $~lib/set/Set<i32>#delete
    (call $~lib/rt/__tmptostack
     (local.get $s)
    )
    (i32.const 2)
   )
  )
  (if
   (i32.eqz
    (call $~lib/iterator/IteratorResult<i32>#get:done
     (call $~lib/rt/__tmptostack
      (call $~lib/set/SetIterator<i32>#next
       (call $~lib/rt/__tmptostack
        (local.get $it)
       )
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 21)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $std/set-iterator/set_iterator_reassign
  (local $s i32)
  (local $it i32)
  (local.set $s
   (call $~lib/rt/__localtostack
    (call $~lib/set/Set<i32>#constructor
     (i32.const 0)
    )
   )
  )
  (drop
   (call $~lib/set/Set<i32>#add
    (call $~lib/rt/__tmptostack
     (call $~lib/set/Set<i32>#add
      (call $~lib/rt/__tmptostack
       (call $~lib/set/Set<i32>#add
        (call $~lib/rt/__tmptostack
         (local.get $s)
        )
        (i32.const 1)
       )
      )
      (i32.const 3)
     )
    )
    (i32.const 2)
   )
  )
  (local.set $it
   (call $~lib/rt/__localtostack
    (call $"~lib/set/Set<i32>#[~lib/symbol/Symbol.iterator]"
     (call $~lib/rt/__tmptostack
      (local.get $s)
     )
    )
   )
  )
  (local.set $s
   (call $~lib/rt/__localtostack
    (call $~lib/set/Set<i32>#constructor
     (i32.const 0)
    )
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/iterator/IteratorResult<i32>#get:value
      (call $~lib/rt/__tmptostack
       (call $~lib/set/SetIterator<i32>#next
        (call $~lib/rt/__tmptostack
         (local.get $it)
        )
       )
      )
     )
     (i32.const 1)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 30)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/iterator/IteratorResult<i32>#get:value
      (call $~lib/rt/__tmptostack
       (call $~lib/set/SetIterator<i32>#next
        (call $~lib/rt/__tmptostack
         (local.get $it)
        )
       )
      )
     )
     (i32.const 3)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 31)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/iterator/IteratorResult<i32>#get:value
      (call $~lib/rt/__tmptostack
       (call $~lib/set/SetIterator<i32>#next
        (call $~lib/rt/__tmptostack
         (local.get $it)
        )
       )
      )
     )
     (i32.const 2)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 32)
     (i32.const 3)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (call $~lib/iterator/IteratorResult<i32>#get:done
     (call $~lib/rt/__tmptostack
      (call $~lib/set/SetIterator<i32>#next
       (call $~lib/rt/__tmptostack
        (local.get $it)
       )
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 33)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $~lib/set/Set<i32>#clear (param $this i32)
  (call $~lib/set/Set<i32>#set:buckets
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
  (call $~lib/set/Set<i32>#set:bucketsMask
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.sub
    (i32.const 4)
    (i32.const 1)
   )
  )
  (call $~lib/set/Set<i32>#set:entries
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (call $~lib/rt/__tmptostack
    (call $~lib/arraybuffer/ArrayBuffer#constructor
     (i32.const 0)
     (i32.mul
      (i32.const 4)
      (call $~lib/set/ENTRY_SIZE<i32>)
     )
    )
   )
  )
  (call $~lib/set/Set<i32>#set:entriesCapacity
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.const 4)
  )
  (call $~lib/set/Set<i32>#set:entriesOffset
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.const 0)
  )
  (call $~lib/set/Set<i32>#set:entriesCount
   (call $~lib/rt/__tmptostack
    (local.get $this)
   )
   (i32.const 0)
  )
 )
 (func $std/set-iterator/set_iterator_clear
  (local $s i32)
  (local $it i32)
  (local.set $s
   (call $~lib/rt/__localtostack
    (call $~lib/set/Set<i32>#constructor
     (i32.const 0)
    )
   )
  )
  (drop
   (call $~lib/set/Set<i32>#add
    (call $~lib/rt/__tmptostack
     (call $~lib/set/Set<i32>#add
      (call $~lib/rt/__tmptostack
       (call $~lib/set/Set<i32>#add
        (call $~lib/rt/__tmptostack
         (local.get $s)
        )
        (i32.const 1)
       )
      )
      (i32.const 3)
     )
    )
    (i32.const 2)
   )
  )
  (local.set $it
   (call $~lib/rt/__localtostack
    (call $"~lib/set/Set<i32>#[~lib/symbol/Symbol.iterator]"
     (call $~lib/rt/__tmptostack
      (local.get $s)
     )
    )
   )
  )
  (call $~lib/set/Set<i32>#clear
   (call $~lib/rt/__tmptostack
    (local.get $s)
   )
  )
  (if
   (i32.eqz
    (call $~lib/iterator/IteratorResult<i32>#get:done
     (call $~lib/rt/__tmptostack
      (call $~lib/set/SetIterator<i32>#next
       (call $~lib/rt/__tmptostack
        (local.get $it)
       )
      )
     )
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 544)
     (i32.const 42)
     (i32.const 3)
    )
    (unreachable)
   )
  )
 )
 (func $start:std/set-iterator
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
  (call $std/set-iterator/set_iterator_add)
  (call $std/set-iterator/set_iterator_del)
  (call $std/set-iterator/set_iterator_reassign)
  (call $std/set-iterator/set_iterator_clear)
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
 (func $~lib/set/Set<i32>#__visit (param $this i32) (param $cookie i32)
  (local $entries i32)
  (call $~lib/rt/itcms/__visit
   (call $~lib/set/Set<i32>#get:buckets
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
   (local.get $cookie)
  )
  (local.set $entries
   (call $~lib/set/Set<i32>#get:entries
    (call $~lib/rt/__tmptostack
     (local.get $this)
    )
   )
  )
  (drop
   (i32.const 0)
  )
  (call $~lib/rt/itcms/__visit
   (local.get $entries)
   (local.get $cookie)
  )
 )
 (func $~lib/set/Set<i32>~visit (param $0 i32) (param $1 i32)
  (call $~lib/object/Object~visit
   (local.get $0)
   (local.get $1)
  )
  (call $~lib/set/Set<i32>#__visit
   (local.get $0)
   (local.get $1)
  )
 )
 (func $~lib/set/SetIterator<i32>~visit (param $0 i32) (param $1 i32)
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
   (block $~lib/iterator/IteratorResult<i32>
    (block $~lib/iterator/Iterator<i32>
     (block $~lib/set/SetIterator<i32>
      (block $~lib/iterator/Iterable<i32>
       (block $~lib/set/Set<i32>
        (block $~lib/arraybuffer/ArrayBufferView
         (block $~lib/string/String
          (block $~lib/arraybuffer/ArrayBuffer
           (block $~lib/object/Object
            (br_table $~lib/object/Object $~lib/arraybuffer/ArrayBuffer $~lib/string/String $~lib/arraybuffer/ArrayBufferView $~lib/set/Set<i32> $~lib/iterator/Iterable<i32> $~lib/set/SetIterator<i32> $~lib/iterator/Iterator<i32> $~lib/iterator/IteratorResult<i32> $invalid
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
        (call $~lib/set/Set<i32>~visit
         (local.get $0)
         (local.get $1)
        )
        (return)
       )
      )
      (return)
     )
     (block
      (call $~lib/set/SetIterator<i32>~visit
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
  (unreachable)
 )
 (func $~start
  (call $start:std/set-iterator)
 )
)
