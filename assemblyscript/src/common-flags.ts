// Copyright (C) 2025 Daniel Wirtz / The AssemblyScript Authors
// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

/** Indicates traits of a {@link Node} or {@link Element}. */
export const enum CommonFlags {
  /** No flags set. */
  None = 0,

  // Basic modifiers

  /** Has an `import` modifier. */
  Import = 1 << 0,
  /** Has an `export` modifier. */
  Export = 1 << 1,
  /** Has a `declare` modifier. */
  Declare = 1 << 2,
  /** Has a `const` modifier. */
  Const = 1 << 3,
  /** Has a `let` modifier. */
  Let = 1 << 4,
  /** Has a `static` modifier. */
  Static = 1 << 5,
  /** Has a `readonly` modifier. */
  Readonly = 1 << 6,
  /** Has an `abstract` modifier. */
  Abstract = 1 << 7,
  /** Has a `public` modifier. */
  Public = 1 << 8,
  /** Has a `private` modifier. */
  Private = 1 << 9,
  /** Has a `protected` modifier. */
  Protected = 1 << 10,
  /** Has a `get` modifier. */
  Get = 1 << 11,
  /** Has a `set` modifier. */
  Set = 1 << 12,
  /** Has a `override` modifier.  */
  Override = 1 << 13,

  /** Has a definite assignment assertion `!` as in `x!: i32;`. */
  DefinitelyAssigned = 1 << 14,

  // Extended modifiers usually derived from basic modifiers

  /** Is ambient, that is either declared or nested in a declared element. */
  Ambient = 1 << 15,
  /** Is generic. */
  Generic = 1 << 16,
  /** Is part of a generic context. */
  GenericContext = 1 << 17,
  /** Is an instance member. */
  Instance = 1 << 18,
  /** Is a constructor. */
  Constructor = 1 << 19,
  /** Is a module export. */
  ModuleExport = 1 << 20,
  /** Is a module import. */
  ModuleImport = 1 << 21,

  // Compilation states

  /** Is resolved. */
  Resolved = 1 << 22,
  /** Is compiled. */
  Compiled = 1 << 23,
  /** Did error. */
  Errored = 1 << 24,
  /** Has a constant value and is therefore inlined. */
  Inlined = 1 << 25,
  /** Is scoped. */
  Scoped = 1 << 26,
  /** Is a stub. */
  Stub = 1 << 27,
  /** Is an overridden method. */
  Overridden = 1 << 28,
  /** Is (part of) a closure. */
  Closure = 1 << 29,

  // Other

  /** Is quoted. */
  Quoted = 1 << 30,
  /** Is internally nullable. */
  InternallyNullable = 1 << 31,
}
