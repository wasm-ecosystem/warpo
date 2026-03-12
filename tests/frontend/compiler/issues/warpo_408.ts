class Node<T> {
  elements: Array<T>;

  constructor(capacity: i32) {
    this.elements = new Array<T>(capacity);
  }

  pop(): void {
    this.elements[1] = unreachable();
  }
}

export function main(): void {
  const node = new Node<i32>(3);
  node.pop();
}
