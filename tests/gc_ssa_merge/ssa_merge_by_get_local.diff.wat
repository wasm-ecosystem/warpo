;; ====================
(func $tests/gc_ssa_merge/ssa_merge_by_get_local/_start (type $func.0 (func))
  (local i32)
  block ;;none
;; ======remove=======
;;    i32.const 8
;; =========add========
      i32.const 4
;; ====================
    call $~lib/rt/__decrease_sp
    block ;;none
            i32.const 0
          call $tests/common_lib/normal/Normal#constructor
          i32.const 0
        call $~lib/rt/__tostack
      local.set $0
        local.get $0
;; ======remove=======
;;        i32.const 4
;;      call $~lib/rt/__tostack
;; ====================
      call $tests/gc_ssa_merge/ssa_merge_by_get_local/foo
    end
;; ======remove=======
;;    i32.const 8
;; =========add========
      i32.const 4
;; ====================
    call $~lib/rt/__increase_sp
  end
)
