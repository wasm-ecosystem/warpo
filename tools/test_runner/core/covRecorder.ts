import { writeFileSync } from "node:fs";

export class CoverageRecorder {
  private _runtimeTrace: Array<[number, number]> = [];

  getCollectionFuncSet(): Record<string, unknown> {
    return {
      traceExpression: (functionIndex: number, basicBlockIndex: number, type: number): void => {
        switch (type) {
          case 1: // call in
          case 2: {
            // call out
            // do not need for now
            break;
          }
          case 0: {
            this._runtimeTrace.push([functionIndex, basicBlockIndex]);
            break;
          }
        }
      },
    };
  }

  outputTrace(traceFile: string) {
    writeFileSync(traceFile, JSON.stringify(this._runtimeTrace));
  }
}
