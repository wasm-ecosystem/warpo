;; ====================
(func $tests/snapshot_diff/gc_lower_opt/ssa_merge/ssa_merge_by_get_param/_start (param i32))
;; ======remove=======
;;(local i32)
;;block ;;none
;;    i32.const 4
;;  call $~lib/rt/__decrease_sp
;;    block ;;i32
;; ====================
    local.get $0
;; ======remove=======
;;      local.set $1
;;        global.get $~lib/memory/__stack_pointer
;;        local.get $1
;;      i32.store $0 align=1
;;      local.get $1
;;    end
;; ====================
  call $tests/snapshot_diff/gc_lower_opt/ssa_merge/ssa_merge_by_get_param/foo
;; ======remove=======
;;    i32.const 4
;;  call $~lib/rt/__increase_sp
;;end
;; ====================
)
