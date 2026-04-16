/** @type {import('jest').Config} */
export default {
  testEnvironment: "node",
  extensionsToTreatAsEsm: [".ts"],
  moduleNameMapper: {
    "^(\\.{1,2}/.*)\\.js$": "$1",
  },
  transform: {
    "^.+\\.ts$": [
      "ts-jest",
      {
        useESM: true,
        tsconfig: {
          module: "nodenext",
          moduleResolution: "nodenext",
          target: "esnext",
          isolatedModules: true,
          rootDir: ".",
          types: ["node", "jest"],
        },
      },
    ],
  },
  testMatch: ["<rootDir>/tests/**/*.test.ts"],
};
