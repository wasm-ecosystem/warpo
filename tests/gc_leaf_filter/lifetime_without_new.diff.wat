;; ====================
(func $tests/gc_leaf_filter/lifetime_without_new/_start (type $func.0 (func (result i32)))
  (local i32)
;; ======remove=======
;;(local i32)
;;block ;;i32
;;    i32.const 4
;;  call $~lib/rt/__decrease_sp
;; ====================
  block ;;unreachable
        i32.const 0
      call $tests/common_lib/normal/Normal#constructor
;; ======remove=======
;;        call $~lib/rt/__tostack<0>
;; ====================
    local.set $0
;; ======remove=======
;;      block ;;unreachable
;; ====================
      local.get $0
;; ======remove=======
;;        local.set $1
;;          i32.const 4
;;        call $~lib/rt/__increase_sp
;;          local.get $1
;; ====================
    return
  end
;; ======remove=======
;;    end
;;  local.tee $1
;;    i32.const 4
;;  call $~lib/rt/__increase_sp
;;  local.get $1
;;end
;; ====================
)
