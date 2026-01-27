import { writeFileSync } from "node:fs";
export class CoverageRecorder {
    _runtimeTrace = [];
    getCollectionFuncSet() {
        return {
            traceExpression: (functionIndex, basicBlockIndex, type) => {
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
    outputTrace(traceFile) {
        writeFileSync(traceFile, JSON.stringify(this._runtimeTrace));
    }
}
//# sourceMappingURL=covRecorder.js.map