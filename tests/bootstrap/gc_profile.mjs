// Copyright (C) 2026 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

import assert from "node:assert/strict";
import binaryen from "binaryen";

export const metricNames = [
  "peakBytes",
  "reservedBytes",
  "zeroFillBytes",
  "zeroStoreBytes",
  "scanBytes",
  "scanPasses",
  "otherRootReadBytes",
  "lastOtherReader",
  "memoryPages",
  "finalBytes",
];

const childFields = {
  Block: [],
  If: ["Condition", "IfTrue", "IfFalse"],
  Loop: ["Body"],
  Break: ["Condition", "Value"],
  Switch: ["Condition", "Value"],
  Call: [],
  CallIndirect: ["Target"],
  LocalSet: ["Value"],
  GlobalSet: ["Value"],
  Load: ["Ptr"],
  Store: ["Ptr", "Value"],
  Unary: ["Value"],
  Binary: ["Left", "Right"],
  Select: ["Condition", "IfTrue", "IfFalse"],
  Drop: ["Value"],
  Return: ["Value"],
  MemoryGrow: ["Delta"],
  MemoryFill: ["Dest", "Value", "Size"],
  MemoryCopy: ["Dest", "Source", "Size"],
  MemoryInit: ["Dest", "Offset", "Size"],
  Const: [],
  LocalGet: [],
  GlobalGet: [],
  Nop: [],
  Unreachable: [],
  MemorySize: [],
  DataDrop: [],
  TableGet: ["Index"],
  TableSet: ["Index", "Value"],
  TableGrow: ["Value", "Delta"],
  TableSize: [],
  RefFunc: [],
  RefNull: [],
};

