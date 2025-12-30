class MyIterator implements Iterator<string> {
  private index: i32 = 0;
  constructor(private items: string[]) {}
  next(): IteratorResult<string> {
    if (this.index < this.items.length) {
      return IteratorResult.fromValue<string>(this.items[this.index++]);
    } else {
      return IteratorResult.done<string>();
    }
  }
}

class MyIterable implements Iterable<string> {
  private items: string[] = ["a", "b", "c"];
  [Symbol.iterator](): MyIterator {
    return new MyIterator(this.items);
  }
}

export function test1(): void {
  let cnt = 0;
  const myIterable = new MyIterable();
  // for (const value of myIterable) {
  for (
    let it: MyIterator = myIterable[Symbol.iterator](), ret: IteratorResult<string> = it.next();
    !ret.done;
    ret = it.next()
  ) {
    switch (cnt) {
      case 0:
        assert(ret.value == "a");
        break;
      case 1:
        assert(ret.value == "b");
        break;
      case 2:
        assert(ret.value == "c");
        break;
      default:
        assert(false); // should not happen
    }
    cnt++;
  }
}

export function test2(): void {
  let cnt = 0;
  const myIterable = new MyIterable();
  for (const value of myIterable) {
    switch (cnt) {
      case 0:
        assert(value == "a");
        break;
      case 1:
        assert(value == "b");
        break;
      case 2:
        assert(value == "c");
        break;
      default:
        assert(false); // should not happen
    }
    cnt++;
  }
}

test1();

test2();
