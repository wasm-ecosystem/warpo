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
          i32.const 0
        call $~lib/rt/__tostack
      local.set $0
          local.get $0
;; ======remove=======
;;        i32.const 4
;; =========add========
          i32.const 0
;; ====================
        call $~lib/rt/__tostack
      call $tests/gc_reuse_stack/reuse_stack_for_difference_ssa/foo
            i32.const 0
          call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;        i32.const 8
;; =========add========
          i32.const 0
;; ====================
        call $~lib/rt/__tostack
      local.set $1
          local.get $1
;; ======remove=======
;;        i32.const 12
;; =========add========
          i32.const 0
;; ====================
        call $~lib/rt/__tostack
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
