;; ====================
(func $tests/snapshot_diff/advanced_inlining/large_function_use_once/_start)
;; =========add========
  (local i32)
  (local i32)
  block ;;none
;; ====================
      i32.const 1
;; =========add========
    local.set $0
;; ====================
      i32.const 2
;; ======remove=======
;;call $tests/snapshot_diff/advanced_inlining/large_function_use_once/bigFunc
;; =========add========
    local.set $1
    block ;;none
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
          local.get $0
          local.get $1
        i32.add
      drop
    end
  end
;; ====================
)
