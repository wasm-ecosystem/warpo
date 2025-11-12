class Calculator {
  value: i32;

  add(a: i32, b: i32): i32 {
    return a + b + this.value;
  }

  processNullable(input: string | null): i32 {
    if (input === null) {
      return 0;
    }
    return 1;
  }

  getLength(text: string): i32 {
    return text.length;
  }
}

// Global functions
export function multiply(x: i32, y: i32): i32 {
  return x * y;
}

export function processString(input: string | null): i32 {
  if (input === null) {
    return 0;
  }
  return input.length;
}

export function concat(a: string, b: string): string {
  return a + b;
}

export function test(): i32 {
  const calc = new Calculator();
  calc.value = 10;
  const result1 = calc.add(5, 3);
  const result2 = calc.processNullable("test");
  const result3 = calc.getLength("hello");
  const result4 = multiply(4, 7);
  const result5 = processString("world");
  const str = concat("a", "b");
  return result1 + result2 + result3 + result4 + result5 + str.length;
}
