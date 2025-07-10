;; ====================
(func $tests/gc_ssa_merge/ssa_merge_for_cond/_start (type $func.0 (func))
  (local i32)
  block ;;none
;; ======remove=======
;;    i32.const 12
;; =========add========
      i32.const 8
;; ====================
    call $~lib/rt/__decrease_sp
    block ;;none
          i32.const 0
        call $~lib/rt/__tostack<0>
      local.set $0
      if ;;none
        global.get $tests/gc_ssa_merge/ssa_merge_for_cond/g
              i32.const 0
            call $tests/common_lib/normal/Normal#constructor
          call $~lib/rt/__tostack<4>
        local.set $0
      end
        local.get $0
;; ======remove=======
;;      call $~lib/rt/__tostack<8>
;; ====================
      call $tests/gc_ssa_merge/ssa_merge_for_cond/foo
    end
;; ======remove=======
;;    i32.const 12
;; =========add========
      i32.const 8
;; ====================
    call $~lib/rt/__increase_sp
  end
)