export function instrument(m) {
  m.setFeatures(m.getFeatures() | binaryen.Features.MutableGlobals | binaryen.Features.BulkMemoryOpt);
  const globals = Array.from({ length: m.getNumGlobals() }, (_, i) => binaryen.getGlobalInfo(m.getGlobalByIndex(i)));
  const sp = globals.find((g) => g.name === "~lib/memory/__stack_pointer");
  assert.ok(sp, "Expected named, final-optimized shadow stack global");
  const initial = binaryen.getExpressionInfo(sp.init);
  assert.equal(initial.id, binaryen.ConstId, "Expected constant initial stack top");
  assert.equal(initial.type, binaryen.i32);
  const top = initial.value;
  const prefix = "__warpo_gc_profile_";
  assert.ok(!globals.some((g) => g.name.startsWith(prefix)), "Module already instrumented");
  const counters = metricNames.slice(1, 8);
  for (const name of counters) m.addGlobal(prefix + name, binaryen.i64, true, m.i64.const(0, 0));
  m.addGlobal(prefix + "minSP", binaryen.i32, true, m.i32.const(top));
  const i32 = (n) => m.i32.const(n);
  const local = (i, type = binaryen.i32) => m.local.get(i, type);
  const stack = () => m.global.get(sp.name, binaryen.i32);
  const add = (name, value) => m.global.set(prefix + name, m.i64.add(m.global.get(prefix + name, binaryen.i64), value));
  const extend = (value) => m.i64.extend_u(value);
  const active = (ptr, size) => m.i32.and(m.i32.ge_u(ptr(), stack()), m.i32.le_u(m.i32.add(ptr(), size()), i32(top)));
  const helpers = new Map();
  const originals = Array.from({ length: m.getNumFunctions() }, (_, i) =>
    binaryen.getFunctionInfo(m.getFunctionByIndex(i))
  );
  const owners = originals.map((f) => f.name);
  const sites = { stackSets: 0, fills: 0, stores: 0, loads: 0 };
  const ids = new Map(Object.keys(childFields).map((name) => [binaryen[name + "Id"], name]));

  function helper(key, create) {
    if (!helpers.has(key)) helpers.set(key, create(prefix + "helper" + helpers.size));
    return helpers.get(key);
  }

  const setSP = prefix + "setSP";
  function visit(expr, owner) {
    if (!expr) return expr;
    const id = binaryen.getExpressionId(expr);
    const name = ids.get(id);
    assert.ok(name, `Unsupported profiler expression ${id} in ${owners[owner]}`);
    const api = binaryen[name];
    for (const field of childFields[name]) {
      const child = api["get" + field](expr);
      if (child) api["set" + field](expr, visit(child, owner));
    }
    if (name === "Block" || name === "Call" || name === "CallIndirect") {
      const item = name === "Block" ? "Child" : "Operand";
      const count = name === "Block" ? "Children" : "Operands";
      for (let i = 0; i < api["getNum" + count](expr); ++i) {
        api["set" + item + "At"](expr, i, visit(api["get" + item + "At"](expr, i), owner));
      }
    }
    if (!["GlobalSet", "MemoryFill", "Store", "Load"].includes(name)) return expr;
    const info = binaryen.getExpressionInfo(expr);
    if (name === "GlobalSet" && info.name === sp.name) {
      sites.stackSets++;
      binaryen.GlobalSet.setValue(expr, m.call(setSP, [info.value], binaryen.i32));
    } else if (name === "MemoryFill") {
      sites.fills++;
      const target = helper("fill", (fn) => {
        m.addFunction(
          fn,
          binaryen.createType([binaryen.i32, binaryen.i32, binaryen.i32]),
          binaryen.none,
          [],
          m.block(null, [
            m.if(
              m.i32.and(
                active(
                  () => local(0),
                  () => local(2)
                ),
                m.i32.eqz(m.i32.and(local(1), i32(255)))
              ),
              add("zeroFillBytes", extend(local(2)))
            ),
            m.memory.fill(local(0), local(1), local(2)),
          ])
        );
        return fn;
      });
      return m.call(target, [info.dest, info.value, info.size], binaryen.none);
    } else if (name === "Store") {
      assert.equal(info.isAtomic, false);
      assert.ok([binaryen.i32, binaryen.i64, binaryen.f32, binaryen.f64].includes(info.valueType));
      sites.stores++;
      const target = helper(`store/${info.valueType}/${info.bytes}/${info.offset}/${info.align}`, (fn) => {
        const store = m.copyExpression(expr);
        binaryen.Store.setPtr(store, local(0));
        binaryen.Store.setValue(store, local(1, info.valueType));
        const wide = info.valueType === binaryen.i64 || info.valueType === binaryen.f64;
        const integer = wide ? m.i64 : m.i32;
        let bits = local(1, info.valueType);
        if (info.valueType === binaryen.f32 || info.valueType === binaryen.f64) bits = integer.reinterpret(bits);
        if (info.bytes < (wide ? 8 : 4)) {
          const mask = 2 ** (info.bytes * 8) - 1;
          bits = integer.and(bits, wide ? m.i64.const(mask, 0) : i32(mask));
        }
        const zero = integer.eqz(bits);
        m.addFunction(
          fn,
          binaryen.createType([binaryen.i32, info.valueType]),
          binaryen.none,
          [],
          m.block(null, [
            m.if(
              m.i32.and(
                active(
                  () => m.i32.add(local(0), i32(info.offset)),
                  () => i32(info.bytes)
                ),
                zero
              ),
              add("zeroStoreBytes", m.i64.const(info.bytes, 0))
            ),
            store,
          ])
        );
        return fn;
      });
      return m.call(target, [info.ptr, info.value], binaryen.none);
    } else if (name === "Load") {
      assert.equal(info.isAtomic, false);
      sites.loads++;
      const gc = owners[owner].startsWith("~lib/rt/itcms/");
      const target = helper(
        `load/${info.type}/${info.bytes}/${info.offset}/${info.align}/${info.isSigned}/${gc}`,
        (fn) => {
          const load = m.copyExpression(expr);
          binaryen.Load.setPtr(load, local(0));
          const updates = gc
            ? [
                add("scanBytes", m.i64.const(info.bytes, 0)),
                m.if(m.i32.eq(m.i32.add(local(0), i32(info.offset)), stack()), add("scanPasses", m.i64.const(1, 0))),
              ]
            : [
                add("otherRootReadBytes", m.i64.const(info.bytes, 0)),
                m.global.set(prefix + "lastOtherReader", extend(local(1))),
              ];
          m.addFunction(
            fn,
            binaryen.createType([binaryen.i32, binaryen.i32]),
            info.type,
            [],
            m.block(
              null,
              [
                m.if(
                  active(
                    () => m.i32.add(local(0), i32(info.offset)),
                    () => i32(info.bytes)
                  ),
                  m.block(null, updates)
                ),
                load,
              ],
              info.type
            )
          );
          return fn;
        }
      );
      return m.call(target, [info.ptr, i32(owner)], info.type);
    }
    return expr;
  }

  for (let owner = 0; owner < originals.length; ++owner) {
    const f = originals[owner];
    if (f.body) binaryen.Function.setBody(m.getFunction(f.name), visit(f.body, owner));
  }
  m.addFunction(
    setSP,
    binaryen.i32,
    binaryen.i32,
    [],
    m.block(
      null,
      [
        m.if(m.i32.lt_u(local(0), stack()), add("reservedBytes", extend(m.i32.sub(stack(), local(0))))),
        m.if(
          m.i32.lt_u(local(0), m.global.get(prefix + "minSP", binaryen.i32)),
          m.global.set(prefix + "minSP", local(0))
        ),
        local(0),
      ],
      binaryen.i32
    )
  );
  const values = [
    () => extend(m.i32.sub(i32(top), m.global.get(prefix + "minSP", binaryen.i32))),
    ...counters.map((name) => () => m.global.get(prefix + name, binaryen.i64)),
    () => extend(m.memory.size()),
    () => extend(m.i32.sub(i32(top), stack())),
  ];
  m.addFunction(
    "__gc_metric",
    binaryen.i32,
    binaryen.i64,
    [],
    m.block(
      null,
      [...values.map((value, i) => m.if(m.i32.eq(local(0), i32(i)), m.return(value()))), m.unreachable()],
      binaryen.i64
    )
  );
  m.addFunctionExport("__gc_metric", "__gc_metric");
  assert.ok(m.validate(), "Instrumented final module failed validation");
  return { stackTop: top, sites, owners, helpers: helpers.size };
}

