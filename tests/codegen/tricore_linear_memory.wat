(module
  (memory 1 100)
  ;; Test for linear memory store for TriCore backend

  ;; CHECK-LABEL: Function[0] Body
  ;; i32.store
  (func
    i32.const 2
    i32.const 10
    ;; baseAddress is compile-time constant and aligned, will not check alignment at runtime
    ;; TRICORE: st.w  [a2]#2, d[[#]]
    i32.store
  )
  ;; CHECK-LABEL: Function[1] Body
  ;; i64.store
  (func
    i32.const 2
    i64.const 10
    ;; TRICORE: st.d  [a2]#2, e[[#]]
    i64.store
  )

  ;; CHECK-LABEL: Function[2] Body
  ;; i64.store16
  (func
    i32.const 2
    i64.const 10
    ;; TRICORE: st.h  [a2]#2, d[[#]]
    i64.store16
  )

  ;; CHECK-LABEL: Function[3] Body
  ;; i32.store but offset overflow
  (func
    i32.const 0xffffe
    i32.const 10
    ;; 0xffffe not in range int16, should use register caculated addrOffset
    ;; TRICORE: add.a  a15, a2
    ;; TRICORE-NEXT: st.w  [a15]#-4, d[[#]]
    i32.store

  ;; i32.store offset not overflow
    i32.const 0xffe
    i32.const 10
    ;; TRICORE: st.w  [a2]#0xffe, d[[#]]
    i32.store
  )

;; Test for linear memory load for TriCore backend

;; CHECK-LABEL: Function[4] Body
  (func
    ;; compile-time aligned
    i32.const 2
    ;; TRICORE: ld.w  d[[#]], [a2]#2
    i32.load
    drop
  )
;; CHECK-LABEL: Function[5] Body
  (func
    i32.const 2
    ;; TRICORE: ld.d  e[[#]], [a2]#2
    i64.load
    drop
  )
;; CHECK-LABEL: Function[6] Body
  (func
    i32.const 2
    ;; TRICORE: ld.w  d[[#]], [a2]#2
    i64.load32_u
    drop
  )

  ;; CHECK-LABEL: Function[7] Body
  ;; i32.load but offset overflow
  (func
    ;; compile-time aligned
    i32.const 0xffffe
    ;; TRICORE: add.a  a15, a2
    ;; TRICORE-NEXT: ld.w  d[[#]], [a15]#-4
    i32.load
    drop
  )

;; With offset not overflow

  ;; CHECK-LABEL: Function[8] Body
  (func
    i32.const 0x2
    ;; 0x100 + 0x2 = 0x102. Compile-time aligned
    ;; TRICORE: ld.w  d[[#]], [a2]#0x102
    i32.load offset=0x100
    drop
  )
  ;; CHECK-LABEL: Function[9] Body
  (func
    i32.const 0x2
    i32.const 1
    ;; 0x200 + 0x2 = 0x202. Compile-time aligned
    ;; TRICORE: st.w  [a2]#0x202, d[[#]]
    i32.store offset=0x200
  )

;; With offset+base not in_range int16(objSize = 4)
  ;; CHECK-LABEL: Function[10] Body
  (func
    i32.const 0x7ffe
    ;; 0x7ffe + 0x2 = 0x8000. Not in_range int16(max is 0x7fff)
    ;; Use register calculated addrOffset
    ;; TRICORE: add.a  a15, a2
    ;; TRICORE-NEXT: ld.w  d8, [a15]#-4
    i32.load offset=0x2
    drop
  )
;; With offset+base is in_range int16(objSize = 4)
  ;; CHECK-LABEL: Function[11] Body
  (func
    i32.const 0x7ff0
    ;; 0x7ff0 + 0x2 = 0x7ff2. In_range int16(max is 0x7fff)
    ;; TRICORE: ld.w  d[[#]], [a2]#0x7ff2
    i32.load offset=0x2
    drop
  )
)