export declare function splitCommand(cmdline: string): {
    cmd: string;
    argv: string[];
};
export declare function findRoot(filePaths: string[]): string;
export declare function getIncludeFiles(includePatterns: string[], filter: (path: string) => boolean): string[];
//# sourceMappingURL=pathResolver.d.ts.map