export function selfTest() {
  const m = binaryen.parseText(`(module
    (memory (export "memory") 1)
    (global $~lib/memory/__stack_pointer (mut i32) (i32.const 1024))
    (global $calls (mut i32) (i32.const 0))
    (func $ptr (result i32)
      (global.set $calls (i32.add (global.get $calls) (i32.const 1)))
      (global.get $~lib/memory/__stack_pointer))
    (func $~lib/rt/itcms/visitStack
      (drop (i32.load (global.get $~lib/memory/__stack_pointer)))
      (drop (i32.load offset=4 (global.get $~lib/memory/__stack_pointer)))
      (drop (i32.load offset=8 (global.get $~lib/memory/__stack_pointer))))
    (func (export "run")
      (global.set $~lib/memory/__stack_pointer (i32.const 1012))
      (memory.fill (call $ptr) (i32.const 0) (i32.const 12))
      (memory.fill (i32.const 2048) (i32.const 0) (i32.const 32))
      (i32.store (global.get $~lib/memory/__stack_pointer) (i32.const 7))
      (i32.store offset=4 (global.get $~lib/memory/__stack_pointer) (i32.const 0))
      (i64.store offset=4 (global.get $~lib/memory/__stack_pointer) (i64.const 0))
      (i32.store8 offset=8 (global.get $~lib/memory/__stack_pointer) (i32.const 256))
      (f32.store offset=4 (global.get $~lib/memory/__stack_pointer) (f32.const 0))
      (f64.store offset=4 (global.get $~lib/memory/__stack_pointer) (f64.const 0))
      (call $~lib/rt/itcms/visitStack)
      (global.set $~lib/memory/__stack_pointer (i32.const 1024)))
    (global (export "calls") (mut i32) (i32.const 0))
    (func (export "getCalls") (result i32) (global.get $calls))
  )`);
  m.setFeatures(binaryen.Features.All);
  instrument(m);
  const ins = new WebAssembly.Instance(new WebAssembly.Module(m.emitBinary()));
  ins.exports.run();
  assert.equal(ins.exports.getCalls(), 1, "Instrumentation evaluated an operand twice");
  const actual = Object.fromEntries(metricNames.map((name, i) => [name, Number(ins.exports.__gc_metric(i))]));
  assert.deepEqual(actual, {
    peakBytes: 12,
    reservedBytes: 12,
    zeroFillBytes: 12,
    zeroStoreBytes: 25,
    scanBytes: 12,
    scanPasses: 1,
    otherRootReadBytes: 0,
    lastOtherReader: 0,
    memoryPages: 1,
    finalBytes: 0,
  });
  m.dispose();
  return actual;
}
