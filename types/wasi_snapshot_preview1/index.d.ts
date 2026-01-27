/// <reference path="../warpo/index.d.ts" />

declare namespace console {
  function assert<T>(condition: T, message?: string): void;
  function log(message?: string): void;
  function debug(message?: string): void;
  function info(message?: string): void;
  function warn(message?: string): void;
  function error(message?: string): void;
  function time(label?: string): void;
  function timeLog(label?: string): void;
  function timeEnd(label?: string): void;
}

declare namespace crypto {
  function getRandomValues(array: Uint8Array): void;
}

declare namespace Date {
  function now(): i64;
}

declare namespace performance {
  function now(): f64;
}

declare namespace process {
  const argv: string[];
  const env: Map<string, string>;
  let exitCode: i32;

  function exit(code?: i32): void;

  const stdin: ReadableStream;
  const stdout: WritableStream;
  const stderr: WritableStream;

  function time(): i64;
  function hrtime(): u64;
}

declare abstract class Stream {
  close(): void;
}

declare abstract class WritableStream extends Stream {
  write<T>(data: T): void;
}

declare abstract class ReadableStream extends Stream {
  read(buffer: ArrayBuffer, offset?: isize): i32;
}
