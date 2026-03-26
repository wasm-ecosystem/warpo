// A closure capturing 64 i32 variables exceeds the 64-slot tuple limit (1 slot is
// reserved for the parent environment pointer), totalling 260 bytes > 256 bytes.
export function test(): void {
  let v00: i32 = 0;
  let v01: i32 = 0;
  let v02: i32 = 0;
  let v03: i32 = 0;
  let v04: i32 = 0;
  let v05: i32 = 0;
  let v06: i32 = 0;
  let v07: i32 = 0;
  let v08: i32 = 0;
  let v09: i32 = 0;
  let v10: i32 = 0;
  let v11: i32 = 0;
  let v12: i32 = 0;
  let v13: i32 = 0;
  let v14: i32 = 0;
  let v15: i32 = 0;
  let v16: i32 = 0;
  let v17: i32 = 0;
  let v18: i32 = 0;
  let v19: i32 = 0;
  let v20: i32 = 0;
  let v21: i32 = 0;
  let v22: i32 = 0;
  let v23: i32 = 0;
  let v24: i32 = 0;
  let v25: i32 = 0;
  let v26: i32 = 0;
  let v27: i32 = 0;
  let v28: i32 = 0;
  let v29: i32 = 0;
  let v30: i32 = 0;
  let v31: i32 = 0;
  let v32: i32 = 0;
  let v33: i32 = 0;
  let v34: i32 = 0;
  let v35: i32 = 0;
  let v36: i32 = 0;
  let v37: i32 = 0;
  let v38: i32 = 0;
  let v39: i32 = 0;
  let v40: i32 = 0;
  let v41: i32 = 0;
  let v42: i32 = 0;
  let v43: i32 = 0;
  let v44: i32 = 0;
  let v45: i32 = 0;
  let v46: i32 = 0;
  let v47: i32 = 0;
  let v48: i32 = 0;
  let v49: i32 = 0;
  let v50: i32 = 0;
  let v51: i32 = 0;
  let v52: i32 = 0;
  let v53: i32 = 0;
  let v54: i32 = 0;
  let v55: i32 = 0;
  let v56: i32 = 0;
  let v57: i32 = 0;
  let v58: i32 = 0;
  let v59: i32 = 0;
  let v60: i32 = 0;
  let v61: i32 = 0;
  let v62: i32 = 0;
  let v63: i32 = 0;

  function inner(): i32 {
    return (
      v00 +
      v01 +
      v02 +
      v03 +
      v04 +
      v05 +
      v06 +
      v07 +
      v08 +
      v09 +
      v10 +
      v11 +
      v12 +
      v13 +
      v14 +
      v15 +
      v16 +
      v17 +
      v18 +
      v19 +
      v20 +
      v21 +
      v22 +
      v23 +
      v24 +
      v25 +
      v26 +
      v27 +
      v28 +
      v29 +
      v30 +
      v31 +
      v32 +
      v33 +
      v34 +
      v35 +
      v36 +
      v37 +
      v38 +
      v39 +
      v40 +
      v41 +
      v42 +
      v43 +
      v44 +
      v45 +
      v46 +
      v47 +
      v48 +
      v49 +
      v50 +
      v51 +
      v52 +
      v53 +
      v54 +
      v55 +
      v56 +
      v57 +
      v58 +
      v59 +
      v60 +
      v61 +
      v62 +
      v63
    );
  }
  inner();
}
