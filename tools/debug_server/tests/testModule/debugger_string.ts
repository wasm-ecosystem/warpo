// @ts-nocheck

class StringHolder {
  label: string;

  constructor(label: string) {
    this.label = label;
  }
}

export function _start(): i32 {
  return run();
}

function run(): i32 {
  let message = "hello debugger";
  let holder = new StringHolder("first holder");
  return message.length + holder.label.length;
}
