;; ====================
(func $tests/gc_lower/new_obj_without_use/_start (type $func.0 (func))
  (local i32)
      i32.const 0
    call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;  call $~lib/rt/__localtostack
;; ====================
  local.set $0
)
