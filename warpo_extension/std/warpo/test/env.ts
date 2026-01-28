// Copyright (C) 2025 wasm-ecosystem
// SPDX-License-Identifier: Apache-2.0

export namespace assertResult {
  // @ts-ignore: decorators
  @external("__unittest_framework_env","addDescription")
  export declare function addDescription(description: string): void;

  // @ts-ignore: decorators
  @external("__unittest_framework_env","removeDescription")
  export declare function removeDescription(): void;

  // @ts-ignore: decorators
  @external("__unittest_framework_env","registerTestFunction")
  export declare function registerTestFunction(index: u32): void;

  // @ts-ignore: decorators
  @external("__unittest_framework_env","registerBeforeEachFunction")
  export declare function registerBeforeEachFunction(index: u32): boolean;

  // @ts-ignore: decorators
  @external("__unittest_framework_env","registerAfterEachFunction")
  export declare function registerAfterEachFunction(index: u32): boolean;

  // @ts-ignore: decorators
  @external("__unittest_framework_env","collectCheckResult")
  export declare function collectCheckResult(
    result: bool,
    codeInfoIndex: number,
    actualValue: string,
    expectValue: string
  ): void;
}
