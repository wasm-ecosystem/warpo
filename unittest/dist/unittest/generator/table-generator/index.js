import chalk from "chalk";
import { basename, dirname } from "node:path";
import { reportConfig } from "../index.js";
import { Rate } from "../../interface.js";
class Table {
    lineWidth = [];
    titles;
    lines = [];
    constructor(titles) {
        this.titles = titles;
        this.lineWidth = titles.map((title) => title.length);
    }
    addItem(items) {
        this.lines.push(items);
        for (let i = 0; i < this.lineWidth.length; i++) {
            this.lineWidth[i] = Math.max(this.lineWidth[i] ?? 0, items[i]?.length ?? 0);
        }
    }
    static padding(str, total) {
        return str + " ".repeat(total - str.length);
    }
    printTitle() {
        return this.titles.map((title, index) => Table.padding(title, this.lineWidth[index] ?? title.length)).join(" | ");
    }
    printSplit() {
        return this.lineWidth.map((width) => "-".repeat(width)).join("-|-");
    }
    printLines() {
        return this.lines.map((line) => line.map((item, index) => Table.padding(item, this.lineWidth[index] ?? item.length)).join(" | "));
    }
}
function render(rate) {
    return rate.getRate().toString();
}
export function genTable(filesInfos) {
    const table = new Table(["File", "% Stmts", "% Branch", "% Funcs", "% Lines"]);
    const map = new Map();
    for (const fileInfo of filesInfos) {
        const { filename } = fileInfo;
        const value = map.get(dirname(filename));
        if (value === undefined) {
            map.set(dirname(filename), [fileInfo]);
        }
        else {
            value.push(fileInfo);
        }
    }
    for (const [folder, infos] of map) {
        table.addItem([
            folder,
            render(Rate.summarize(infos.map((info) => info.statementCoverageRate))),
            render(Rate.summarize(infos.map((info) => info.branchCoverageRate))),
            render(Rate.summarize(infos.map((info) => info.functionCoverageRate))),
            render(Rate.summarize(infos.map((info) => info.lineCoverageRate))),
        ]);
        for (const info of infos) {
            const { filename, statementCoverageRate, branchCoverageRate, functionCoverageRate, lineCoverageRate } = info;
            table.addItem([
                "  " + basename(filename),
                render(statementCoverageRate),
                render(branchCoverageRate),
                render(functionCoverageRate),
                render(lineCoverageRate),
            ]);
        }
    }
    console.log(table.printSplit());
    console.log(table.printTitle());
    console.log(table.printSplit());
    const lines = table
        .printLines()
        .join("\n")
        .replaceAll(/\d+(.\d+)?/g, (str) => {
        const v = Number.parseFloat(str);
        if (v > reportConfig.warningLimit)
            return chalk.bold.greenBright(str);
        if (v > reportConfig.errorLimit)
            return chalk.bold.yellowBright(str);
        return chalk.bold.redBright(str);
    });
    console.log(lines);
    console.log(table.printSplit());
    console.log();
}
//# sourceMappingURL=index.js.map