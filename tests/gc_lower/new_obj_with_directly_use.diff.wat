;; ====================
(func $tests/gc_lower/new_obj_with_directly_use/_start (type $func.0 (func))
;; =========add========
  block ;;none
      i32.const 4
    call $~lib/rt/__decrease_sp
;; ====================
          i32.const 0
        call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;  call $~lib/rt/__tmptostack
;; =========add========
      call $~lib/rt/__tostack<0>
;; ====================
    call $tests/gc_lower/new_obj_with_directly_use/foo
;; =========add========
      i32.const 4
    call $~lib/rt/__increase_sp
  end
;; ====================
)
