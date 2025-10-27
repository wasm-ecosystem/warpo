export namespace utf8 {

  @unmanaged
  export class ConstStr {
    toString(): string {
      return String.UTF8.decodeUnsafe(this.addr, this.size, true);
    }
    get addr(): usize {
      return changetype<usize>(this);
    }
    get size(): u32 {
      return load<u32>(this.addr - 4);
    }
  }

  // @ts-ignore: decorator
  @builtin
  export declare function build(x: string): ConstStr;
}
