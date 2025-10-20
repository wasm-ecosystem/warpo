;; ====================
(func $tests/snapshot_diff/gc_lower_opt/base/new_obj_without_use/_start)
  (local i32)
      i32.const 0
    call $tests/snapshot_diff/common_lib/normal/Normal#constructor
;; ======remove=======
;;  call $~lib/rt/__localtostack
;; ====================
  local.set $0
)
