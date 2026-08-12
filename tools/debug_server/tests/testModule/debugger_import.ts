// @ts-nocheck

@external("env", "debuggerImport")
declare function debuggerImport(): i32;

export function importedValue(): i32 {
  const value: i32 = debuggerImport();
  return value + 1;
}
