(module
  (func $callee-Ii/0 (param i32 i32)
  )
  ;; CHECK-LABEL: Function[1] Body
  (func $caller/1
    (param $arg0 f32)
    (param $arg1 i32)
    i32.const 0x1234
    local.get $arg1
    ;; $arg1 is stored in the first generic reg, which is the reg used by 1st argument in calling convension.
    ;; store $arg1 to stack before load 0x1234 in 1st parameter reg
    ;; then load $arg1 from stack to 2nd parameter reg.

    ;; X86_64:         mov  dword ptr [rsp + [[OFFSET:(0x)?[0-9a-f]+]]], ebp
    ;; X86_64:         mov  edi, ebp
    ;; X86_64:         mov  ebp, 0x1234
    ;; X86_64:         call

    ;; AARCH64:        str  w19, [sp, [[OFFSET:#0x[0-9]+]]]
    ;; AARCH64:        mov  w8, w19
    ;; AARCH64:        mov  w19, #0x1234
    ;; AARCH64:        bl

    ;;
    
    ;; tricore does not have the concept of generic reg and float reg.
    ;; store $arg0 to stack before load 0x1234 as 1st argument reg.
    ;; then do not need to load $arg1 from stack because it is already in 2nd parameter reg.

    ;; TRICORE:        st.w  [sp]#0x10, d8
    ;; TRICORE:        mov  d8, #0x1234
    ;; TRICORE:        fcall

    call $callee-Ii/0
  )

  ;; CHECK-LABEL: Function[2] Body
  (func $callee-fff (param f32 f32 f32)
    
  )

  ;; CHECK-LABEL: Function[3] Body
  (func $caller/fff/0
    (param $arg0 f32)
    (param $arg1 f32)

    ;; X86_64: movd  [[REG:(r[0-9]+d?|[re](ax|cx|dx|bx|bp|si|di))]], xmm5
    ;; X86_64-NEXT: movss xmm5, xmm4
    ;; X86_64-NEXT: movd xmm4, [[REG]]

    ;; AARCH64: fmov  [[REG:w[0-9]+]], s1
    ;; AARCH64-NEXT: fmov  s1, s8
    ;; AARCH64-NEXT: fmov  s8, [[REG]]

    ;; TRICORE: xor [[REG1:d[0-9]+]], [[REG2:d[0-9]+]]
    ;; TRICORE-NEXT: xor [[REG2]], [[REG1]]
    ;; TRICORE-NEXT: xor [[REG1]], [[REG2]]
    local.get $arg1
    local.get $arg0
    f32.const 1
    call $callee-fff
  )

  ;; CHECK-LABEL: Function[4] Body
  (func $caller/fff/1
    (param $arg0 f32)
    (param $arg1 f32)
    (param $arg2 f32)
    f32.const 1

    ;; X86_64: movss xmm6, xmm5
    ;; X86_64-NEXT: movss xmm5, xmm4
    ;; AARCH64: fmov  s2, s1
    ;; AARCH64-NEXT: fmov  s1, s8
    ;; TRICORE: mov  d6, d9
    ;; TRICORE-NEXT: mov  d9, d8
    local.get $arg0
    local.get $arg1
    call $callee-fff
  )


)
