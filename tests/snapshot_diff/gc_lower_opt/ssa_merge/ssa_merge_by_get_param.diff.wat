;; ====================
(func $tests/snapshot_diff/gc_lower_opt/ssa_merge/ssa_merge_by_get_param/_start (param i32))
;; ======remove=======
;;block ;;none
;;    i32.const 4
;;  call $~lib/rt/__decrease_sp
;;    block ;;i32
;;        global.get $~lib/memory/__stack_pointer
;; ====================
    local.get $0
;; ======remove=======
;;      i32.store $0 align=1
;;      local.get $0
;;    end
;; ====================
  call $tests/snapshot_diff/gc_lower_opt/ssa_merge/ssa_merge_by_get_param/foo
;; ======remove=======
;;    i32.const 4
;;  call $~lib/rt/__increase_sp
;;end
;; ====================
)
