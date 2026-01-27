export namespace assertResult {

  @external("__unittest_framework_env","addDescription")
  export declare function addDescription(description: string): void;


  @external("__unittest_framework_env","removeDescription")
  export declare function removeDescription(): void;


  @external("__unittest_framework_env","registerTestFunction")
  export declare function registerTestFunction(index: u32): void;


  @external("__unittest_framework_env","registerBeforeEachFunction")
  export declare function registerBeforeEachFunction(index: u32): boolean;


  @external("__unittest_framework_env","registerAfterEachFunction")
  export declare function registerAfterEachFunction(index: u32): boolean;


  @external("__unittest_framework_env","collectCheckResult")
  export declare function collectCheckResult(
    result: bool,
    codeInfoIndex: number,
    actualValue: string,
    expectValue: string,
  ): void;
}
