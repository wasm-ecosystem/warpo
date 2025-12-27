import { Map } from "./map";

// @ts-ignore: decorator
@lazy
const stringToId: Map<string, usize> = new Map();

// @ts-ignore: decorator
@lazy
const idToString: Map<usize, string> = new Map();

// @ts-ignore: decorator
@lazy
const idToDesc: Map<usize, string | null> = new Map();

function ensureToMap(id: i32, key: string): symbol {
  stringToId.set(key, id);
  idToString.set(id, key);
  return changetype<symbol>(id);
}


@unmanaged @final
// @ts-ignore: class name
export abstract class symbol {
  toString(): string {
    const id = changetype<usize>(this);
    const str: string | null = idToString.has(id) ? idToString.get(id) : idToDesc.get(id);
    if (str == null) return "Symbol()";
    return `Symbol(${str})`;
  }
}

export function Symbol(description: string | null = null): symbol {
  let id = Symbol.nextId++;
  if (!id) unreachable(); // out of ids
  idToDesc.set(id, description);
  return changetype<symbol>(id);
}

export namespace Symbol {
  // @ts-ignore: decorator
  @lazy
  export let nextId: usize = 2;

  // @ts-ignore: decorator
  @lazy
  export const iterator: symbol = ensureToMap(1, "iterator");

  // @ts-ignore: decorator
  @__warpo_rename_for
  export function __warpo_for(key: string): symbol {
    if (stringToId.has(key)) return changetype<symbol>(stringToId.get(key));
    let id = Symbol.nextId++;
    if (!id) unreachable(); // out of ids
    return ensureToMap(id, key);
  }

  export function keyFor(sym: symbol): string | null {
    return idToString.has(changetype<usize>(sym)) ? idToString.get(changetype<usize>(sym)) : null;
  }
}
