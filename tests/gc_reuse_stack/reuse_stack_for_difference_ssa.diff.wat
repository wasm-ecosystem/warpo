;; ====================
(func $tests/gc_reuse_stack/reuse_stack_for_difference_ssa/_start (type $func.0 (func))
  (local i32)
  (local i32)
  block ;;none
;; ======remove=======
;;    i32.const 16
;; =========add========
      i32.const 4
;; ====================
    call $~lib/rt/__decrease_sp
    block ;;none
            i32.const 0
          call $tests/common_lib/normal/Normal#constructor
        call $~lib/rt/__tostack<0>
      local.set $0
          local.get $0
;; ======remove=======
;;      call $~lib/rt/__tostack<4>
;; =========add========
        call $~lib/rt/__tostack<0>
;; ====================
      call $tests/gc_reuse_stack/reuse_stack_for_difference_ssa/foo
            i32.const 0
          call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;      call $~lib/rt/__tostack<8>
;; =========add========
        call $~lib/rt/__tostack<0>
;; ====================
      local.set $1
          local.get $1
;; ======remove=======
;;      call $~lib/rt/__tostack<12>
;; =========add========
        call $~lib/rt/__tostack<0>
;; ====================
      call $tests/gc_reuse_stack/reuse_stack_for_difference_ssa/foo
    end
;; ======remove=======
;;    i32.const 16
;; =========add========
      i32.const 4
;; ====================
    call $~lib/rt/__increase_sp
  end
)
