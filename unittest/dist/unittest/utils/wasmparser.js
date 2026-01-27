import { BinaryReader, } from "wasmparser";
import assert from "node:assert";
export function parseImportFunctionInfo(buf) {
    const reader = new BinaryReader();
    const types = [];
    const result = [];
    reader.setData(buf, 0, buf.byteLength);
    while (true) {
        if (!reader.read()) {
            return result;
        }
        switch (reader.state) {
            case 2 /* BinaryReaderState.END_WASM */: {
                break;
            }
            case -1 /* BinaryReaderState.ERROR */: {
                throw reader.error;
            }
            case 4 /* BinaryReaderState.END_SECTION */: {
                break;
            }
            case 3 /* BinaryReaderState.BEGIN_SECTION */: {
                const sectionInfo = reader.result;
                switch (sectionInfo.id) {
                    case 1 /* SectionCode.Type */:
                    case 2 /* SectionCode.Import */: {
                        break;
                    }
                    default: {
                        reader.skipSection();
                        break;
                    }
                }
                break;
            }
            case 11 /* BinaryReaderState.TYPE_SECTION_ENTRY */: {
                const typeEntry = reader.result;
                types.push(typeEntry);
                break;
            }
            case 12 /* BinaryReaderState.IMPORT_SECTION_ENTRY */: {
                const importInfo = reader.result;
                const decoder = new TextDecoder("utf8");
                if (importInfo.kind === 0 /* ExternalKind.Function */) {
                    const typeIdx = importInfo.funcTypeIndex;
                    assert(typeIdx !== undefined, "ImportFunction must have a typeIndex");
                    const typeItem = types[typeIdx];
                    assert(typeItem !== undefined, "ImportFunction must have a typeItem");
                    assert(typeItem.params !== undefined);
                    assert(typeItem.returns !== undefined);
                    const returnValue = typeItem.returns.length === 0 ? undefined : typeItem.returns[0];
                    result.push({
                        module: decoder.decode(importInfo.module),
                        name: decoder.decode(importInfo.field),
                        args: typeItem.params,
                        return: returnValue,
                    });
                }
                break;
            }
            default: {
                break;
            }
        }
    }
}
export function parseSourceMapPath(buf) {
    const reader = new BinaryReader();
    reader.setData(buf, 0, buf.byteLength);
    while (true) {
        if (!reader.read()) {
            return null;
        }
        if (reader.state === 3 /* BinaryReaderState.BEGIN_SECTION */) {
            const sectionInfo = reader.result;
            if (sectionInfo.id !== 0 /* SectionCode.Custom */) {
                reader.skipSection();
            }
        }
        else if (reader.state === 43 /* BinaryReaderState.SOURCE_MAPPING_URL */) {
            const sectionInfo = reader.result;
            return new TextDecoder("utf8").decode(sectionInfo.url);
        }
    }
}
//# sourceMappingURL=wasmparser.js.map