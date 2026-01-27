export default initInstrumenter;

interface Instrumenter {
  allocateUTF8(str: string): number;
  _wasm_instrument(
    fileName: number,
    targetName: number,
    reportFunction: number,
    sourceMap: number,
    expectInfoOutputFilePath: number,
    debugInfoOutputFilePath: number,
    excludes: number,
    skipLib: boolean,
    collectCoverage: boolean
  ): void;
  _free(ptr: number): void;
}

declare function initInstrumenter(initInstrumenter?: {}): Promise<Instrumenter>;
