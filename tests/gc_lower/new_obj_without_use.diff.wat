;; ====================
(func $tests/gc_lower/new_obj_without_use/_start (type $func.0 (func))
  (local i32)
;; =========add========
  block ;;none
      i32.const 4
    call $~lib/rt/__decrease_sp
;; ====================
          i32.const 0
        call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;  call $~lib/rt/__localtostack
;; =========add========
        i32.const 0
      call $~lib/rt/__tostack
;; ====================
    local.set $0
;; =========add========
      i32.const 4
    call $~lib/rt/__increase_sp
  end
;; ====================
)
