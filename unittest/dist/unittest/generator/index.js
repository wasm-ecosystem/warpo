import { genHtml } from "./html-generator/index.js";
import { genJson } from "./json-generator/index.js";
import { genTable } from "./table-generator/index.js";
class GeneratorConfig {
    warningLimit = 80;
    errorLimit = 50;
}
export const reportConfig = new GeneratorConfig();
export function generateReport(modes, outputFolder, fileCoverageResult) {
    for (const mode of [modes].flat()) {
        switch (mode) {
            case "html": {
                genHtml(outputFolder, fileCoverageResult);
                break;
            }
            case "json": {
                genJson(outputFolder, fileCoverageResult);
                break;
            }
            case "table": {
                genTable(fileCoverageResult);
                break;
            }
            default: {
                throw new Error("output mode illegal");
            }
        }
    }
}
//# sourceMappingURL=index.js.map