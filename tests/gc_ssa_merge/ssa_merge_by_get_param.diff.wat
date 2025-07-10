;; ====================
(func $tests/gc_ssa_merge/ssa_merge_by_get_param/_start (type $func.0 (func (param i32)))
;; ======remove=======
;;block ;;none
;;    i32.const 4
;;  call $~lib/rt/__decrease_sp
;; ====================
    local.get $0
;; ======remove=======
;;    call $~lib/rt/__tostack<0>
;; ====================
  call $tests/gc_ssa_merge/ssa_merge_by_get_param/foo
;; ======remove=======
;;    i32.const 4
;;  call $~lib/rt/__increase_sp
;;end
;; ====================
)
