export default {
  include: ["unittest_debug.ts", "unittest_debug.case.ts", "debugger_import.ts", "debugger_import.case.ts"],
  collectCoverage: false,
  output: "build_coverage",
  imports() {
    return {
      env: {
        debuggerImport: () => 41,
      },
    };
  },
};
